require("ui.uieditor.widgets.REX.ColdWar.Revive.CWReviveWidget")
require("ui.uieditor.widgets.REX.ColdWar.Revive.ZM_ReviveClampedArrow")

CoD.CWRevive = InheritFrom(LUI.UIElement)
CoD.CWRevive.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(Widget, InstanceRef)
	end
	Widget:setUseStencil(false)
	Widget:setClass(CoD.CWRevive)
	Widget.id = "CWRevive"
	Widget.soundSet = "default"
	Widget:setLeftRight(true, false, 0, 1280)
	Widget:setTopBottom(true, false, 0, 720)
	Widget.anyChildUsesUpdateState = true

	Widget.curReviveStage = Enum.BleedOutStateFlags.BLEEDOUT_STATE_FLAG_BLEEDING_OUT
	Widget.curBleedOut = 1

	local ReviveImage = LUI.UIImage.new()
	ReviveImage:setLeftRight(false, false, -64, 64)
	ReviveImage:setTopBottom(false, false, -64, 64)
	ReviveImage:setRGB(1, 1, 0)
	ReviveImage:setAlpha(0)
	ReviveImage:setImage(RegisterImage("t6waypoint_revive"))
	
	Widget:addElement(ReviveImage)
	Widget.ReviveImage = ReviveImage

	Widget:linkToElementModel(Widget, "bleedOutPercent", true, function (ModelRef)
		if Engine.GetModelValue(ModelRef) then
			local bleedOutPercent = Engine.GetModelValue(ModelRef)
			Widget.curBleedOut = bleedOutPercent
			if Widget.curReviveStage == Enum.BleedOutStateFlags.BLEEDOUT_STATE_FLAG_BLEEDING_OUT then
				ReviveImage:setRGB(1, Widget.curBleedOut, 0)
			end
		end
	end)
	Widget:linkToElementModel(Widget, "stateFlags", true, function (ModelRef)
		if Engine.GetModelValue(ModelRef) then
			local stateFlag = Engine.GetModelValue(ModelRef)
			Widget.curReviveStage = stateFlag
			if Widget.curReviveStage == Enum.BleedOutStateFlags.BLEEDOUT_STATE_FLAG_BEING_REVIVED then
				ReviveImage:setRGB(1, 1, 1)
			else
				ReviveImage:setRGB(1, Widget.curBleedOut, 0)
			end
		end
	end)

	Widget.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				Widget:setupElementClipCounter(1)

				Widget.ReviveImage:completeAnimation()
                Widget.ReviveImage:setAlpha(0)
                Widget.clipFinished(Widget.ReviveImage, {})
            end,
            BleedingOut = function()
            	Widget:setupElementClipCounter(1)

				Widget.ReviveImage:completeAnimation()
                Widget.ReviveImage:setAlpha(1)
                Widget.clipFinished(Widget.ReviveImage, {})
            end,
            Reviving = function()
            	Widget:setupElementClipCounter(1)

				Widget.ReviveImage:completeAnimation()
                Widget.ReviveImage:setAlpha(1)
                Widget.clipFinished(Widget.ReviveImage, {})
            end
		},
		BleedingOut = {
			DefaultClip = function()
				Widget:setupElementClipCounter(1)

            	Widget.ReviveImage:completeAnimation()
                Widget.ReviveImage:setAlpha(1)
                Widget.clipFinished(Widget.ReviveImage, {})

                Widget.nextClip = "DefaultClip"
            end
		},
		Reviving = {
			DefaultClip = function()
				Widget:setupElementClipCounter(1)

            	Widget.ReviveImage:completeAnimation()
                Widget.ReviveImage:setAlpha(1)
                Widget.clipFinished(Widget.ReviveImage, {})

                Widget.nextClip = "DefaultClip"
            end
		}
	}

	Widget:mergeStateConditions({
		{
            stateName = "BleedingOut",
            condition = function(HudRef, ItemRef, UpdateTable)
                local IsBleedOutVisible = IsBleedOutVisible(ItemRef, InstanceRef)
                if IsBleedOutVisible then
                	return IsSelfModelValueEnumBitSet(ItemRef, InstanceRef, "stateFlags", Enum.BleedOutStateFlags.BLEEDOUT_STATE_FLAG_BLEEDING_OUT)
                end
                return IsBleedOutVisible
            end
        },
        {
            stateName = "Reviving",
            condition = function(HudRef, ItemRef, UpdateTable)
            	local IsBleedOutVisible = IsBleedOutVisible(ItemRef, InstanceRef)
                if IsBleedOutVisible then
                	return IsSelfModelValueEnumBitSet(ItemRef, InstanceRef, "stateFlags", Enum.BleedOutStateFlags.BLEEDOUT_STATE_FLAG_BEING_REVIVED)
                end
                return IsBleedOutVisible
            end
        }
	})

	Widget:linkToElementModel(Widget, "stateFlags", true, function (ModelRef)
		HudRef:updateElementState(Widget, 
			{
				name = "model_validation", 
				menu = HudRef, 
				modelValue = Engine.GetModelValue(ModelRef), 
				modelName = "stateFlags"
			})
	end)

	Widget:linkToElementModel(Widget, "bleedOutPercent", true, function (ModelRef)
		HudRef:updateElementState(Widget, 
			{
				name = "model_validation", 
				menu = HudRef, 
				modelValue = Engine.GetModelValue(ModelRef), 
				modelName = "bleedOutPercent"
			})
	end)
	
	if PostLoadFunc then
		PostLoadFunc(Widget, InstanceRef, HudRef)
	end

	return Widget
end

