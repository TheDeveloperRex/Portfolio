#using scripts\codescripts\struct;

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

#define SUPERGOLIATH_LUNGE_INTERVAL_MIN				5
#define SUPERGOLIATH_LUNGE_INTERVAL_MAX				15
#define SUPERGOLIATH_ATTACK_DISTANCE_INITIAL		75
#define SUPERGOLIATH_ATTACK_DISTANCE_MIN			75
#define SUPERGOLIATH_ATTACK_DISTANCE_MAX			150
#define SUPERGOLIATH_SPECIAL_COOLDOWN_MIN			10
#define SUPERGOLIATH_SPECIAL_COOLDOWN_MAX   		25
#define SUPERGOLIATH_TARGET_DISTANCE				1250
#define SUPERGOLIATH_ATTACK_DAMAGE					35
#define SUPERGOLIATH_ROCKET_DAMAGE					50
#define SUPERGOLIATH_HEALTH 						15000

#define ARCHETYPE_SUPERGOLIATH 					    "rex_supergoliath"

#precache( "xmodel", "rex_ai_supergoliath_anchor" );
#precache( "xmodel", "rex_ai_supergoliath_shield" );
#precache( "xmodel", "rex_ai_goliath_rocket" );
#precache( "xmodel", "hit_cube" );

#namespace rex_supergoliath_ai;

REGISTER_SYSTEM_EX( "rex_supergoliath", &__init__, &__main__, undefined )

function __init__()
{
    level.sg_spawn_type = undefined;
	level.supergoliath_spawner = GetEntArray( "supergoliath_spawner", "script_noteworthy" );

	BT_REGISTER_API( "GoliathLocomotionBehaviorCondition",		&SuperGoliathLocomotionBehaviorCondition ); 
	BT_REGISTER_API( "GoliathTargetService",					&SuperGoliathTargetService );
	BT_REGISTER_API( "GoliathShouldAttack",					    &SuperGoliathShouldAttack );
    BT_REGISTER_API( "GoliathShouldSpawn",					    &SuperGoliathShouldSpawn );
	BT_REGISTER_API( "GoliathShouldLunge",					    &SuperGoliathShouldLunge );

	spawner::add_archetype_spawn_function( ARCHETYPE_SUPERGOLIATH, 	&SuperGoliathInit );
    
	level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_SUPERGOLIATH, true, true, true );
	level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_SUPERGOLIATH, true, true, true );
	level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_SUPERGOLIATH, true, true, true );
	level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_SUPERGOLIATH, true, true, true );
	level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_SUPERGOLIATH, true, true, true );
}

function __main__()
{
}

function SuperGoliathInit()
{
    self.spawn_type = level.sg_spawn_type;

    BB_REGISTER_ATTRIBUTE( "_rex_goliath_spawn_type", "skyfall", undefined );
    BB_REGISTER_ATTRIBUTE( "_rex_goliath_locomotion_speed", "run", &SuperGoliathMoveType );

	Blackboard::CreateBlackBoardForEntity( self );
		
	ai::CreateInterfaceForEntity( self );

	self AiUtility::RegisterUtilityBlackboardAttributes();

	self thread zm_audio::zmbAIVox_NotifyConvert();

	self flag::init( "supergoliath_is_attacking" );
	
	self.supergoliath_move_type = "run";

	self PushActors( true );
	self ASMSetAnimationRate( 1.1 );
	//self SetPhysParams( 50, 0, 200 );

	self.special_events = array(
		array( "rocket", 95 ),
		array( "stomp", 5 )
	);

	level.supergoliath_attack_distance = SUPERGOLIATH_ATTACK_DISTANCE_INITIAL;

	self.ignore_nuke = true;
	self.ignore_enemy_count = true;
	self.ignoreragdoll = true;
	self.skipautoragdoll = true;
	self.ignorebulletdamage = true;
	self.ignoretriggerdamage = true;
	self.ignore_round_robbin_death = true;
	self.b_ignore_cleanup = true;
	self.is_spawning = false;
	self.is_roaming = false;
	self.can_attack = false;
	self.is_shockwaving = false;
	self.is_lunging = false;
	self.rocketdamage = SUPERGOLIATH_ROCKET_DAMAGE;
	
	self.health = SUPERGOLIATH_HEALTH;
	self.maxhealth = self.health;

    self thread WatchSpawn();
	self thread WatchDeath();
	self thread HandleLunge();
	self thread HandleRocket();
	self thread CheckIsAttacking();
	self thread HandleSpecialEvents();
	self thread HandleShieldHit();
    self thread WeaponSetup();

	AiUtility::addaioverridedamagecallback( self, &SuperGoliathDamageCallback );
}

function SuperGoliathDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, offsetTime, boneIndex, modelIndex )
{
	if( !self.is_roaming )
		self notify( "roam_interrupted" );
	return damage;
}

function WatchDeath()
{
	self waittill( "death", attacker );
}

function WatchSpawn()
{
    Blackboard::SetBlackBoardAttribute( self, "_rex_goliath_spawn_type", self.spawn_type );

    self.is_spawning = true;
    if( isdefined( self.spawn_type ) )
        self waittill( "spawn_done" );
    IPrintLnBold( "SPAWN DONE" );
    self.is_spawning = false;

    Blackboard::SetBlackBoardAttribute( self, "_rex_goliath_spawn_type", undefined );
    
    level.sg_spawn_type = undefined;
}

function SuperGoliathShouldSpawn( entity )
{
	return entity.is_spawning;
}

function SuperGoliathLocomotionBehaviorCondition( entity )
{	
	if( entity flag::get( "supergoliath_is_attacking" ) )
		return false;
    if( entity.is_spawning )
        return false;
    if( !entity HasPath() )
        return false;
	return true;
}

function SuperGoliathMoveType()
{
	return self.supergoliath_move_type;
}

function HandleRoaming()
{
    self endon( "death" );
	
	self thread WatchRoaming();

    while( 1 )
    {
        WAIT_SERVER_FRAME;

        if( self.is_spawning )
            continue;

        if( !isdefined( self.favoriteenemy ) )
        {
			queryResult = PositionQuery_Source_Navigation( self.origin, 750, 1250, 250, 20, self );
			roam_loc = array::random( array::randomize( queryResult.data ) );
			if( !self CanPath( self.origin, roam_loc.origin ) ) 
				continue;

			self.v_zombie_custom_goal = roam_loc.origin;
            self.is_roaming = true;

            self util::waittill_any( "roam_done", "roam_interrupted" );

            self.v_zombie_custom_goal = undefined;
			self.is_roaming = false;

			wait( RandomFloatRange( 1.5, 4.5 ) );
        }
    }
}

function WatchRoaming()
{
    self endon( "death" );

    while( 1 )
    {
		WAIT_SERVER_FRAME;
        
        if( self.is_roaming )
        {
            if( Distance( self.origin, self.v_zombie_custom_goal ) < 75 )
            {
				self notify( "roam_done" );
            }
        }
    }
}

function CheckIsAttacking()
{
	self endon( "death" );

	while( 1 )
	{
		WAIT_SERVER_FRAME;

        if( self.can_attack )
        {
            self util::waittill_any( "attack_done" );

            self flag::clear( "supergoliath_is_attacking" );

			IPrintLnBold( ( ( level.ai_debug ) ? "ATTACK DONE!" : undefined ) );

			level.supergoliath_attack_distance = RandomIntRange( SUPERGOLIATH_ATTACK_DISTANCE_MIN, SUPERGOLIATH_ATTACK_DISTANCE_MAX + 1 );
        }
	}
}

function SuperGoliathShouldAttack( entity )
{	
	if( entity flag::get( "supergoliath_is_attacking" ) )
		return true;
    if( self.is_spawning )
    {
        entity.can_attack = false;
        return false;
    }
	if( !isdefined( entity.favoriteenemy ) )
    {
		entity.can_attack = false;
		return false;
	}
	if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > level.supergoliath_attack_distance * level.supergoliath_attack_distance )
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
	entity flag::set( "supergoliath_is_attacking" );
	entity.can_attack = true;
	return true;
}

function SuperGoliathTargetService( entity )
{
    if( IS_TRUE( entity.ignoreall ) )
        return false;

    n_player = ArrayGetClosest( entity.origin, entity GetAlivePlayers() );
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

function GetAlivePlayers()
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

function GetEvent( arr ) {
	pool = [];
	for( i = 0; i < arr.size; i++ )
		for( j = 0; j < arr[ i ][ 1 ]; j++ )
			pool[ pool.size ] = i;
	return arr[ array::randomize( pool )[ 0 ] ];
}

function HandleSpecialEvents()
{
	self endon( "death" );

	special_interval = GetTime() + ( RandomIntRange( SUPERGOLIATH_SPECIAL_COOLDOWN_MIN, SUPERGOLIATH_SPECIAL_COOLDOWN_MAX + 1 ) * 1000 );

	while( 1 )
	{
		WAIT_SERVER_FRAME;
		
		if( GetTime() > special_interval )
		{
			if( !isdefined( self.current_event ) )
			{	
				self.current_event = ( ( !isdefined( self.current_event ) ) ? GetEvent( self.special_events )[ 0 ] : self.current_event );

				special_interval = GetTime() + ( RandomIntRange( SUPERGOLIATH_SPECIAL_COOLDOWN_MIN, SUPERGOLIATH_SPECIAL_COOLDOWN_MAX + 1 ) * 1000 );
			}
		}
	}
}

function spawn_supergoliath( s_location )
{
	spots = struct::get_array( "supergoliath_location", "targetname" );

	loc = ( ( isdefined( s_location ) ) ? s_location : spots[ RandomInt( spots.size ) ] );

    level.sg_spawn_type = ( ( IS_EQUAL( loc.script_string, "pipefall" ) || IS_EQUAL( loc.script_string, "skyfall" ) || IS_EQUAL( loc.script_string, "walljump" ) ) ? loc.script_string : undefined );

	player = loc zm_utility::get_closest_player();
	v_dir = VectortoAngles( AnglesToForward( player.origin - loc.origin ) * -1 );

	entity = zombie_utility::spawn_zombie( level.supergoliath_spawner[ 0 ], "rex_supergoliath", loc );
	entity ForceTeleport( loc.origin, v_dir );
	return entity;
}

function WeaponSetup()
{
    self.shield = util::spawn_model( "rex_ai_supergoliath_shield", self GetTagOrigin( "tag_weapon_left" ), self GetTagAngles( "tag_weapon_left" ) );
    self.shield LinkTo( self, "tag_weapon_left" );

	self.melee = util::spawn_model( "rex_ai_supergoliath_anchor", self GetTagOrigin( "tag_weapon_right" ), self GetTagAngles( "tag_weapon_right" ) );
    self.melee LinkTo( self, "tag_weapon_right" );
}

function HandleLunge()
{
	self endon( "death" );

	lunge_interval = GetTime() + ( RandomIntRange( SUPERGOLIATH_LUNGE_INTERVAL_MIN, SUPERGOLIATH_LUNGE_INTERVAL_MAX + 1 ) * 1000 );

	while( 1 )
	{
		WAIT_SERVER_FRAME;
        
        if( self.is_spawning )
            continue;
		if( self.is_shockwaving )
			continue;

		if( GetTime() > lunge_interval )
		{
			IPrintLnBold( "LUNGE" );
			self.is_lunging = true;
			self waittill( "lunge_done" );
			self.is_lunging = false;

			lunge_interval = GetTime() + ( RandomIntRange( SUPERGOLIATH_LUNGE_INTERVAL_MIN, SUPERGOLIATH_LUNGE_INTERVAL_MAX + 1 ) * 1000 );
		}
	}
}

function SuperGoliathShouldLunge( entity )
{
	return entity.is_lunging;
}

function HandleShieldHit()
{
	self endon( "death" );

	while( 1 )
	{
		self waittill( "damage", damage );

		self PlaySound( "rex_ai_goliath_shield_impact" );
	}
}

function HandleRocket()
{
	self endon( "death" );

	while( 1 )
	{
		WAIT_SERVER_FRAME;

        if( self.is_spawning )
            continue;

		if( self.current_event === "rocket" )
		{
			IPrintLnBold( "ROCKET" );
			angle_to_target = VectortoAngles( self.favoriteenemy.origin + ( 0, 0, 20 ) - self.origin + ( 0, 0, 20 ) );
			rocket = util::spawn_model( "rex_ai_goliath_rocket", self GetTagOrigin( "tag_rocket_fx" ), angle_to_target );
			rocket zm_utility::fake_physicslaunch( self.favoriteenemy.origin + vectorscale( AnglesToUp( self.favoriteenemy.angles ), 45 ), RandomIntRange( 650, 850 ) );
			rocket PlayLoopSound( "rex_ai_goliath_rocket_whizby" );
			rocket thread WatchRocketMovement();
			rocket thread WatchRocket( self );

			self.current_event = undefined;
		}
	}
}

function WatchRocketMovement()
{
	self zm_utility::waittill_not_moving();
	self Delete();
}

function WatchRocket( entity )
{
	while( isdefined( self ) )
	{
		WAIT_SERVER_FRAME;

		if( self IsTouching( entity.favoriteenemy ) || Distance( entity.favoriteenemy.origin, self.origin ) < 75 )
		{
			entity.favoriteenemy DoDamage( entity.rocketdamage, entity.favoriteenemy.origin );
			//entity.favoriteenemy thread PlayerStaticScreen( 8 );
			self StopLoopSound();
			self Delete();
		}
	}
}

function PlayerStaticScreen( length )
{
	self clientfield::set_to_player( "goliath_static", 1 );
		wait( length );
	self clientfield::set_to_player( "goliath_static", 0 );
}
