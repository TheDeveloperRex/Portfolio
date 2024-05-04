CoD.Menu_Tabs_ListItem = InheritFrom(LUI.UIElement)

CoD.Menu_Tabs_ListItem.new = function(HudRef, InstanceRef)

    local Widget = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc(Widget, InstanceRef)
    end

    Widget:setClass(CoD.Menu_Tabs_ListItem)
    Widget.id = "Menu_Tabs_ListItem"
    Widget.soundSet = "default"
    Widget:setLeftRight(true, false, 0, 57.5)
    Widget:setTopBottom(true, false, 0, 57.5)
    Widget.anyChildUsesUpdateState = true
    Widget:makeFocusable()
    Widget:setHandleMouse(true)

    Widget.ButtonLocked = LUI.UIImage.new()
    Widget.ButtonLocked:setLeftRight(false, true, -148.5, 0)
    Widget.ButtonLocked:setTopBottom(true, true, 0, 0)
    Widget.ButtonLocked:setImage(RegisterImage("blacktransparent"))
    Widget.ButtonLocked:linkToElementModel(Widget, "locked", true, function(ModelRef)
        Widget.ButtonLocked:setImage( RegisterImage( Engine.GetModelValue( ModelRef ) and "rex_coldwar_ui_buttonlocked" or "rex_coldwar_ui_buttonunlocked" ) )
    end)
    Widget:addElement(Widget.ButtonLocked)

    Widget.ButtonImage = LUI.UIImage.new()
    Widget.ButtonImage:setLeftRight(true, true, 0, 0)
    Widget.ButtonImage:setTopBottom(true, true, 0, 0)
    Widget.ButtonImage:linkToElementModel(Widget, "image", true, function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            Widget.ButtonImage:setImage(RegisterImage(Engine.GetModelValue(ModelRef)))
        end
    end)
    Widget:addElement(Widget.ButtonImage)

    Widget.ButtonCircle = LUI.UIImage.new()
    Widget.ButtonCircle:setLeftRight(true, true, 0, 0)
    Widget.ButtonCircle:setTopBottom(true, true, 0, 0)
    Widget.ButtonCircle:setImage(RegisterImage("blacktransparent"))
    Widget.ButtonCircle:linkToElementModel(Widget, "circle", true, function(ModelRef) 
        Widget.ButtonCircle:setImage( RegisterImage( Engine.GetModelValue( ModelRef ) and "rex_coldwar_ui_dot" or "blacktransparent" ) )
    end)

    Widget:addElement(Widget.ButtonCircle)

    Widget.ButtonFocus = LUI.UIImage.new()
    Widget.ButtonFocus:setLeftRight(true, true, -5, 5)
    Widget.ButtonFocus:setTopBottom(true, true, -5, 5)
    Widget.ButtonFocus:setImage(RegisterImage("rex_coldwar_ui_buttonfocus"))

    Widget:addElement(Widget.ButtonFocus)

    Widget.ButtonRepairBG = LUI.UIImage.new()
    Widget.ButtonRepairBG:setLeftRight(true, true, 4.5, -4.5)
    Widget.ButtonRepairBG:setTopBottom(true, false, 48.5, 53)
	Widget.ButtonRepairBG:setImage(RegisterImage("blacktransparent"))
    Widget.ButtonRepairBG:linkToElementModel(Widget, "repair", true, function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            Widget.ButtonRepairBG:setImage(RegisterImage("rex_coldwar_ui_armory_repairbar_bg"))
        else
            Widget.ButtonRepairBG:setImage(RegisterImage("blacktransparent"))
        end
    end)

    Widget:addElement(Widget.ButtonRepairBG)

    Widget.ButtonRepair = LUI.UIImage.new()
    Widget.ButtonRepair:setLeftRight(true, true, 5.5, -5.5)
    Widget.ButtonRepair:setTopBottom(true, false, 49.5, 52)
	Widget.ButtonRepair:setImage(RegisterImage("blacktransparent"))
	Widget.ButtonRepair:setMaterial(RegisterMaterial("uie_wipe_normal"))
	Widget.ButtonRepair:setShaderVector(1, 0, 0, 0, 0)
	Widget.ButtonRepair:setShaderVector(2, 1, 0, 0, 0)
	Widget.ButtonRepair:setShaderVector(3, 0, 0, 0, 0)
    Widget.ButtonRepair:linkToElementModel(Widget, "repair", true, function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            Widget.ButtonRepair:setImage(RegisterImage("rex_coldwar_ui_armory_repairbar"))
        else
            Widget.ButtonRepair:setImage(RegisterImage("blacktransparent"))
        end
        local shaderW = CoD.GetVectorComponentFromString(Engine.GetModelValue(ModelRef), 1)
        local shaderX = CoD.GetVectorComponentFromString(Engine.GetModelValue(ModelRef), 2)
        local shaderY = CoD.GetVectorComponentFromString(Engine.GetModelValue(ModelRef), 3)
        local shaderZ = CoD.GetVectorComponentFromString(Engine.GetModelValue(ModelRef), 4)
                        
        Widget.ButtonRepair:setShaderVector(0, AdjustStartEnd(0, 1, shaderW, shaderX, shaderY, shaderZ))
    end)

    Widget:addElement(Widget.ButtonRepair)
    
    Widget.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(0.25)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(0)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end,
            GainFocus = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(1)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(1)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end,
            LoseFocus = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(0.25)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(0)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end,
            Focus = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(1)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(1)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end
        },
        GainFocus = {
            DefaultClip = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(1)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(1)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end,
            GainFocus = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(1)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(1)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end,
            Focus = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(1)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(1)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end
        },
        Focus = {
            DefaultClip = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(1)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(1)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end,
            LoseFocus = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(0.25)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(0)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end
        },
        LoseFocus = {
            DefaultClip = function()
                Widget:setupElementClipCounter(2)

                
                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(1)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(1)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end,
            DefaultState = function()
                Widget:setupElementClipCounter(2)


                Widget.ButtonImage:completeAnimation()
                Widget.ButtonImage:setAlpha(0.25)
                Widget.clipFinished(Widget.ButtonImage, {})


                Widget.ButtonFocus:completeAnimation()
                Widget.ButtonFocus:setAlpha(0)
                Widget.clipFinished(Widget.ButtonFocus, {})
            end
        }
    }

    LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function(Sender)
        Sender.ButtonLocked:close()
        Sender.ButtonImage:close()
        Sender.ButtonCircle:close()
        Sender.ButtonFocus:close()
        Sender.ButtonRepairBG:close()
        Sender.ButtonRepair:close()
    end)

    if PostLoadFunc then
        PostLoadFunc(Widget, InstanceRef, HudRef)
    end

    return Widget
end