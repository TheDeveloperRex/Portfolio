#using scripts\codescripts\struct; 
#using scripts\shared\system_shared; 
#using scripts\shared\array_shared; 
#using scripts\shared\vehicle_shared; 
#using scripts\zm\_zm_score;
#using scripts\shared\flag_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\clientfield_shared;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\trigger_shared;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_spawner;
#using scripts\shared\_burnplayer;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai_shared;
#using scripts\zm\_zm_attackables;
#insert scripts\shared\shared.gsh;
#using scripts\shared\hud_util_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_perks;
#insert scripts\shared\version.gsh;
#using scripts\zm\craftables\_zm_craftables;
#insert scripts\zm\_zm_utility.gsh;
#using scripts\zm\_zm_unitrigger;

#using scripts\zm\logical\logical_utility;

#define DEFAULT_HEALTH                          1500
#define RADIUS_FOR_HUD							1500
#define HEIGHT_FOR_HUD							200
#define COOLDOWN_TIME                           15

#define COOLDOWN_TEXT                           "Cooling Down"
#define STRING_HEALTH 						    "Attackable health: "
#define TRIGGER_TEXT                            "Hold ^3[{+activate}]^7 to initiate defense protocol"
#define TRIGGER_HINT                            "HINT_NOICON"
#define ATTACKABLE_ALREADY_ACTIVE               "Defend the attackable"

#define SPAWN_EXTRA_ZOMBIES                     true
#define KILL_EXTRA_ZOMBIE_AFTER_ATTACKABLE      true
#define NUMBER_OF_SPAWNER_FOR_EXTRA_ZOMBIES     4

#precache( "xmodel", "logical_m_droppod_machine_02" );

function autoexec __init__()
{
    level.attackable_active = false;
    level.attackable_health = 1500;
    level.attackable_timer = 60;
    level.distance_melee = 50;
    trigger = undefined;
    clip = undefined;
    
    thread zm_spawner::add_custom_zombie_spawn_logic( &attack_stuff );

    struct_attackable = GetEnt( "log_attackable", "targetname" );
    if( !isdefined( struct_attackable ) )
        break;
    struct_attackable.attackable_model_in_radiant = struct_attackable.model;
    attack_targets = GetEntArray( struct_attackable.target, "targetname" );
    for( t = 0; t < attack_targets.size; t++ ) {
        if( attack_targets[ t ].script_noteworthy == "attackable_trig" )
            trigger = attack_targets[ t ];
        if( attack_targets[ t ].classname == "script_brushmodel" )
            clip = attack_targets[ t ];
    }
    if( isdefined( struct_attackable.script_brake ) )
        closest_spawners = struct_attackable.script_brake;
    attackable_entity = struct_attackable attackable_create( "attackable", struct_attackable.origin, struct_attackable.angles, 8, level.distance_melee, false, "rex_attackables", undefined, clip );

    attackable = GetEnt( "attackable", "targetname" );
    attackable thread attackable_logic( trigger, true, struct_attackable, closest_spawners );
    trigger.is_cooling_down = false;
    trigger.attackable_done = false;
}

function attackable_logic( trigger, spawn_extra_zombie = SPAWN_EXTRA_ZOMBIES, struct, closest_spawners )
{
    self endon( "entityshutdown" );

    while( 1 )
    {
        trigger log_util::log_uni_trig_create( TRIGGER_TEXT, undefined, 50, &log_uni_trig_attackable_prompt_visibility );
        trigger waittill( "trigger_activated", player );

        zm_unitrigger::unregister_unitrigger( self.s_unitrigger );

        level.free_slot_attackable = 0;
        thread attackable_initiate( self, trigger );

        level.attackable_active = true;

        self thread activate_ui( player );
        
        if( spawn_extra_zombie )
            self thread spawn_zombies_init( closest_spawners );
        self thread attackable_timer( level.attackable_timer );

        self waittill("attack_succeed");

        trigger.is_cooling_down = true;
            wait( COOLDOWN_TIME );
        trigger.is_cooling_down = false;
    }
}

function log_uni_trig_attackable_prompt_visibility( player )
{
	can_use = self log_uni_trig_attackable_visibility( player );

	if( isdefined( self.hint_string ) )
		self SetHintString( self.hint_string );
	return can_use;
}

function log_uni_trig_attackable_visibility( player )
{
	if( !player log_util::log_is_player_valid() )
		return false;
    if( self.stub.related_parent.attackable_done || level.attackable_active ) {
        self.hint_string = "";
        return false;
    }
    self.hint_string = ( ( self.stub.related_parent.is_cooling_down ) ? COOLDOWN_TEXT : TRIGGER_TEXT );
	return true;
}

function activate_ui( player )
{
    self thread hintstrings_init();
}

function attackable_timer( time )
{
    self endon( "attack_succeed" );
        wait( time );
    self notify( "attackable_survived" );
}

function spawn_zombies_init( closest_spawners )
{
    spawner = GetEnt( "zombie_spawner", "script_noteworthy" );
    while( self.is_active )
    {
        while( self.is_active == true && zombie_utility::get_current_zombie_count() <= level.zombie_actor_limit )
        {
            struct = self spawn_location_selection( closest_spawners );
            zombie = zombie_utility::spawn_zombie( spawner, "attackable_zombies", struct );
            zombie.is_spawned = true;
            zombie.ignore_enemy_count = true;
                wait( 1 );
        }
        wait( 0.1 );
    }
    a_zombies = GetAITeamArray( level.zombie_team );
    foreach( ai in a_zombies )
    {
        if( isdefined( ai.is_spawned ) && KILL_EXTRA_ZOMBIE_AFTER_ATTACKABLE )
        {
            ai DoDamage( ai.health + 666, ai.origin );
            ai thread zombie_death::flame_death_fx();
        }
        wait( 0.05 );
    }
}

function spawn_location_selection( closest_spawners = NUMBER_OF_SPAWNER_FOR_EXTRA_ZOMBIES )
{
    a_spots = level.zm_loc_types[ "zombie_location" ];

    if( !isdefined( level.n_player_spawn_selection_index ) )
        level.n_player_spawn_selection_index = 0;
    active_spawners = ArraySortClosest( a_spots, self.origin, closest_spawners );
    s_spot = array::random( active_spawners );
    return s_spot;
}

function attack_stuff()
{
    self endon( "death" );

    while( isdefined( self ) && IsAlive( self ) )
    {
        b_attribute_active = self ai::get_behavior_attribute( "use_attackable" );
        
        if( !IS_TRUE( b_attribute_active ) )
           self ai::set_behavior_attribute( "use_attackable", true );

        foreach( attackable in level.attackables )
        {
            if( attackable.is_active )
                if( Distance( attackable.origin, self.origin ) < attackable.bundle.aggro_distance )
                    self.ignore_enemy_count = true;
            if( !attackable.is_active )
                self.ignore_enemy_count = false;
        }
        WAIT_SERVER_FRAME;
    }
}

function attackable_create( str_targetname, v_origin, v_angles, n_number_of_attack_spots = 4, n_distance_to_attack_point = 50, b_attackable_active, str_script_bundle_name, attack_attract_zombie = 1500, clip = undefined )
{
    DEFAULT( level.attackables, [] );

    if( n_distance_to_attack_point < 25 )
        n_distance_to_attack_point = 25;

    self.targetname = str_targetname;
    self.e_collision = clip;
    self EnableLinkTo();

    a_slots = [];
    f_increment = 360 / n_number_of_attack_spots;
    f_offset = RandomFloat( f_increment );
    
    for( i = 0; i < n_number_of_attack_spots; i++ )
    {
        n_forward_angle = f_offset + ( f_increment * i );
        n_forward_velocity = ( Cos( n_forward_angle ) * n_distance_to_attack_point, Sin( n_forward_angle ) * n_distance_to_attack_point, 0 );
        enemy_spot = Spawn( "script_origin", v_origin + n_forward_velocity );
        enemy_spot.targetname = str_targetname + "_slots";
        enemy_spot.angles = VectortoAngles( self.origin - enemy_spot.origin );

        v_ground = PlayerPhysicsTrace( enemy_spot.origin + ( 0, 0, 50 ), enemy_spot.origin - ( 0, 0, 50 ) );
        n_z_distance = v_ground[ 2 ] - self.origin[ 2 ];
        
        if( n_z_distance > 20 || n_z_distance < -20 || !IsPointOnNavMesh( enemy_spot.origin ) )
        {
            enemy_spot Delete();
            continue;
        }
        enemy_spot LinkTo( self );
        a_slots[ a_slots.size ] = enemy_spot;
    }
    self.target = str_targetname + "_slots";
    self.bundle = struct::get_script_bundle( "attackables", str_script_bundle_name );
    self.bundle.aggro_distance = attack_attract_zombie;
    self.bundle.is_active = b_attackable_active;
    self.health = DEFAULT_HEALTH;
    self.slot = a_slots;

    slot_remover = GetEnt( self.e_collision.target, "targetname" );
    self.trigger_ignore = GetEnt( slot_remover.target, "targetname" );
    slot_remover Delete();
    return self;
}

function attackable_unregister()
{
    if ( isdefined( self.slot ) && IsArray( self.slot ) && self.slot.size > 0 )
        for ( i = 0; i < self.slot; i++ )
            self.slot[ i ] Delete();
    self notify( "entityshutdown" );

    ArrayRemoveValue( level.attackables, self );
    foreach( player in GetPlayers() )
    {
        thread attackable_completed( player );
        thread delete_bar_security( player );
    }
}

function attackable_initiate( a_attackables, trigger )
{
    if( !IS_TRUE( IsInArray( level.attackables, a_attackables ) ) )
        ARRAY_ADD( level.attackables, a_attackables );

    a_attackables Show();
    a_attackables.e_collision Show();
    a_attackables.e_collision DisconnectPaths();
    
    a_attackables.health = DEFAULT_HEALTH;
    a_attackables zm_attackables::activate();
    a_attackables watch_attackable_completion( trigger );
}

function watch_attackable_completion( trigger )
{
    while( isdefined( self ) )
    {
        notify_returned = self util::waittill_any_return( "attackable_deactivated", "attackable_survived" );
        if( notify_returned == "attackable_deactivated" )
        {
            self zm_attackables::deactivate();
            for( i = 0; i < GetPlayers().size; i++ )
            {
                thread attackable_failed( GetPlayers()[ i ] );
                thread delete_bar_security( GetPlayers()[ i ] );
            }
            self notify( "attack_succeed" );
            break;
        }
        if( notify_returned == "attackable_survived" )
        {
            trigger.attackable_done = true;
            level.attackable_active = false;
            self zm_attackables::deactivate();
            self thread attackable_unregister();
            break;
        }
    }
}

function delete_bar_security( player )
{
    player.lowerTimer FadeOverTime( 0.3 );
    player.lowerTimer.alpha = 0;
    player.hackProgressBar FadeOverTime( 0.3 );
    player.hackProgressBar.alpha = 0;
        wait( 0.3 );
    player.lowerTimer Destroy();
    player.hackProgressBar hud::destroyElem();
        wait( 0.05 );
    player.is_in_trigger = false;
}

function activate_ui_timer( time )
{
    y = 63.2;
    fontScale = 1.1;
    self.lowerTimer = self hud::createClientTimer( "default", fontScale );
    self.lowerTimer SetTimer( time );
    
    self.lowerTimer.alignX = "center"; 
    self.lowerTimer.alignY = "top";
    self.lowerTimer.horzAlign = "center";  
    self.lowerTimer.vertAlign = "top";
    self.lowerTimer.x = 0; 
    if ( self IsSplitScreen() )
        y -= 20;

    self.lowerTimer.y = y;   
    self.lowerTimer.alpha = 1;
    self.lowerTimer.color = ( 0.3, 0.3, 0.3 );
    self.lowerTimer hud::showElem();
}

function hintstrings_init()
{
    self.gaz = 1;
    trig = Spawn( "trigger_radius", self.origin, 0, RADIUS_FOR_HUD, HEIGHT_FOR_HUD );

    while( self.is_active )
    {
        trig waittill( "trigger", player );

        if( !IS_TRUE( player.touch_for_the_first_time ) )
        {
            level.primaryProgressBarY = -183;
            if ( player IsSplitScreen() )
                level.primaryProgressBarY += 100;
            player activate_ui_timer( level.attackable_timer );
            player.hackProgressBar = player hud::createPrimaryProgressBar();
            player.hackProgressBar hud::updateBar( 1, 0.0 );
            self thread damage_hint_string( player );
        }
        if( IS_TRUE( player.is_in_trigger ) )
        {
            if( !self.is_active )
                break; 

            wait( 0.05 );
            continue;
        }
        if( IS_TRUE( self.is_active ) )
        {
            player.touch_for_the_first_time = true;
            player notify( "touch_trigger" );
            player.is_in_trigger = true;
            self thread display_hud( player, trig );
                wait( 0.05 );
        }
    }
    for( i = 0; i < GetPlayers().size; i++ )
    {
        GetPlayers()[ i ].touch_for_the_first_time = false;
        GetPlayers()[ i ].is_in_trigger = false;
        self.deactivate = false;
    }
}

function attackable_failed( player )
{
    player IPrintLnBold( "^1Attackable Failed" );
    level.attackable_active = false;
}

function attackable_completed( player )
{
    player IPrintLnBold( "^2Attackable Secured" );
    level.attackable_active = false;
}

function hintstring_delete()
{
    self FadeOverTime( 0.3 );
    self.alpha = 0;
        wait( 0.3 );
    self Destroy();
}

function display_hud( player, trig )
{   
    damage_text_element = [];
    self thread damage_hint_string_show_hide_delete( player, trig );

    while( player IsTouching( trig ) && isdefined( trig ) )
        WAIT_SERVER_FRAME;

    player.hackProgressBar FadeOverTime( 0.3 );
    player.lowerTimer FadeOverTime( 0.3 );
    player.hackProgressBar.alpha = 0;
    player.lowerTimer.alpha = 0;
        wait( 0.3 );
    player.lowerTimer hud::hideElem();
    player.hackProgressBar hud::hideElem();
        wait( 0.05 );
    player.is_in_trigger = false;
}

function damage_hint_string( player )
{
    while( self.gaz > 0 || self.is_active )
    {
        self waittill( "attackable_damaged", damage );
        self.gaz = self get_decrement( damage, self.gaz );
        player.hackProgressBar hud::updateBar( self.gaz, 0.0 );
        player.hackProgressBar.bar.color = ( 1, self.gaz, self.gaz );
    }
}

function damage_hint_string_none( player )
{
    while( self.gaz > 0 || self.is_active )
    {
        self waittill( "attackable_damaged", damage );
        self.gaz = self get_decrement( damage, self.gaz );   
    }
}

function damage_hint_string_show_hide_delete( player, trig )
{
    trig endon( "trigger_delete" );
    while( self.gaz > 0 )
    {
        str_notify_caught = player util::waittill_any_return( "touch_trigger" );
        if ( str_notify_caught == "touch_trigger" )
        {
            player.lowerTimer hud::showElem();
            player.hackProgressBar hud::showElem();
        }
    }
    player.lowerTimer FadeOverTime( 0.3 );
    player.lowerTimer.alpha = 0.1;
    player.hackProgressBar FadeOverTime( 0.3 );
    player.hackProgressBar.alpha = 0.1;
        wait( 0.3 );
    player.hackProgressBar hud::destroyElem();
    player.lowerTimer Destroy();
}

function get_decrement( damage, gaz )
{
    if( IS_TRUE( self.health_defined_in_radiant ) )
        n_bar_progress_percent = ( self.health / level.attackable_health );
    else
        n_bar_progress_percent = ( self.health / DEFAULT_HEALTH );
    return n_bar_progress_percent;
}

