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
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_unitrigger;

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

#define CHUCKY_SPECIAL_COOLDOWN_MIN           15
#define CHUCKY_SPECIAL_COOLDOWN_MAX           30
#define CHUCKY_VOX_MIN                        5
#define CHUCKY_VOX_MAX                        10
#define CHUCKY_HURT_MIN                       5
#define CHUCKY_HURT_MAX                       15
#define CHUCKY_TAUNT_COOLDOWN_MIN             5
#define CHUCKY_TAUNT_COOLDOWN_MAX             15
#define CHUCKY_ATTACK_DAMAGE                  45
#define CHUCKY_ATTACK_RADIUS                  80
#define CHUCKY_ARRIVAL_CHANCE                 15
#define CHUCKY_ARRIVAL_COOLDOWN               30
#define CHUCKY_CHASE_RADIUS                   500
#define CHUCKY_DEATH_POINTS                   500
#define CHUCKY_HEALTH                         10000

#define ARCHETYPE_CHUCKY                      "rex_chucky"

#define SQUARED(x)                              ( x * x )

#using_animtree( "generic" );

#namespace rex_chucky_ai;

REGISTER_SYSTEM( "rex_chucky", &__init__, undefined )

function __init__()
{
    level.chucky_spawner = GetEntArray( "chucky_spawner", "script_noteworthy" );
    
    BT_REGISTER_API( "ChuckyLocomotionBehaviorCondition",     &ChuckyLocomotionBehaviorCondition );
    BT_REGISTER_API( "ChuckyTargetService",                   &ChuckyTargetService );
    BT_REGISTER_API( "ChuckyShouldAttack",                    &ChuckyShouldAttack );
    BT_REGISTER_API( "ChuckyShouldPower",                     &ChuckyShouldPower );
    BT_REGISTER_API( "ChuckyShouldClimbIn",                   &ChuckyShouldClimbIn );
    BT_REGISTER_API( "ChuckyShouldClimbOut",                  &ChuckyShouldClimbOut );

    spawner::add_archetype_spawn_function( ARCHETYPE_CHUCKY, &ChuckyInit );

    level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_CHUCKY, true, true, true );
    level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_CHUCKY, true, true, true );
    level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_CHUCKY, true, true, true );
    level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_CHUCKY, true, true, true );
    level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_CHUCKY, true, true, true );

    level waittill( "initial_blackscreen_passed" );

    array::thread_all( level.chests, &HandleSpawning );
}

function ChuckyInit()
{
    self.health = CHUCKY_HEALTH;
    self.maxhealth = self.health;

    self.chucky_move_type = "walk";
    self.chucky_attack_type = "attack";
    BB_REGISTER_ATTRIBUTE( "_rex_chucky_move_type", self.chucky_move_type, &ChuckyMoveType );
    BB_REGISTER_ATTRIBUTE( "_rex_chucky_attack_type", self.chucky_attack_type, &ChuckyAttackType );

    Blackboard::CreateBlackBoardForEntity( self );

    ai::CreateInterfaceForEntity( self );

    self flag::init( "chucky_is_attacking" );

    self AiUtility::RegisterUtilityBlackboardAttributes();

    self SetPhysParams( 16, 0, 24 );
    self PushActors( false );
    self PushPlayer( false );

	self.no_gib = true;
	self.has_legs = true;
    self.allowpain = false;
    self.ignoretriggerdamage = false;
    self.ignorebulletdamage = false;
	self.forcemovementscriptstate = false;
    self.ignore_nuke = true;
    self.ignore_enemy_count = true;
    self.ignoreragdoll = false;
    self.skipautoragdoll = false;
    self.ignore_round_robbin_death = true;
    self.b_ignore_cleanup = true;
    self.climbing_in = false;
    self.climbing_out = false;
    self.playing_vox = false;
    self.is_powered = false;
    self.is_returning = false;
    self.total_damage = 0;
    self.taunt_interval = GetTime();
    self.hurt_interval = GetTime();
    self.special_events = array(
        array( &HandlePower, 100 )
    );

    //self thread HandleSpecialEvents();
    self thread HandlePlayerDamage();
    self thread HandleClimbIn();
    self thread HandleChase();
    self thread HandleStep();
    self thread HandleVOX();
    self thread CheckIsAttacking();

    AiUtility::AddAiOverrideDamageCallback( self, &ChuckyDamageCallback );
}

function HandleSpawning()
{
    loc = util::spawn_model( "tag_origin", ( self.origin + VectorScale( ( AnglesToRight( self.angles ) * -1 ), 24 ) ), ( self.angles + VectorScale( AnglesToRight( self.angles ), 90 ) ) );
    self.chucky_cooldown = GetTime();

    for( ;; )
    {
        WAIT_SERVER_FRAME;

        chance = RandomInt( 100 );

        while( IS_EQUAL( self.zbarrier zm_magicbox::get_magic_box_zbarrier_state(), "open" ) )
        {
            wait( 0.5 );

            ents = GetAIArchetypeArray( "rex_chucky" );

            IPrintLnBold( ents.size );
            
            if( !IS_EQUAL( ents.size, 1 ) && ( chance < CHUCKY_ARRIVAL_CHANCE ) && ( GetTime() > self.chucky_cooldown ) )
            {
                entity = zombie_utility::spawn_zombie( level.chucky_spawner[ 0 ], "rex_chucky", loc );

                entity ForceTeleport( loc.origin, loc.angles );

                entity.climbing_out = true;
                entity waittill( "climbing_done" );
                entity.climbing_out = false;

                self.chucky_cooldown = ( GetTime() + CHUCKY_ARRIVAL_COOLDOWN * 1000 );
            }
        }
    }
}

function ChuckyDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, offsetTime, boneIndex, modelIndex )
{
    n_damage = damage;
    n_damage = ( ( n_damage > 1000 ) ? 1000 : n_damage );

    self.health = self.maxhealth;
    self.total_damage += n_damage;

    if( self.total_damage > self.maxhealth )
        self.total_damage = self.maxhealth;
    if( IS_EQUAL( self.total_damage, self.maxhealth ) )
        if( !self.is_returning )
            self.is_returning = true;
    if( GetTime() > self.hurt_interval )
    {
        self PlaySound( "rex_ai_chucky_hurt_vox" );
        self.hurt_interval = ( GetTime() + ( RandomFloatRange( CHUCKY_HURT_MIN, CHUCKY_HURT_MAX + 1 ) * 1000 ) );
    }
    return 0;
}

function HandleClimbIn()
{
    while( !self.is_returning )
        WAIT_SERVER_FRAME;

    chest = level.chests[ level.chest_index ];
    self.v_zombie_custom_goal = ( chest.origin + VectorScale( ( AnglesToRight( chest.angles ) * -1 ), 24 ) );
        
    while( DistanceSquared( self.origin, self.v_zombie_custom_goal ) > SQUARED( 36 ) )
        WAIT_SERVER_FRAME;

    if( !IS_EQUAL( chest.zbarrier zm_magicbox::get_magic_box_zbarrier_state(), "open" ) )
    {
        chest thread HandleChest( self );
        wait( 0.25 );
    }
    self ForceTeleport( ( chest.origin + VectorScale( ( AnglesToRight( chest.angles ) * -1 ), 24 ) ), ( chest.angles + VectorScale( AnglesToRight( chest.angles ), -90 ) ) );
        
    self.climbing_in = true;
    self waittill( "climbing_done" );
    self.climbing_in = false;

    self.v_zombie_custom_goal = undefined;

    chest.chucky_cooldown = ( GetTime() + ( CHUCKY_ARRIVAL_COOLDOWN * 1000 ) );

    self notify( "death" );
    self Ghost();
    self Kill();
    self Delete();
}

function ChuckyShouldClimbIn( entity )
{
    return entity.climbing_in;
}

function ChuckyShouldClimbOut( entity )
{
    return entity.climbing_out;
}

function HandleChest( entity )
{
    self.zbarrier clientfield::set( "magicbox_rarity_glow", 1 );
    self.zbarrier clientfield::set( "magicbox_closed_glow", 0 );

    self.zbarrier zm_magicbox::set_magic_box_zbarrier_state( "open" );
    zm_unitrigger::unregister_unitrigger( self.unitrigger_stub );
    
    entity waittill( "climbing_done" );

    self.zbarrier clientfield::set( "magicbox_rarity_glow", 0 );
    self.zbarrier clientfield::set( "magicbox_closed_glow", 1 );

    self.zbarrier zm_magicbox::set_magic_box_zbarrier_state( "close" );
    self.unitrigger_stub = SpawnStruct();
    self.unitrigger_stub.origin = self.origin + ( AnglesToRight( self.angles ) * -22.5 );
    self.unitrigger_stub.angles = self.angles;
    self.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    self.unitrigger_stub.script_width = 104;
    self.unitrigger_stub.script_height = 50;
    self.unitrigger_stub.script_length = 45;
    self.unitrigger_stub.trigger_target = self;
    self.unitrigger_stub.prompt_and_visibility_func = &zm_magicbox::boxtrigger_update_prompt;
    zm_unitrigger::unitrigger_force_per_player_triggers( self.unitrigger_stub, true );
    zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think );
}

function HandleChase()
{
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( DistanceSquared( self.favoriteenemy.origin, self.origin ) < SQUARED( CHUCKY_CHASE_RADIUS ) )
        {
            self.chucky_move_type = "run";
            result = self util::waittill_any_timeout( RandomFloatRange( 10, 15 ), "attack_done" );
        }
        self.chucky_move_type = "walk";
    }
}

function ChuckyMoveType()
{
    return self.chucky_move_type;
}

function CheckIsAttacking()
{
	self endon( "death" );

	for( ;; )
	{
        WAIT_SERVER_FRAME;

        if( self flag::get( "chucky_is_attacking" ) )
        {
            self waittill( "attack_done" );

            self flag::clear( "chucky_is_attacking" );

            self.chucky_attack_type = ( ( GetTime() > self.taunt_interval ) ? "taunt" : "attack" );
            if( GetTime() > self.taunt_interval )
            {
                self.taunt_interval = ( GetTime() + ( RandomFloatRange( CHUCKY_TAUNT_COOLDOWN_MIN, CHUCKY_TAUNT_COOLDOWN_MAX ) * 1000 ) );
            }
        }
	}
}

function ChuckyAttackType()
{
    return self.chucky_attack_type;
}

function HandlePlayerDamage()
{
    self endon( "death" );

    for( ;; )
    {
        self waittill( "attack_melee" );

        if( DistanceSquared( self.favoriteenemy.origin, self.origin ) <= SQUARED( CHUCKY_ATTACK_RADIUS ) )
            self.favoriteenemy DoDamage( CHUCKY_ATTACK_DAMAGE, self.favoriteenemy.origin );

        if( self.favoriteenemy laststand::player_is_in_laststand() )
            self PlaySound( "rex_ai_chucky_taunt_vox" );
    }
}

function ChuckyLocomotionBehaviorCondition( entity )
{
    if( entity flag::get( "chucky_is_attacking" ) )
        return false;
    if( !entity HasPath() )
        return false;
    return true;
}

function ChuckyShouldAttack( entity )
{
    if( entity flag::get( "chucky_is_attacking" ) )
        return true;
    if( !isdefined( entity.favoriteenemy ) )
        return false;
    if( isdefined( entity.v_zombie_custom_goal ) )
        return false;
    if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > SQUARED( CHUCKY_ATTACK_RADIUS ) )
        return false;
    yawToEnemy = AngleClamp180( entity.angles[ 1 ] - GET_YAW( entity, entity.favoriteenemy.origin ) );
	if( Abs( yawToEnemy ) > 45 )
        return false;
    entity flag::set( "chucky_is_attacking" );
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

	special_interval = ( GetTime() + ( RandomFloatRange( CHUCKY_SPECIAL_COOLDOWN_MIN, CHUCKY_SPECIAL_COOLDOWN_MAX + 1 ) * 1000 ) );

	for( ;; )
	{
		WAIT_SERVER_FRAME;

		if( GetTime() > special_interval )
		{
			if( !isdefined( self.current_event ) )
			{	
				self.current_event = ( ( !isdefined( self.current_event ) ) ? GetEvent( self.special_events )[ 0 ] : self.current_event );
                self thread [[ self.current_event ]]();

				special_interval = ( GetTime() + ( RandomFloatRange( CHUCKY_SPECIAL_COOLDOWN_MIN, CHUCKY_SPECIAL_COOLDOWN_MAX + 1 ) * 1000 ) );
			}
		}
	}
}

function HandlePower()
{
}

function ChuckyShouldPower( entity )
{
    return entity.is_powered;
}

function HandleVOX()
{
    self endon( "death" );
    
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( !isdefined( self.favoriteenemy ) )
            continue;
        if( self.climbing_in || self.climbing_out )
            continue;
        evt = self util::waittill_any_timeout( RandomFloatRange( CHUCKY_VOX_MIN, CHUCKY_VOX_MAX + 1 ), "power_start" );

        if( IS_EQUAL( evt, "timeout" ) )
        {
            self.playing_vox = true;

            //self PlaySoundWithNotify( "rex_ai_chucky_vox", "sounddone" );
            //self waittill( "sounddone" );

            self.playing_vox = false;
        }
    }
}

function HandleStep()
{
    self endon( "death" );

    for( ;; )
    {
        self waittill( "chucky_step", tag );

        self PlaySoundOnTag( "rex_ai_chucky_step", tag );
    }
}

function ChuckyTargetService( entity )
{
    if( IS_TRUE( entity.ignoreall ) )
        return false;
    if( entity.climbing_in || entity.climbing_out )
        return false;
    n_player = ArrayGetClosest( entity.origin, entity GetTargetablePlayers() );
    player = ( ( !isdefined( entity.favoriteenemy ) || !IS_EQUAL( entity.favoriteenemy, n_player ) ) ? ( ( !IS_EQUAL( n_player, 0 ) ) ? n_player : undefined ) : entity.favoriteenemy );
    
    if( !isdefined( entity.v_zombie_custom_goal ) )
    {
        entity.favoriteenemy = player;
    
        targetPos = GetClosestPointOnNavMesh( entity.favoriteenemy.origin, 16, 8 );
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
		targetPos = GetClosestPointOnNavMesh( entity.v_zombie_custom_goal, 16, 8 );
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
