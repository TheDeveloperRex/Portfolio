require("ui.uieditor.widgets.GenericPopups.ButtonPrompts")
require("ui.uieditor.menus.REX.ColdWar.Shared.Menu_Tabs_ListItem")
require("ui.uieditor.menus.REX.ColdWar.Shared.Menu_ExitButton")

CoD.PAPMenu_Tab1 = InheritFrom(LUI.UIElement)

DataSources.PAPTab1 = DataSourceHelpers.ListSetup( "PAPTab1", function( controller )
    local MenuInfo = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.MenuInfo" )
    local val = Engine.GetModelValue( MenuInfo )
    
    local papLvl = 0

    if MenuInfo and val then
        local strToks = LUI.splitString( val, "," )
                    
        if #strToks > 0 then
            papLvl = tonumber( strToks[ 7 ] )
        end
    end

    local dataTable = {
        {
            models = {
                title = "LEVEL I",
                description = "Large Damage Increase | Enhance Weapon Attributes",
                image = "rex_coldwar_ui_pap_paplvl1",
                cost = 5000,
                circle = ( papLvl > 0 ),
                idx = 1
            }
        },
        {
            models = {
                title = "LEVEL II",
                description = "Massive Damage Increase",
                image = "rex_coldwar_ui_pap_paplvl2",
                cost = 15000,
                locked = ( papLvl < 2 ),
                circle = ( papLvl > 1 ),
                idx = 2
            }
        },
        {
            models = {
                title = "LEVEL III",
                description = "Gigantic Damage Increase",
                image = "rex_coldwar_ui_pap_paplvl3",
                cost = 30000,
                locked = ( papLvl < 3 ),
                circle = ( papLvl > 2 ),
                idx = 3
            }
        }
    }
    
    return dataTable
end, true)

CoD.PAPMenu_Tab1.new = function( menu, controller )
    
    local self = LUI.UIElement.new()
    
    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end
    
    self:setUseStencil(false)
    self:setClass(CoD.PAPMenu_Tab1)
    self.id = "PAPMenu_Tab1"
    self.soundSet = "default"
    self:setLeftRight(true, true, 0, 0)
    self:setTopBottom(true, true, 0, 0)
    self:makeFocusable()
    self.anyChildUsesUpdateState = true
    self.onlyChildrenFocusable = true

    self.MyList = LUI.UIList.new(menu, controller, 33.5, 0, nil, false, false, 0, 0, false, false)
    self.MyList:setLeftRight(false, false, 0, 0)
    self.MyList:setTopBottom(true, false, 524.5, 582)
    self.MyList:setDataSource("PAPTab1")
    self.MyList:setWidgetType(CoD.Menu_Tabs_ListItem)
    self.MyList:makeFocusable()
    self.MyList:setHorizontalCount(4)
    self.MyList.id = "MyList"
    self.MyList:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.MenuInfo" ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )

        if val then
            self.MyList:updateDataSource()
        end
    end)
    self.MyList:subscribeToModel(Engine.GetModel(Engine.GetModel(DataSources.ZMPlayerList.getModel(controller), Engine.GetClientNum(controller)), "playerScore"), function(ModelRef)
        self.MyList:updateDataSource()
    end)
    self:addElement(self.MyList)

    self.ButtonPrompts = CoD.ButtonPrompts.new(menu, controller)
	self.ButtonPrompts:setLeftRight(true, false, 459, 780)
	self.ButtonPrompts:setTopBottom(true, false, 609, 640)
    self.ButtonPrompts:setScale(0.7)
    self.ButtonPrompts.PromptBack.label:setText(Engine.Localize("MENU_EXIT"))

	self:addElement(self.ButtonPrompts)

    self.ButtonPromptsLeftShoulder = LUI.UIImage.new()
    self.ButtonPromptsLeftShoulder:setLeftRight(true, false, 465, 491.5)
    self.ButtonPromptsLeftShoulder:setTopBottom(true, false, 418.5, 445)
    self.ButtonPromptsLeftShoulder:setScale(0.7)
    self.ButtonPromptsLeftShoulder:subscribeToGlobalModel(controller, "Controller", "left_shoulder_button_image", function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            self.ButtonPromptsLeftShoulder:setImage(RegisterImage(Engine.GetModelValue(ModelRef)))
        end
    end)
    
    self:addElement(self.ButtonPromptsLeftShoulder)
    
    self.ButtonPromptsRightShoulder = LUI.UIImage.new()
    self.ButtonPromptsRightShoulder:setLeftRight(false, true, -491.5, -465)
    self.ButtonPromptsRightShoulder:setTopBottom(true, false, 418.5, 445)
    self.ButtonPromptsRightShoulder:setScale(0.7)
    self.ButtonPromptsRightShoulder:subscribeToGlobalModel(controller, "Controller", "right_shoulder_button_image", function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            self.ButtonPromptsRightShoulder:setImage(RegisterImage(Engine.GetModelValue(ModelRef)))
        end
    end)
    
    self:addElement(self.ButtonPromptsRightShoulder)
    
    self.ItemTitle = LUI.UIText.new()
    self.ItemTitle:setLeftRight(true, true, 435.5, 0)
    self.ItemTitle:setTopBottom(true, false, 456, 481)
    self.ItemTitle:setTTF("fonts/MaximaTOTBold-Regular.ttf")
    self.ItemTitle:setRGB( 0.55, 0.20, 0.16 )
    self.ItemTitle:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
    
    self:addElement(self.ItemTitle)
    
    self.ItemDescription = LUI.UIText.new()
    self.ItemDescription:setLeftRight(true, true, 435.5, 0)
    self.ItemDescription:setTopBottom(true, false, 493, 509)
    self.ItemDescription:setTTF("fonts/MaximaEF-Medium.ttf")
    self.ItemDescription:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
    self.ItemDescription:setRGB( 0.7137254901960784, 0.6862745098039216, 0.6352941176470588 )
    self:addElement(self.ItemDescription)
    
    self.ItemCost = LUI.UIText.new()
    self.ItemCost:setLeftRight(true, true, 0, -433.5)
    self.ItemCost:setTopBottom(true, false, 463, 480.5)
    self.ItemCost:setTTF("fonts/DroidSans-Bold.ttf")
    self.ItemCost:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT)
    self.ItemCost:setRGB( 0, 0, 0 )
    self:addElement( self.ItemCost )

    self.ItemScore = LUI.UIImage.new()
    self.ItemScore:setLeftRight(false, true, -433.5 - self.ItemCost:getTextWidth() - 16, -433.5 - self.ItemCost:getTextWidth() - 4)
    self.ItemScore:setTopBottom(true, false, 464.5, 478)
    self.ItemScore:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_essence" ) )
    self:addElement( self.ItemScore )

    self.ItemCostText = LUI.UIText.new()
    self.ItemCostText:setLeftRight(true, true, 0, -433.5 - self.ItemCost:getTextWidth() - 4 - self.ItemScore:getWidth())
    self.ItemCostText:setTopBottom(true, false, 463, 480.5)
    self.ItemCostText:setText("Cost: ")
    self.ItemCostText:setTTF("fonts/MaximaEF-Medium.ttf")
    self.ItemCostText:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT)
    self.ItemCostText:setRGB( 0.15, 0.15, 0.15 )
    self:addElement( self.ItemCostText )
    
    self.scoreText = LUI.UIText.new()
    self.scoreText:setLeftRight( true, true, 0, -433.5 )
    self.scoreText:setTopBottom( true, false, 613.5, 630 )
    self.scoreText:setTTF("fonts/DroidSans-Bold.ttf")
    self.scoreText:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT)
    self.scoreText:setRGB( 0.7137254901960784, 0.6862745098039216, 0.6352941176470588 )
    self.scoreText:subscribeToModel(Engine.GetModel(Engine.GetModel(DataSources.ZMPlayerList.getModel(controller), Engine.GetClientNum(controller)), "playerScore"), function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            self.scoreText:setText(Engine.GetModelValue(ModelRef))
        end
    end)
    
    self:addElement( self.scoreText )
    
    self.scoreImage = LUI.UIImage.new()
    self.scoreImage:setLeftRight(false, true, -433.5 - self.scoreText:getTextWidth() - 16, -433.5 - self.scoreText:getTextWidth() - 4)
    self.scoreImage:setTopBottom(true, false, 615, 628.5)
    self.scoreImage:setImage(RegisterImage("rex_coldwar_ui_scoreboard_essence"))
    
    self:addElement(self.scoreImage)
    
    self.ExitButton = CoD.Menu_ExitButton.new(menu, controller)
    self.ExitButton:setLeftRight(true, false, 434, 478)
    self.ExitButton:setTopBottom(true, false, 614.5, 635)
    self.ExitButton.id = "ExitButton"
    
    self:addElement(self.ExitButton)

    self.UpdateButtonPrompts = LUI.UITimer.newElementTimer(0, false, function(Event)
        self.ItemScore:setLeftRight(false, true, -433.5 - self.ItemCost:getTextWidth() - 16, -433.5 - self.ItemCost:getTextWidth() - 4)
        self.ItemCostText:setLeftRight(true, true, 0, -433.5 - self.ItemCost:getTextWidth() - 4 - self.ItemScore:getWidth())
        self.scoreImage:setLeftRight(false, true, -433.5 - self.scoreText:getTextWidth() - 16, -433.5 - self.scoreText:getTextWidth() - 4)

        if Engine.LastInput_Gamepad() then
            self.ButtonPrompts:setAlpha(1)
            self.ButtonPromptsLeftShoulder:setAlpha(1)
            self.ButtonPromptsRightShoulder:setAlpha(1)
        else
            self.ButtonPrompts:setAlpha(0)
            self.ButtonPromptsLeftShoulder:setAlpha(0)
            self.ButtonPromptsRightShoulder:setAlpha(0)
        end
    end)
    
    self:addElement(self.UpdateButtonPrompts)
    
    menu:AddButtonCallbackFunction(self.MyList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function(ItemRef, menu, controller, Button)
        Engine.PlaySound( "rex_coldwar_ui_select" )

        local idx = Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "idx" ) )
        local cost = Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "cost" ) )

        Engine.SendMenuResponse( controller, "PAPMenu", ( "pap,"..idx..","..cost ) )
        return true
    end, function( ItemRef, menu, controller )
        Engine.PlaySound( "list_right" )

        CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )

        self.ItemTitle:setText(Engine.Localize(Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "title"))))
        self.ItemDescription:setText(Engine.Localize(Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "description"))))
        self.ItemCost:setText(Engine.Localize(Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "cost"))))

        if Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "cost")) > Engine.GetModelValue(Engine.GetModel(Engine.GetModel(DataSources.ZMPlayerList.getModel(controller), Engine.GetClientNum(controller)), "playerScore")) then
            self.ItemCost:setRGB( 1, 0, 0 )
        else
            self.ItemCost:setRGB( 0.15, 0.15, 0.15 )
        end
        return true
    end, true)
    
    menu:AddButtonCallbackFunction(self.ExitButton, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( ItemRef, menu, controller, Button )
        Engine.SendMenuResponse( controller, "PAPMenu", "close" )
        menu:close()
        return true
    end, function( ItemRef, menu, controller )
        CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )
        return true
    end, true)
    
    self.ExitButton.navigation = {
        up = self.MyList
    }
    
    self.MyList.navigation = {
        down = self.ExitButton
    }
    
    CoD.Menu.AddNavigationHandler(menu, menu, controller)

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.MenuInfo" )
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function( element )
        element.ButtonPrompts:close()
        element.ButtonPromptsLeftShoulder:close()
        element.ButtonPromptsRightShoulder:close()
        element.ItemTitle:close()
        element.ItemDescription:close()
        element.ItemCost:close()
        element.ItemScore:close()
        element.ItemCostText:close()
        element.scoreText:close()
        element.scoreImage:close()
        element.MyList:close()
        element.ExitButton:close()
        element.UpdateButtonPrompts:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end
    
    return self
end