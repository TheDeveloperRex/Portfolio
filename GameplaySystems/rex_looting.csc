//*****************************************************************************
// USINGS
//*****************************************************************************

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\system_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\shared\duplicaterender.gsh;
#using scripts\shared\duplicaterender_mgr;

#using scripts\zm\_load;
#using scripts\zm\_zm_weapons;

#insert scripts\zm\log_looting.gsh;

//*****************************************************************************
// DEFINES
//*****************************************************************************

#define KEYLINE_MATERIAL_GREEN    				"mc/loot_outline_model_green"
#define KEYLINE_MATERIAL_WHITE    				"mc/loot_outline_model_white"
#define KEYLINE_MATERIAL_BLUE    				"mc/loot_outline_model_blue"
#define KEYLINE_MATERIAL_RED    				"mc/loot_outline_model_red"
#define KEYLINE_MATERIAL_ORANGE    				"mc/loot_outline_model_orange"

//*****************************************************************************
// PRECACHE
//*****************************************************************************

//*****************************************************************************
// MAIN
//*****************************************************************************

#namespace log_looting;

REGISTER_SYSTEM_EX( "log_looting", &init, &log_main, undefined )

function init()
{
	level.sitrepscan1_enable = GetDvarInt( "scr_sitrepscan1_enable", 2 );
    level.sitrepscan1_setoutline = GetDvarInt( "scr_sitrepscan1_setoutline", 1 );
    level.sitrepscan1_setsolid = GetDvarInt( "scr_sitrepscan1_setsolid", 0);
    level.sitrepscan1_setlinewidth = GetDvarInt( "scr_sitrepscan1_setlinewidth", 3 );
    level.sitrepscan1_setradius = GetDvarInt( "scr_sitrepscan1_setradius", 259 );
    level.sitrepscan1_setfalloff = GetDvarFloat( "scr_sitrepscan1_setfalloff", 1 );
    level.sitrepscan1_setdesat = GetDvarFloat( "scr_sitrepscan1_setdesat", 0 );

    level.sitrepscan2_enable = GetDvarInt( "scr_sitrepscan2_enable", 2 );
    level.sitrepscan2_setoutline = GetDvarInt( "scr_sitrepscan2_setoutline", 1 );
    level.sitrepscan2_setsolid = GetDvarInt( "scr_sitrepscan2_setsolid", 0 );
    level.sitrepscan2_setlinewidth = GetDvarInt( "scr_sitrepscan2_setlinewidth", 3 );
    level.sitrepscan2_setradius = GetDvarInt( "scr_sitrepscan2_setradius", 250 );
    level.sitrepscan2_setfalloff = GetDvarFloat( "scr_sitrepscan2_setfalloff", 1 );
    level.sitrepscan2_setdesat = GetDvarFloat("scr_sitrepscan2_setdesat", 0 );

	callback::on_localplayer_spawned( &on_localplayer_spawned );

 	clientfield::register( "scriptmover", "enable_keyline_white", VERSION_SHIP, 1, "int", &EnableKeylineWhite, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "scriptmover", "enable_keyline_green", VERSION_SHIP, 1, "int", &EnableKeylineGreen, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "scriptmover", "enable_keyline_blue", VERSION_SHIP, 1, "int", &EnableKeylineBlue, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "scriptmover", "enable_keyline_red", VERSION_SHIP, 1, "int", &EnableKeylineRed, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "scriptmover", "enable_keyline_orange", VERSION_SHIP, 1, "int", &EnableKeylineOrange, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "scriptmover", "enable_keyline_chest", VERSION_SHIP, 1, "int", &EnableKeylineChest, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );

    duplicate_render::set_dr_filter_offscreen( "enable_keyline_white", 30, "enable_keyline_white_active", "enable_keyline_white_disabled", 2, KEYLINE_MATERIAL_WHITE, 0 );
    duplicate_render::set_dr_filter_offscreen( "enable_keyline_green", 30, "enable_keyline_green_active", "enable_keyline_green_disabled", 2, KEYLINE_MATERIAL_GREEN, 0 );
    duplicate_render::set_dr_filter_offscreen( "enable_keyline_blue", 30, "enable_keyline_blue_active", "enable_keyline_blue_disabled", 2, KEYLINE_MATERIAL_BLUE, 0 );
    duplicate_render::set_dr_filter_offscreen( "enable_keyline_red", 30, "enable_keyline_red_active", "enable_keyline_red_disabled", 2, KEYLINE_MATERIAL_RED, 0 );
    duplicate_render::set_dr_filter_offscreen( "enable_keyline_orange", 30, "enable_keyline_orange_active", "enable_keyline_orange_disabled", 2, KEYLINE_MATERIAL_ORANGE, 0 );
    duplicate_render::set_dr_filter_offscreen( "enable_keyline_chest", 30, "enable_keyline_chest_active", "enable_keyline_chest_dsabled", 2, KEYLINE_MATERIAL_WHITE, 0 );
}

function log_main()
{

}

function on_localplayer_spawned( localClientNum )
{
    self thread updateSitrepScan();
    self oed_sitrepscan_setradius( 250 );
}

function updateSitrepScan()
{
    self endon("entityshutdown");
    while( 1 )
    {
        self oed_sitrepscan_enable( level.sitrepscan1_enable );
        self oed_sitrepscan_setoutline( level.sitrepscan1_setoutline );
        self oed_sitrepscan_setsolid( level.sitrepscan1_setsolid );
        self oed_sitrepscan_setlinewidth( level.sitrepscan1_setlinewidth );
        self oed_sitrepscan_setradius( level.sitrepscan1_setradius );
        self oed_sitrepscan_setfalloff( level.sitrepscan1_setfalloff );
        self oed_sitrepscan_setdesat( level.sitrepscan1_setdesat );
        self oed_sitrepscan_enable( level.sitrepscan2_enable, 1 );
        self oed_sitrepscan_setoutline( level.sitrepscan2_setoutline, 1 );
        self oed_sitrepscan_setsolid( level.sitrepscan2_setsolid, 1 );
        self oed_sitrepscan_setlinewidth( level.sitrepscan2_setlinewidth, 1 );
        self oed_sitrepscan_setradius( level.sitrepscan2_setradius, 1 );
        self oed_sitrepscan_setfalloff( level.sitrepscan2_setfalloff, 1 );
        self oed_sitrepscan_setdesat( level.sitrepscan2_setdesat, 1 );
            wait( 1 );
    }
}

function EnableKeylineWhite( n_local_client_num, n_old_val, n_new_val, b_new_ent, b_initial_snap, str_field_name, b_was_time_jump )
{
    if( n_new_val )
    {
        self duplicate_render::set_dr_flag( "enable_keyline_white_active", 1 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
    else
    {
        self duplicate_render::set_dr_flag( "enable_keyline_white_disabled", 0 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
}

function EnableKeylineGreen( n_local_client_num, n_old_val, n_new_val, b_new_ent, b_initial_snap, str_field_name, b_was_time_jump )
{
    if ( n_new_val )
    {
        self duplicate_render::set_dr_flag( "enable_keyline_green_active", 1 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
    else
    {
        self duplicate_render::set_dr_flag( "enable_keyline_green_disabled", 0 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
}

function EnableKeylineBlue( n_local_client_num, n_old_val, n_new_val, b_new_ent, b_initial_snap, str_field_name, b_was_time_jump )
{
    if ( n_new_val )
    {
        self duplicate_render::set_dr_flag("enable_keyline_blue_active", 1);
        self duplicate_render::update_dr_filters(n_local_client_num);
    }
    else
    {
        self duplicate_render::set_dr_flag("enable_keyline_blue_disabled", 0);
        self duplicate_render::update_dr_filters(n_local_client_num);
    }
}

function EnableKeylineRed( n_local_client_num, n_old_val, n_new_val, b_new_ent, b_initial_snap, str_field_name, b_was_time_jump )
{
    if ( n_new_val )
    {
        self duplicate_render::set_dr_flag( "enable_keyline_red_active", 1 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
    else
    {
        self duplicate_render::set_dr_flag( "enable_keyline_red_disabled", 0 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
}

function EnableKeylineOrange( n_local_client_num, n_old_val, n_new_val, b_new_ent, b_initial_snap, str_field_name, b_was_time_jump )
{
    if ( n_new_val )
    {
        self duplicate_render::set_dr_flag( "enable_keyline_orange_active", 1 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
    else
    {
        self duplicate_render::set_dr_flag( "enable_keyline_orange_disabled", 0 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
}

function EnableKeylineChest( n_local_client_num, n_old_val, n_new_val, b_new_ent, b_initial_snap, str_field_name, b_was_time_jump )
{
    if ( n_new_val )
    {
        self duplicate_render::set_dr_flag( "enable_keyline_chest_active", 1 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
    else
    {
        self duplicate_render::set_dr_flag( "enable_keyline_chest_disabled", 0 );
        self duplicate_render::update_dr_filters( n_local_client_num );
    }
}
