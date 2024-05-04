CoD.Menu_TabBar_ListItem = InheritFrom(LUI.UIElement)

local PostLoadFunc = function(Widget, InstanceRef, HudRef)
	Widget:setHandleMouse(true)
end

CoD.Menu_TabBar_ListItem.new = function(HudRef, InstanceRef)

    local Widget = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc(Widget, InstanceRef)
    end

    Widget:setUseStencil(false)
    Widget:setClass(CoD.Menu_TabBar_ListItem)
    Widget.id = "Menu_TabBar_ListItem"
    Widget.soundSet = "default"
    Widget:setLeftRight(true, false, 0, 128.5)
    Widget:setTopBottom(true, false, 0, 20.5)
    Widget.anyChildUsesUpdateState = true

    Widget.TabImage = LUI.UIImage.new()
    Widget.TabImage:setLeftRight(true, true, 0, 0)
    Widget.TabImage:setTopBottom(true, true, 0, 0)
    Widget.TabImage:setImage( RegisterImage( "rex_coldwar_ui_armory_tab" ) )

    Widget:addElement(Widget.TabImage)

	Widget.TabText = LUI.UIText.new()
	Widget.TabText:setLeftRight(true, true, 0, 0)
	Widget.TabText:setTopBottom(true, true, 0, 0)
    Widget.TabText:setTTF("fonts/MaximaTOTBold-Regular.ttf")
    Widget.TabText:setScale(0.6)
	Widget.TabText:linkToElementModel(Widget, "tabName", true, function(ModelRef)
		if Engine.GetModelValue(ModelRef) then
			Widget.TabText:setText(Engine.Localize(Engine.GetModelValue(ModelRef)))
		end
	end)

	Widget:addElement(Widget.TabText)

    Widget.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Widget:setupElementClipCounter(2)


                Widget.TabImage:completeAnimation()
                Widget.TabImage:setAlpha(0)
                Widget.clipFinished(Widget.TabImage, {})


                Widget.TabText:completeAnimation()
                Widget.TabText:setRGB(1,1,1)
                Widget.clipFinished(Widget.TabText, {})
            end,
            Active = function()
                Widget:setupElementClipCounter(2)


                Widget.TabImage:completeAnimation()
                Widget.TabImage:setAlpha(1)
                Widget.clipFinished(Widget.TabImage, {})


                Widget.TabText:completeAnimation()
                Widget.TabText:setRGB(0,0,0)
                Widget.clipFinished(Widget.TabText, {})
            end,
            GainActive = function()
                Widget:setupElementClipCounter(2)


                Widget.TabImage:completeAnimation()
                Widget.TabImage:setAlpha(1)
                Widget.clipFinished(Widget.TabImage, {})


                Widget.TabText:completeAnimation()
                Widget.TabText:setRGB(0,0,0)
                Widget.clipFinished(Widget.TabText, {})
            end,
            LoseActive = function()
                Widget:setupElementClipCounter(2)


                Widget.TabImage:completeAnimation()
                Widget.TabImage:setAlpha(0)
                Widget.clipFinished(Widget.TabImage, {})


                Widget.TabText:completeAnimation()
                Widget.TabText:setRGB(1,1,1)
                Widget.clipFinished(Widget.TabText, {})
            end,
            Over = function()
                Widget:setupElementClipCounter(2)


                Widget.TabImage:completeAnimation()
                Widget.TabImage:setAlpha(1)
                Widget.clipFinished(Widget.TabImage, {})


                Widget.TabText:completeAnimation()
                Widget.TabText:setRGB(1,1,1)
                Widget.clipFinished(Widget.TabText, {})
            end,
            GainOver = function()
                Widget:setupElementClipCounter(2)


                Widget.TabImage:completeAnimation()
                Widget.TabImage:setAlpha(1)
                Widget.clipFinished(Widget.TabImage, {})


                Widget.TabText:completeAnimation()
                Widget.TabText:setRGB(0,0,0)
                Widget.clipFinished(Widget.TabText, {})
            end,
            LoseOver = function()
                Widget:setupElementClipCounter(2)


                Widget.TabImage:completeAnimation()
                Widget.TabImage:setAlpha(0)
                Widget.clipFinished(Widget.TabImage, {})


                Widget.TabText:completeAnimation()
                Widget.TabText:setRGB(1,1,1)
                Widget.clipFinished(Widget.TabText, {})
            end
        }
    }

    LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function (Sender)
        Sender.TabImage:close()
        Sender.TabText:close()
    end)

    if PostLoadFunc then
        PostLoadFunc(Widget, InstanceRef, HudRef)
    end

    return Widget
end