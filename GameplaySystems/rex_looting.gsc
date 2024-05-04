//*****************************************************************************
// USINGS
//*****************************************************************************

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

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\shared\system_shared;

#using scripts\shared\hud_shared;
#using scripts\shared\hud_util_shared;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;

#using scripts\shared\ai\zombie_utility;

#using scripts\zm\logical\logical_utility;

#insert scripts\zm\log_looting.gsh;

//*****************************************************************************
// DEFINES
//*****************************************************************************

// SOUNDS
#define CHEST_OPEN_TRASHCAN_SOUND				"log_looting_open_common"
#define CHEST_OPEN_LOCKER_SOUND					"log_looting_open_common"
#define CHEST_OPEN_SAFE_SOUND					"log_looting_open_common"
#define CHEST_OPEN_WEAPONCRATE_SOUND			"log_looting_open_common"
#define CHEST_OPEN_LEGENDARYCRATE_SOUND			"log_looting_open_common"

#define LOOT_SOUND_TAKE_AMMO					"log_looting_take_common"
#define LOOT_SOUND_TAKE_POINTS_SM				"log_looting_take_gold_sm"
#define LOOT_SOUND_TAKE_POINTS_LG				"log_looting_take_gold_lg"
#define LOOT_SOUND_TAKE_WEAPONS					"log_looting_take_weapon"
#define LOOT_SOUND_TAKE_WEAPONS_LEGENDARY		"log_looting_take_legendary"
#define LOOT_SOUND_TAKE_PERKS					"log_looting_take_legendary"
#define LOOT_SOUND_TAKE_POWERUP					"log_looting_take_common"

#define LOOT_DEFAULT_SPAWN_SOUND				""
#define LOOT_LEGENDARY_SPAWN_SOUND				"log_looting_spawn_legendary"

#define LOOT_CHEST_AMBIENT_SOUND				"log_looting_chest_amb_loop"


// STRINGS
#define CHEST_TRASHCAN_HINTSTRING				"LOG_LOOTING_CHEST_TRASHCAN_HINTSTRING"
#define CHEST_LOCKER_HINTSTRING					"LOG_LOOTING_CHEST_LOCKER_HINTSTRING"
#define CHEST_SAFE_HINTSTRING					"LOG_LOOTING_CHEST_SAFE_HINTSTRING"
#define CHEST_WEAPONCRATE_HINTSTRING			"LOG_LOOTING_CHEST_WEAPONCRATE_HINTSTRING"
#define CHEST_LEGENDARYCRATE_HINTSTRING			"LOG_LOOTING_CHEST_LEGENDARYCRATE_HINTSTRING"

#define LOOT_TAKE_AMMO							"LOG_LOOTING_LOOT_TAKE_AMMO"
#define LOOT_TAKE_MAX_AMMO						"LOG_LOOTING_LOOT_TAKE_MAX_AMMO"
#define LOOT_TAKE_POINTS						"LOG_LOOTING_LOOT_TAKE_POINTS"
#define LOOT_TAKE_PERK							"LOG_LOOTING_LOOT_TAKE_PERK"
#define LOOT_TAKE_WEAPON                        "LOG_LOOTING_LOOT_TAKE_WEAPON"
#define LOOT_TAKE_POWERUP_INSTAKILL             "LOG_LOOTING_LOOT_TAKE_POWERUP_INSTAKILL"
#define LOOT_TAKE_POWERUP_DOUBLEPOINTS          "LOG_LOOTING_LOOT_TAKE_POWERUP_DOUBLEPOINTS"
#define LOOT_TAKE_POWERUP_FIRESALE              "LOG_LOOTING_LOOT_TAKE_POWERUP_FIRESALE"


// FX
#define LOOT_TRAIL_FX_AMMO 						"_logical_fx/looting/loot_trail_fx_ammo"
#define LOOT_READY_FX_AMMO 						"_logical_fx/looting/loot_ready_fx_ammo"
#define LOOT_TRAIL_FX_POINTS 					"_logical_fx/looting/loot_trail_fx_points"
#define LOOT_READY_FX_POINTS 					"_logical_fx/looting/loot_ready_fx_points"
#define LOOT_TRAIL_FX_WEAPONS 					"_logical_fx/looting/loot_trail_fx_weapons"
#define LOOT_READY_FX_WEAPONS 					"_logical_fx/looting/loot_ready_fx_weapons"
#define LOOT_TRAIL_FX_PERKS 					"_logical_fx/looting/loot_trail_fx_perks"
#define LOOT_READY_FX_PERKS 					"_logical_fx/looting/loot_ready_fx_perks"
#define LOOT_TRAIL_FX_POWERUPS 					"_logical_fx/looting/loot_trail_fx_powerups"
#define LOOT_READY_FX_POWERUPS 					"_logical_fx/looting/loot_ready_fx_powerups"

//*****************************************************************************
// PRECACHE
//*****************************************************************************

// LOOT CHEST MODELS
#precache( "xmodel", TRASHCAN_CHEST_MODEL );
#precache( "xmodel", LOCKER_CHEST_MODEL );
#precache( "xmodel", SAFE_CHEST_MODEL );
#precache( "xmodel", WEAPONCRATE_CHEST_MODEL );
#precache( "xmodel", LEGENDARYCRATE_CHEST_MODEL );

// LOOT POOL MODELS
#precache( "xmodel", LOOTPOOL_POINTS_MODEL_SM );
#precache( "xmodel", LOOTPOOL_POINTS_MODEL_LG );
#precache( "xmodel", LOOTPOOL_AMMO_MODEL_SM );
#precache( "xmodel", LOOTPOOL_AMMO_MODEL_LG );
#precache( "xmodel", LOOTPOOL_POWERUP_MODEL_DP );
#precache( "xmodel", LOOTPOOL_POWERUP_MODEL_IK );
#precache( "xmodel", LOOTPOOL_POWERUP_MODEL_FS );

// STRINGS
#precache( "string", "LOG_LOOTING_CHEST_TRASHCAN_HINTSTRING" );
#precache( "string", "LOG_LOOTING_CHEST_LOCKER_HINTSTRING" );
#precache( "string", "LOG_LOOTING_CHEST_SAFE_HINTSTRING" );
#precache( "string", "LOG_LOOTING_CHEST_WEAPONCRATE_HINTSTRING" );
#precache( "string", "LOG_LOOTING_CHEST_LEGENDARYCRATE_HINTSTRING" );

#precache( "string", "LOG_LOOTING_LOOT_TAKE_AMMO" );
#precache( "string", "LOG_LOOTING_LOOT_TAKE_MAX_AMMO" );
#precache( "string", "LOG_LOOTING_LOOT_TAKE_POINTS" );
#precache( "string", "LOG_LOOTING_LOOT_TAKE_PERK" );
#precache( "string", "LOG_LOOTING_LOOT_TAKE_WEAPON" );
#precache( "string", "LOG_LOOTING_LOOT_TAKE_POWERUP_INSTAKILL" );
#precache( "string", "LOG_LOOTING_LOOT_TAKE_POWERUP_DOUBLEPOINTS" );
#precache( "string", "LOG_LOOTING_LOOT_TAKE_POWERUP_FIRESALE" );


// FX
#precache( "fx", "_logical_fx/looting/loot_trail_fx_ammo");
#precache( "fx", "_logical_fx/looting/loot_ready_fx_ammo");
#precache( "fx", "_logical_fx/looting/loot_trail_fx_points");
#precache( "fx", "_logical_fx/looting/loot_ready_fx_points");
#precache( "fx", "_logical_fx/looting/loot_trail_fx_weapons");
#precache( "fx", "_logical_fx/looting/loot_ready_fx_weapons");
#precache( "fx", "_logical_fx/looting/loot_trail_fx_perks");
#precache( "fx", "_logical_fx/looting/loot_ready_fx_perks");
#precache( "fx", "_logical_fx/looting/loot_trail_fx_powerups");
#precache( "fx", "_logical_fx/looting/loot_ready_fx_powerups");

// ANIMS
#precache( "xanim", "rex_loot_safe_open" );
#precache( "xanim", "rex_loot_nuclear_open" );
#precache( "xanim", "rex_loot_weapon_open" );
#precache( "xanim", "rex_loot_locker_open" );

#using_animtree( "animtree_looting" );

//*****************************************************************************
// MAIN
//*****************************************************************************

#namespace log_looting;

REGISTER_SYSTEM_EX( "log_looting", &init, &log_main, undefined )

function autoexec pre_init()
{
	// TESTING MODE - SET TO FALSE FOR RELEASE
	//level.log_debug = true;

	// SETUP AMMO LOOT POOL
	level.log_lootpool_ammo = [];

	level.log_lootpool_ammo[0] = "refill_clip";
	level.log_lootpool_ammo[1] = "max_ammo";

	// SETUP POINTS LOOT POOL
	level.log_lootpool_points = [];

	level.log_lootpool_points[0] = 100;
	level.log_lootpool_points[1] = 250;
	level.log_lootpool_points[2] = 500;
	level.log_lootpool_points[3] = 1000;
	level.log_lootpool_points[4] = 1500;
	level.log_lootpool_points[5] = 2500;
	level.log_lootpool_points[6] = 5000;

	level.log_lootpool_weapons = array( 
		LOG_LOOTPOOL_WEAPONS_PISTOLS,
		LOG_LOOTPOOL_WEAPONS_ARS,
		LOG_LOOTPOOL_WEAPONS_SMGS,
		LOG_LOOTPOOL_WEAPONS_LMGS,
		LOG_LOOTPOOL_WEAPONS_RPGS,
		LOG_LOOTPOOL_WEAPONS_SHOTGUNS,
		LOG_LOOTPOOL_WEAPONS_SNIPERS,
		LOG_LOOTPOOL_WEAPONS_MELEES,
		LOG_LOOTPOOL_WEAPONS_WONDERWEAPONS
	);

	// SETUP POEWRUPS - POEWRUPS LOOT POOL
	level.lootpool_powerups = array( SpawnStruct(), SpawnStruct(), SpawnStruct() );
    level.lootpool_powerups[ 0 ].powerup_type = "insta_kill";
    level.lootpool_powerups[ 0 ].model = LOOTPOOL_POWERUP_MODEL_IK;
    level.lootpool_powerups[ 0 ].hint = LOOT_TAKE_POWERUP_INSTAKILL;

    level.lootpool_powerups[ 1 ].powerup_type = "double_points";
    level.lootpool_powerups[ 1 ].model = LOOTPOOL_POWERUP_MODEL_DP;
    level.lootpool_powerups[ 1 ].hint = LOOT_TAKE_POWERUP_DOUBLEPOINTS;

    level.lootpool_powerups[ 2 ].powerup_type = "fire_sale";
    level.lootpool_powerups[ 2 ].model = LOOTPOOL_POWERUP_MODEL_FS;
    level.lootpool_powerups[ 2 ].hint = LOOT_TAKE_POWERUP_FIRESALE;

}

function init()
{
	// KEYLINES
	clientfield::register( "scriptmover", "enable_keyline_green", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "enable_keyline_white", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "enable_keyline_blue", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "enable_keyline_red", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "enable_keyline_orange", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "enable_keyline_chest", VERSION_SHIP, 1, "int" );
}

function log_main()
{
	if(level.log_debug)
		level waittill("initial_blackscreen_passed");

	// SETUP LOOT CHESTS
	level thread setup_loot_boxes();
}

//*****************************************************************************
// LOOT CHEST UNITRIGGER
//*****************************************************************************

function log_uni_trig_prompt_visibility(player)
{
	can_use = self log_uni_trig_visibility(player);

	if(isdefined(self.hint_string))
		self SetHintString(self.hint_string);

	return can_use;
}

function log_uni_trig_visibility(player)
{
	if( !player log_util::log_is_player_valid() )
		return false;

	switch( self.stub.related_parent.script_string )
	{
		case "trashcan":
			self.hint_string = CHEST_TRASHCAN_HINTSTRING;
			break;
		case "locker":
			self.hint_string = CHEST_LOCKER_HINTSTRING;
			break;
		case "safe":
			self.hint_string = CHEST_SAFE_HINTSTRING;
			break;
		case "weaponcrate":
			self.hint_string = CHEST_WEAPONCRATE_HINTSTRING;
			break;
		case "legendarycrate":
			self.hint_string = CHEST_LEGENDARYCRATE_HINTSTRING;
			break;
	}
	return true;
}

//*****************************************************************************
// SETUP LOOT BOXES
//*****************************************************************************

function setup_loot_boxes()
{
	// DEFINE LOCATIONS
	spots = struct::get_array( "log_loot_spot", "targetname" );

	// DEFINE ARRAYS
	trashcans = [];
	lockers = [];
	safes = [];
	weaponcrates = [];
	legendarycrates = [];

	// FILL IN THE ARRAYS
	for( i = 0; i < spots.size; i ++ )
	{
	    switch( spots[ i ].script_string )
	    {
	        case "trashcan":
	            ARRAY_ADD( trashcans, spots[ i ] ); 
	            break;
	        case "locker":
	            ARRAY_ADD( lockers, spots[ i ] ); 
	            break;
	        case "safe":
	            ARRAY_ADD( safes, spots[ i ] ); 
	            break;
	        case "weaponcrate":
	            ARRAY_ADD( weaponcrates, spots[ i ] ); 
	            break; 
	        case "legendarycrate":
	            ARRAY_ADD( legendarycrates, spots[ i ] ); 
	            break; 
	    }
	}

	if(!level.log_debug)
	{
		// RANDOMIZE ARRAYS AND CHOOSE WHICH ONES TO SPAWN
		trashcans = array::randomize( trashcans );
		lockers = array::randomize( lockers );
		safes = array::randomize( safes );
		weaponcrates = array::randomize( weaponcrates );
		legendarycrates = array::randomize( legendarycrates );

		object_amounts = array(
		    RandomIntRange( TRASHCAN_CHEST_MIN_AMOUNT, TRASHCAN_CHEST_MAX_AMOUNT ),
		    RandomIntRange( LOCKER_CHEST_MIN_AMOUNT, LOCKER_CHEST_MAX_AMOUNT ),
		    RandomIntRange( SAFE_CHEST_MIN_AMOUNT, SAFE_CHEST_MAX_AMOUNT ),
		    RandomIntRange( WEAPONCRATE_CHEST_MIN_AMOUNT, WEAPONCRATE_CHEST_MAX_AMOUNT ),
		    RandomIntRange( LEGENDARYCRATE_CHEST_MIN_AMOUNT, LEGENDARYCRATE_CHEST_MAX_AMOUNT )
		);

		// REMOVE LEFT OVER UNUSED OBJECTS FROM EACH ARRAY TO EQUATE TO THE MAXIMUM SPAWNS GIVEN PER OBJECT ARRAY
		for( i = 0; i < object_amounts.size; i++ )
		{
		    switch( i )
		    {
		        case 0:
		            for( j = trashcans.size - 1; j > object_amounts[i]; j-- )
		                ArrayRemoveIndex( trashcans, j );
		            break;
		        case 1:
		            for( k = lockers.size - 1; k > object_amounts[i]; k-- )
		                ArrayRemoveIndex( lockers, k );
		            break;
		        case 2:
		            for( l = safes.size - 1; l > object_amounts[i]; l-- )
		                ArrayRemoveIndex( safes, l );
		            break;
		        case 3:
		            for( m = weaponcrates.size - 1; m > object_amounts[i]; m-- )
		                ArrayRemoveIndex( weaponcrates, m );
		            break;
		        case 4:
		            for( n = legendarycrates.size - 1; n > object_amounts[i]; n-- )
		                ArrayRemoveIndex( legendarycrates, n );
		            break;
		    }
		}
	}

	totalamount = ( object_amounts[ 0 ] - 1 ) + ( object_amounts[ 1 ] - 1 ) + ( object_amounts[2 ] - 1 ) + ( object_amounts[ 3 ] - 1 ) + ( object_amounts[ 4 ] - 1 );

	if( level.log_debug )
	{
		IPrintLnBold( "Total Amount = ^7" + totalamount );
		IPrintLnBold( "Trashcan Chest Amount: ^7" + trashcans.size );
		IPrintLnBold( "Locker Chest Amount: ^7" + lockers.size );
		IPrintLnBold( "Safe Chest Amount: ^7" + safes.size );
		IPrintLnBold( "Weapon Crate Chest Amount: ^7" + weaponcrates.size );
		IPrintLnBold( "Legendary Crate Chest Amount: ^7" + legendarycrates.size );
	}

	// THREAD REMAINING ARRAY OBJECTS
	array::thread_all( trashcans, &loot_box_logic, 0, TRASHCAN_CHEST_MODEL, CHEST_OPEN_TRASHCAN_SOUND, %rex_loot_trashcan_open );
	array::thread_all( lockers, &loot_box_logic, 1, LOCKER_CHEST_MODEL, CHEST_OPEN_LOCKER_SOUND, %rex_loot_locker_open );
	array::thread_all( safes, &loot_box_logic, 2, SAFE_CHEST_MODEL, CHEST_OPEN_SAFE_SOUND,  %rex_loot_safe_open );
	array::thread_all( weaponcrates, &loot_box_logic, 3, WEAPONCRATE_CHEST_MODEL, CHEST_OPEN_WEAPONCRATE_SOUND, %rex_loot_weapon_open );
	array::thread_all( legendarycrates, &loot_box_logic, 4, LEGENDARYCRATE_CHEST_MODEL, CHEST_OPEN_LEGENDARYCRATE_SOUND, %rex_loot_nuclear_open );
}

function spawn_lootcrate( spots, rarity )
{
	switch( rarity )
	{
		case 0:
			array::thread_all( spots, &loot_box_logic, 0, TRASHCAN_CHEST_MODEL, CHEST_OPEN_TRASHCAN_SOUND, %rex_loot_trashcan_open );
			break;
		case 1:
			array::thread_all( spots, &loot_box_logic, 1, LOCKER_CHEST_MODEL, CHEST_OPEN_LOCKER_SOUND, %rex_loot_locker_open );
			break;
		case 2:
			array::thread_all( spots, &loot_box_logic, 2, SAFE_CHEST_MODEL, CHEST_OPEN_SAFE_SOUND,  %rex_loot_safe_open );
			break;
		case 3:
			array::thread_all( spots, &loot_box_logic, 3, WEAPONCRATE_CHEST_MODEL, CHEST_OPEN_WEAPONCRATE_SOUND, %rex_loot_weapon_open );
			break;
		case 4:
			array::thread_all( spots, &loot_box_logic, 4, LEGENDARYCRATE_CHEST_MODEL, CHEST_OPEN_LEGENDARYCRATE_SOUND, %rex_loot_nuclear_open );
			break;
	}
}

//*****************************************************************************
// LOOT BOX MASTER LOGIC
//*****************************************************************************

function loot_box_logic( rarity, model_type, sound, animation )
{	
	//chest_outline = util::spawn_model( model_type, self.origin, self.angles );
	chest = util::spawn_model( model_type, self.origin, self.angles );
	chest PlayLoopSound( LOOT_CHEST_AMBIENT_SOUND );

	//chest_outline thread SetEventKeyline( "enable_keyline_chest", "chest_opened", array( 1, 0 ), true );
	
	self log_util::log_uni_trig_create( "", undefined, 50, &log_uni_trig_prompt_visibility );
	self waittill("trigger_activated", player);

	self flag::set( "chest_opened" );
	
	chest StopLoopSound();

	zm_unitrigger::unregister_unitrigger( self.s_unitrigger );

	chest UseAnimTree( #animtree );
	//chest_outline UseAnimTree( #animtree );

	if( isdefined( animation ) )
		//chest_outline AnimScripted( "", chest_outline.origin, chest_outline.angles, animation );
		chest AnimScripted( "", chest.origin, chest.angles, animation );
			wait( GetAnimLength( animation ) / 1.5 );

	//chest_outline Delete();

	switch( rarity )
	{
		case 0:
			drops = RandomIntRange( LOOT_MIN_TRASH_DROPS, LOOT_MAX_TRASH_DROPS + 1 );

			if(level.log_debug)
        		IPrintLnBold( "Drop Amount: " + drops );

			for( i = 0; i < drops; i++ )
			{	
				self thread trashcan_loot_logic( player, rarity, 32 );
                	wait( 0.25 );
			}
			break;

		case 1: 
			drops = RandomIntRange( LOOT_MIN_LOCKER_DROPS, LOOT_MAX_LOCKER_DROPS + 1 );

			if(level.log_debug)
        		IPrintLnBold( "Drop Amount: " + drops );

			for( i = 0; i < drops; i++ )
			{
				self thread locker_loot_logic( player, rarity, 42 );
                	wait( 0.25 );
			}
			break;

		case 2:
			drops = RandomIntRange( LOOT_MIN_SAFE_DROPS, LOOT_MAX_SAFE_DROPS + 1 );

			if(level.log_debug)
        		IPrintLnBold( "Drop Amount: " + drops );

			for( i = 0; i < drops; i++ )
			{
                self thread safe_loot_logic( player, rarity, 16 );
                	wait( 0.25 );
			}
			break;

		case 3:
			drops = RandomIntRange( LOOT_MIN_WEAPONCRATE_DROPS, LOOT_MAX_WEAPONCRATE_DROPS + 1 );

			if(level.log_debug)
        		IPrintLnBold( "Drop Amount: " + drops );

			for( i = 0; i < drops; i++ )
			{
                self thread weaponcrate_loot_logic( player, rarity, 16 );
                	wait( 0.25 );
			}
			break;

		case 4:
			drops = RandomIntRange( LOOT_MIN_LEGENDARY_DROPS, LOOT_MAX_LEGENDARY_DROPS + 1 );

			if(level.log_debug)
        		IPrintLnBold( "Drop Amount: " + drops );

			for( i = 0; i < drops; i++ )
			{
                self thread legendary_loot_logic( player, rarity, 16 );
                	wait( 0.25 );
			}
			break;
	}
}

//*****************************************************************************
// LOOT CHANCE LOGIC
//*****************************************************************************

// TRASHCAN LOOT LOGIC
function trashcan_loot_logic( player, rarity, z_origin )
{
	// DEFAULT
	chance = RandomIntRange( 1, 100 + 1 );

	if(level.log_debug)
		IPrintLnBold( "Loot Chance Number: " + chance );

	if( chance <= 25 )
	{
		if( chance <= 25 && chance > 5 ) 	// Ammo 20, 5 - 25%
            self thread lootpool_ammo( 0, z_origin );
        else if( chance <= 5 )
            self thread lootpool_ammo( 1, z_origin );
	}
	else if( chance <= 66 && chance >= 26 )	// Points 66, 41, 31, 26 - 41%
	{
		if( chance <= 66 && chance > 41 )
            self thread lootpool_points( 0, z_origin );
        else if( chance <= 41 && chance > 31 )
            self thread lootpool_points( 1, z_origin );
        else if( chance <= 31 && chance > 26 )
            self thread lootpool_points( 2, z_origin );
        else if( chance == 26 )
            self thread lootpool_points( 3, z_origin );
	}
	else if( chance <= 84 && chance > 66 ) // Weapons 84, 66 - 18%
        self thread lootpool_weapons( player, 0, z_origin );
	else if( chance == 85 )					// Perk 85 - 1%
        self thread lootpool_perks( z_origin );
	else if( chance <= 100 && chance > 85 )	// Powerup 85, 100 - 15%
	{
		random_num = RandomInt( level.lootpool_powerups.size );
        self thread lootpool_powerups( level.lootpool_powerups[ random_num ].model, level.lootpool_powerups[ random_num ].powerup_type, level.lootpool_powerups[ random_num ].hint, z_origin );
	}
}


// LOCKER LOOT LOGIC
function locker_loot_logic( player, rarity, z_origin )
{
	chance = RandomIntRange( 1, 100 + 1 );

	if(level.log_debug)
		IPrintLnBold( "Loot Chance Number: " + chance );

	if( chance <= 4 )
        self thread lootpool_ammo( 1, z_origin );
	else if( chance <= 15 && chance > 4 ) // Points
	{
		if( chance <= 8 && chance > 4 )
            self thread lootpool_points( 2, z_origin );
        else if( chance <= 11 && chance > 8 )
            self thread lootpool_points( 3, z_origin );
        else if( chance <= 13 && chance > 11 )
            self thread lootpool_points( 4, z_origin );
        else if( chance == 14 )
            self thread lootpool_points( 5, z_origin );
	}
	else if( chance <= 72 && chance > 14 ) // Weapons
	{
		if( chance <= 19 && chance > 14 )
        	self thread lootpool_weapons( player, 0, z_origin );
        else if( chance <= 29 && chance > 19 )
        	self thread lootpool_weapons( player, 1, z_origin );
        else if( chance <= 39 && chance > 29 )
        	self thread lootpool_weapons( player, 2, z_origin );
        else if( chance <= 49 && chance > 39 )
        	self thread lootpool_weapons( player, 3, z_origin );
        else if( chance <= 54 && chance > 49 )
        	self thread lootpool_weapons( player, 4, z_origin );
        else if( chance <= 60 && chance > 54 )
        	self thread lootpool_weapons( player, 5, z_origin );
        else if( chance <= 65 && chance > 60 )
        	self thread lootpool_weapons( player, 6, z_origin );
        else if( chance <= 70 && chance > 65 )
        	self thread lootpool_weapons( player, 7, z_origin );
        else if( chance == 71 )
        	self thread lootpool_weapons( player, 8, z_origin );
	}
	else if( chance <= 91 && chance > 71 ) // Perks
        self thread lootpool_perks( z_origin );
	else if( chance > 91 ) // Powerups
	{
		random_num = RandomInt( level.lootpool_powerups.size );
        self thread lootpool_powerups( level.lootpool_powerups[ random_num ].model, level.lootpool_powerups[ random_num ].powerup_type, level.lootpool_powerups[ random_num ].hint, z_origin );
	}
}

// SAFE LOOT LOGIC
function safe_loot_logic( player, rarity, z_origin )
{
	chance = RandomIntRange( 1, 100 + 1 );

	if(level.log_debug)
		IPrintLnBold( "Loot Chance Number: " + chance );

	if( chance <= 10 )
        self thread lootpool_ammo( 1, z_origin );
	else if( chance <= 85 && chance > 10 ) // Points
	{
		if( chance <= 40 && chance > 10 )
            self thread lootpool_points( 3, z_origin );
        else if( chance <= 60 && chance > 40 )
            self thread lootpool_points( 4, z_origin );
        else if( chance <= 75 && chance > 60 )
            self thread lootpool_points( 5, z_origin );
        else if( chance <= 85 && chance > 75 )
            self thread lootpool_points( 6, z_origin );
	}
	else if( chance <= 88 && chance > 85 ) // Weapons
		self thread lootpool_weapons( player, 8, z_origin );
	else if( chance > 88 ) // Perks
        self thread lootpool_perks( z_origin );
}

// WEAPONCRATE LOOT LOGIC
function weaponcrate_loot_logic( player, rarity, z_origin )
{
	chance = RandomIntRange( 1, 100 + 1 );

	if(level.log_debug)
		IPrintLnBold( "Loot Chance Number: " + chance );

	if( chance <= 10 )
        self thread lootpool_ammo( 1, z_origin );
	else if( chance <= 25 && chance > 10 ) // Points
	{
		if( chance <= 20 && chance > 10 )
            self thread lootpool_points( 5, z_origin );
        else if( chance <= 25 && chance > 20 )
            self thread lootpool_points( 6, z_origin );
	}
	else if( chance <= 90 && chance > 25 ) // Weapons
	{
		if( chance <= 40 && chance > 25 )
            self thread lootpool_weapons( player, 1, z_origin );
        else if( chance <= 50 && chance > 40 )
            self thread lootpool_weapons( player, 2, z_origin );
        else if( chance <= 60 && chance > 50 )
            self thread lootpool_weapons( player, 3, z_origin );
        else if( chance <= 65 && chance > 60 )
            self thread lootpool_weapons( player, 4, z_origin );
        else if( chance <= 70 && chance > 65 )
            self thread lootpool_weapons( player, 5, z_origin );
        else if( chance <= 75 && chance > 70 )
            self thread lootpool_weapons( player, 6, z_origin );
        else if( chance <= 80 && chance > 75 )
            self thread lootpool_weapons( player, 7, z_origin );
        else if( chance <= 85 && chance > 80 )
            self thread lootpool_weapons( player, 8, z_origin );
	}
	else if( chance > 85 ) // Perks
        self thread lootpool_perks( z_origin );
}

// LEGENDARY LOOT LOGIC
function legendary_loot_logic( player, rarity, z_origin )
{
	chance = RandomIntRange( 1, 100 + 1 );

	if(level.log_debug)
		IPrintLnBold( "Loot Chance Number: " + chance );

	if( chance <= 25 )
        self thread lootpool_ammo( 1, z_origin );
	else if( chance <= 50 && chance > 25 ) // Points
		self thread lootpool_points( 6, z_origin );
	else if( chance <= 75 && chance > 50 ) // Weapons
        self thread lootpool_weapons( player, 8, z_origin );
	else if( chance > 75 ) // Perks
        self thread lootpool_perks( z_origin );
}

//*****************************************************************************
// LOOT POOL LOGIC
//*****************************************************************************

// AMMO LOOT POOL
function lootpool_ammo( rarity, z_origin )
{
    model = ( ( rarity ) ? LOOTPOOL_AMMO_MODEL_LG : LOOTPOOL_AMMO_MODEL_SM );
    hintstring = ( ( rarity ) ? LOOT_TAKE_MAX_AMMO : LOOT_TAKE_AMMO );
	weight = ( ( rarity ) ? LOOT_WEIGHT_AMMO_LG : LOOT_WEIGHT_AMMO_SM );

    loot = util::spawn_model( model, self.origin + ( 0 , 0, z_origin ), self.angles );
    loot loot_drop_logic( weight, 0, "enable_keyline_white" );

    loot log_util::log_uni_trig_create( hintstring, undefined, 50, &log_uni_trig_loot_prompt_visibility );
    loot thread loot_drop_timeout( LOOT_DROP_TIMER );

    loot waittill( "trigger_activated", player );

	player PlaySound( "loot_grab_default" );

    switch( rarity )
    {
        case 0: // FILL ONE WEAPON
        	if( level.log_debug )
        		IPrintLnBold( "Fill One Weapon" );

            current_weapon = player GetCurrentWeapon();
            player SetWeaponAmmoStock( current_weapon, current_weapon.maxAmmo );
            break;
        case 1: // FILL ALL WEAPONS
        	if( level.log_debug )
        		IPrintLnBold( "Fill All Weapons" );

            weapon_list = player GetWeaponsListPrimaries();
            for( j = 0; j < weapon_list.size; j++ )
                player SetWeaponAmmoStock( weapon_list[ j ], weapon_list[ j ].maxAmmo );
            break;
    }

    zm_unitrigger::unregister_unitrigger( loot.s_unitrigger );

    loot Delete();
}

// POINTS LOOT POOL
function lootpool_points( rarity, z_origin )
{
	model = ( ( level.log_lootpool_points[ rarity ] < 1000 ) ? LOOTPOOL_POINTS_MODEL_SM : LOOTPOOL_POINTS_MODEL_LG );
	weight = ( ( level.log_lootpool_points[ rarity ] < 1000 ) ? LOOT_WEIGHT_POINTS_SM : LOOT_WEIGHT_POINTS_LG );

    loot = util::spawn_model( model, self.origin + ( 0 , 0, z_origin ), self.angles );

    loot loot_drop_logic( weight, 1, "enable_keyline_green" );
        
    hintstring = LOOT_TAKE_POINTS;

    loot log_util::log_uni_trig_create( hintstring, undefined, 50, &log_uni_trig_loot_prompt_visibility );
    loot thread loot_drop_timeout( LOOT_DROP_TIMER );

    loot waittill( "trigger_activated", player );

	sound = ( ( level.log_lootpool_points[ rarity ] < 1000 ) ? LOOT_SOUND_TAKE_POINTS_SM : LOOT_SOUND_TAKE_POINTS_LG );
	player PlaySound( sound );

	if(level.log_debug)
		IPrintLnBold( "Add Points: " + level.log_lootpool_points[ rarity ] );

    player zm_score::add_to_player_score( level.log_lootpool_points[ rarity ] );

    zm_unitrigger::unregister_unitrigger( loot.s_unitrigger );

    loot Delete();
}

// WEAPONS LOOT POOL
function lootpool_weapons( player, weapon_type, z_origin, is_legendary = undefined )
{
    WeaponSelection = undefined;

    weapons = StrTok( level.log_lootpool_weapons[ weapon_type ], "," );

    WeaponSelection = weapons[ GetArrayKeys( weapons )[ RandomInt( GetArrayKeys( weapons ).size ) ] ];
    weapon = GetWeapon( WeaponSelection );
	weapon.clip = weapon.clipSize;
	weapon.stock = weapon.maxAmmo;
    if(level.log_debug)
        IPrintLnBold( "Given Weapon: " + weapon.name );

	is_legendary = ( ( weapon_type == 8 ) ? true : undefined );

    switch( weapon_type )
    {
    	case 0: // PISTOLS
			weight = LOOT_WEIGHT_WEAPONS_PISTOLS;
			break;
		case 1: // ARS
			weight = LOOT_WEIGHT_WEAPONS_ARS;
			break;
		case 2: // SMGS
			weight = LOOT_WEIGHT_WEAPONS_SMGS;
			break;
		case 3: // LMGS
			weight = LOOT_WEIGHT_WEAPONS_LMGS;
			break;
		case 4: // RPG
			weight = LOOT_WEIGHT_WEAPONS_RPGS;
			break;
		case 5: // SHOTGUN
			weight = LOOT_WEIGHT_WEAPONS_SHOTGUNS;
			break;
		case 6: // SNIPER
			weight = LOOT_WEIGHT_WEAPONS_SNIPERS;
			break;
		case 7: // MELEE
			weight = LOOT_WEIGHT_WEAPONS_MELEES;
			break;
		case 8: // WW
			weight = LOOT_WEIGHT_WEAPONS_WONDERWEAPONS;
			break;
    }
	weapon_model = zm_utility::spawn_weapon_model( weapon, undefined, self.origin, self.angles );
	weapon_model loot_drop_logic( weight, 2, "enable_keyline_blue", is_legendary );
	weapon_model.weapon = weapon;
	weapon_model.timeout = 0;

    weapon_model log_util::log_uni_trig_create( "Hold ^3[{+activate}]^7 to pickup {{weapon_name}}", "HINT_WEAPON", 50, &log_uni_trig_loot_prompt_visibility );
    weapon_model thread loot_drop_timeout( LOOT_DROP_TIMER );
	
	while( isdefined( weapon_model ) )
	{
		weapon_model waittill( "trigger_activated", player );

		if( !player HasWeapon( weapon ) )
		{
			sound = ( ( zm_weapons::is_wonder_weapon( weapon ) ) ? LOOT_SOUND_TAKE_WEAPONS_LEGENDARY : LOOT_SOUND_TAKE_WEAPONS );
			if( player HasMaxPrimaryWeapons() )
			{
				zm_unitrigger::unregister_unitrigger( weapon_model.s_unitrigger );
				
				currentWeapon = player GetCurrentWeapon();
				currentWeapon.clip = player GetWeaponAmmoClip( currentWeapon );
				currentWeapon.stock = player GetWeaponAmmoStock( currentWeapon );

				player zm_weapons::weapon_give( weapon );
				player SwitchToWeapon( weapon );
				player SetWeaponAmmoClip( weapon, weapon.clip );
				player SetWeaponAmmoStock( weapon, weapon.stock );
				
				weapon_model UseWeaponModel( currentWeapon );
				weapon_model.interactor = player;

				weapon = currentWeapon;
				weapon.clip = currentWeapon.clip;
				weapon.stock = currentWeapon.stock;
				weapon_model.weapon = weapon;

				weapon_model log_util::log_uni_trig_create( "Hold [{+activate}] to pickup {{weapon_name}}", "HINT_WEAPON", 50, &log_uni_trig_loot_prompt_visibility );
			}
			else
			{
				zm_unitrigger::unregister_unitrigger( weapon_model.s_unitrigger );

				player zm_weapons::weapon_give( weapon );
				player SwitchToWeapon( weapon );
				weapon_model Delete();
			}
			player PlaySound( sound );
		}
	}
}

// PERKS LOOT POOL
function lootpool_perks( z_origin )
{
	a_str_perks = GetArrayKeys( level._custom_perks );

	excluded_perks = array( "specialty_deadshot", "specialty_additionalprimaryweapon" );

	for( e = 0; e < excluded_perks.size; e++ )
	    for( p = 0; p < level._custom_perks.size; p++ )
	        if( a_str_perks[ p ] == excluded_perks[ e ] )
	            ArrayRemoveIndex( a_str_perks, p );
	a_str_perks = array::randomize( a_str_perks );

	IPrintLnBold( a_str_perks[ 0 ] );

	perk_model = util::spawn_model( rex_get_perk_bottle_model( a_str_perks[ 0 ] ), self.origin + ( 0 , 0, z_origin ), self.angles );
	perk_model loot_drop_logic( LOOT_WEIGHT_PERKS, 3, "enable_keyline_orange",  true );

	perk_model log_util::log_uni_trig_create( LOOT_TAKE_PERK, undefined, 50, &log_uni_trig_loot_prompt_visibility );
	perk_model thread loot_drop_timeout( LOOT_DROP_TIMER );

	perk_model waittill( "trigger_activated", player );

	player PlaySound( LOOT_SOUND_TAKE_PERKS );

	player thread do_perk_buy( a_str_perks[ 0 ] );

	zm_unitrigger::unregister_unitrigger( perk_model.s_unitrigger );

    perk_model Delete();
}

function rex_get_perk_bottle_model( perk )
{
    return GetWeaponWorldModel( rex_get_perk_bottle( perk ) );
}

function rex_get_perk_bottle( perk )
{
    if( isdefined( level._custom_perks[ perk ].perk_bottle_weapon ) )
        return level._custom_perks[ perk ].perk_bottle_weapon;
    else if( isdefined( level.machine_assets[ perk ] ) )
        return level.machine_assets[ perk ];
    return level.weaponNone;
}

function do_perk_buy( perk )
{
    gun = self zm_perks::perk_give_bottle_begin( perk );
    evt = self util::waittill_any_return( "fake_death", "death", "player_downed", "weapon_change_complete", "perk_abort_drinking", "disconnect" );
    
	if ( evt == "weapon_change_complete" )
        self thread zm_perks::wait_give_perk( perk, true );
		
    self zm_perks::perk_give_bottle_end( gun, perk );

    if ( self laststand::player_is_in_laststand() || self.intermission )
        return;

    self notify( "burp" );
}


// POWERUP LOOT POOL
function lootpool_powerups( model, powerup, hint, z_origin )
{
    powerup_model = util::spawn_model( model, self.origin + ( 0, 0, z_origin ), self.angles );
    powerup_model loot_drop_logic( LOOT_WEIGHT_POWERUPS, 4, "enable_keyline_red" );

    powerup_model log_util::log_uni_trig_create( hint, undefined, 50, &log_uni_trig_loot_prompt_visibility );
    powerup_model thread loot_drop_timeout( LOOT_DROP_TIMER );
	powerup_model thread loot_drop_levitate( 10, 2.5 );
	powerup_model thread loot_drop_spin( 4 );

    powerup_model waittill( "trigger_activated", player );

	player PlaySound( LOOT_SOUND_TAKE_POWERUP );

    zm_powerups::specific_powerup_drop( powerup, player.origin );

    zm_unitrigger::unregister_unitrigger( powerup_model.s_unitrigger );

    powerup_model Delete();
}   

//*****************************************************************************
// LOOT PICKUP UNITRIGGER
//*****************************************************************************

function log_uni_trig_loot_prompt_visibility( player )
{
	can_use = self log_uni_trig_loot_visibility( player );

	if( isdefined( self.hint_string ) )
		self SetHintString( self.hint_string );
	return can_use;
}

function log_uni_trig_loot_visibility( player )
{
	if( !player log_util::log_is_player_valid() )
		return false;
	if( self.stub.is_weapon )
	{
		self.hint_string = "Hold ^3[{+activate}]^7 to pickup {{weapon_name}}";
	}
	return true;
}

//*****************************************************************************
// UTILITY
//*****************************************************************************

function loot_drop_logic( weight, loot_type, keyline, is_legendary )
{
	// MATH
    x = RandomFloat( 1 );
    y = RandomFloat( 1 );

    if( math::cointoss() )
        x *= -1;
    if( math::cointoss() )
        y *= -1;

    switch( loot_type )
    {
    	case 0: // AMMO
			trail_fx = LOOT_TRAIL_FX_AMMO;
			ready_fx = LOOT_READY_FX_AMMO;
			break;
		case 1: // POINTS
			trail_fx = LOOT_TRAIL_FX_POINTS;
			ready_fx = LOOT_READY_FX_POINTS;
			break;
		case 2: // WEAPONS
			trail_fx = LOOT_TRAIL_FX_WEAPONS;
			ready_fx = LOOT_READY_FX_WEAPONS;
			break;
		case 3: // PERKS
			trail_fx = LOOT_TRAIL_FX_PERKS;
			ready_fx = LOOT_READY_FX_PERKS;
			break;
		case 4: // POWERUPS
			trail_fx = LOOT_TRAIL_FX_POWERUPS;
			ready_fx = LOOT_READY_FX_POWERUPS;
			break;
    }
	if( isdefined( keyline ) )
		self SetKeyline( keyline );
	
    PlayFXOnTag( trail_fx, self, "tag_origin" );

	sound = ( ( isdefined( is_legendary ) ) ? LOOT_LEGENDARY_SPAWN_SOUND : LOOT_DEFAULT_SPAWN_SOUND );
	self PlaySound( sound );

    // LAUNCH
    self PhysicsLaunch( self.origin, ( AnglesToForward( self.angles ) + ( x, y, 0.5 ) ) * weight );
    self util::waitTillNotMoving();
		wait( 0.25 );

	self.angles = ( 0, self.angles[ 1 ], 0 );
	self.origin += ( 0, 0, 4 );

	PlayFXOnTag( ready_fx, self, "tag_origin" );
}

function loot_drop_timeout( time )
{	
	half_time = time / 2;
    wait( half_time );

	self.timeout = 0;
    while( self.timeout < half_time )
    {
		if( self.timeout % 2 )
			self Hide();
		else
			self Show();
        if( self.timeout < half_time / 2 )
            wait( 0.5 );
        else if( self.timeout < Ceil( half_time / 1.75 ) )
            wait( 0.25 );
        else
            wait( 0.1 );

		if( isdefined( self.interactor ) )
		{
			self Show(); 
			wait( half_time );
		}	
		self.timeout = ( ( isdefined( self.interactor ) ) ? 0 : self.timeout + 1 );
		self.interactor = undefined;
    }
    if( isdefined( self ) )
    {
        zm_unitrigger::unregister_unitrigger( self.s_unitrigger );
		self Delete();
    }
}

function SetKeyline( keyline ) 
{
	WAIT_SERVER_FRAME;
	clientfield::set( keyline, 1 );
}

function SetEventKeyline( keyline, str_notify, visibility, on_interact_delete )
{
	self flag::init( str_notify );

	WAIT_SERVER_FRAME;
	self clientfield::set( keyline, visibility[ 0 ] );

	while( !flag::get( str_notify ) )
		WAIT_SERVER_FRAME;
	
	WAIT_SERVER_FRAME;
	self clientfield::set( keyline, visibility[ 1 ] );

	if( on_interact_delete )
		self Delete();
}

function loot_drop_levitate( point, time )
{
	time = time / 2;
	while( isdefined( self ) )
	{
		self MoveZ( point, time / 1.15 );
			wait( time / 2 );
		self MoveZ( -point, time / 1.15 );
			wait( time / 2 );
	}
}

function loot_drop_spin( time )
{
	while( isdefined( self ) )
	{
		self RotateYaw( 360, time );
			wait( time / 1.1 );
	}
}
