require("ui.uieditor.widgets.GenericPopups.ButtonPrompts")
require("ui.uieditor.menus.REX.ColdWar.Shared.Menu_Tabs_ListItem")
require("ui.uieditor.menus.REX.ColdWar.Shared.Menu_ExitButton")

CoD.ArmoryMenu_Tab1 = InheritFrom(LUI.UIElement)

DataSources.ArmoryTab1 = DataSourceHelpers.ListSetup( "ArmoryTab1", function(controller)
    local MenuInfo = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.MenuInfo" )
    local val = Engine.GetModelValue( MenuInfo )
    
    local Armor = 0
    local ArmorMax = 0
    local ArmorTier = 0
    local ArmorPercent = 0
    
    if MenuInfo and val then
        local strToks = LUI.splitString( val, "," )
        
        if #strToks > 0 then
            Armor = tonumber( strToks[ 3 ] )
            ArmorMax = tonumber( strToks[ 4 ] )
            ArmorTier = tonumber( strToks[ 5 ] )
            ArmorPercent = ( Armor / ArmorMax )
        end
    end

    local dataTable = {
        {
            models = {
                title = "LEVEL 1 ARMOR",
                description = "Reduces damage from zombies.",
                image = "rex_coldwar_ui_armory_armorlvl1",
                salvage = "rex_coldwar_ui_scoreboard_commonscrap",
                salvagetype = "common",
                cost = 500,
                circle = ( ArmorTier > 0 ),
                idx = 1
            }
        },
        {
            models = {
                title = "LEVEL 2 ARMOR",
                description = "Increased damage reduction and durability.",
                image = "rex_coldwar_ui_armory_armorlvl2",
                salvage = "rex_coldwar_ui_scoreboard_commonscrap",
                salvagetype = "common",
                cost = 1000,
                locked = ( ArmorTier < 2 ),
                circle = ( ArmorTier > 1 ),
                idx = 2
            }
        },
        {
            models = {
                title = "LEVEL 3 ARMOR",
                description = "Maximum damage reduction and durability.",
                image = "rex_coldwar_ui_armory_armorlvl3",
                salvage = "rex_coldwar_ui_scoreboard_rarescrap",
                salvagetype = "rare",
                cost = 250,
                locked = ( ArmorTier < 3 ),
                circle = ( ArmorTier > 2 ),
                idx = 3
            }
        },
        {
            models = {
                title = "REPAIR ARMOR",
                description = "Repair Your Armor.",
                image = "rex_coldwar_ui_armory_armorrepair",
                salvage = "rex_coldwar_ui_scoreboard_rarescrap",
                salvagetype = "rare",
                cost = 250,
                repair = ( ( ArmorTier > 0 ) and ArmorPercent or 0 ),
                idx = 4
            },
            properties = {
                isRepair = true
            }
        }
    }
    
    return dataTable
end, true)

CoD.ArmoryMenu_Tab1.new = function( menu, controller )
    
    local self  = LUI.UIElement.new()
    
    if PreLoadFunc then
        PreLoadFunc( menu, controller )
    end
    
    self:setUseStencil(false)
    self:setClass(CoD.ArmoryMenu_Tab1)
    self.id = "ArmoryMenu_Tab1"
    self.soundSet = "default"
    self:setLeftRight(true, true, 0, 0)
    self:setTopBottom(true, true, 0, 0)
    self:makeFocusable()
    self.anyChildUsesUpdateState = true
    self.onlyChildrenFocusable = true
    
    local MyList = LUI.UIList.new(menu, controller, 33.5, 0, nil, false, false, 0, 0, false, false)
    MyList:setLeftRight(false, false, 0, 0)
    MyList:setTopBottom(true, false, 524.5, 582)
    MyList:setDataSource("ArmoryTab1")
    MyList:setWidgetType( CoD.Menu_Tabs_ListItem )
    MyList:setImage( RegisterImage( "blacktransparent" ) )
    MyList:makeFocusable()
    MyList:setHorizontalCount( 4 )
    MyList.id = "MyList"
    MyList:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.MenuInfo" ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )

        if val then
            MyList:updateDataSource()
        end
    end)
    self:addElement( MyList )
    self.MyList = MyList

    local ButtonPrompts = CoD.ButtonPrompts.new(menu, controller)
	ButtonPrompts:setLeftRight(true, false, 459, 780)
	ButtonPrompts:setTopBottom(true, false, 609, 640)
    ButtonPrompts:setScale(0.7)
    ButtonPrompts.PromptBack.label:setText( Engine.Localize("MENU_EXIT" ) )
	self:addElement( ButtonPrompts )
    self.ButtonPrompts = ButtonPrompts

    local ButtonPromptsLeftShoulder = LUI.UIImage.new()
    ButtonPromptsLeftShoulder:setLeftRight(true, false, 465, 491.5)
    ButtonPromptsLeftShoulder:setTopBottom(true, false, 418.5, 445)
    ButtonPromptsLeftShoulder:setScale(0.7)
    ButtonPromptsLeftShoulder:subscribeToGlobalModel(controller, "Controller", "left_shoulder_button_image", function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            ButtonPromptsLeftShoulder:setImage(RegisterImage(Engine.GetModelValue(ModelRef)))
        end
    end)
    menu:addElement( ButtonPromptsLeftShoulder )
    self.ButtonPromptsLeftShoulder = ButtonPromptsLeftShoulder
    
    local ButtonPromptsRightShoulder = LUI.UIImage.new()
    ButtonPromptsRightShoulder:setLeftRight(false, true, -491.5, -465)
    ButtonPromptsRightShoulder:setTopBottom(true, false, 418.5, 445)
    ButtonPromptsRightShoulder:setScale(0.7)
    ButtonPromptsRightShoulder:subscribeToGlobalModel(controller, "Controller", "right_shoulder_button_image", function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            ButtonPromptsRightShoulder:setImage(RegisterImage(Engine.GetModelValue(ModelRef)))
        end
    end)
    menu:addElement( ButtonPromptsRightShoulder )
    self.ButtonPromptsRightShoulder = ButtonPromptsRightShoulder
    
    local ItemTitle = LUI.UIText.new()
    ItemTitle:setLeftRight(true, true, 435.5, 0)
    ItemTitle:setTopBottom(true, false, 456, 481)
    ItemTitle:setTTF("fonts/MaximaTOTBold-Regular.ttf")
    ItemTitle:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    ItemTitle:setRGB( 0.55, 0.20, 0.16 )
    self:addElement( ItemTitle )
    self.ItemTitle = ItemTitle
    
    local ItemDescription = LUI.UIText.new()
    ItemDescription:setLeftRight(true, true, 435.5, 0)
    ItemDescription:setTopBottom(true, false, 493, 509)
    ItemDescription:setTTF("fonts/MaximaEF-Medium.ttf")
    ItemDescription:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    ItemDescription:setRGB( 0.7137254901960784, 0.6862745098039216, 0.6352941176470588 )
    self:addElement( ItemDescription )
    self.ItemDescription = ItemDescription
    
    local ItemSalvage = LUI.UIImage.new()
    ItemSalvage:setLeftRight(true, false, 831, 846)
    ItemSalvage:setTopBottom(true, false, 465.5, 478)
    ItemSalvage:setImage( RegisterImage( "blacktransparent" ) )
    self:addElement( ItemSalvage )
    self.ItemSalvage = ItemSalvage
    
    local ItemCost = LUI.UIText.new()
    ItemCost:setLeftRight(true, true, 0, -453.5)
    ItemCost:setTopBottom(true, false, 464, 480.5)
    ItemCost:setTTF( "fonts/MaximaEF-Medium.ttf" )
    ItemCost:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT)
    self:addElement( ItemCost )
    self.ItemCost = ItemCost
    
    local scrapText = LUI.UIText.new()
    scrapText:setLeftRight( true, true, 0, -453.5 )
    scrapText:setTopBottom( true, false, 613.5, 630 )
    scrapText:setTTF( "fonts/DroidSans-Bold.ttf" )
    scrapText:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT)
    scrapText:setRGB( 0.7137254901960784, 0.6862745098039216, 0.6352941176470588 )
    self:addElement( scrapText )
    self.scrapText = scrapText
    
    local scrapImage = LUI.UIImage.new()
    scrapImage:setLeftRight(false, true, -448.5, -433.5)
    scrapImage:setTopBottom(true, false, 615, 627.5)
    scrapImage:setImage(RegisterImage("blacktransparent"))
    self:addElement( scrapImage )
    self.scrapImage = scrapImage

    local RepairLargeBG = LUI.UIImage.new()
    RepairLargeBG:setLeftRight(true, false, 581.5, 785.5)
    RepairLargeBG:setTopBottom(true, false, 494, 503.5)
    RepairLargeBG:setImage(RegisterImage("blacktransparent"))
    self:addElement( RepairLargeBG )
    self.RepairLargeBG = RepairLargeBG

    local RepairLarge = LUI.UIImage.new()
    RepairLarge:setLeftRight(true, false, 583.5, 783.5)
    RepairLarge:setTopBottom(true, false, 496, 501.5)
    RepairLarge:setImage(RegisterImage("blacktransparent"))
    RepairLarge:setMaterial(RegisterMaterial("uie_wipe_normal"))
    RepairLarge:setShaderVector( 0, 1, 0, 0, 0 )
    RepairLarge:setShaderVector( 1, 0, 0, 0, 0 )
    RepairLarge:setShaderVector( 2, 1, 0, 0, 0 )
    RepairLarge:setShaderVector( 3, 0, 0, 0, 0 )
    RepairLarge:setShaderVector( 0, AdjustStartEnd(0, 1,
        CoD.GetVectorComponentFromString( 0, 1 ),
        CoD.GetVectorComponentFromString( 0, 2 ),
        CoD.GetVectorComponentFromString( 0, 3 ),
        CoD.GetVectorComponentFromString( 0, 4 )))
    self:addElement( RepairLarge )
    self.RepairLarge = RepairLarge
    
    local ExitButton = CoD.Menu_ExitButton.new(menu, controller)
    ExitButton:setLeftRight(true, false, 434, 478)
    ExitButton:setTopBottom(true, false, 614.5, 635)
    ExitButton.id = "ExitButton"
    self:addElement( ExitButton )
    self.ExitButton = ExitButton

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
    
    menu:AddButtonCallbackFunction(self.MyList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( ItemRef, menu, controller, Button )        
        Engine.PlaySound( "rex_coldwar_ui_select" )
        
        local idx = Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "idx" ) )
        local cost = Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "cost" ) )
        local salvagetype = Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "salvagetype" ) )

        Engine.SendMenuResponse(controller, "ArmoryMenu", ( "armory,"..idx..","..cost..","..salvagetype ) )
        return true
    end, function( ItemRef, menu, controller )
        Engine.PlaySound( "list_right" )

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
        
        self.ItemTitle:setText(Engine.Localize(Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "title"))))
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

        if ItemRef.isRepair then
            self.RepairLarge:setShaderVector(0, AdjustStartEnd(0, 1, 
                CoD.GetVectorComponentFromString( Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "repair") ), 1 ),
                CoD.GetVectorComponentFromString( Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "repair") ), 2 ),
                CoD.GetVectorComponentFromString( Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "repair") ), 3 ),
                CoD.GetVectorComponentFromString( Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "repair") ), 4 )))
            self.RepairLargeBG:setAlpha(1)
            self.RepairLarge:setAlpha(1)
        else
            self.RepairLargeBG:setAlpha(0)
            self.RepairLarge:setAlpha(0)
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
    
    CoD.Menu.AddNavigationHandler(menu, menu, controller)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function (element)
        element.ButtonPrompts:close()
        element.ButtonPromptsLeftShoulder:close()
        element.ButtonPromptsRightShoulder:close()
        element.ItemTitle:close()
        element.ItemDescription:close()
        element.ItemSalvage:close()
        element.ItemCost:close()
        element.scrapText:close()
        element.scrapImage:close()
        element.RepairLargeBG:close()
        element.RepairLarge:close()
        element.MyList:close()
        element.ExitButton:close()
        element.UpdateButtonPrompts:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end