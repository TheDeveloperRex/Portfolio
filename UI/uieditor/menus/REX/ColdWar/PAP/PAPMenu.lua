require( "ui.uieditor.menus.REX.ColdWar.PAP.PAPMenu_TabBar" )

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

LUI.createMenu.PAPMenu = function( controller )

    local self = CoD.Menu.NewForUIEditor( "PAPMenu" )
    
    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end
    
    self.soundSet = "HUD"
    self:setOwner( controller )
    self:setLeftRight( true, true, 0, 0 )
    self:setTopBottom( true, true, 0, 0 )
    self:playSound( "menu_open", controller )
    self.buttonModel = Engine.CreateModel( Engine.GetModelForController( controller ), "PAPMenu.buttonPrompts" )
    self.anyChildUsesUpdateState = true

    local Title = LUI.UIText.new()
    Title:setLeftRight( true, true, 0, 0 )
    Title:setTopBottom( true, false, 75.5, 116 )
    Title:setText( "PACK-A-PUNCH" )
    Title:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    Title:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    self:addElement( Title )
    self.Title = Title

    local TitleDivider = LUI.UIImage.new()
    TitleDivider:setLeftRight( false, false, -211, 211 )
    TitleDivider:setTopBottom( true, false, 117.5, 120.5 )
    TitleDivider:setImage( RegisterImage( "rex_coldwar_ui_ammodivider" ) )
    self:addElement( TitleDivider )
    self.TitleDivider = TitleDivider

    local Background = LUI.UIImage.new()
    Background:setLeftRight( false, false, -213, 213 )
    Background:setTopBottom( true, false, 450.5, 648.5 )
    Background:setImage( RegisterImage( "rex_coldwar_ui_armory_bg" ) )
    self:addElement( Background )
    self.Background = Background

    local TabBackground = LUI.UIImage.new()
    TabBackground:setLeftRight( false, false, -213, 213 )
    TabBackground:setTopBottom( true, false, 418.5, 448 )
    TabBackground:setImage( RegisterImage( "rex_coldwar_ui_armory_header" ) )
    self:addElement( TabBackground )
    self.TabBackground = TabBackground
    
    local TabFrame = LUI.UIFrame.new( self, controller, 0, 0, false )
    TabFrame:setLeftRight( true, true, 0, 0 )
    TabFrame:setTopBottom( true, true, 0, 0 )
    TabFrame.id = "TabFrame"
    self:addElement( TabFrame )
    self.TabFrame = TabFrame

    local CustomTabBar = CoD.PAPMenu_TabBar.new( self, controller )
    CustomTabBar:setLeftRight( false, false, -213, 213 )
    CustomTabBar:setTopBottom( true, false, 421.5, 445 )
    CustomTabBar.id = "CustomTabBar" 
    self:addElement( CustomTabBar )
    self.CustomTabBar = CustomTabBar

    self.TabFrame:linkToElementModel( self.CustomTabBar.grid, "tabWidget", true, function( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            self.TabFrame:changeFrameWidget( Engine.GetModelValue( ModelRef ) )
        end
    end)

    self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "ESCAPE", function( ItemRef, self, controller, Button )
        self:close()
        Engine.SendMenuResponse( controller, "PAPMenu", "close" )

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
    
    if not self:restoreState() then
        self.TabFrame:processEvent({
            name = "gain_focus",
            controller = controller
        })
    end

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.Title:close()
        element.TitleDivider:close()
        element.Background:close()
        element.TabBackground:close()
        element.TabFrame:close()
        element.CustomTabBar:close()
        Engine.UnsubscribeAndFreeModel( Engine.GetModel( Engine.GetModelForController( controller ), "PAPMenu.buttonPrompts" ) )
    end)
    
    if PostLoadFunc then
        PostLoadFunc( self, controller )
    end

    return self
end