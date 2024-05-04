# Gut Quest - Programmed by Landon Hill

import tkinter as tk
import random
import glob
import config.source.AnimatedGIF as GIF
import json
import sys
import os, os.path

from tkinter import *
from tkinter import NW, END, CENTER, RIGHT, LEFT, FLAT
from PIL import Image
from tkcode import CodeBlock

global main, bg_list, roll_button, number, num_container

def resource_path( relative_path ):
    try:
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath( '.' )
    return os.path.join( base_path, relative_path )

bg_list = []
for menu_bg in glob.glob( resource_path( 'gifs/menu/*' ) ):
    bg = Image.open( menu_bg )
    bg_list.append( str( menu_bg ) )

player_list = [] 
for player, title in zip( glob.glob( resource_path( 'icons/game/player/*' ) ), [
    [ 'RED', '#FF2F00' ],
    [ 'GREEN', '#00EF17' ],
    [ 'BLUE', '#005DFF' ],
    [ 'PURPLE', '#AA33EA' ] ] ):
    bg = Image.open( player )
    player_list.append( [ str( player ), title ] )

unit_list = [
    {
        "path": resource_path( 'icons/game/easy_unit.png' ),
        "chance": 55,
        "type": 0
    },
    {
        "path": resource_path( 'icons/game/hard_unit.png' ),
        "chance": 30,
        "type": 1
    },
    {
        "path": resource_path( 'icons/game/life_unit.png' ),
        "chance": 15,
        "type": 2
    }
]

dataDir = os.path.join( os.path.expanduser('~/') + 'Documents/GutQuest' )

questions = json.load( open( resource_path( 'config/source/questionData.json' ) ) )[ 'questions' ]
mockData = json.load( open( resource_path( 'config/source/mockData.json' ) ) )[ 'mocks' ]
userData = json.load( open( resource_path( 'config/source/userData.json' ) if not os.path.exists( dataDir ) else ( dataDir + '/questionData.json' ) ) )[ 'data' ]

if not os.path.exists( dataDir ):
    os.makedirs( dataDir, mode=0o777, exist_ok=False )
    with open( ( dataDir + '/questionData.json' ), 'w', encoding='utf-8' ) as file:
        json.dump( { "data" : userData }, file, ensure_ascii=False, indent=4 )

def send_data( **kwargs ):
    with open( ( resource_path( 'config/source/userData.json' ) if not os.path.exists( dataDir ) else ( dataDir + '/questionData.json' ) ), 'w', encoding='utf-8' ) as file:
        userData[ 0 ][ 'wins' ] = kwargs[ 'wins' ] if 'wins' in kwargs else userData[ 0 ][ 'wins' ]
        userData[ 0 ][ 'losses' ] = kwargs[ 'losses' ] if 'losses' in kwargs else userData[ 0 ][ 'losses' ]
        userData[ 0 ][ 'correct' ] = kwargs[ 'correct' ] if 'correct' in kwargs else userData[ 0 ][ 'correct' ]
        userData[ 0 ][ 'incorrect' ] = kwargs[ 'incorrect' ] if 'incorrect' in kwargs else userData[ 0 ][ 'incorrect' ]
        try:
            userData[ 0 ][ 'wlr' ] = '{:.2f}'.format( float( userData[ 0 ][ 'wins' ] / ( userData[ 0 ][ 'losses' ] ) ) if userData[ 0 ][ 'losses' ] else userData[ 0 ][ 'wins' ] )
        except:
            userData[ 0 ][ 'wlr' ] = '{:.2f}'.format( 0 )
        try:
            userData[ 0 ][ 'accuracy' ] = '{:.2f}%'.format( float( ( userData[ 0 ][ 'correct' ] / ( userData[ 0 ][ 'correct' ] + userData[ 0 ][ 'incorrect' ] ) ) * 100 ) )
        except:
            userData[ 0 ][ 'accuracy' ] = '{:.2f}%'.format( 0 )
        json.dump( { "data" : userData }, file, ensure_ascii=False, indent=4 )
send_data()

def get_unit( array ):
    pool = {}
    for i, unit in enumerate( array ):
        for j in range( unit[ 'chance' ] ):
            pool[ len( pool ) ] = i
    return array[ random.choice( pool ) ]

class Window:
    def __init__( self, resizable, title, icon, scale, **kwargs ):
        self.contents = []
        self.current_pos = 0
        self.root = tk.Tk()
        self.root.geometry( scale )
        self.root.title( title )
        self.root.configure( kwargs, relief=FLAT )
        self.root.wm_attributes( '-topmost', False )
        self.root.resizable( resizable, resizable )
        self.root.iconbitmap( icon )
        
    def create_button( self, *args, **kwargs ):
        if self.root == None:
            return
        button = tk.Button( self.root, kwargs )
        if args:
            button.bind( "<Enter>", lambda event:args[ 0 ]( event, width=1, height=1 ) )
            button.bind( "<Leave>", lambda event:args[ 1 ]( event, width=1, height=1 ) )
        self.contents.append( button )
        return button
    
    def create_label( self, *args, **kwargs ):
        if self.root == None:
            return
        label = tk.Label( self.root, kwargs )
        self.contents.append( label )
        return label
        
    def destroyContent( self ):
        for elem in self.contents:
            elem.destroy()
        self.contents = []

    def close( self ):
        self.root.destroy()

main = Window( False, "ＧＵＴ ＱＵＥＳＴ", resource_path( 'icons/dw-logo.ico' ), "650x650+650-250" )

life_state = [
    tk.PhotoImage( file = resource_path( 'icons/game/life_active.png' ) ),
    tk.PhotoImage( file = resource_path( 'icons/game/life_inactive.png' ) )
]

def give_life( button ):
    button[ 'state' ] = 'normal'
    for life in main.lives:
        if not life.active:
            life[ 'image' ] = life_state[ 0 ]
            life.image = life_state[ 0 ]
            life.active = True
            return

def take_life():
    for life in reversed( main.lives ):
        if life.active:
            life[ 'image' ] = life_state[ 1 ]
            life.image = life_state[ 1 ]
            life.active = False
            return True
    return False
            
def check_win( is_decrement = False ):
    if not is_decrement:
        main.score.set( "{}/{}".format( main.current_score, main.total_score ) )
        if main.current_score < main.total_score:
            return False
        return True
    else:
        for life in reversed( main.lives ):
            if not life.active:
                continue
            else:
                return False
        return True
    
def create_board( canvas ):
    units = {}
    main.root.uImages = {}
    for i in range( 5 ):
        unit = get_unit( unit_list )
        main.root.uImages[ len( main.root.uImages ) ] = uImage = tk.PhotoImage( file = r'{}'.format( unit[ 'path' ] ) if i > 0 else r'{}'.format( resource_path( 'icons/game/easy_unit.png' ) ) )
        units[ len( units ) ] = [ canvas.create_image( ( ( 125 + ( 100 * i ) ), 100 ), anchor=CENTER, image=uImage ), ( ( 125 + ( 100 * i ) ), 100 ), unit[ 'type' ] ]
        if i + 1 == 5:
            for j in range( 3 ):
                unit = get_unit( unit_list )
                main.root.uImages[ len( main.root.uImages ) ] = uImage = tk.PhotoImage( file = r'{}'.format( unit[ 'path' ] ) )
                units[ len( units ) ] = [ canvas.create_image( ( 125 + ( 100 * i ), 100 + ( 100 * ( j + 1 ) ) ), anchor=CENTER, image=uImage ), ( 125 + ( 100 * i ), 100 + ( 100 * ( j + 1 ) ) ), unit[ 'type' ] ]
                if j + 1 == 3:
                    for k in range( 5 ):
                        unit = get_unit( unit_list )
                        main.root.uImages[ len( main.root.uImages ) ] = uImage = tk.PhotoImage( file = r'{}'.format( unit[ 'path' ] ) )
                        units[ len( units ) ] = [ canvas.create_image( ( ( 525 - ( 100 * k ) ), 500 ), anchor=CENTER, image=uImage ), ( ( 525 - ( 100 * k ) ), 500 ), unit[ 'type' ] ]
                        if k + 1 == 5:
                            for l in range( 3 ):
                                unit = get_unit( unit_list )
                                main.root.uImages[ len( main.root.uImages ) ] = uImage = tk.PhotoImage( file = r'{}'.format( unit[ 'path' ] ) )
                                units[ len( units ) ] = [ canvas.create_image( ( 125, 500 - ( 100 * ( l + 1 ) ) ), anchor=CENTER, image=uImage ), ( 125, 500 - ( 100 * ( l + 1 ) ) ), unit[ 'type' ] ]
    return units

def create_prompt( button, game_container, board, q_total = 1 ):
    def choice_callback( event, button, game_container, board, q_total, choices ):
        def highlight_choices( event, choices ):
            for choice in choices:
                if choice.info[ 2 ] == event.widget.info[ 0 ][ 2 ]:
                    choice.configure( activebackground='#77C94B', activeforeground='#347510', disabledforeground='#347510' )
                    choice[ 'bg' ] = '#77C94B'
                else:
                    choice.configure( activebackground='#C94B4B', activeforeground='#821111', disabledforeground='#821111' )
                    choice[ 'bg' ] = '#C94B4B'
                choice[ 'state' ] = 'disabled'
        def handle_notif( is_correct ):
            if is_correct:
                send_data( correct=( userData[ 0 ][ 'correct' ] + 1 ) )
                notif_label[ 'fg' ] = '#77C94B'
                notif.set( "CORRECT" )
            else:
                send_data( incorrect=( userData[ 0 ][ 'incorrect' ] + 1 ) )
                notif_label[ 'fg' ] = '#C94B4B'
                notif.set( "INCORRECT" )
        if event.widget[ 'state' ] == 'disabled':
                return
        if event.widget.info[ 2 ] == event.widget.info[ 0 ][ 2 ]:
            main.q_correct += 1
            
            count.set( '{}/{}'.format( main.q_correct, q_total ) if main.q_correct <= q_total else count.get() )

            if main.q_correct < q_total:
                main.root.after( 1500, create_choices, button, random.choice( questions ), game_container, board, q_total, choices )
            else:
                if main.current_score < main.total_score:
                    main.current_score += 1
                if check_win():
                    for elem in prompt.contents:
                        elem.destroy()
                    for choice in choices:
                        choice.destroy()
                    choices = []

                    send_data( wins=( userData[ 0 ][ 'wins' ] + 1 ) )
                    prompt[ 'bg' ] = '#77C94B'
                    notif_label[ 'bg' ] = '#77C94B'
                    notif_label[ 'fg' ] = '#FFFFFF'
                    notif.set( "YOU WIN!" )

                    main.root.after( 3000, prompt.destroy )
                    main.root.after( 3000, create_menu )
                else:
                    main.root.after( 1500, prompt.destroy )
            if choices != []:
                handle_notif( 1 )
        else:
            if take_life():	
                if check_win( True ):
                    for elem in prompt.contents:
                        elem.destroy()
                    for choice in choices:
                        choice.destroy()
                    choices = []

                    send_data( losses=( userData[ 0 ][ 'losses' ] + 1 ) )
                    prompt[ 'bg' ] = '#C94B4B'
                    notif_label[ 'bg' ] = '#C94B4B'
                    notif_label[ 'fg' ] = 'white'
                    notif.set( "YOU LOSE!" )

                    main.root.after( 3000, prompt.destroy )
                    main.root.after( 3000, create_menu )
                else:
                    main.root.after( 1500, prompt.destroy )
            if choices != []:
                handle_notif( 0 )
        if choices != []:
            highlight_choices( event, choices )
        
    def create_choices( button, curr_question, game_container, board, q_total, choices = [] ):
        column = 0
        if choices != []:
            for choice in choices:
                choice.destroy()
            choices = []
        question.set( curr_question[ 0 ] )
        notif.set( "" )
        
        for i, choice in enumerate( curr_question[ 1 ] ):
            answer = tk.Button( prompt, bg='#5F66D4', fg='white', text=choice, width=36, height=6, wraplength=200 )
            answer.place( relx=( 0.065 + ( 0.45 * column ) ), rely=( 0.5895 + ( 0.1875 * ( ( i + 1 ) % 2 == 0 ) ) ) )
            answer.bind( '<ButtonRelease-1>', lambda event:choice_callback( event, button, game_container, board, q_total, choices ) )
            answer.info = [ curr_question, choice, i ]
            column += 1 if i % 2 != 0 else 0
            choices.append( answer )
        return choices
    
    main.q_correct = 0

    prompt = tk.Canvas( main.root, width=600, height=600, borderwidth=5, border=5, bg='#1B1E4F' )
    prompt.place( relx=0.5, rely=0.5, anchor=CENTER )
    prompt.contents = []
    
    current_question = random.choice( questions )

    question_container = tk.Canvas( prompt, width=534, height=250, bg='#5F66D4' )
    question_container.place( relx=0.5, rely=0.275, anchor=CENTER )
    prompt.contents.append( question_container )
    
    question = tk.StringVar()
    question_label = tk.Label( question_container, textvariable=question, font=( 'Helvetica', 16, 'bold' ), bg='#5F66D4', fg='white', wraplength=450 )
    question_label.place( relx=0.5, rely=0.5, anchor=CENTER )
    prompt.contents.append( question_label )
    question.set( current_question[ 0 ] )
    
    count = tk.StringVar()
    question_counter = tk.Label( question_container, textvariable=count, font=( 'Verdana', 20 ), bg='#5F66D4', fg='white' )
    question_counter.place( relx=0.05, rely=0.075, anchor=NW )
    prompt.contents.append( question_counter )
    count.set( '{}/{}'.format( main.q_correct, q_total ) )

    notif = tk.StringVar()
    notif_label = tk.Label( prompt, textvariable=notif, font=( 'Helvetica', 25, 'bold' ), bg='#1B1E4F', fg='white' )
    notif_label.place( relx=0.5, rely=0.535, anchor=CENTER )
    main.contents.append( notif_label )
    notif.set( "" )
    
    create_choices( button, current_question, game_container, board, q_total )

    button[ 'state' ] = 'normal'

def handle_action( button, game_container, board, char, val, c_val ):
    main.current_pos = ( ( main.current_pos + 1 ) ) if main.current_pos + 1 < len( board ) else 0

    game_container.moveto( char, board[ main.current_pos ][ 1 ][ 0 ] - 32, board[ main.current_pos ][ 1 ][ 1 ] - 32 )
    
    if ( c_val + 1 ) != val:
        main.root.after( 500, handle_action, button, game_container, board, char, val, ( ( c_val + 1 ) if main.current_pos < len( board ) else 0 ) )
    else:
        match( board[ main.current_pos ][ 2 ] ):
            case 0:
                main.root.after( 1500, create_prompt, button, game_container, board, 1 )
            case 1:
                main.root.after( 1500, create_prompt, button, game_container, board, 3 )
            case 2:
                main.root.after( 500, give_life, button )

def diceroll( button, game_container, board, char, number = None, num_container = None ):
    def destroy_num( number, num_container ):
        num_container.destroy()
        num_container = None
        number.destroy()
        number = None
        
    if button[ 'state' ] == 'normal' or button[ 'state' ] == 'active':
        val = random.randint( 1, 9 )
        num_container = tk.Canvas( game_container )
        num_container.place( relx=0.5, rely=0.46, anchor=CENTER )
        num_container.configure( bg='red',  width=300, height=300  )
        
        number = GIF.AnimatedGif( num_container, resource_path( 'gifs/game/num_' + str( val ) + '.gif' ) )
        number.place( relx=0, rely=0, anchor=NW )
        number.configure( color=None, bg='#083663', width=300, height=300 )
        number.start()

        button[ 'state' ] = 'disabled'

        main.root.after( 1250, destroy_num, number, num_container )
        main.root.after( 1350, handle_action, button, game_container, board, char, val, 0 )

def character_select( char_container=None ):
    def destroy_select( event ):
        if event.widget.is_hovered:
            for elem in main.contents:
                elem.destroy()
            create_menu()

    def char_hover( event, **kwargs ):
        if 'hovered' in kwargs:
            event.widget.is_hovered = kwargs[ 'hovered' ]
        if 'color' in kwargs:
            event.widget[ 'bg' ] = kwargs[ 'color' ]
        if hasattr( event.widget, 'name' ):
            char_title[ 'fg' ] = event.widget.name[ 1 ][ 1 ]
            char_name.set( event.widget.name[ 1 ][ 0 ] )
    
    char_container = tk.Canvas( main.root, bg='#1F619C' )
    char_container.place( relx=0.5, rely=0.5, width=650, height=650, anchor=CENTER )
    main.contents.append( char_container )

    char_exit = tk.Label( char_container, text='✕', font=( 'Helvetica', 20, 'bold' ), bg='#8C261F', fg='white', highlightcolor='white', highlightthickness=2 )
    char_exit.place( relx=0.95, rely=0.05, anchor=CENTER, relheight=( 32 / 650 ), relwidth=( 32 / 650 ) )
    char_exit.bind( '<Enter>', lambda event:char_hover( event, hovered=True, color='#F04343' ) )
    char_exit.bind( '<Leave>', lambda event:char_hover( event, hovered=False, color='#8C261F' ) )
    char_exit.bind( '<ButtonRelease-1>', destroy_select )
    main.contents.append( char_exit )

    char_name = tk.StringVar()
    char_title = tk.Label( char_container, textvariable=char_name, bg='#1F619C', font=( 'Helvetica', 30, 'bold' ) )
    char_title.place( relx=0.5, rely=0.25, anchor=CENTER )
    main.contents.append( char_title )
    chars = []
    for i, player in enumerate( player_list ):
        image = tk.PhotoImage( file = player[ 0 ] )
        char = tk.Button( char_container, image=image, bg='#3495EB', color=None, borderwidth=2, activebackground='#47A8FF', highlightthickness=2 )
        char.place( relx=( 0.15 + ( 0.235 * i ) ), rely=0.5, anchor=CENTER )
        char.name = player
        char.image = image
        char.bind( "<Enter>", lambda event:char_hover( event, hovered=True, color='#4FA8F7' ) )
        char.bind( "<Leave>", lambda event:char_hover( event, hovered=True, color='#3495EB' ) )
        char.bind( "<Button-1>", create_game )
        main.contents.append( char )
        chars.append( char )

def create_game( event ):
    main.destroyContent()

    global game_container
    game_container = tk.Canvas(main.root, bg='#083663', color=None, width=646, height=646 )
    game_container.place( x=0, y=0, anchor=NW )
    main.contents.append( game_container )
    
    board = create_board( game_container )

    main.current_pos = 0
    main.current_score = 0
    main.total_score = 20
    main.root.character = character = tk.PhotoImage( file = r'{}'.format( event.widget.name[ 0 ] ) ).subsample( 2, 2 )
    char = game_container.create_image( ( 125, 100 ), anchor=CENTER, image=character )
    
    roll_button = main.create_button( bg='#3495EB', fg='white', width=12, height=1, text="ROLL", font=( 'Helvetica', 20, 'bold' ) )
    roll_button.place( relx=( 0.5 / 1 ), rely=( 0.915 ), anchor=CENTER )
    roll_button.configure( command=lambda:diceroll( roll_button, game_container, board, char ) )

    main.score = tk.StringVar()
    score_label = tk.Label( game_container, bg='#083663', fg='#6AA7E6', textvariable=main.score, font=( 'Helvetica', 32, 'bold' ) )
    score_label.place( relx=0.5, rely=0.45, anchor=CENTER )
    main.score.set( "{}/{}".format( main.current_score, main.total_score ) )

    main.lives = []
    for i in range( 3 ):
        life = tk.Label( game_container, width=40, height=40, bg='#083663', color=None, image=life_state[ 0 ] )
        life.place( relx=0.4 + ( 0.1 * i ), rely=0.045, anchor=CENTER )
        life.image = life_state[ 0 ]
        life.active = True
        main.lives.append( life )
    
def create_menu():
    def show_stats( event ):
        if event.widget.is_hovered:
            def destroy_stats( event ):
                if event.widget.is_hovered:
                    if event.widget[ 'state' ] == 'disabled':
                        return
                    for elem in stat_container.contents:
                        elem.destroy()
                    stat_container.destroy()

            def show_reset( event ):
                if event.widget.is_hovered:
                    if event.widget[ 'state' ] == 'disabled':
                        return
                    def destroy_reset():
                        stat_reset[ 'state' ] = 'normal'
                        stat_exit[ 'state' ] = 'normal'
                        for elem in reset_container.contents:
                            elem.destroy()
                        reset_container.destroy()

                    def get_mock():
                        mock = str( random.choice( mockData ) )
                        if mock.find( 'accuracy' ) != -1:
                            if float( str( userData[ 0 ][ 'accuracy' ] ).replace( '%', '' ) ) >= 75:
                                return get_mock()
                            else:
                                return mock_val.set( mock.format( str( userData[ 0 ][ 'accuracy' ] ) ) )
                        if mock.find( 'win/loss ratio' ) != -1:
                            if float( userData[ 0 ][ 'wlr' ] ) >= 0.75:
                                return get_mock()
                            else:
                                return mock_val.set( mock.format( userData[ 0 ][ 'wlr' ] ) )
                        return mock_val.set( mock )
                        
                    def reset_stats( event, is_reset ):
                        if event.widget.is_hovered:
                            if is_reset:
                                send_data( wins=0, losses=0, correct=0, incorrect=0 )
                                for i, ( s_val, val ) in enumerate( zip( a_stats, userData[ 0 ] ) ):
                                    s_val.set( '{}	{}'.format( userData[ 1 ][ i ], userData[ 0 ][ val ] ) )
                            destroy_reset()

                    def reset_hover( event, **kwargs ):
                        if 'hovered' in kwargs:
                            event.widget.is_hovered = kwargs[ 'hovered' ]

                    stat_reset[ 'bg' ] = '#8C261F'
                    stat_exit[ 'bg' ] = '#8C261F'
                    stat_reset[ 'state' ] = 'disabled'
                    stat_exit[ 'state' ] = 'disabled'
                    
                    reset_container = tk.Canvas( stat_container, width=350, height=175, borderwidth=8, highlightbackground='#92B6D1', bg='#42637A' )
                    reset_container.place( relx=0.5, rely=0.5, anchor=CENTER )
                    reset_container.contents = []

                    reset_backing = tk.Canvas( reset_container, width=330, height=100, borderwidth=8, highlightbackground='#92B6D1', bg='#4A4A4A' )
                    reset_backing.place( relx=0.5, rely=0.35, anchor=CENTER )
                    reset_container.contents.append( reset_backing )

                    mock_val = tk.StringVar()
                    reset_mock = tk.Label( reset_backing, textvariable=mock_val, font=( 'Helvetica', 13 ), bg='#4A4A4A', fg='white', wraplength=325 )
                    reset_mock.place( relx=0.5, rely=0.5, anchor=CENTER )
                    get_mock()
                    
                    reset_yes = tk.Button( reset_container, font=( 'Helvetica', 16, 'bold' ), text='YES', bg='#77C94B', fg='white', activebackground='#ADF288', activeforeground='white' )
                    reset_yes.place( relx=0.7375, rely=0.825, relwidth=( 80 / 175 ), relheight=( 75 / 350 ), anchor=CENTER )
                    reset_yes.bind( '<ButtonRelease-1>', lambda event:reset_stats( event, 1 ) )
                    reset_yes.bind( '<Enter>', lambda event:reset_hover( event, hovered=True ) )
                    reset_yes.bind( '<Leave>', lambda event:reset_hover( event, hovered=False ) )
                    reset_container.contents.append( reset_yes )

                    reset_no = tk.Button( reset_container, font=( 'Helvetica', 16, 'bold' ), text='NO', bg='#C94B4B', fg='white', activebackground='#F27272', activeforeground='white' )
                    reset_no.place( relx=0.2625, rely=0.825, relwidth=( 80 / 175 ), relheight=( 75 / 350 ), anchor=CENTER )
                    reset_no.bind( '<ButtonRelease-1>', lambda event:reset_stats( event, 0 ) )
                    reset_no.bind( '<Enter>', lambda event:reset_hover( event, hovered=True ) )
                    reset_no.bind( '<Leave>', lambda event:reset_hover( event, hovered=False ) )
                    reset_container.contents.append( reset_no )

            def stat_hover( event, **kwargs ):
                if event.widget[ 'state' ] == 'disabled':
                    return
                if 'hovered' in kwargs:
                    event.widget.is_hovered = kwargs[ 'hovered' ]
                if 'color' in kwargs:
                    event.widget[ 'bg' ] = kwargs[ 'color' ]

            stat_container = tk.Canvas( main.root, width=600, height=600, borderwidth=5, border=5, bg='#1B1E4F' )
            stat_container.place( relx=0.5, rely=0.5, anchor=CENTER )
            stat_container.contents = []
            
            stat_title = tk.Label( stat_container, text='STATS', font=( 'Helvetica', 28, 'bold' ), bg='#1B1E4F', fg='#255EBA' )
            stat_title.place( relx=0.5, rely=0.1, anchor=CENTER )
            stat_container.contents.append( stat_title )

            stat_exit = tk.Label( stat_container, text='✕', font=( 'Helvetica', 20, 'bold' ), bg='#8C261F', fg='white', highlightcolor='white', highlightthickness=2 )
            stat_exit.place( relx=0.95, rely=0.05, anchor=CENTER, relheight=( 32 / 650 ), relwidth=( 32 / 650 ) )
            stat_exit.bind( '<Enter>', lambda event:stat_hover( event, hovered=True, color='#F04343' ) )
            stat_exit.bind( '<Leave>', lambda event:stat_hover( event, hovered=False, color='#8C261F' ) )
            stat_exit.bind( '<ButtonRelease-1>', destroy_stats )
            stat_container.contents.append( stat_exit )

            stat_reset = tk.Label( stat_container, width=6, height=1, text='RESET', font=( 'Helvetica', 24, 'bold' ), bg='#8C261F', fg='white', highlightcolor='#CF4D44', highlightthickness=1 )
            stat_reset.place( relx=0.5, rely=0.875, anchor=CENTER )
            stat_reset.bind( '<Enter>', lambda event:stat_hover( event, hovered=True, color='#F04343' ) )
            stat_reset.bind( '<Leave>', lambda event:stat_hover( event, hovered=False, color='#8C261F' ) )
            stat_reset.bind( '<ButtonRelease-1>', show_reset )
            stat_container.contents.append( stat_reset )

            a_stats = []
            for i, ( val, title ) in enumerate( zip( userData[ 0 ], userData[ 1 ] ) ):
                stat = tk.StringVar()
                stat.set( '{}	{}'.format( title, userData[ 0 ][ val ] ) )
                stat_label = tk.Label( stat_container, textvariable=stat, font=( 'Helvetica', 16, 'bold' ), bg='#1B1E4F', fg='white' )
                stat_label.place( relx=0.225, rely=( 0.225 + ( 0.1 * i ) ) )
                stat_container.contents.append( stat_label )
                a_stats.append( stat )
        
    def show_info( event ):
        if event.widget.is_hovered:
            def destroy_info( event ):
                if event.widget.is_hovered:
                    if event.widget[ 'state' ] == 'disabled':
                        return
                    for elem in info_container.contents:
                        elem.destroy()
                    info_container.destroy()

            def show_source( event ):
                def destroy_codeblock( event ):
                    if event.widget.is_hovered:
                        if event.widget[ 'state' ] == 'disabled':
                            return
                        for elem in codeblock_container.contents:
                            elem.destroy()
                        codeblock_container.destroy()

                with open( resource_path( 'config/source/source.py' ) ) as file:
                    data = file.read()

                codeblock_container = tk.Frame( info_container, width=500, height=500, bg='#6F82A8' )
                codeblock_container.place( relx=0.5, rely=0.5, anchor=CENTER )
                codeblock_container.contents = []

                codeblock = CodeBlock( codeblock_container, width=84, height=45, font=( 'Verdana', 8 ), autofocus=True )
                codeblock.pack( expand=True, padx=2, pady=2 )
                codeblock_container.contents.append( codeblock )
                codeblock.content = data

                codeblock_exit = tk.Label( codeblock_container, text='✕', font=( 'Helvetica', 20, 'bold' ), bg='#8C261F', fg='white', highlightcolor='white', highlightthickness=2 )
                codeblock_exit.place( relx=0.95, rely=0.05, anchor=CENTER, relheight=( 32 / 650 ), relwidth=( 32 / 650 ) )
                codeblock_exit.bind( '<Enter>', lambda event:info_hover( event, hovered=True, color='#F04343' ) )
                codeblock_exit.bind( '<Leave>', lambda event:info_hover( event, hovered=False, color='#8C261F' ) )
                codeblock_exit.bind( '<ButtonRelease-1>', destroy_codeblock )
                codeblock_container.contents.append( codeblock_exit )

            def info_hover( event, **kwargs ):
                if event.widget[ 'state' ] == 'disabled':
                    return
                if 'hovered' in kwargs:
                    event.widget.is_hovered = kwargs[ 'hovered' ]
                if 'color' in kwargs:
                    event.widget[ 'bg' ] = kwargs[ 'color' ]

            info_container = tk.Canvas( main.root, width=600, height=600, borderwidth=5, border=5, bg='#1B1E4F' )
            info_container.place( relx=0.5, rely=0.5, anchor=CENTER )
            info_container.contents = []
            
            info_title = tk.Label( info_container, text='INFO', font=( 'Helvetica', 28, 'bold' ), bg='#1B1E4F', fg='#255EBA' )
            info_title.place( relx=0.5, rely=0.1, anchor=CENTER )
            info_container.contents.append( info_title )

            info_text = tk.Label( 
                info_container, 
                text="Gut Quest, a Digestive Sytem review game\n\nProgrammed by Landon Hill using Python\n\n750+ total lines of user interface code\n\nCreated and packaged within 7 days\n\nUtilized custom utilities and libraries\n\nMr. Tignor is a top-tier teacher",
                font=( 'Helvetica', 15 ), 
                bg='#1B1E4F', 
                fg='#878FA1' 
            )
            info_text.place( relx=0.5, rely=0.475, anchor=CENTER )
            info_container.contents.append( info_text )

            info_exit = tk.Label( info_container, text='✕', font=( 'Helvetica', 20, 'bold' ), bg='#8C261F', fg='white', highlightcolor='white', highlightthickness=2 )
            info_exit.place( relx=0.95, rely=0.05, anchor=CENTER, relheight=( 32 / 650 ), relwidth=( 32 / 650 ) )
            info_exit.bind( '<Enter>', lambda event:info_hover( event, hovered=True, color='#F04343' ) )
            info_exit.bind( '<Leave>', lambda event:info_hover( event, hovered=False, color='#8C261F' ) )
            info_exit.bind( '<ButtonRelease-1>', destroy_info )
            info_container.contents.append( info_exit )

            info_source = tk.Label( info_container, width=13, height=1, text='SHOW SOURCE', font=( 'Helvetica', 24, 'bold' ), bg='#53DB53', fg='white', highlightcolor='#CF4D44', highlightthickness=1 )
            info_source.place( relx=0.5, rely=0.875, anchor=CENTER )
            info_source.bind( '<Enter>', lambda event:info_hover( event, hovered=True, color='#3E8A3E' ) )
            info_source.bind( '<Leave>', lambda event:info_hover( event, hovered=False, color='#53DB53' ) )
            info_source.bind( '<ButtonRelease-1>', show_source )
            info_container.contents.append( info_source )
            
    def menu_enter( event, **kwargs ):
        if 'hovered' in kwargs:
            event.widget.is_hovered = kwargs[ 'hovered' ]
        if 'width' in kwargs:
            event.widget[ 'width' ] = kwargs[ 'width' ]
        if 'height' in kwargs:
            event.widget[ 'height' ] = kwargs[ 'height' ]
    
    def menu_leave( event, **kwargs ):
        if 'hovered' in kwargs:
            event.widget.is_hovered = kwargs[ 'hovered' ]
        if 'width' in kwargs:
            event.widget[ 'width' ] = kwargs[ 'width' ]
        if 'height' in kwargs:
            event.widget[ 'height' ] = kwargs[ 'height' ]

    background = GIF.AnimatedGif( main.root, random.choice( bg_list ), delay=0.02 )
    background.configure( color=None, activebackground=None, bg=None, width=650, height=650 )
    background.place( relx=0.5, rely=0.5, anchor=CENTER )
    background.start()

    main.contents.append( background )

    start_button = main.create_button( bg='#3495EB', fg='#104E85', width=15, height=1, text="START", font=( 'Helvetica', 15, 'bold' ), command=character_select )
    start_button.bind( '<Enter>', lambda event:menu_enter( event, hovered=True, width=16, height=2 ) )
    start_button.bind( '<Leave>', lambda event:menu_leave( event, hovered=False, width=15, height=1 ) )
    start_button.place( relx=0.5, rely=0.55, anchor=CENTER )

    quit_button = main.create_button( bg='#D61515', fg='#660B0B', width=15, height=1, text="QUIT", font=( 'Helvetica', 15, 'bold' ), command=main.close )
    quit_button.bind( '<Enter>', lambda event:menu_enter( event, hovered=True, width=16, height=2 ) )
    quit_button.bind( '<Leave>', lambda event:menu_leave( event, hovered=False, width=15, height=1 ) )
    quit_button.place( relx=0.5, rely=0.65, anchor=CENTER )
    
    stat_icon = tk.PhotoImage( file = resource_path( 'icons/misc/stats.png' ) ).subsample( 2, 2 )
    stat_button = main.create_button( width=50, height=50, bg='#5076B3', activebackground='#709DE6', border=2, image=stat_icon )
    stat_button.bind( '<Enter>', lambda event:menu_enter( event, hovered=True, width=55, height=55 ) )
    stat_button.bind( '<Leave>', lambda event:menu_leave( event, hovered=False, width=50, height=50 ) )
    stat_button.bind( '<ButtonRelease-1>', show_stats )
    stat_button.place( relx=0.9, rely=0.9, anchor=CENTER )
    stat_button.image = stat_icon

    info_icon = tk.PhotoImage( file = resource_path( 'icons/misc/info.png' ) ).subsample( 2, 2 )
    info_button = main.create_button( width=50, height=50, bg='#5076B3', activebackground='#709DE6', border=2, image=info_icon )
    info_button.bind( '<Enter>', lambda event:menu_enter( event, hovered=True, width=55, height=55 ) )
    info_button.bind( '<Leave>', lambda event:menu_leave( event, hovered=False, width=50, height=50 ) )
    info_button.bind( '<ButtonRelease-1>', show_info )
    info_button.place( relx=0.1, rely=0.9, anchor=CENTER )
    info_button.image = info_icon

if __name__ == "__main__":
    create_menu()
    
main.root.mainloop()