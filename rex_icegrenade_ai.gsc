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

#define ICEGRENADE_KEYBOARD_EXPLOSION_FX        "REX/ai/icegrenade/key_explosion"
#define ICEGRENADE_GRENADE_EXPLOSION_FX         "REX/ai/icegrenade/grenade_ignite_notif"
#define ICEGRENADE_GRENADE_TRAIL_FX             "REX/ai/icegrenade/grenade_trail"
#define ICEGRENADE_LEFT_FOOTPRINT_FX            "REX/ai/icegrenade/footprint_l"
#define ICEGRENADE_RIGHT_FOOTPRINT_FX           "REX/ai/icegrenade/footprint_r"
#define ICEGRENADE_ICICLE_01                    "rex_ai_icegrenade_icicle_01"
#define ICEGRENADE_ICICLE_02                    "rex_ai_icegrenade_icicle_02"
#define ICEGRENADE_ICICLE_03                    "rex_ai_icegrenade_icicle_03"
#define ICEGRENADE_SPECIAL_COOLDOWN_MIN         10
#define ICEGRENADE_SPECIAL_COOLDOWN_MAX         20
#define ICEGRENADE_BARK_MIN                     5
#define ICEGRENADE_BARK_MAX                     10
#define ICEGRENADE_TORNADO_GRAVITATION          650
#define ICEGRENADE_TORNADO_STRENGTH             65
#define ICEGRENADE_TORNADO_MIN                  6
#define ICEGRENADE_TORNADO_MAX                  12
#define ICEGRENADE_ICICLE_MIN                   15
#define ICEGRENADE_ICICLE_MAX                   20
#define ICEGRENADE_ICICLE_SPEED                 0.05
#define ICEGRENADE_ICICLE_INCREMENT             25
#define ICEGRENADE_ICICLE_ACTIVATION            275
#define ICEGRENADE_HEAVY_DAMAGE_MIN             8
#define ICEGRENADE_HEAVY_DAMAGE_MAX             16
#define ICEGRENADE_HEAVY_DAMAGE_REQ             5000
#define ICEGRENADE_KEYBOARD_DAMAGE              75
#define ICEGRENADE_TORNADO_DAMAGE               15
#define ICEGRENADE_GRENADE_DAMAGE               85
#define ICEGRENADE_ICICLE_DAMAGE                15
#define ICEGRENADE_ATTACK_DAMAGE                50
#define ICEGRENADE_KEYBOARD_RADIUS              128
#define ICEGRENADE_TORNADO_RADIUS               145
#define ICEGRENADE_ATTACK_RADIUS                90
#define ICEGRENADE_ICICLE_RADIUS                75
#define ICEGRENADE_CHASE_RADIUS                 500
#define ICEGRENADE_THROW_RADIUS                 550
#define ICEGRENADE_FROST_RADIUS                 136
#define ICEGRENADE_HEALTH                       15000

#define ARCHETYPE_ICEGRENADE                    "rex_icegrenade"

#define SQUARED(x)                              ( x * x )

#precache( "fx",        ICEGRENADE_KEYBOARD_EXPLOSION_FX );
#precache( "fx",        ICEGRENADE_GRENADE_EXPLOSION_FX );
#precache( "fx",        ICEGRENADE_GRENADE_TRAIL_FX );
#precache( "fx",        ICEGRENADE_LEFT_FOOTPRINT_FX );
#precache( "fx",        ICEGRENADE_RIGHT_FOOTPRINT_FX );
#precache( "xmodel",    ICEGRENADE_ICICLE_01 );
#precache( "xmodel",    ICEGRENADE_ICICLE_02 );
#precache( "xmodel",    ICEGRENADE_ICICLE_03 );

#using_animtree( "generic" );

#namespace rex_icegrenade_ai;

REGISTER_SYSTEM( "rex_icegrenade", &__init__, undefined )

function __init__()
{
    clientfield::register( "toplayer", "rex_frost_pfx", VERSION_SHIP, 1, "int" );
    clientfield::register( "clientuimodel", "IceBossHealthNotif", 1, 20, "float" );
	clientfield::register( "clientuimodel", "IceBossHealthBar", 1, 1, "int" );
    
    level.icegrenade_spawner = GetEntArray( "icegrenade_spawner", "script_noteworthy" );
    
    BT_REGISTER_API( "IcegrenadeLocomotionBehaviorCondition",   &IcegrenadeLocomotionBehaviorCondition );
    BT_REGISTER_API( "IcegrenadeShouldHeavyDamage",             &IcegrenadeShouldHeavyDamage );
    BT_REGISTER_API( "IcegrenadeTargetService",                 &IcegrenadeTargetService );
    BT_REGISTER_API( "IcegrenadeShouldAttack",                  &IcegrenadeShouldAttack );
    BT_REGISTER_API( "IcegrenadeShouldTornado",                 &IcegrenadeShouldTornado );
    BT_REGISTER_API( "IcegrenadeShouldIcewall",                 &IcegrenadeShouldIcewall );
    BT_REGISTER_API( "IcegrenadeShouldThrow",                   &IcegrenadeShouldThrow );

    spawner::add_archetype_spawn_function( ARCHETYPE_ICEGRENADE, &IcegrenadeInit );

    level thread aat::register_immunity( ZM_AAT_BLAST_FURNACE_NAME, ARCHETYPE_ICEGRENADE, true, true, true );
    level thread aat::register_immunity( ZM_AAT_DEAD_WIRE_NAME, ARCHETYPE_ICEGRENADE, true, true, true );
    level thread aat::register_immunity( ZM_AAT_FIRE_WORKS_NAME, ARCHETYPE_ICEGRENADE, true, true, true );
    level thread aat::register_immunity( ZM_AAT_THUNDER_WALL_NAME, ARCHETYPE_ICEGRENADE, true, true, true );
    level thread aat::register_immunity( ZM_AAT_TURNED_NAME, ARCHETYPE_ICEGRENADE, true, true, true );
}

function IcegrenadeInit()
{
    self.health = Int( ICEGRENADE_HEALTH + ( ICEGRENADE_HEALTH * ( 0.125 * level.round_number ) ) );
    self.maxhealth = self.health;

    self.icegrenade_move_type = "walk";

    BB_REGISTER_ATTRIBUTE( "_rex_icegrenade_move_type", self.icegrenade_move_type, &IcegrenadeMoveType );

    Blackboard::CreateBlackBoardForEntity( self );

    ai::CreateInterfaceForEntity( self );

    self flag::init( "icegrenade_is_attacking" );

    self AiUtility::RegisterUtilityBlackboardAttributes();

    self PushActors( true );
    self PushPlayer( true );

    self.ignore_nuke = true;
    self.ignore_enemy_count = true;
    self.ignoreragdoll = true;
    self.skipautoragdoll = true;
    self.ignore_round_robbin_death = true;
    self.b_ignore_cleanup = true;
    self.is_barking = false;
    self.is_tornado = false;
    self.is_magic_icewall = false;
    self.is_heavy_damaged = false;
    self.is_throwing_grenade = false;
    self.is_throwing_keyboard = false;
    self.can_attack = false;
    self.last_heavy_infliction = GetTime();

    self.damage_inflicted = 0;

    self.special_events = array(
        array( "throw_keyboard", 25 ),
        array( "throw_grenade", 25 ),
        array( "tornado", 25 ),
        array( "icewall", 25 )
    );
    
    self.icicles = array( 
        ICEGRENADE_ICICLE_01, 
        ICEGRENADE_ICICLE_02, 
        ICEGRENADE_ICICLE_03 
    );

    self thread HandleSpecialEvents();
    self thread HandleThrowKeyboard();
    self thread HandleThrowGrenade();
    self thread HandlePlayerDamage();
    self thread HandleFootprint();
    self thread HandleTornado();
    self thread HandleIcewall();
    self thread HandleChase();
    self thread HandleBark();
    self thread WatchDeath();
    self thread CheckIsAttacking();

    AiUtility::AddAiOverrideDamageCallback( self, &IcegrenadeDamageCallback );
}

function IcegrenadeDamageCallback( inflictor, attacker, damage, dFlags, mod, weapon, point, dir, hitLoc, offsetTime, boneIndex, modelIndex )
{
    n_damage = ( ( damage > 1000 ) ? 1000 : damage );

    if( self.has_healthbar )
    {
        players = GetPlayers();
        for( i = 0; i < players.size; i++ )
        {
            players[ i ] clientfield::set_player_uimodel( "IceBossHealthNotif", ( ( self.health - n_damage ) / self.maxhealth ) );
        }
    }
    
    self.damage_inflicted = ( ( !self.is_heavy_damaged && ( GetTime() > self.last_heavy_infliction ) ) ? ( self.damage_inflicted + damage ) : 0 );
    
    if( GetTime() > self.last_heavy_infliction )
    {
        if( self.damage_inflicted >= ICEGRENADE_HEAVY_DAMAGE_REQ )
        {
            self.last_heavy_infliction = ( GetTime() + ( RandomFloatRange( ICEGRENADE_HEAVY_DAMAGE_MIN, ICEGRENADE_HEAVY_DAMAGE_MAX + 1 ) * 1000 ) );
            self thread HandleHeavyDamage();
        }
    }
    return n_damage;
}

function HandleHeavyDamage()
{
    self.is_heavy_damaged = true;
    self waittill( "heavy_done" );
    self.is_heavy_damaged = false;
}

function IcegrenadeShouldHeavyDamage( entity )
{
    return entity.is_heavy_damaged;
}

function HandleChase()
{
    while( 1 )
    {
        WAIT_SERVER_FRAME;

        if( DistanceSquared( self.favoriteenemy.origin, self.origin ) < SQUARED( ICEGRENADE_CHASE_RADIUS ) )
        {
            self.icegrenade_move_type = "run";

            result = self util::waittill_any_timeout( RandomIntRange( 10, 15 ), "attack_done" );
        }
        self.icegrenade_move_type = "walk";
    }
}

function IcegrenadeMoveType()
{
    return self.icegrenade_move_type;
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

            self flag::clear( "icegrenade_is_attacking" );
        }
	}
}

function WatchDeath()
{
    self waittill( "death" );

    if( self.has_healthbar )
    {
        players = GetPlayers();
        for( i = 0; i < players.size; i++ )
        {
            players[ i ] clientfield::set_player_uimodel( "IceBossHealthNotif", 0 );
            players[ i ] clientfield::set_player_uimodel( "IceBossHealthBar", 0 );
        }
    }
}

function HandlePlayerDamage()
{
    self endon( "death" );

    while( 1 )
    {
        self waittill( "attack_melee" );

        players = self GetTargetablePlayers();
        for( i = 0; i < players.size; i++ )
        {
            if( DistanceSquared( players[ i ].origin, self.origin ) <= SQUARED( ICEGRENADE_ATTACK_RADIUS ) )
                players[ i ] DoDamage( ICEGRENADE_ATTACK_DAMAGE, players[ i ].origin );
            if( players[ i ] laststand::player_is_in_laststand() )
                self PlaySound( "rex_ai_icegrenade_taunt_vox" );
        }
    }
}

function IcegrenadeLocomotionBehaviorCondition( entity )
{
    if( entity flag::get( "icegrenade_is_attacking" ) )
        return false;
    if( !entity HasPath() )
        return false;
    return true;
}

function IcegrenadeShouldAttack( entity )
{
    if( entity flag::get( "icegrenade_is_attacking" ) )
        return true;
    if( !isdefined( entity.favoriteenemy ) )
    {
        entity.can_attack = false;
        return false;
    }
    if( DistanceSquared( entity.origin, entity.favoriteenemy.origin ) > SQUARED( ICEGRENADE_ATTACK_RADIUS ) )
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
    entity flag::set( "icegrenade_is_attacking" );
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

	special_interval = GetTime() + ( RandomIntRange( ICEGRENADE_SPECIAL_COOLDOWN_MIN, ICEGRENADE_SPECIAL_COOLDOWN_MAX + 1 ) * 1000 );

	while( 1 )
	{
		WAIT_SERVER_FRAME;
		
		if( GetTime() > special_interval )
		{
			if( !isdefined( self.current_event ) )
			{	
				self.current_event = ( ( !isdefined( self.current_event ) ) ? GetEvent( self.special_events )[ 0 ] : self.current_event );

				special_interval = GetTime() + ( RandomIntRange( ICEGRENADE_SPECIAL_COOLDOWN_MIN, ICEGRENADE_SPECIAL_COOLDOWN_MAX + 1 ) * 1000 );
			}
		}
	}
}

function HandleThrowGrenade()
{
    self endon( "death" );

    while( 1 )
    {
        WAIT_SERVER_FRAME;

        if( IS_EQUAL( self GetTargetablePlayers().size, 0 ) )
            continue;
        if( self.is_barking )
            continue;
        if( IS_EQUAL( self.current_event, "throw_grenade" ) )
        {
            self.is_throwing_grenade = true;

            self PlaySound( "rex_ai_icegrenade_projectile_vox" );

            point = VectorLerp( self GetTagOrigin( "righthand" ), self GetTagOrigin( "righthandmiddle4" ), 0.5 );
            angles = VectortoAngles( self GetTagOrigin( "righthandmiddle4" ) - self GetTagOrigin( "righthand" ) );
            grenade = util::spawn_model( "rex_ai_icegrenade_grenade", point, angles );
            grenade LinkTo( self, "righthand" );

            grenade.fx = util::spawn_model( "tag_origin", grenade.origin );
            grenade.fx LinkTo( grenade );

            self waittill( "throw_start" );

            grenade Unlink();

            PlayFXOnTag( ICEGRENADE_GRENADE_TRAIL_FX, grenade.fx, "tag_origin" );

            hitpos = undefined;
            while( !isdefined( hitpos ) )
            {
                WAIT_SERVER_FRAME;

                queryResult = PositionQuery_Source_Navigation( self.favoriteenemy.origin, 5, 35, 75, 15, self );
                query = array::random( queryResult.data );
                if( IsPointOnNavMesh( query.origin ) )
                    hitpos = query;
            }
            grenade zm_utility::fake_physicslaunch( hitpos.origin, RandomIntRange( 650, 850 ) );
            grenade thread HandleGrenade( self, hitpos );

            self waittill( "throw_done" );
            
            self.current_event = undefined;
            self.is_throwing_grenade = false;
        }
    }
}

function HandleGrenade( entity, hitpos )
{
    self zm_utility::waittill_not_moving();

    self.fx Delete();
    
    hit_point = util::spawn_model( "tag_origin", hitpos.origin, ( 0, 0, 0 ) );

    forward = ( ( !IS_EQUAL( entity GetTargetablePlayers().size, 0 ) ) ? ( AnglesToForward( VectortoAngles( self.origin - ArrayGetClosest( self.origin, GetTargetablePlayers() ).origin ) ) * -1 ) : undefined );
    up = AnglesToUp( self.angles );

    PlayFX( ICEGRENADE_GRENADE_EXPLOSION_FX, hit_point.origin, forward, up );

    self.origin = hit_point.origin;
    self.angles = VectortoAngles( AnglesToForward( hit_point.angles ) );

    self MoveTo( ( self.origin + vectorscale( AnglesToUp( hit_point.angles ), 50 ) ), 0.75, 0.15, 0.15 );
    
    wait( 0.75 );

    self Delete();

    hit_point PlaySound( "rex_ai_icegrenade_grenade" );

    players = self GetTargetablePlayers();

    array::thread_all( players, &HandleFrost, hit_point );

    for( i = 0; i < players.size; i++ )
    {
        if( DistanceSquared( players[ i ].origin, hitpos.origin ) <= SQUARED( ICEGRENADE_FROST_RADIUS ) )  
            players[ i ] DoDamage( ICEGRENADE_GRENADE_DAMAGE, players[ i ].origin );
        if( players[ i ] laststand::player_is_in_laststand() )
            self PlaySound( "rex_ai_icegrenade_taunt_vox" );
    }
    
    frost_interval = ( GetTime() + 6000 );
    while( GetTime() < frost_interval )
        WAIT_SERVER_FRAME;

    hit_point Delete();
}

function HandleFrost( hitpos )
{
    while( isdefined( hitpos ) )
    {
        WAIT_SERVER_FRAME;
        
        self clientfield::set_to_player( "rex_frost_pfx", ( ( isdefined( hitpos ) && DistanceSquared( self.origin, hitpos.origin ) <= SQUARED( ICEGRENADE_FROST_RADIUS ) ) ? 1 : 0 ) );
        self SetMoveSpeedScale( ( ( isdefined( hitpos ) && DistanceSquared( self.origin, hitpos.origin ) <= SQUARED( ICEGRENADE_FROST_RADIUS ) ) ? 0.15 : 1 ) );
    }
    self clientfield::set_to_player( "rex_frost_pfx", 0 );
    self SetMoveSpeedScale( 1 );
}

function HandleThrowKeyboard()
{
    self endon( "death" );

    while( 1 )
    {
        WAIT_SERVER_FRAME;

        if( IS_EQUAL( self GetTargetablePlayers().size, 0 ) )
            continue;
        if( self.is_barking )
            continue;
        if( IS_EQUAL( self.current_event, "throw_keyboard" ) )
        {
            self.is_throwing_keyboard = true;

            self PlaySound( "rex_ai_icegrenade_keyboard_vox" );

            point = VectorLerp( self GetTagOrigin( "righthand" ), self GetTagOrigin( "righthandmiddle4" ), 0.5 );
            angles = VectortoAngles( self GetTagOrigin( "righthandmiddle4" ) - self GetTagOrigin( "righthand" ) );
            keyboard = util::spawn_model( "rex_ai_icegrenade_keyboard", point, angles );
            keyboard LinkTo( self, "righthand" );

            self waittill( "throw_start" );

            keyboard Unlink();

            hitpos = undefined;
            while( !isdefined( hitpos ) )
            {
                WAIT_SERVER_FRAME;

                queryResult = PositionQuery_Source_Navigation( self.favoriteenemy.origin, 5, 35, 75, 15, self );
                query = array::random( queryResult.data );
                if( IsPointOnNavMesh( query.origin ) )
                    hitpos = query;
            }
            keyboard zm_utility::fake_physicslaunch( hitpos.origin, RandomIntRange( 1000, 1250 ) );
            keyboard thread HandleKeyboard( self, hitpos );

            self waittill( "throw_done" );
            
            self.current_event = undefined;
            self.is_throwing_keyboard = false;
        }
    }
}

function HandleKeyboard( entity, hitpos )
{
    self zm_utility::waittill_not_moving();
    self Delete();

    hit_point = util::spawn_model( "tag_origin", hitpos.origin, ( 0, 0, 0 ) );
    
    forward = ( ( !IS_EQUAL( entity GetTargetablePlayers().size, 0 ) ) ? ( AnglesToForward( VectortoAngles( self.origin - ArrayGetClosest( self.origin, GetTargetablePlayers() ).origin ) ) * -1 ) : undefined );
    up = AnglesToUp( self.angles );

    PlayFX( ICEGRENADE_KEYBOARD_EXPLOSION_FX, hit_point.origin, forward, up );

    hit_point PlaySound( "rex_ai_icegrenade_keyboard" );

    players = self GetTargetablePlayers();
    for( i = 0; i < players.size; i++ )
    {
        if( DistanceSquared( players[ i ].origin, hit_point.origin ) <= SQUARED( ICEGRENADE_KEYBOARD_RADIUS ) )
            players[ i ] DoDamage( ICEGRENADE_KEYBOARD_DAMAGE, players[ i ].origin );
        if( players[ i ] laststand::player_is_in_laststand() )
            self PlaySound( "rex_ai_icegrenade_taunt_vox" );
    }
    hit_point Delete();
}

function IcegrenadeShouldThrow( entity )
{
    return ( entity.is_throwing_grenade || entity.is_throwing_keyboard );
}

function HandleIcewall()
{
    self endon( "death" );

    while( 1 )
    {
        WAIT_SERVER_FRAME;
        
        if( IS_EQUAL( self GetTargetablePlayers().size, 0 ) )
            continue;
        if( self.is_barking )
            continue;
        if( IS_EQUAL( self.current_event, "icewall" ) )
        {
            if( DistanceSquared( self.favoriteenemy.origin, self.origin ) <= SQUARED( ICEGRENADE_ICICLE_ACTIVATION ) )
            {
                self.is_magic_icewall = true;

                self waittill( "icewall_start" );

                icicles = RandomIntRange( ICEGRENADE_ICICLE_MIN, ICEGRENADE_ICICLE_MAX + 1 );
                for( i = 0; i < icicles; i++ )
                {
                    icicle_increment = ( GetTime() + ( 0.05 * 1000 ) );

                    hitpos = undefined;
                    while( !isdefined( hitpos ) )
                    {
                        WAIT_SERVER_FRAME;

                        queryResult = PositionQuery_Source_Navigation( ( self.origin + vectorscale( AnglesToForward( self.angles ), ( ICEGRENADE_ICICLE_INCREMENT * ( i + 1 ) ) ) ), 5, 25, 35, 5, self );
                        query = array::random( queryResult.data );

                        if( !IsPointOnNavMesh( query.origin ) )
                        {
                            if( GetTime() > icicle_increment )
                                break;
                            continue;
                        }
                        hitpos = query;
                    }
                    if( isdefined( hitpos ) )
                    {
                        icicle = util::spawn_model( self.icicles[ RandomInt( self.icicles.size ) ], ( query.origin + vectorscale( AnglesToUp( self.angles ), -50 ) ), VectortoAngles( self.favoriteenemy.origin - self.origin ) );
                        icicle thread HandleIcicleMovement( ICEGRENADE_ICICLE_SPEED );
                    }
                    wait( ICEGRENADE_ICICLE_SPEED );
                }
                self waittill( "icewall_done" );
            
                self.current_event = undefined;
                self.is_magic_icewall = false;
            }
        }
    }
}

function HandleIcicleMovement( time )
{
    self thread HandleIcicle();
    
    self MoveTo( ( self.origin + vectorscale( AnglesToUp( self.angles ), 50 ) ), 0.5 );

    icicle_interval = ( GetTime() + 3500 );
    while( GetTime() < icicle_interval )
        WAIT_SERVER_FRAME;

    self MoveTo( ( self.origin + vectorscale( AnglesToUp( self.angles ), -50 ) ), 0.5 );
    
    self waittill( "movedone" );

    self Delete();
}

function HandleIcicle()
{
    while( isdefined( self ) )
    {
        WAIT_SERVER_FRAME;

        players = self GetTargetablePlayers();
        for( i = 0; i < players.size; i++ )
        {
            if( DistanceSquared( players[ i ].origin, self.origin ) <= SQUARED( ICEGRENADE_ICICLE_RADIUS ) )
            {
                if( !isdefined( players[ i ].last_hit ) )
                    players[ i ].last_hit = GetTime();
                if( GetTime() > players[ i ].last_hit )
                {
                    players[ i ] DoDamage( ICEGRENADE_ICICLE_DAMAGE, players[ i ].origin );
                    players[ i ].last_hit = ( GetTime() + 1000 );

                    if( players[ i ] laststand::player_is_in_laststand() )
                        self PlaySound( "rex_ai_icegrenade_taunt_vox" );
                }
            }
        }
    }
}

function IcegrenadeShouldIcewall( entity )
{
    return entity.is_magic_icewall;
}

function HandleTornado()
{
    self endon( "death" );

    while( 1 )
    {
        WAIT_SERVER_FRAME;

        if( IS_EQUAL( self GetTargetablePlayers().size, 0 ) )
            continue;
        if( self.is_barking )
            continue;
        if( IS_EQUAL( self.current_event, "tornado" ) )
        {
            self.is_tornado = true;
            
            tornado_length = RandomFloatRange( ICEGRENADE_TORNADO_MIN, ICEGRENADE_TORNADO_MAX + 1 );

            self thread WatchTornado( tornado_length );
            self thread HandleGravitation();

            self PlayLoopSound( "rex_ai_icegrenade_tornado", 0.5 );
                wait( tornado_length );
            self StopLoopSound( 0.5 );
            
            self.current_event = undefined;
            self.is_tornado = false;
        }
    }
}

function WatchTornado( length )
{
    tornado_interval = ( GetTime() + ( length * 1000 ) );
    while( GetTime() < tornado_interval )
    {
        wait( 0.5 );

        players = self GetTargetablePlayers();
        for( i = 0; i < players.size; i++ )
        {
            if( DistanceSquared( players[ i ].origin, self.origin ) <= SQUARED( ICEGRENADE_TORNADO_RADIUS ) )
            {
                players[ i ] DoDamage( ICEGRENADE_TORNADO_DAMAGE, players[ i ].origin );

                if( players[ i ] laststand::player_is_in_laststand() )
                    self PlaySound( "rex_ai_icegrenade_taunt_vox" );
            }
        }
    }
}

function HandleGravitation()
{
    while( self.is_tornado )
    {
        WAIT_SERVER_FRAME;

        players = GetPlayers();
        for( i = 0; i < players.size; i++ )
        {
            if( DistanceSquared( players[ i ].origin, self.origin ) <= SQUARED( ICEGRENADE_TORNADO_GRAVITATION ) )
            {
                players[ i ] SetVelocity( ( players[ i ] GetVelocity() + ( VectorNormalize( AnglesToForward( VectortoAngles( self.origin - players[ i ].origin ) ) ) * ICEGRENADE_TORNADO_STRENGTH ) ) );
            }
        }
    }
}

function IcegrenadeShouldTornado( entity )
{
    return entity.is_tornado;
}

function HandleBark()
{
    self endon( "death" );
    
    while( 1 )
    {
        WAIT_SERVER_FRAME;

        if( self.is_tornado )
            continue;
        if( self.is_magic_icewall )
            continue;
        if( self.is_heavy_damaged )
            continue;
        if( self.is_throwing_grenade )
            continue;
        if( self.is_throwing_keyboard )
            continue;
        if( !isdefined( self.favoriteenemy ) )
            continue;
        evt = self util::waittill_any_timeout( RandomFloatRange( ICEGRENADE_BARK_MIN, ICEGRENADE_BARK_MAX + 1 ), "throw_start", "icewall_start", "tornado_start", "heavy_start", "idle_start" );

        if( IS_EQUAL( evt, "timeout" ) )
        {
            self.is_barking = true;

            self PlaySoundWithNotify( "rex_ai_icegrenade_bark_vox", "sounddone" );
            self waittill( "sounddone" );

            self.is_barking = false;
        }
    }
}

function IcegrenadeTargetService( entity )
{
    if( IS_TRUE( entity.ignoreall ) )
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

function HandleFootprint()
{
    self endon( "death" );

    while( 1 )
    {
        self waittill( "footstep", data );

        step_data = StrTok( data, "," );
        
        forward = AnglesToForward( self.angles );
        up = AnglesToUp( self.angles );

        PlayFX( step_data[ 0 ], self GetTagOrigin( step_data[ 1 ] ), forward, up );
    }
}

function spawn_icegrenade( health, has_healthbar = true, s_location = undefined )
{
    spots = struct::get_array( "icegrenade_location", "targetname" );

    if( !isdefined( s_location ) )
    {
        spot = undefined;
        while( !isdefined( spot ) )
        {   
            WAIT_SERVER_FRAME;

            player = array::random( GetPlayers() );
            
            r_spot = ArrayGetClosest( player.origin, spots );

            zone = zm_zonemgr::get_zone_from_position( r_spot.origin, 1 );
            if( zm_zonemgr::zone_is_enabled( zone ) )
                spot = r_spot;
        }
    }   
	loc = ( ( isdefined( s_location ) ) ? s_location : spot );
	
	entity = zombie_utility::spawn_zombie( level.icegrenade_spawner[ 0 ], "rex_icegrenade", loc );
	entity ForceTeleport( loc.origin, loc.angles );

    entity.has_healthbar = has_healthbar;

    if( isdefined( health ) )
    {
        entity.health = health;
        entity.maxhealth = entity.health;
    }
    if( has_healthbar )
    {
        players = GetPlayers();
        for( i = 0; i < players.size; i++ )
        {
            players[ i ] clientfield::set_player_uimodel( "IceBossHealthNotif", ( entity.health / entity.maxhealth ) );
            players[ i ] clientfield::set_player_uimodel( "IceBossHealthBar", 1 );
        }
    }
	return entity;
}
