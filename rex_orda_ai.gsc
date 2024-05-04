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

#define ORDA_ZOMBIE_SUMMON_TRAIL_FX			"REX/ai/orda/spawn_trail"
#define ORDA_ZOMBIE_SUMMON_IMPACT_FX			"REX/ai/orda/spawn_impact"
#define ORDA_ZOMBIE_CRUSH_ENABLED			false
#define ORDA_ZOMBIE_CRUSH_DIST				150
#define ORDA_ZOMBIE_SUMMON_MIN				12
#define ORDA_ZOMBIE_SUMMON_MAX 				24
#define ORDA_ZOMBIE_SUMMON_COOLDOWN_MIN			10
#define ORDA_ZOMBIE_SUMMON_COOLDOWN_MAX			20
#define ORDA_ZOMBIE_SWIPE_DIST_MIN			50
#define ORDA_ZOMBIE_SWIPE_DIST_MAX			100
#define ORDA_ZOMBIE_HEALTH_INCREMENT			1.5
#define ORDA_ZOMBIE_SPEED				1.125
#define ORDA_ZOMBIE_MAX					64

#define ORDA_HEAL_ARM_FX				"REX/ai/orda/heal_club_consume"
#define ORDA_SPAWN_FX					"REX/ai/orda/spawn_orda_trail"
#define ORDA_IMPACT_FX					"REX/ai/orda/hit_impact"
#define ORDA_WP_UPPER					"rex_ai_orda_wp_upper"
#define ORDA_WP_TORSO					"rex_ai_orda_wp_torso"
#define ORDA_WP_LOWER_L					"rex_ai_orda_wp_lower_l"
#define ORDA_WP_LOWER_R					"rex_ai_orda_wp_lower_r"
#define ORDA_HEALTHBAR_ENABLED				true
#define ORDA_DISINTEGRATION_LENGTH			6
#define ORDA_GROWL_INTERVAL_MIN 			10
#define ORDA_GROWL_INTERVAL_MAX 			20
#define ORDA_ATTACK_DISTANCE_INITIAL			300
#define ORDA_ATTACK_DISTANCE_MIN			300
#define ORDA_ATTACK_DISTANCE_MAX			400
#define ORDA_ATTACK_COOLDOWN_MIN			1
#define ORDA_ATTACK_COOLDOWN_MAX			2
#define ORDA_INFLICTOR_INTERVAL_MIN			8
#define ORDA_INFLICTOR_INTERVAL_MAX			16
#define ORDA_SPECIAL_COOLDOWN_MIN			10
#define ORDA_SPECIAL_COOLDOWN_MAX   			20
#define ORDA_KNOCKBACK_DAMAGE				250
#define ORDA_KNOCKBACK_STRENGTH				950
#define ORDA_KNOCKBACK_LERP				7.5
#define ORDA_TARGET_DISTANCE				2000 // 1800
#define ORDA_RUMBLE_RADIUS				1000
#define ORDA_RUMBLE_LENGTH				0.35
#define ORDA_KNOCKBACK_RANGE				1000
#define ORDA_ATTACK_DAMAGE				75
#define ORDA_HEAL_HEALTH_REQUIREMENT			0.85 // reqhealth / maxhealth
#define ORDA_HEAL_COUNTER_REQUIREMENT			17500
#define ORDA_HEAL_INCREMENT				7500
#define ORDA_HEALTH_BAR_RADIUS				2500 // 1850
#define ORDA_HEALTH 					350000 // 500000-750000
#define ORDA_NAME					"ORDA"

#define WASP_ATTACK_FX					"REX/ai/orda/wasp_attack"
#define WASP_TRAIL_FX					"REX/ai/orda/wasp_trail"
#define WASP_DEATH_FX					"REX/ai/orda/wasp_death"
#define WASP_MODEL					"rex_ai_orda_wasp"
#define WASP_NEARGOAL_NOTIFY				30
#define WASP_ROAM_LENGTH_MIN				10
#define WASP_ROAM_LENGTH_MAX				20
#define WASP_ROAM_DISTANCE				1550
#define WASP_ATTACK_DAMAGE				10
#define WASP_ATTACK_LENGTH				1.5
#define WASP_SPAWN_TIME					2.25
#define WASP_SPAWN_VELOCITY				15
#define WASP_SPAWN_COOLDOWN				1
#define WASP_HEALTH					350
#define WASP_SPAWN_INCREMENT				4
#define WASP_SPAWN_MAX					6

#define HELLHOUND_IMPACT_FX				"REX/ai/orda/hellhound_impact"
#define HELLHOUND_TRAIL_FX				"REX/ai/orda/hellhound_body"
#define HELLHOUND_FIRE_FX				"REX/ai/orda/hellhound_fire"
#define HELLHOUND_HEALTH				500
#define HELLHOUND_SPAWN_MIN				7
#define HELLHOUND_SPAWN_MAX				10
#define HELLHOUND_ATTACK_DAMAGE				5
#define HELLHOUND_DAMAGE_INCREMENT_MIN			4
#define HELLHOUND_DAMAGE_INCREMENT_MAX			9
#define HELLHOUND_FIRE_LIFETIME_MIN			3
#define HELLHOUND_FIRE_LIFETIME_MAX 			6
#define HELLHOUND_HIT_RADIUS_MIN			25
#define HELLHOUND_HIT_RADIUS_MAX			175
#define HELLHOUND_FIRE_RADIUS				128

#define HELLHOUND_VEHICLE				"spawner_rex_orda_hellhound"
#define WASP_VEHICLE					"spawner_rex_orda_wasp"
#define ARCHETYPE_ORDA_HELLHOUND 			"rex_orda_hellhound"
#define ARCHETYPE_ORDA_WASP 				"rex_orda_wasp"
#define ARCHETYPE_ORDA 					"rex_orda"

#define SQUARED(x)					( x * x )

#precache( "vehicle", 		HELLHOUND_VEHICLE );
#precache( "vehicle", 		WASP_VEHICLE );
#precache( "fx", 		WASP_ATTACK_FX );
#precache( "fx",		WASP_TRAIL_FX );
#precache( "fx",		WASP_DEATH_FX );
#precache( "fx",		HELLHOUND_IMPACT_FX );
#precache( "fx",		HELLHOUND_TRAIL_FX );
#precache( "fx",		HELLHOUND_FIRE_FX );
#precache( "fx",	 	ORDA_ZOMBIE_SUMMON_TRAIL_FX );
#precache( "fx",	 	ORDA_ZOMBIE_SUMMON_IMPACT_FX );
#precache( "fx", 		ORDA_HEAL_ARM_FX );
#precache( "fx", 		ORDA_SPAWN_FX );
#precache( "fx", 		ORDA_IMPACT_FX );
#precache( "xmodel", 		ORDA_WP_UPPER );
#precache( "xmodel",		ORDA_WP_TORSO );
#precache( "xmodel", 		ORDA_WP_LOWER_L );
#precache( "xmodel", 		ORDA_WP_LOWER_R );
#precache( "xmodel",		WASP_MODEL );

#using_animtree( "generic" );

#namespace rex_orda_ai;

REGISTER_SYSTEM( "rex_orda", &__init__, undefined )

function __init__()
{
	// HEALTHBAR
	clientfield::register( "clientuimodel", "hudItems.CWBossHealthBar", VERSION_SHIP, 1, "int" );
	clientfield::register( "clientuimodel", "hudItems.CWBossHealth", VERSION_SHIP, 20, "float" );

	// DISENTEGRATION
	clientfield::register( "actor", "orda_disintegrate", 12000, 1, "int" );
	clientfield::register( "vehicle", "orda_disintegrate", 12000, 1, "int" );

	// HEAL
	clientfield::register( "scriptmover", "orda_heal", VERSION_SHIP, 1, "int" );

	// WEAKPOINT
	clientfield::register( "scriptmover", "orda_weakpoint", VERSION_SHIP, 1, "int" );

	level.orda_spawner = GetEntArray( "orda_spawner", "script_noteworthy" );

	players = GetPlayers();
	for( i = 0; i < players.size; i++ )
		players[ i ] clientfield::set_player_uimodel( "hudItems.CWBossHealthBar", 0 );

	BT_REGISTER_API( "OrdaLocomotionBehaviorCondition",			&OrdaLocomotionBehaviorCondition );
	BT_REGISTER_API( "OrdaShouldSummonDog",					&OrdaShouldSummonDog );
	BT_REGISTER_API( "OrdaTargetService",					&OrdaTargetService );
	BT_REGISTER_API( "OrdaSpawnService",					&OrdaSpawnService );
	BT_REGISTER_API( "OrdaShouldAttack",					&OrdaShouldAttack );
	BT_REGISTER_API( "OrdaShouldRoar",					&OrdaShouldRoar );
	BT_REGISTER_API( "OrdaShouldHeal",					&OrdaShouldHeal );

	spawner::add_archetype_spawn_function( ARCHETYPE_ORDA, &OrdaInit );

	level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_ORDA, true, true, true );
	level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_ORDA, true, true, true );
	level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_ORDA, true, true, true );
	level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_ORDA, true, true, true );
	level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_ORDA, true, true, true );
	
	level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_ORDA_WASP, true, true, true );
	level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_ORDA_WASP, true, true, true );
	level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_ORDA_WASP, true, true, true );
	level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_ORDA_WASP, true, true, true );
	level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_ORDA_WASP, true, true, true );

	level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_ORDA_HELLHOUND, true, true, true );
	level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_ORDA_HELLHOUND, true, true, true );
	level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_ORDA_HELLHOUND, true, true, true );
	level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_ORDA_HELLHOUND, true, true, true );
	level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_ORDA_HELLHOUND, true, true, true );

	level.ai_debug = false;
}

function autoexec init()
{
	callback::on_connect( &on_player_connect );
}

function on_player_connect()
{
	util::registerClientSys( "CWBossName" );
	self util::setClientSysState( "CWBossName", "" );
}

function OrdaInit()
{
	self.health = Int( ORDA_HEALTH + ( ORDA_HEALTH * ( 0.125 * level.round_number ) ) );
	self.maxhealth = self.health;

	self.increment_heal = Int( ORDA_HEAL_INCREMENT + ( ORDA_HEAL_INCREMENT * ( 0.01 * level.round_number ) ) );
	
	if( ORDA_HEALTHBAR_ENABLED )
	{
		players = GetPlayers();
		for( i = 0; i < players.size; i++ )
		{
			players[ i ] util::setClientSysState( "CWBossName", MakeLocalizedString( ORDA_NAME ), players[ i ] );
			players[ i ] clientfield::set_player_uimodel( "hudItems.CWBossHealth", ( self.health / self.maxhealth ) );
		}
		self thread HandleUIRadius();
	}

	self.is_spawning = false;

	self HandleSpawning();

	self.orda_move_type = "walk";

	BB_REGISTER_ATTRIBUTE( "_rex_orda_locomotion_type", self.orda_move_type, &OrdaMoveType );

	Blackboard::CreateBlackBoardForEntity( self );
	
	ai::CreateInterfaceForEntity( self );

	self AiUtility::RegisterUtilityBlackboardAttributes();

	self zm_spawner::zombie_setup_attack_properties();

	//self thread zm_audio::zmbAIVox_NotifyConvert();

	self flag::init( "orda_is_attacking" );
	self flag::init( "orda_can_increment" );
	self flag::init( "orda_is_healing" );
	self flag::init( "orda_can_damage" );

	self DisableAimAssist();
	self PushPlayer( true );
	self PushActors( false );
	self BloodImpact( "none" );
	self SetPhysParams( 64, 0, 400 );
	
	level.orda_specials = array( "summon", "roar" );

	level.orda_attack_distance = ORDA_ATTACK_DISTANCE_INITIAL;

	self.thundergun_fling_func = &FlingOverride;

	self.ignore_nuke = true;
	self.ignore_enemy_count = true;
	self.ignoreragdoll = true;
	self.skipautoragdoll = true;
	self.ignorebulletdamage = true;
	self.ignoretriggerdamage = true;
	self.ignore_round_robbin_death = true;
	self.forcemovementscriptstate = false;
	self.b_ignore_cleanup = true;
	//self.cant_melee = 1;
	self.allowpain = 0;
	self.has_legs = 1;
	self.no_gib = 1;
	self.is_summoning_dog = false;
	self.is_roaming = false;
	self.is_healing = false;
	self.is_roaring = false;
	self.can_attack = false;
	self.wasps_count = 0;
	self.weakpoints = [];
	self.zombies = [];
	self.wasps = [];
	
	self.attackdamage = ORDA_ATTACK_DAMAGE;
	self.attack_cooling_down = false;

	self.heal_counterdamage = 0;
	self.inflictor_interval = undefined;
		
	if( ORDA_ZOMBIE_CRUSH_ENABLED )
		self thread HandleZombieCrush();

	self thread SetupWeakpoints();
	self thread WatchDeath();
	self thread HandleChase();
	self thread HandleHeal();
	self thread HandleGrowl();
	self thread HandleRoaming();
	self thread HandleSummonDog();
	self thread HandleSpecialEvents();
	self thread HandleSummonZombie();
	self thread HandleKnockback();
	self thread HandleRoar();
	self thread HandleStepRumble();
	self thread HandlePlayerDamage();
	self thread CheckIsAttacking();
	self thread UpdateHealTickInterval();
	self thread CheckHealFlags();
}

function FlingOverride( player )
{
	return -1;
}

function HandleUIRadius()
{
	while( isdefined( self ) )
	{
		WAIT_SERVER_FRAME;

		players = GetPlayers();
		for( i = 0; i < players.size; i++ )
		{
			players[ i ] clientfield::set_player_uimodel( "hudItems.CWBossHealthBar", ( ( IsAlive( self ) && Distance( players[ i ].origin, self.origin ) <= ORDA_HEALTH_BAR_RADIUS ) ? 1 : 0 ) );
		}
	}
}

function SetupWeakpoints()
{
	v_origin = VectorLerp( self GetTagOrigin( "xstring_32cfe6f86361d79" ), self GetTagOrigin( "xstring_32d026f86362445" ), 0.5 );
	self.weakpoint_fx = util::spawn_model( "tag_origin", v_origin );
	self.weakpoint_fx LinkTo( self, "xstring_a18b602cd6b0f65" );

	upper = util::spawn_model( ORDA_WP_UPPER, self GetTagOrigin( "j_weakpoint" ), self GetTagAngles( "j_weakpoint" ) );
	upper LinkTo( self, "j_weakpoint" );

	torso = util::spawn_model( ORDA_WP_TORSO, self GetTagOrigin( "j_spineupper" ), self GetTagAngles( "j_spineupper" ) );
	torso LinkTo( self, "j_spineupper" );

	lower_ru = util::spawn_model( ORDA_WP_LOWER_R, self GetTagOrigin( "j_hip_ri" ), self GetTagAngles( "j_hip_ri" ) );
	lower_ru LinkTo( self, "j_hip_ri" );

	lower_rl = util::spawn_model( ORDA_WP_LOWER_R, self GetTagOrigin( "j_knee_ri" ), self GetTagAngles( "j_knee_ri" ) );
	lower_rl LinkTo( self, "j_knee_ri" );

	lower_lu = util::spawn_model( ORDA_WP_LOWER_L, self GetTagOrigin( "j_hip_le" ), self GetTagAngles( "j_hip_le" ) );
	lower_lu LinkTo( self, "j_hip_le" );
	
	lower_ll = util::spawn_model( ORDA_WP_LOWER_L, self GetTagOrigin( "j_knee_le" ), self GetTagAngles( "j_knee_le" ) );
	lower_ll LinkTo( self, "j_knee_le" );
	
	self.weakpoints[ self.weakpoints.size ] = upper;
	self.weakpoints[ self.weakpoints.size ] = torso;
	self.weakpoints[ self.weakpoints.size ] = lower_ru;
	self.weakpoints[ self.weakpoints.size ] = lower_rl;
	self.weakpoints[ self.weakpoints.size ] = lower_lu;
	self.weakpoints[ self.weakpoints.size ] = lower_ll;

	self thread HandleWeakpoint();
	
	array::thread_all( self.weakpoints, &WeakpointWatchDamage, self );

	self waittill( "death" );

	self.weakpoint_fx Delete();
	array::run_all( self.weakpoints, &Delete );
}

function WeakpointWatchDamage( entity )
{
	entity endon( "death" );

	self.is_exposed = false;

	self SetCanDamage( 1 );

	while( 1 )
	{
		self waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		
		if( entity.is_spawning )
			continue;

		attacker ShowHitMarker();
		
		n_damage = damage;
		n_damage = ( ( isdefined( self.is_exposed ) && self.is_exposed ) ? ( n_damage * 2 ) : n_damage );
		
		if( entity.is_roaming )
			entity notify( "roam_interrupted" );
		if( entity.is_healing && entity flag::get( "orda_can_increment" ) )
			entity.heal_counterdamage += n_damage;
		entity.inflictor_interval = ( ( entity.is_healing && ( entity.heal_counterdamage < ORDA_HEAL_COUNTER_REQUIREMENT ) ) ? entity.inflictor_interval : ( GetTime() + ( ( RandomIntRange( ORDA_INFLICTOR_INTERVAL_MIN, ORDA_INFLICTOR_INTERVAL_MAX ) ) * 1000 ) ) );

		entity DoDamage( n_damage, entity.origin );

		if( ORDA_HEALTHBAR_ENABLED )
		{
			players = GetPlayers();
			for( i = 0; i < players.size; i++ )
				players[ i ] clientfield::set_player_uimodel( "hudItems.CWBossHealth", ( entity.health / entity.maxhealth ) );
		}
	}
}

function HandleWeakpoint()
{
	self endon( "death" );

	for( ;; )
	{
		WAIT_SERVER_FRAME;

		self.weakpoint_fx clientfield::set( "orda_weakpoint", ( ( self.is_roaring ) ? 1 : 0 ) );
	}
}

function HandleChase()
{
	self endon( "death" );

	for( ;; )
	{
		WAIT_SERVER_FRAME;

		while( self.is_healing )
			WAIT_SERVER_FRAME;

		if( DistanceSquared( self.favoriteenemy.origin, self.origin ) < SQUARED( 1000 ) )
		{
			self.orda_move_type = "run";

			result = self WaittillAnyTimeout( RandomIntRange( 10, 15 ), "swipe_start", "stomp_start", "slam_start", "summon_start", "roar_start", "heal_start", "heal_done" );

			if( IS_EQUAL( result, "heal_start" ) || IS_EQUAL( result, "heal_done" ) )
				continue;
		}
		self.orda_move_type = "walk";
	}
}

function WatchDeath()
{
	self waittill( "death", attacker );
	
	self StopLoopSound( RandomFloatRange( 0.5, 1 ) );

	self StopSound( "rex_ai_orda_roar" );

	self NotSolid();

	if( ORDA_HEALTHBAR_ENABLED )
	{
		players = GetPlayers();
		for( i = 0; i < players.size; i++ )
			players[ i ] util::setClientSysState( "CWBossName", "", players[ i ] );
		array::thread_all( players, &clientfield::set_player_uimodel, "hudItems.CWBossHealth", 0 );
		array::thread_all( players, &clientfield::set_player_uimodel, "hudItems.CWBossHealthBar", 0 );
	}
	if( self.wasps.size > 0 || self.wasps != [] )
	{
		for( i = 0; i < self.wasps.size; i++ )
		{
			self.wasps[ i ].fx Delete();
			self.wasps[ i ] Delete();
		}
	}
	if( self.zombies.size > 0 || self.zombies != [] )
	{
		for( i = 0; i < self.zombies.size; i++ )
		{
			self.zombies[ i ] Kill();
		}
	}
	self waittill( "start_disintegrate" );

	self thread HandleDisintegrate();
}

function HandleSpawning()
{
	self.is_spawning = true;

	self.spawn_fx = util::spawn_model( "tag_origin", self GetTagOrigin( "j_mainroot" ) );
	self.spawn_fx LinkTo( self, "j_mainroot" );

	PlayFXOnTag( ORDA_SPAWN_FX, self.spawn_fx, "tag_origin" );

	self waittill( "spawn_done" );

	self.spawn_fx Unlink();
	self.spawn_fx Delete();

	self.is_spawning = false;
}

function OrdaSpawnService( entity )
{
	return entity.is_spawning;
}

function OrdaLocomotionBehaviorCondition( entity )
{	
	if( entity.is_healing || entity flag::get( "orda_is_healing" ) )
		return false;
	if( entity flag::get( "orda_is_attacking" ) )
		return false;
	if( entity.is_spawning )
		return false;
	if( !entity HasPath() )
		return false;
	return true;
}

function OrdaMoveType()
{
	return self.orda_move_type;
}

function HandleRoaming()
{
    self endon( "death" );
	
	self thread WatchRoaming();

    while( 1 )
    {
        WAIT_SERVER_FRAME;
        
		while( self.is_spawning || self.is_healing || self flag::get( "orda_is_healing" ) )
			WAIT_SERVER_FRAME;

        if( !isdefined( self.favoriteenemy ) )
        {
		queryResult = PositionQuery_Source_Navigation( ( self.origin + vectorscale( AnglesToForward( self.angles ), 250 ) ), 750, 1250, 250, 50, self );
		roam_loc = array::random( queryResult.data );
		if( !self CanPath( self.origin, roam_loc.origin ) ) 
			continue;

		a_players = self GetAlivePlayers();
		if( !IS_EQUAL( a_players, 0 ) )
			for( i = 0; i < a_players.size; i++ )
				if( DistanceSquared( a_players[ i ].origin, self.origin ) <= SQUARED( ORDA_TARGET_DISTANCE ) )
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
			IPrintLnBold( ( ( level.ai_debug ) ? "GOAL REACHED" : undefined ) );
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
	    self util::waittill_any( "swipe_done", "stomp_done", "slam_done" );

	    self flag::clear( "orda_is_attacking" );

			IPrintLnBold( ( ( level.ai_debug ) ? "ATTACK DONE!" : undefined ) );

			self.attack_cooling_down = true;
			wait( RandomIntRange( ORDA_ATTACK_COOLDOWN_MIN, ORDA_ATTACK_COOLDOWN_MAX + 1 ) );
			self.attack_cooling_down = false;

			level.orda_attack_distance = RandomIntRange( ORDA_ATTACK_DISTANCE_MIN, ORDA_ATTACK_DISTANCE_MAX + 1 );
        }
	}
}

function OrdaShouldAttack( entity )
{	
	if( entity flag::get( "orda_is_attacking" ) )
		return true;
	if( entity.is_spawning )
	{
		entity.can_attack = false;
		return false;
	}
	if( entity.is_healing )
	{
		entity.can_attack = false;
		return false;
	}
	if( entity.attack_cooling_down )
	{
		entity.can_attack = false;
		return false;
	}
	if( !isdefined( entity.favoriteenemy ) )
    {
		entity.can_attack = false;
		return false;
	}
	if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > SQUARED( level.orda_attack_distance ) )
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
	entity flag::set( "orda_is_attacking" );
	entity.can_attack = true;
	return true;
}

function OrdaTargetService( entity )
{
	if( IS_TRUE( entity.ignoreall ) )
		return false; 
	if( entity.is_spawning )
		return false;
	if( entity.is_summoning_dog )
		return false;
	if( entity.is_healing || entity flag::get( "orda_is_healing" ) )
		return false;

	closest_player = ArrayGetClosest( entity.origin, entity GetAlivePlayers() );
	player = ( ( !isdefined( entity.favoriteenemy ) || !IS_EQUAL( entity.favoriteenemy, closest_player ) ) ? ( ( !IS_EQUAL( entity GetAlivePlayers().size, 0 ) ) ? closest_player : undefined ) : ( ( DistanceSquared( entity.favoriteenemy.origin, entity.origin ) > SQUARED( ORDA_TARGET_DISTANCE ) ) ? undefined : entity.favoriteenemy ) );
	
	if( !isdefined( entity.v_zombie_custom_goal ) )
	{
		entity.favoriteenemy = player;
		
		targetPos = GetClosestPointOnNavMesh( entity.favoriteenemy.origin, 750, 128 );
		if( isdefined( targetPos ) )
		{	
			entity GetPerfectInfo( entity.favoriteenemy );
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
		targetPos = GetClosestPointOnNavMesh( entity.v_zombie_custom_goal, 750, 128 );
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

function HandleSpecialEvents()
{
	self endon( "death" );

	while( 1 )
	{
		while( isdefined( self.current_special ) )
			WAIT_SERVER_FRAME;

		wait( RandomIntRange( ORDA_SPECIAL_COOLDOWN_MIN, ORDA_SPECIAL_COOLDOWN_MAX + 1 ) );

		self.current_special = ( ( !isdefined( self.current_special ) ) ? level.orda_specials[ RandomInt( level.orda_specials.size ) ] : self.current_special );
	}
}

function HandleSummonDog()
{
	self endon( "death" );

	while( 1 )
	{
		WAIT_SERVER_FRAME;

		while( self.is_healing || self flag::get( "orda_is_healing" ) )
			WAIT_SERVER_FRAME;

		if( self.current_special == "summon" )
		{
			if( self flag::get( "orda_is_attacking" ) || self.is_roaring || self.is_spawning )
				continue;

			IPrintLnBold( ( ( level.ai_debug ) ? "summon" : undefined ) );

			self.is_summoning_dog = true;

			shot_count = RandomIntRange( HELLHOUND_SPAWN_MIN, HELLHOUND_SPAWN_MAX + 1 );
			
			for( i = 0; i < shot_count; i++ )
			{
				a_players = self GetAlivePlayers();
				if( IS_EQUAL( a_players.size, 0 ) )
					continue;

				self.specialenemy = ( ( !isdefined( self.specialenemy ) && isdefined( self.favoriteenemy ) ) ? self.favoriteenemy : self.specialenemy );

				player = ( IsTargetable( self.specialenemy ) ? self.specialenemy : array::random( a_players ) );

				if( isdefined( player ) )
				{
					self util::waittill_any_timeout( 10, "summon_shot" );

					hitpos = undefined;
					while( !isdefined( hitpos ) )
					{
						WAIT_SERVER_FRAME;

						queryResult = array::random( array::randomize( PositionQuery_Source_Navigation( player.origin, HELLHOUND_HIT_RADIUS_MIN, HELLHOUND_HIT_RADIUS_MAX, 45, 15, self ).data ) );
						hitpos = ( ( IsPointOnNavMesh( queryResult.origin ) ) ? queryResult : undefined );
					}
					dog_node = util::spawn_model( "tag_origin", self GetTagOrigin( "xstring_a3853ddc44e5503" ) + vectorscale( AnglesToForward( self GetTagAngles( "xstring_a3853ddc44e5503" ) ), 100 ) , AnglesToForward( player.angles ) * -1 );

					dog_node thread WatchSummonDog( self, hitpos );
					dog_node zm_utility::fake_physicslaunch( hitpos.origin, RandomIntRange( 650, 950 ) );
					self util::waittill_any_timeout( 10, "summon_shot_done" );
				}
			}
			self.specialenemy = undefined;
			self.current_special = undefined;
			self.is_summoning_dog = false;
		}
	}
}

function SetupSummonedDog( entity, node )
{
	self UseAnimTree( #animtree );
	
	blackboard::CreateBlackBoardForEntity( self );
	self Blackboard::RegisterVehicleBlackBoardAttributes();
	ai::CreateInterfaceForEntity( self );

	self.vehAirCraftCollisionEnabled = true;
	self.fovcosinebusy = 0;
	self.fovcosine = 0;
	self.solid = true;

	self.health = HELLHOUND_HEALTH;
	self.maxhealth = self.health;
	self.attackdamage = HELLHOUND_ATTACK_DAMAGE;

	self.overrideVehicleDamage = &DogDamageCallback;

	self ClearVehGoalPos();
	self SetVehicleAvoidance( true );
	self SetNearGoalNotifyDist( 35 );
	self LookAtEntity( entity.favoriteenemy );
	
	self thread vehicle_ai::nudge_collision();
	self thread animation::play( "rex_ai_orda_hellhound_fall_01" );

	self.fx = util::spawn_model( "tag_origin", self GetTagOrigin( "j_mainroot" ), self.angles );
	self.fx LinkTo( self, "j_mainroot" );

	PlayFXOnTag( HELLHOUND_TRAIL_FX, self.fx, "tag_origin" );

	self LinkTo( node );
}

function DogDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, damageOrigin, offsetTime, damageUnderneath, modelIndex, partName, vSurfaceNormal )
{
	damage = vehicle_ai::shared_callback_damage( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, damageOrigin, offsetTime, damageUnderneath, modelIndex, partName, vSurfaceNormal );

	return damage;
}

function DogDeathCallback( entity )
{
	self waittill( "death" );

	self StopLoopSound( RandomFloatRange( 0.75, 1.5 ) );
	self PlaySound( "rex_ai_orda_summon_impact" );

	forward = AnglesToForward( self.angles );
	up = AnglesToUp( self.angles );

	PlayFX( HELLHOUND_IMPACT_FX, self.origin, forward, up );
	
	entity.fx Delete();
	entity Delete();
	self Delete();
}

function WatchSummonDog( entity, hitpos )
{
	dog = SpawnVehicle( "spawner_rex_orda_hellhound", self.origin, entity.angles, "orda_hellhound" );
	dog SetupSummonedDog( entity, self );
	dog thread DogDeathCallback( self );

	dog PlayLoopSound( "rex_ai_orda_summon_ambient" );
	
	self DogCheckMovement();

	if( isdefined( dog ) )
	{
		hitpoint = util::spawn_model( "tag_origin", ( hitpos.origin + vectorscale( ( 0, 0, 1 ), 10 ) ), ( 0, 0, 0 ) );
		hitpoint thread DogHandleImpact( entity );

		dog notify( "death" );
	}
}

function DogCheckMovement()
{
	self endon( "death" );

    prevorigin = self.origin;
	while( 1 )
	{
		wait( 0.15 );

		if( self.origin == prevorigin )
			break;
		prevorigin = self.origin;
	}
}

function DogHandleImpact( entity )
{
	if( !isdefined( entity ) )
		return;

	PlayFXOnTag( HELLHOUND_FIRE_FX, self, "tag_origin" );

	array::thread_all( GetPlayers(), &DogHandleImpactDamage, self, HELLHOUND_FIRE_RADIUS );

	wait( RandomIntRange( HELLHOUND_FIRE_LIFETIME_MIN, HELLHOUND_FIRE_LIFETIME_MAX + 1 ) );

	self Delete();
}

function DogHandleImpactDamage( hitpoint, radius )
{
	next_hit = GetTime();

	while( isdefined( hitpoint ) )
	{
		WAIT_SERVER_FRAME;

		if( GetTime() < next_hit )
			continue;

		if( Distance( self.origin, hitpoint.origin ) <= radius )
		{
			damage_tick = RandomIntRange( HELLHOUND_DAMAGE_INCREMENT_MIN, HELLHOUND_DAMAGE_INCREMENT_MAX + 1 );
			self thread PlayerFireTick( HELLHOUND_ATTACK_DAMAGE, damage_tick, 0.75 );
			next_hit = ( GetTime() + ( ( damage_tick / 2 ) * 1000 ) );
		}
	}
}

function PlayerFireTick( damage, ticks, interval = 1 )
{
	self burnplayer::SetPlayerBurning( ticks, 1 );

	for( i = 0; i < ticks; i++ )
	{
		self DoDamage( damage, self.origin );

		wait( interval );
	}
}

function OrdaShouldSummonDog( entity )
{
	return ( entity.is_summoning_dog && !( entity.is_spawning || entity.is_healing || entity flag::get( "orda_can_increment" ) ) );
}

function HandleSummonZombie()
{
	self endon( "death" );

	while( 1 )
	{
		WAIT_SERVER_FRAME;

		while( self.is_spawning || self.is_healing || self flag::get( "orda_is_healing" ) )
			WAIT_SERVER_FRAME;

		self util::waittill_any_timeout( RandomIntRange( ORDA_ZOMBIE_SUMMON_COOLDOWN_MIN, ORDA_ZOMBIE_SUMMON_COOLDOWN_MAX ), "summon_zombies" );

		spawn_count = RandomIntRange( ORDA_ZOMBIE_SUMMON_MIN, ORDA_ZOMBIE_SUMMON_MAX + 1 );
		for( i = 0; i < spawn_count; i++ )
		{
			if( self.zombies.size >= ORDA_ZOMBIE_MAX )
				continue;

			hitpos = undefined;
			while( !isdefined( hitpos ) )
			{
				wait( 0.01 );

				queryResult = PositionQuery_Source_Navigation( ( ( isdefined( self.favoriteenemy ) ) ? self.favoriteenemy.origin : self.origin ), 150, 550, 50, 25, self );
				spawn_loc = array::random( queryResult.data );

				if( !IsPointOnNavMesh( spawn_loc.origin ) )
					continue;
				hitpos = spawn_loc;
			}
			loc = util::spawn_model( "tag_origin", self GetTagOrigin( "j_neck" ), ( 0, 0, 0 ) );
			loc.script_string = "find_flesh";

			PlayFXOnTag( ORDA_ZOMBIE_SUMMON_TRAIL_FX, loc, "tag_origin" );

			loc zm_utility::fake_physicslaunch( spawn_loc.origin, RandomIntRange( 750, 1250 ) );
			loc thread WatchSummonZombie( self, spawn_loc );
			
			wait( RandomFloatRange( 0.25, 0.5 ) );
		}
	}
}

function WatchSummonZombie( entity, hitpos )
{
	self zm_utility::waittill_not_moving();

	self.origin = ( self.origin[ 0 ], self.origin[ 1 ], hitpos.origin[ 2 ] );

	forward = ( ( !IS_EQUAL( GetAlivePlayers().size, 0 ) ) ? ( AnglesToForward( VectortoAngles( self.origin - ArrayGetClosest( self.origin, GetAlivePlayers() ).origin ) ) * -1 ) : undefined );
	up = AnglesToUp( self.angles );

	PlayFX( ORDA_ZOMBIE_SUMMON_IMPACT_FX, self.origin, forward, up );

	spawner = GetEntArray( "zombie_spawner", "script_noteworthy" );
	zombie = zombie_utility::spawn_zombie( spawner[ 0 ], "zombie", self );

	entity.zombies[ entity.zombies.size ] = zombie;

	zombie zm_spawner::do_zombie_rise( self );

	zombie thread WatchZombieDeath( entity );
	zombie thread ConfigureZombie( entity );
	zombie thread ZombieTargetService();

	result = zombie util::waittill_any_timeout( 10, "risen", "death" );

	IPrintLnBold( ( ( level.ai_debug ) ? ( "^2ZOMBIES: " + entity.zombies.size ) : undefined ) );

	self Delete();
}

function ConfigureZombie( entity )
{
	self.ignore_enemy_count = true;

	zombie_utility::ai_calculate_health( level.round_number );
	self.health = ( level.zombie_health * ORDA_ZOMBIE_HEALTH_INCREMENT );
	self.maxhealth = self.health;
	
	self zombie_utility::set_zombie_run_cycle( array::random( array( "sprint", "super_sprint" ) ) );
	
	self ASMSetAnimationRate( ORDA_ZOMBIE_SPEED );
	self SetMoveSpeedScale( ORDA_ZOMBIE_SPEED );
	self PushActors( false );
}

function ZombieTargetService()
{
	while( IsAlive( self ) )
	{
		WAIT_SERVER_FRAME;

		player = ( ( !IS_EQUAL( self GetAlivePlayers().size, 0 ) ) ? ArrayGetClosest( self.origin, self GetAlivePlayers() ) : undefined );
		
		while( self IsTargetable( player ) )
		{
			WAIT_SERVER_FRAME;

			self.v_zombie_custom_goal_pos = player.origin;
		}
		self SetGoal( self.origin );
	}
}

function WatchZombieDeath( entity )
{
	self waittill( "death" );

	ArrayRemoveValue( entity.zombies, self, false );

	IPrintLnBold( ( ( level.ai_debug ) ? ( "^1ZOMBIES: " + entity.zombies.size ) : undefined ) );
}

function HandleRoar()
{
	self endon( "death" );

	while( 1 )
	{
		WAIT_SERVER_FRAME;

		while( self.is_healing || self flag::get( "orda_is_healing" ) )
			WAIT_SERVER_FRAME;

		if( self.current_special == "roar" )
		{	
			IPrintLnBold( ( ( level.ai_debug ) ? "roar" : undefined ) );
			
			player = ( ( isdefined( self.favoriteenemy ) ) ? self.favoriteenemy : zombie_utility::get_closest_valid_player( self.origin, self.ignore_player, 1 ) );

			if( DistanceSquared( self.favoriteenemy, self.origin ) > SQUARED( ORDA_TARGET_DISTANCE ) )
				continue;

			self.is_roaring = true;
			
			self.weakpoints[ 0 ].is_exposed = true;

			if( math::cointoss() && self.wasps.size < WASP_SPAWN_MAX )
			{
				IPrintLnBold( ( ( level.ai_debug ) ? "wasps" : undefined ) );

				self waittill( "start_summon" );

				for( i = 0; i < WASP_SPAWN_INCREMENT; i++ )
				{
					n_players = GetPlayers().size;
					n_wasps = ( n_players * 2 );

					increment_spawn = ( Floor( n_wasps / 4 ) ) + ( 3 - self.wasps_count < n_wasps % 4 ? 1 : 0 );
					self.wasps_count++;

					IPrintLnBold( ( ( level.ai_debug ) ? ( ( !increment_spawn ) ? "NO WASP SPAWNING" : undefined ) : undefined ) );

					for( j = 0; j < increment_spawn; j++ )
						if( self.wasps.size < WASP_SPAWN_MAX )
							self thread SpawnWasp();
						
					wait( WASP_SPAWN_COOLDOWN );
				}
			}
			else
			{
				IPrintLnBold( ( ( level.ai_debug ) ? "zombies" : undefined ) );

				self waittill( "start_summon" );
				
				self.weakpoints[ 0 ].is_exposed = true;

				self notify( "summon_zombies" );
			}
			self waittill( "roar_done" );

			self.weakpoints[ 0 ].is_exposed = false;

			self.current_special = undefined;
			self.is_roaring = false;
		}
	}
}

function OrdaShouldRoar( entity )
{
	return ( entity.is_roaring && !( entity.is_spawning || entity.is_healing || entity flag::get( "orda_can_increment" ) ) );
}

function HandleGrowl()
{
	growl_interval = GetTime();

	while( isdefined( self ) )
	{
		WAIT_SERVER_FRAME;

		growl_interval = ( GetTime() + ( RandomIntRange( ORDA_GROWL_INTERVAL_MIN, ORDA_GROWL_INTERVAL_MAX + 1 ) * 1000 ) );

		while( GetTime() < growl_interval )
		{
			WAIT_SERVER_FRAME;

			if( self.is_spawning || self.is_healing || self.is_summoning_dog || self.is_roaring )
			{
				growl_interval = ( GetTime() + ( RandomIntRange( ORDA_GROWL_INTERVAL_MIN, ORDA_GROWL_INTERVAL_MAX + 1 ) * 1000 ) );
				
				continue;
			}
		}
		self PlaySound( "rex_ai_orda_growl" );
	}
}

function HandleKnockback()
{
	self endon( "death" );

	while( 1 )
	{
		self util::waittill_any( "orda_slam", "orda_stomp" );

		players = GetPlayers();
		for( i = 0; i < players.size; i++ )
		{
			IPrintLnBold( ( ( level.ai_debug ) ? ( ( ORDA_KNOCKBACK_RANGE / ( Distance( players[ i ].origin, self.origin ) ) ) / 2 ) : undefined ) );
			Earthquake( ( ( ORDA_KNOCKBACK_RANGE / ( Distance( players[ i ].origin, self.origin ) ) ) / 2 ), ORDA_RUMBLE_LENGTH, self.origin, ORDA_KNOCKBACK_RANGE );
			if( DistanceSquared( players[ i ].origin, self.origin ) < SQUARED( ORDA_KNOCKBACK_RANGE ) )
			{
				players[ i ] DoDamage( self.attackdamage, players[ i ].origin );
				players[ i ] thread HandlePlayerKnockback( self );
			}
		}
	}
}

function HandlePlayerKnockback( entity )
{
	for( i = 0; i < ( ORDA_KNOCKBACK_LERP * ( ( ORDA_KNOCKBACK_RANGE / ( Distance( entity.origin, self.origin ) ) ) / 2 ) ); i += 0.5 )
	{
		self SetVelocity( VectorNormalize( AnglesToForward( VectortoAngles( entity.origin - self.origin ) ) * -1 ) * ORDA_KNOCKBACK_STRENGTH );
			wait( 0.01 );
	}
}

function HandlePlayerDamage()
{
	self endon( "death" );

	self thread WatchPlayerDamage();

	while( 1 )
	{
		self waittill( "swipe_start" );

		self flag::set( "orda_can_damage" );

		self waittill( "swipe_done" );

		self flag::clear( "orda_can_damage" );
	}
}

function WatchPlayerDamage()
{
	self endon( "death" );

	while( 1 )
	{
		WAIT_SERVER_FRAME;

		if( self flag::get( "orda_can_damage" ) )
		{
			players = GetAlivePlayers();
			for( i = 0; i < players.size; i++ )
			{
				if( !isdefined( players[ i ].last_swipe ) )
					players[ i ].last_swipe = GetTime();

				if( DistanceSquared( players[ i ].origin, ( self GetTagOrigin( "xstring_7fcbe4da452b335" ) ) ) < SQUARED( 250 ) )
				{
					if( GetTime() > players[ i ].last_swipe )
					{
						players[ i ].last_swipe = ( GetTime() + 2500 );
						players[ i ] DoDamage( ( self.attackdamage / 2 ), players[ i ].origin );
					}
				}
			}
		}
	}
}

function HandleStepRumble()
{
	self endon( "death" );

	while( 1 )
	{
		self waittill( "orda_step", tag );

		PlayFXOnTag( ORDA_IMPACT_FX, self, tag );
		
		players = GetPlayers();
		for( i = 0; i < players.size; i++ )
		{	
			players[ i ] IPrintLnBold( ( ( level.ai_debug ) ? ( ( ORDA_RUMBLE_RADIUS / ( Distance( players[ i ].origin, self.origin ) * 3.5 ) ) / 2 ) : undefined ) );
			Earthquake( ( ( ORDA_RUMBLE_RADIUS / ( Distance( self.favoriteenemy.origin, self.origin ) * 3.5 ) ) / 2 ), ORDA_RUMBLE_LENGTH, self.origin, ORDA_RUMBLE_RADIUS );
		}
	}
}

function HandleZombieCrush()
{
	self endon( "death" );

	while( 1 )
	{
		WAIT_SERVER_FRAME;

		self util::waittill_any( "orda_step", "orda_slam", "orda_stomp" );

		a_zombies = GetAIArchetypeArray( "zombie", "all" );
		for( i = 0; i < a_zombies.size; i++ )
		{
			if( DistanceSquared( a_zombies[ i ].origin, self.origin ) < SQUARED( ORDA_ZOMBIE_CRUSH_DIST ) )
			{
				if( array::contains( self.zombies, a_zombies[ i ] ) )
				{
					ArrayRemoveValue( self.zombies, a_zombies[ i ], false );
				}
				a_zombies[ i ] Kill();
			}
		}
	}
}

function CheckHealFlags()
{
	while( 1 )
	{
		WAIT_SERVER_FRAME;

		if( !self.is_healing )
			continue;

		self flag::set( "orda_is_healing" );

		self waittill( "heal_done" );

		self.heal_fx clientfield::set( "orda_heal", 0 );
		self.heal_fx Delete();

		self flag::clear( "orda_is_healing" );
		self flag::clear( "orda_can_increment" );
	}
}

function UpdateHealTickInterval()
{
	self.heal_interval = ( GetTime() + 1000 );
}

function HandleHeal()
{
	self endon( "death" );

	self thread WatchHeal();
	
	while( 1 )
	{
		WAIT_SERVER_FRAME;

		self.orda_move_type = ( ( !self.is_healing ) ? self.orda_move_type : "heal" );

		while( ( self.health > ( self.maxhealth * ORDA_HEAL_HEALTH_REQUIREMENT ) ) && !self.is_healing )
			WAIT_SERVER_FRAME;

		self.is_healing = ( ( IsAlive( self ) && ( self.health < self.maxhealth ) && ( GetTime() >= self.inflictor_interval ) && !( self.is_spawning || self.is_summoning_dog || self.is_roaring ) ) );
	
		self.heal_counterdamage = ( ( !self.is_healing ) ? 0 : self.heal_counterdamage );
	}
}

function WatchHeal()
{
	self endon( "death" );

	while( 1 )
	{
		WAIT_SERVER_FRAME;
		
		if( !self.is_healing )
			continue;

		if( self flag::exists( "orda_can_increment" ) )
		{
			if( !self flag::get( "orda_can_increment" ) )
			{
				self waittill( "heal_start" );

				hfx_angles = ( VectortoAngles( self GetTagOrigin( "j_elbow_le" ) - self GetTagOrigin( "xstring_532a7b51e22d9c7" ) ) );

				self.heal_fx = util::spawn_model( "tag_origin", self GetTagOrigin( "xstring_532a7b51e22d9c7" ), ( hfx_angles + ( 90, 0, 0 ) ) );
				self.heal_fx LinkTo( self, "xstring_532a7b51e22d9c7" );
				self.heal_fx clientfield::set( "orda_heal", 1 );

				self flag::set( "orda_can_increment" );
			}
			else
			{
				if( GetTime() >= self.heal_interval )
				{
					if( self.is_healing )
					{
						if( self.health < self.maxhealth )
						{
							self.health += self.increment_heal;
							self UpdateHealTickInterval();
						}
						if( self.health >= self.maxhealth )
							self.health = self.maxhealth;

						if( ORDA_HEALTHBAR_ENABLED )
						{
							players = GetPlayers();
							for( i = 0; i < players.size; i++ )
							{
								players[ i ] clientfield::set_player_uimodel( "hudItems.CWBossHealth", ( self.health / self.maxhealth ) );
							}
						}
					}
				}
			}
		}
	}
}

function OrdaShouldHeal( entity )
{
	return ( ( entity.is_healing || entity.orda_move_type === "heal" ) );
}

function HandleDisintegrate()
{
	self endon( "death" );

	if( IS_TRUE( self.b_disintegrating ) )
		return;

	self.b_disintegrating = 1;
	self clientfield::set( "orda_disintegrate", 1 );

	wait( ORDA_DISINTEGRATION_LENGTH );

	self Ghost();
	self DoDamage( self.health, self.origin );
}

function spawn_orda( s_location )
{
	spots = struct::get_array( "orda_location", "targetname" );

	loc = ( ( isdefined( s_location ) ) ? s_location : spots[ RandomInt( spots.size ) ] );
	
	entity = zombie_utility::spawn_zombie( level.orda_spawner[ 0 ], "rex_orda", loc );
	entity PlayLoopSound( "rex_ai_orda_ambient", 0.5 );
	entity ForceTeleport( loc.origin, loc.angles );
	return entity;
}

function WaspInit( entity )
{
	blackboard::CreateBlackBoardForEntity( self );
	self Blackboard::RegisterVehicleBlackBoardAttributes();
	ai::CreateInterfaceForEntity( self );

	self.overrideVehicleDamage = &WaspDamageCallback;
	self.overridevehiclekilled = &WaspDeathCallback;
	self.vehAirCraftCollisionEnabled = true;
	self.damage_on_death = false;
	self.delete_on_death = true;
	self.fovcosinebusy = 0;
	self.fovcosine = 0;
	self.solid = true;

	self.is_roaming = false;
	self.is_revolving = false;
	self.attackdamage = WASP_ATTACK_DAMAGE;

	self.owner = entity;
	self.health = WASP_HEALTH;
	self.maxhealth = self.health;
	
	self SetVehicleAvoidance( true );
	self SetNearGoalNotifyDist( 35 );

	self thread WaspHandleLocomotion( entity );
	self thread WaspWatchOrdaDeath( entity );
	self thread WaspHandleDamage( entity );

	self thread vehicle_ai::nudge_collision();

	self vehicle_ai::call_custom_add_state_callbacks();
}

function WaspDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, damageOrigin, offsetTime, damageUnderneath, modelIndex, partName, vSurfaceNormal )
{
	damage = vehicle_ai::shared_callback_damage( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, damageOrigin, offsetTime, damageUnderneath, modelIndex, partName, vSurfaceNormal );

	return damage;
}

function WaspDeathCallback( inflictor, attacker, damage, mod, weapon, dir, hitLoc, offsetTime )
{
	PlayFX( WASP_DEATH_FX, self.origin );

	ArrayRemoveValue( self.owner.wasps, self, false );

	IPrintLnBold( ( ( level.ai_debug ) ? ( "WASPS: " + self.owner.wasps.size ) : undefined ) );
	
	self StopLoopSound( RandomFloatRange( 0.5, 1 ) );

	self CancelAIMove();
    self ClearVehGoalPos();
    self ClearLookAtEnt();
	self.fx Delete();
	self Delete();
}

function WaspWatchOrdaDeath( entity )
{
	self endon( "death" );

	entity waittill( "death" );
	
	self StopLoopSound( RandomFloatRange( 1.5, 2 ) );

	self CancelAIMove();
    self ClearVehGoalPos();
    self ClearLookAtEnt();
	self.fx Delete();
	self Delete();
}

function WaspHandleLocomotion( entity )
{
	self endon( "death" );

	self thread WaspHandleRoam( entity );
	self thread WaspHandleRevolve( entity );
	
	while( 1 )
	{
		WAIT_SERVER_FRAME;

		v_players = GetPlayers();
		c_players = ArraySortClosest( v_players, entity GetTagOrigin( "j_head" ) );
		
		for( i = 0; i < c_players.size; i++ )
		{
			if( !c_players[ i ] laststand::player_is_in_laststand() )
			{
				//if( IsSentient( entity ) && !self VehCanSee( c_players[ i ] ) )
				//	continue;
				player = ( ( isdefined( entity.favoriteenemy ) ) ? entity.favoriteenemy : c_players[ i ] );
				IPrintLnBold( ( "^5PLAYER TARGETED:^3 " + ( ( isdefined( player ) ) ? player.name : "NONE" ) ) );
			}
		}
		if( isdefined( player ) && !player laststand::player_is_in_laststand() && !self.is_roaming && !self.is_revolving )
		{
			self SetVehGoalPos( player GetEye() );
			self LookAtEntity( player );
			self.targetenemy = player;
		}
		/* else 
		{
			if( !self.is_revolving )
			{
				rand_loc = self GetRandomPointOnNavVolume();
				if( isdefined( rand_loc ) && BulletTracePassed( self.origin, rand_loc, false, undefined ) && Distance( rand_loc, self.favoriteenemy.origin ) <= WASP_ROAM_DISTANCE )
				{
					self SetVehGoalPos( rand_loc );
		
					self util::waittill_any_timeout( 5, "near_goal", "roam_interrupted" );
				}
			}
		} */
	}
}

function WaspHandleRevolve( entity )
{
	self endon( "death" );

	self thread WaspWatchRevolve( entity );

	while( 1 )
	{
		WAIT_SERVER_FRAME;

		IPrintLnBold( self.is_revolving );

		if( isdefined( self.targetenemy ) )
			continue;
		if( self.is_roaming )
			if( DistanceSquared( entity.favoriteenemy.origin, self.origin ) > SQUARED( 550 ) )
				self.revolve_time = ( GetTime() + ( 5 * 1000 ) );
		if( !isdefined( entity.favoriteenemy ) )
			self.revolve_time = ( GetTime() + ( 5 * 1000 ) );
		self.is_revolving = ( ( GetTime() > self.revolve_time ) ? false : true );
	}
}

function WaspWatchRevolve( entity )
{
	self endon( "death" );
	self.revolve_time = 0;
	self.v_dist = 60;
	while( 1 )
	{	
		WAIT_SERVER_FRAME;
		
		clockwise = 1;
		anchor = ( 0, 0, 0 );
		v_increment_angle = 0;
		e_origin = self.origin;
		self.v_dist = Min( self.v_dist, 60 );
		while( self.is_revolving )
		{
			anchor = ( ( isdefined( entity ) ) ? entity GetTagOrigin( "j_head" ) : ( 0, 0, 0 ) );
			e_origin = ( self.origin[ 0 ], self.origin[ 1 ], anchor[ 2 ] + ( Sin( v_increment_angle ) * 100 ) );
			v_increment_angle += 0.01;
			dir_to_target = VectorNormalize( anchor - e_origin );

			v_forward = -1 * dir_to_target * 150 + anchor;
			n_direction = VectorCross( dir_to_target, ( 0, 0, clockwise ) );
			target_pos = v_forward + ( n_direction * self.v_dist );

			target_pos = ( ( VectorNormalize( target_pos - self.origin ) ) * self.v_dist ) + self.origin;
			self SetVehGoalPos( target_pos );

			wait( 0.01 );
		}
	}
}

function WaspHandleDamage( entity )
{
	self endon( "death" );

	next_hit = GetTime();

	while( 1 )
	{
		WAIT_SERVER_FRAME;

		if( GetTime() < next_hit )
			continue;

		player = ( ( isdefined( self.targetenemy ) ) ? self.targetenemy : zombie_utility::get_closest_valid_player( self.origin, self.ignore_player, 1 ) );

		if( Distance( player.origin, self.origin ) <= 128 )
		{
			player thread WaspWatchDamage( self );
			next_hit = ( GetTime() + 1500 );
		}
	}
}

function WaspWatchDamage( entity )
{
	self DoDamage( entity.attackdamage, self.origin );

	fx = util::spawn_model( "tag_origin", self.origin + ( 0, 0, 50 ), self.angles );
	fx EnableLinkTo();
	fx LinkTo( self, "tag_origin" );

	PlayFXOnTag( WASP_ATTACK_FX, fx, "tag_origin" );

	wait( WASP_ATTACK_LENGTH );

	fx Delete();
}

function WaspHandleRoam( entity )
{
	self endon( "death" );

	while( 1 )
	{
		self waittill( "near_goal" );

		if( isdefined( self.targetenemy ) )
			self thread WaspWatchRoam( entity );
	}
}

function WaspWatchRoam( entity )
{
	self.targetenemy = undefined;

	self.is_roaming = true;
	self util::waittill_any_timeout( RandomIntRange( WASP_ROAM_LENGTH_MIN, WASP_ROAM_LENGTH_MAX + 1 ), "roam_interrupted" );
	self.is_roaming = false;
}

function SpawnWasp()
{
	if( !isdefined( self ) )
		return;

	origin = VectorLerp( self GetTagOrigin( "j_shoulder_le" ), self GetTagOrigin( "j_shoulder_ri" ), 0.5 );
	wasp = util::spawn_model( "tag_origin", origin, self.angles );

	PlayFXOnTag( WASP_TRAIL_FX, wasp, "tag_origin" );

	wasp PlayLoopSound( "rex_ai_orda_swarm", 0.25 );

	wasp thread WaspHandlePreSpawn( self );
}

function WaspHandlePreSpawn( entity )
{
	if( isdefined( entity ) )
	{
		origin = VectorLerp( entity GetTagOrigin( "xstring_32cfe6f86361d79" ), entity GetTagOrigin( "xstring_32d026f86362445" ), 0.5 );
		launch_dir = VectorNormalize( AnglesToForward( entity.angles ) );

		self MoveTo( self.origin + ( launch_dir * 100 ), 0.25 );
		wait( 0.25 );

		self MoveTo( self.origin + ( launch_dir * 100 ), 2, 0, 1.5 );
		wait( 2 );
	}
	self thread WaspHandlePostSpawn( entity );
}

function WaspHandlePostSpawn( entity )
{
	wasp = SpawnVehicle( WASP_VEHICLE, self.origin, self.angles, "orda_wasp" );
	wasp thread WaspInit( entity );
	
	wasp.fx = self;
	wasp.fx LinkTo( wasp );

	entity.wasps[ entity.wasps.size ] = wasp;
}

function PathToGoalSuccess( s_origin, radius, e_origin )
{
	self endon( "death" );

	if( !isdefined( e_origin ) )
		e_origin = s_origin;

	target_pos = ( ( VectorNormalize( e_origin - self.origin ) ) * self.v_dist ) + self.origin;

	if( IsVehicle( self ) )
		self SetVehGoalPos( target_pos );
	else
		self MoveTo( target_pos, 0.5 );

	result = self util::waittill_any_timeout( 0.5, "movedone", "near_goal" );
	if( result === "movedone" || result === "near_goal" )
	{
		if( result === "near_goal" )
			self ClearVehGoalPos();
		return true;
	}
	if( isdefined( radius ) && DistanceSquared( e_origin, self.origin ) < SQUARED( radius ) )
		return true;
	return false;
}

// REX UTILITIES

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

function IsTargetable( player )
{
	if( !isdefined( player ) )
		return false;
	if( !IsAlive( player ) )
		return false;
	if( player laststand::player_is_in_laststand() )
		return false;
	if( player.sessionstate === "spectator" )
		return false;
	if( player.sessionstate === "intermission" )
		return false;
	if( IS_TRUE( player.intermission ) )
		return false;
	if( isdefined( player.is_zombie ) && player.is_zombie )
		return false;
	if( !IsPointOnNavMesh( player.origin ) )
		return false;
	if( isdefined( self ) )
		if( !self CanPath( self.origin, player.origin ) )
			return false;
	return true;
}

function ShowHitMarker()
{
	if( IsPlayer( self ) )
	{
		if(isdefined( self ) && isdefined( self.hud_damagefeedback ) )
		{
			self.hud_damagefeedback SetShader( "damage_feedback", 24, 48 );
			self.hud_damagefeedback.alpha = 1;
			self.hud_damagefeedback fadeovertime( 1 );
			self.hud_damagefeedback.alpha = 0;
		}
		else if( isdefined( self ) && !isdefined( self.hud_damagefeedback ) )
		{
			self PlayHitMarker( undefined, 1, undefined, 0 );
		}
	}
}

function WaittillAnyUniversal( ... )
{
	if( StrIsNumber( vararg[ 0 ] ) ) {
		timeout = vararg[ 0 ];
		if( timeout > 0 ) 
			self thread WaittillHandle( timeout, "time" );
	}
	if( vararg.size > 1 )
	{
		for( i = ( ( StrIsNumber( vararg[ 0 ] ) ) ? 1 : 0 ); i < vararg.size; i++ ) {	
			if( IsString( vararg[ i ] ) )
				self thread WaittillHandle( vararg[ i ], "str" );
			else
				self thread WaittillHandle( vararg[ i ], "var" );
		}
	}
	else
	{
		if( IsString( vararg[ 0 ] ) )
			self thread WaittillHandle( vararg[ i ], "str" );
		else
			self thread WaittillHandle( vararg[ i ], "var" );
	}
	self waittill( "returned", str_notify );
}

function WaittillAnyTimeout( n_timeout, ... )
{
	if( !array::contains( vararg, "death" ) )
		self endon( "death" );

	ent = SpawnStruct();

	for( i = 0; i < vararg.size; i++ )
		self thread _string( vararg[ i ], ent );

	ent thread _timeout( n_timeout );

	ent waittill( "returned", str );
	return str;
}

function _string( str, ent )
{
	self waittill( str );
	ent notify( "returned", str );
}

function _timeout( delay )
{
	wait( delay );
	self notify( "returned", "timeout" );
}

function WaittillHandle( condition, type )
{
	switch( type )
	{
		case "str":
			IPrintLnBold( "string" );
			self waittill( condition );
			break;
		case "var":
			IPrintLnBold( "variable" );
			while( !condition )
				WAIT_SERVER_FRAME;
			break;
		case "time":
			IPrintLnBold( "timeout" );
			wait( condition );
			break;
	}
	self notify( "returned", type );
}

function ArraySplit( array, index )
{
	array2 = [];
	for( i = index; i < array.size; i++ )
		array2[ array2.size ] = array[ i ];
	return array2;
}

function ArrayClamp( array, e_index )
{
	array2 = [];
	for( i = 0; i < e_index; i++ )
		array2[ array2.size ] = array[ i ];
	return array2;
}

function ArrayPush( array, object )
{
	if( IsArray( object ) )
		for( i = 0; i < object.size; i++ )
			array[ array.size ] = object[ i ];
	else
		array[ array.size ] = object;
}
