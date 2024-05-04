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
#using scripts\shared\lui_shared;

#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_unitrigger;

// REX - Heisenberg AI
#using scripts\zm\_rex_ai_heisenberg;

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

#insert scripts\zm\_zm_utility.gsh;
#insert scripts\zm\_zm_weapons.gsh;
#insert scripts\zm\_zm_perks.gsh;

#define RE8_MOLD_CLOSED         "rex_re8_mold_closed"
#define RE8_KEY                 "rex_re8_mold_key"
#define RE8_KEY_GRAB_FX         "zombie/fx_powerup_grab_solo_zmb"
#define RE8_KEY_FX              "zombie/fx_powerup_on_solo_zmb"
#define RE8_GRAB_FX             "zombie/fx_ritual_item_grab_zod_zmb"
#define SQUARED(x) ( x * x )

#precache( "xmodel", RE8_MOLD_CLOSED );
#precache( "xmodel", RE8_KEY );
#precache( "fx", RE8_KEY_GRAB_FX );
#precache( "fx", RE8_KEY_FX );
#precache( "fx", RE8_GRAB_FX );

#using_animtree( "animtree_rex_re8_ee" );

#namespace rex_re8_ee;

REGISTER_SYSTEM( "rex_re8_ee", &__init__, undefined )

function __init__()
{
    level thread key_machine_init();
	level thread elevator_init();
    level thread boss_door_init();

    callback::on_connect( &on_player_connect );
}

function on_player_connect()
{
    self.has_ingot = false;
    self.has_mold = false;
    self.has_key = false;
    self.key_target = undefined;
}

function key_machine_init()
{
    level.mold_machines = GetEntArray( "key_mold_machine", "targetname" );
    level.key_ingots = GetEntArray( "key_ingot", "targetname" );
    level.key_molds = GetEntArray( "key_mold", "targetname" );

    array::thread_all( level.mold_machines, &key_machine_logic );
    array::thread_all( level.key_ingots, &key_ingot_logic );
    array::thread_all( level.key_molds, &key_mold_logic );
}

function key_ingot_logic()
{
    self create_unitrigger( "", undefined, 64, &ingot_visibility_and_update_prompt );

    while( isdefined( self ) )
    {
        self waittill( "trigger_activated", player );

        if( !player.has_ingot )
        {
            player.has_ingot = true;

            PlayFX( RE8_GRAB_FX, self.origin, AnglesToForward( self.angles ), AnglesToUp( self.angles ) );
            player PlaySoundToPlayer( "rex_re8_ingot_pickup", player );
            
            zm_unitrigger::unregister_unitrigger( self.s_unitrigger );
            self Delete();
        }
    }
}

function ingot_visibility_and_update_prompt( player )
{
    can_use = self ingot_visibility_unitrigger( player );
    if( isdefined( self.hint_string ) )
        self SetHintString( self.hint_string );
    return can_use;
}

function ingot_visibility_unitrigger( player )
{
    if( !is_valid( player ) )
    {
        self.hint_string = "";
        return false;
    }
    if( !player.has_ingot )
    {
        self.hint_string = "Hold ^1[{+activate}]^7 to pickup the Ingot";
        return true;
    }
    self.hint_string = "^1You already have an Ingot!";
    return false;
}

function key_mold_logic()
{
    self create_unitrigger( "", undefined, 64, &mold_visibility_and_update_prompt );

    while( isdefined( self ) )
    {
        self waittill( "trigger_activated", player );

        if( !player.has_mold )
        {
            player.has_mold = true;

            PlayFX( RE8_GRAB_FX, self.origin, AnglesToForward( self.angles ), AnglesToUp( self.angles ) );
            player PlaySoundToPlayer( "rex_re8_pickup", player );
            
            zm_unitrigger::unregister_unitrigger( self.s_unitrigger );
            self Delete();
        }
    }
}

function mold_visibility_and_update_prompt( player )
{
    can_use = self mold_visibility_unitrigger( player );
    if( isdefined( self.hint_string ) )
        self SetHintString( self.hint_string );
    return can_use;
}

function mold_visibility_unitrigger( player )
{
    if( !is_valid( player ) )
    {
        self.hint_string = "";
        return false;
    }
    if( !player.has_mold )
    {
        self.hint_string = "Hold ^1[{+activate}]^7 to pickup the Key Mold";
        return true;
    }
    self.hint_string = "^1You already have a Key Mold!";
    return false;
}

function key_door_logic()
{
    ents = GetEntArray( self.target, "targetname" );
    for( i = 0; i < ents.size; i++ )
    {
        if( IS_EQUAL( ents[ i ].classname, "script_brushmodel" ) )
            clip = ents[ i ];
        if( IS_EQUAL( ents[ i ].classname, "script_origin" ) )
            trig = ents[ i ];
    }
    trig create_unitrigger( "", undefined, 64, &door_visibility_and_update_prompt );
    trig.target = self.targetname;

    while( isdefined( trig ) )
    {
        trig waittill( "trigger_activated", player );

        IPrintLnBold( "YUM" );
        
        if( player.has_key && ( player.key_target == trig.target ) )
        {
            zm_unitrigger::unregister_unitrigger( trig.s_unitrigger );
            
            self RotateTo( ( self.angles + VectorScale( AnglesToForward( trig.angles ), 125 ) * -1 ), 2, 0.25, 0.5 );
            self PlaySound( "rex_re8_door_open" );

            clip Delete();
            trig Delete();
            
            player.has_key = false;
            player.key_target = undefined;
        }
    }
}

function door_visibility_and_update_prompt( player )
{
    can_use = self door_visibility_unitrigger( player );
    if( isdefined( self.hint_string ) )
        self SetHintString( self.hint_string );
    return can_use;
}

function door_visibility_unitrigger( player )
{
    if( !is_valid( player ) )
    {
        self.hint_string = "";
        return false;
    }
    if( !player.has_key )
    {
        self.hint_string = "^1This door requires a Key!";
        return false;
    }
    else
    {
        if( player.key_target != self.stub.related_parent.target )
        {
            self.hint_string = "^1This door requires a different Key!";
            return false;
        }
        else
        {
            self.hint_string = "Hold ^1[{+activate}]^7 to unlock the Door";
            return true;
        }
    }    
}

function key_machine_logic()
{
    door = GetEnt( self.target, "targetname" );
    door thread key_door_logic();

    self create_unitrigger( "", undefined, 64, &machine_visibility_and_update_prompt );

    self.is_forging = false;
    self.has_ingot = false;
    self.has_mold = false;
    self.has_key = false;

    while( isdefined( self.s_unitrigger ) )
    {
        self waittill( "trigger_activated", player );

        if( !self.has_mold )
        {
            if( !player.has_mold )
                continue;
            player.has_mold = false;
            self.has_mold = true;

            self Attach( RE8_MOLD_CLOSED, "moldpos2" );
            player PlaySoundToPlayer( "rex_re8_mold_insert", player );
        }
        else
        {
            if( !self.has_ingot )
            {
                if( !player.has_ingot )
                    continue;
                player PlaySoundToPlayer( "rex_re8_ingot_insert", player );

                player.has_ingot = false;
                self.has_ingot = true;
            }
            else
            {
                if( !self.has_key )
                {
                    self.is_forging = true;
                    self UseAnimTree( #animtree );
                    self AnimScripted( "", self.origin, self.angles, %rex_re8_mold_machine_anim );
                        wait( GetAnimLength( %rex_re8_mold_machine_anim ) );
                    key = util::spawn_model( RE8_KEY, ( self GetTagOrigin( "moldpos2" ) + VectorScale( AnglesToRight( self GetTagAngles( "moldpos2" ) ), 24 ) * -1 ) );
                    PlayFXOnTag( RE8_KEY_FX, key, "tag_origin" );

                    self.is_forging = false;
                    self.has_key = true;

                    continue;
                }
                PlayFX( RE8_KEY_GRAB_FX, key.origin, AnglesToForward( key.angles ), AnglesToUp( key.angles ) );
                player PlaySoundToPlayer( "rex_re8_key_pickup", player );

                key Delete();
                self Detach( "rex_re8_mold_closed", "moldpos2" );
                player.has_key = true;
                player.key_target = self.target;

                IPrintLnBold( player.key_target );

                zm_unitrigger::unregister_unitrigger( self.s_unitrigger );
            }
        }
    }
}

function machine_visibility_and_update_prompt( player )
{
    can_use = self machine_visibility_unitrigger( player );
    if( isdefined( self.hint_string ) )
        self SetHintString( self.hint_string );
    return can_use;
}

function machine_visibility_unitrigger( player )
{
    if( !is_valid( player ) )
    {
        self.hint_string = "";
        return false;
    }
    if( self.stub.related_parent.is_forging )
    {
        self.hint_string = "";
        return false;
    }
    if( !self.stub.related_parent.has_mold )
    {
        if( !player.has_mold )
        {
            self.hint_string = "^1This machine requires a Key Mold!";
            return false;
        }
        else
        {
            self.hint_string = "Hold ^1[{+activate}]^7 to insert the Key Mold";
            return true;
        }
    }
    if( !self.stub.related_parent.has_ingot )
    {
        if( !player.has_ingot )
        {
            self.hint_string = "^1This machine requires an Ingot!";
            return false;
        }
        else
        {
            self.hint_string = "Hold ^1[{+activate}]^7 to insert the Ingot";
            return true;
        }
    }
    if( !self.stub.related_parent.has_key )
    {
        self.hint_string = "Hold ^1[{+activate}]^7 to forge the Key";
        return true;
    }
    if( !player.has_key )
    {
        self.hint_string = "Hold ^1[{+activate}]^7 to pickup the Key";
        return true;
    }
    else
    {
        self.hint_string = "^1You already have a Key!";
        return false;
    }
}

function elevator_init()
{
    level.elevator_fuses = GetEntArray( "elevator_fuse", "targetname" );
    level.elevator_fuses_inserted = 0;

    level.elevator_panel = GetEnt( "elevator_panel", "targetname" );
    level.elevator_panel create_unitrigger( sprintf( "Hold [{+activate}] to insert the Fuse \n^3Total Fuses: {0}/{1}", level.elevator_fuses_inserted, level.elevator_fuses.size ), undefined, 64, &panel_visibility_and_update_prompt );
    
    level.elevator_button = struct::get( "elevator_trigger" );
    level.elevator_button thread elevator_logic();

    array::run_all( level.elevator_fuses, &Hide );
    array::thread_all( level.elevator_fuses, &fuse_logic );
}

function fuse_logic()
{
    self.obj = GetEnt( self.target, "targetname" );
    self.obj create_unitrigger( "Hold [{+activate}] to pickup the Fuse", undefined, 64 );

    self.obj waittill( "trigger_activated", player );

    level.elevator_fuse_collected++;
    player PlaySoundToPlayer( "rex_re8_fuse_pickup", player );

    zm_unitrigger::unregister_unitrigger( self.obj.s_unitrigger );
    self.obj Delete();

    level.elevator_panel waittill( "trigger_activated", player );

    level.elevator_fuses_inserted++;
    player PlaySoundToPlayer( "rex_re8_fuse_insert", player );

    if( IS_EQUAL( level.elevator_fuses_inserted, level.elevator_fuses.size ) )
    {
        players = GetPlayers();
        for( i = 0; i < players.size; i++ )
        {
            players[ i ] PlaySoundToPlayer( "rex_re8_panel_powerup", players[ i ] );
        }
        level.elevator_panel PlayLoopSound( "rex_re8_panel_ambience", 1 );
    }
    self Show();
}

function panel_visibility_and_update_prompt( player )
{
    can_use = self panel_visibility_unitrigger( player );
    if( isdefined( self.hint_string ) )
        self SetHintString( self.hint_string );
    return can_use;
}

function panel_visibility_unitrigger( player )
{
    if( !is_valid( player ) )
    {
        self.hint_string = "";
        return false;
    }
    if( IS_EQUAL( level.elevator_fuses_inserted, level.elevator_fuses.size ) )
    {
        self.hint_string = "";
        return false;
    }
    self.hint_string = sprintf( "Hold ^1[{+activate}]^7 to insert Fuse \n^3Total Fuses: {0}/{1}", level.elevator_fuses_inserted, level.elevator_fuses.size );
    return true;
}

function elevator_logic()
{
    player_locs = struct::get_array( "heisenberg_player_spawn", "targetname" );
    player_locs = array::randomize( player_locs );

    self create_unitrigger( "", undefined, 86, &elevator_visibility_and_update_prompt );
    self waittill( "trigger_activated", player );

    zm_unitrigger::unregister_unitrigger( self.s_unitrigger );

    SetDvar( "ai_disableSpawn", 1 );

    a_zombies = GetAISpeciesArray();
    for( i = 0; i < a_zombies.size; i++ )
        a_zombies[ i ] Kill();

    array::thread_all( GetPlayers(), &disable_controls );
    array::thread_all( GetPlayers(), &lui::screen_fade_out, 2.5 );
        wait( 2.5 );

    players = GetPlayers();
    for( i = 0; i < players.size; i++ )
    {
        players[ i ] SetOrigin( player_locs[ i ].origin );
        players[ i ] SetPlayerAngles( player_locs[ i ].angles );
    }
        wait( 1.5 );
    array::thread_all( GetPlayers(), &zm::screen_fade_in, 2.5 );
        wait( 2.5 );
    array::thread_all( GetPlayers(), &enable_controls );
        wait( 1.5 );
    SetDvar( "ai_disableSpawn", 0 );
}

function elevator_visibility_and_update_prompt( player )
{
    can_use = self elevator_visibility_unitrigger( player );
    if( isdefined( self.hint_string ) )
        self SetHintString( self.hint_string );
    return can_use;
}

function elevator_visibility_unitrigger( player )
{
    if( !is_valid( player ) )
    {
        self.hint_string = "";
        return false;
    }
    if( !IS_EQUAL( level.elevator_fuses_inserted, level.elevator_fuses.size ) )
    {
        self.hint_string = "^1This elevator requires power!";
        return false;
    }
    self.hint_string = "Hold ^1[{+activate}]^7 to go to the next floor";
    return true;
}

function boss_door_init()
{
    player_locs = struct::get_array( "heisenberg_arena_player_spawn", "targetname" );

    ent = GetEnt( "hberg_trig", "targetname" );
    ent create_unitrigger( "Hold ^1[{+activate}]^7 to begin the Boss Fight\n^1DISCLAIMER: ^3THERE IS NO TURNING BACK", undefined, 64 );

    ent waittill( "trigger_activated", player );

    zm_unitrigger::unregister_unitrigger( ent.s_unitrigger );

    SetDvar( "ai_disableSpawn", 1 );

    a_zombies = GetAISpeciesArray();
    for( i = 0; i < a_zombies.size; i++ )
        a_zombies[ i ] Kill();

    array::thread_all( GetPlayers(), &disable_controls );
    array::thread_all( GetPlayers(), &lui::screen_fade_out, 2.5 );
        wait( 2.5 );

    players = GetPlayers();
    for( i = 0; i < players.size; i++ )
    {
        players[ i ] SetOrigin( player_locs[ i ].origin );
        players[ i ] SetPlayerAngles( player_locs[ i ].angles );
    }

    SetDvar( "ai_disableSpawn", 0 );
    entity = rex_heisenberg_ai::spawn_heisenberg();
    SetDvar( "ai_disableSpawn", 1 );
        wait( 1.5 );
    array::thread_all( GetPlayers(), &zm::screen_fade_in, 3.5 );
        wait( 3.5 );
    array::thread_all( GetPlayers(), &enable_controls );
        wait( 1.5 );
    SetDvar( "ai_disableSpawn", 0 );
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
    if( player zm_utility::has_powerup_weapon() )
		return false;
    if( player.currentWeapon.isRiotShield )
		return false;
    return true;
}

function disable_controls()
{
    self DisableWeapons();
	self DisableOffhandWeapons();
	self EnableInvulnerability();
	self FreezeControls( true );
}

function enable_controls()
{
    self EnableWeapons();
	self EnableOffhandWeapons();
	self DisableInvulnerability();
	self FreezeControls( false );
}
