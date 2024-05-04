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

#define HEISENBERG_HITBOX_CHASSIS					"rex_ai_heisenberg_hitbox_chassis"
#define HEISENBERG_HITBOX_BODY						"rex_ai_heisenberg_hitbox_body"
#define HEISENBERG_DAMAGE_FX						"REX/ai/heisenberg/damage_spark"
#define HEISENBERG_DEATH_FX							"REX/ai/heisenberg/death_explosion"
#define HEISENBERG_ATTACK_DISTANCE					550
#define HEISENBERG_HEALTH 						    15000

#define ARCHETYPE_HEISENBERG 					    "rex_heisenberg"

#define SQUARED(x)                              ( x * x )

#precache( "xmodel", HEISENBERG_HITBOX_CHASSIS );
#precache( "xmodel", HEISENBERG_HITBOX_BODY );
#precache( "fx", HEISENBERG_DAMAGE_FX );
#precache( "fx", HEISENBERG_DEATH_FX );

#namespace rex_heisenberg_ai;

REGISTER_SYSTEM( "rex_heisenberg", &__init__, undefined )
function __init__()
{
	level.heisenberg_spawner = GetEntArray( "heisenberg_spawner", "script_noteworthy" );

	BT_REGISTER_API( "HeisenbergLocomotionBehaviorCondition",	    &HeisenbergLocomotionBehaviorCondition );
	BT_REGISTER_API( "HeisenbergTargetService",					    &HeisenbergTargetService );
	BT_REGISTER_API( "HeisenbergShouldAttack",					    &HeisenbergShouldAttack );
	BT_REGISTER_API( "HeisenbergShouldDamage",					    &HeisenbergShouldDamage );

	spawner::add_archetype_spawn_function( ARCHETYPE_HEISENBERG, 	&HeisenbergInit );

    animationstatenetwork::registernotetrackhandlerfunction( "heisenberg_melee", &HeisenbergMelee );

	level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_HEISENBERG, true, true, true );
	level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_HEISENBERG, true, true, true );
	level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_HEISENBERG, true, true, true );
	level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_HEISENBERG, true, true, true );
	level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_HEISENBERG, true, true, true );

	zm_spawner::add_custom_zombie_spawn_logic( &ConfigureZombie );
	zm_spawner::register_zombie_death_event_callback( &ZombieDeath );
}

function HeisenbergInit()
{
    self.health = HEISENBERG_HEALTH;
	self.maxhealth = self.health;

	Blackboard::CreateBlackBoardForEntity( self );
		
	ai::CreateInterfaceForEntity( self );

	self AiUtility::RegisterUtilityBlackboardAttributes();

	self flag::init( "heisenberg_is_attacking" );

	self.audio = util::spawn_model( "tag_origin", self.origin, self.angles );
	self.audio PlayLoopSound( "rex_ai_hberg_ambience", 1 );
	self.audio LinkTo( self );
	
	self SetPhysParams( 156, 0, 550 );
	self PushActors( false );
    self PushPlayer( true );

    self.meleedamage = 45;
    self.meleeattackdist = 450;

    self.no_gib = true;
	self.has_legs = true;
	self.forcemovementscriptstate = false;
	self.ignorebulletdamage = true;
	self.ignoretriggerdamage = true;
	self.ignore_nuke = true;
	self.ignore_enemy_count = true;
	self.ignoreragdoll = true;
	self.skipautoragdoll = true;
	self.ignore_round_robbin_death = true;
	self.b_ignore_cleanup = true;
    self.is_damaged = false;

	self.hitbox = [];

	self.dialog_interval = ( GetTime() + ( RandomIntRange( 5, 11 ) * 1000 ) );
	self.idle_interval = ( GetTime() + ( RandomIntRange( 2, 5 ) * 1000 ) );

    self thread CheckIsAttacking();
	self thread HandleSpawning();
	self thread HandleZombies();
    self thread HandleDamage();
	self thread HandleDialog();
	self thread HandleSound();
	self thread HandleTrack();
	self thread SetupHitbox();
	self thread WatchCorpse();
	self thread WatchDeath();

	AiUtility::AddAIOverrideDamageCallback( self, &HeisenbergDamageCallback );
}

function SetupHitbox()
{
	chassis =  util::spawn_model( HEISENBERG_HITBOX_CHASSIS, self.origin, self.angles );
	chassis LinkTo( self, "chassis_mid" );

	body =  util::spawn_model( HEISENBERG_HITBOX_BODY, self.origin, self.angles );
	body LinkTo( self, "tag_origin" );

	self.hitbox[ self.hitbox.size ] = chassis;
	self.hitbox[ self.hitbox.size ] = body;

	array::thread_all( self.hitbox, &WatchHitbox, self );
}

function WatchHitbox( entity )
{
	entity endon( "death" );

	self SetCanDamage( 1 );

	for( ;; )
	{
		self waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );

		adjusted_damage = Int( ( ( damage * 100 ) / ( entity.maxhealth * 0.55 ) ) );

		entity DoDamage( ( ( entity.is_damaged ) ? ( adjusted_damage * 2 ) : adjusted_damage ), entity.origin, undefined, undefined, undefined, "MOD_IMPACT" );

		PlayFX( HEISENBERG_DAMAGE_FX, point );
	}
}

function HandleDamage()
{
    self endon( "death" );

    health_req = Int( self.health - ( self.maxhealth / 5 ) );

    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( self.health <= health_req && !IS_EQUAL( health_req, 0 ) )
        {
            self.is_damaged = true;
            self waittill( "damage_done" );
            self.is_damaged = false;

            health_req = ( ( Int( self.health - ( self.maxhealth / 5 ) ) < 0 ) ? 0 : Int( self.health - ( self.maxhealth / 5 ) ) );
        }
    }
}

function HeisenbergShouldDamage( entity )
{
    return entity.is_damaged;
}

function HeisenbergDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, offsetTime, boneIndex, modelIndex )
{
	return ( ( IS_EQUAL( mod, "MOD_IMPACT" ) ) ? damage : 0 );
}

function WatchDeath()
{
	self waittill( "death" );

	self StopSounds();

	self StopSound( "rex_ai_hberg_taunt_vox" );
	self PlaySound( "rex_ai_hberg_death_vox" );
	self PlaySound( "rex_ai_hberg_death" );

	self.audio StopLoopSound( 1 );
	self.audio Unlink();
	self.audio Delete();

	array::run_all( self.hitbox, &Delete );
}

function WatchCorpse()
{
	self waittill( "actor_corpse", corpse );
	
	PlayFX( HEISENBERG_DEATH_FX, corpse.origin );

	PlaySoundAtPosition( "rex_ai_hberg_explosion", corpse.origin );
	PlaySoundAtPosition( "rex_ai_hberg_explosion_decay", corpse.origin );

	corpse Delete();
}

function HandleZombies()
{
	self endon( "death" );

	for( ;; )
	{
		WAIT_SERVER_FRAME;

		a_zombies = GetAIArchetypeArray( "zombie", "all" );
		for( i = 0; i < a_zombies.size; i++ )
		{
			if( DistanceSquared( a_zombies[ i ].origin, self.origin ) <= SQUARED( 156 ) )
			{
				PlaySoundAtPosition( "rex_ai_hberg_crush_gore", a_zombies[ i ].origin );

				a_zombies[ i ] DoDamage( a_zombies[ i ].maxhealth, a_zombies[ i ].origin );
			}
		}
	}
}

function HandleSound()
{
	self endon( "death" );

	for( ;; )
	{
		self waittill( "attack_sound", data );

		strToks = StrTok( data, "," );

		self PlaySoundOnTag( strToks[ 0 ], strToks[ 1 ] );
	}
}

function HandleDialog()
{
    self endon( "death" );
    
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( isdefined( self.favoriteenemy ) )
        {
            if( GetTime() > self.dialog_interval )
            {
                self PlaySoundWithNotify( "rex_ai_hberg_taunt_vox", "sounddone" );

				self waittill( "sounddone" );

				self.dialog_interval = ( GetTime() + ( RandomIntRange( 5, 11 ) * 1000 ) );
            }
        }
        else
        {
            self StopSound( "rex_ai_hberg_taunt_vox" );
        }
    }
}

function HandleTrack()
{
	track_interval = GetTime();
	audio = util::spawn_model( "tag_origin", ( 0, 0, 0 ) );
	
	while( isdefined( self ) && IsAlive( self ) )
	{
		WAIT_SERVER_FRAME;

		if( GetTime() > track_interval )
		{
			audio PlaySound( "rex_ai_hberg_music_track" );

			track_interval = ( GetTime() + ( SoundGetPlaybackTime( "rex_ai_hberg_music_track" ) ) );
		}
	}
	audio StopSound( "rex_ai_hberg_music_track" );
	audio Delete();
}

function HandleSpawning()
{
    level endon( "infinite_spawning" ); 
	
	locs = struct::get_array( "heisenberg_zombie_loc", "targetname" );
	spawner = GetEntArray( "zombie_spawner", "script_noteworthy" );

    ent_count = zombie_utility::get_current_zombie_count();

    for( ;; )
    {   
		wait( 0.1 );

        if( isdefined( self ) && IsAlive( self ) )
        {
            while( ent_count < 40 )
            {
				wait( 1 );

                level.zombie_total = 10;
				
				player = array::random( GetPlayers() );

				loc = ArrayGetClosest( player.origin, locs );
				loc.angles = VectortoAngles( AnglesToForward( player.angles ) * -1 );
				loc.script_string = "find_flesh";

                zombie = zombie_utility::spawn_zombie( spawner[ 0 ], "zombie", loc );
				zombie thread zm_spawner::do_zombie_rise( loc );

                ent_count = zombie_utility::get_current_zombie_count();
            }
			wait( 0.1 );

            ent_count = zombie_utility::get_current_zombie_count();
        }
    }
}

function ConfigureZombie()
{
	self.ignore_enemy_count = true;

	zombie_utility::ai_calculate_health( level.round_number );
	
	hberg = GetAIArchetypeArray( "rex_heisenberg" );

	if( hberg.size > 0 )
	{
		self.health = ( level.zombie_health * 1.25 );
		self.maxhealth = self.health;

		self ASMSetAnimationRate( 1.125 );
		self zombie_utility::set_zombie_run_cycle( array::random( array( "sprint", "super_sprint" ) ) );
	}
	else
	{
		self ASMSetAnimationRate( 1 );
		self zombie_utility::set_zombie_run_cycle( array::random( array( "walk", "run", "sprint" ) ) );
	}
	self PushActors( false );
}

function ZombieDeath( player )
{
	if( !isdefined( level.current_zombie_req ) )
		level.current_zombie_req = RandomIntRange( 50, 100 );
	level.current_zombie_req--;
	if( IS_EQUAL( level.current_zombie_req, 0 ) )
	{
		powerup_spawned = zm_powerups::specific_powerup_drop( "full_ammo", self.origin );
		level.current_zombie_req = RandomIntRange( 50, 100 );
	}	
}

function HeisenbergMelee( entity )
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

function KnockbackEnemy( enemy )
{
	forward = AnglesToForward( self.angles );
	velocity = enemy GetVelocity();
	force = ( 200 + ( RandomInt( 500 ) ) );
	enemy SetVelocity( velocity + ( forward * force ) );
}

function HeisenbergLocomotionBehaviorCondition( entity )
{	
	if( entity HasPath() && !entity flag::get( "heisenberg_is_attacking" ) && ( GetTime() > entity.idle_interval ) )
		return true;
	return false;
}

function CheckIsAttacking()
{
	self endon( "death" );

	for( ;; )
	{
		WAIT_SERVER_FRAME;

        if( self flag::get( "heisenberg_is_attacking" ) )
        {
            self waittill( "melee_done" );

            self flag::clear( "heisenberg_is_attacking" );
        }
	}
}

function HeisenbergShouldAttack( entity )
{	
	if( entity flag::get( "heisenberg_is_attacking" ) )
		return true;
	if( GetTime() < entity.idle_interval )
		return false;
	if( !isdefined( entity.favoriteenemy ) )
		return false;
	if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > SQUARED( HEISENBERG_ATTACK_DISTANCE ) )
		return false;
	yawToEnemy = AngleClamp180( entity.angles[ 1 ] - GET_YAW( entity, entity.favoriteenemy.origin ) );
	if( Abs( yawToEnemy ) > 45 )
		return false;
	entity flag::set( "heisenberg_is_attacking" );
	return true;
}

function HeisenbergTargetService( entity )
{
    if( IS_TRUE( entity.ignoreall ) )
        return false;
    n_player = ArrayGetClosest( entity.origin, entity GetTargetablePlayers() );
    entity.favoriteenemy = ( ( !isdefined( entity.favoriteenemy ) || !IS_EQUAL( entity.favoriteenemy, n_player ) ) ? ( ( !IS_EQUAL( n_player, 0 ) ) ? n_player : undefined ) : entity.favoriteenemy );

    targetPos = GetClosestPointOnNavMesh( ( ( !isdefined( entity.v_zombie_custom_goal ) ) ? entity.favoriteenemy.origin : entity.v_zombie_custom_goal ), 32, 16 );

    entity SetGoal( ( ( isdefined( targetPos ) ) ? targetPos : entity.origin ) );
    return ( isdefined( targetPos ) );
}

function spawn_heisenberg( s_location )
{
	spots = struct::get_array( "heisenberg_location", "targetname" );

	loc = ( ( isdefined( s_location ) ) ? s_location : array::random( spots ) );
	
	entity = zombie_utility::spawn_zombie( level.heisenberg_spawner[ 0 ], "rex_heisenberg", loc );
	entity ForceTeleport( loc.origin, loc.angles );

	return entity;
}

// REX - UTILITIES

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

	return withinrange;
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
