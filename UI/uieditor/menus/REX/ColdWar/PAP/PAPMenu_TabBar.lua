require( "ui.uieditor.menus.REX.ColdWar.Shared.Menu_TabBar_ListItem" )
require( "ui.uieditor.menus.REX.ColdWar.PAP.PAPMenu_Tab1" )
require( "ui.uieditor.menus.REX.ColdWar.PAP.PAPMenu_Tab2" )

CoD.PAPMenu_TabBar = InheritFrom( LUI.UIElement )
CoD.PAPMenu_TabBar.SizeTabsToWidth = function( TabBar, Width )
    TabBar:setLeftRight( false, false, ( ( -Width * 3 ) / 2 ), ( ( Width * 3 ) / 2 ) )
	for k, v in LUI.IterateTableBySortedKeys( TabBar.grid.layoutItems ) do
		for i, j in LUI.IterateTableBySortedKeys( v ) do
			j:setLeftRight( true, false, 0, Width )
		end
	end

    TabBar.grid:updateLayout()
end

DataSources.PAPTabBar = DataSourceHelpers.ListSetup( "PAPTabBar", function( controller )
    local dataTable = {
        {
            models = {
                tabName = "PACK WEAPON",
                tabWidget = "CoD.PAPMenu_Tab1",
                tabIcon = ""
            },
            properties = {
                tabId = "PAPMenu_Tab1"
            }
        },
        {
            models = {
                tabName = "AMMO MODS",
                tabWidget = "CoD.PAPMenu_Tab2",
                tabIcon = ""
            },
            properties = {
                tabId = "PAPMenu_Tab2"
            }
        }
    }
    return dataTable
end, true)

local PostLoadFunc = function( self, controller, menu )
    menu:AddButtonCallbackFunction( menu, controller, Enum.LUIButton.LUI_KEY_LB, nil, function( ItemRef, menu, controller, Button )
        BlockGameFromKeyEvent( controller )

		if not PropertyIsTrue( self, "m_disableNavigation" ) then
			self.grid:navigateItemLeft()
		end
    end, function( ItemRef, menu, controller )
        if IsGamepad( controller ) then
            CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_LB, "Navigate Left" )
            return true
        end

        CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_LB, "" )
        return false
    end, true)

    menu:AddButtonCallbackFunction( menu, controller, Enum.LUIButton.LUI_KEY_RB, nil, function( ItemRef, menu, controller, Button )
        BlockGameFromKeyEvent( controller )

		if not PropertyIsTrue( self, "m_disableNavigation" ) then
			self.grid:navigateItemRight()
		end
    end, function( ItemRef, menu, controller )
        if IsGamepad( controller ) then
            CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_RB, "Navigate Right" )
            return true
        end

        CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_RB, "" )
        return false
    end, true)

    menu:registerEventHandler("input_source_changed", function( element, Event )
        CoD.Menu.UpdateButtonShownState( element, menu, controller, Enum.LUIButton.LUI_KEY_LB )
        CoD.Menu.UpdateButtonShownState( element, menu, controller, Enum.LUIButton.LUI_KEY_RB )
    end)

	self:setForceMouseEventDispatch(true)
end

CoD.PAPMenu_TabBar.new = function( menu, controller )

    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setUseStencil( false )
    self:setClass( CoD.PAPMenu_TabBar )
    self.id = "PAPMenu_TabBar"
    self.soundSet = "default"
    self:setLeftRight( true, true, 0, 0 )
    self:setTopBottom( true, true, 0, 0 )
    self.anyChildUsesUpdateState = true
    self.onlyChildrenFocusable = true

	local grid = LUI.GridLayout.new( menu, controller, true, 0, 0, 5.5, 0, nil, nil, true, false, 81.75, 0, false, false )
	grid:setLeftRight( true, true, 0, 0 )
	grid:setTopBottom( true, true, 0, 0 )
	grid:setWidgetType( CoD.Menu_TabBar_ListItem )
    grid:setDataSource( "PAPTabBar" )
	grid:setHorizontalCount( 2 )
    grid.id = "grid"
    grid:registerEventHandler( "menu_loaded", function( element, Event )
		local success = nil

		UpdateDataSource( self, element, controller )

		if not success then
			success = element:dispatchEventToChildren( Event )
		end

		return success
	end)
	grid:registerEventHandler( "mouse_left_click", function( element, Event )
        local success = nil

		SelectItemIfPossible( self, element, controller, Event )
        Engine.PlaySound( "rex_coldwar_ui_select" )

		if not success then
			success = element:dispatchEventToChildren( Event )
		end

		return success
	end)
	self:addElement( grid )
    self.grid = grid

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.grid:close()
	end)

    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end

    return self
end