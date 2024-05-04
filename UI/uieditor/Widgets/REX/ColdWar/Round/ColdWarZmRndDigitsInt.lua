require("ui.uieditor.widgets.REX.ColdWar.Round.ColdWarZmRndDigitWidget")

CoD.ColdWarZmRndDigitsInt = InheritFrom(LUI.UIElement)
CoD.ColdWarZmRndDigitsInt.new = function(HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(Widget, InstanceRef)
	end

	Widget:setUseStencil(false)
	Widget:setClass(CoD.ColdWarZmRndDigitsInt)
	Widget.id = "ColdWarZmRndDigitsInt"
	Widget.soundSet = "HUD"
	Widget:setLeftRight(true, false, 0, 106)
	Widget:setTopBottom(true, false, 0, 80)
	Widget.anyChildUsesUpdateState = true

	Widget.ColdWarZmRndDigitWidget = CoD.ColdWarZmRndDigitWidget.new(HudRef, InstanceRef)
	Widget.ColdWarZmRndDigitWidget:setLeftRight(true, false, 3, 59)
	Widget.ColdWarZmRndDigitWidget:setTopBottom(true, false, 0, 80)
	Widget:addElement(Widget.ColdWarZmRndDigitWidget)
	
	Widget.ColdWarZmRndDigitWidget:linkToElementModel(Widget, nil, false, function(ModelRef)
		Widget.ColdWarZmRndDigitWidget:setModel(ModelRef, InstanceRef)
	end)

	Widget.ColdWarZmRndDigitWidget:linkToElementModel(Widget, "roundsPlayed", true, function(ModelRef)
		PlayClipOnElement(Widget, {elementName = "ColdWarZmRndDigitWidget", clipName = "DefaultClip"}, InstanceRef)
	end)

	Widget.ColdWarZmRndDigitWidget:linkToElementModel(Widget.ColdWarZmRndDigitWidget, "roundsPlayed", true, function(ModelRef)
		HudRef:updateElementState(Widget.ColdWarZmRndDigitWidget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "roundsPlayed"})
	end)

    Widget.ColdWarZmRndDigitWidget.StateTable = {
        {
            stateName = "One",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 1)
            end
        },
        {
            stateName = "Two",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 2)
            end
        },
        {
            stateName = "Three",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 3)
            end
        },
        {
            stateName = "Four",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 4)
            end
        },
        {
            stateName = "Five",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 5)
            end
        },
        {
            stateName = "Six",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 6)
            end
        },
        {
            stateName = "Seven",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 7)
            end
        },
        {
            stateName = "Eight",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 8)
            end
        },
        {
            stateName = "Nine",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 9)
            end
        },
        {
            stateName = "Zero",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundTensDigitEqualTo(ItemRef, InstanceRef, 0)
            end
        }
    }
	Widget.ColdWarZmRndDigitWidget:mergeStateConditions(Widget.ColdWarZmRndDigitWidget.StateTable)

	Widget.ZmRndDigitWidget0 = CoD.ColdWarZmRndDigitWidget.new(HudRef, InstanceRef)
	Widget.ZmRndDigitWidget0:setLeftRight(true, false, 46, 102)
	Widget.ZmRndDigitWidget0:setTopBottom(true, false, 0, 80)
	Widget:addElement(Widget.ZmRndDigitWidget0)
	
	Widget.ZmRndDigitWidget0:linkToElementModel(Widget, nil, false, function(ModelRef)
		Widget.ZmRndDigitWidget0:setModel(ModelRef, InstanceRef)
	end)

	Widget.ZmRndDigitWidget0:linkToElementModel(Widget.ZmRndDigitWidget0, "roundsPlayed", true, function(ModelRef)
		HudRef:updateElementState(Widget.ZmRndDigitWidget0, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "roundsPlayed"})
	end)

    Widget.ZmRndDigitWidget0.StateTable = {
        {
            stateName = "One",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 1)
            end
        },
        {
            stateName = "Two",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 2)
            end
        },
        {
            stateName = "Three",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 3)
            end
        },
        {
            stateName = "Four",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 4)
            end
        },
        {
            stateName = "Five",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 5)
            end
        },
        {
            stateName = "Six",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 6)
            end
        },
        {
            stateName = "Seven",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 7)
            end
        },
        {
            stateName = "Eight",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 8)
            end
        },
        {
            stateName = "Nine",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 9)
            end
        },
        {
            stateName = "Zero",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundOnesDigitEqualTo(ItemRef, InstanceRef, 0)
            end
        }
    }
	Widget.ZmRndDigitWidget0:mergeStateConditions(Widget.ZmRndDigitWidget0.StateTable)

	Widget.ZmRndDigitWidget1 = CoD.ColdWarZmRndDigitWidget.new(HudRef, InstanceRef)
	Widget.ZmRndDigitWidget1:setLeftRight(true, false, -40, 16)
	Widget.ZmRndDigitWidget1:setTopBottom(true, false, 0, 80)
	Widget:addElement(Widget.ZmRndDigitWidget1)
	
	Widget.ZmRndDigitWidget1:linkToElementModel(Widget, nil, false, function(ModelRef)
		Widget.ZmRndDigitWidget1:setModel(ModelRef, InstanceRef)
	end)
    
	Widget.ZmRndDigitWidget1:linkToElementModel(Widget, "roundsPlayed", true, function(ModelRef)
		PlayClipOnElement(Widget, {elementName = "ZmRndDigitWidget1", clipName = "DefaultClip"}, InstanceRef)
	end)

	Widget.ZmRndDigitWidget1:linkToElementModel(Widget.ZmRndDigitWidget1, "roundsPlayed", true, function(ModelRef)
		HudRef:updateElementState(Widget.ZmRndDigitWidget1, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "roundsPlayed"})
	end)

    Widget.ZmRndDigitWidget1.StateTable = {
        {
            stateName = "One",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 1)
            end
        },
        {
            stateName = "Two",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 2)
            end
        },
        {
            stateName = "Three",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 3)
            end
        },
        {
            stateName = "Four",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 4)
            end
        },
        {
            stateName = "Five",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 5)
            end
        },
        {
            stateName = "Six",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 6)
            end
        },
        {
            stateName = "Seven",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 7)
            end
        },
        {
            stateName = "Eight",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 8)
            end
        },
        {
            stateName = "Nine",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 9)
            end
        },
        {
            stateName = "Zero",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsZombieRoundHundredsDigitEqualTo(ItemRef, InstanceRef, 0)
            end
        }
    }
	Widget.ZmRndDigitWidget1:mergeStateConditions(Widget.ZmRndDigitWidget1.StateTable)

	Widget.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Widget:setupElementClipCounter(3)

                Widget.ColdWarZmRndDigitWidget:completeAnimation()
                Widget.ColdWarZmRndDigitWidget:setLeftRight(true, false, 3, 59)
                Widget.ColdWarZmRndDigitWidget:setTopBottom(true, false, 0, 80)
                Widget.ColdWarZmRndDigitWidget:setAlpha(0)
                Widget.clipFinished(Widget.ColdWarZmRndDigitWidget, {})

                Widget.ZmRndDigitWidget0:completeAnimation()
                Widget.ZmRndDigitWidget0:setLeftRight(true, false, 46, 102)
                Widget.ZmRndDigitWidget0:setTopBottom(true, false, 0, 80)
                Widget.ZmRndDigitWidget0:setAlpha(1)
                Widget.clipFinished(Widget.ZmRndDigitWidget0, {})

                Widget.ZmRndDigitWidget1:completeAnimation()
                Widget.ZmRndDigitWidget1:setLeftRight(true, false, -40, 16)
                Widget.ZmRndDigitWidget1:setTopBottom(true, false, 0, 80)
                Widget.ZmRndDigitWidget1:setAlpha(0)
                Widget.clipFinished(Widget.ZmRndDigitWidget1, {})
	        end
        }, 
        Triple = {
            DefaultClip = function()
                Widget:setupElementClipCounter(3)

                Widget.ColdWarZmRndDigitWidget:completeAnimation()
                Widget.ColdWarZmRndDigitWidget:setLeftRight(true, false, 43, 99)
                Widget.ColdWarZmRndDigitWidget:setTopBottom(true, false, 0, 80)
                Widget.ColdWarZmRndDigitWidget:setAlpha(1)
                Widget.clipFinished(Widget.ColdWarZmRndDigitWidget, {})

                Widget.ZmRndDigitWidget0:completeAnimation()
                Widget.ZmRndDigitWidget0:setLeftRight(true, false, 86, 142)
                Widget.ZmRndDigitWidget0:setTopBottom(true, false, 0, 80)
                Widget.ZmRndDigitWidget0:setAlpha(1)
                Widget.clipFinished(Widget.ZmRndDigitWidget0, {})

                Widget.ZmRndDigitWidget1:completeAnimation()
                Widget.ZmRndDigitWidget1:setLeftRight(true, false, 0, 56)
                Widget.ZmRndDigitWidget1:setTopBottom(true, false, 0, 80)
                Widget.ZmRndDigitWidget1:setAlpha(1)
                Widget.clipFinished(Widget.ZmRndDigitWidget1, {})
	        end
        }, 
        Double = {
            DefaultClip = function()
                Widget:setupElementClipCounter(3)

                Widget.ColdWarZmRndDigitWidget:completeAnimation()
                Widget.ColdWarZmRndDigitWidget:setLeftRight(true, false, 3, 59)
                Widget.ColdWarZmRndDigitWidget:setTopBottom(true, false, 0, 80)
                Widget.ColdWarZmRndDigitWidget:setAlpha(1)
                Widget.clipFinished(Widget.ColdWarZmRndDigitWidget, {})

                Widget.ZmRndDigitWidget0:completeAnimation()
                Widget.ZmRndDigitWidget0:setLeftRight(true, false, 46, 102)
                Widget.ZmRndDigitWidget0:setTopBottom(true, false, 0, 80)
                Widget.ZmRndDigitWidget0:setAlpha(1)
                Widget.clipFinished(Widget.ZmRndDigitWidget0, {})

                Widget.ZmRndDigitWidget1:completeAnimation()
                Widget.ZmRndDigitWidget1:setLeftRight(true, false, -40, 16)
                Widget.ZmRndDigitWidget1:setTopBottom(true, false, 0, 80)
                Widget.ZmRndDigitWidget1:setAlpha(0)
                Widget.clipFinished(Widget.ZmRndDigitWidget1, {})
	        end
        }
    }

	LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function(Sender)
		Sender.ColdWarZmRndDigitWidget:close()
		Sender.ZmRndDigitWidget0:close()
		Sender.ZmRndDigitWidget1:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(Widget, InstanceRef, HudRef)
	end

	return Widget
end