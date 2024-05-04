CoD.Menu_ExitButton = InheritFrom(LUI.UIElement)
CoD.Menu_ExitButton.new = function (HudRef, InstanceRef)
    
    local Widget = LUI.UIElement.new()
    
    if PreLoadFunc then
        PreLoadFunc(Widget, InstanceRef)
    end
    
    Widget:setUseStencil(false)
    Widget:setClass(CoD.Menu_ExitButton)
    Widget.id = "Menu_ExitButton"
    Widget.soundSet = "default"
    Widget:setLeftRight(true, true, 0, 0)
    Widget:setTopBottom(true, true, 0, 0)
    Widget:makeFocusable()
    Widget:setHandleMouse(true)
    Widget.anyChildUsesUpdateState = true

    Widget.ButtonImage = LUI.UIImage.new()
    Widget.ButtonImage:setLeftRight(true, true, 0, 0)
    Widget.ButtonImage:setTopBottom(true, true, 0, 0)
    Widget.ButtonImage:setImage(RegisterImage("t9hud_ammostockbg"))
    Widget.ButtonImage:setRGB(0.24,0.23,0.21)

    Widget:addElement(Widget.ButtonImage)

    Widget.ButtonText = LUI.UIText.new()
    Widget.ButtonText:setLeftRight(true, true, 0, 0)
    Widget.ButtonText:setTopBottom(true, true, 0, 0)
    Widget.ButtonText:setText("| " .. Engine.Localize("MENU_EXIT_CAPS"))
    Widget.ButtonText:setTTF("fonts/frabk.ttf")
    Widget.ButtonText:setRGB(0.74,0.73,0.72)
    Widget.ButtonText:setScale(0.6)
    Widget.ButtonText:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
    
    Widget:addElement(Widget.ButtonText)
    
    Widget.clipsPerState = {
        DefaultState = {
            DefaultClip = function ()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setRGB(0.24,0.23,0.21)
                Widget.ButtonImage:setScale(1)
                Widget.clipFinished(Widget.ButtonImage, {})
                
                
                Widget.ButtonText:completeAnimation()
                Widget.ButtonText:setRGB(0.74,0.73,0.72)
                Widget.ButtonText:setScale(0.6)
                Widget.clipFinished(Widget.ButtonText, {})
            end,
            Focus = function ()
                Widget:setupElementClipCounter(2)
                

                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setRGB(0.74,0.73,0.72)
                Widget.ButtonImage:setScale(1.1)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonText:completeAnimation()
                Widget.ButtonText:setRGB(0.24,0.23,0.21)
                Widget.ButtonText:setScale(0.7)
                Widget.clipFinished(Widget.ButtonText, {})
            end
        }
    }
    
    LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function (Sender)
        Sender.ButtonImage:close()
        Sender.ButtonText:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(Widget, InstanceRef, HudRef)
    end
    
    return Widget
end