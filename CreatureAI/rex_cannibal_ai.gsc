#using scripts\codescripts\struct;

#using scripts\shared\ai_shared;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
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
#using scripts\shared\ai\archetype_human_blackboard;
#using scripts\shared\ai\archetype_human_cover;
#using scripts\shared\ai\archetype_human_exposed;
#using scripts\shared\ai\archetype_human_interface;
#using scripts\shared\ai\archetype_human_locomotion;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_notetracks;
#using scripts\shared\ai\systems\ai_blackboard;
#using scripts\shared\ai\systems\destructible_character;
#using scripts\shared\ai\systems\gib;

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

#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_weapons;

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

#define CANNIBAL_DOOR_DESTROY_FX                "REX/ai/cannibal/door_destroy"

#define CANNIBAL_HEALTH 			10000

#define ARCHETYPE_CANNIBAL 			"rex_cannibal"

#define SQUARED(x)                              ( x * x )

#precache( "xmodel", "rex_outlast_door_stage1" );
#precache( "xmodel", "rex_outlast_door_stage2" );
#precache( "fx", CANNIBAL_DOOR_DESTROY_FX );

#namespace rex_cannibal_ai;

REGISTER_SYSTEM( "rex_cannibal", &__init__, undefined )

function __init__() 
{
	level.cannibal_spawner = GetEntArray( "cannibal_spawner", "script_noteworthy" );

	BT_REGISTER_API( "CannibalLocomotionBehaviorCondition",				&CannibalLocomotionBehaviorCondition );
	BT_REGISTER_API( "CannibalTargetService",					&CannibalTargetService );
	BT_REGISTER_API( "CannibalShouldAttack",					&CannibalShouldAttack );
	BT_REGISTER_API( "CannibalShouldShove",					    	&CannibalShouldShove );
    	BT_REGISTER_API( "CannibalShouldEquip",					    	&CannibalShouldEquip );
   	 BT_REGISTER_API( "CannibalShouldSpawn",					&CannibalShouldSpawn );

	spawner::add_archetype_spawn_function( ARCHETYPE_CANNIBAL, 	&CannibalInit );

    	animationstatenetwork::registernotetrackhandlerfunction( "cannibal_melee", &CannibalMelee );
    	animationstatenetwork::registernotetrackhandlerfunction( "cannibal_shove", &CannibalShove );
    	animationstatenetwork::registernotetrackhandlerfunction( "death", &CannibalDeath );

	level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_CANNIBAL, true, true, true );
	level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_CANNIBAL, true, true, true );
	level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_CANNIBAL, true, true, true );
	level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_CANNIBAL, true, true, true );
	level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_CANNIBAL, true, true, true );

    level thread WatchDoor();
}

function WatchDoor()
{
    level endon( "begin_door_evt" );

    door = GetEnt( "outlast_cannibal_door", "targetname" );
    spawn_loc = struct::get( "cannibal_spawn_location" );

    for( ;; )
    {
        WAIT_SERVER_FRAME;
        
        players = GetPlayers();
        for( i = 0; i < players.size; i++ )
        {
            if( DistanceSquared( players[ i ].origin, door.origin ) <= SQUARED( 175 ) )
            {
                entity = rex_cannibal_ai::spawn_cannibal( spawn_loc );
                level notify( "begin_door_evt" );
            }
        }
    }
}

function CannibalInit()
{
    self.health = CANNIBAL_HEALTH;
	self.maxhealth = self.health;
	
    self.cannibal_move_type = "walk";
    self.cannibal_equip_type = "equip";

    BB_REGISTER_ATTRIBUTE( "_rex_cannibal_move_type", self.cannibal_move_type, &CannibalMoveType );
    BB_REGISTER_ATTRIBUTE( "_rex_cannibal_equip_type", self.cannibal_equip_type, &CannibalEquipType );

	Blackboard::CreateBlackBoardForEntity( self );
		
	ai::CreateInterfaceForEntity( self );

	self AiUtility::RegisterUtilityBlackboardAttributes();

	self flag::init( "cannibal_is_attacking" );

    self.grab_spot = util::spawn_model( "tag_origin", ( self.origin + VectorScale( AnglesToForward( self.angles ), 36 ) ), VectortoAngles( AnglesToForward( self.angles ) * -1 ) );
    self.grab_spot LinkTo( self );

    self.track = util::spawn_model( "tag_origin", self.origin, self.angles );
    self.track LinkTo( self );
    
    self.saw = util::spawn_model( "tag_origin", self.origin, self.angles );
    self.saw LinkTo( self );
	
	self PushActors( true );
    self PushPlayer( true );

    self.meleedamage = 35;
    self.meleeattackdist = 75;

    self.no_gib = true;
	self.has_legs = true;
	self.forcemovementscriptstate = false;
	self.ignore_nuke = true;
	self.ignore_enemy_count = true;
	self.ignoreragdoll = true;
	self.skipautoragdoll = true;
	self.ignore_round_robbin_death = true;
	self.b_ignore_cleanup = true;
    self.is_spawning = false;
    self.is_shoving = false;
    self.is_equipped = false;
    self.is_equipping = false;

    self.shove_interval = GetTime();
    self.dialog_interval = GetTime();

    self HandleSpawning();
    self thread HandleRoam();
    self thread HandleShove();
    self thread HandleDeath();
    self thread HandleDialog();
    self thread CheckIsAttacking();

	AiUtility::AddAIOverrideDamageCallback( self, &CannibalDamageCallback );
}

function HandleSpawning()
{
    door = GetEnt( "outlast_cannibal_door", "targetname" );
    ents = GetEntArray( door.target, "targetname" );

    for( i = 0; i < ents.size; i++ )
    {
        if( IS_EQUAL( ents[ i ].classname, "script_brushmodel" ) )
            clip = ents[ i ];
        if( IS_EQUAL( ents[ i ].classname, "script_origin" ) )
            fx = ents[ i ];
    }

    self.is_spawning = true;

    bash_amount = RandomIntRange( 5, 8 );
    for( i = 0; i < bash_amount; i++ )
    {
        self waittill( "bash_door" );

        if( IS_EQUAL( i, ( bash_amount - 1 ) ) )
        {
            door PlaySound( "rex_ai_cannibal_bash_destroy" );

            PlayFX( CANNIBAL_DOOR_DESTROY_FX, fx.origin, AnglesToForward( fx.angles ), AnglesToUp( fx.angles ) );

            fx Delete();
            clip Delete();
            door Delete();
        }
        else
        {
            door PlaySound( "rex_ai_cannibal_bash" );

            if( IS_EQUAL( i, ( ( IS_EQUAL( bash_amount, 5 ) ) ? 1 : 2 ) ) )
                door SetModel( "rex_outlast_door_stage1" );
            if( IS_EQUAL( i, Ceil( bash_amount / 2 ) ) )
                door SetModel( "rex_outlast_door_stage2" );

            self waittill( "bash_done" );
        }
    }
    self.is_spawning = false;
}

function CannibalShouldSpawn( entity )
{
    return entity.is_spawning;
}

function CannibalDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, offsetTime, boneIndex, modelIndex )
{
    return ( ( self.marked_for_death ) ? damage : 0 );
}

function CannibalMelee( entity )
{
    hitent = undefined;
    if( DistanceSquared( entity.favoriteenemy.origin, entity.origin ) <= SQUARED( entity.meleeattackdist ) )
        hitent = entity.favoriteenemy;
    
	if( isdefined( hitent ) && IsPlayer( hitent ) )
	{
        hitent DoDamage( entity.meleedamage, hitent.origin, entity, entity, "none", "MOD_MELEE" );

        if( entity.is_shoving )
        {
            WAIT_SERVER_FRAME;

            hitent ShellShock( "explosion", 1.5 );
        }
	}
}

function CannibalLocomotionBehaviorCondition( entity )
{	
	if( entity HasPath() && !self flag::get( "cannibal_is_attacking" ) )
		return true;
	return false;
}

function CannibalMoveType()
{
    self.cannibal_move_type = "walk";
    if( isdefined( self.favoriteenemy ) && IsAlive( self.favoriteenemy ) )
    {
        self.cannibal_move_type = "sprint";
    }
	return self.cannibal_move_type;
}

function CheckIsAttacking()
{
	self endon( "death" );

	for( ;; )
	{
		WAIT_SERVER_FRAME;

        if( self flag::get( "cannibal_is_attacking" ) )
        {
            result = util::waittill_any_return( "melee_done" );

            self flag::clear( "cannibal_is_attacking" );
        }
	}
}

function CannibalShouldAttack( entity )
{	
	if( entity flag::get( "cannibal_is_attacking" ) )
		return true;
    if( entity.is_spawning )
        return false;
	if( !isdefined( entity.favoriteenemy ) )
		return false;
	if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > SQUARED( entity.meleeattackdist ) )
		return false;
	yawToEnemy = AngleClamp180( entity.angles[ 1 ] - GET_YAW( entity, entity.favoriteenemy.origin ) );
	if( Abs( yawToEnemy ) > 45 )
		return false;
	entity flag::set( "cannibal_is_attacking" );
	return true;
}

function HandleDeath()
{
    self waittill( "death" );

    self.marked_for_death = true;

    self StopLoopSound( 1 );
    self Ghost();

    self.saw StopLoopSound( 1 );
    self.saw Unlink();
    self.saw Delete();

    self.track StopLoopSound( 1 );
    self.track Unlink();
    self.track Delete();

    self.grab_spot Unlink();
    self.grab_spot Delete();

    self DoDamage( self.maxhealth, self.origin );
}

function HandleShove()
{
    for( ;; )
    {
        WAIT_SERVER_FRAME;
        
        if( self.is_spawning )
            continue;
        if( DistanceSquared( self.favoriteenemy.origin, self.origin ) <= SQUARED( Int( self.meleeattackdist * 1.75 ) ) && ( GetTime() > self.shove_interval ) )
        {
            yawToAI = AngleClamp180( self.favoriteenemy.angles[ 1 ] - GET_YAW( self.favoriteenemy, self.origin ) );
            if( Abs( yawToAI ) > 120 )
            {
                if( self flag::get( "cannibal_is_attacking" ) )
                    self notify( "melee_done" );

                self.favoriteenemy StartCameraTween( 0.1 );
                self.favoriteenemy CameraActivate( true );
                self.favoriteenemy CameraSetPosition( ( self.grab_spot.origin + VectorScale( AnglesToForward( self.grab_spot.angles ), 72 ) ) );
                self.favoriteenemy CameraSetAngles( self.grab_spot.angles );
                    wait( 0.1 );
                self.favoriteenemy CameraActivate( false );
                self.favoriteenemy PlayerLinkToDelta( self.grab_spot, "tag_origin", 1, 10, 10, 10, 10, 1 );
                
                self.is_shoving = true;
                self waittill( "shove_done" );
                self.is_shoving = false;

                self.shove_interval = ( GetTime() + ( RandomIntRange( 15, 20 ) * 1000 ) );
            }
        }
    }
}

function CannibalShouldShove( entity )
{
    return entity.is_shoving;
}

function CannibalShove( entity )
{
    wait( 0.1 );

    entity.favoriteenemy Unlink();
    entity KnockbackEnemy( entity.favoriteenemy );
}

function CannibalEquip()
{   
    self.is_equipping = true;

    self waittill( "equip_done" );

    self.is_equipping = false;
}

function CannibalEquipType()
{
    self.cannibal_equip_type = "equip";
    if( !isdefined( self.favoriteenemy ) )
    {
        self.cannibal_equip_type = "unequip";
    }
	return self.cannibal_equip_type;
}

function CannibalShouldEquip( entity )
{
    return entity.is_equipping;
}

function CannibalDeath( entity )
{
    entity.grab_spot Unlink();
    entity.grab_spot Delete();
}

function HandleRoam()
{
    self endon( "death" );

    old_origin = ( 0, 0, 0 );

    for( ;; )
    {
        wait( 0.15 );

        if( self.is_spawning )
            continue;
        if( !isdefined( self.favoriteenemy ) )
        {
            if( self.is_equipped )
            {
                self.is_equipped = false;
                self thread CannibalEquip();
                
                self.track StopLoopSound( 1 );
                self.saw StopLoopSound( 1 );
                self StopLoopSound( 1 );
            }
            if( !isdefined( self.v_zombie_custom_goal ) )
            {
                queryResult = PositionQuery_Source_Navigation( ( self.origin + vectorscale( AnglesToForward( self.angles ), 250 ) ), 250, 1000, 175, 25, self );
                roam_loc = array::random( queryResult.data );
                if( !self CanPath( self.origin, roam_loc.origin ) )
                    continue;
	            yawToPos = AngleClamp180( self.angles[ 1 ] - GET_YAW( self, roam_loc.origin ) );
                if( Abs( yawToPos ) > 135 )
                    continue;

                self.v_zombie_custom_goal = roam_loc.origin;
            }
            else
            {
                if( ( DistanceSquared( self.origin, self.v_zombie_custom_goal ) < SQUARED( 36 ) ) || IS_EQUAL( self.origin, old_origin ) )
                {
                    self.v_zombie_custom_goal = undefined;
                }
                old_origin = self.origin;
            }
        }
        else
        {
            self.v_zombie_custom_goal = undefined;

            if( !self.is_equipped )
            {
                self.is_equipped = true;
                self thread CannibalEquip();

                self.track PlayLoopSound( "rex_ai_chriswalker_chase_track", 1 );
                self.saw PlayLoopSound( "rex_ai_cannibal_saw", 1 );
                self PlayLoopSound( "rex_ai_cannibal_chase", 1 );
            }
        }
    }
}

function HandleDialog()
{
    self endon( "death" );
    
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( !isdefined( self.favoriteenemy ) )
        {
            
            if( GetTime() > self.dialog_interval )
            {
                self PlaySound( "rex_ai_cannibal_roam" );

                self.dialog_interval = ( GetTime() + ( RandomIntRange( 8, 16 ) * 1000 ) );
            }
        }
        else
        {
            self StopSound( "rex_ai_cannibal_roam" );
        }
    }
}

function CannibalTargetService( entity )
{
    if( IS_TRUE( entity.ignoreall ) )
        return false;
    if( entity.is_spawning )
        return false;
    if( entity.is_equipping )
        return false;
    if( !isdefined( entity.favoriteenemy ) )
    {
        players = GetTargetablePlayers();
        for( i = 0; i < players.size; i++ )
        {
            if( CanSeeEnemy( entity, players[ i ] ) && !IsEnemyStealth( entity, players[ i ] ) && IsWithinRange( entity, players[ i ], 0, 500 ) )
            {
                entity.favoriteenemy = players[ i ];
            }
        }
    }
    else
    {
        if( !IsWithinRange( entity, undefined, 0, 750 ) || !entity CanPath( entity.origin, entity.favoriteenemy.origin ) )
        {
            entity.favoriteenemy = undefined;
        }
    }
    targetPos = ( isdefined( entity.v_zombie_custom_goal ) ? entity.v_zombie_custom_goal : ( ( isdefined( entity.favoriteenemy ) ) ? entity.favoriteenemy.origin : undefined ) );
    entity SetGoal( ( ( isdefined( targetPos ) ) ? targetPos : entity.origin ) );

    return ( isdefined( targetPos ) );
}

function spawn_cannibal( s_location )
{
	spots = struct::get_array( "cannibal_location", "targetname" );

	loc = ( ( isdefined( s_location ) ) ? s_location : array::random( spots ) );

	entity = zombie_utility::spawn_zombie( level.cannibal_spawner[ 0 ], "rex_cannibal", loc );
	entity ForceTeleport( loc.origin, loc.angles );

	return entity;
}



// REX - UTILITIES



function private IsEnemyStealth( entity, target = undefined )
{
    player = ( ( isdefined( target ) ? target : entity.favoriteenemy ) );

    if( IS_EQUAL( player GetStance(), "crouch" ) && !player IsFiring() && !player IsSprinting() )
        return true;
    return false;
}

function private CanSeeEnemy( entity, target = undefined )
{
    player = ( ( isdefined( target ) ) ? target : entity.favoriteenemy );
    
	can_see = false;
	trace = PhysicsTrace( entity.origin + VectorScale( ( 0, 0, 1 ), 48 ), player.origin + VectorScale( ( 0, 0, 1 ), 36 ), ( -16, -16, -12 ), ( 16, 16, 12 ), entity );
	if( trace[ "fraction" ] == 1 || IS_EQUAL( trace[ "entity" ], player ) )
		can_see = true;
	return can_see;
}

function private IsWithinRange( entity, target = undefined, minrange, maxrange )
{
	if( !isdefined( minrange ) )
		minrange = 200;
	if( !isdefined( maxrange ) )
		maxrange = 1000;
    
    player = ( ( isdefined( target ) ? target : entity.favoriteenemy ) );

	withinrange = DistanceSquared( entity.origin, player.origin ) <= SQUARED( maxrange );
	withinrange = ( withinrange && DistanceSquared( entity.origin, player.origin ) >= SQUARED( minrange ) );

	return withinrange;
}

function private KnockbackEnemy( enemy )
{
    velocity = enemy GetVelocity();
    forward = AnglesToForward( self.angles );
    force = ( 200 + ( RandomIntRange( 450, 650 ) ) );

	enemy SetVelocity( velocity + ( forward * force ) );
}

function private CreateDynEnt( model, origin, angles = ( 0, 0, 0 ), weight = 1, length = 15 )
{
    ent = util::spawn_model( model, origin, angles );
    ent PhysicsLaunch( origin, ( AnglesToUp( self.angles ) * weight ) );

    lifetime = ( GetTime() + ( length * 1000 ) );
    while( GetTime() < lifetime )
        WAIT_SERVER_FRAME;
    ent Delete();
}

function private GetTargetablePlayers()
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
