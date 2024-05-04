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

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_unitrigger;
#using scripts\shared\ai\zombie_utility;

// Logical - Utility
#using scripts\zm\logical\logical_utility;

#namespace log_ss;

REGISTER_SYSTEM_EX( "log_simon_says", &init, &rex_main, undefined )

function init()
{
}

function rex_main()
{
	level.screen_tags = array( "off_tag", "blue_tag", "red_tag", "yellow_tag", "green_tag" );
	level.computers = GetEntArray( "simon_says_terminal", "targetname" );
	level.ss_panel = GetEnt( "simon_says_panel", "targetname" );
	level.pattern_failed = false;
	level.current_pattern = [];
	level.computers_done = 0;
	level.patterns_done = 0;
	level.patterns = 5;

	level flag::init( "simon_says_completed" );

	level thread simon_says_init();
}

function simon_says_init()
{
	for( i = 0; i < level.computers.size; i++ )
	{
		level.computers[ i ].screen = level.computers[ i ].script_string + "_tag";
		for( s = 1; s < level.screen_tags.size; s++ )
			level.computers[ i ] HidePart( level.screen_tags[ s ] );
	}
	level.ss_panel thread simon_says_logic( level.computers, 30 );
}

function simon_says_logic( computers, cooldown, delay = 5 )
{
	level thread watch_patterns();
	array::thread_all( computers, &watch_pattern_shot );

	while( level.patterns_done < level.patterns )
	{
		self log_util::log_uni_trig_create( "Hold [{+activate}] to begin pattern sequence", undefined, 50 );
		self waittill( "trigger_activated", player );
		zm_unitrigger::unregister_unitrigger( self.s_unitrigger );

		while( !level.pattern_failed )
		{
			if( !level flag::get( "simon_says_completed" ) )
			{
				ARRAY_ADD( level.current_pattern, computers[ RandomInt( computers.size ) ] );
				do_pattern_sequence( level.current_pattern, 2 );

				while( level.computers_done < level.current_pattern.size )
				{
					if( level.computers_done == level.current_pattern.size )
					{
						can_damage( level.computers, false );
						level.computers_done = 0;
					}
					if( level.pattern_failed )
						break;
					WAIT_SERVER_FRAME;
				}
				if( level.patterns_done < level.patterns )
				{
					level.computers_done = 0;
					level.patterns_done++;
					wait( delay );
				}
			}
			else
				return;
			WAIT_SERVER_FRAME;
		}
		if( level.pattern_failed )
		{
			level.pattern_failed = false;
			level.current_pattern = [];
			level.computers_done = 0;
			level.patterns_done = 0;
			wait( cooldown );
		}
	}
}

function watch_pattern_shot()
{
	can_damage( level.computers, true );

	while( level.patterns_done < level.patterns )
	{
		if( !level.pattern_failed )
			can_damage( level.computers, true );

		self waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		if( level.patterns_done < level.patterns )
		{
			if( self.screen == level.current_pattern[ level.computers_done ].screen )
			{
				level thread do_pattern_sequence( level.current_pattern[ level.computers_done ], 1 );
				level.computers_done++;
			}
			else
			{
				for( i = 0; i < level.computers.size; i++ )
					level.computers[ i ] thread set_screen( level.screen_tags[ 0 ], level.computers[ i ].screen, false );
				can_damage( level.computers, false );
				level.pattern_failed = true;
			}
		}
	}
}

function watch_patterns()
{
	while( level.patterns_done < level.patterns )
        WAIT_SERVER_FRAME;
	level flag::set( "simon_says_completed" ); // this is set once all sequences are completed
}

// UTILITY //////////////////////////////////////////////////////////////////////////////////////////

function do_pattern_sequence( ents, time, str_notify )
{
	can_damage( ents, false );
	if( IsArray( ents ) )
	{
		for( i = 0; i < ents.size; i++ )
		{
				wait( time / 2 );
			ents[ i ] thread set_screen( level.screen_tags[ 0 ], ents[ i ].screen, true );
				wait( time / 2 );
			ents[ i ] thread set_screen( level.screen_tags[ 0 ], ents[ i ].screen, false );
		}
	}
	else
	{
			wait( time / 2 );
		ents thread set_screen( level.screen_tags[ 0 ], ents.screen, true );
			wait( time / 2 );
		ents thread set_screen( level.screen_tags[ 0 ], ents.screen, false );
	}
	if( isdefined( str_notify ) )
		level notify( str_notify );
	can_damage( ents, true );
}

function set_screen( off_tag, on_tag, is_enabled )
{
	hidden_screen = ( ( !is_enabled ) ? on_tag : off_tag );
	shown_screen = ( ( is_enabled ) ? on_tag : off_tag );
	
	self HidePart( hidden_screen );
	self ShowPart( shown_screen );
}

function can_damage( ents, bool )
{
    if( IsArray( ents ) )
	    for( i = 0; i < ents.size; i++ )
		    ents[ i ] SetCanDamage( bool );
    else
        ents SetCanDamage( bool );
}
