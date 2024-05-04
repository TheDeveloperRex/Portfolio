require( "ui.uieditor.menus.REX.MusicSelector.MusicSelector_ListItem" )

local PreLoadFunc = function( self, controller )
    self.disableBlur = true
    self.disablePopupOpenCloseAnim = true
    self.disableDarkenElement = true
end

local PostLoadFunc = function( self, controller )
    Engine.LockInput( controller, true )
    Engine.SetUIActive( controller, true )

    self:setForceMouseEventDispatch( true )
end

DataSources.MusicList = DataSourceHelpers.ListSetup( "MusicList", function( controller )    
    local dataTable = {
        {
            models = {
                title = "TEST TITLE 1",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 2",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 3",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 4",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 5",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 6",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 7",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 8",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 9",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 10",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 11",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 12",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 13",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 14",
                alias = "test_song_alias"
            }
        },
        {
            models = {
                title = "TEST TITLE 15",
                alias = "test_song_alias"
            }
        }
    }
    return dataTable
end, true)

LUI.createMenu.MusicSelectorMenu = function( controller )

    local self = CoD.Menu.NewForUIEditor( "MusicSelectorMenu" )
    
    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end
    
    self.soundSet = "HUD"
    self:setOwner( controller )
    self:setLeftRight( true, true, 0, 0 )
    self:setTopBottom( true, true, 0, 0 )
    self:playSound( "menu_open", controller )
    self.buttonModel = Engine.CreateModel( Engine.GetModelForController( controller ), "MusicSelectorMenu.buttonPrompts" )
    self.anyChildUsesUpdateState = true

    local Background = LUI.UIImage.new()
    Background:setLeftRight( false, false, -215, 215 )
    Background:setTopBottom( false, false, -300, 300 )
    Background:setRGB( 0, 0, 0 )
    Background:setAlpha( 0.85 )
    self:addElement( Background )
    self.Background = Background

    local Title = LUI.UIText.new()
    Title:setLeftRight( true, true, 0, 0 )
    Title:setTopBottom( true, false, 75.5, 116 )
    Title:setText( "MUSIC SELECTOR" )
    Title:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    Title:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    self:addElement( Title )
    self.Title = Title

    local TitleDivider = LUI.UIImage.new()
    TitleDivider:setLeftRight( false, false, -185, 185 )
    TitleDivider:setTopBottom( true, false, 117.5, 120.5 )
    TitleDivider:setImage( RegisterImage( "rex_coldwar_ui_ammodivider" ) )
    self:addElement( TitleDivider )
    self.TitleDivider = TitleDivider

    local MusicList = LUI.UIList.new( self, controller, 3, 0, nil, false, false, 0, 0, false, false )
    MusicList:setLeftRight( false, false, -185, 185 )
    MusicList:setTopBottom( true, false, 145, 145 )
    MusicList:setWidgetType( CoD.MusicSelector_ListItem )
    MusicList:setDataSource( "MusicList" )
    MusicList:setVerticalCount( 15 )
    MusicList:makeFocusable()
    MusicList.id = "MusicList"
    self:addElement( MusicList )
    self.MusicList = MusicList

    self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "ESCAPE", function( ItemRef, self, controller, Button )
        self:close()
        Engine.SendMenuResponse( controller, "MusicSelectorMenu", "close" )

        return true
    end, function( ItemRef, self, controller )
        
        CoD.Menu.SetButtonLabel( self, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK" )

        return true
    end, true)

    self:registerEventHandler( "menu_loaded", function( element, Event )
        return element:dispatchEventToChildren( Event )
    end)

    self:processEvent({
        name = "menu_loaded",
        controller = controller 
    })

    self:processEvent({ 
        name = "update_state",
        menu = self
    })

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.Background:close()
        element.Title:close()
        element.TitleDivider:close()
        element.MusicList:close()
        Engine.UnsubscribeAndFreeModel( Engine.GetModel( Engine.GetModelForController( controller ), "MusicSelectorMenu.buttonPrompts" ) )
    end)
    
    if PostLoadFunc then
        PostLoadFunc( self, controller )
    end

    return self
end