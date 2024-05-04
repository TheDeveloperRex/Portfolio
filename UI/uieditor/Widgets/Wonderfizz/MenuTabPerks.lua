require("ui.uieditor.widgets.Wonderfizz.MenuListItemWidget")
require("ui.uieditor.widgets.Scrollbars.verticalScrollbar")
require("ui.uieditor.widgets.Scrollbars.verticalCounter")
require("ui.uieditor.widgets.Wonderfizz.PerksUIListWidget")
require("ui.uieditor.widgets.Wonderfizz.ExitButtonDobby")

CoD.MenuTabPerks = InheritFrom(LUI.UIElement)

-- Datasource for populating our list with elements
DataSources.BuyablePerksDataSource = DataSourceHelpers.ListSetup("BuyablePerksDataSource", function(InstanceRef)

    local dataTable = {}

    local function AddButtonEntry(displayText, responseStr, iconName)
        table.insert(dataTable, {
            models = {
                text = displayText,
                responseStr = responseStr, 
                name = LUI.splitString(responseStr, ".")[2],
                itemIcon = iconName
            }
        })
    end

    -- Stock 8 perks (no electric cherry)
    AddButtonEntry("PREVIOUS WEAPON", "prev", "rex_ui_arrow_back")
    AddButtonEntry("CONFIRM SELECTION", "confirm", "rex_ui_check_mark")
    AddButtonEntry("NEXT WEAPON", "next", "rex_ui_arrow_forward")

    return dataTable
end, true)

function CoD.MenuTabPerks.new(HudRef, InstanceRef) 

    local Widget = LUI.UIElement.new()

    Widget:setClass(CoD.MenuTabPerks)
    Widget.id = "MenuTabPerks"
    Widget.soundSet = "default"
    Widget:setUseStencil(false)

    Widget:setLeftRight(true, true, 0, 0)
    Widget:setTopBottom(true, true, 0, 0)

    Widget:makeFocusable()
    Widget:setHandleMouse(true)
    Widget.onlyChildrenFocusable = true
    Widget.anyChildUsesUpdateState = true

    Widget.ListBackground = LUI.UIImage.new()
    Widget.ListBackground:setLeftRight(false, false, -500, 500)
    Widget.ListBackground:setTopBottom(false, false, -250, 250)
    Widget.ListBackground:setImage( RegisterImage( "$blacktransparent" ) )
    --Widget.ListBackground:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))

    Widget.ListBackground:makeFocusable()
    Widget.ListBackground:setHandleMouse(true)
    Widget.ListBackground.onlyChildrenFocusable = true
    Widget.ListBackground.anyChildUsesUpdateState = true
    Widget.ListBackground.id = "ListBackground"
    Widget:addElement(Widget.ListBackground)

    Widget.ListBackground.ItemNameText = LUI.UIText.new()
    Widget.ListBackground.ItemNameText:setLeftRight(false, false, 12.5-6, -12.5+6)
    Widget.ListBackground.ItemNameText:setTopBottom(true, false, 34.5 - 26.5, 56 - 26.5)
    Widget.ListBackground.ItemNameText:setTTF("fonts/coldwar/cwbold.ttf")
    Widget.ListBackground.ItemNameText:setAlignment(LUI.Alignment.Left)
    Widget.ListBackground.ItemNameText:setText("")
    Widget.ListBackground.ItemNameText:setRGB(0.498039216, 0.109803922, 0.0705882353)
    Widget.ListBackground:addElement(Widget.ListBackground.ItemNameText)

    Widget.ListBackground.ExitButtonDobby = CoD.ExitButtonDobby.new(HudRef, InstanceRef)
    Widget.ListBackground.ExitButtonDobby:setLeftRight(true, false, 6, 50)
    Widget.ListBackground.ExitButtonDobby:setTopBottom(false, true, 30, 50)
    Widget.ListBackground.ExitButtonDobby.id = "ExitButtonDobby"
    --Widget.ListBackground:addElement(Widget.ListBackground.ExitButtonDobby)

    -- Each of our specific craftables.. Populated by the datasource..
    Widget.ListBackground.CraftablesList = CoD.PerksUIListWidget.new(HudRef, InstanceRef, 2)
    Widget.ListBackground.CraftablesList:setLeftRight(false, false, -192, 192)
    Widget.ListBackground.CraftablesList:setTopBottom(false, true, 0, 40)
    Widget.ListBackground.CraftablesList:SetDataSources("BuyablePerksDataSource")
    Widget.ListBackground.CraftablesList:setWidgetType(CoD.MenuListItemWidget)
    Widget.ListBackground.CraftablesList:makeFocusable()
    Widget.ListBackground.CraftablesList:setHorizontalCount(3)
    Widget.ListBackground.CraftablesList:SetSpacingAndPadding(2)
    Widget.ListBackground.CraftablesList:SetItemSize(2)
    Widget.ListBackground:addElement(Widget.ListBackground.CraftablesList)

    Widget.ListBackground.CraftablesList.id = "CraftablesList"

    Widget:registerEventHandler("gain_focus", function(Sender, Event)
		local success = nil
        
        if Sender.m_focusable then
            if Sender.gainFocus then
                success = Sender:gainFocus(Event)
            elseif Sender.super.gainFocus then
                success = Sender:gainFocus(Event)
            end
        else
            success = false
        end

		return success
	end)

    local function PostLoadCallback(Widget, InstanceRef, HudRef)
        Widget.ListBackground.CraftablesList:ScaleListAndBackgroundForElementCount()
    
        LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function(Widget)
            Widget.ListBackground.CraftablesList:close()
            Widget.ListBackground.ItemNameText:close()
            Widget.ListBackground.ExitButtonDobby:close()
            Widget.ListBackground:close()
        end)
    end

    if PostLoadCallback then
        PostLoadCallback(Widget, InstanceRef, HudRef)
    end

    return Widget
end