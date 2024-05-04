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
#using scripts\zm\_zm;
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

#define STURMKRIEGER_MINIGUN_MUZZLE_FX  "REX/ai/sturmkrieger/fire_muz_flash"
#define STURMKRIEGER_MINIGUN_MODEL      "rex_ai_sturmkrieger_minigun"
#define STURMKRIEGER_PAIN_VOX_CHANCE    10
#define STURMKRIEGER_GRUNT_VOX_MIN      8
#define STURMKRIEGER_GRUNT_VOX_MAX      16
#define STURMKRIEGER_MINIGUN_RPM        0.11
#define STURMKRIEGER_STRAFE_MIN         5
#define STURMKRIEGER_STRAFE_MAX         20
#define STURMKRIEGER_COMBAT_MIN         1.5
#define STURMKRIEGER_COMBAT_MAX         4.5
#define STURMKRIEGER_ATTACK_REACH       64
#define STURMKRIEGER_ATTACK_DAMAGE      75
#define STURMKRIEGER_ATTACK_DISTANCE    85
#define STURMKRIEGER_EXIT_CHASE_RADIUS  500
#define STURMKRIEGER_HEALTH             5000

#define ARCHETYPE_STURMKRIEGER          "rex_sturmkrieger"

#define SQUARED(x)                      ( x * x )

#precache( "xmodel", STURMKRIEGER_MINIGUN_MODEL );
#precache( "fx", STURMKRIEGER_MINIGUN_MUZZLE_FX );

#using_animtree( "generic" );

#namespace rex_sturmkrieger_ai;

REGISTER_SYSTEM( "rex_sturmkrieger", &__init__, undefined )

function __init__()
{
    level.sturmkrieger_spawner = GetEntArray( "sturmkrieger_spawner", "script_noteworthy" );
    
    behaviortreenetworkutility::registerbehaviortreescriptapi( "SturmkriegerShouldProceduralTraverse",  &SturmkriegerShouldProceduralTraverse);
    behaviortreenetworkutility::registerbehaviortreescriptapi( "LocomotionShouldTraverse",              &LocomotionShouldTraverse );
	behaviorstatemachine::registerbsmscriptapiinternal( "LocomotionShouldTraverse",                     &LocomotionShouldTraverse );
	behaviorstatemachine::registerbsmscriptapiinternal( "TraverseSetup",                                &TraverseSetup );
    behaviortreenetworkutility::registerbehaviortreeaction( "TraverseActionStart",                      &TraverseActionStart, undefined, undefined );

    BT_REGISTER_API( "SturmkriegerLocomotionBehaviorCondition", &SturmkriegerLocomotionBehaviorCondition );
    BT_REGISTER_API( "SturmkriegerTargetService",               &SturmkriegerTargetService );
    BT_REGISTER_API( "SturmkriegerShouldAttack",                &SturmkriegerShouldAttack );
    BT_REGISTER_API( "SturmkriegerShouldCombat",                &SturmkriegerShouldCombat );

    spawner::add_archetype_spawn_function( ARCHETYPE_STURMKRIEGER, &SturmkriegerInit );

    level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_STURMKRIEGER, true, true, true );
    level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_STURMKRIEGER, true, true, true );
    level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_STURMKRIEGER, true, true, true );
    level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_STURMKRIEGER, true, true, true );
    level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_STURMKRIEGER, true, true, true );
}

function SturmkriegerInit()
{
    self.health = Int( STURMKRIEGER_HEALTH + ( STURMKRIEGER_HEALTH * ( 0.125 * level.round_number ) ) );
    self.maxhealth = self.health;

    self.sturmkrieger_move_type = "strafe";

    BB_REGISTER_ATTRIBUTE( "_rex_sturmkrieger_move_type", self.sturmkrieger_move_type, &SturmkriegerMoveType );

    Blackboard::CreateBlackBoardForEntity( self );

    ai::CreateInterfaceForEntity( self );

    level.strafe_dirs = array( "strafe_l", "strafe_r", "strafe_b" );

    self flag::init( "sturmkrieger_is_attacking" );

    self AiUtility::RegisterUtilityBlackboardAttributes();

    self PushActors( true );
    self PushPlayer( true );

    self.ignore_nuke = true;
    self.ignore_enemy_count = true;
    self.ignoreragdoll = true;
    self.skipautoragdoll = true;
    self.ignore_round_robbin_death = true;
    self.b_ignore_cleanup = true;
    self.is_in_combat = false;
    self.is_strafing = false;
    self.can_attack = false;
    self.can_strafe = false;

    self.minigun = util::spawn_model( STURMKRIEGER_MINIGUN_MODEL, self GetTagOrigin( "tag_weapon_right" ), self GetTagAngles( "tag_weapon_right" ) );
    self.minigun LinkTo( self, "tag_weapon_right" );

    self thread WatchDeath();
    self thread CheckStrafe();
    self thread HandleStrafe();
    self thread HandleLocomotion();
    self thread CheckIsAttacking();
    self thread HandlePlayerDamage();
    self thread HandleCombat();
    self thread HandleGrunt();

    AiUtility::AddAiOverrideDamageCallback( self, &SturmkriegerDamageCallback );
}

function SturmkriegerDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, offsetTime, boneIndex, modelIndex )
{
    if( !IsPlayer( attacker ) && IS_EQUAL( weapon.name, "rex_sturmkrieger_minigun" ) )
        return 0;
    if( RandomInt( 100 ) <= STURMKRIEGER_PAIN_VOX_CHANCE )
        self PlaySound( "rex_ai_sturmkrieger_pain_vox" );
    return damage;
}

function SturmkriegerMoveType()
{
    return self.sturmkrieger_move_type;
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

            self flag::clear( "sturmkrieger_is_attacking" );
        }
	}
}

function WatchDeath()
{
    self waittill( "death" );

    self.minigun Unlink();
    self.minigun Delete();
}

function HandlePlayerDamage()
{
    self endon( "death" );

    while( 1 )
    {
        self waittill( "attack_melee" );

        if( isdefined( self.favoriteenemy ) )
        {
            if( DistanceSquared( self.favoriteenemy.origin, self.origin ) < SQUARED( STURMKRIEGER_ATTACK_REACH ) )
            {
                self.favoriteenemy DoDamage( STURMKRIEGER_ATTACK_DAMAGE, self.favoriteenemy.origin );
            }
        }
    }
}

function HandleCombat()
{
    self endon( "death" );

    self thread WatchCombat();

    while( 1 )
    {
        WAIT_SERVER_FRAME;

        if( !isdefined( self.combat_interval ) )
            self.combat_interval = GetTime();
        
        while( GetTime() < self.combat_interval )
            WAIT_SERVER_FRAME;

        if( self flag::get( "sturmkrieger_is_attacking" ) )
            continue;
        if( IS_EQUAL( self GetAlivePlayers(), 0 ) )
            continue;

        self.is_in_combat = false;

        evt = self util::waittill_any_timeout( ( RandomFloatRange( STURMKRIEGER_COMBAT_MIN, STURMKRIEGER_COMBAT_MAX + 1 ) * 1.75 ), "combat_interrupted" );
        if( IS_EQUAL( evt, "timeout" ) && !IS_EQUAL( self GetAlivePlayers(), 0 ) )
        {
            self.is_in_combat = true;

            self.combat_interval = ( GetTime() + ( RandomFloatRange( STURMKRIEGER_COMBAT_MIN, STURMKRIEGER_COMBAT_MAX + 1 ) * 1000 ) );
        }
    }
}

function WatchCombat()
{
    self endon( "death" );
    while( 1 )
    {
        WAIT_SERVER_FRAME;

        if( self flag::get( "sturmkrieger_is_attacking" ) )
            continue;

        while( self.is_in_combat )
        {
            wait( STURMKRIEGER_MINIGUN_RPM );

            if( !self CanSee( self.favoriteenemy ) || IS_EQUAL( self GetAlivePlayers(), 0 ) )
            {
                self.is_in_combat = false;
                self notify( "combat_interrupted" );
            }
            self PlaySound( "rex_ai_sturmkrieger_shot" );

            start_origin = ( self.minigun GetTagOrigin( "tag_flash" ) + vectorscale( AnglesToForward( self.angles ), 10 ) );
            if( isdefined( start_origin ) )
            {
                e_up_offset = vectorscale( AnglesToUp( self.favoriteenemy.angles ), ( RandomInt( 10 ) * ( ( math::cointoss() ) ? -1 : 1 ) ) );
                e_r_offset = vectorscale( AnglesToRight( self.favoriteenemy.angles ), ( RandomInt( 10 ) * ( ( math::cointoss() ) ? -1 : 1 ) ) );

                end_origin = ( ( start_origin + e_up_offset + e_r_offset ) + ( ( AnglesToForward( VectortoAngles( ( self.favoriteenemy.origin + vectorscale( AnglesToUp( self.favoriteenemy.angles ), 50 ) ) - start_origin ) ) ) * 500 ) );

                if(isdefined( start_origin ) && isdefined( end_origin ) )
                {   
                    shot = MagicBullet( GetWeapon( "rex_sturmkrieger_minigun" ), start_origin, end_origin );
                    PlayFX( STURMKRIEGER_MINIGUN_MUZZLE_FX, self.minigun GetTagOrigin( "tag_flash" ), AnglesToForward( self.minigun.angles ), AnglesToUp( self.minigun.angles ) );
                }
            }
        }
    }
}

function SturmkriegerShouldCombat( entity )
{
    return entity.is_in_combat;
}

function CheckStrafe()
{
    self endon( "death" );

    while( 1 )
    {
        wait( 0.25 );

        z_diff = ( self.favoriteenemy.origin[ 2 ] - self.origin[ 2 ] );
        IPrintLnBold( z_diff );
        
        self.can_strafe = ( ( z_diff < 35 ) && ( z_diff > -35 ) );
    }
}

function HandleStrafe()
{
    self endon( "death" );

    while( 1 )
    {
        WAIT_SERVER_FRAME;
        
        if( !isdefined( self.strafe_interval ) )
            self.strafe_interval = GetTime();
        if( GetTime() < self.strafe_interval )
            continue;
        if( !self.can_strafe )
            continue;
            
        self.is_strafing = false;
        wait( RandomFloatRange( STURMKRIEGER_STRAFE_MIN, STURMKRIEGER_STRAFE_MAX + 1 ) );
        self.is_strafing = true;

        self.strafe_interval = ( GetTime() + ( RandomFloatRange( STURMKRIEGER_STRAFE_MIN, STURMKRIEGER_STRAFE_MAX + 1 ) * 1000 ) );
    }
}

function HandleLocomotion()
{
    self endon( "death" );

    while( 1 )
    {
        WAIT_SERVER_FRAME;
        
        if( self.is_strafing )
        {
            if( !isdefined( self.next_dir ) )
                self.next_dir = GetTime();
            if( GetTime() > self.next_dir )
            {
                strafe_dir = array::random( level.strafe_dirs );
                self.next_dir = ( GetTime() + ( RandomFloat( 7.5 ) * 1000 ) );
            }
        }
        self.sturmkrieger_move_type = ( ( self.is_strafing && ( DistanceSquared( self.favoriteenemy.origin, self.origin ) ) < SQUARED( STURMKRIEGER_EXIT_CHASE_RADIUS ) ) ? strafe_dir : ( ( DistanceSquared( self.favoriteenemy.origin, self.origin ) ) > SQUARED( STURMKRIEGER_EXIT_CHASE_RADIUS ) ? "run" : "walk" ) );
    }
}

function HandleGrunt()
{
    self endon( "death" );

    while( 1 )
    {
        grunt_interval = ( GetTime() + ( RandomFloatRange( STURMKRIEGER_GRUNT_VOX_MIN, STURMKRIEGER_GRUNT_VOX_MAX + 1 ) * 1000 ) );

        while( GetTime() < grunt_interval || self.is_in_combat )
            WAIT_SERVER_FRAME;

        self PlaySound( "rex_ai_sturmkrieger_grunt_vox" );
    }
}

function SturmkriegerLocomotionBehaviorCondition( entity )
{
    if( entity flag::get( "sturmkrieger_is_attacking" ) )
        return false;
    if( entity.is_in_combat )
        return false;
    if( !entity HasPath() )
        return false;
    return true;
}

function SturmkriegerShouldProceduralTraverse( entity )
{
	return isdefined( entity.traversestartnode ) && isdefined( entity.traverseendnode ) && entity.traversestartnode.spawnflags & 1024 && entity.traverseendnode.spawnflags & 1024;
}

function HandleTraverse()
{
    while( 1 )
    {
        self waittill( "traverse_done" );
        self.is_traversing = false;
    }
}

function LocomotionShouldTraverse( entity )
{
	startnode = entity.traversestartnode;
	if( isdefined( startnode ) && entity ShouldStartTraversal() )
    {   
        IPrintLnBold( "^2TRAVERSING: " + startnode.animscript );
        return true;
    }
	return false;
}

function TraverseActionStart( entity, asmstatename )
{
	TraverseSetup( entity );
	animationstatenetworkutility::requeststate( entity, asmstatename );
	return 5;
}

function TraverseSetup( entity )
{
	blackboard::setblackboardattribute( entity, "_traversal_type", entity.traversestartnode.animscript );
	return true;
}

function SturmkriegerShouldAttack( entity )
{
    if( entity flag::get( "sturmkrieger_is_attacking" ) )
        return true;
    if( !isdefined( entity.favoriteenemy ) )
    {
        entity.can_attack = false;
        return false;
    }
    if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > SQUARED( STURMKRIEGER_ATTACK_DISTANCE ) )
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
    entity flag::set( "sturmkrieger_is_attacking" );
    entity.can_attack = true;
    return true;
}

function SturmkriegerTargetService( entity )
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

function spawn_sturmkrieger( s_location )
{
    spots = struct::get_array( "sturmkrieger_location", "targetname" );

	loc = ( ( isdefined( s_location ) ) ? s_location : spots[ RandomInt( spots.size ) ] );
	
	entity = zombie_utility::spawn_zombie( level.sturmkrieger_spawner[ 0 ], "rex_sturmkrieger", loc );
	entity ForceTeleport( loc.origin, loc.angles );
	return entity;
}
