#using scripts\codescripts\struct;

#using scripts\shared\abilities\gadgets\_gadget_camo;

#using scripts\shared\ai_shared;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\behavior_state_machine;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\archetype_cover_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\blackboard_vehicle;

#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\_burnplayer;
#using scripts\shared\aat_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapons;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;

#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_score;

#insert scripts\shared\archetype_shared\archetype_shared.gsh;
#insert scripts\shared\ai\systems\animation_state_machine.gsh;
#insert scripts\shared\ai\systems\behavior.gsh;
#insert scripts\shared\ai\systems\behavior_state_machine.gsh;
#insert scripts\shared\ai\systems\behavior_tree.gsh;
#insert scripts\shared\ai\systems\blackboard.gsh;
#insert scripts\shared\ai\utility.gsh;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\shared\aat_zm.gsh;

#define PREDATOR_MODEL                          "rex_ai_predator"
#define PREDATOR_CAMO_MODEL                     "rex_ai_predator_camo"
#define PREDATOR_SHIELD_MODEL                   "rex_ai_predator_shield"
#define PREDATOR_LAUNCHER_MODEL                 "rex_ai_predator_launcher"
#define PREDATOR_CAMO_LAUNCHER_MODEL            "rex_ai_predator_launcher_camo"
#define PREDATOR_BLOOD_FX                       "REX/ai/predator/blood_impact"
#define PREDATOR_SHIELD_FX                      "REX/ai/predator/shield_glow"
#define PREDATOR_LAUNCHER_FLASH_FX              "REX/ai/predator/launcher_flash"
#define PREDATOR_EMP_EXPLOSION_FX               "REX/ai/predator/emp_explosion"
#define PREDATOR_SUSPENSE_TRACK                 true
#define PREDATOR_SPECIAL_COOLDOWN_MIN           15
#define PREDATOR_SPECIAL_COOLDOWN_MAX           30
#define PREDATOR_LAUNCHER_INTERVAL              5
#define PREDATOR_SHIELD_INTERVAL                5
#define PREDATOR_EMP_INTERVAL                   7.5
#define PREDATOR_LAUNCHER_VELOCITY              0.175
#define PREDATOR_BARK_MIN                       5
#define PREDATOR_BARK_MAX                       10
#define PREDATOR_HURT_MIN                       3
#define PREDATOR_HURT_MAX                       8
#define PREDATOR_HIDE_MIN                       15 // 60
#define PREDATOR_HIDE_MAX                       25 // 120
#define PREDATOR_LAUNCHER_DAMAGE                15
#define PREDATOR_ATTACK_DAMAGE                  45
#define PREDATOR_EMP_DAMAGE                     80
#define PREDATOR_LAUNCHER_RADIUS                50
#define PREDATOR_ATTACK_RADIUS                  80
#define PREDATOR_CHASE_RADIUS                   500
#define PREDATOR_EMP_RADIUS                     250
#define PREDATOR_PRE_CAMO_HEALTH_REQ            0.75
#define PREDATOR_POST_CAMO_HEALTH_REQ           0.5
#define PREDATOR_KNOCKBACK_STRENGTH			    650
#define PREDATOR_KNOCKBACK_LERP				    30
#define PREDATOR_DEATH_POINTS                   1000
#define PREDATOR_HEALTH                         10000

#define ARCHETYPE_PREDATOR                      "rex_predator"

#define SQUARED(x)                              ( x * x )

#precache( "fx", PREDATOR_BLOOD_FX );
#precache( "fx", PREDATOR_SHIELD_FX );
#precache( "fx", PREDATOR_LAUNCHER_FLASH_FX );
#precache( "fx", PREDATOR_EMP_EXPLOSION_FX );

#precache( "xmodel", PREDATOR_MODEL );
#precache( "xmodel", PREDATOR_CAMO_MODEL );
#precache( "xmodel", PREDATOR_SHIELD_MODEL );
#precache( "xmodel", PREDATOR_LAUNCHER_MODEL );

#using_animtree( "generic" );

#namespace rex_predator_ai;

REGISTER_SYSTEM( "rex_predator", &__init__, undefined )

function __init__()
{
    clientfield::register( "scriptmover", "rex_laser_charge", VERSION_SHIP, 1, "int" );
    clientfield::register( "scriptmover", "rex_laser_beam", 15000, 1, "int" );
    clientfield::register( "toplayer", "rex_emp_pfx", VERSION_SHIP, 1, "int" );

    level.predator_spots = struct::get_array( "predator_popin", "targetname" );
    level.predator_spawner = GetEntArray( "predator_spawner", "script_noteworthy" );
    
    BT_REGISTER_API( "PredatorLocomotionBehaviorCondition",     &PredatorLocomotionBehaviorCondition );
    BT_REGISTER_API( "PredatorTargetService",                   &PredatorTargetService );
    BT_REGISTER_API( "PredatorShouldAttack",                    &PredatorShouldAttack );
    BT_REGISTER_API( "PredatorShouldPopOut",                    &PredatorShouldPopOut );
    BT_REGISTER_API( "PredatorShouldPopIn",                     &PredatorShouldPopIn );
    BT_REGISTER_API( "PredatorShouldToggleCamo",                &PredatorShouldToggleCamo );
    
    spawner::add_archetype_spawn_function( ARCHETYPE_PREDATOR, &PredatorInit );

    level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_PREDATOR, true, true, true );
    level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_PREDATOR, true, true, true );
    level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_PREDATOR, true, true, true );
    level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_PREDATOR, true, true, true );
    level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_PREDATOR, true, true, true );
}

function PredatorInit()
{
    self.launcher = util::spawn_model( PREDATOR_LAUNCHER_MODEL, self GetTagOrigin( "spine1" ), self GetTagAngles( "spine1" ) );
    self.launcher LinkTo( self, "hips" );

    self.launcher SetModel( PREDATOR_CAMO_LAUNCHER_MODEL );
    self SetModel( PREDATOR_CAMO_MODEL );

    self.launcher Ghost();
    self Ghost();
    
    self.flee_spots = struct::get_array( "predator_popout", "targetname" );
    self.health = Int( PREDATOR_HEALTH + ( PREDATOR_HEALTH * ( 0.125 * level.round_number ) ) );
    self.maxhealth = self.health;

    self.predator_move_type = "walk";

    BB_REGISTER_ATTRIBUTE( "_rex_predator_move_type", self.predator_move_type, &PredatorMoveType );

    Blackboard::CreateBlackBoardForEntity( self );

    ai::CreateInterfaceForEntity( self );

    self flag::init( "predator_is_attacking" );

    self AiUtility::RegisterUtilityBlackboardAttributes();

    self SetNearGoalNotifyDist( 32 );
    self SetPhysParams( 24, 0, 72 );
    self PushActors( false );
    self PushPlayer( false );
    self DisableAimAssist();
    
	self.no_gib = 1;
	self.has_legs = 1;
    self.allowpain = 0;
    self.ignoretriggerdamage = false;
    self.ignorebulletdamage = false;
	self.forcemovementscriptstate = false;
    self.ignore_nuke = true;
    self.ignore_enemy_count = true;
    self.ignoreragdoll = false;
    self.skipautoragdoll = false;
    self.ignore_round_robbin_death = true;
    self.b_ignore_cleanup = true;
    self.is_launching = false;
    self.can_attack = false;
    self.is_toggling = false;
    self.is_fleeing = false;
    self.is_hiding = false;
    self.is_barking = false;
    self.popping_in = false;
    self.popping_out = false;
    self.camo_toggled = true;
    self.hide_interval = GetTime();
    self.hurt_interval = GetTime();

    self.special_events = array(
        array( "launch", 100 )
    );
    self thread HandleCorpse( self.launcher );
    self thread HandleSpecialEvents();
    self thread HandlePlayerDamage();
    self thread HandleLauncher();
    self thread HandleGesture();
    self thread HandlePopping();
    self thread HandlePopIn();
    self thread HandleChase();
    self thread HandleClick();
    self thread HandleStep();
    self thread HandleSuspense();
    self thread WatchDeath();
    self thread CheckIsAttacking();

    AiUtility::AddAiOverrideDamageCallback( self, &PredatorDamageCallback );
}

function PredatorDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, offsetTime, boneIndex, modelIndex )
{
    n_damage = damage;
    n_damage = ( ( damage > 1000 ) ? 1000 : damage );

    PlayFX( PREDATOR_BLOOD_FX, point );

    if( GetTime() > self.hurt_interval )
    {
        self PlaySound( "rex_ai_predator_hurt_vox" );
        self.hurt_interval = ( GetTime() + ( RandomFloatRange( PREDATOR_HURT_MIN, PREDATOR_HURT_MAX + 1 ) * 1000 ) );
    }
    return n_damage;
}

function HandleChase()
{
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( ( DistanceSquared( self.favoriteenemy.origin, self.origin ) < SQUARED( PREDATOR_CHASE_RADIUS ) || self.is_fleeing ) && !self.is_launching )
        {
            self.predator_move_type = "run";
            result = self util::waittill_any_timeout( RandomFloatRange( 10, 15 ), "attack_done", "launch_start" );
        }
        else
        {
            if( ( self.health <= ( self.maxhealth * PREDATOR_PRE_CAMO_HEALTH_REQ ) ) && !self.is_launching )
                self.predator_move_type = "run";
            else
                self.predator_move_type = "walk";
        }
    }
}

function PredatorMoveType()
{
    return self.predator_move_type;
}

function CheckIsAttacking()
{
	self endon( "death" );

	for( ;; )
	{
		WAIT_SERVER_FRAME;

        if( self.can_attack )
        {
            self util::waittill_any( "attack_done" );

            self flag::clear( "predator_is_attacking" );
        }
	}
}

function HandleGesture()
{
    self endon( "death" );

    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( ( self.health <= ( self.maxhealth * PREDATOR_PRE_CAMO_HEALTH_REQ ) ) && !self.is_fleeing )
        {
            if( self.camo_toggled )
            {
                self.camo_toggled = false;

                self ToggleCamo();
            }
        }
        else
        {
            if( !self.camo_toggled )
            {
                self.camo_toggled = true;

                self ToggleCamo();
            }
        }
    }
}

function ToggleCamo()
{
    self.is_toggling = true;

    self waittill( "toggle_camo" );
    
    if( ( self.health <= ( self.maxhealth * PREDATOR_PRE_CAMO_HEALTH_REQ ) ) && !self.is_fleeing )
    {
        self PlaySound( "rex_ai_predator_cloak_off" );
        self.launcher SetModel( PREDATOR_LAUNCHER_MODEL );
        self SetModel( PREDATOR_MODEL );
    }
    else
    {
        self PlaySound( "rex_ai_predator_cloak_on" );
        self.launcher SetModel( PREDATOR_CAMO_LAUNCHER_MODEL );
        self SetModel( PREDATOR_CAMO_MODEL );

        if( !IS_EQUAL( self.launcher clientfield::get( "rex_laser_beam" ), 0 ) )
            self.launcher clientfield::set( "rex_laser_beam", 0 );
    }
    
    self waittill( "toggle_done" );

    self.is_toggling = false;
}

function PredatorShouldToggleCamo( entity )
{
    return entity.is_toggling;
}

function WatchDeath()
{
    self waittill( "death", attacker );

    self.launcher clientfield::set( "rex_laser_beam", 0 );

    attacker zm_score::add_to_player_score( PREDATOR_DEATH_POINTS );
}

function HandleCorpse( launcher )
{
    self waittill( "actor_corpse", corpse );

    shield = util::spawn_model( PREDATOR_SHIELD_MODEL, corpse.origin );
    shield.fx = util::spawn_model( "tag_origin", shield.origin );
    shield thread GrowShield();
    
    corpse PlayLoopSound( "rex_ai_predator_emp_ambience", 1 );

    PlayFXOnTag( PREDATOR_SHIELD_FX, shield.fx, "tag_origin" );

    for( j = 0; j < PREDATOR_SHIELD_INTERVAL; j += 0.075 )
    {
        shield [[ ( ( shield IsHidden() || j < 3 ) ? &Show : ( ( !shield IsHidden() ) ? &Hide : &Show ) ) ]]();
        if( j < 2.5 )
            wait( 0.15 );
        else if( j > 2.5 && j < 4 )
            wait( 0.1 );
        else
            wait( 0.075 );
    }
    PlayFX( PREDATOR_EMP_EXPLOSION_FX, self.origin );
    corpse PlaySound( "rex_ai_predator_emp_explosion" );
    corpse StopLoopSound( 1 );

    players = GetPlayers();
    for( i = 0; i < players.size; i++ )
    {
        if( DistanceSquared( players[ i ].origin, corpse.origin ) < SQUARED( PREDATOR_EMP_RADIUS ) )
        {
            players[ i ] DoDamage( PREDATOR_EMP_DAMAGE, players[ i ].origin );
            players[ i ] thread HandleKnockback( corpse );
            players[ i ] thread HandleEMPPFX();
        }
    }
    launcher Delete();
    shield.fx Delete();
    shield Delete();
    corpse Delete();
}

function GrowShield()
{
    scale = 0.01;
    for( ;; )
    {  
        self SetScale( scale );

        wait( 0.015 );

        if( IS_EQUAL( scale, 0.85 ) )
            break;
        scale = ( ( scale < 0.85 ) ? scale + 0.05 : 0.85 );
    }
}

function HandleKnockback( entity )
{
	for( i = 0; i < PREDATOR_KNOCKBACK_LERP; i++ )
	{
		self SetVelocity( VectorNormalize( AnglesToForward( VectortoAngles( entity.origin - self.origin ) ) * -1 ) * PREDATOR_KNOCKBACK_STRENGTH );
			wait( 0.01 );
	}
}

function HandlePlayerDamage()
{
    self endon( "death" );

    for( ;; )
    {
        self waittill( "attack_melee" );

        players = self GetTargetablePlayers();
        for( i = 0; i < players.size; i++ )
        {
            if( DistanceSquared( players[ i ].origin, self.origin ) <= SQUARED( PREDATOR_ATTACK_RADIUS ) )
            {
                players[ i ] DoDamage( PREDATOR_ATTACK_DAMAGE, players[ i ].origin );
                players[ i ] PlaySound( "rex_ai_predator_hit_impact" );
            }
            /*if( players[ i ] laststand::player_is_in_laststand() )
                self PlaySound( "rex_ai_predator_taunt_vox" );*/
        }
    }
}

function HandleEMPPFX()
{
    self clientfield::set_to_player( "rex_emp_pfx", 1 );
    self PlayLoopSound( "rex_ai_predator_emp_loop", 1 );
    
    emp_interval = ( GetTime() + ( PREDATOR_EMP_INTERVAL * 1000 ) );
    while( GetTime() < emp_interval )
    {
        visionset_mgr::activate( "overlay", "zm_trap_electric", self, 1.25, 1.25 );
            wait( 1.25 );
    }
    visionset_mgr::deactivate( "overlay", "zm_trap_electric", self );
    self clientfield::set_to_player( "rex_emp_pfx", 0 );
    self StopLoopSound( 1 );
}

function PredatorLocomotionBehaviorCondition( entity )
{
    if( entity flag::get( "predator_is_attacking" ) )
        return false;
    if( !entity HasPath() )
        return false;
    return true;
}

function PredatorShouldAttack( entity )
{
    if( entity flag::get( "predator_is_attacking" ) )
        return true;
    if( entity.is_hiding )
    {
        entity.can_attack = false;
        return false;
    }
    if( entity.is_fleeing )
    {
        entity.can_attack = false;
        return false;
    }
    if( entity.is_toggling )
    {
        entity.can_attack = false;
        return false;
    }
    if( !isdefined( entity.favoriteenemy ) )
    {
        entity.can_attack = false;
        return false;
    }
    if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > SQUARED( PREDATOR_ATTACK_RADIUS ) )
	{
		entity.can_attack = false;
		return false;
	}
    yawToEnemy = AngleClamp180( entity.angles[ 1 ] - GET_YAW( entity, entity.favoriteenemy.origin ) );
	if( Abs( yawToEnemy ) > 45 )
	{
		entity.can_attack = false;
		return false;
	}
    entity flag::set( "predator_is_attacking" );
    entity.can_attack = true;
    return true;
}

function GetEvent( array )
{
    pool = [];
    for( i = 0; i < array.size; i++ )
        for( j = 0; j < array[ i ][ 1 ]; j++ )
            pool[ pool.size ] = i;
    return array[ array::randomize( pool )[ 0 ] ];
}

function HandleSpecialEvents()
{
	self endon( "death" );

	special_interval = ( GetTime() + ( RandomFloatRange( PREDATOR_SPECIAL_COOLDOWN_MIN, PREDATOR_SPECIAL_COOLDOWN_MAX + 1 ) * 1000 ) );

	for( ;; )
	{
		WAIT_SERVER_FRAME;

        if( ( self.health > ( self.maxhealth * PREDATOR_PRE_CAMO_HEALTH_REQ ) ) || self.is_fleeing )
            special_interval = ( GetTime() + ( RandomFloatRange( PREDATOR_SPECIAL_COOLDOWN_MIN, PREDATOR_SPECIAL_COOLDOWN_MAX + 1 ) * 1000 ) );
		if( GetTime() > special_interval )
		{
			if( !isdefined( self.current_event ) )
			{	
				self.current_event = ( ( !isdefined( self.current_event ) ) ? GetEvent( self.special_events )[ 0 ] : self.current_event );

				special_interval = ( GetTime() + ( RandomFloatRange( PREDATOR_SPECIAL_COOLDOWN_MIN, PREDATOR_SPECIAL_COOLDOWN_MAX + 1 ) * 1000 ) );
			}
		}
	}
}

function HandleLauncher()
{
    self endon( "death" );

    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( IS_EQUAL( self GetTargetablePlayers().size, 0 ) )
            continue;
        if( ( self.health > ( self.maxhealth * PREDATOR_PRE_CAMO_HEALTH_REQ ) ) || self.is_fleeing )
            continue;
        if( self.is_barking )
            continue;
        if( IS_EQUAL( self.current_event, "launch" ) )
        {   
            self.launcher.fx = util::spawn_model( "tag_origin", self.launcher GetTagOrigin( "tag_launcher" ) );
            self.launcher.fx LinkTo( self.launcher, "tag_launcher" );
            self.launcher.fx clientfield::set( "rex_laser_charge", 1 );

            self PlaySound( "rex_ai_predator_beam_start" );
            self PlayLoopSound( "rex_ai_predator_beam_loop", 1.5 );

            wait( 1 );

            self.launcher.fx clientfield::set( "rex_laser_charge", 0 );
            PlayFXOnTag( PREDATOR_LAUNCHER_FLASH_FX, self.launcher.fx, "tag_origin" );

            self.launcher clientfield::set( "rex_laser_beam", 1 );
            self.is_launching = true;

            self notify( "launch_start" );

            node = util::spawn_model( "tag_origin", self.launcher GetTagOrigin( "tag_launcher" ) );

            launcher_interval = ( GetTime() + ( PREDATOR_LAUNCHER_INTERVAL * 1000 ) );
            while( ( GetTime() < launcher_interval ) && !self.is_fleeing )
            {
                node.origin = ( self.favoriteenemy.origin + VectorScale( AnglesToUp( self.favoriteenemy.angles ), 36 ) );

                wait( PREDATOR_LAUNCHER_VELOCITY );

                if( DistanceSquared( self.favoriteenemy.origin, node.origin ) < SQUARED( PREDATOR_LAUNCHER_RADIUS ) )
                {
                    if( self CanSee( self.favoriteenemy ) )
                    {
                        eye_pos = ( self.origin + VectorScale( AnglesToUp( self.angles ), 64 ) );
                        trace = BulletTrace( eye_pos, ( eye_pos + vectorscale( AnglesToForward( self.angles ), 10000 ) ), 1, self );

                        if( !( isdefined( trace[ "entity" ] ) && isdefined( trace[ "entity" ].archetype ) ) )
                        {
                            self.favoriteenemy DoDamage( PREDATOR_LAUNCHER_DAMAGE, self.favoriteenemy.origin );
                            self.favoriteenemy PlaySound( "rex_ai_predator_beam_hit" );
                        }
                    }
                }
            }
            self StopLoopSound( 1.5 );
            self PlaySound( "rex_ai_predator_beam_stop" );
            self.launcher clientfield::set( "rex_laser_beam", 0 );

            self.current_event = undefined;
            self.is_launching = false;
            
            self.launcher.fx Delete();
            node Delete();
        }
    }
}

function HandleClick()
{
    self endon( "death" );
    
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( !isdefined( self.favoriteenemy ) )
            continue;
        if( self.is_launching )
            continue;
        if( self.is_fleeing )
            continue;
        if( self.is_hiding )
            continue;
        evt = self util::waittill_any_timeout( RandomFloatRange( PREDATOR_BARK_MIN, PREDATOR_BARK_MAX + 1 ), "launch_start", "idle_start" );

        if( IS_EQUAL( evt, "timeout" ) )
        {
            self.is_barking = true;

            self PlaySoundWithNotify( "rex_ai_predator_click_vox", "sounddone" );
            self waittill( "sounddone" );

            self.is_barking = false;
        }
    }
}

function HandleStep()
{
    self endon( "death" );

    for( ;; )
    {
        self waittill( "predator_step", tag );
        
        if( ( self.health > ( self.maxhealth * PREDATOR_PRE_CAMO_HEALTH_REQ ) ) || self.is_fleeing )
            continue;
        self PlaySoundOnTag( "rex_ai_predator_step", tag );
    }
}

function HandleSuspense()
{
    self endon( "death" );

    if( PREDATOR_SUSPENSE_TRACK )
    {
        while( 1 )
        {
            WAIT_SERVER_FRAME;

            if( self.is_hiding )
                continue;

            sound = util::spawn_model( "tag_origin", self.origin );
            sound LinkTo( self );
            sound PlayLoopSound( "rex_ai_predator_suspense", 2.5 );

            while( !self.is_fleeing && IsAlive( self ) )
                WAIT_SERVER_FRAME;
            
            sound StopLoopSound( 2.5 );
            sound Delete();
        }
    }
}

function HandlePopping()
{
    self endon( "death" );

    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( self.health <= ( self.maxhealth * PREDATOR_POST_CAMO_HEALTH_REQ ) )
        {
            n_popout = undefined;
            while( !isdefined( n_popout ) )
            {   
                WAIT_SERVER_FRAME;

                r_spot = ArrayGetClosest( self.origin, self.flee_spots );
                zone = zm_zonemgr::get_zone_from_position( ( r_spot.origin + vectorscale( ( 0, 0, 1 ), 64 ) ), 1 );

                if( zm_zonemgr::zone_is_enabled( zone ) )
                    n_popout = r_spot;
            }
            self.v_zombie_custom_goal = n_popout.origin;
            self.is_fleeing = true;

            while( DistanceSquared( self.origin, n_popout.origin  ) > SQUARED( 32 ) )
                WAIT_SERVER_FRAME;

            self ForceTeleport( n_popout.origin, n_popout.angles );

            self.v_zombie_custom_goal = undefined;
            
            self HandlePopOut();

            self.is_fleeing = false;
            self.health = self.maxhealth;
            self.hide_interval = ( GetTime() + ( RandomFloatRange( PREDATOR_HIDE_MIN, PREDATOR_HIDE_MAX + 1 ) * 1000 ) );
            
            while( GetTime() < self.hide_interval )
                WAIT_SERVER_FRAME;

            self HandlePopIn();
        }
    }
}

function HandlePopOut()
{
    self PushPlayer( false );

    self.popping_out = true;
    
    self waittill( "popout_done" );

    self.launcher Ghost();
    self Ghost();

    self.popping_out = false;
    self.is_hiding = true;

    self ForceTeleport( level.predator_spawner[ 0 ].origin, level.predator_spawner[ 0 ].angles );
}

function PredatorShouldPopOut( entity )
{
    return entity.popping_out;
}

function HandlePopIn()
{
    n_popin = undefined;
    while( !isdefined( n_popin ) )
    {   
        WAIT_SERVER_FRAME;

        player = array::random( GetPlayers() );
        r_spot = ArrayGetClosest( player.origin, level.predator_spots );
        zone = zm_zonemgr::get_zone_from_position( ( r_spot.origin + vectorscale( ( 0, 0, 1 ), 64 ) ), 1 );

        if( zm_zonemgr::zone_is_enabled( zone ) )
            n_popin = r_spot;
    }
    self ForceTeleport( n_popin.origin, n_popin.angles );

    self.is_hiding = false;
    self.popping_in = true;

    wait( 0.25 );

    self.launcher SetModel( PREDATOR_CAMO_LAUNCHER_MODEL );
    self SetModel( PREDATOR_CAMO_MODEL );

    self.launcher Show();
    self Show();
    
    self waittill( "popin_done" );

    self.popping_in = false;

    self PushPlayer( true );
}

function PredatorShouldPopIn( entity )
{
    return entity.popping_in;
}

function PredatorTargetService( entity )
{
    if( IS_TRUE( entity.ignoreall ) )
        return false;
    if( entity.is_hiding )
        return false;
    if( entity.is_toggling )
        return false;
    n_player = ArrayGetClosest( entity.origin, entity GetTargetablePlayers() );
    player = ( ( !isdefined( entity.favoriteenemy ) || !IS_EQUAL( entity.favoriteenemy, n_player ) ) ? ( ( !IS_EQUAL( n_player, 0 ) ) ? n_player : undefined ) : entity.favoriteenemy );
    
    if( !isdefined( entity.v_zombie_custom_goal ) )
    {
        entity.favoriteenemy = player;
    
        targetPos = GetClosestPointOnNavMesh( entity.favoriteenemy.origin, 64, 30 );
        if( isdefined( targetPos ) )
        {
            entity SetGoal( targetPos );        
            return true;
        }
        else
        {
            entity SetGoal( entity.origin );
            return false;
        }
    }   
    else
	{
		targetPos = GetClosestPointOnNavMesh( entity.v_zombie_custom_goal, 64, 30 );
		if( isdefined( targetPos ) )
		{
			entity SetGoal( targetPos );
			return true;
		}
		else
		{
			entity SetGoal( entity.origin );
			return false;
		}
    }
}

function GetTargetablePlayers()
{
    a_players = [];
    players = GetPlayers();

    for( i = 0; i < players.size; i++ )
    {
        if( !isdefined( players[ i ] ) )
            continue;
        if( !IsAlive( players[ i ] ) )
            continue;
        if( players[ i ] laststand::player_is_in_laststand() )
            continue;
        if( players[ i ].sessionstate === "spectator" )
            continue;
        if( players[ i ].sessionstate === "intermission" )
            continue;
        if( IS_TRUE( players[ i ].intermission ) )
            continue;
        if( isdefined( players[ i ].is_zombie ) && players[ i ].is_zombie )
            continue;
        if( !IsPointOnNavMesh( players[ i ].origin ) )
            continue;
        if( isdefined( self ) )
            if( !self CanPath( self.origin, players[ i ].origin ) )
                continue;
        a_players[ a_players.size ] = players[ i ];
    }
    return a_players;
}

function spawn_predator( health = undefined, s_location = undefined )
{
    if( !isdefined( s_location ) )
    {
        spot = undefined;
        while( !isdefined( spot ) )
        {   
            WAIT_SERVER_FRAME;

            player = array::random( GetPlayers() );

            r_spot = ArrayGetClosest( player.origin, level.predator_spots );

            zone = zm_zonemgr::get_zone_from_position( ( r_spot.origin + vectorscale( ( 0, 0, 1 ), 64 ) ), 1 );

            if( zm_zonemgr::zone_is_enabled( zone ) )
                spot = r_spot;
        }
    }
	loc = ( ( isdefined( s_location ) ) ? s_location : spot );
	
	entity = zombie_utility::spawn_zombie( level.predator_spawner[ 0 ], "rex_predator", loc );
	entity ForceTeleport( loc.origin, loc.angles );

    if( isdefined( health ) )
    {
        entity.health = health;
        entity.maxhealth = entity.health;
    }
	return entity;
}
