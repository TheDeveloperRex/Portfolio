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

// REX - Utility
#using scripts\zm\_rex_util;

// REX - Rat AI
#using scripts\zm\_rex_ai_rat;

// REX - Obamyyy AI
#using scripts\zm\_rex_ai_obamyyy;

#define WAIT_CENTI wait( 0.01 )

#precache( "xmodel", "tictactoe_x_highlight" );
#precache( "xmodel", "tictactoe_o_highlight" );
#precache( "xmodel", "tictactoe_x" );
#precache( "xmodel", "tictactoe_o" );

#namespace rex_manor_ee;

REGISTER_SYSTEM( "manor_ee", &__init__, undefined )

function __init__()
{
    trig = GetEnt( "rex_skullbreaker_trig", "targetname" );
	trig thread rat_spawn_logic();

    level thread manor_ee_init();
}

function manor_ee_init()
{
	level.obama = rex_obamyyy_ai::spawn_obamyyy();
    level.hank_ent = util::spawn_model( "tag_origin", ( 0, 0, 0 ) );
    level.hank_ent.tictactoe_weights = array(
        array( "simple_move", 0 ),
        array( "standard_move", 100 ),
        array( "smart_move", 0 )
    );
	level.morgan_ent = util::spawn_model( "tag_origin", ( 0, 0, 0 ) );
    level.morgan_ent.interaction = false;

    // STEP 1 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
        level.obama_prism = GetEnt( "obama_prism", "targetname" );
        panel = GetEnt( "can_prompt", "targetname" );
        med_machine = GetEnt( "med_machine", "targetname" );
        med_machine.cans = GetEntArray( "med_can", "targetname" );

        med_machine.med_total = 3;
        med_machine thread manor_step_1( panel );

        array::run_all( med_machine.cans, &Hide );
    // ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    
    // STEP 2 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
        level thread manor_step_2();
    // ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

    level thread tictactoe_init();
}

function med_visibility_and_update_prompt( player )
{
    can_use = self med_visibility_unitrigger( player );
    if( isdefined( self.hint_string ) )
        self SetHintString( self.hint_string );
    return can_use;
}

function med_visibility_unitrigger( player )
{
    if( !rex_util::is_valid( player ) )
    {
        self.hint_string = "";
        return false;
    }
    if( level.morgan_ent.interaction )
    {
        self.hint_string = "";
        return false;
    }
    if( !player zm_score::can_player_purchase( self.stub.related_parent.zombie_cost ) )
    {
        self.hint_string = self.stub.hint_string + "\n^1[ YOU DO NOT HAVE ENOUGH ]";
        return false;
    }
    self.hint_string = self.stub.hint_string;
    return true;
}

function manor_step_1( panel )
{
	level waittill( "initial_blackscreen_passed" );

	level.morgan_ent PlaySoundWithNotify( "morgan_intro", "sounddone" );

	level.morgan_ent waittill( "sounddone" );

	level.obama thread rex_obamyyy_ai::StartInteraction( "rex_ai_obama_intro", "begin_step_1", "rex_ai_obama_intro_r", "cancel_prompt" );
    level.obama waittill( "begin_step_1" );

    self rex_util::create_unitrigger( "Hold ^3[{+activate}]^7 to purchase a Monser Energy [Cost: " + self.zombie_cost + "]", undefined, 72, &med_visibility_and_update_prompt );

	for( i = 1; i <= self.med_total; i++ )
	{
        while( 1 )
        {
            self waittill( "trigger_activated", player );

            if( player zm_score::can_player_purchase( self.zombie_cost ) )
            {
                player zm_score::minus_to_player_score( self.zombie_cost );
                player PlaySound( "zmb_cha_ching" );

                level.morgan_ent PlaySoundWithNotify( "morgan_med_" + i, "sounddone" );

                level.morgan_ent.interaction = true;
                level.morgan_ent waittill( "sounddone" );
                level.morgan_ent.interaction = false;
                break;
            }
        }
	}
    zm_unitrigger::unregister_unitrigger( self.s_unitrigger );
    level.obama.prompt notify( "cancel_prompt" );

    panel rex_util::create_unitrigger( "Hold ^3[{+activate}]^7 to insert Monster Energy", undefined, 64 ); 
    panel waittill( "trigger_activated", player );

    zm_unitrigger::unregister_unitrigger( panel.s_unitrigger );

    array::run_all( self.cans, &Show );

    level flag::set( "power_on" );

    level.obama_prism thread levitate( 16, 1 );
    level.obama_prism thread spin( 360, 2.5 );

    level notify( "initiate_step_2" );
}

function manor_step_2()
{
    level waittill( "initiate_step_2" );

    level.obama thread rex_obamyyy_ai::StartInteraction( "rex_ai_obama_airdrop", "begin_step_2", "rex_ai_obama_airdrop_r", "cancel_prompt" );
    level.obama waittill( "begin_step_2" );
}

function rat_spawn_logic()
{
	self SetHintString( "Hold ^3[{+activate}]^7 to spawn AI" );
	self SetCursorHint( "HINT_NOICON" );

	while( 1 )
	{
		self waittill( "trigger", player );

		rex_rat_ai::spawn_rat();
	}
}

function levitate( point, time )
{
    if( time < 0.1 )   
        time = 0.1;
    while( isdefined( self ) )
    {
        self MoveZ( point, time );
            wait( time );
        self MoveZ( -point, time );
            wait( time );
    }
}

function spin( angle, time )
{
    while( isdefined( self ) )
    {
        self RotateYaw( angle, time );
            wait( time );
    }
}

function tictactoe_init()
{
    level waittill( "initial_blackscreen_passed" );

    level.ttt = GetEnt( "tictactoe_interface", "targetname" );
    level.ttt.spots = struct::get_array( "tictactoe_spot", "targetname" );
    level.ttt.current_turn = undefined;
    level.ttt.opponent = undefined;
    level.ttt.is_completed = false;
    level.ttt.ai = level.hank_ent;
    level.ttt.win_combos = [];
    level.ttt.ents = [];
    directions = 4;

    for( i = 1; i <= directions; i++ )
    {
        combos = ( ( i % 2 == 0 ) ? 1 : 3 );
        for( j = 0; j < combos; j++ )
        {	
            c_combo = [];
            for( k = 0; k < 3; k++ )
            {
                matrix = ( ( i == 2 ) ? k + 1 : k );
                increment = ( ( i % 3 == 0 ) ? 1 : 3 );
                c_combo[ c_combo.size ] = ( ( matrix * i ) + ( increment * j ) );
            }
            level.ttt.win_combos[ level.ttt.win_combos.size ] = c_combo;
            IPrintLnBold( c_combo[ 0 ] + " " + c_combo[ 1 ] + " " + c_combo[ 2 ] );
        }
    }

    level.ttt.win_combos = array(
        array( 0, 1, 2 ),
        array( 3, 4, 5 ),
        array( 6, 7, 8 ),
        array( 0, 4, 8 ),
        array( 6, 4, 2 ),
        array( 2, 5, 8 ),
        array( 1, 4, 7 ),
        array( 0, 3, 6 )
    );
    level.ttt thread tictactoe_watch_hover();
    level.ttt thread tictactoe_logic();
}

function tictactoe_setup( index )
{
    self.claimed_team = undefined;
    self.is_hovered = false;
    self.is_claimed = false;
    self.index = index;
}

function tictactoe_logic()
{
    while( !self.is_completed )
    {
        array::thread_all( self.spots, &tictactoe_setup );
        array::run_all( self.ents, &Delete );
        self.ents = [];

        self rex_util::create_unitrigger( "Hold ^3[{+activate}]^7 to play Tic-Tac-Toe", undefined, 64 );
        self waittill( "trigger_activated", player );

        zm_unitrigger::unregister_unitrigger( self.s_unitrigger );

        while( player UseButtonPressed() )
            WAIT_SERVER_FRAME;

        self.opponent = player;
        self.current_turn = player;
        self.opponent.last_hovered = undefined;

        level.ttt util::waittill_any( "tictactoe_completed", "tictactoe_failed", "tictactoe_tied" );
    }
}

function tictactoe_watch_hover()
{
    while( !self.is_completed )
    {
        WAIT_SERVER_FRAME;

        if( isdefined( self.opponent ) )
        {
            if( self.current_turn == self.opponent )
            {
                for( i = 0; i < self.spots.size; i++ )
                {
                    if( Distance( self.opponent.origin, self.origin ) <= 128 )
                    {
                        if( self.opponent zm_utility::is_player_looking_at( self.spots[ i ].origin + ( 0, 0, 15 ), 0.99 ) )
                        {
                            if( !self.spots[ i ].is_claimed )
                            {
                                if( !isdefined( self.opponent.ent ) )
                                {
                                    self.opponent.ent = util::spawn_model( "tictactoe_x_highlight", self.spots[ i ].origin );
                                    self thread tictactoe_handle_hover();
                                }
                                self.opponent.ent [[( ( Distance( self.opponent.origin, self.origin ) <= 128 ) ? &Show : &Hide )]]();
                                self.opponent.ent.origin = self.spots[ i ].origin;
                                self.opponent.last_hovered = self.spots[ i ];
                            }
                        }
                    }
                }
            }
        }
    }
}

function tictactoe_handle_hover()
{
    while( isdefined( self.opponent.ent ) )
    {
        WAIT_SERVER_FRAME;

        if( isdefined( self.opponent.last_hovered ) )
        {
            if( Distance( self.opponent.origin, self.origin ) <= 128 )
            {
                if( self.opponent UseButtonPressed() )
                {
                    self thread tictactoe_turn( self.opponent.last_hovered, self.opponent );
                    if( !( self tictactoe_check_win( self.spots, self.opponent ) || self tictactoe_check_tie( self.spots ) ) )
                        self thread tictactoe_handle_ai();
                }
            }
        }
    }
}

function tictactoe_handle_ai()
{
    wait( 2.5 );

    switch( get_chance( self.ai.tictactoe_weights )[ 0 ] )
    {
        case "smart_move":
        {
            IPrintLnBold( "ADVANCED MOVEMENT" );
            //selected_spot = self tictactoe_predict_spot();
            //self tictactoe_turn( selected_spot, self.ai );
            //self.ents[ self.ents.size ] = util::spawn_model( "tictactoe_o", selected_spot.origin );
            break;
        }
        case "standard_move":
        {
            WAIT_CENTI;

            IPrintLnBold( "STANDARD MOVEMENT" );
            selected_spot = undefined;
            current_combo = [];
            for( i = 0; i < self.win_combos.size; j++ )
            {
                current_combo = [];
                for( j = 0; j < self.win_combos[ i ].size; j++ )
                    if( self.spots[ self.win_combos[ i ][ j ] ].claimed_team === self.opponent )
                        current_combo[ current_combo.size ] = self.spots[ self.win_combos[ i ][ j ] ];
                IPrintLnBold( current_combo.size );
                if( current_combo.size == 2 )
                {
                    IPrintLnBold( "DUAL PLAYER PATTERN FOUND" );
                    
                    for( k = 0; k < self.win_combos[ i ].size; k++ ) {
                        if( !array::contains( current_combo, self.spots[ self.win_combos[ i ][ k ] ] ) )
                        {
                            selected_spot = self.spots[ self.win_combos[ i ][ k ] ];
                            self thread tictactoe_turn( selected_spot, self.ai );
                            self.ents[ self.ents.size ] = util::spawn_model( "tictactoe_o", selected_spot.origin );
                            break;
                        }
                    }
                    break;
                }
            }
            if( !isdefined( selected_spot ) )
            {
                spots = array::randomize( self.spots );
                for( i = 0; i < spots.size; i++ )
                {
                    if( spots[ i ].is_claimed )
                        continue;
                    self thread tictactoe_turn( spots[ i ], self.ai );
                    self.ents[ self.ents.size ] = util::spawn_model( "tictactoe_o", spots[ i ].origin );
                    break;
                }
            }
            break;
        }
        case "simple_move":
        {
            IPrintLnBold( "SIMPLE MOVEMENT" );
            spots = array::randomize( self.spots );
            for( i = 0; i < spots.size; i++ )
            {
                if( spots[ i ].is_claimed )
                    continue;
                self thread tictactoe_turn( spots[ i ], self.ai );
                self.ents[ self.ents.size ] = util::spawn_model( "tictactoe_o", spots[ i ].origin );
                break;
            }
            break;
        }
    }
}

function tictactoe_check_win( board, player )
{
    for( i = 0; i < self.win_combos.size; i++ ) {
        WAIT_CENTI;
		adjacent = 0;
		for( j = 0; j < self.win_combos[ i ].size; j++ )
			adjacent += ( ( board[ self.win_combos[ i ][ j ] ].claimed_team === player ) ? 1 : 0 );
		if( adjacent === 3 )
        {
            self.is_completed = ( ( player === self.opponent ) ? true : false );
            self notify( ( ( player === self.ai ) ? "tictactoe_failed" : "tictactoe_completed" ) );
            IPrintLnBold( ( ( player === self.ai ) ? "^1YOU LOST!" : "^2YOU WON!" ) );
            IPrintLnBold( adjacent + " " + ( ( player === self.opponent ) ? "PLAYER" : "AI" ) );
            return true;
        }
	}
	return false;
}

function tictactoe_check_tie( board ) {
	if( get_empty( board ).size === 0 ) {
		IPrintLnBold( "^3YOU TIED!" );
        self notify( "tictactoe_tied" );
		return true;
	}
	return false;
}


function tictactoe_predict_spot()
{
    best_score = -1000;
    best_move = undefined;
    newSpots = ArrayCopy( self.spots );
    for( i = 0; i < self.spots.size; i++ )
    {
        if( !isdefined( self.spots[ i ].claimed_team ) )
        {
            self.spots[ i ].claimed_team = self.opponent;
            if( self thread tictactoe_check_win( newSpots, self.opponent ) )
            {
				newSpots[ i ].claimed_team = undefined;
				return newSpots[ i ];
			}
            score = self minimax( newSpots, 0, true );
            newSpots[ i ].claimed_team = undefined;
            if( score > best_score )
            {
                best_score = score;
                best_move = i;
            }
        }
    }
    IPrintLnBold( best_move );
    newSpots[ best_move ].claimed_team = self.ai;
    return newSpots[ best_move ];
}

function minimax( board, depth, is_maximizing )
{
	if( self tictactoe_check_win( board, self.opponent ) )
		return depth - 100;
	else if ( self tictactoe_check_win( board, self.ai ) )
		return 100 - depth;
	else if ( self tictactoe_check_tie( board ) )
		return 0;

    best_score = ( ( is_maximizing ) ? -1000 : 1000 );
    best_move = undefined;

    for( i = 0; i < board.size; i++ )
    {
        WAIT_CENTI;
        if( !isdefined( board[ i ].claimed_team ) )
        {
            board[ i ].claimed_team = ( ( is_maximizing ) ? self.ai : self.opponent );
            score = self minimax( board, ( depth + 1 ), !is_maximizing );
            board[ i ].claimed_team = undefined;
            if( is_maximizing )
            {
                if( score > best_score )
                {
                    best_score = score;
                    best_move = i;
                }
            } 
            else 
            {
                if( score < best_score ) 
                {
                    best_score = score;
                    best_move = i;
                }
            }
        }
    }
    return best_score;
}

function tictactoe_turn( spot, player )
{
    if( player === self.opponent )
        player.ent SetModel( "tictactoe_x" );
    spot.claimed_team = player;
    spot.is_claimed = true;

    self.ents[ self.ents.size ] = player.ent;
    player.ent = undefined;
    

    if( !( self tictactoe_check_win( self.spots, player ).result && self tictactoe_check_tie( self.spots ) ) )
        self.current_turn = ( ( player === self.opponent ) ? self.ai : self.opponent );
}

function get_empty( board ) {
    e_spots = [];
    for( i = 0; i < board.size; i++ )
        if( !board[ i ].is_claimed )
            e_spots[ e_spots.size ] = board[ i ];
    return e_spots;
}

function get_chance( arr ) {
	pool = [];
	for( i = 0; i < arr.size; i++ )
		for( j = 0; j < arr[ i ][ 1 ]; j++ )
			pool[ pool.size ] = i;
	return arr[ array::randomize( pool )[ 0 ] ];
}

function tictactoe_win_event( winner )
{
    if( winner == self.opponent )
    {
        IPrintLnBold( "^2PLAYER WINS" );
        self notify( "tictactoe_completed" );
    }
    else
    {
        IPrintLnBold( "^6HANK WINS" );
        self notify( "tictactoe_failed" );
    }
}
