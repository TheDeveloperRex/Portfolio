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

#define GEGENEES_HELMET                         "c_t8_zmb_dlc2_gegenees_helmet1"
#define GEGENEES_SHIELD                         "c_t8_zmb_dlc2_gegenees_shield"
#define GEGENEES_SWORD                          "c_t8_zmb_dlc2_gegenees_sword"
#define GEGENEES_SPEAR                          "c_t8_zmb_dlc2_gegenees_spear"

#define GEGENEES_LUNGE_INTERVAL_MIN				5
#define GEGENEES_LUNGE_INTERVAL_MAX				15
#define GEGENEES_ATTACK_DISTANCE        		125
#define GEGENEES_TARGET_DISTANCE				1250
#define GEGENEES_ATTACK_DAMAGE					35
#define GEGENEES_ROCKET_DAMAGE					50
#define GEGENEES_HEALTH 						10000

#define ARCHETYPE_GEGENEES 					    "rex_gegenees"

#define SQUARED(x)                              ( x * x )

#precache( "xmodel", GEGENEES_SHIELD );
#precache( "xmodel", GEGENEES_SWORD );
#precache( "xmodel", GEGENEES_SPEAR );

#namespace rex_gegenees_ai;

REGISTER_SYSTEM( "rex_gegenees", &__init__, undefined )

function __init__()
{
	level.gegenees_spawner = GetEntArray( "gegenees_spawner", "script_noteworthy" );

	BT_REGISTER_API( "GegeneesLocomotionBehaviorCondition",		&GegeneesLocomotionBehaviorCondition );
    BT_REGISTER_API( "GegeneesShouldShieldBlast",				&GegeneesShouldShieldBlast );
    BT_REGISTER_API( "GegeneesShouldSpearThrow",			    &GegeneesShouldSpearThrow );
	BT_REGISTER_API( "GegeneesTargetService",					&GegeneesTargetService );
	BT_REGISTER_API( "GegeneesShouldAttack",					&GegeneesShouldAttack );
    BT_REGISTER_API( "GegeneesShouldRun",			            &GegeneesShouldRun );

	spawner::add_archetype_spawn_function( ARCHETYPE_GEGENEES, 	&GegeneesInit );

    animationstatenetwork::registernotetrackhandlerfunction( "gegenees_melee", &GegeneesMelee );
    animationstatenetwork::registernotetrackhandlerfunction( "geg_grab_spear", &GegeneesGrabSpear );
    animationstatenetwork::registernotetrackhandlerfunction( "geg_throw_spear", &GegeneesThrowSpear );
    animationstatenetwork::registernotetrackhandlerfunction( "gegenees_weapon_drop", &GegeneesWeaponDrop );
    animationstatenetwork::registernotetrackhandlerfunction( "geg_shield_blast_done", &GegeneesShieldBlastTerminate );

	level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_GEGENEES, true, true, true );
	level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_GEGENEES, true, true, true );
	level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_GEGENEES, true, true, true );
	level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_GEGENEES, true, true, true );
	level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_GEGENEES, true, true, true );
}

function GegeneesInit()
{
    self.health = GEGENEES_HEALTH;
	self.maxhealth = self.health;
	
    self.gegenees_move_type = "walk";

    BB_REGISTER_ATTRIBUTE( "_rex_gegenees_move_type", self.gegenees_move_type, &GegeneesMoveType );

	Blackboard::CreateBlackBoardForEntity( self );
		
	ai::CreateInterfaceForEntity( self );

	self AiUtility::RegisterUtilityBlackboardAttributes();

	self flag::init( "gegenees_is_attacking" );
	
	self PushActors( true );
    self PushPlayer( true );

    self.meleedamage = 50;
    self.meleeattackdist = 175;
    self.requireddamage = 0;
    self.track_enemy = 0;

    self.no_gib = true;
	self.has_legs = true;
	self.forcemovementscriptstate = false;
	self.ignore_nuke = true;
	self.ignore_enemy_count = true;
	self.ignoreragdoll = true;
	self.skipautoragdoll = true;
	self.ignore_round_robbin_death = true;
	self.b_ignore_cleanup = true;
    self.is_throwing_spear = false;
    self.is_blasting = false;
    self.is_spawning = false;
    self.has_spear = true;
    self.can_attack = true;

    self.shield_interval = GetTime();
    self.spear_interval = ( GetTime() + Int( RandomFloatRange( 8.5, 10 ) * 1000 ) );

    self thread HandleShieldBlast();
    self thread CheckIsAttacking();
    self thread SetupEquipment();
    self thread HandleSpear();

	AiUtility::AddAIOverrideDamageCallback( self, &GegeneesDamageCallback );
}

function SetupEquipment()
{
    self Attach( GEGENEES_SHIELD, "tag_weapon_left" );
	self Attach( GEGENEES_SWORD, "tag_weapon_right" );
    self Attach( GEGENEES_SPEAR, "tag_inhand" );
	self Attach( GEGENEES_HELMET, "j_head" );
}

function GegeneesShouldRun( entity )
{
    return IS_EQUAL( entity.gegenees_move_type, "run" );
}

function GegeneesDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, offsetTime, boneIndex, modelIndex )
{
    if( isdefined( boneIndex ) )
	{
		if( IS_EQUAL( boneIndex, 258 ) )
		{
			if( isdefined( dir ) )
			{
				//PlayFX( "impacts/fx8_bul_impact_metal_sm", point, dir * -1 );
				if( isdefined( point ) )
				{
					//PlaySoundAtPosition( "rex_gegenees_shield_impact", point );
				}
			}
			return 0;
		}
	}
    adjusted_damage = Int( ( ( damage * 100 ) / ( self.maxhealth * 0.65 ) ) );

    if( !isdefined( self.currentdamage ) )
		self.currentdamage = adjusted_damage;
	else
		self.currentdamage += adjusted_damage;

    self.requireddamage += adjusted_damage;
	if( self.requireddamage >= 500 )
	{
		self.shield_interval = ( GetTime() + 4000 );
        self.requireddamage = 0;
	}
	return adjusted_damage;
}

function GegeneesMelee( entity )
{
    hitent = undefined;
    if( DistanceSquared( entity.favoriteenemy.origin, entity.origin ) <= SQUARED( entity.meleeattackdist ) )
        hitent = entity.favoriteenemy;
    
	if( isdefined( hitent ) && IsPlayer( hitent ) )
	{
        hitent DoDamage( entity.meleedamage, hitent.origin, entity, entity, "none", "MOD_MELEE" );
		entity KnockbackEnemy( hitent );
	}
}

function GegeneesWeaponDrop( entity )
{
    entity Detach( GEGENEES_SHIELD, "tag_weapon_left" );
    entity Detach( GEGENEES_SWORD, "tag_weapon_right" );
	entity Detach( GEGENEES_SPEAR, "tag_inhand" );

    self thread CreateDynEnt( GEGENEES_SHIELD, entity GetTagOrigin( "tag_weapon_left" ), entity GetTagAngles( "tag_weapon_left" ), -1 );
    self thread CreateDynEnt( GEGENEES_SWORD, entity GetTagOrigin( "tag_weapon_right" ), entity GetTagAngles( "tag_weapon_right" ), -1 );
    self thread CreateDynEnt( GEGENEES_SPEAR, entity GetTagOrigin( "tag_inhand" ), entity GetTagAngles( "tag_inhand" ), -1 );
}

function KnockbackEnemy( enemy )
{
	forward = AnglesToForward( self.angles );
	velocity = enemy GetVelocity();
	force = ( 200 + ( RandomInt( 500 ) ) );
	enemy SetVelocity( velocity + ( forward * force ) );
}

function GegeneesLocomotionBehaviorCondition( entity )
{	
	if( entity HasPath() && !self flag::get( "gegenees_is_attacking" ) )
		return true;
	return false;
}

function GegeneesMoveType()
{
    if( isdefined( self.favoriteenemy ) && IsAlive( self.favoriteenemy ) )
    {
        if( DistanceSquared( self.origin, self.favoriteenemy.origin ) > SQUARED( 550 ) )
            self.gegenees_move_type = "run";
        if( DistanceSquared( self.origin, self.favoriteenemy.origin ) < SQUARED( 450 ) )
            self.gegenees_move_type = "walk";
    }
    if( GetTime() < self.shield_interval )
        self.gegenees_move_type = "block";
	return self.gegenees_move_type;
}

function CheckIsAttacking()
{
	self endon( "death" );

	while( 1 )
	{
		WAIT_SERVER_FRAME;

        if( self flag::get( "gegenees_is_attacking" ) )
        {
            self waittill( "melee_done" );

            self flag::clear( "gegenees_is_attacking" );

            if( IsWithinRange( self ) && CanSeeEnemy( self ) )
            {
                self.is_throwing_spear = true;
            }
        }
	}
}

function GegeneesShouldAttack( entity )
{	
	if( entity flag::get( "gegenees_is_attacking" ) )
		return true;
	if( !isdefined( entity.favoriteenemy ) )
		return false;
	if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > SQUARED( GEGENEES_ATTACK_DISTANCE ) )
		return false;
	yawToEnemy = AngleClamp180( entity.angles[ 1 ] - GET_YAW( entity, entity.favoriteenemy.origin ) );
	if( Abs( yawToEnemy ) > 45 )
		return false;
    if( !entity.can_attack )
        return false;
	entity flag::set( "gegenees_is_attacking" );
	return true;
}

function GegeneesShouldSpearThrow( entity )
{
	return entity.is_throwing_spear;
}

function GegeneesGrabSpear( entity )
{
    entity AttachSpear();
}

function GegeneesThrowSpear( entity )
{
	if( !IsActor( entity ) || !isdefined( entity.favoriteenemy ) )
		return;

	weapon = GetWeapon( "gegenees_spear_projectile" );
	startpos = entity GetTagOrigin( "tag_inhand" );
	endpos = ( entity.favoriteenemy.origin + VectorScale( ( 0, 0, 1 ), 36 ) );
    
	projectile = MagicBullet( weapon, startpos, endpos, entity, entity.favoriteenemy );
	projectile thread WatchSpear( projectile, entity );
	entity thread DetachSpear();

    result = entity util::waittill_any_return( "spear_throw_done", "spear_cancel" );
    entity.is_throwing_spear = false;

    entity.spear_interval = ( GetTime() + Int( RandomFloatRange( 8.5, 10 ) * 1000 ) );
}

function DetachSpear()
{
	if( IS_TRUE( self.has_spear ) )
	{
		//self clientfield::set("gegenees_spear_tip_effect", 0);

		self Detach( GEGENEES_SPEAR, "tag_inhand" );
		self.has_spear = false;
	}
}

function AttachSpear()
{
	if( isdefined( self.has_spear ) && !self.has_spear )
	{
		//self clientfield::set("gegenees_spear_tip_effect", 1);

		self Attach( GEGENEES_SPEAR, "tag_inhand" );
		self.has_spear = true;
	}
}

function WatchSpear( projectile, entity )
{
    projectile endon( "spear_death" );

    result = projectile util::waittill_any_return( "projectile_impact_player", "death" );
    if( !IS_EQUAL( result, "projectile_impact_player" ) )
    {
        // Handle yum later
    }
}

function HandleSpear()
{
    self endon( "death" );

    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( self.is_throwing_spear || self.is_blasting || self.is_spawning )
            self.spear_interval = ( GetTime() + Int( RandomFloatRange( 8.5, 10 ) * 1000 ) );
            
        if( ( GetTime() > self.spear_interval ) && !self.is_throwing_spear )
            self.is_throwing_spear = true;
    }
}

function HandleShieldBlast()
{
    self endon( "death" );
    
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        guard_health_req = ( 0.1 * self.maxhealth );

        if( isdefined( self.currentdamage ) )
        {
            if( self.currentdamage > guard_health_req )
            {
                self.is_blasting = true;
            }
        }
        if( self.is_blasting )
        {
            //self clientfield::increment( "gegenees_shield_blast_effect" );
            
            self.can_attack = false;
            self.track_enemy = true;
            self.locked_enemy = self.favoriteenemy;

            self waittill( "gegenees_start_tracking" );

            self.track_interval = ( GetTime() + ( Int( RandomIntRange( 2, 4 ) * 1000 ) ) );

            while( IS_TRUE( self.track_enemy ) )
            {
                WAIT_SERVER_FRAME;

                if( isdefined( self.track_interval ) )
                	if( GetTime() > self.track_interval )
                        self.track_enemy = false;
            }
            self thread DoShieldBlast();

            self.currentdamage = 0;
            self.is_blasting = false;
        }
    }
}

function DoShieldBlast()
{
    if( isdefined( self.locked_enemy ) )
    {
        hit_enemy = 1;
        blast_origin = self GetTagOrigin( "j_gegenees_shield" );
        forward_angles = AnglesToForward( self.angles );
        if( isdefined( blast_origin ) && isdefined( forward_angles ) )
        {
            end_pos = ( blast_origin + ( forward_angles * 1200 ) );
            point_origin = self.locked_enemy GetCentroid();
            radial_origin = PointOnSegmentNearestToPoint( blast_origin, end_pos, point_origin );
            dist = DistanceSquared( point_origin, radial_origin );

            if( dist > SQUARED( 64 ) )
                hit_enemy = 0;
            hit_enemy = BulletTracePassed( blast_origin, point_origin, 0, undefined );

            if( hit_enemy )
            {
                self.locked_enemy thread DoBlastRumble( self );
                //self.locked_enemy clientfield::increment_to_player( "gegenees_damage_cf" );
            }
        }
    }
}

function GegeneesShieldBlastTerminate( entity )
{
    entity.can_attack = true;
    //entity clientfield::set( "gegenees_shield_guard_effect", 0 );
}

function GegeneesShouldShieldBlast( entity )
{
    if( IsWithinRange( entity ) && CanSeeEnemy( entity ) && self.is_blasting )
        return true;
    return false;
}

function GegeneesTargetService( entity )
{
    if( IS_TRUE( entity.ignoreall ) )
        return false;
    if( entity.is_throwing_spear )
        return false;
    if( entity.is_blasting )
        return false;
    n_player = ArrayGetClosest( entity.origin, entity GetTargetablePlayers() );
    player = ( ( !isdefined( entity.favoriteenemy ) || !IS_EQUAL( entity.favoriteenemy, n_player ) ) ? ( ( !IS_EQUAL( n_player, 0 ) ) ? n_player : undefined ) : entity.favoriteenemy );
    
    if( !isdefined( entity.v_zombie_custom_goal ) )
    {
        entity.favoriteenemy = player;
    
        targetPos = GetClosestPointOnNavMesh( entity.favoriteenemy.origin, 32, 16 );
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
		targetPos = GetClosestPointOnNavMesh( entity.v_zombie_custom_goal, 32, 16 );
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

function spawn_gegenees( s_location )
{
	spots = struct::get_array( "gegenees_location", "targetname" );

	loc = ( ( isdefined( s_location ) ) ? s_location : array::random( spots ) );

	entity = zombie_utility::spawn_zombie( level.gegenees_spawner[ 0 ], "rex_gegenees", loc );
	entity ForceTeleport( loc.origin, loc.angles );

	return entity;
}



// REX - UTILITIES



function private DoBlastRumble( entity )
{
	self endon( "death" );
	self endon( "disconnect" );

	time = ( GetTime() + 2000 );
	
	for( ;; )
	{
		WAIT_SERVER_FRAME;

		if( GetTime() > time )
			break;
		self PlayRumbleOnEntity( "damage_heavy" );
	}
    entity.locked_enemy = undefined;
}

function private CanDoEvent( entity, eventname )
{
	if( !isdefined( entity.favoriteenemy ) )
		return false;

	events = blackboard::getblackboardevents( eventname );
	if( isdefined( events ) && events.size )
	{
		foreach( event in events )
		{
			if( IS_EQUAL( event.data.favoriteenemy, entity.favoriteenemy ) )
			{
				return false;
			}
		}
	}
	return true;
}

function private CanSeeEnemy( entity )
{
	if( !isdefined( entity.favoriteenemy ) )
		return false;
	can_see = false;
	trace = PhysicsTrace( entity.origin + VectorScale( ( 0, 0, 1 ), 48 ), entity.favoriteenemy.origin + VectorScale( ( 0, 0, 1 ), 36 ), ( -16, -16, -12 ), ( 16, 16, 12 ), entity );
	if( trace[ "fraction" ] == 1 || IS_EQUAL( trace[ "entity" ], entity.favoriteenemy ) )
		can_see = true;
	return can_see;
}

function private IsWithinRange( entity, minrange, maxrange )
{
	if( !isdefined( entity.favoriteenemy ) )
		return false;
	if( !isdefined( minrange ) )
		minrange = 200;
	if( !isdefined( maxrange ) )
		maxrange = 1000;
	withinrange = DistanceSquared( entity.origin, entity.favoriteenemy.origin ) <= SQUARED( maxrange );
	withinrange = ( withinrange && DistanceSquared( entity.origin, entity.favoriteenemy.origin ) >= SQUARED( minrange ) );

    if( !withinrange )
        entity notify( "spear_cancel" );
	return withinrange;
}

function private WatchForDeath( projectile )
{
    projectile waittill( "death" );

    WAIT_SERVER_FRAME;

    projectile notify( "spear_death" );
}

function private DestructPart( entity, hitloc, tag )
{
    gibserverutils::togglespawngibs( entity, 1 );
    destructserverutils::destructhitlocpieces( entity, hitloc );

    if( isdefined( tag ) )
    {
        bonename = tag;
        if( !IsString( tag ) )
            bonename = GetPartName( entity, tag );
        if( isdefined( bonename ) )
            ReapplyDestructedPieces( entity, bonename, hitloc );
    }
}

function private ReapplyDestructedPieces( entity, tag, hitloc )
{
	if( isdefined( tag ) && isdefined( entity.destructibledef ) )
	{
        destructbundle = struct::get_script_bundle( "destructiblecharacterdef", entity.destructibledef );

		for( index = 1; index <= destructbundle.pieces.size; index++ )
		{
			piece = destructbundle.pieces[ index - 1 ];
			if( isdefined( piece.hitlocation ) && piece.hitlocation == hitloc )
			{
                destructserverutils::destructpiece( entity, index );
			}
		}
	}
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
