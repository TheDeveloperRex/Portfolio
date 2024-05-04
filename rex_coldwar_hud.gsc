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
#using scripts\shared\system_shared;
#using scripts\shared\aat_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;
#insert scripts\zm\_zm_weapons.gsh;
#insert scripts\zm\_zm_perks.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_bgb_token;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_pers_upgrades_functions;

#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai\archetype_utility;

#define COMMON_SCRAP                "p9_sur_junk_parts_pile"
#define RARE_SCRAP                  "p9_sur_junk_parts_rare"
#define ARMOR_SATCHEL               "p9_zmb_armor_pickup_full"
#define ARMOR_PLATE                 "wpn_t9_eqp_armor_plate_world"
#define POINT_SYSTEM                true
#define LOOT_LIFETIME               30
#define SCRAP_MAX                   50000
#define SCRAP_COMMON                50
#define SCRAP_RARE                  10
#define SATCHEL_KILL_REQ_MIN        15 // 150
#define SATCHEL_KILL_REQ_MAX        75 // 750
#define BASE_PLAYER_HEALTH          150
#define ARMOR_PLATE_HEALTH          65
#define ARMOR_PLATE_DROP_HEALTH     15
#define ARMOR_PLATE_REDUCTION_MIN   0.25
#define ARMOR_PLATE_REDUCTION_MAX   0.45
#define ARMOR_PLATE_DAMAGE_MIN      12
#define ARMOR_PLATE_DAMAGE_MAX      25
#define PAP_AAT_COST                2000

#define PAP_WEAPON                  GetWeapon( "zombie_knuckle_crack" )
#define BUILDER_WEAPON              GetWeapon( "zombie_builder" )
#define FIST_WEAPON                 GetWeapon( "zombie_fists" )

#define SQUARED(x)                  ( x * x )

#precache( "string", "REX_COLDWAR_ZOMBIE_KILL" );
#precache( "string", "REX_COLDWAR_CRITICAL_KILL" );
#precache( "string", "REX_COLDWAR_MELEE_KILL" );

#precache( "menu", "ArmoryMenu" );
#precache( "menu", "PAPMenu" );

// REX - MUSIC SELECTOR
#precache( "menu", "MusicSelectorMenu" );

// REX - KEYPAD LOCK
#precache( "menu", "KeypadLockMenu" );
#precache( "eventstring", "KeypadEntryAction" );

// REX - Progression System
#precache( "menu", "ProgressionData" ); // Progression System
#precache( "eventstring", "WriteData" );
#precache( "eventstring", "RetrieveData" );
#precache( "eventstring", "RankPopup" );

#precache( "xmodel", COMMON_SCRAP );
#precache( "xmodel", RARE_SCRAP );
#precache( "xmodel", ARMOR_SATCHEL );
#precache( "xmodel", ARMOR_PLATE );

REGISTER_SYSTEM( "rex_coldwar_hud", &__init__, undefined )

function __init__()
{
    level.powerup_title = [];
    level.powerup_title[ "double_points" ] = "DOUBLE POINTS";
    level.powerup_title[ "insta_kill" ] = "INSTA KILL";
    level.powerup_title[ "fire_sale" ] = "FIRE SALE";
    level.powerup_title[ "full_ammo" ] = "MAX AMMO";
    level.powerup_title[ "free_perk" ] = "RANDOM PERK";
    level.powerup_title[ "carpenter" ] = "CARPENTER";
    level.powerup_title[ "minigun" ] = "FULL POWER";
    level.powerup_title[ "nuke" ] = "NUKE";

    level.rarity_keyline[ 0 ] = "loadout_keyline";
    level.rarity_keyline[ 1 ] = "common_keyline";
    level.rarity_keyline[ 2 ] = "uncommon_keyline";
    level.rarity_keyline[ 3 ] = "rare_keyline";
    level.rarity_keyline[ 4 ] = "epic_keyline";
    level.rarity_keyline[ 5 ] = "legendary_keyline";
    level.rarity_keyline[ 6 ] = "mythic_keyline";

    zm_utility::register_tactical_grenade_for_level( "cymbal_monkey" );
    zm_utility::register_tactical_grenade_for_level( "octobomb" );

    zm_equipment::register_for_level( "cymbal_monkey" );
    zm_equipment::register_for_level( "octobomb" );

    level.custom_treasure_chest_glowfx = &handle_box_glow;
    level.mystery_box_rarity = 0;

    level thread system_vars();

    level.satchel_kill_req = RandomIntRange( SATCHEL_KILL_REQ_MIN, ( SATCHEL_KILL_REQ_MAX + 1 ) );

    for( i = 0; i < 8; i++ )
    {
        clientfield::register( "world", ( "hudItems.PlayerCharIndex" + i ), VERSION_SHIP, 7, "int" );
        clientfield::register( "world", ( "hudItems.HealthBarNotif" + i ), VERSION_SHIP, 7, "float" );
        clientfield::register( "world", ( "hudItems.ShieldBarNotif" + i ), VERSION_SHIP, 7, "float" );
        clientfield::register( "world", ( "hudItems.ShieldBGNotif" + i ), VERSION_SHIP, 7, "float" );
        clientfield::register( "world", ( "hudItems.ShieldBar" + i ), VERSION_SHIP, 1, "int" );
    }
    clientfield::register( "clientuimodel", "hudItems.HealthBarNum", VERSION_SHIP, GetMinBitCountForNum( 250 ), "int" );
    clientfield::register( "clientuimodel", "hudItems.CommonScrap", VERSION_SHIP, GetMinBitCountForNum( SCRAP_MAX ), "int" );
    clientfield::register( "clientuimodel", "hudItems.RareScrap", VERSION_SHIP, GetMinBitCountForNum( SCRAP_MAX ), "int" );
    clientfield::register( "clientuimodel", "hudItems.Hitmarker", VERSION_SHIP, 2, "int" );

    clientfield::register( "scriptmover", "loadout_keyline", VERSION_SHIP, 1, "int" );
    clientfield::register( "scriptmover", "common_keyline", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "uncommon_keyline", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "rare_keyline", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "epic_keyline", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "legendary_keyline", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "mythic_keyline", VERSION_SHIP, 1, "int" );
	clientfield::register( "scriptmover", "loot_trail", VERSION_SHIP, 1, "int" ); 

    clientfield::register( "zbarrier", "magicbox_rarity_glow", VERSION_SHIP, 5, "int" );

    util::registerClientSys( "RarityNotif" );
    util::registerClientSys( "TierNotif" );
    util::registerClientSys( "PowerUpNotif" );
    util::registerClientSys( "MenuInfo" );
    util::registerClientSys( "KeypadEntry" );
    util::registerClientSys( "Progression" );

    level.scrap_types = array( 
        array( "common", 50, COMMON_SCRAP, 2 ),
        array( "rare", 50, RARE_SCRAP, 3 )
    );

    level.armor_types = array( 
        array( "plate", false, ARMOR_PLATE, 1 ),
        array( "satchel", true, ARMOR_SATCHEL, 3 )
    );

    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    callback::on_ai_spawned( &on_zombie_spawned );

    zm::register_player_damage_callback( &handle_armor_damage );

    level flag::wait_till( "initial_blackscreen_passed" );
    
    level thread handle_powerups();
    level thread handle_pap_menu();
    level thread handle_armory_menu();
    
    // REX - MUSIC SELECTOR
    level thread handle_music_menu();
    
    array::thread_all( level.chests, &handle_box );

    zm_spawner::register_zombie_death_event_callback( &watch_zombie_death );
}

function system_vars()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );

    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( POINT_SYSTEM )
        {
            zombie_utility::set_zombie_var( "zombie_score_damage_normal",           0 );
            zombie_utility::set_zombie_var( "zombie_score_damage_light",            0 );
        }
        zombie_utility::set_zombie_var( "player_base_health",                       BASE_PLAYER_HEALTH );
        zombie_utility::set_zombie_var( "zombie_perk_juggernaut_health",            100 );
        zombie_utility::set_zombie_var( "zombie_perk_juggernaut_health_upgrade",    100 );
    }
}

function on_zombie_spawned()
{
    if( self.in_the_ground )
        PlaySoundAtPosition( "zmb_zombie_crawl_dirt", self.origin );
    AIUtility::AddAIOverrideDamageCallback( self, &watch_zombie_damage );
}

function on_player_connect()
{
    self endon( "disconnect" );

    self.current_level = 1;
    self.prestige = 0;
    self.max_xp = 1454000;
    self.xp = 0;

    self thread watch_menu_response();
    self thread watch_keypad_response();

    self util::setClientSysState( "RarityNotif", "" );
    self util::setClientSysState( "TierNotif", "" );
    self util::setClientSysState( "PowerUpNotif", "" );
    self util::setClientSysState( "MenuInfo", "" );
    self util::setClientSysState( "KeypadEntry", "" );
    self util::setClientSysState( "Progression", "" );

    level clientfield::set( ( "hudItems.PlayerCharIndex" + self GetEntityNumber() ), self.characterindex );

    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( !IS_EQUAL( self clientfield::get_player_uimodel( "hudItems.HealthBarNum" ), ( ( self laststand::player_is_in_laststand() ) ? 0 : self.health ) ) )
            self clientfield::set_player_uimodel( "hudItems.HealthBarNum", ( ( self laststand::player_is_in_laststand() ) ? 0 : self.health ) );
    }
}

function on_player_spawned()
{
    self.armor_maxhealth = 0;
    self.armor_health = 0;
    self.armor_tier = 0;
    self.common_scrap = 0;
    self.rare_scrap = 0;
    self.clip_size = 0;
    self.stock_size = 0;
    self.rarity = 0;
    self.pap = 0;
    
    self thread register_player_health();
    self thread register_player_shield();
    self thread watch_weaponlist();
    self thread set_rarity_test();

    self.check_override_wallbuy_purchase = &handle_wallbuys;

    self waittill( "weapon_change_complete" );

    self thread watch_data();
    self thread prestige_test();

    w_current = ( ( zm_weapons::is_weapon_upgraded( self GetCurrentWeapon() ) ) ? zm_weapons::get_base_weapon( self GetCurrentWeapon() ) : self GetCurrentWeapon() );

    self.weapon_data = array( w_current.name, 0, 0 );
    self util::setClientSysState( "Progression", sprintf( "{0},{1}|{2},{3},{4}",
        self.prestige,
        self.xp,
        self.weapon_data[ 0 ],
        self.weapon_data[ 1 ],
        self.weapon_data[ 2 ]
    ), self );
    self LUINotifyEvent( &"RetrieveData", 0 );
}

function register_player_health()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "bled_out" );
    
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( !IS_EQUAL( level clientfield::set( ( "hudItems.HealthBarNotif" + self GetEntityNumber() ) ), ( ( !self laststand::player_is_in_laststand() ) ? ( self.health / self.maxhealth ) : 0 ) ) )
            level clientfield::set( ( "hudItems.HealthBarNotif" + self GetEntityNumber() ), ( ( !self laststand::player_is_in_laststand() ) ? ( self.health / self.maxhealth ) : 0 ) );
    }
}

function register_player_shield()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "bled_out" );

    level clientfield::set( ( "hudItems.ShieldBarNotif" + self GetEntityNumber() ), 0 );
    level clientfield::set( ( "hudItems.ShieldBar" + self GetEntityNumber() ), 0 );
    
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( !IS_EQUAL( level clientfield::get( ( "hudItems.ShieldBar" + self GetEntityNumber() ) ), ( ( self.armor_tier > 0 ) && !IS_EQUAL( self.sessionstate, "spectator" ) ) ) )
            level clientfield::set( ( "hudItems.ShieldBar" + self GetEntityNumber() ), ( ( self.armor_tier > 0 ) && !IS_EQUAL( self.sessionstate, "spectator" ) ) );

        if( !IS_EQUAL( level clientfield::get( ( "hudItems.ShieldBarNotif" + self GetEntityNumber() ) ), ( self.armor_health / ( 3 * ARMOR_PLATE_HEALTH ) ) ) )
            level clientfield::set( ( "hudItems.ShieldBarNotif" + self GetEntityNumber() ), ( self.armor_health / ( 3 * ARMOR_PLATE_HEALTH ) ) );

        if( !IS_EQUAL( level clientfield::get( ( "hudItems.ShieldBGNotif" + self GetEntityNumber() ) ), ( self.armor_maxhealth / ( 3 * ARMOR_PLATE_HEALTH ) ) ) )
            level clientfield::set( ( "hudItems.ShieldBGNotif" + self GetEntityNumber() ), ( self.armor_maxhealth / ( 3 * ARMOR_PLATE_HEALTH ) ) );
    }
}

function handle_armor_damage( inflictor, attacker, damage, flags, mod, weapon, point, dir, hit_loc, offset_time )
{
    self endon( "disconnect" );

    if( mod != "MOD_PROJECTILE_SPLASH" && ( mod == "MOD_FALLING" || mod == "MOD_SUICIDE" || mod == "MOD_TELEFRAG" || mod == "MOD_ELECTROCUTED" ) )
        return damage;
    if( mod == "MOD_CRUSH" )
    {
        self.armor_health = 0;
        return damage;
    }
    if( IS_EQUAL( self.armor_health, 0 ) )
        return damage;
    else
    {
        a_damage = RandomIntRange( ARMOR_PLATE_DAMAGE_MIN, ( ARMOR_PLATE_DAMAGE_MIN + 1 ) );
        d_reduction = RandomFloatRange( ARMOR_PLATE_REDUCTION_MIN, ( ARMOR_PLATE_REDUCTION_MAX + 0.01 ) );

        self.armor_health -= a_damage;
        if( self.armor_health < 0 )
            self.armor_health = 0;

        n_damage = Int( damage * d_reduction );

        return n_damage;
    }
}

function watch_weaponlist()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "bled_out" );

    self waittill( "weapon_change_complete" );

    self.a_weapons = [];

    for( ;; )
    {
        wait( 0.01 );

        w_current = self GetCurrentWeapon();
        if( !w_current.isriotshield && 
            !self zm_utility::has_powerup_weapon() && 
            !zm_equipment::is_equipment( w_current ) &&
            !IS_EQUAL( w_current, PAP_WEAPON ) && 
            !IS_EQUAL( w_current, FIST_WEAPON ) &&
            !IS_EQUAL( w_current, BUILDER_WEAPON ) && 
            !IS_EQUAL( w_current, level.weaponNone ) )
        {
            if( !weaponlist_contains( self.a_weapons, w_current ) )
            {
                obj = SpawnStruct();
                obj.weapon = w_current;
                obj.rarity = ( ( zm_weapons::is_wonder_weapon( w_current ) ) ? 6 : 0 );
                obj.pap = 0;
                obj.camo = 0;
                self.a_weapons[ self.a_weapons.size ] = obj;
            }
        }
        for( i = 0; i < self.a_weapons.size; i++ )
        {
            if( !self HasWeapon( self.a_weapons[ i ].weapon ) )
                ArrayRemoveIndex( self.a_weapons, i, false );
            if( IS_EQUAL( w_current, self.a_weapons[ i ].weapon ) || zm_equipment::is_equipment( w_current ) || self zm_utility::has_powerup_weapon() )
            {
                self util::setClientSysState( "RarityNotif", ( ( !( zm_equipment::is_equipment( w_current ) && self zm_utility::has_powerup_weapon() ) ) ? self.a_weapons[ i ].rarity : 0 ), self );
                self util::setClientSysState( "TierNotif", ( ( !( zm_equipment::is_equipment( w_current ) && self zm_utility::has_powerup_weapon() ) ) ? self.a_weapons[ i ].pap : 0 ), self );
            }
        }
    }
}

function set_rarity_test()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "bled_out" );

    self waittill( "weapon_change_complete" );

    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( self ActionSlotThreeButtonPressed() )
        {
            w_current = self GetCurrentWeapon();
            for( i = 0; i < self.a_weapons.size; i++ )
            {
                if( IS_EQUAL( w_current, self.a_weapons[ i ].weapon ) )
                    self.a_weapons[ i ].rarity = ( ( self.a_weapons[ i ].rarity < 5 ) ? self.a_weapons[ i ].rarity + 1 : self.a_weapons[ i ].rarity );
            }
            while( self ActionSlotThreeButtonPressed() )
                WAIT_SERVER_FRAME;
        }
    }
}

function watch_zombie_damage( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex, partName )
{
    for( i = 0; i < attacker.a_weapons.size; i++ )
        if( IS_EQUAL( weapon, attacker.a_weapons[ i ].weapon ) )
            c_weapon = attacker.a_weapons[ i ];

    n_damage = damage;
    if( isdefined( c_weapon ) )
    {
        n_damage = ( damage + ( damage * ( 0.475 * ( ( c_weapon.rarity < 2 ) ? 0 : ( c_weapon.rarity - 1 ) ) ) ) );
        n_damage = Int( n_damage + ( n_damage * ( c_weapon.pap / 1.5 ) ) );
    }
    if( attacker zm_powerups::is_insta_kill_active() && ( IS_EQUAL( self.archetype, "zombie" ) || IS_EQUAL( self.archetype, "zombie_dog" ) ) )
        n_damage = self.maxhealth;
        
    if( ( self.health - n_damage ) > 0 )
        attacker thread hitmarker_evt( 1, "rex_coldwar_hitmarker_damage" );
    return n_damage;
}

function watch_zombie_death( attacker )
{
    level.satchel_kill_req--;
    
    attacker thread hitmarker_evt( 2, "rex_coldwar_hitmarker_death" );

    if( ( RandomFloat( 100 ) <= ( 2.75 * ( GetPlayers().size / 1.5 ) ) && is_armor_valid() ) || IS_EQUAL( level.satchel_kill_req, 0 ) )
    {
        data = level.armor_types[ ( ( IS_EQUAL( level.satchel_kill_req, 0 ) ) ? 1 : 0 ) ];
        do_loot_drop( "armor", data );

        if( IS_EQUAL( level.satchel_kill_req, 0 ) )
            level.satchel_kill_req = RandomIntRange( SATCHEL_KILL_REQ_MIN, ( SATCHEL_KILL_REQ_MAX + 1 ) );
    }
    else
    {
        if( RandomFloat( 100 ) <= ( 28 + ( 5 * ( GetPlayers().size - 1 ) ) ) )
        {
            data = get_scrap( level.scrap_types );
            do_loot_drop( "scrap", data );
        }
    }
    if( !isdefined( attacker ) || !IsPlayer( attacker ) )
        return;
    if( isdefined( self ) && isdefined( self.damagemod ) && self.damagemod == "MOD_MELEE" )
        attacker LUINotifyEvent( &"score_event", 2, &"REX_COLDWAR_MELEE_KILL", 1 );
    else
    {
        if( zm_utility::is_headshot( self.damageweapon, self.damagelocation, self.damagemod ) )
            attacker LUINotifyEvent( &"score_event", 2, &"REX_COLDWAR_CRITICAL_KILL", 1 );
        else
            attacker LUINotifyEvent( &"score_event", 2, &"REX_COLDWAR_ZOMBIE_KILL", 1 );
    }

    // PROGRESSION SYSTEM

    w_current = ( ( zm_weapons::is_weapon_upgraded( self.damageweapon ) ) ? zm_weapons::get_base_weapon( self.damageweapon ) : self.damageweapon );
    attacker.weapon_data = array( w_current.name, 1, zm_utility::is_headshot( self.damageweapon, self.damagelocation, self.damagemod ) );

    xp = 150;
    if( zm_utility::is_headshot( self.damageweapon, self.damagelocation, self.damagemod ) )
        xp += 200;
    if( IS_EQUAL( level.zombie_vars[ "allies" ][ "zombie_point_scalar" ], 2 ) )
        xp *= 3;
    attacker.xp = ( ( ( attacker.xp + xp ) < attacker.max_xp ) ? ( attacker.xp + xp ) : attacker.max_xp );
    attacker.max_xp = ( ( IS_EQUAL( attacker.prestige, 10 ) && attacker.xp >= 1454000 ) ? 13266500 : attacker.max_xp );
    attacker thread update_data();
}

function handle_weapon_info( weapon, rarity = 0, pap = 0, camo = 0, aat = undefined )
{
    while( !weaponlist_contains( self.a_weapons, weapon ) )
        WAIT_SERVER_FRAME;
    for( i = 0; i < self.a_weapons.size; i++ )
    {
        if( IS_EQUAL( self.a_weapons[ i ].weapon, weapon ) )
        {
            self.a_weapons[ i ].rarity = rarity;
            self.a_weapons[ i ].pap = pap;
            if( isdefined( aat ) )
            {
                self.aat[ weapon ] = aat;
                self clientfield::set_to_player( "aat_current", level.aat[ self.aat[ weapon ] ].clientfield_index );
            }
        }
    }
}

function handle_powerups() 
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );

    for( ;; )
    {        
        level waittill( "powerup_dropped", powerup );

        powerup thread watch_powerup();
    }
}

function watch_powerup()
{
    self endon( "powerup_timedout" );

    self waittill( "powerup_grabbed" );

    title = ( ( isdefined( level.powerup_title[ self.powerup_name ] ) ) ? level.powerup_title[ self.powerup_name ] : "Unknown" );

    players = GetPlayers();
    for( i = 0; i < players.size; i++ )
        players[ i ] util::setClientSysState( "PowerUpNotif", sprintf( "{0},rex_coldwar_ui_powerup_{1}", title, self.powerup_name ), players[ i ] );
}

function handle_armory_menu()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );

    armory = struct::get( "armory_ent" );
    armory create_unitrigger( "Hold ^3[{+activate}]^7 to open Armory", undefined, 64 );

    for( ;; )
    {
        armory waittill( "trigger_activated", player );

        player thread update_menu_info();

        player CloseMenu( "ArmoryMenu" );
	    player OpenMenu( "ArmoryMenu" );
    }
}

function handle_pap_menu()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );

    pap = struct::get( "pap_ent" );
    pap create_unitrigger( "Hold ^3[{+activate}]^7 to open Pack-A-Punch", undefined, 64 );

    for( ;; )
    {
        pap waittill( "trigger_activated", player );

        player thread update_menu_info();

        player CloseMenu( "PAPMenu" );
	    player OpenMenu( "PAPMenu" );
    }
}

function watch_menu_response()
{
    self endon( "disconnect" );

    for( ;; )
    {
        self waittill( "menuresponse", menu, response );

        w_current = self GetCurrentWeapon();
        idx = get_weaponlist_index( self.a_weapons, w_current );
        
        strToks = StrTok( response, "," );

        switch( menu )
        {
            case "ArmoryMenu":
            {
                switch( strToks[ 0 ] )
                {
                    case "armory":
                    {
                        if( self can_player_upgrade( Int( strToks[ 2 ] ), strToks[ 3 ] ) )
                        {
                            if( !IS_EQUAL( Int( strToks[ 1 ] ), 4 ) )
                            {
                                if( IS_EQUAL( Int( strToks[ 1 ] ), ( self.armor_tier + 1 ) ) && !IS_EQUAL( Int( strToks[ 1 ] ), self.armor_tier ) )
                                {  
                                    self minus_to_scrap( Int( strToks[ 2 ] ), strToks[ 3 ] );

                                    self.armor_tier++;
                                    self.armor_maxhealth = ( self.armor_tier * ARMOR_PLATE_HEALTH );
                                    self.armor_health = self.armor_maxhealth;
                                }
                            }
                            else
                            {
                                if( ( self.armor_health < self.armor_maxhealth ) && ( self.armor_tier > 0 ) )
                                {
                                    self minus_to_scrap( 250, strToks[ 3 ] );
                                    self.armor_health = self.armor_maxhealth;
                                }
                            }
                        }
                    }
                    case "weaponry":
                    {
                        if( self can_player_upgrade( Int( strToks[ 2 ] ), strToks[ 3 ] ) )
                        {
                            if( IS_EQUAL( Int( strToks[ 1 ] ), ( self.a_weapons[ idx ].rarity + ( ( IS_EQUAL( self.a_weapons[ idx ].rarity, 0 ) ) ? 2 : 1 ) ) ) && 
                                !IS_EQUAL( Int( strToks[ 1 ] ), self.a_weapons[ idx ].rarity ) )
                            {  
                                self minus_to_scrap( Int( strToks[ 2 ] ), strToks[ 3 ] );
                                self.a_weapons[ idx ].rarity += ( ( IS_EQUAL( self.a_weapons[ idx ].rarity, 0 ) ) ? 2 : 1 );
                            }
                        }
                    }
                }
                break;
            }
            case "PAPMenu":
            {
                switch( strToks[ 0 ] )
                {
                    case "pap":
                    {
                        if( self zm_score::can_player_purchase( Int( strToks[ 2 ] ) ) )
                        {
                            if( IS_EQUAL( Int( strToks[ 1 ] ), 1 ) && !IS_EQUAL( self.a_weapons[ idx ].pap, 1 ) )
                            {
                                aat = self.aat[ w_current ];
                                pap = self.a_weapons[ idx ].pap;
                                camo = self.a_weapons[ idx ].camo;
                                rarity = self.a_weapons[ idx ].rarity;
                                naw_current = zm_weapons::get_nonalternate_weapon( w_current );

                                if( isdefined( naw_current.rootweapon ) )
                                    naw_current = naw_current.rootweapon;

                                if( !( isdefined( level.zombie_weapons[ naw_current ] ) || isdefined( level.zombie_weapons[ naw_current ].upgrade ) ) )
                                    continue;

                                w_upgrade = zm_weapons::get_upgrade_weapon( naw_current, 0 );
                                w_upgrade = zm_weapons::get_nonalternate_weapon( w_upgrade );
                                if( isdefined( w_upgrade.rootweapon ) )
                                    w_upgrade = w_upgrade.rootweapon;

                                level.pack_a_punch_camo_index = array::random( array( 15, 16, 121 ) );
                                level.pack_a_punch_camo_index_number_variants = ( ( IS_EQUAL( level.pack_a_punch_camo_index, 121 ) ) ? 5 : undefined );

                                w_buildkit_upgrade = self GetBuildKitWeapon( w_upgrade, 1 );
                                w_buildkit_upgrade.pap_camo_to_use = zm_weapons::get_pack_a_punch_camo_index( w_buildkit_upgrade.pap_camo_to_use );
                                self zm_weapons::weapon_take( naw_current );

                                w_buildkit_upgrade = self zm_weapons::weapon_give( w_buildkit_upgrade, false, false, true );

                                self GiveStartAmmo( w_buildkit_upgrade );
                                self SwitchToWeapon( w_buildkit_upgrade );

                                self handle_weapon_info( w_buildkit_upgrade, rarity, pap, camo, aat );
                                idx = get_weaponlist_index( self.a_weapons, w_buildkit_upgrade );
                            }
                            if( IS_EQUAL( Int( strToks[ 1 ] ), ( self.a_weapons[ idx ].pap + 1 ) ) && !IS_EQUAL( Int( strToks[ 1 ] ), self.a_weapons[ idx ].pap ) )
                            { 
                                self zm_utility::play_sound_on_ent( "purchase" );

                                self zm_score::minus_to_player_score( Int( strToks[ 2 ] ) ); 
                                self.a_weapons[ idx ].pap++;
                            }
                        }
                        break;
                    }
                    case "aat":
                    {
                        if( self zm_score::can_player_purchase( PAP_AAT_COST ) )
                        {
                            if( self zm_utility::has_powerup_weapon() )
                                continue;
                            if( zm_weapons::is_wonder_weapon( w_current ) )
                                continue;
                            if( isdefined( self.aat[ w_current ] ) )
                                aat_current = self.aat[ w_current ];
                            if( isdefined( aat_current ) && IS_EQUAL( strToks[ 1 ], aat_current ) )
                                continue;
                            self zm_score::minus_to_player_score( PAP_AAT_COST ); 

                            self.aat[ w_current ] = strToks[ 1 ];
                            self clientfield::set_to_player( "aat_current", level.aat[ self.aat[ w_current ] ].clientfield_index );
                        }
                        break;
                    }
                }
                break;
            }
        }
        self clientfield::set_player_uimodel( "hudItems.CommonScrap", self.common_scrap );
        self clientfield::set_player_uimodel( "hudItems.RareScrap", self.rare_scrap );

        self update_menu_info();
    }
}

function do_loot_drop( type, data, is_weapon = false, is_backwards = false )
{
    if( IS_EQUAL( type, "armor" ) && !data[ 1 ] && !is_armor_valid() )
        return;
    if( is_weapon )
    	ent = zm_utility::spawn_weapon_model( data[ 2 ], undefined, ( self.origin + VectorScale( AnglesToUp( self.angles ), 36 ) ), ( 0, RandomFloat( 360 ), 0 ), undefined ); 
    else
        ent = util::spawn_model( data[ 2 ], ( self.origin + VectorScale( AnglesToUp( self.angles ), 36 ) ), ( 0, RandomFloat( 360 ), 0 ) );    
    ent clientfield::set( level.rarity_keyline[ data[ 3 ] ], 1 );

    ent [[ ( ( is_weapon ) ? &drop_weapon : &drop_loot ) ]]( self, is_backwards );

    switch( type )
    {
        case "armor":
            if( data[ 1 ] )
                ent thread watch_satchel();
            func = &handle_armor;
            break;
        case "scrap":
            func = &handle_scrap;
            break;
        case "weapon":
            ent thread watch_weapon( data[ 2 ] );
            func = &handle_weapon;
            break;
        default:
            func = undefined;
            break;
    }
    players = GetPlayers();
    for( i = 0; i < players.size; i++ )
    {
        if( isdefined( func ) )
            players[ i ] thread [[ func ]]( ent, data );
        else
        {
            if( isdefined( ent ) )
            {
                ent clientfield::set( "loot_trail", 0 );
                ent Delete();
            }
            return undefined;
        }
    }
    return ent;
}

function handle_scrap( ent, data )
{
    lifetime = ( GetTime() + ( LOOT_LIFETIME * 1000 ) );
    while( isdefined( ent ) && ( GetTime() < lifetime ) )
    {  
        WAIT_SERVER_FRAME;

        if( IS_EQUAL( data[ 0 ], "common" ) )
            if( IS_EQUAL( self.common_scrap, SCRAP_MAX ) )
                continue;
        else
            if( IS_EQUAL( self.rare_scrap, SCRAP_MAX ) )
                continue;
        if( DistanceSquared( self.origin, ent.origin ) <= SQUARED( 50 ) )
            break;
    }
    if( isdefined( ent ) && DistanceSquared( self.origin, ent.origin ) <= SQUARED( 50 ) )
    {
        self PlaySoundToPlayer( "rex_coldwar_scrap_pickup", self );

        switch( data[ 0 ] )
        {
            case "common":
                self.common_scrap = ( ( ( self.common_scrap + SCRAP_COMMON ) < SCRAP_MAX ) ? ( self.common_scrap + SCRAP_COMMON ) : SCRAP_MAX );
                self clientfield::set_player_uimodel( "hudItems.CommonScrap", self.common_scrap );
                break;
            case "rare":
                self.rare_scrap = ( ( ( self.rare_scrap + SCRAP_RARE ) < SCRAP_MAX ) ? ( self.rare_scrap + SCRAP_RARE ) : SCRAP_MAX );
                self clientfield::set_player_uimodel( "hudItems.RareScrap", self.rare_scrap );
                break;
        }
    }
    if( isdefined( ent ) )
    {
        ent clientfield::set( level.rarity_keyline[ data[ 3 ] ], 0 );
        ent clientfield::set( "loot_trail", 0 );
        ent Delete();
    }
}

function handle_armor( ent, data )
{
    lifetime = ( GetTime() + ( LOOT_LIFETIME * 1000 ) );
    while( ( isdefined( ent ) && IsPointOnNavMesh( ent.origin ) ) && ( GetTime() < lifetime ) )
    {
        WAIT_SERVER_FRAME;

        if( !data[ 1 ] )
        {
            if( IS_EQUAL( self.armor_health, self.armor_maxhealth ) )
                continue;
            if( DistanceSquared( self.origin, ent.origin ) <= SQUARED( 50 ) )
                break;
        }
        else
        {
            if( isdefined( ent.interactor ) )
                break;
        }
    }
    if( GetTime() >= lifetime )
    {
        ent notify( "loot_timedout" );

        if( isdefined( ent.s_unitrigger ) )
            zm_unitrigger::unregister_unitrigger( ent.s_unitrigger );
    }
    if( isdefined( ent ) && IsPointOnNavMesh( ent.origin ) )
    {
        switch( data[ 0 ] )
        {
            case "plate":
                if( DistanceSquared( self.origin, ent.origin ) <= SQUARED( 50 ) )
                {
                    self PlaySoundToPlayer( "rex_coldwar_item_pickup", self );

                    self.armor_health = ( ( ( ( self.armor_health + ARMOR_PLATE_DROP_HEALTH ) < self.armor_maxhealth ) ) ? ( self.armor_health + ARMOR_PLATE_DROP_HEALTH ) : self.armor_maxhealth );
                }
                break;
        }
    }
    if( isdefined( ent ) )
    {
        ent clientfield::set( level.rarity_keyline[ data[ 3 ] ], 0 );
        ent clientfield::set( "loot_trail", 0 );
        ent Delete();
    }
}

function watch_satchel()
{
    self endon( "loot_timedout" );

    self waittill_not_moving();

    if( isdefined( self ) && IsPointOnNavMesh( self.origin ) )
    {
        self create_unitrigger( "Hold ^3[{+activate}]^7 to pickup Armor Satchel", undefined, 48 );

        while( !isdefined( self.interactor ) )
        {
            self waittill( "trigger_activated", player );

            if( !IS_EQUAL( player.armor_tier, 0 ) && IS_EQUAL( player.armor_health, player.armor_maxhealth ) )
                continue;
            zm_unitrigger::unregister_unitrigger( self.s_unitrigger );

            player PlaySoundToPlayer( "rex_coldwar_satchel_pickup", player );

            if( IS_EQUAL( player.armor_tier, 0 ) )
            {
                player.armor_tier++;
                player.armor_maxhealth = ( player.armor_tier * ARMOR_PLATE_HEALTH );
            }
            player.armor_health = player.armor_maxhealth;
            self.interactor = player;
        }
    }
}

function handle_weapon( ent, data )
{
    lifetime = ( GetTime() + ( LOOT_LIFETIME * 1000 ) );
    while( ( isdefined( ent ) && !isdefined( ent.interactor ) ) && ( GetTime() < lifetime ) )
        WAIT_SERVER_FRAME;
    if( GetTime() >= lifetime )
        ent notify( "loot_timedout" );
    if( isdefined( ent ) )
    {
        if( IS_EQUAL( self, ent.interactor ) )
        {
            self PlaySoundToPlayer( "rex_coldwar_weapon_pickup", self );

            if( self HasMaxPrimaryWeapons() )
            {
                w_current = self GetCurrentWeapon();
                idx = get_weaponlist_index( self.a_weapons, w_current );

                w_old = self do_loot_drop( "weapon", array( "weapon", false, w_current, self.a_weapons[ idx ].rarity ), true );
                w_old.rarity = self.a_weapons[ idx ].rarity;
                w_old.pap = self.a_weapons[ idx ].pap;
                w_old.aat = self.aat[ w_current ];
                w_old.clip = self GetWeaponAmmoClip( w_current );
                w_old.stock = self GetWeaponAmmoStock( w_current );
            }
            self zm_weapons::weapon_give( data[ 2 ], false, false, true );
            self SetWeaponAmmoClip( data[ 2 ], ent.clip );
            self SetWeaponAmmoStock( data[ 2 ], ent.stock );
            self thread handle_weapon_info( data[ 2 ], ent.rarity, ent.pap, ent.camo, ent.aat );
        }
    }
    if( isdefined( ent ) )
    {
        if( isdefined( ent.s_unitrigger ) )
            zm_unitrigger::unregister_unitrigger( ent.s_unitrigger );
        ent clientfield::set( level.rarity_keyline[ data[ 3 ] ], 0 );
        ent clientfield::set( "loot_trail", 0 );
        ent Delete();
    }
}

function watch_weapon( weapon )
{
    self endon( "loot_timedout" );

    self waittill_not_moving();

    if( isdefined( self ) )
    {
        self create_unitrigger( sprintf( "Hold ^3[{+activate}]^7 to pickup {0}", MakeLocalizedString( weapon.displayname ) ), undefined, 48 );

        while( !isdefined( self.interactor ) )
        {
            self waittill( "trigger_activated", player );

            w_current = weapon;
            if( isdefined( weapon.rootweapon ) )
                w_current = weapon.rootweapon;
            if( player zm_weapons::has_weapon_or_upgrade( w_current ) )
                continue;
            zm_unitrigger::unregister_unitrigger( self.s_unitrigger );
            self.interactor = player;
        }
    }
}

function handle_wallbuys( weapon, wallbuy )
{
    ammo_cost = zm_weapons::get_ammo_cost( weapon );
	is_grenade = weapon.isGrenadeWeapon;
	shared_ammo_weapon = undefined;

	player_has_weapon = self zm_weapons::has_weapon_or_upgrade( weapon ); 
    if( !player_has_weapon && IS_TRUE( level.weapons_using_ammo_sharing ) )
    {
        shared_ammo_weapon = self zm_weapons::get_shared_ammo_weapon( weapon );
        if( isdefined( shared_ammo_weapon ) )
            player_has_weapon = true;
    }
    if( IS_TRUE( level.pers_upgrade_nube ) )
        player_has_weapon = zm_pers_upgrades_functions::pers_nube_should_we_give_raygun( player_has_weapon, self, weapon );
    
    cost = Int( zm_weapons::get_weapon_cost( weapon ) * ( ( self zm_pers_upgrades_functions::is_pers_double_points_active() ) ? 0.5 : 1 ) );

    if( !player_has_weapon )
    {        
        if( self zm_score::can_player_purchase( cost ) )
        {
            if( !wallbuy.first_time_triggered )
                wallbuy zm_weapons::show_all_weapon_buys( self, cost, ammo_cost, is_grenade );

            self zm_score::minus_to_player_score( cost );

            if( self HasMaxPrimaryWeapons() )
            {
                w_current = self GetCurrentWeapon();
                idx = get_weaponlist_index( self.a_weapons, w_current );

                w_old = self do_loot_drop( "weapon", array( "weapon", false, w_current, self.a_weapons[ idx ].rarity ), true, self util::is_looking_at( wallbuy.origin ) );
                w_old.rarity = self.a_weapons[ idx ].rarity;
                w_old.pap = self.a_weapons[ idx ].pap;
                w_old.aat = self.aat[ w_current ];
                w_old.clip = self GetWeaponAmmoClip( w_current );
                w_old.stock = self GetWeaponAmmoStock( w_current );
            }
            level notify( "weapon_bought", self, weapon );
            
            if( weapon.isriotshield ) 
            {
                self zm_equipment::give( weapon );

                if( isdefined( self.player_shield_reset_health ) )
                    self [[ self.player_shield_reset_health ]]();
            }
            else
            {
                if( zm_utility::is_lethal_grenade( weapon ) )
                {
                    self zm_weapons::weapon_take( self zm_utility::get_player_lethal_grenade() );
                    self zm_utility::set_player_lethal_grenade( weapon );
                }
                if( IS_TRUE( level.pers_upgrade_nube ) )
                {
                    weapon = zm_pers_upgrades_functions::pers_nube_weapon_upgrade_check( self, weapon );
                }
                if( zm_weapons::should_upgrade_weapon( self ) )
                {
                    if( self zm_weapons::can_upgrade_weapon( weapon ) )
                    {
                        weapon = zm_weapons::get_upgrade_weapon( weapon );
                        self notify( "zm_bgb_wall_power_used" );
                    }
                }
                weapon = self zm_weapons::weapon_give( weapon, false, false, true );
                if( isdefined( weapon ) )
                {
                    self thread aat::remove( weapon );
                }
            }
        }
        else
        {
            zm_utility::play_sound_on_ent( "no_purchase" );
            self zm_audio::create_and_play_dialog( "general", "outofmoney" );
        }
    }
    else
    {
        if( isdefined( shared_ammo_weapon ) )
            weapon = shared_ammo_weapon;
        if( IS_TRUE( level.pers_upgrade_nube ) )
            weapon = zm_pers_upgrades_functions::pers_nube_weapon_ammo_check( self, weapon );

        if( IS_TRUE( wallbuy.stub.hacked ) )
            ammo_cost = ( ( !self zm_weapons::has_upgrade( weapon ) ) ? N_UPGRADED_WEAPON_AMMO_COST : zm_weapons::get_ammo_cost( weapon ) );
        else
            ammo_cost = ( ( self zm_weapons::has_upgrade( weapon ) ) ? N_UPGRADED_WEAPON_AMMO_COST : zm_weapons::get_ammo_cost( weapon ) );
        if( IS_TRUE( self.pers_upgrades_awarded[ "nube" ] ) )
            ammo_cost = zm_pers_upgrades_functions::pers_nube_override_ammo_cost( self, weapon, ammo_cost );

        ammo_cost = Int( zm_weapons::get_ammo_cost( weapon ) * ( ( self zm_pers_upgrades_functions::is_pers_double_points_active() ) ? 0.5 : 1 ) );

        if( self bgb::is_enabled( "zm_bgb_secret_shopper" ) && !zm_weapons::is_wonder_weapon( weapon ) )
            ammo_cost = self zm_weapons::get_ammo_cost_for_weapon( weapon );

        if( weapon.isriotshield )
            zm_utility::play_sound_on_ent( "no_purchase" );
        else if( self zm_score::can_player_purchase( ammo_cost ) )
        {
            if( !wallbuy.first_time_triggered )
                wallbuy zm_weapons::show_all_weapon_buys( self, cost, ammo_cost, is_grenade );

            ammo_given = self zm_weapons::ammo_give( ( ( self zm_weapons::has_upgrade( weapon ) ) ? level.zombie_weapons[ weapon ].upgrade : weapon ) );
            if( ammo_given )
                self zm_score::minus_to_player_score( ammo_cost );
        }
        else
        {
            zm_utility::play_sound_on_ent( "no_purchase" );

            if( isdefined( level.custom_generic_deny_vo_func ) )
                self [[ level.custom_generic_deny_vo_func ]]();
            else
                self zm_audio::create_and_play_dialog( "general", "outofmoney" );
        }
    }
    if( isdefined( wallbuy.stub ) && isdefined( wallbuy.stub.prompt_and_visibility_func ) )
        wallbuy [[ wallbuy.stub.prompt_and_visibility_func ]]( self );
}

function handle_box()
{
    self.previous_weapon = [];

    for( ;; )
    {
        self waittill( "trigger", player );

        if( self._box_open )
        {
            self.zbarrier util::waittill_any( "randomization_done", "box_hacked_respin" );

            w_new = zm_weapons::get_nonalternate_weapon( self.zbarrier.weapon );

            if( isdefined( w_new.rootweapon ) )
            {
                w_new = w_new.rootweapon;
                att_forced = zm_weapons::get_force_attachments( w_new );
                if( isdefined( att_forced ) )
                {
                    w_new = GetWeapon( w_new.name, att_forced );
                }
            }
            w_new = player GetBuildKitWeapon( w_new, 0 );

            level.mystery_box_rarity = ( zm_weapons::is_wonder_weapon( w_new ) ? 6 : RandomIntRange( 1, 6 ) );  

            player thread watch_weapon_data( self );

            while( !IS_TRUE( self.closed_by_emp ) )
            {
                self waittill( "trigger", grabber );

                if( !IS_EQUAL( grabber, level ) && IS_TRUE( self.box_rerespun ) )
                    player = grabber;
                if( IS_EQUAL( grabber, player ) )
                {
                    a_primaries = player GetWeaponsListPrimaries();
                    
                    if( !isdefined( self.previous_weapon[ player.name ] ) )
                        self.previous_weapon[ player.name ] = w_new;
                    if( player HasMaxPrimaryWeapons() && 
                        !zm_equipment::is_equipment( w_new ) && 
                        ( !zm_equipment::is_equipment( self.previous_weapon[ player.name ] ) || 
                        IS_EQUAL( a_primaries.size, ( ( player HasPerk( "specialty_additionalprimaryweapon" ) ) ? 3 : 2 ) ) ) )
                    {
                        w_current = player GetCurrentWeapon();

                        w_old = player do_loot_drop( "weapon", array( "weapon", false, w_current, player.rarity ), true, player util::is_looking_at( self.origin ) );
                        w_old.rarity = player.rarity;
                        w_old.pap = player.pap;
                        w_old.aat = player.aat[ w_current ];
                        w_old.clip = player.clip_size;
                        w_old.stock = player.stock_size;
                    }
                    player thread handle_weapon_info( w_new, level.mystery_box_rarity );
                    self.previous_weapon[ player.name ] = w_new;
                }
                break;
            }
        }
    } 
}

function watch_weapon_data( box )
{
    box endon( "user_grabbed_weapon" );

    for( ;; )
    {
        wait( 0.01 );

        if( IS_EQUAL( self, level ) )
            return;
        w_current = self GetCurrentWeapon();
        idx = get_weaponlist_index( self.a_weapons, w_current );

        self.clip_size = self GetWeaponAmmoClip( w_current );
        self.stock_size = self GetWeaponAmmoStock( w_current );
        self.rarity = self.a_weapons[ idx ].rarity;
        self.pap = self.a_weapons[ idx ].pap;
    }
}

function handle_box_glow()
{
    self clientfield::set( "magicbox_rarity_glow", 1 );
	self clientfield::set( "magicbox_closed_glow", 0 );

    self util::waittill_any( "randomization_done", "box_hacked_respin" );

    if( !zm_equipment::is_equipment( self.weapon ) )
    {
        self clientfield::set( "magicbox_rarity_glow", 0 );
            wait( 0.01 );
        self clientfield::set( "magicbox_rarity_glow", level.mystery_box_rarity );
        self.weapon_model clientfield::set( level.rarity_keyline[ level.mystery_box_rarity ], 1 );
    }
    evt = util::waittill_any_return( "weapon_grabbed", "box_moving" );

    self clientfield::set( "magicbox_rarity_glow", 0 );
    self.weapon_model clientfield::set( level.rarity_keyline[ level.mystery_box_rarity ], 0 );

    if( !IS_EQUAL( evt, "box_moving" ) )
	{
		self clientfield::set( "magicbox_closed_glow", 1 );
	}
}

// REX - UTILITIES

function create_unitrigger( str_hint, cur_hint = "HINT_NOICON", n_radius, func_prompt_and_visibility = &visibility_and_update_prompt, func_unitrigger_logic = &unitrigger_logic, s_trigger_type = "unitrigger_radius_use" )
{
    s_unitrigger = SpawnStruct();
    s_unitrigger.origin = self.origin;
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = s_trigger_type;
    s_unitrigger.cursor_hint = cur_hint;
    s_unitrigger.hint_string = str_hint;
    s_unitrigger.default_string = str_hint;
    s_unitrigger.prompt_and_visibility_func = func_prompt_and_visibility;
    s_unitrigger.related_parent = self;
    s_unitrigger.radius = n_radius;
    if( isdefined( self.script_noteworthy ) ) 
        s_unitrigger.script_noteworthy = self.script_noteworthy;
    if( isdefined( self.script_string ) ) 
        s_unitrigger.script_string = self.script_string;
    if( isdefined( self.zombie_cost ) ) 
        s_unitrigger.zombie_cost = self.zombie_cost;
    self.s_unitrigger = s_unitrigger;

	zm_unitrigger::unitrigger_force_per_player_triggers( self.s_unitrigger, true );
    zm_unitrigger::register_static_unitrigger( s_unitrigger, func_unitrigger_logic );
    return s_unitrigger;
}

function visibility_and_update_prompt( player )
{
    can_use = self visibility_unitrigger( player );
    if( isdefined( self.hint_string ) )
        self SetHintString( self.hint_string );
    return can_use;
}

function visibility_unitrigger( player )
{
    if( !is_valid( player ) )
    {
        self.hint_string = "";
        return false;
    }
    self.hint_string = self.stub.hint_string;
    return true;
}

function unitrigger_logic()
{
    self endon( "death" );
    
    for( ;; )
    {
        self waittill( "trigger", player );
        
        if( !is_valid( player ) )
            continue;
        self.stub.related_parent notify( "trigger_activated", player );
    }
}

function is_valid( player )
{
    if( player laststand::player_is_in_laststand() )
        return false;
    if( IS_DRINKING( player.is_drinking ) )
        return false;
    if( !zm_utility::is_player_valid( player ) )
        return false;
    if( player laststand::player_is_in_laststand() )
        return false;
    if( player zm_utility::has_powerup_weapon() )
		return false;
    if( player.currentWeapon.isRiotShield )
		return false;
    return true;
}

function waittill_not_moving()
{
    level endon( "intermission" );
	level endon( "game_ended" );
    level endon( "end_game" );

    prevorigin = self.origin;
    for( ;; )
    {
        wait( 0.15 );

        if( !IsPointOnNavMesh( self.origin ) )
            break;
        if( self.origin == prevorigin )
            break;
        prevorigin = self.origin;
    }
}

function can_player_upgrade( cost, salvage_type )
{
    return ( cost <= ( ( IS_EQUAL( salvage_type, "common" ) ) ? self.common_scrap : self.rare_scrap ) );
}

function minus_to_scrap( cost, salvage_type )
{
    switch( salvage_type )
    {
        case "common":
            self.common_scrap -= cost;
            break;
        case "rare":
            self.rare_scrap -= cost;
            break;
    }
}

function get_scrap( array )
{
    pool = [];
    for( i = 0; i < array.size; i++ )
        for( j = 0; j < array[ i ][ 1 ]; j++ )
            pool[ pool.size ] = i;
    return array[ array::randomize( pool )[ 0 ] ];
}

function drop_loot( entity, is_backwards )
{
    self clientfield::set( "loot_trail", 1 );

    v_forward = AnglesToForward( entity.angles );
    v_right = AnglesToRight( entity.angles );
    v_up = AnglesToUp( entity.angles );

    f_offset = ( RandomIntRange( 35, 65 ) * ( ( is_backwards ) ? -1 : 1 ) );
    u_offset = RandomIntRange( 50, 175 );
    r_offset = RandomIntRange( -50, 50 );

    self Launch( ( ( ( v_forward * f_offset ) + ( v_up * u_offset ) ) + ( v_right * ( ( math::cointoss() ) ? -r_offset : r_offset ) ) ) );
}

function drop_weapon( player, is_backwards )
{
    const ground_offset = 25;

    self clientfield::set( "loot_trail", 1 );

    v_forward = AnglesToForward( player.angles );
    v_right = AnglesToRight( player.angles );

    f_offset = ( RandomIntRange( 35, 65 ) * ( ( is_backwards ) ? -1 : 1 ) );
    r_offset = RandomIntRange( -50, 50 );

    end = ( self.origin + ( v_forward * f_offset ) + ( v_right * r_offset ) );
    ground_pos = util::ground_position( end, 500, ground_offset );

    self zm_utility::fake_physicslaunch( ground_pos, RandomFloatRange( 150, 200 ) );
}

function is_armor_valid()
{
    players = GetPlayers();
    for( i = 0; i < players.size; i++ )
        if( players[ i ].armor_tier > 0 )
            return true;
    return false;
}

function get_weaponlist_index( array, weapon )
{
    for( i = 0; i < array.size; i++ )
        if( IS_EQUAL( array[ i ].weapon.name, weapon.name ) )
            return i;
    return undefined;
}

function weaponlist_contains( array, weapon )
{
    for( i = 0; i < array.size; i++ )
        if( IS_EQUAL( array[ i ].weapon.name, weapon.name ) )
            return true;
    return false;
}

function update_menu_info()
{
    w_current = self GetCurrentWeapon();
    idx = get_weaponlist_index( self.a_weapons, w_current );
    
    self util::setClientSysState( "MenuInfo", sprintf( "{0},{1},{2},{3},{4},{5},{6}",
        self.common_scrap,
        self.rare_scrap,
        self.armor_health,
        self.armor_maxhealth,
        self.armor_tier,
        self.a_weapons[ idx ].rarity,
        self.a_weapons[ idx ].pap
    ), self );
}

function hitmarker_evt( type, alias )
{
    if( isdefined( alias ) )
        self PlaySoundToPlayer( alias, self );
    self clientfield::set_player_uimodel( "hudItems.Hitmarker", 0 );
        wait( 0.01 );
    self clientfield::set_player_uimodel( "hudItems.Hitmarker", type );
}

function array_remove( array, object )
{
	if( !isdefined( array ) && !isdefined( object ) )
		return;

	n_array = [];
    for( i = 0; i < array.size; i++ )
    {
        if( array[ i ] != object )
        {
            if( !isdefined( n_array ) )
                n_array = [];
            else if( !IsArray( n_array ) )
                n_array = array( n_array );
            n_array[ n_array.size ] = array[ i ];
        }
    }
	return n_array;
}

function array_remove_key( array, key )
{
    if( !isdefined( array ) && !isdefined( key ) )
        return;
    
    n_array = [];
    keys = GetArrayKeys( array );
    for( i = 0; i < keys.size; i++ )
    {
        if( keys[ i ] != key )
        {
            if( !isdefined( n_array ) )
                n_array = [];
            else if( !IsArray( n_array ) )
                n_array = array( n_array );
            n_array[ keys[ i ] ] = array[ keys[ i ] ];
        }
    }
    return n_array;
}

function waittill_any_return( ... )
{
	ent = SpawnStruct();
    for( i = 0; i < vararg.size; i++ )
        self thread [[ &waittill_string ]]( vararg[ i ], ent );
	ent waittill( "returned", msg );
	ent notify( "die" );

	return msg;
}

function waittill_string( msg, ent )
{
	ent endon( "die" );
	self waittill( msg );
	ent notify( "returned", msg );
}

function handle_music_menu()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );

    music = struct::get( "music_selector_ent" );
    music create_unitrigger( "Hold ^3[{+activate}]^7 to open Music Selector", undefined, 64 );

    for( ;; )
    {
        music waittill( "trigger_activated", player );

        player CloseMenu( "MusicSelectorMenu" );
	    player OpenMenu( "MusicSelectorMenu" );
    }
}

function handle_music_menu()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );

    keypad = struct::get( "music_selector_ent" );
    keypad create_unitrigger( "Hold ^3[{+activate}]^7 to open Keypad Lock", undefined, 64 );
    keypad.is_unlocked = false;
    keypad.entry = "";
    keypad.code = "";

    for( i = 0; i < 4; i++ )
        keypad.code += sprintf( "{0}", RandomInt( 10 ) );
    for( ;; )
    {
        keypad waittill( "trigger_activated", player );

        player CloseMenu( "KeypadLockMenu" );
	    player OpenMenu( "KeypadLockMenu" );

        player notify( "keypad_opened" );
        player thread watch_keypad_response( keypad );
    }
}

function watch_keypad_response( keypad )
{
    self endon( "keypad_opened" );
    self endon( "disconnect" );
    
    self IPrintLnBold( keypad.code );

    for( ;; )
    {
        self waittill( "menuresponse", menu, response );

        if( IS_EQUAL( menu, "KeypadLockMenu" ) )
        {
            switch( response )
            {
                case "CLEAR":
                    keypad.entry = "";
                    break;
                case "ENTER":
                    self LUINotifyEvent( &"KeypadEntryAction", 1, IS_EQUAL( keypad.entry, keypad.code ) );

                    if( IS_EQUAL( keypad.entry, keypad.code ) && !keypad.is_unlocked )
                    {
                        keypad.is_unlocked = true;
                    }
                    keypad.entry = "";
                    break;
                default:
                    if( StrIsNumber( response ) )
                    {
                        if( !IS_EQUAL( keypad.entry.size, 4 ) )
                        {
                            keypad.entry = sprintf( "{0}{1}", keypad.entry, response );
                        }
                    }
                    break;
            }
            self util::setClientSysState( "KeypadEntry", keypad.entry, self );
        }
    }
}

function update_data( do_prestige = 0 )
{
    row_id = 0;
    if( IS_EQUAL( self.prestige, 0 ) )
        row_id = ( self.current_level + 2 );
    else
        row_id = ( self.prestige + ( ( self.current_level > 55 ) ? 58 : 57 ) );
    
    rankTable = "gamedata/tables/mp/cu_ranktable.csv";
    rank_title = TableLookupColumnForRow( rankTable, row_id, 5 );
    rank_icon = TableLookupColumnForRow( rankTable, row_id, 6 );

    self util::setClientSysState( "Progression", sprintf( "{0},{1},{2},{3},{4}|{5},{6},{7}",
        self.prestige,
        self.xp,
        self.current_level, 
        rank_title,
        rank_icon,
        self.weapon_data[ 0 ],
        self.weapon_data[ 1 ],
        self.weapon_data[ 2 ]
    ), self );

    wait( 0.5 );

    self LUINotifyEvent( &"WriteData", 1, do_prestige );
    self LUINotifyEvent( &"RetrieveData", 0 );
}

function watch_data()
{
    level endon( "intermission" );
    level endon( "game_ended" );
    level endon( "end_game" );
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "bled_out" );

    old_level = undefined;

    for( ;; )
    {
        self waittill( "menuresponse", menu, response );

        if( IS_EQUAL( menu, "ProgressionData" ) )
        {
            data = StrTok( response, "|" );
            levelData = StrTok( data[ 0 ], "," );
            weaponData = StrTok( data[ 1 ], "," );

            self.prestige = Int( levelData[ 0 ] );
            self.xp = Int( levelData[ 1 ] );
            self.max_xp = ( ( IS_EQUAL( self.prestige, 10 ) && self.xp >= 1454000 ) ? 13266500 : 1454000 );
            a_attachments = sprintf( "{0}/{1}", 0, 0 );
            a_camos = sprintf( "{0}/{1}", 0, 0 );

            rankTable = "gamedata/tables/mp/cu_ranktable.csv";
            weaponTable = "gamedata/weapons/po_weapontable.csv";

            w_current = self GetCurrentWeapon();
            idx = get_weaponlist_index( self.a_weapons, w_current ); 
            
            for( i = 3; i < 58; i++ )
            {
                minXP = Int( TableLookupColumnForRow( rankTable, i, 2 ) );
                maxXP = Int( TableLookupColumnForRow( rankTable, i, 7 ) );

                if( self.xp >= minXP && self.xp <= maxXP )
                    self.current_level = ( Int( TableLookupColumnForRow( rankTable, i, 0 ) ) + 1 );
            }
            if( IS_EQUAL( self.prestige, 10 ) && self.xp >= 1454000 )
            {
                prestige_level = Floor( ( self.xp - 1454000 ) / 12500 );
                self.current_level = ( ( ( 55 + prestige_level ) <= 1000 ) ? ( 55 + prestige_level ) : 1000 );
            }
            if( !isdefined( self.old_level ) )
            {
                self.old_level = self.current_level;
            }
            for( i = 1; i < 33; i++ )
            {
                weapon = TableLookupColumnForRow( weaponTable, i, 0 );
                
                if( IS_EQUAL( weapon, weaponData[ 0 ] ) )
                {
                    reqKills = StrTok( TableLookupColumnForRow( weaponTable, i, 1 ), "|" );
                    reqHeadshots = StrTok( TableLookupColumnForRow( weaponTable, i, 2 ), "|" );
                    a_attachments = sprintf( "{0}/{1}", 0, reqKills.size );
                    a_camos = sprintf( "{0}/{1}", 0, reqHeadshots.size );

                    for( j = 0; j < reqKills.size; j++ )
                        if( Int( weaponData[ 1 ] ) >= Int( reqKills[ j ] ) )
                            a_attachments = sprintf( "{0}/{1}", ( j + 1 ), reqKills.size );
                    for( k = 0; k < reqHeadshots.size; k++ )
                        if( Int( weaponData[ 2 ] ) >= Int( reqHeadshots[ k ] ) )
                            self.camo_idx = j;
                }
            }
            if( !IS_EQUAL( self.old_level, self.current_level ) )
            {
                row_id = 0;
                if( IS_EQUAL( self.prestige, 0 ) )
                    row_id = ( self.current_level + 2 );
                else
                    row_id = ( self.prestige + ( ( self.current_level > 55 ) ? 58 : 57 ) );

                rank_title = TableLookupColumnForRow( rankTable, row_id, 5 );
                rank_icon = TableLookupColumnForRow( rankTable, row_id, 6 );

                self util::setClientSysState( "Progression", sprintf( "{0},{1},{2},{3},{4}|{5},{6},{7}",
                    self.prestige,
                    self.xp,
                    self.current_level, 
                    rank_title,
                    rank_icon,
                    self.weapon_data[ 0 ],
                    self.weapon_data[ 1 ],
                    self.weapon_data[ 2 ]
                ), self );

                self LUINotifyEvent( &"RankPopup", 0 );
                
                self PlaySoundToPlayer( "rex_coldwar_rankup", self );
                self.old_level = self.current_level;
            }
        }
    }
}

function watch_gun_camo()
{
    for( ;; )
    {
        self waittill( "weapon_change_complete" );

        while( !host UseButtonPressed() )
            WAIT_SERVER_FRAME;
        
        w_current = host GetCurrentWeapon();
        naw_current = zm_weapons::get_nonalternate_weapon( w_current );

        level.pack_a_punch_camo_index = array::random( array( 15, 16, 17, 121 ) );
        level.pack_a_punch_camo_index_number_variants = ( ( IS_EQUAL( level.pack_a_punch_camo_index, 121 ) ) ? 5 : undefined );
        
        host zm_weapons::weapon_take( naw_current );
            WAIT_SERVER_FRAME;
        w_buildkit = host give_build_kit_weapon( naw_current );

        while( host UseButtonPressed() )
            WAIT_SERVER_FRAME;
    }
}

function prestige_test()
{
    for( ;; )
    {
        WAIT_SERVER_FRAME;

        if( self ActionSlotThreeButtonPressed() )
        {
            self thread update_data( 1 );

            while( self ActionSlotThreeButtonPressed() )
                WAIT_SERVER_FRAME;
        }
    }
}

function give_build_kit_weapon( weapon )
{
	upgraded = false;
	camo = undefined;
	base_weapon = weapon;

    if( isdefined( weapon.pap_camo_to_use ) )
        camo = weapon.pap_camo_to_use;
    else
        camo = zm_weapons::get_pack_a_punch_camo_index( undefined );
	if( zm_weapons::is_weapon_upgraded( weapon ) )
	{
		upgraded = true;
		base_weapon = zm_weapons::get_base_weapon( weapon );
	}
	if( zm_weapons::is_weapon_included( base_weapon ) )
	{
		force_attachments = zm_weapons::get_force_attachments( base_weapon.rootweapon );
	}
	if( isdefined( force_attachments ) && force_attachments.size )
	{
		if( upgraded )
		{
			packed_attachments = [];
			packed_attachments[ packed_attachments.size ] = "extclip";
			packed_attachments[ packed_attachments.size ] = "fmj";
			force_attachments = ArrayCombine( force_attachments, packed_attachments, false, false );
		}
		weapon = GetWeapon( weapon.rootweapon.name, force_attachments );

		if( !isdefined( camo ) )
			camo = 0;

		weapon_options = self CalcWeaponOptions( camo, 0, 0 );
		acvi = 0;
	}
	else
	{
		weapon = self GetBuildKitWeapon( weapon, upgraded );

		weapon_options = self GetBuildKitWeaponOptions( weapon, camo );

		acvi = self GetBuildKitAttachmentCosmeticVariantIndexes( weapon, upgraded );
	}
	self GiveWeapon( weapon, weapon_options, acvi );
    self SwitchToWeaponImmediate( weapon );

	return weapon;
}

function fake_physicslaunch( target_pos, power, dir_vel )
{
	start_pos = self.origin;
	gravity = ( GetDvarInt( "bg_gravity" ) * -1 );
	dist = Distance( start_pos, target_pos );
	time = ( dist / power );
	delta = ( target_pos - start_pos );
	drop = ( ( 0.5 * gravity ) * ( time * time ) );
	velocity = ( ( delta[ 0 ] / time ), ( delta[ 1 ] / time ), ( ( delta[ 2 ] - drop ) / time ) );

    self thread horz_arch( dir_vel, delta, velocity, time );

	self MoveGravity( velocity, time );
	return time;
}

function horz_arch( dir_vel, delta, velocity, time )
{
    offset = 0;

    for( i = 0; i < 2; i++ )
    {
        half_time = ( GetTime() + ( ( time / 2 ) * 1000 ) );

        while( GetTime() < half_time )
        {
            WAIT_SERVER_FRAME;

            offset = ( ( i % 2 == 0 ) ? dir_vel : -dir_vel );
            self.origin = ( delta + VectorScale( AnglesToRight( ( delta[ 0 ], delta[ 1 ] / half_time, ) ), offset ) );
        }
    }
}
