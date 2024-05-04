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

#define CHRISWALKER_HEALTH 						    10000

#define ARCHETYPE_CHRISWALKER 					    "rex_chriswalker"

#define SQUARED(x)                              ( x * x )

#namespace rex_chriswalker_ai;

REGISTER_SYSTEM( "rex_chriswalker", &__init__, undefined )

function __init__() 
{
	level.chriswalker_spawner = GetEntArray( "chriswalker_spawner", "script_noteworthy" );

	BT_REGISTER_API( "ChrisWalkerLocomotionBehaviorCondition",		&ChrisWalkerLocomotionBehaviorCondition );
	BT_REGISTER_API( "ChrisWalkerTargetService",					&ChrisWalkerTargetService );
	BT_REGISTER_API( "ChrisWalkerShouldAttack",					    &ChrisWalkerShouldAttack );
    BT_REGISTER_API( "ChrisWalkerShouldRun",					    &ChrisWalkerShouldRun );
	//BT_REGISTER_API( "ChrisWalkerShouldShove",					    &ChrisWalkerShouldShove );

	spawner::add_archetype_spawn_function( ARCHETYPE_CHRISWALKER, 	&ChrisWalkerInit );

    animationstatenetwork::registernotetrackhandlerfunction( "chriswalker_melee", &ChrisWalkerMelee );
    //animationstatenetwork::registernotetrackhandlerfunction( "chriswalker_shove", &ChrisWalkerShove );

	level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_CHRISWALKER, true, true, true );
	level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_CHRISWALKER, true, true, true );
	level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_CHRISWALKER, true, true, true );
	level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_CHRISWALKER, true, true, true );
	level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_CHRISWALKER, true, true, true );
}

function ChrisWalkerInit()
{
    self.health = CHRISWALKER_HEALTH;
	self.maxhealth = self.health;
	
	Blackboard::CreateBlackBoardForEntity( self );
		
	ai::CreateInterfaceForEntity( self );

	self AiUtility::RegisterUtilityBlackboardAttributes();

	self flag::init( "chriswalker_is_attacking" );

    self.grab_spot = util::spawn_model( "tag_origin", ( self.origin + VectorScale( AnglesToForward( self.angles ), 36 ) ), VectortoAngles( AnglesToForward( self.angles ) * -1 ) );
    self.grab_spot LinkTo( self );

    self.track = util::spawn_model( "tag_origin", self.origin, self.angles );
    self.track LinkTo( self );
	
	self PushActors( true );
    self PushPlayer( true );

    self.meleedamage = 35;
    self.meleeattackdist = 80;

    self.no_gib = true;
	self.has_legs = true;
	self.forcemovementscriptstate = false;
	self.ignore_nuke = true;
	self.ignore_enemy_count = true;
	self.ignoreragdoll = true;
	self.skipautoragdoll = true;
	self.ignore_round_robbin_death = true;
	self.b_ignore_cleanup = true;
    self.chasetrack = false;
    self.is_spawning = false;
    self.is_shoving = false;

    self.shove_interval = GetTime();
    self.dialog_interval = GetTime();

    self.current_dialog = undefined;

    self thread CheckIsAttacking();
    //self thread HandleShove();
    self thread HandleBreathing();
    self thread HandleDialog();
    self thread HandleDeath();
    self thread HandleRoam();
    
	AiUtility::AddAIOverrideDamageCallback( self, &ChrisWalkerDamageCallback );
}

function ChrisWalkerDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, offsetTime, boneIndex, modelIndex )
{
    return ( ( self.marked_for_death ) ? damage : 0 );
}

function ChrisWalkerMelee( entity )
{
    hitent = undefined;
    if( DistanceSquared( entity.favoriteenemy.origin, entity.origin ) <= SQUARED( entity.meleeattackdist ) )
        hitent = entity.favoriteenemy;
    
	if( isdefined( hitent ) && IsPlayer( hitent ) )
	{
        hitent DoDamage( entity.meleedamage, hitent.origin, entity, entity, "none", "MOD_MELEE" );
        hitent PlaySoundToPlayer( "rex_ai_chriswalker_hit", hitent );

        if( entity.is_shoving )
        {
            WAIT_SERVER_FRAME;

            hitent ShellShock( "explosion", 1.5 );
        }
	}
}

function ChrisWalkerLocomotionBehaviorCondition( entity )
{	
	if( entity HasPath() && !self flag::get( "chriswalker_is_attacking" ) )
		return true;
	return false;
}

function ChrisWalkerShouldRun( entity )
{
    return ( isdefined( entity.favoriteenemy ) && IsAlive( entity.favoriteenemy ) );
}

function CheckIsAttacking()
{
	self endon( "death" );

	for( ;; )
	{
		WAIT_SERVER_FRAME;

        if( self flag::get( "chriswalker_is_attacking" ) )
        {
            result = util::waittill_any_return( "melee_done" );

            self flag::clear( "chriswalker_is_attacking" );
        }
	}
}

function ChrisWalkerShouldAttack( entity )
{	
	if( entity flag::get( "chriswalker_is_attacking" ) )
		return true;
	if( !isdefined( entity.favoriteenemy ) )
		return false;
	if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > SQUARED( entity.meleeattackdist ) )
		return false;
	yawToEnemy = AngleClamp180( entity.angles[ 1 ] - GET_YAW( entity, entity.favoriteenemy.origin ) );
	if( Abs( yawToEnemy ) > 45 )
		return false;
	entity flag::set( "chriswalker_is_attacking" );
	return true;
}

function HandleDeath()
{
    self waittill( "death" );

    self.marked_for_death = true;

    self StopLoopSound( 1 );
    self Ghost();

    self.track StopLoopSound( 1 );
    self.track Unlink();
    self.track Delete();

    self.grab_spot Unlink();
    self.grab_spot Delete();

    self DoDamage( self.maxhealth, self.origin );
}

function HandleRoam()
{
    self endon( "death" );

    old_origin = ( 0, 0, 0 );

    for( ;; )
    {
        wait( 0.15 );

        if( !isdefined( self.favoriteenemy ) )
        {
            if( self.chasetrack )
            {
                self.chasetrack = false;
                self.track StopLoopSound( 1 );

                self notify( "end_chase" );
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
            
            if( !self.chasetrack )
            {
                self.chasetrack = true;
                self.track PlayLoopSound( "rex_ai_chriswalker_chase_track", 1 );
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
            closest_player = ArrayGetClosest( self.origin, self GetTargetablePlayers() );

            self.current_dialog = ( ( DistanceSquared( closest_player.origin, self.origin ) < SQUARED( 350 ) ) ? "rex_ai_chriswalker_nearby" : "rex_ai_chriswalker_roam" );
            
            if( GetTime() > self.dialog_interval )
            {
                self PlaySound( self.current_dialog );
                self.dialog_interval = ( GetTime() + ( RandomIntRange( 8, 16 ) * 1000 ) );
            }
        }
        else
        {
            self StopSound( self.current_dialog );
        }
    }
}

function HandleBreathing()
{
    self endon( "death" );

    for( ;; )
    {
        breath_type = ( ( isdefined( self.favoriteenemy ) ) ? "rex_ai_chriswalker_chase" : "rex_ai_chriswalker_idle" );
        self PlaySoundWithNotify( breath_type, "breathe_done" );

        result = util::waittill_any_return( "breathe_done", "begin_chase" );

        if( IS_EQUAL( result, "begin_chase" ) )
        {
            self StopSound( breath_type );
        }
    }
}

function ChrisWalkerTargetService( entity )
{
    if( IS_TRUE( entity.ignoreall ) )
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
    targetPos = GetClosestPointOnNavMesh( ( ( !isdefined( entity.v_zombie_custom_goal ) ) ? entity.favoriteenemy.origin : entity.v_zombie_custom_goal ), 32, 16 );

    entity SetGoal( ( ( isdefined( targetPos ) ) ? targetPos : entity.origin ) );
    return ( isdefined( targetPos ) );
}

function spawn_chriswalker( s_location )
{
	spots = struct::get_array( "chriswalker_location", "targetname" );

	loc = ( ( isdefined( s_location ) ) ? s_location : array::random( spots ) );

	entity = zombie_utility::spawn_zombie( level.chriswalker_spawner[ 0 ], "rex_chriswalker", loc );
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
