require("ui.uieditor.widgets.REX.ColdWar.Round.ColdWarZmRndDigitsInt")
require("ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Flsh1")
require("ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2")

CoD.ColdWarZmRndDigits = InheritFrom(LUI.UIElement)
CoD.ColdWarZmRndDigits.new = function(HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(Widget, InstanceRef)
	end

	Widget:setUseStencil(false)
	Widget:setClass(CoD.ColdWarZmRndDigits)
	Widget.id = "ColdWarZmRndDigits"
	Widget.soundSet = "HUD"
	Widget:setLeftRight(true, false, 0, 106)
	Widget:setTopBottom(true, false, 0, 80)
	Widget.anyChildUsesUpdateState = true

	Widget.DigitsInt = CoD.ColdWarZmRndDigitsInt.new(HudRef, InstanceRef)
	Widget.DigitsInt:setLeftRight(true, false, 0, 106)
	Widget.DigitsInt:setTopBottom(true, false, 0, 80)
	Widget.DigitsInt:setZRot(-10)
	Widget:addElement(Widget.DigitsInt)
	
	Widget.DigitsInt:linkToElementModel(Widget, nil, false, function(ModelRef)
		Widget.DigitsInt:setModel(ModelRef, InstanceRef)
	end)

	Widget.DigitsInt:linkToElementModel(Widget.DigitsInt, "roundsPlayed", true, function(ModelRef)
		HudRef:updateElementState(Widget.DigitsInt, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "roundsPlayed"})
	end)

    Widget.DigitsInt.StateTable = {
        {
            stateName = "Triple",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsSelfModelValueGreaterThanOrEqualTo(ItemRef, InstanceRef, "roundsPlayed", Engine.GetGametypeSetting("startRound") + 100)
            end
        },
        {
            stateName = "Double",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsSelfModelValueGreaterThanOrEqualTo(ItemRef, InstanceRef, "roundsPlayed", Engine.GetGametypeSetting("startRound") + 10)
            end
        }
    }
	Widget.DigitsInt:mergeStateConditions(Widget.DigitsInt.StateTable)

	Widget.DigitsOverlay = CoD.ColdWarZmRndDigitsInt.new(HudRef, InstanceRef)
	Widget.DigitsOverlay:setLeftRight(true, false, 0, 106)
	Widget.DigitsOverlay:setTopBottom(true, false, 0, 80)
	Widget.DigitsOverlay:setAlpha(0)
	Widget.DigitsOverlay:setZRot(-19)
	Widget.DigitsOverlay:setZoom(52)
	Widget.DigitsOverlay:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.DigitsOverlay)
	
	Widget.GlowOrangeOver = LUI.UIImage.new()
	Widget.GlowOrangeOver:setLeftRight(true, false, -16, 122)
	Widget.GlowOrangeOver:setTopBottom(true, false, -24.5, 96.5)
	Widget.GlowOrangeOver:setRGB(1, 0.31, 0)
	Widget.GlowOrangeOver:setAlpha(0)
	Widget.GlowOrangeOver:setImage(RegisterImage("uie_t7_core_hud_mapwidget_panelglow"))
	Widget.GlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.GlowOrangeOver)
	
	Widget.ZmFxFlsh10 = CoD.ZmFx_Flsh1.new(HudRef, InstanceRef)
	Widget.ZmFxFlsh10:setLeftRight(true, false, -67.5, 173.5)
	Widget.ZmFxFlsh10:setTopBottom(true, false, -27.5, 107.5)
	Widget.ZmFxFlsh10:setRGB(0, 0, 0)
	Widget.ZmFxFlsh10:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.ZmFxFlsh10)
	
	Widget.ZmFxSpark20 = CoD.ZmFx_Spark2.new(HudRef, InstanceRef)
	Widget.ZmFxSpark20:setLeftRight(true, false, -12, 118)
	Widget.ZmFxSpark20:setTopBottom(true, false, -102, 114)
	Widget.ZmFxSpark20:setRGB(0.65, 0, 0)
	Widget.ZmFxSpark20:setAlpha(0)
	Widget.ZmFxSpark20:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget.ZmFxSpark20.Image0:setShaderVector(1, 0, 1.37, 0, 0)
	Widget.ZmFxSpark20.Image00:setShaderVector(1, 0, -0.62, 0, 0)
	Widget:addElement(Widget.ZmFxSpark20)
	
	Widget.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Widget:setupElementClipCounter(5)

                Widget.DigitsInt:completeAnimation()
                Widget.DigitsInt:setAlpha(1)
                Widget.DigitsInt:setZRot(-10)
                Widget.DigitsInt:setZoom(0)
                Widget.clipFinished(Widget.DigitsInt, {})

                Widget.DigitsOverlay:completeAnimation()
                Widget.DigitsOverlay:setAlpha(0)
                Widget.DigitsOverlay:setZRot(-19)
                Widget.clipFinished(Widget.DigitsOverlay, {})

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.clipFinished(Widget.GlowOrangeOver, {})

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setAlpha(1)
                Widget.clipFinished(Widget.ZmFxFlsh10, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setLeftRight(true, false, -12, 118)
                Widget.ZmFxSpark20:setTopBottom(true, false, -102, 114)
                Widget.ZmFxSpark20:setRGB(0.65, 0, 0)
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end, 
            Update = function()
                Widget:setupElementClipCounter(5)
                
                Widget.DigitsInt:completeAnimation()
                Widget.DigitsInt:setAlpha(1)
                Widget.DigitsInt:setZRot(-10)
                Widget.DigitsInt:setZoom(25)
                Widget.clipFinished(Widget.DigitsInt, {})

                local function HandleDigitsOverlayClip(Sender, Event)
                    local function HandleDigitsOverlayClipStage2(Sender, Event)
                        local function HandleDigitsOverlayClipStage3(Sender, Event)
                            local function HandleDigitsOverlayClipStage4(Sender, Event)
                                if not Event.interrupted then
                                    Sender:beginAnimation("keyframe", 60, false, false, CoD.TweenType.Linear)
                                end

                                Sender:setAlpha(0)
                                Sender:setZRot(-19)

                                if Event.interrupted then
                                    Widget.clipFinished(Sender, Event)
                                else
                                    Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                end
                            end

                            if Event.interrupted then
                                HandleDigitsOverlayClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 99, false, false, CoD.TweenType.Linear)
                                Sender:setAlpha(0.13)
                                Sender:setZRot(-2)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleDigitsOverlayClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleDigitsOverlayClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 290, false, true, CoD.TweenType.Bounce)
                            Sender:setAlpha(0.36)
                            Sender:setZRot(-17)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleDigitsOverlayClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleDigitsOverlayClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 109, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:setZRot(-7.58)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleDigitsOverlayClipStage2)
                    end
                end

                Widget.DigitsOverlay:completeAnimation()
                Widget.DigitsOverlay:setAlpha(0)
                Widget.DigitsOverlay:setZRot(5)
                HandleDigitsOverlayClip(Widget.DigitsOverlay, {})
                
                local function HandleGlowOrangeOverClip(Sender, Event)
                    local function HandleGlowOrangeOverClipStage2(Sender, Event)
                        local function HandleGlowOrangeOverClipStage3(Sender, Event)
                            local function HandleGlowOrangeOverClipStage4(Sender, Event)
                                local function HandleGlowOrangeOverClipStage5(Sender, Event)
                                    local function HandleGlowOrangeOverClipStage6(Sender, Event)
                                        local function HandleGlowOrangeOverClipStage7(Sender, Event)
                                            if not Event.interrupted then
                                                Sender:beginAnimation("keyframe", 840, false, false, CoD.TweenType.Bounce)
                                            end

                                            Sender:setAlpha(0)

                                            if Event.interrupted then
                                                Widget.clipFinished(Sender, Event)
                                            else
                                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                            end
                                        end

                                        if Event.interrupted then
                                            HandleGlowOrangeOverClipStage7(Sender, Event)
                                            return 
                                        else
                                            Sender:beginAnimation("keyframe", 9, false, false, CoD.TweenType.Linear)
                                            Sender:setAlpha(0.35)
                                            Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage7)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleGlowOrangeOverClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 20, false, false, CoD.TweenType.Linear)
                                        Sender:setAlpha(0.21)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleGlowOrangeOverClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 69, false, false, CoD.TweenType.Linear)
                                    Sender:setAlpha(0.36)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleGlowOrangeOverClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 19, false, false, CoD.TweenType.Linear)
                                Sender:setAlpha(0.39)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleGlowOrangeOverClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 19, false, false, CoD.TweenType.Linear)
                            Sender:setAlpha(0.01)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleGlowOrangeOverClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 19, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage2)
                    end
                end

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setAlpha(0.4)
                HandleGlowOrangeOverClip(Widget.GlowOrangeOver, {})
                
                local function HandleZmFxFlsh10Clip(Sender, Event)
                    local function HandleZmFxFlsh10ClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 680, false, false, CoD.TweenType.Bounce)
                        end
                        
                        Sender:setRGB(0, 0, 0)
                        Sender:setAlpha(1)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxFlsh10ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 319, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxFlsh10ClipStage2)
                    end
                end

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0.9, 0.73, 0.68)
                Widget.ZmFxFlsh10:setAlpha(1)
                HandleZmFxFlsh10Clip(Widget.ZmFxFlsh10, {})
                
                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end
        }
    }

	Widget:subscribeToGlobalModel(InstanceRef, "PerController", "gameScore.roundsPlayed", function(ModelRef)
		PlayClip(Widget, "Update", InstanceRef)
	end)

	LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function(Sender)
		Sender.DigitsInt:close()
		Sender.DigitsOverlay:close()
		Sender.ZmFxFlsh10:close()
		Sender.ZmFxSpark20:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(Widget, InstanceRef, HudRef)
	end

	return Widget
end