#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\aat_shared;
#using scripts\shared\system_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_score;

#using scripts\shared\ai\zombie_utility;

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;

#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;

#namespace cw_challenges;

REGISTER_SYSTEM( "rex_cw_challenges", &__init__, undefined )

function __init__()
{
    clientfield::register( "world", "hudItems.CWChallengeNotif", VERSION_SHIP, 2, "int" );

	animationstatenetwork::registernotetrackhandlerfunction( "zombie_melee", &zombienotetrackmeleefire );

    callback::on_connect( &on_player_connect );

    level thread trial_init();
}

function on_player_connect()
{
	util::registerClientSys( "challengeNotif" );
	self util::setClientSysState( "challengeNotif", "" );
	self.t_reward_rarity = 0;

	//self thread test_distance();
}

/*
	// ##### ARGUMENTS EXAMPLE #####
	AddTrial( desc, category, has_location, ARRAY( value, type, name, stance ) ) 

	// ##### TIMED WEAPON ELIMINATION CHALLENGE EXAMPLE #####
	AddTrial(
		"Get Kills With Any Weapon", 	// Challenge description
		"timed",						// Challenge category
		false							// Required location
		array(
			120							// Length in seconds
			"weapon",					// Timed challenge type
			"none",						// Weapon class name
			undefined					// Required stance
		)	
	)

	// ##### WEAPON ELIMINATION CHALLENGE EXAMPLE #####
	AddTrial(
		"Get Crouched Kills With Any LMG", 	// Challenge description
		"timed",							// Challenge category
		true								// Required location
		array(
			50								// Amount of elims
			"weapon",						// Timed challenge type
			"lmg",							// Weapon class name
			"crouch"						// Required stance
		)	
	)

	// ##### OBJECT CHALLENGE EXAMPLE #####
	AddTrial(
		"Pickup 5 Powerups", 				// Challenge description
		"goal",								// Challenge category
		true								// Required location
		array(
			5								// Length in seconds
			"object",						// Timed challenge type
			"none",							// Object ID name
			undefined						// Required stance
		)	
	)
*/

function AddTrial( ... )
{
	obj = SpawnStruct();
	obj.description = vararg[ 0 ];
	obj.category = vararg[ 1 ];
	obj.has_location = vararg[ 2 ];
	obj setup_config( vararg[ 3 ] );
	return obj;
}

function trial_init() 
{
	level waittill( "initial_blackscreen_passed" );

	/*challenges = array( 
		"Kill Zombies In Any Location",
		"Get Critical Kills In Any Location",
		"Get Kills While Crouching",
		"Get Kills Using Lethals",
		"Get Kills Using Tacticals",
		"Pickup Salvage Scraps",
		"Rebuild Barriers"
	);*/

	level.locations = array(
		"Cum City",
		"Cummy Kitchen",
		"Saul's Office",
		"Heisenberg Lair",
		"Cum Universe",
		"Trumpyyy World"
	);
	level.trials_completed = 0;
	level.trial_current_value = 0;
	level.trial_current = undefined;
	level.trials = array(
		AddTrial( "Get Crouched Kills With Any Weapon", "goal", true, array( 5, "weapon", "all", "crouch" ) ),
		//AddTrial( "Get Kills With Any Weapon", "timed", true, array( 30, "weapon", "all", undefined ) ),
		AddTrial( "Get Kills With Any Pistol", "goal", false, array( 5, "weapon", "pistol", undefined ) ),
		AddTrial( "Get Kills With Any Special", "goal", false, array( 5, "weapon", "special", undefined ) ),
		AddTrial( "Get Kills With Any Offhand", "goal", false, array( 5, "weapon", "grenade", undefined ) ),
		AddTrial( "Get Kills With Any Special", "goal", false, array( 5, "weapon", "special", undefined ) ),
		AddTrial( "Get Kills With Blast Furnace", "goal", true, array( 5, "weapon", "all", undefined, "zm_aat_blast_furnace" ) ),
		AddTrial( "Get Kills With Thunder Wall", "goal", true, array( 5, "weapon", "all", undefined, "zm_aat_thunder_wall" ) ),
		//AddTrial( "Get Kills With Fire Works", "goal", true, array( 5, "weapon", "all", undefined, "zm_aat_fire_works" ) )
		AddTrial( "Get Kills With Dead Wire", "goal", true, array( 5, "weapon", "all", undefined, "zm_aat_dead_wire" ) ),
		AddTrial( "Get Kills With Turned", "goal", true, array( 5, "weapon", "all", undefined, "zm_aat_turned" ) )
	);
	zm_spawner::register_zombie_death_event_callback( &trial_watch_death );

	//level thread trial_setup(); // UNCOMMENT LATER
}

function trial_setup()
{
	while( 1 )
	{
		WAIT_SERVER_FRAME;

		while( !GetPlayers()[ 0 ] UseButtonPressed() )
			WAIT_SERVER_FRAME;
	
		value = clientfield::get( "hudItems.CWChallengeNotif" );

		IPrintLnBold( value );
		
		if( !isdefined( level.trial_current ) )
		{
			level.trial_current_value = 0;
			level.trial_current = level.trials[ RandomInt( level.trials.size ) ];
			loc = ( ( level.trial_current.has_location ) ? level.locations[ RandomInt( level.locations.size ) ] : undefined );

			players = GetPlayers();
			for( j = 0; j < players.size; j++ )
				players[ j ] thread trial_activate( level.trial_current, loc );
			level thread trial_watch_completion( level.trial_current );

			clientfield::set( "hudItems.CWChallengeNotif", 1 );
		}
		while( GetPlayers()[ 0 ] UseButtonPressed() )
			WAIT_SERVER_FRAME;
	}
}

function trial_watch_completion( trial )
{
	v_initial = ( ( trial.category === "timed" ) ? ( Floor( GetTime() / 1000 ) + trial.config.value ) : undefined );

	while( level.trial_current_value < trial.config.value )
	{
		WAIT_SERVER_FRAME;

		if( ( v_initial - Floor( GetTime() / 1000 ) ) <= 0 )
			break;
	}
	clientfield::set( "hudItems.CWChallengeNotif", 0 );
	
	level.trial_current = undefined;
	level notify( "trial_ended" );
	level.trials_completed++;
}

function trial_activate( trial, loc )
{		
	v_initial = ( ( trial.category === "timed" ) ? ( Floor( GetTime() / 1000 ) + trial.config.value ) : undefined );
	self util::setClientSysState( "challengeNotif", "", self );
	self thread trial_update_prompt( trial, loc, v_initial );
}

function trial_update_prompt( trial, loc, v_initial )
{	
	while( isdefined( level.trial_current ) )
	{
		WAIT_SERVER_FRAME;

		switch( trial.category )
		{
			case "timed": {
				c_interval = ( v_initial - Floor( GetTime() / 1000 ) );
				IPrintLnBold( c_interval );
				value = c_interval;
				break;
			}
			case "goal": {
				value = ( level.trial_current_value + "/" + trial.config.value );
				break;
			}
		}
		str = MakeLocalizedString( trial.description + "," + value + ( ( isdefined( loc ) ) ? ( "," + loc ) : "" ) );
		self util::setClientSysState( "challengeNotif", str, self );
	}
}

function setup_config( data )
{	
	self.config = SpawnStruct();
	self.config.value = data[ 0 ];
	self.config.type = data[ 1 ];
	
	switch( self.config.type ){
		case "weapon": {
			self.config.weapClass = ( ( data[ 2 ] !== "all" ) ? data[ 2 ] : undefined );
			self.config.reqStance = data[ 3 ];
			self.config.reqAAT = data[ 4 ];
			break;
		}
		case "object": {
			self.config.itemName = data[ 2 ];
			break;
		}
		case "action": {
			self.config.actionName = data[ 2 ];
			break;
		}
	}
}

function convert_time( s )
{
	h = 0;
	m = 0;
	if( s > 59 ) {
		m = Int( s / 60 );
		s = ( Int( s * 1000 ) ) % 60000;
		s *= 0.001;
		if( m > 59 ) {
			h = Int( m / 60 );
			m = ( Int( m * 1000 ) ) % 60000;
			m *= 0.001;
		}
	}
	h = ( ( h < 10 ) ? ( h > 0 ? ( "0" + h ) : "" ) : h );
	m = ( ( m < 10 ) ? ("0" + m ) : m );
	s = ( ( s < 10 ) ? ("0" + s ) : s );
	str = ( ( ( StrIsNumber( h ) && Int( h ) > 0 ? ( h + ":" ) : "" ) + m ) + ":" ) + s;
	return str;	
}

function trial_watch_death( attacker )
{
	WAIT_SERVER_FRAME;

	if( isdefined( level.trial_current ) )
	{
		if( level.trial_current.config.type === "weapon" )
		{
			weapon = attacker GetCurrentWeapon();

			switch( level.trial_current.category )
			{
				case "goal":
				{
					if( level.trial_current_value < level.trial_current.config.value )
					{
						switch( weapon.weapClass )
						{
							case "grenade":
								weaponClass = "grenade";
								break;
							case "rifle":
								weaponClass = "rifle";
								break;
							case "smg":
								weaponClass = "smg";
								break;
							case "mg":
								weaponClass = "lmg";
								break;
							case "spread":
								weaponClass = "shotgun";
								break;
							case "rocketlauncher":
								weaponClass = "launcher";
								break;
							case "pistol spread":
							case "pistolspread":
							case "pistol":
								weaponClass = "pistol";
								if( zm_weapons::is_wonder_weapon( weapon ) )
									weaponClass = "special";
								break;
							case "knife":
							case "melee":
								weaponClass = "melee";
								break;
						}
						attacker IPrintLnBold( weaponClass );

						if( !isdefined( level.trial_current.config.weapClass ) || weaponClass === level.trial_current.config.weapClass )
						{
							if( isdefined( level.trial_current.config.reqStance ) )
								if( attacker GetStance() !== level.trial_current.config.reqStance )
									return;
							if( isdefined( level.trial_current.config.reqPerk ) )
								if( !attacker HasPerk( level.trial_current.config.reqPerk ) )
									return;
							if( isdefined( level.trial_current.config.reqAAT ) )
							{
								if( attacker aat::getaatonweapon( weapon ).name !== level.trial_current.config.reqAAT )
									if( !( IsAI( attacker ) && isdefined( attacker.aat_turned ) && attacker.aat_turned ) )
										return;
								switch( level.trial_current.config.reqAAT )
								{
									case "zm_aat_blast_furnace": {
										if( !IS_TRUE( self.blastfurnace_death ) ) {
											IPrintLnBold( "^1ZOMBIE NOT KILLED WITH BLASTFURNACE AAT" );
											return;
										}
										break;
									}
									case "zm_aat_thunder_wall": {
										if( !IS_TRUE( self.thunderwall_death ) ) {
											IPrintLnBold( "^1ZOMBIE NOT KILLED WITH THUNDERWALL AAT" );
											return;
										}
										break;
									}
									case "zm_aat_fire_works": {
										if( !IS_TRUE( self.firework_death ) ) {
											IPrintLnBold( "^1ZOMBIE NOT KILLED WITH FIREWORKS AAT" );
											return;
										}
										break;
									}
									case "zm_aat_dead_wire": {
										if( !IS_TRUE( self.deadwire_death ) ) {
											IPrintLnBold( "^1ZOMBIE NOT KILLED WITH DEADWIRE AAT" );
											return;
										}
										break;
									}
									case "zm_aat_turned": {
										if( !IS_TRUE( self.turned_death ) ) {
											IPrintLnBold( "^1ZOMBIE NOT KILLED WITH TURNED AAT" );
											return;
										}
										break;
									}
								}
							}
							level.trial_current_value++;
							
							IPrintLnBold( "VALUE: ^2" + level.trial_current_value + "/" + level.trial_current.config.value );
						}
					}
					break;
				}
			}
		}
	}
}

function zombienotetrackmeleefire( entity )
{
	if( isdefined( entity.aat_turned ) && entity.aat_turned )
	{
		if( isdefined( entity.enemy ) && !IsPlayer( entity.enemy ) )
		{
			if( entity.enemy.archetype === "zombie" && ( isdefined( entity.enemy.allowdeath ) && entity.enemy.allowdeath ) )
			{
				entity.enemy.turned_death = true;
				gibserverutils::gibhead(entity.enemy);
				entity.enemy zombie_utility::gib_random_parts();
				entity.enemy trial_watch_death( entity );
				entity.enemy Kill();
				entity.n_aat_turned_zombie_kills++;
			}
			else {
				if( entity.enemy.archetype === "zombie_quad" || entity.enemy.archetype === "spider" && ( isdefined( entity.enemy.allowdeath ) && entity.enemy.allowdeath ) )
				{
					entity.enemy.turned_death = true;
					entity.enemy Kill();
					entity.n_aat_turned_zombie_kills++;
				}
				else if( isdefined( entity.enemy.canbetargetedbyturnedzombies ) && entity.enemy.canbetargetedbyturnedzombies )
					entity Melee();
			}
		}
	}
	else
	{
		if( isdefined( entity.enemy ) && ( isdefined( entity.enemy.bgb_in_plain_sight_active ) && entity.enemy.bgb_in_plain_sight_active || ( isdefined( entity.enemy.bgb_idle_eyes_active ) && entity.enemy.bgb_idle_eyes_active ) ) )
			return;
		if( isdefined( entity.enemy ) && ( isdefined( entity.enemy.allow_zombie_to_target_ai ) && entity.enemy.allow_zombie_to_target_ai ) ) {
			if( entity.enemy.health > 0 )
				entity.enemy DoDamage( entity.meleeweapon.meleedamage, entity.origin, entity, entity, "none", "MOD_MELEE" );
			return;
		}
		entity Melee();
        
		if( zombieshouldattackobject( entity ) )
			if( isdefined( level.attackablecallback ) )
				entity.attackable [ [ level.attackablecallback ] ]( entity );
	}
}

function zombieshouldattackobject( entity )
{
	if( isdefined( entity.missinglegs ) && entity.missinglegs )
		return false;
	if( isdefined( entity.enemyoverride ) && isdefined( entity.enemyoverride[ 1 ] ) )
		return false;
	if( isdefined( entity.favoriteenemy ) && ( isdefined( entity.favoriteenemy.b_is_designated_target ) && entity.favoriteenemy.b_is_designated_target ) )
		return false;
	if( isdefined( entity.aat_turned ) && entity.aat_turned )
		return false;
	if( isdefined( entity.attackable ) && ( isdefined( entity.attackable.is_active ) && entity.attackable.is_active ) )
		if( isdefined( entity.is_at_attackable ) && entity.is_at_attackable )
			return true;
	return false;
}

function test_distance()
{
	while( 1 )
	{
		wait( 1 );
		dist = self get_distance_traveled( "mi", 1 );
		IPrintLnBold( dist[ 0 ] + dist[ 1 ] + "/" + "1.0mi" );
	}
}

function get_distance_traveled( unit = "in", has_unit )
{
	len = Float( ( ( self.pers[ "distance_traveled" ] > 0 ) ? self.pers[ "distance_traveled" ] : 0 ) );

	if( len > 0 )
	{
		switch( unit )
		{
			case "in":
				convert_len = 1;
				break;
			case "ft":
				convert_len = 12;
				break;
			case "yd":
				convert_len = 36;
				break;
			case "m":
				convert_len = 39.37;
				break;
			case "km":
				convert_len = 39370;
				break;
			case "mi":
				convert_len = 63360;
				break;
			default:
				convert_len = 1;
				unit = "in";
				break;
		}
		len /= convert_len;
	}
	return ( ( has_unit ) ? array( len, unit ) : len );
}
