require("ui.uieditor.widgets.GenericPopups.ButtonPrompts")
require("ui.uieditor.menus.REX.ColdWar.Shared.Menu_Tabs_ListItem")
require("ui.uieditor.menus.REX.ColdWar.Shared.Menu_ExitButton")
require( "ui.utility.CoreUtil" )

CoD.ArmoryMenu_Tab2 = InheritFrom(LUI.UIElement)

DataSources.ArmoryTab2 = DataSourceHelpers.ListSetup("ArmoryTab2", function(controller)
    local MenuInfo = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.MenuInfo" )
    local val = Engine.GetModelValue( MenuInfo )
    
    local Rarity = 0

    if MenuInfo and val then
        local strToks = LUI.splitString( val, "," )
                    
        if #strToks > 0 then
            Rarity = tonumber( strToks[ 6 ] )
        end
    end

    local dataTable = {
        {
            models = {
                description = "Uncommon | Tier 2 Damage",
                image = "rex_coldwar_ui_armory_raritylvl1",
                salvage = "rex_coldwar_ui_scoreboard_commonscrap",
                salvagetype = "common",
                cost = 500,
                circle = ( Rarity > 1 ),
                idx = 2
            }
        },
        {
            models = {
                description = "Rare | Tier 3 Damage",
                image = "rex_coldwar_ui_armory_raritylvl2",
                salvage = "rex_coldwar_ui_scoreboard_commonscrap",
                salvagetype = "common",
                cost = 1000,
                locked = ( Rarity < 3 ),
                circle = ( Rarity > 2 ),
                idx = 3
            }
        },
        {
            models = {
                description = "Epic | Tier 4 Damage",
                image = "rex_coldwar_ui_armory_raritylvl3",
                salvage = "rex_coldwar_ui_scoreboard_rarescrap",
                salvagetype = "rare",
                cost = 500,
                locked = ( Rarity < 4 ),
                circle = ( Rarity > 3 ),
                idx = 4
            }
        },
        {
            models = {
                description = "Legendary | Tier 5 Damage",
                image = "rex_coldwar_ui_armory_raritylvl4",
                salvage = "rex_coldwar_ui_scoreboard_rarescrap",
                salvagetype = "rare",
                cost = 1000,
                locked = ( Rarity < 5 ),
                circle = ( Rarity > 4 ),
                idx = 5
            }
        }
    }
    
    return dataTable
end, true)

CoD.ArmoryMenu_Tab2.new = function(menu, controller)
    
    local self = LUI.UIElement.new()
    
    if PreLoadFunc then
        PreLoadFunc( menu, controller )
    end
    
    self:setUseStencil(false)
    self:setClass(CoD.ArmoryMenu_Tab2)
    self.id = "ArmoryMenu_Tab2"
    self.soundSet = "default"
    self:setLeftRight(true, true, 0, 0)
    self:setTopBottom(true, true, 0, 0)
    self:makeFocusable()
    self.anyChildUsesUpdateState = true
    self.onlyChildrenFocusable = true

    self.MyList = LUI.UIList.new(menu, controller, 33.5, 0, nil, false, false, 0, 0, false, false)
    self.MyList:setLeftRight(false, false, 0, 0)
    self.MyList:setTopBottom(true, false, 524.5, 582)
    self.MyList:setDataSource( "ArmoryTab2" )
    self.MyList:setWidgetType(CoD.Menu_Tabs_ListItem)
    self.MyList:makeFocusable()
    self.MyList:setHorizontalCount(4)
    self.MyList.id = "MyList"
    self.MyList:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.MenuInfo" ), function(ModelRef)
        local val = Engine.GetModelValue( ModelRef )

        if val then
            self.MyList:updateDataSource()
        end
    end)
    self:addElement( self.MyList )

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
    menu:addElement(self.ButtonPromptsLeftShoulder)
    
    self.ButtonPromptsRightShoulder = LUI.UIImage.new()
    self.ButtonPromptsRightShoulder:setLeftRight(false, true, -491.5, -465)
    self.ButtonPromptsRightShoulder:setTopBottom(true, false, 418.5, 445)
    self.ButtonPromptsRightShoulder:setScale(0.7)
    self.ButtonPromptsRightShoulder:subscribeToGlobalModel(controller, "Controller", "right_shoulder_button_image", function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            self.ButtonPromptsRightShoulder:setImage(RegisterImage(Engine.GetModelValue(ModelRef)))
        end
    end)
    menu:addElement(self.ButtonPromptsRightShoulder)
    
    self.ItemTitle = LUI.UIText.new()
    self.ItemTitle:setLeftRight(true, true, 435.5, 0)
    self.ItemTitle:setTopBottom(true, false, 456, 481)
    self.ItemTitle:setText("TIER UPGRADE")
    self.ItemTitle:setTTF("fonts/MaximaTOTBold-Regular.ttf")
    self.ItemTitle:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
    self.ItemTitle:setRGB( 0.55, 0.20, 0.16 )
    self:addElement(self.ItemTitle)
    
    self.ItemDescription = LUI.UIText.new()
    self.ItemDescription:setLeftRight(true, true, 435.5, 0)
    self.ItemDescription:setTopBottom(true, false, 493, 509)
    self.ItemDescription:setTTF("fonts/DroidSans-Bold.ttf")
    self.ItemDescription:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
    self.ItemDescription:setRGB( 0.7137254901960784, 0.6862745098039216, 0.6352941176470588 )
    self:addElement(self.ItemDescription)
    
    self.ItemSalvage = LUI.UIImage.new()
    self.ItemSalvage:setLeftRight(true, false, 831, 846)
    self.ItemSalvage:setTopBottom(true, false, 465.5, 478)
    self.ItemSalvage:setImage(RegisterImage("blacktransparent"))
    self:addElement(self.ItemSalvage)
    
    self.ItemCost = LUI.UIText.new()
    self.ItemCost:setLeftRight(true, true, 0, -453.5)
    self.ItemCost:setTopBottom(true, false, 464, 480.5)
    self.ItemCost:setTTF("fonts/MaximaEF-Medium.ttf")
    self.ItemCost:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT)
    self:addElement( self.ItemCost )
    
    self.scrapText = LUI.UIText.new()
    self.scrapText:setLeftRight(true, true, 0, -453.5)
    self.scrapText:setTopBottom(true, false, 613.5, 630)
    self.scrapText:setTTF("fonts/DroidSans-Bold.ttf")
    self.scrapText:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT)
    self.scrapText:setRGB( 0.7137254901960784, 0.6862745098039216, 0.6352941176470588 )
    self:addElement( self.scrapText )
    
    self.scrapImage = LUI.UIImage.new()
    self.scrapImage:setLeftRight(false, true, -448.5, -433.5)
    self.scrapImage:setTopBottom(true, false, 615, 627.5)
    self.scrapImage:setImage( RegisterImage( "blacktransparent" ) )
    self:addElement( self.scrapImage )
    
    self.ExitButton = CoD.Menu_ExitButton.new( menu, controller )
    self.ExitButton:setLeftRight(true, false, 434, 478)
    self.ExitButton:setTopBottom(true, false, 614.5, 635)
    self.ExitButton.id = "ExitButton"
    self:addElement( self.ExitButton )

    self.UpdateButtonPrompts = LUI.UITimer.newElementTimer(0, false, function(Event)
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
        local salvagetype = Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "salvagetype" ) )

        Engine.SendMenuResponse(controller, "ArmoryMenu", ( "armory,"..idx..","..cost..","..salvagetype ) )

        return true
    end, function(ItemRef, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT")

        local IsCommon = ( Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "salvage" ) ) == "rex_coldwar_ui_scoreboard_commonscrap" )
        local val = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.MenuInfo" ) )

        local scrapAmount = 0

        if val then
            local strToks = LUI.splitString( val, "," )

            if #strToks > 0 then
                scrapAmount = tonumber( IsCommon and strToks[ 1 ] or strToks[ 2 ] )
            end
        end

        self.ItemDescription:setText(Engine.Localize(Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "description"))))
        self.ItemSalvage:setImage(RegisterImage(Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "salvage"))))
        self.ItemCost:setText("Cost: " .. Engine.Localize(Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "cost"))))
        self.scrapImage:setImage(RegisterImage(Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "salvage"))))
        self.scrapText:setText( Engine.Localize( scrapAmount ) )

        if Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "cost" ) ) > scrapAmount then
            self.ItemCost:setRGB( 1, 0, 0 )
        else
            self.ItemCost:setRGB( 0.15, 0.15, 0.15 )
        end

        return true
    end, true)
    
    menu:AddButtonCallbackFunction(self.ExitButton, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function (ItemRef, menu, controller, Button)
        Engine.SendMenuResponse(controller, "ArmoryMenu", "close")
        menu:close()
        return true
    end, function (ItemRef, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT")
        return true
    end, true)
    
    self.ExitButton.navigation = {
        up = self.MyList
    }
    
    self.MyList.navigation = {
        down = self.ExitButton
    }
    
    CoD.Menu.AddNavigationHandler( menu, menu, controller )
        
    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.ButtonPrompts:close()
        element.ButtonPromptsLeftShoulder:close()
        element.ButtonPromptsRightShoulder:close()
        element.ItemTitle:close()
        element.ItemDescription:close()
        element.ItemSalvage:close()
        element.ItemCost:close()
        element.scrapText:close()
        element.scrapImage:close()
        element.MyList:close()
        element.ExitButton:close()
        element.UpdateButtonPrompts:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end
    
    return self
end