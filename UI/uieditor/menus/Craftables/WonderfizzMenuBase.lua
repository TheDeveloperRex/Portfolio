require("ui.uieditor.widgets.BackgroundFrames.GenericMenuFrame")
require("ui.uieditor.widgets.Footer.fe_LeftContainer_NOTLobby")
require("ui.uieditor.widgets.footerbuttonprompt")

require("ui.uieditor.widgets.Wonderfizz.PerkMenuTabBar")
require("ui.uieditor.widgets.Wonderfizz.ExitButtonDobby")

require("ui.uieditor.widgets.REX.CumUniverse.CUSelectorWeaponContainer")

require( "ui.utility.CoreUtil" )

local function PreLoadCallback(HudRef, InstanceRef)
    HudRef.disablePopupOpenCloseAnim = true
    local buyablesModel = Engine.CreateModel(Engine.GetModelForController(InstanceRef), "cw_perk_buyables")
    local ownedItemsModel = Engine.CreateModel(buyablesModel, "owned_perks")
end

-- Instead of restructuring, we're just removing the tab bar and forcing it to use this tab..
local function PostLoadCallback(HudRef, InstanceRef)
    local DefaultTab = "CoD.MenuTabPerks"
    HudRef.TabFrame:changeFrameWidget(DefaultTab)
end

function LUI.createMenu.WonderfizzMenuBase(InstanceRef)
    local HudRef = CoD.Menu.NewForUIEditor("WonderfizzMenuBase")
    
    if PreLoadCallback then
        PreLoadCallback(HudRef, InstanceRef)
    end
    
    HudRef.soundSet = "default"
    HudRef:setOwner(InstanceRef)
    HudRef:setLeftRight(true, true, 0, 0)
    HudRef:setTopBottom(true, true, 0, 0)
    PlaySoundSetSound(HudRef, "menu_open")
    
    HudRef.buttonModel = Engine.CreateModel(Engine.GetModelForController(InstanceRef), "WonderfizzMenuBase.buttonPrompts")
    HudRef.anyChildUsesUpdateState = true
    HudRef.disableBlur = true
    HudRef.disableDarkenElement = true
    Engine.LockInput(InstanceRef, true)
    Engine.SetUIActive(InstanceRef, true)

    HudRef.wonderfizzBackground = LUI.UIImage.new()
    HudRef.wonderfizzBackground:setLeftRight(true, true, 0, 0)
    HudRef.wonderfizzBackground:setTopBottom(true, true, 0, 0)
    HudRef.wonderfizzBackground:setRGB( 0, 0, 0 )
    HudRef.wonderfizzBackground:setAlpha( 0.35 )
    HudRef:addElement(HudRef.wonderfizzBackground)

    HudRef.CUSelectorWeaponContainer = CoD.CUSelectorWeaponContainer.new(HudRef, InstanceRef)
    HudRef.CUSelectorWeaponContainer:setLeftRight(false, false, -250, 250)
    HudRef.CUSelectorWeaponContainer:setTopBottom(false, false, -250, 250)
    HudRef.CUSelectorWeaponContainer:setAlpha( 1 )
    HudRef:addElement( HudRef.CUSelectorWeaponContainer )

    HudRef.wonderfizzText = LUI.UIText.new()
    HudRef.wonderfizzText:setLeftRight(false, false, -168, 168)
    HudRef.wonderfizzText:setTopBottom(true, false, 78, 115)
    HudRef.wonderfizzText:setTTF("fonts/coldwar/cwbold.ttf")
    HudRef.wonderfizzText:setText("WEAPON SELECTION")
    HudRef:addElement(HudRef.wonderfizzText)
    
    -- This is a UIFrame. You can make it use whatever widget you want through script.. Used to display different tab information..
    HudRef.TabFrame = LUI.UIFrame.new(HudRef, InstanceRef, 0, 0, false)
    HudRef.TabFrame:setLeftRight(true, true, 0, 0)
    HudRef.TabFrame:setTopBottom(true, true, 0, 0)
    HudRef.TabFrame.id = "TabFrame"
    HudRef.TabFrame:setHandleMouse(true)
    HudRef:addElement(HudRef.TabFrame)

    local buttonBottomOffset = 87
    local buttonLeftOffset = 370
    HudRef.ExitButtonDobby = CoD.ExitButtonDobby.new(HudRef, InstanceRef)
    HudRef.ExitButtonDobby:setLeftRight(true, false, buttonLeftOffset, buttonLeftOffset + 44)
    HudRef.ExitButtonDobby:setTopBottom(false, true, -buttonBottomOffset - 20, -buttonBottomOffset)
    HudRef.ExitButtonDobby.id = "ExitButtonDobby"
    --HudRef:addElement(HudRef.ExitButtonDobby)

    HudRef.leftButtonBar = CoD.fe_LeftContainer_NOTLobby.new(HudRef, InstanceRef)
	HudRef.leftButtonBar:setLeftRight(true, false, 445.96, 877.96)
	HudRef.leftButtonBar:setTopBottom(true, false, 523.25, 555.25)
	HudRef.leftButtonBar:setScale(0.5)
	HudRef:addElement(HudRef.leftButtonBar)
    
    -- This is the part that shows the text and the animation at the top of the screen. It also shows buttonprompts at the bottom of the screen.. 
    HudRef.MenuFrame = CoD.GenericMenuFrame.new(HudRef, InstanceRef)
    HudRef.MenuFrame:setLeftRight(true, true, 0, 0)
    HudRef.MenuFrame:setTopBottom(true, true, 0, 0)
    HudRef.MenuFrame.titleLabel:setText(Engine.Localize("TEST TAB MENU"))
    HudRef.MenuFrame.cac3dTitleIntermediary0.FE3dTitleContainer0.MenuTitle.TextBox1.Label0:setText(Engine.Localize("WEAPON SELECTION"))
    --HudRef:addElement(HudRef.MenuFrame)

    HudRef.TabFrame.navigation = {
        down = HudRef.ExitButtonDobby
    }
    HudRef.ExitButtonDobby.navigation = {
        up = HudRef.TabFrame
    }
    CoD.Menu.AddNavigationHandler(HudRef, HudRef, InstanceRef)

    HudRef:registerEventHandler("menu_loaded", function(Sender, Event)
        -- Remove size to safe area unless you want the menu to be fullscreen!
        SizeToSafeArea(Sender, InstanceRef)
        return Sender:dispatchEventToChildren(Event)
    end)

    -- Needed to make the button prompts display at the bottom of the screen
    --HudRef.MenuFrame:setModel(HudRef.buttonModel, InstanceRef)
    --HudRef.leftButtonBar:setModel(HudRef.buttonModel, InstanceRef)

    HudRef:processEvent({name = "menu_loaded", controller = InstanceRef})
    HudRef:processEvent({name = "update_state", menu = HudRef})
    
    if not HudRef:restoreState() then
        HudRef.TabFrame:processEvent({
            name = "gain_focus",
            controller = InstanceRef
        })
    end

    LUI.OverrideFunction_CallOriginalSecond(HudRef, "close", function(HudRef)        
        HudRef.MenuFrame:close()
        HudRef.TabFrame:close()
        HudRef.CUSelectorWeaponContainer:close()
        HudRef.wonderfizzBackground:close()
        HudRef.wonderfizzText:close()
        HudRef.leftButtonBar:close()
        HudRef.ExitButtonDobby:close()

        Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "WonderfizzMenuBase.buttonPrompts"))
    end)
    
    if PostLoadCallback then
        PostLoadCallback(HudRef, InstanceRef)
    end

    return HudRef
end