require("ui.uieditor.widgets.HUD.ZM_Panels.ZmPanel_RndExt")
require("ui.uieditor.widgets.REX.ColdWar.Round.ColdWarZmRndDigits")
require("ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Flsh1")
require("ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2Ext")
require("ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2")

CoD.ColdWarZmRnd = InheritFrom(LUI.UIElement)
CoD.ColdWarZmRnd.new = function(HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(Widget, InstanceRef)
	end

	Widget:setUseStencil(false)
	Widget:setClass(CoD.ColdWarZmRnd)
	Widget.id = "ColdWarZmRnd"
	Widget.soundSet = "HUD"
	Widget:setLeftRight(true, false, 0, 224)
	Widget:setTopBottom(true, false, 0, 200)
	Widget.anyChildUsesUpdateState = true

	Widget.Panel = CoD.ZmPanel_RndExt.new(HudRef, InstanceRef)
	Widget.Panel:setLeftRight(true, false, 0, 224)
	Widget.Panel:setTopBottom(true, false, 0, 200)
	Widget.Panel:setRGB(0.61, 0.61, 0.61)
	Widget.Panel:setAlpha(0)
	Widget:addElement(Widget.Panel)
	
	Widget.RndDigits = CoD.ColdWarZmRndDigits.new(HudRef, InstanceRef)
	Widget.RndDigits:setLeftRight(true, false, 44, 150)
	Widget.RndDigits:setTopBottom(true, false, 84, 164)
	Widget:addElement(Widget.RndDigits)
	
	Widget.RndDigits:linkToElementModel(Widget, nil, false, function(ModelRef)
		Widget.RndDigits:setModel(ModelRef, InstanceRef)
	end)

	Widget.Mrk1Def = LUI.UIImage.new()
	Widget.Mrk1Def:setLeftRight(true, false, 40, 72)
	Widget.Mrk1Def:setTopBottom(true, false, 84, 172)
	Widget.Mrk1Def:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk1def"))
	Widget:addElement(Widget.Mrk1Def)
	
	Widget.Mrk2Def = LUI.UIImage.new()
	Widget.Mrk2Def:setLeftRight(true, false, 65, 89)
	Widget.Mrk2Def:setTopBottom(true, false, 75, 163)
	Widget.Mrk2Def:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk2def"))
	Widget:addElement(Widget.Mrk2Def)
	
	Widget.Mrk3Def = LUI.UIImage.new()
	Widget.Mrk3Def:setLeftRight(true, false, 85, 109)
	Widget.Mrk3Def:setTopBottom(true, false, 80, 168)
	Widget.Mrk3Def:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk3def"))
	Widget:addElement(Widget.Mrk3Def)
	
	Widget.Mrk4Def = LUI.UIImage.new()
	Widget.Mrk4Def:setLeftRight(true, false, 105, 129)
	Widget.Mrk4Def:setTopBottom(true, false, 80, 152)
	Widget.Mrk4Def:setAlpha(0)
	Widget.Mrk4Def:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk4def"))
	Widget:addElement(Widget.Mrk4Def)
	
	Widget.Mrk5Def = LUI.UIImage.new()
	Widget.Mrk5Def:setLeftRight(true, false, 40, 136)
	Widget.Mrk5Def:setTopBottom(true, false, 88, 160)
	Widget.Mrk5Def:setAlpha(0)
	Widget.Mrk5Def:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk5def"))
	Widget:addElement(Widget.Mrk5Def)
	
	Widget.Mrk1Act = LUI.UIImage.new()
	Widget.Mrk1Act:setLeftRight(true, false, 40, 72)
	Widget.Mrk1Act:setTopBottom(true, false, 84, 172)
	Widget.Mrk1Act:setAlpha(0)
	Widget.Mrk1Act:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk1act"))
	Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
	Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
	Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
	Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
	Widget:addElement(Widget.Mrk1Act)
	
	Widget.Mrk2Act = LUI.UIImage.new()
	Widget.Mrk2Act:setLeftRight(true, false, 65, 89)
	Widget.Mrk2Act:setTopBottom(true, false, 75, 163)
	Widget.Mrk2Act:setAlpha(0)
	Widget.Mrk2Act:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk2act"))
	Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
	Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
	Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
	Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
	Widget:addElement(Widget.Mrk2Act)
	
	Widget.Mrk3Act = LUI.UIImage.new()
	Widget.Mrk3Act:setLeftRight(true, false, 85, 109)
	Widget.Mrk3Act:setTopBottom(true, false, 80, 168)
	Widget.Mrk3Act:setAlpha(0)
	Widget.Mrk3Act:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk3act"))
	Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
	Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
	Widget.Mrk3Act:setShaderVector(2, 1.15, 0, 0, 0)
	Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
	Widget:addElement(Widget.Mrk3Act)
	
	Widget.Mrk4Act = LUI.UIImage.new()
	Widget.Mrk4Act:setLeftRight(true, false, 105, 129)
	Widget.Mrk4Act:setTopBottom(true, false, 80, 152)
	Widget.Mrk4Act:setAlpha(0)
	Widget.Mrk4Act:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk4act"))
	Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
	Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
	Widget.Mrk4Act:setShaderVector(2, 1, 0, 0, 0)
	Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
	Widget:addElement(Widget.Mrk4Act)
	
	Widget.Mrk5Act = LUI.UIImage.new()
	Widget.Mrk5Act:setLeftRight(true, false, 40, 136)
	Widget.Mrk5Act:setTopBottom(true, false, 88, 160)
	Widget.Mrk5Act:setAlpha(0)
	Widget.Mrk5Act:setImage(RegisterImage("uie_t7_zm_hud_rnd_mrk5act"))
	Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
	Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
	Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
	Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.Mrk5Act)
	
	Widget.GlowOrangeOver = LUI.UIImage.new()
	Widget.GlowOrangeOver:setLeftRight(true, false, 43, 152)
	Widget.GlowOrangeOver:setTopBottom(true, false, 104.5, 137.5)
	Widget.GlowOrangeOver:setRGB(1, 0.31, 0)
	Widget.GlowOrangeOver:setAlpha(0)
	Widget.GlowOrangeOver:setZRot(-84)
	Widget.GlowOrangeOver:setImage(RegisterImage("uie_t7_core_hud_mapwidget_panelglow"))
	Widget.GlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.GlowOrangeOver)
	
	Widget.ZmFxFlsh10 = CoD.ZmFx_Flsh1.new(HudRef, InstanceRef)
	Widget.ZmFxFlsh10:setLeftRight(true, false, -57.5, 257.5)
	Widget.ZmFxFlsh10:setTopBottom(true, false, 0, 216)
	Widget.ZmFxFlsh10:setRGB(0, 0, 0)
	Widget.ZmFxFlsh10:setAlpha(0)
	Widget.ZmFxFlsh10:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.ZmFxFlsh10)
	
	Widget.ZmFxSpark2Ext0 = CoD.ZmFx_Spark2Ext.new(HudRef, InstanceRef)
	Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 54, 166)
	Widget.ZmFxSpark2Ext0:setTopBottom(true, false, 12, 180)
	Widget.ZmFxSpark2Ext0:setAlpha(0)
	Widget.ZmFxSpark2Ext0:setZRot(9)
	Widget:addElement(Widget.ZmFxSpark2Ext0)
	
	Widget.ZmFxSpark20 = CoD.ZmFx_Spark2.new(HudRef, InstanceRef)
	Widget.ZmFxSpark20:setLeftRight(true, false, 32, 162)
	Widget.ZmFxSpark20:setTopBottom(true, false, -33, 183)
	Widget.ZmFxSpark20:setAlpha(0)
	Widget.ZmFxSpark20:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget.ZmFxSpark20.Image0:setShaderVector(1, 0, 1.37, 0, 0)
	Widget.ZmFxSpark20.Image00:setShaderVector(1, 0, -0.62, 0, 0)
	Widget:addElement(Widget.ZmFxSpark20)
	
	Widget.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Widget:setupElementClipCounter(16)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(1)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 1.5, 110.5)
                Widget.GlowOrangeOver:setTopBottom(true, false, 107.5, 140.5)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-79)
                Widget.clipFinished(Widget.GlowOrangeOver, {})

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxFlsh10, {})

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 5, 117)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -40, 128)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end,
            Rnd1 = function()
                Widget:setupElementClipCounter(16)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                local function HandleMrk1DefClip(Sender, Event)
                    local function HandleMrk1DefClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 789, false, false, CoD.TweenType.Linear)
                        end
                        Sender:setAlpha(1)
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk1DefClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1320, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk1DefClipStage2)
                    end
                end

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(0)
                HandleMrk1DefClip(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                local function HandleMrk1ActClip(Sender, Event)
                    local function HandleMrk1ActClipStage2(Sender, Event)
                        local function HandleMrk1ActClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1009, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1.25, 0, 0, 0)
                            Sender:setShaderVector(3, 0.21, 0, 0, 0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleMrk1ActClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1209, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleMrk1ActClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk1ActClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 899, false, true, CoD.TweenType.Linear)
                        Sender:setShaderVector(2, 1.25, 0, 0, 0)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk1ActClipStage2)
                    end
                end

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(1)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                HandleMrk1ActClip(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                local function HandleGlowOrangeOverClip(Sender, Event)
                    local function HandleGlowOrangeOverClipStage2(Sender, Event)
                        local function HandleGlowOrangeOverClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1019, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 1.5, 110.5)
                            Sender:setTopBottom(true, false, 107.5, 140.5)
                            Sender:setAlpha(0)
                            Sender:setZRot(-79)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleGlowOrangeOverClipStage3(Sender, Event)
                            return
                        else
                            Sender:beginAnimation("keyframe", 2230, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleGlowOrangeOverClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 889, false, false, CoD.TweenType.Bounce)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage2)
                    end
                end

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 1.5, 110.5)
                Widget.GlowOrangeOver:setTopBottom(true, false, 107.5, 140.5)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-79)
                HandleGlowOrangeOverClip(Widget.GlowOrangeOver, {})

                local function HandleZmFxFlsh10Clip(Sender, Event)
                    local function HandleZmFxFlsh10ClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1110, false, false, CoD.TweenType.Linear)
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
                        Sender:beginAnimation("keyframe", 600, false, false, CoD.TweenType.Linear)
                        Sender:setRGB(0.9, 0.73, 0.68)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxFlsh10ClipStage2)
                    end
                end

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0, 0, 0)
                Widget.ZmFxFlsh10:setAlpha(1)
                HandleZmFxFlsh10Clip(Widget.ZmFxFlsh10, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 199, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setLeftRight(true, false, 17, 129)
                        Sender:setTopBottom(true, false, 19, 187)
                        Sender:setAlpha(0)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 680, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, 17, 129)
                        Sender:setTopBottom(true, false, 19, 187)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 5, 117)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -40, 128)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end
        }, 
        Rnd1 = {
            DefaultClip = function()
                Widget:setupElementClipCounter(16)
                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 1.5, 110.5)
                Widget.GlowOrangeOver:setTopBottom(true, false, 107.5, 140.5)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-79)
                Widget.clipFinished(Widget.GlowOrangeOver, {})

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxFlsh10, {})

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 17, 129)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, 19, 187)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end,
            Rnd2 = function()
                Widget:setupElementClipCounter(16)
                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk1Def, {})

                local function HandleMrk2DefClip(Sender, Event)
                    local function HandleMrk2DefClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 869, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk2DefClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1240, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk2DefClipStage2)
                    end
                end
                
                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(0)
                HandleMrk2DefClip(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                local function HandleMrk2ActClip(Sender, Event)
                    local function HandleMrk2ActClipStage2(Sender, Event)
                        local function HandleMrk2ActClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1009, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1.08, 0, 0, 0)
                            Sender:setShaderVector(3, 0.21, 0, 0, 0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleMrk2ActClipStage3(Sender, Event)
                            return
                        else
                            Sender:beginAnimation("keyframe", 1429, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleMrk2ActClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk2ActClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 680, false, true, CoD.TweenType.Linear)
                        Sender:setShaderVector(2, 1.08, 0, 0, 0)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk2ActClipStage2)
                    end
                end

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(1)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                HandleMrk2ActClip(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                local function HandleGlowOrangeOverClip(Sender, Event)
                    local function HandleGlowOrangeOverClipStage2(Sender, Event)
                        local function HandleGlowOrangeOverClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1019, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 23, 132)
                            Sender:setTopBottom(true, false, 99.5, 132.5)
                            Sender:setAlpha(0)
                            Sender:setZRot(-82)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleGlowOrangeOverClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 2230, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleGlowOrangeOverClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 889, false, false, CoD.TweenType.Bounce)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage2)
                    end
                end

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 23, 132)
                Widget.GlowOrangeOver:setTopBottom(true, false, 99.5, 132.5)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-82)
                HandleGlowOrangeOverClip(Widget.GlowOrangeOver, {})

                local function HandleZmFxFlsh10Clip(Sender, Event)
                    local function HandleZmFxFlsh10ClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1110, false, false, CoD.TweenType.Linear)
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
                        Sender:beginAnimation("keyframe", 600, false, false, CoD.TweenType.Linear)
                        Sender:setRGB(0.9, 0.73, 0.68)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxFlsh10ClipStage2)
                    end
                end

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0, 0, 0)
                Widget.ZmFxFlsh10:setAlpha(1)
                HandleZmFxFlsh10Clip(Widget.ZmFxFlsh10, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 199, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 38, 150)
                            Sender:setTopBottom(true, false, 12, 180)
                            Sender:setAlpha(0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 620, false, true, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, 38, 150)
                            Sender:setTopBottom(true, false, 12, 180)
                            Sender:setAlpha(1)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 59, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, 29.79, 141.79)
                        Sender:setTopBottom(true, false, -44.53, 123.47)
                        Sender:setAlpha(0.45)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 29, 141)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -50, 118)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end
        },
        Rnd2 = {
            DefaultClip = function()
                Widget:setupElementClipCounter(16)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 23, 132)
                Widget.GlowOrangeOver:setTopBottom(true, false, 99.5, 132.5)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-82)
                Widget.clipFinished(Widget.GlowOrangeOver, {})

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxFlsh10, {})

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 38, 150)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, 12, 180)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
	        end,
            Rnd3 = function()
                Widget:setupElementClipCounter(15)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk2Def, {})

                local function HandleMrk3DefClip(Sender, Event)
                    local function HandleMrk3DefClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 869, false, false, CoD.TweenType.Linear)
                        end
                        
                        Sender:setAlpha(1)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk3DefClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1240, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk3DefClipStage2)
                    end
                end

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(0)
                HandleMrk3DefClip(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                local function HandleMrk3ActClip(Sender, Event)
                    local function HandleMrk3ActClipStage2(Sender, Event)
                        local function HandleMrk3ActClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1.15, 0, 0, 0)
                            Sender:setShaderVector(3, 0.26, 0, 0, 0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleMrk3ActClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1439, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleMrk3ActClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk3ActClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 680, false, true, CoD.TweenType.Linear)
                        Sender:setShaderVector(2, 1.15, 0, 0, 0)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk3ActClipStage2)
                    end
                end

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(1)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                HandleMrk3ActClip(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                local function HandleGlowOrangeOverClip(Sender, Event)
                    local function HandleGlowOrangeOverClipStage2(Sender, Event)
                        local function HandleGlowOrangeOverClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1019, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 43, 152)
                            Sender:setTopBottom(true, false, 104.5, 137.5)
                            Sender:setAlpha(0)
                            Sender:setZRot(-84)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleGlowOrangeOverClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 2230, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleGlowOrangeOverClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 889, false, false, CoD.TweenType.Bounce)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage2)
                    end
                end

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 43, 152)
                Widget.GlowOrangeOver:setTopBottom(true, false, 104.5, 137.5)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-84)
                HandleGlowOrangeOverClip(Widget.GlowOrangeOver, {})

                local function HandleZmFxFlsh10Clip(Sender, Event)
                    local function HandleZmFxFlsh10ClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1110, false, false, CoD.TweenType.Linear)
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
                        Sender:beginAnimation("keyframe", 600, false, false, CoD.TweenType.Linear)
                        Sender:setRGB(0.9, 0.73, 0.68)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxFlsh10ClipStage2)
                    end
                end

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0, 0, 0)
                Widget.ZmFxFlsh10:setAlpha(1)
                HandleZmFxFlsh10Clip(Widget.ZmFxFlsh10, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 199, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 54, 166)
                            Sender:setTopBottom(true, false, 12, 180)
                            Sender:setAlpha(0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 620, false, true, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, 54, 166)
                            Sender:setTopBottom(true, false, 12, 180)
                            Sender:setAlpha(1)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 59, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, 49.44, 161.44)
                        Sender:setTopBottom(true, false, -43.62, 124.38)
                        Sender:setAlpha(0.45)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 49, 161)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -49, 119)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})
	        end
        }, 
        Rnd3 = {
            DefaultClip = function()
                Widget:setupElementClipCounter(15)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 1.15, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 43, 152)
                Widget.GlowOrangeOver:setTopBottom(true, false, 104.5, 137.5)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-84)
                Widget.clipFinished(Widget.GlowOrangeOver, {})
                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxFlsh10, {})

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 54, 166)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, 12, 180)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext0, {})
            end, 
            Rnd4 = function()
                Widget:setupElementClipCounter(16)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk3Def, {})

                local function HandleMrk4DefClip(Sender, Event)
                    local function HandleMrk4DefClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 869, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk4DefClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1240, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk4DefClipStage2)
                    end
                end

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(0)
                HandleMrk4DefClip(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 1.15, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                local function HandleMrk4ActClip(Sender, Event)
                    local function HandleMrk4ActClipStage2(Sender, Event)
                        local function HandleMrk4ActClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1.12, 0, 0, 0)
                            Sender:setShaderVector(3, 0.35, 0, 0, 0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleMrk4ActClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1439, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleMrk4ActClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk4ActClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 680, false, false, CoD.TweenType.Linear)
                        Sender:setShaderVector(2, 1.12, 0, 0, 0)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk4ActClipStage2)
                    end
                end

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(1)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                HandleMrk4ActClip(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                local function HandleGlowOrangeOverClip(Sender, Event)
                    local function HandleGlowOrangeOverClipStage2(Sender, Event)
                        local function HandleGlowOrangeOverClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1019, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 76, 160)
                            Sender:setTopBottom(true, false, 95, 128)
                            Sender:setAlpha(0)
                            Sender:setZRot(-93)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleGlowOrangeOverClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 2230, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleGlowOrangeOverClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 889, false, false, CoD.TweenType.Bounce)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage2)
                    end
                end

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 76, 160)
                Widget.GlowOrangeOver:setTopBottom(true, false, 95, 128)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-93)
                HandleGlowOrangeOverClip(Widget.GlowOrangeOver, {})

                local function HandleZmFxFlsh10Clip(Sender, Event)
                    local function HandleZmFxFlsh10ClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1110, false, false, CoD.TweenType.Linear)
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
                        Sender:beginAnimation("keyframe", 600, false, false, CoD.TweenType.Linear)
                        Sender:setRGB(0.9, 0.73, 0.68)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxFlsh10ClipStage2)
                    end
                end

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0, 0, 0)
                Widget.ZmFxFlsh10:setAlpha(1)
                HandleZmFxFlsh10Clip(Widget.ZmFxFlsh10, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 199, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 71.5, 183.5)
                            Sender:setTopBottom(true, false, -4, 164)
                            Sender:setAlpha(0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 620, false, true, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, 71.5, 183.5)
                            Sender:setTopBottom(true, false, -4, 164)
                            Sender:setAlpha(1)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 59, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, 73.78, 185.78)
                        Sender:setTopBottom(true, false, -45.03, 122.97)
                        Sender:setAlpha(0.45)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 74, 186)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -49, 119)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
	        end
        }, 
        Rnd4 = {
            DefaultClip = function()
                Widget:setupElementClipCounter(16)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 1.15, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.35, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 76, 160)
                Widget.GlowOrangeOver:setTopBottom(true, false, 95, 128)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-93)
                Widget.clipFinished(Widget.GlowOrangeOver, {})

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0, 0, 0)
                Widget.ZmFxFlsh10:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxFlsh10, {})

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 71.5, 183.5)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -4, 164)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end,
            Rnd5 = function()
                Widget:setupElementClipCounter(16)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk4Def, {})

                local function HandleMrk5DefClip(Sender, Event)
                    local function HandleMrk5DefClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 869, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk5DefClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1240, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk5DefClipStage2)
                    end
                end

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                HandleMrk5DefClip(Widget.Mrk5Def, {})
                
                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})
                
                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})
                
                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 1.15, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})
                
                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 1.12, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})
                
                local function HandleMrk5ActClip(Sender, Event)
                    local function HandleMrk5ActClipStage2(Sender, Event)
                        local function HandleMrk5ActClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1.15, 0, 0, 0)
                            Sender:setShaderVector(1, 0.22, 0, 0, 0)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:setShaderVector(3, 0, 0, 0, 0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleMrk5ActClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1439, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleMrk5ActClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk5ActClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 680, false, false, CoD.TweenType.Linear)
                        Sender:setShaderVector(0, 1.15, 0, 0, 0)
                        Sender:setShaderVector(1, 0.22, 0, 0, 0)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk5ActClipStage2)
                    end
                end

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(1)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.11, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                HandleMrk5ActClip(Widget.Mrk5Act, {})
                
                local function HandleGlowOrangeOverClip(Sender, Event)
                    local function HandleGlowOrangeOverClipStage2(Sender, Event)
                        local function HandleGlowOrangeOverClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1019, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 20, 158)
                            Sender:setTopBottom(true, false, 107.25, 140.25)
                            Sender:setAlpha(0)
                            Sender:setZRot(-214)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleGlowOrangeOverClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 2230, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleGlowOrangeOverClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 889, false, false, CoD.TweenType.Bounce)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage2)
                    end
                end

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 20, 158)
                Widget.GlowOrangeOver:setTopBottom(true, false, 107.25, 140.25)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-214)
                HandleGlowOrangeOverClip(Widget.GlowOrangeOver, {})
                
                local function HandleZmFxFlsh10Clip(Sender, Event)
                    local function HandleZmFxFlsh10ClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1110, false, false, CoD.TweenType.Linear)
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
                        Sender:beginAnimation("keyframe", 600, false, false, CoD.TweenType.Linear)
                        Sender:setRGB(0.9, 0.73, 0.68)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxFlsh10ClipStage2)
                    end
                end

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0, 0, 0)
                Widget.ZmFxFlsh10:setAlpha(1)
                HandleZmFxFlsh10Clip(Widget.ZmFxFlsh10, {})
                
                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 199, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 85, 197)
                            Sender:setTopBottom(true, false, 8, 176)
                            Sender:setAlpha(0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 620, false, true, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, 85, 197)
                            Sender:setTopBottom(true, false, 8, 176)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 59, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, -0.71, 111.29)
                        Sender:setTopBottom(true, false, -41.24, 126.76)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -9, 103)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -46, 122)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})
                
                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end
        },
        Rnd5 = {
            DefaultClip = function()
                Widget:setupElementClipCounter(16)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(1)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 1.15, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 1.12, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, -0.13, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.11, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 20, 158)
                Widget.GlowOrangeOver:setTopBottom(true, false, 107.25, 140.25)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(-214)
                Widget.clipFinished(Widget.GlowOrangeOver, {})

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0, 0, 0)
                Widget.ZmFxFlsh10:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxFlsh10, {})

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 85, 197)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, 8, 176)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end, 
            Digits = function()
                Widget:setupElementClipCounter(16)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})
                
                local function HandleRndDigitsClip(Sender, Event)
                    local function HandleRndDigitsClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 389, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleRndDigitsClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 310, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleRndDigitsClipStage2)
                    end
                end

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(0)
                HandleRndDigitsClip(Widget.RndDigits, {})
                
                local function HandleMrk1DefClip(Sender, Event)
                    if not Event.interrupted then
                        Sender:beginAnimation("keyframe", 209, false, false, CoD.TweenType.Linear)
                    end

                    Sender:setAlpha(0)

                    if Event.interrupted then
                        Widget.clipFinished(Sender, Event)
                    else
                        Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                    end
                end

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(1)
                HandleMrk1DefClip(Widget.Mrk1Def, {})
                
                local function HandleMrk2DefClip(Sender, Event)
                    local function HandleMrk2DefClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 159, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(0)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk2DefClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 119, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk2DefClipStage2)
                    end
                end
                
                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(1)
                HandleMrk2DefClip(Widget.Mrk2Def, {})
                
                local function HandleMrk3DefClip(Sender, Event)
                    local function HandleMrk3DefClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(0)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk3DefClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 219, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk3DefClipStage2)
                    end
                end

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(1)
                HandleMrk3DefClip(Widget.Mrk3Def, {})
                
                local function HandleMrk4DefClip(Sender, Event)
                    local function HandleMrk4DefClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)
                        end
                        Sender:setAlpha(0)
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk4DefClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 310, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk4DefClipStage2)
                    end
                end

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(1)
                HandleMrk4DefClip(Widget.Mrk4Def, {})
                
                local function HandleMrk5DefClip(Sender, Event)
                    local function HandleMrk5DefClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 170, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(0)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleMrk5DefClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 379, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleMrk5DefClipStage2)
                    end
                end

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(1)
                HandleMrk5DefClip(Widget.Mrk5Def, {})
                
                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})
                
                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})
                
                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 1.15, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})
                
                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 1.12, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})
                
                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, 1.15, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.22, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})
                
                local function HandleGlowOrangeOverClip(Sender, Event)
                    local function HandleGlowOrangeOverClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1320, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setLeftRight(true, false, 25, 163)
                        Sender:setTopBottom(true, false, 58.5, 179.5)
                        Sender:setAlpha(0)
                        Sender:setZRot(0)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleGlowOrangeOverClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 620, false, false, CoD.TweenType.Bounce)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleGlowOrangeOverClipStage2)
                    end
                end

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 25, 163)
                Widget.GlowOrangeOver:setTopBottom(true, false, 58.5, 179.5)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(0)
                HandleGlowOrangeOverClip(Widget.GlowOrangeOver, {})
                
                local function HandleZmFxFlsh10Clip(Sender, Event)
                    local function HandleZmFxFlsh10ClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1110, false, false, CoD.TweenType.Linear)
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
                        Sender:beginAnimation("keyframe", 600, false, false, CoD.TweenType.Linear)
                        Sender:setRGB(0.9, 0.73, 0.68)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxFlsh10ClipStage2)
                    end
                end
                
                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0, 0, 0)
                Widget.ZmFxFlsh10:setAlpha(1)
                HandleZmFxFlsh10Clip(Widget.ZmFxFlsh10, {})
                
                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 199, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, 77, 189)
                            Sender:setTopBottom(true, false, 9, 177)
                            Sender:setAlpha(0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 620, false, true, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, 77, 189)
                            Sender:setTopBottom(true, false, 9, 177)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 59, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, 11.35, 123.35)
                        Sender:setTopBottom(true, false, 8.09, 176.09)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end
                
                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 5, 117)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, 8, 176)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})
                
                local function HandleZmFxSpark20Clip(Sender, Event)
                    local function HandleZmFxSpark20ClipStage2(Sender, Event)
                        local function HandleZmFxSpark20ClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 780, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark20ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 779, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark20ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark20ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 259, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark20ClipStage2)
                    end
                end

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                HandleZmFxSpark20Clip(Widget.ZmFxSpark20, {})
            end
        }, 
        Digits = {
            DefaultClip = function()
                Widget:setupElementClipCounter(16)

                Widget.Panel:completeAnimation()
                Widget.Panel:setAlpha(0)
                Widget.clipFinished(Widget.Panel, {})

                Widget.RndDigits:completeAnimation()
                Widget.RndDigits:setAlpha(1)
                Widget.clipFinished(Widget.RndDigits, {})

                Widget.Mrk1Def:completeAnimation()
                Widget.Mrk1Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk1Def, {})

                Widget.Mrk2Def:completeAnimation()
                Widget.Mrk2Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk2Def, {})

                Widget.Mrk3Def:completeAnimation()
                Widget.Mrk3Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk3Def, {})

                Widget.Mrk4Def:completeAnimation()
                Widget.Mrk4Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk4Def, {})

                Widget.Mrk5Def:completeAnimation()
                Widget.Mrk5Def:setAlpha(0)
                Widget.clipFinished(Widget.Mrk5Def, {})

                Widget.Mrk1Act:completeAnimation()
                Widget.Mrk1Act:setAlpha(0)
                Widget.Mrk1Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk1Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(2, 1.25, 0, 0, 0)
                Widget.Mrk1Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk1Act, {})

                Widget.Mrk2Act:completeAnimation()
                Widget.Mrk2Act:setAlpha(0)
                Widget.Mrk2Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk2Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(2, 1.08, 0, 0, 0)
                Widget.Mrk2Act:setShaderVector(3, 0.21, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk2Act, {})

                Widget.Mrk3Act:completeAnimation()
                Widget.Mrk3Act:setAlpha(0)
                Widget.Mrk3Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk3Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(2, 1.15, 0, 0, 0)
                Widget.Mrk3Act:setShaderVector(3, 0.26, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk3Act, {})

                Widget.Mrk4Act:completeAnimation()
                Widget.Mrk4Act:setAlpha(0)
                Widget.Mrk4Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk4Act:setShaderVector(0, 1, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(1, 0, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(2, 1.12, 0, 0, 0)
                Widget.Mrk4Act:setShaderVector(3, 0.35, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk4Act, {})

                Widget.Mrk5Act:completeAnimation()
                Widget.Mrk5Act:setAlpha(0)
                Widget.Mrk5Act:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.Mrk5Act:setShaderVector(0, 1.15, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(1, 0.22, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(2, 1, 0, 0, 0)
                Widget.Mrk5Act:setShaderVector(3, 0, 0, 0, 0)
                Widget.clipFinished(Widget.Mrk5Act, {})

                Widget.GlowOrangeOver:completeAnimation()
                Widget.GlowOrangeOver:setLeftRight(true, false, 25, 163)
                Widget.GlowOrangeOver:setTopBottom(true, false, 58.5, 179.5)
                Widget.GlowOrangeOver:setAlpha(0)
                Widget.GlowOrangeOver:setZRot(0)
                Widget.clipFinished(Widget.GlowOrangeOver, {})

                Widget.ZmFxFlsh10:completeAnimation()
                Widget.ZmFxFlsh10:setRGB(0, 0, 0)
                Widget.ZmFxFlsh10:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxFlsh10, {})

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, 77, 189)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, 9, 177)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark20:completeAnimation()
                Widget.ZmFxSpark20:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark20, {})
            end
        }
    }
    
    Widget.StateTable = {
        {
            stateName = "Rnd1",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsSelfModelValueEqualTo(ItemRef, InstanceRef, "roundsPlayed", Engine.GetGametypeSetting("startRound") + 1)
            end
        },
        {
            stateName = "Rnd2",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsSelfModelValueEqualTo(ItemRef, InstanceRef, "roundsPlayed", Engine.GetGametypeSetting("startRound") + 2)
            end
        },
        {
            stateName = "Rnd3",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsSelfModelValueEqualTo(ItemRef, InstanceRef, "roundsPlayed", Engine.GetGametypeSetting("startRound") + 3)
            end
        },
        {
            stateName = "Rnd4",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsSelfModelValueEqualTo(ItemRef, InstanceRef, "roundsPlayed", Engine.GetGametypeSetting("startRound") + 4)
            end
        },
        {
            stateName = "Rnd5",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsSelfModelValueEqualTo(ItemRef, InstanceRef, "roundsPlayed", Engine.GetGametypeSetting("startRound") + 5)
            end
        },
        {
            stateName = "Digits",
            condition = function(HudRef, ItemRef, UpdateTable)
                return IsSelfModelValueGreaterThanOrEqualTo(ItemRef, InstanceRef, "roundsPlayed", Engine.GetGametypeSetting("startRound") + 6)
            end
        }
    }
	Widget:mergeStateConditions(Widget.StateTable)

	Widget:linkToElementModel(Widget, "roundsPlayed", true, function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "roundsPlayed"})
	end)

	LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function(Sender)
		Sender.Panel:close()
		Sender.RndDigits:close()
		Sender.ZmFxFlsh10:close()
		Sender.ZmFxSpark2Ext0:close()
		Sender.ZmFxSpark20:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(Widget, InstanceRef, HudRef)
	end

	return Widget
end