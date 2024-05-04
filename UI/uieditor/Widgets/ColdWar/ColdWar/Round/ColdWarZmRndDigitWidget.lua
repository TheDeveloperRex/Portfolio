require("ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2Ext")

CoD.ColdWarZmRndDigitWidget = InheritFrom(LUI.UIElement)
CoD.ColdWarZmRndDigitWidget.new = function(HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(Widget, InstanceRef)
	end

	Widget:setUseStencil(false)
	Widget:setClass(CoD.ColdWarZmRndDigitWidget)
	Widget.id = "ColdWarZmRndDigitWidget"
	Widget.soundSet = "HUD"
	Widget:setLeftRight(true, false, 0, 56)
	Widget:setTopBottom(true, false, 0, 80)

	Widget.Nine = LUI.UIImage.new()
	Widget.Nine:setLeftRight(true, false, 0, 56)
	Widget.Nine:setTopBottom(true, false, 0, 80)
	Widget.Nine:setAlpha(0)
	Widget.Nine:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr9"))
	Widget.Nine:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	Widget:addElement(Widget.Nine)
	
	Widget.NineLight = LUI.UIImage.new()
	Widget.NineLight:setLeftRight(true, false, 0, 56)
	Widget.NineLight:setTopBottom(true, false, 0, 80)
	Widget.NineLight:setAlpha(0)
	Widget.NineLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr9_act"))
	Widget.NineLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.NineLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.NineLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.NineLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.NineLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.NineLight)
	
	Widget.NineGlow = LUI.UIImage.new()
	Widget.NineGlow:setLeftRight(true, false, 0, 56)
	Widget.NineGlow:setTopBottom(true, false, 0, 80)
	Widget.NineGlow:setRGB(1, 0.31, 0)
	Widget.NineGlow:setAlpha(0)
	Widget.NineGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr9_glow"))
	Widget.NineGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.NineGlow)
	
	Widget.Eight = LUI.UIImage.new()
	Widget.Eight:setLeftRight(true, false, 0, 56)
	Widget.Eight:setTopBottom(true, false, 0, 80)
	Widget.Eight:setAlpha(0)
	Widget.Eight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr8"))
	Widget.Eight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	Widget:addElement(Widget.Eight)
	
	Widget.EightLight = LUI.UIImage.new()
	Widget.EightLight:setLeftRight(true, false, 0, 56)
	Widget.EightLight:setTopBottom(true, false, 0, 80)
	Widget.EightLight:setAlpha(0)
	Widget.EightLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr8_act"))
	Widget.EightLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.EightLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.EightLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.EightLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.EightLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.EightLight)
	
	Widget.EightGlow = LUI.UIImage.new()
	Widget.EightGlow:setLeftRight(true, false, 0, 56)
	Widget.EightGlow:setTopBottom(true, false, 0, 80)
	Widget.EightGlow:setRGB(1, 0.31, 0)
	Widget.EightGlow:setAlpha(0)
	Widget.EightGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr8_glow"))
	Widget.EightGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.EightGlow)
	
	Widget.Seven = LUI.UIImage.new()
	Widget.Seven:setLeftRight(true, false, 0, 56)
	Widget.Seven:setTopBottom(true, false, 0, 80)
	Widget.Seven:setAlpha(0)
	Widget.Seven:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr7"))
	Widget.Seven:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	Widget:addElement(Widget.Seven)
	
	Widget.SevenLight = LUI.UIImage.new()
	Widget.SevenLight:setLeftRight(true, false, 0, 56)
	Widget.SevenLight:setTopBottom(true, false, 0, 80)
	Widget.SevenLight:setAlpha(0)
	Widget.SevenLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr7_act"))
	Widget.SevenLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.SevenLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.SevenLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.SevenLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.SevenLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.SevenLight)
	
	Widget.SevenGlow = LUI.UIImage.new()
	Widget.SevenGlow:setLeftRight(true, false, 0, 56)
	Widget.SevenGlow:setTopBottom(true, false, 0, 80)
	Widget.SevenGlow:setRGB(1, 0.31, 0)
	Widget.SevenGlow:setAlpha(0)
	Widget.SevenGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr7_glow"))
	Widget.SevenGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.SevenGlow)
	
	Widget.Six = LUI.UIImage.new()
	Widget.Six:setLeftRight(true, false, 0, 56)
	Widget.Six:setTopBottom(true, false, 0, 80)
	Widget.Six:setAlpha(0)
	Widget.Six:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr6"))
	Widget:addElement(Widget.Six)
	
	Widget.SixLight = LUI.UIImage.new()
	Widget.SixLight:setLeftRight(true, false, 0, 56)
	Widget.SixLight:setTopBottom(true, false, 0, 80)
	Widget.SixLight:setAlpha(0)
	Widget.SixLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr6_act"))
	Widget.SixLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.SixLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.SixLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.SixLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.SixLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.SixLight)
	
	Widget.SixGlow = LUI.UIImage.new()
	Widget.SixGlow:setLeftRight(true, false, 0, 56)
	Widget.SixGlow:setTopBottom(true, false, 0, 80)
	Widget.SixGlow:setRGB(1, 0.31, 0)
	Widget.SixGlow:setAlpha(0)
	Widget.SixGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr6_glow"))
	Widget.SixGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.SixGlow)
	
	Widget.Five = LUI.UIImage.new()
	Widget.Five:setLeftRight(true, false, 0, 56)
	Widget.Five:setTopBottom(true, false, 0, 80)
	Widget.Five:setAlpha(0)
	Widget.Five:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr5"))
	Widget.Five:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	Widget:addElement(Widget.Five)
	
	Widget.FiveLight = LUI.UIImage.new()
	Widget.FiveLight:setLeftRight(true, false, 0, 56)
	Widget.FiveLight:setTopBottom(true, false, 0, 80)
	Widget.FiveLight:setAlpha(0)
	Widget.FiveLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr5_act"))
	Widget.FiveLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.FiveLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.FiveLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.FiveLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.FiveLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.FiveLight)
	
	Widget.FiveGlow = LUI.UIImage.new()
	Widget.FiveGlow:setLeftRight(true, false, 0, 56)
	Widget.FiveGlow:setTopBottom(true, false, 0, 80)
	Widget.FiveGlow:setRGB(1, 0.31, 0)
	Widget.FiveGlow:setAlpha(0)
	Widget.FiveGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr5_glow"))
	Widget.FiveGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.FiveGlow)
	
	Widget.Four = LUI.UIImage.new()
	Widget.Four:setLeftRight(true, false, 0, 56)
	Widget.Four:setTopBottom(true, false, 0, 80)
	Widget.Four:setAlpha(0)
	Widget.Four:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr4"))
	Widget.Four:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	Widget:addElement(Widget.Four)
	
	Widget.FourLight = LUI.UIImage.new()
	Widget.FourLight:setLeftRight(true, false, 0, 56)
	Widget.FourLight:setTopBottom(true, false, 0, 80)
	Widget.FourLight:setAlpha(0)
	Widget.FourLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr4_act"))
	Widget.FourLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.FourLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.FourLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.FourLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.FourLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.FourLight)
	
	Widget.FourGlow = LUI.UIImage.new()
	Widget.FourGlow:setLeftRight(true, false, 0, 56)
	Widget.FourGlow:setTopBottom(true, false, 0, 80)
	Widget.FourGlow:setRGB(1, 0.31, 0)
	Widget.FourGlow:setAlpha(0)
	Widget.FourGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr4_glow"))
	Widget.FourGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.FourGlow)
	
	Widget.Three = LUI.UIImage.new()
	Widget.Three:setLeftRight(true, false, 0, 56)
	Widget.Three:setTopBottom(true, false, 0, 80)
	Widget.Three:setAlpha(0)
	Widget.Three:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr3"))
	Widget.Three:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	Widget:addElement(Widget.Three)
	
	Widget.ThreeLight = LUI.UIImage.new()
	Widget.ThreeLight:setLeftRight(true, false, 0, 56)
	Widget.ThreeLight:setTopBottom(true, false, 0, 80)
	Widget.ThreeLight:setAlpha(0)
	Widget.ThreeLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr3_act"))
	Widget.ThreeLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.ThreeLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.ThreeLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.ThreeLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.ThreeLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.ThreeLight)
	
	Widget.ThreeGlow = LUI.UIImage.new()
	Widget.ThreeGlow:setLeftRight(true, false, 0, 56)
	Widget.ThreeGlow:setTopBottom(true, false, 0, 80)
	Widget.ThreeGlow:setRGB(1, 0.31, 0)
	Widget.ThreeGlow:setAlpha(0)
	Widget.ThreeGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr3_glow"))
	Widget.ThreeGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.ThreeGlow)
	
	Widget.Two = LUI.UIImage.new()
	Widget.Two:setLeftRight(true, false, 0, 56)
	Widget.Two:setTopBottom(true, false, 0, 80)
	Widget.Two:setAlpha(0)
	Widget.Two:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr2"))
	Widget:addElement(Widget.Two)
	
	Widget.TwoLight = LUI.UIImage.new()
	Widget.TwoLight:setLeftRight(true, false, 0, 56)
	Widget.TwoLight:setTopBottom(true, false, 0, 80)
	Widget.TwoLight:setAlpha(0)
	Widget.TwoLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr2_act"))
	Widget.TwoLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.TwoLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.TwoLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.TwoLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.TwoLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.TwoLight)
	
	Widget.TwoGlow = LUI.UIImage.new()
	Widget.TwoGlow:setLeftRight(true, false, 0, 56)
	Widget.TwoGlow:setTopBottom(true, false, 0, 80)
	Widget.TwoGlow:setRGB(1, 0.31, 0)
	Widget.TwoGlow:setAlpha(0)
	Widget.TwoGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr2_glow"))
	Widget.TwoGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.TwoGlow)
	
	Widget.One = LUI.UIImage.new()
	Widget.One:setLeftRight(true, false, 0, 56)
	Widget.One:setTopBottom(true, false, 0, 80)
	Widget.One:setAlpha(0)
	Widget.One:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr1"))
	Widget.One:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	Widget:addElement(Widget.One)
	
	Widget.OneLight = LUI.UIImage.new()
	Widget.OneLight:setLeftRight(true, false, 0, 56)
	Widget.OneLight:setTopBottom(true, false, 0, 80)
	Widget.OneLight:setAlpha(0)
	Widget.OneLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr1_act"))
	Widget.OneLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.OneLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.OneLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.OneLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.OneLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.OneLight)
	
	Widget.OneGlow = LUI.UIImage.new()
	Widget.OneGlow:setLeftRight(true, false, 0, 56)
	Widget.OneGlow:setTopBottom(true, false, 0, 80)
	Widget.OneGlow:setRGB(1, 0.31, 0)
	Widget.OneGlow:setAlpha(0)
	Widget.OneGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr1_glow"))
	Widget.OneGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.OneGlow)
	
	Widget.Zero = LUI.UIImage.new()
	Widget.Zero:setLeftRight(true, false, 0, 56)
	Widget.Zero:setTopBottom(true, false, 0, 80)
	Widget.Zero:setAlpha(0)
	Widget.Zero:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr0"))
	Widget.Zero:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	Widget:addElement(Widget.Zero)
	
	Widget.ZeroLight = LUI.UIImage.new()
	Widget.ZeroLight:setLeftRight(true, false, 0, 56)
	Widget.ZeroLight:setTopBottom(true, false, 0, 80)
	Widget.ZeroLight:setAlpha(0)
	Widget.ZeroLight:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr0_act"))
	Widget.ZeroLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	Widget.ZeroLight:setShaderVector(0, 1, 0, 0, 0)
	Widget.ZeroLight:setShaderVector(1, 0, 0, 0, 0)
	Widget.ZeroLight:setShaderVector(2, 1, 0, 0, 0)
	Widget.ZeroLight:setShaderVector(3, 0, 0, 0, 0)
	Widget:addElement(Widget.ZeroLight)
	
	Widget.ZeroGlow = LUI.UIImage.new()
	Widget.ZeroGlow:setLeftRight(true, false, 0, 56)
	Widget.ZeroGlow:setTopBottom(true, false, 0, 80)
	Widget.ZeroGlow:setRGB(1, 0.31, 0)
	Widget.ZeroGlow:setAlpha(0)
	Widget.ZeroGlow:setImage(RegisterImage("uie_t7_zm_hud_rnd_nmbr0_glow"))
	Widget.ZeroGlow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.ZeroGlow)
	
	Widget.ZmFxSpark2Ext0 = CoD.ZmFx_Spark2Ext.new(HudRef, InstanceRef)
	Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -17.56, 94.44)
	Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -137.29, 30.71)
	Widget.ZmFxSpark2Ext0:setAlpha(0)
	Widget.ZmFxSpark2Ext0:setZRot(9)
	Widget.ZmFxSpark2Ext0:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.ZmFxSpark2Ext0)
	
	Widget.ZmFxSpark2Ext00 = CoD.ZmFx_Spark2Ext.new(HudRef, InstanceRef)
	Widget.ZmFxSpark2Ext00:setLeftRight(true, false, -3.56, 108.44)
	Widget.ZmFxSpark2Ext00:setTopBottom(true, false, -128, 40)
	Widget.ZmFxSpark2Ext00:setAlpha(0)
	Widget.ZmFxSpark2Ext00:setZRot(9)
	Widget.ZmFxSpark2Ext00:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	Widget:addElement(Widget.ZmFxSpark2Ext00)
	
	Widget.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Widget:setupElementClipCounter(0)
	        end
        }, 
        One = {
            DefaultClip = function()
                Widget:setupElementClipCounter(31)

                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                Widget.clipFinished(Widget.Nine, {})

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(0)
                Widget.clipFinished(Widget.NineLight, {})

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                Widget.clipFinished(Widget.NineGlow, {})

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                Widget.clipFinished(Widget.Eight, {})

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(0)
                Widget.clipFinished(Widget.EightLight, {})

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                Widget.clipFinished(Widget.EightGlow, {})

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                Widget.clipFinished(Widget.Seven, {})

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(0)
                Widget.clipFinished(Widget.SevenLight, {})

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                Widget.clipFinished(Widget.SevenGlow, {})

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                Widget.clipFinished(Widget.Six, {})

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(0)
                Widget.clipFinished(Widget.SixLight, {})

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                Widget.clipFinished(Widget.SixGlow, {})

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                Widget.clipFinished(Widget.Five, {})

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(0)
                Widget.clipFinished(Widget.FiveLight, {})

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                Widget.clipFinished(Widget.FiveGlow, {})

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                Widget.clipFinished(Widget.Four, {})

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(0)
                Widget.clipFinished(Widget.FourLight, {})

                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                Widget.clipFinished(Widget.FourGlow, {})

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                Widget.clipFinished(Widget.Three, {})

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(0)
                Widget.clipFinished(Widget.ThreeLight, {})

                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                Widget.clipFinished(Widget.ThreeGlow, {})

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                Widget.clipFinished(Widget.Two, {})

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.clipFinished(Widget.TwoLight, {})

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                Widget.clipFinished(Widget.TwoGlow, {})

                local function HandleOneClip(Sender, Event)
                    local function HandleOneClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1509, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleOneClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1500, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleOneClipStage2)
                    end
                end

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                HandleOneClip(Widget.One, {})

                local function HandleOneLightClip(Sender, Event)
                    local function HandleOneLightClipStage2(Sender, Event)
                        local function HandleOneLightClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 2210, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1.16, 0, 0, 0)
                            Sender:setShaderVector(3, 0.26, 0, 0, 0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleOneLightClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 610, false, false, CoD.TweenType.Linear)
                            Sender:setShaderVector(2, 1.16, 0, 0, 0)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleOneLightClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleOneLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 189, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleOneLightClipStage2)
                    end
                end
                
                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(1)
                Widget.OneLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.OneLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.OneLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.OneLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.OneLight:setShaderVector(3, 0.26, 0, 0, 0)
                HandleOneLightClip(Widget.OneLight, {})

                local function HandleOneGlowClip(Sender, Event)
                    local function HandleOneGlowClipStage2(Sender, Event)
                        local function HandleOneGlowClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1009, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleOneGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1509, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleOneGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleOneGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 490, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleOneGlowClipStage2)
                    end
                end

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                HandleOneGlowClip(Widget.OneGlow, {})

                Widget.Zero:completeAnimation()
                Widget.Zero:setAlpha(0)
                Widget.clipFinished(Widget.Zero, {})

                Widget.ZeroLight:completeAnimation()
                Widget.ZeroLight:setAlpha(0)
                Widget.clipFinished(Widget.ZeroLight, {})

                Widget.ZeroGlow:completeAnimation()
                Widget.ZeroGlow:setAlpha(0)
                Widget.clipFinished(Widget.ZeroGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                if not Event.interrupted then
                                    Sender:beginAnimation("keyframe", 449, false, false, CoD.TweenType.Linear)
                                end

                                Sender:setLeftRight(true, false, -13.56, 98.44)
                                Sender:setTopBottom(true, false, -75.29, 92.71)
                                Sender:setAlpha(0)

                                if Event.interrupted then
                                    Widget.clipFinished(Sender, Event)
                                else
                                    Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 610, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -13.56, 98.44)
                                Sender:setTopBottom(true, false, -75.29, 92.71)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 79, false, false, CoD.TweenType.Linear)
                            Sender:setAlpha(0.8)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 109, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -17.56, 94.44)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -137.29, 30.71)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})
	        end
        },
        Two = {
            DefaultClip = function()
                Widget:setupElementClipCounter(29)
                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                Widget.clipFinished(Widget.Nine, {})

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(0)
                Widget.clipFinished(Widget.NineLight, {})

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                Widget.clipFinished(Widget.NineGlow, {})

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                Widget.clipFinished(Widget.Eight, {})

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(0)
                Widget.clipFinished(Widget.EightLight, {})

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                Widget.clipFinished(Widget.EightGlow, {})

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                Widget.clipFinished(Widget.Seven, {})

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(0)
                Widget.clipFinished(Widget.SevenLight, {})

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                Widget.clipFinished(Widget.SevenGlow, {})

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                Widget.clipFinished(Widget.Six, {})

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(0)
                Widget.clipFinished(Widget.SixLight, {})

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                Widget.clipFinished(Widget.SixGlow, {})

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                Widget.clipFinished(Widget.Five, {})

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(0)
                Widget.clipFinished(Widget.FiveLight, {})

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                Widget.clipFinished(Widget.FiveGlow, {})

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                Widget.clipFinished(Widget.Four, {})

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(0)
                Widget.clipFinished(Widget.FourLight, {})

                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                Widget.clipFinished(Widget.FourGlow, {})

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                Widget.clipFinished(Widget.Three, {})

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(0)
                Widget.clipFinished(Widget.ThreeLight, {})

                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                Widget.clipFinished(Widget.ThreeGlow, {})

                local function HandleTwoClip(Sender, Event)
                    local function HandleTwoClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1519, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleTwoClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1500, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleTwoClipStage2)
                    end
                end

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                HandleTwoClip(Widget.Two, {})

                local function HandleTwoLightClip(Sender, Event)
                    local function HandleTwoLightClipStage2(Sender, Event)
                        local function HandleTwoLightClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:setShaderVector(3, 0.22, 0, 0, 0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleTwoLightClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 810, false, false, CoD.TweenType.Linear)
                            Sender:setAlpha(0.55)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleTwoLightClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleTwoLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleTwoLightClipStage2)
                    end
                end

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.TwoLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.TwoLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.TwoLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.TwoLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.TwoLight:setShaderVector(3, 0.22, 0, 0, 0)
                HandleTwoLightClip(Widget.TwoLight, {})

                local function HandleTwoGlowClip(Sender, Event)
                    local function HandleTwoGlowClipStage2(Sender, Event)
                        local function HandleTwoGlowClipStage3(Sender, Event)
                            local function HandleTwoGlowClipStage4(Sender, Event)
                                if not Event.interrupted then
                                    Sender:beginAnimation("keyframe", 1009, false, false, CoD.TweenType.Linear)
                                end

                                Sender:setAlpha(0)

                                if Event.interrupted then
                                    Widget.clipFinished(Sender, Event)
                                else
                                    Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                end
                            end

                            if Event.interrupted then
                                HandleTwoGlowClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 1379, false, false, CoD.TweenType.Linear)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleTwoGlowClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleTwoGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 430, false, false, CoD.TweenType.Linear)
                            Sender:setAlpha(1)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleTwoGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleTwoGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleTwoGlowClipStage2)
                    end
                end

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                HandleTwoGlowClip(Widget.TwoGlow, {})

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                Widget.clipFinished(Widget.One, {})

                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(0)
                Widget.clipFinished(Widget.OneLight, {})

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                Widget.clipFinished(Widget.OneGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    local function HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        local function HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            local function HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                local function HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    if not Event.interrupted then
                                                        Sender:beginAnimation("keyframe", 359, false, false, CoD.TweenType.Linear)
                                                    end

                                                    Sender:setLeftRight(true, false, -7.56, 104.44)
                                                    Sender:setTopBottom(true, false, -86, 82)
                                                    Sender:setAlpha(0)

                                                    if Event.interrupted then
                                                        Widget.clipFinished(Sender, Event)
                                                    else
                                                        Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                                    end
                                                end

                                                if Event.interrupted then
                                                    HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    return 
                                                else
                                                    Sender:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
                                                    Sender:setLeftRight(true, false, -7.56, 104.44)
                                                    Sender:setTopBottom(true, false, -86, 82)
                                                    Sender:setAlpha(0.7)
                                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage9)
                                                end
                                            end

                                            if Event.interrupted then
                                                HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                return 
                                            else
                                                Sender:beginAnimation("keyframe", 79, false, false, CoD.TweenType.Linear)
                                                Sender:setLeftRight(true, false, -12.56, 99.44)
                                                Sender:setTopBottom(true, false, -82.54, 85.46)
                                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage8)
                                            end
                                        end

                                        if Event.interrupted then
                                            HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            return 
                                        else
                                            Sender:beginAnimation("keyframe", 139, false, false, CoD.TweenType.Linear)
                                            Sender:setLeftRight(true, false, -20.56, 91.44)
                                            Sender:setTopBottom(true, false, -77, 91)
                                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage7)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)
                                        Sender:setLeftRight(true, false, -16.56, 95.44)
                                        Sender:setTopBottom(true, false, -92, 76)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 189, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -11.56, 100.44)
                                    Sender:setTopBottom(true, false, -113, 55)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 159, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -10.56, 101.44)
                                Sender:setTopBottom(true, false, -128, 40)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -19.56, 92.44)
                            Sender:setTopBottom(true, false, -132.29, 35.71)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -29.56, 82.44)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -121.29, 46.71)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark2Ext00:completeAnimation()
                Widget.ZmFxSpark2Ext00:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext00, {})
            end
        },
        Three = {
            DefaultClip = function()
                Widget:setupElementClipCounter(32)

                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                Widget.clipFinished(Widget.Nine, {})

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(0)
                Widget.clipFinished(Widget.NineLight, {})

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                Widget.clipFinished(Widget.NineGlow, {})

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                Widget.clipFinished(Widget.Eight, {})

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(0)
                Widget.clipFinished(Widget.EightLight, {})

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                Widget.clipFinished(Widget.EightGlow, {})

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                Widget.clipFinished(Widget.Seven, {})

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(0)
                Widget.clipFinished(Widget.SevenLight, {})

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                Widget.clipFinished(Widget.SevenGlow, {})

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                Widget.clipFinished(Widget.Six, {})

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(0)
                Widget.clipFinished(Widget.SixLight, {})

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                Widget.clipFinished(Widget.SixGlow, {})

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                Widget.clipFinished(Widget.Five, {})

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(0)
                Widget.clipFinished(Widget.FiveLight, {})

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                Widget.clipFinished(Widget.FiveGlow, {})

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                Widget.clipFinished(Widget.Four, {})

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(0)
                Widget.clipFinished(Widget.FourLight, {})

                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                Widget.clipFinished(Widget.FourGlow, {})

                local function HandleThreeClip(Sender, Event)
                    local function HandleThreeClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1480, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleThreeClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1529, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleThreeClipStage2)
                    end
                end

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                HandleThreeClip(Widget.Three, {})

                local function HandleThreeLightClip(Sender, Event)
                    local function HandleThreeLightClipStage2(Sender, Event)
                        local function HandleThreeLightClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 2000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:setShaderVector(3, 0.21, 0, 0, 0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleThreeLightClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 810, false, false, CoD.TweenType.Linear)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleThreeLightClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleThreeLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleThreeLightClipStage2)
                    end
                end

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(1)
                Widget.ThreeLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.ThreeLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.ThreeLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.ThreeLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.ThreeLight:setShaderVector(3, 0.21, 0, 0, 0)
                HandleThreeLightClip(Widget.ThreeLight, {})

                local function HandleThreeGlowClip(Sender, Event)
                    local function HandleThreeGlowClipStage2(Sender, Event)
                        local function HandleThreeGlowClipStage3(Sender, Event)
                            local function HandleThreeGlowClipStage4(Sender, Event)
                                if not Event.interrupted then
                                    Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                                end

                                Sender:setAlpha(0)

                                if Event.interrupted then
                                    Widget.clipFinished(Sender, Event)
                                else
                                    Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                end
                            end

                            if Event.interrupted then
                                HandleThreeGlowClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 1529, false, false, CoD.TweenType.Linear)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleThreeGlowClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleThreeGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 279, false, false, CoD.TweenType.Linear)
                            Sender:setAlpha(1)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleThreeGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleThreeGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleThreeGlowClipStage2)
                    end
                end
                
                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                HandleThreeGlowClip(Widget.ThreeGlow, {})

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                Widget.clipFinished(Widget.Two, {})

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.clipFinished(Widget.TwoLight, {})

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                Widget.clipFinished(Widget.TwoGlow, {})

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                Widget.clipFinished(Widget.One, {})

                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(0)
                Widget.clipFinished(Widget.OneLight, {})

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                Widget.clipFinished(Widget.OneGlow, {})

                Widget.Zero:completeAnimation()
                Widget.Zero:setAlpha(0)
                Widget.clipFinished(Widget.Zero, {})

                Widget.ZeroLight:completeAnimation()
                Widget.ZeroLight:setAlpha(0)
                Widget.clipFinished(Widget.ZeroLight, {})

                Widget.ZeroGlow:completeAnimation()
                Widget.ZeroGlow:setAlpha(0)
                Widget.clipFinished(Widget.ZeroGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    local function HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        local function HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            local function HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                local function HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    local function HandleZmFxSpark2Ext0ClipStage10(Sender, Event)
                                                        local function HandleZmFxSpark2Ext0ClipStage11(Sender, Event)
                                                            local function HandleZmFxSpark2Ext0ClipStage12(Sender, Event)
                                                                local function HandleZmFxSpark2Ext0ClipStage13(Sender, Event)
                                                                    if not Event.interrupted then
                                                                        Sender:beginAnimation("keyframe", 2240, false, false, CoD.TweenType.Linear)
                                                                    end

                                                                    Sender:setLeftRight(true, false, -19.56, 92.44)
                                                                    Sender:setTopBottom(true, false, -72, 96)
                                                                    Sender:setAlpha(0)

                                                                    if Event.interrupted then
                                                                        Widget.clipFinished(Sender, Event)
                                                                    else
                                                                        Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                                                    end
                                                                end

                                                                if Event.interrupted then
                                                                    HandleZmFxSpark2Ext0ClipStage13(Sender, Event)
                                                                    return 
                                                                else
                                                                    Sender:beginAnimation("keyframe", 470, false, false, CoD.TweenType.Linear)
                                                                    Sender:setLeftRight(true, false, -18.73, 93.27)
                                                                    Sender:setAlpha(0)
                                                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage13)
                                                                end
                                                            end

                                                            if Event.interrupted then
                                                                HandleZmFxSpark2Ext0ClipStage12(Sender, Event)
                                                                return 
                                                            else
                                                                Sender:beginAnimation("keyframe", 79, false, false, CoD.TweenType.Linear)
                                                                Sender:setLeftRight(true, false, -18.56, 93.44)
                                                                Sender:setTopBottom(true, false, -72, 96)
                                                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage12)
                                                            end
                                                        end

                                                        if Event.interrupted then
                                                            HandleZmFxSpark2Ext0ClipStage11(Sender, Event)
                                                            return 
                                                        else
                                                            Sender:beginAnimation("keyframe", 90, false, false, CoD.TweenType.Linear)
                                                            Sender:setLeftRight(true, false, -2.56, 109.44)
                                                            Sender:setTopBottom(true, false, -86, 82)
                                                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage11)
                                                        end
                                                    end

                                                    if Event.interrupted then
                                                        HandleZmFxSpark2Ext0ClipStage10(Sender, Event)
                                                        return 
                                                    else
                                                        Sender:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
                                                        Sender:setLeftRight(true, false, -3.56, 108.44)
                                                        Sender:setTopBottom(true, false, -95, 73)
                                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage10)
                                                    end
                                                end

                                                if Event.interrupted then
                                                    HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    return 
                                                else
                                                    Sender:beginAnimation("keyframe", 109, false, false, CoD.TweenType.Linear)
                                                    Sender:setLeftRight(true, false, -16, 96)
                                                    Sender:setTopBottom(true, false, -103, 65)
                                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage9)
                                                end
                                            end

                                            if Event.interrupted then
                                                HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                return 
                                            else
                                                Sender:beginAnimation("keyframe", 120, false, false, CoD.TweenType.Linear)
                                                Sender:setLeftRight(true, false, -11, 101)
                                                Sender:setTopBottom(true, false, -110, 58)
                                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage8)
                                            end
                                        end

                                        if Event.interrupted then
                                            HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            return 
                                        else
                                            Sender:beginAnimation("keyframe", 110, false, false, CoD.TweenType.Linear)
                                            Sender:setLeftRight(true, false, -5, 107)
                                            Sender:setTopBottom(true, false, -120, 48)
                                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage7)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 99, false, false, CoD.TweenType.Linear)
                                        Sender:setLeftRight(true, false, -10, 102)
                                        Sender:setTopBottom(true, false, -135, 33)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -19, 93)
                                    Sender:setTopBottom(true, false, -137, 31)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 69, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -26.06, 85.94)
                                Sender:setTopBottom(true, false, -127, 41)
                                Sender:setAlpha(0.8)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 40, false, false, CoD.TweenType.Linear)
                            Sender:setAlpha(0.29)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 129, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -31, 81)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -120, 48)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark2Ext00:completeAnimation()
                Widget.ZmFxSpark2Ext00:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext00, {})
            end
        }, 
        Four = {
            DefaultClip = function()
                Widget:setupElementClipCounter(32)
                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                Widget.clipFinished(Widget.Nine, {})

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(0)
                Widget.clipFinished(Widget.NineLight, {})

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                Widget.clipFinished(Widget.NineGlow, {})

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                Widget.clipFinished(Widget.Eight, {})

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(0)
                Widget.clipFinished(Widget.EightLight, {})

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                Widget.clipFinished(Widget.EightGlow, {})

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                Widget.clipFinished(Widget.Seven, {})

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(0)
                Widget.clipFinished(Widget.SevenLight, {})

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                Widget.clipFinished(Widget.SevenGlow, {})

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                Widget.clipFinished(Widget.Six, {})

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(0)
                Widget.clipFinished(Widget.SixLight, {})

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                Widget.clipFinished(Widget.SixGlow, {})

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                Widget.clipFinished(Widget.Five, {})

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(0)
                Widget.clipFinished(Widget.FiveLight, {})

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                Widget.clipFinished(Widget.FiveGlow, {})

                local function HandleFourClip(Sender, Event)
                    local function HandleFourClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1539, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleFourClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1480, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleFourClipStage2)
                    end
                end

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                HandleFourClip(Widget.Four, {})

                local function HandleFourLightClip(Sender, Event)
                    local function HandleFourLightClipStage2(Sender, Event)
                        local function HandleFourLightClipStage3(Sender, Event)
                            local function HandleFourLightClipStage4(Sender, Event)
                                if not Event.interrupted then
                                    Sender:beginAnimation("keyframe", 649, false, false, CoD.TweenType.Linear)
                                end

                                Sender:setAlpha(0)
                                Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                                Sender:setShaderVector(0, 1, 0, 0, 0)
                                Sender:setShaderVector(1, 0, 0, 0, 0)
                                Sender:setShaderVector(2, 1, 0, 0, 0)
                                Sender:setShaderVector(3, 0.22, 0, 0, 0)
                                
                                if Event.interrupted then
                                    Widget.clipFinished(Sender, Event)
                                else
                                    Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                end
                            end

                            if Event.interrupted then
                                HandleFourLightClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 379, false, false, CoD.TweenType.Linear)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleFourLightClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleFourLightClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 850, false, false, CoD.TweenType.Linear)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleFourLightClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleFourLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleFourLightClipStage2)
                    end
                end

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(1)
                Widget.FourLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.FourLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.FourLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.FourLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.FourLight:setShaderVector(3, 0.22, 0, 0, 0)
                HandleFourLightClip(Widget.FourLight, {})

                local function HandleFourGlowClip(Sender, Event)
                    local function HandleFourGlowClipStage2(Sender, Event)
                        local function HandleFourGlowClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleFourGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1779, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleFourGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleFourGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 239, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleFourGlowClipStage2)
                    end
                end
                
                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                HandleFourGlowClip(Widget.FourGlow, {})

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                Widget.clipFinished(Widget.Three, {})

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(0)
                Widget.clipFinished(Widget.ThreeLight, {})

                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                Widget.clipFinished(Widget.ThreeGlow, {})

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                Widget.clipFinished(Widget.Two, {})

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.clipFinished(Widget.TwoLight, {})

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                Widget.clipFinished(Widget.TwoGlow, {})

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                Widget.clipFinished(Widget.One, {})

                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(0)
                Widget.clipFinished(Widget.OneLight, {})

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                Widget.clipFinished(Widget.OneGlow, {})

                Widget.Zero:completeAnimation()
                Widget.Zero:setAlpha(0)
                Widget.clipFinished(Widget.Zero, {})

                Widget.ZeroLight:completeAnimation()
                Widget.ZeroLight:setAlpha(0)
                Widget.clipFinished(Widget.ZeroLight, {})

                Widget.ZeroGlow:completeAnimation()
                Widget.ZeroGlow:setAlpha(0)
                Widget.clipFinished(Widget.ZeroGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    if not Event.interrupted then
                                        Sender:beginAnimation("keyframe", 149, false, false, CoD.TweenType.Linear)
                                    end

                                    Sender:setLeftRight(true, false, -4.56, 107.44)
                                    Sender:setTopBottom(true, false, -117.29, 50.71)
                                    Sender:setAlpha(0)

                                    if Event.interrupted then
                                        Widget.clipFinished(Sender, Event)
                                    else
                                        Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 129, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -4.56, 107.44)
                                    Sender:setTopBottom(true, false, -117.29, 50.71)
                                    Sender:setAlpha(0.43)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 140, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -14.67, 97.33)
                                Sender:setTopBottom(true, false, -111.03, 56.97)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 429, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -25.56, 86.44)
                            Sender:setTopBottom(true, false, -104.29, 63.71)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, -22.59, 89.41)
                        Sender:setTopBottom(true, false, -127.27, 40.73)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -21.56, 90.44)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -135.29, 32.71)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                local function HandleZmFxSpark2Ext00Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext00ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext00ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext00ClipStage4(Sender, Event)
                                if not Event.interrupted then
                                    Sender:beginAnimation("keyframe", 470, false, false, CoD.TweenType.Linear)
                                end

                                Sender:setLeftRight(true, false, -10.56, 101.44)
                                Sender:setTopBottom(true, false, -76, 92)
                                Sender:setAlpha(0)
                                
                                if Event.interrupted then
                                    Widget.clipFinished(Sender, Event)
                                else
                                    Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext00ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 189, false, false, CoD.TweenType.Linear)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext00ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 519, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -10.56, 101.44)
                            Sender:setTopBottom(true, false, -76, 92)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext00ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, -5.9, 106.1)
                        Sender:setTopBottom(true, false, -117.91, 50.09)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext00:completeAnimation()
                Widget.ZmFxSpark2Ext00:setLeftRight(true, false, -4.56, 107.44)
                Widget.ZmFxSpark2Ext00:setTopBottom(true, false, -130, 38)
                Widget.ZmFxSpark2Ext00:setAlpha(0)
                HandleZmFxSpark2Ext00Clip(Widget.ZmFxSpark2Ext00, {})
            end
        }, 
        Five = {
            DefaultClip = function()
                Widget:setupElementClipCounter(32)
                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                Widget.clipFinished(Widget.Nine, {})

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(0)
                Widget.clipFinished(Widget.NineLight, {})

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                Widget.clipFinished(Widget.NineGlow, {})

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                Widget.clipFinished(Widget.Eight, {})

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(0)
                Widget.clipFinished(Widget.EightLight, {})

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                Widget.clipFinished(Widget.EightGlow, {})

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                Widget.clipFinished(Widget.Seven, {})

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(0)
                Widget.clipFinished(Widget.SevenLight, {})

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                Widget.clipFinished(Widget.SevenGlow, {})

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                Widget.clipFinished(Widget.Six, {})

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(0)
                Widget.clipFinished(Widget.SixLight, {})

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                Widget.clipFinished(Widget.SixGlow, {})

                local function HandleFiveClip(Sender, Event)
                    local function HandleFiveClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1529, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleFiveClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1490, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleFiveClipStage2)
                    end
                end

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                HandleFiveClip(Widget.Five, {})

                local function HandleFiveLightClip(Sender, Event)
                    local function HandleFiveLightClipStage2(Sender, Event)
                        local function HandleFiveLightClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1019, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:setShaderVector(3, 0.2, 0, 0, 0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleFiveLightClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 810, false, false, CoD.TweenType.Linear)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleFiveLightClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleFiveLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 189, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleFiveLightClipStage2)
                    end
                end

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(1)
                Widget.FiveLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.FiveLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.FiveLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.FiveLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.FiveLight:setShaderVector(3, 0.2, 0, 0, 0)
                HandleFiveLightClip(Widget.FiveLight, {})

                local function HandleFiveGlowClip(Sender, Event)
                    local function HandleFiveGlowClipStage2(Sender, Event)
                        local function HandleFiveGlowClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleFiveGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1649, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleFiveGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleFiveGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 370, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleFiveGlowClipStage2)
                    end
                end

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                HandleFiveGlowClip(Widget.FiveGlow, {})

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                Widget.clipFinished(Widget.Four, {})

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(0)
                Widget.clipFinished(Widget.FourLight, {})

                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                Widget.clipFinished(Widget.FourGlow, {})

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                Widget.clipFinished(Widget.Three, {})

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(0)
                Widget.clipFinished(Widget.ThreeLight, {})

                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                Widget.clipFinished(Widget.ThreeGlow, {})

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                Widget.clipFinished(Widget.Two, {})

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.clipFinished(Widget.TwoLight, {})

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                Widget.clipFinished(Widget.TwoGlow, {})

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                Widget.clipFinished(Widget.One, {})

                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(0)
                Widget.clipFinished(Widget.OneLight, {})

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                Widget.clipFinished(Widget.OneGlow, {})

                Widget.Zero:completeAnimation()
                Widget.Zero:setAlpha(0)
                Widget.clipFinished(Widget.Zero, {})

                Widget.ZeroLight:completeAnimation()
                Widget.ZeroLight:setAlpha(0)
                Widget.clipFinished(Widget.ZeroLight, {})

                Widget.ZeroGlow:completeAnimation()
                Widget.ZeroGlow:setAlpha(0)
                Widget.clipFinished(Widget.ZeroGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    local function HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        local function HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            local function HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                local function HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    local function HandleZmFxSpark2Ext0ClipStage10(Sender, Event)
                                                        if not Event.interrupted then
                                                            Sender:beginAnimation("keyframe", 289, false, false, CoD.TweenType.Linear)
                                                        end

                                                        Sender:setLeftRight(true, false, -22.56, 89.44)
                                                        Sender:setTopBottom(true, false, -73.29, 94.71)
                                                        Sender:setAlpha(0)
                                                        
                                                        if Event.interrupted then
                                                            Widget.clipFinished(Sender, Event)
                                                        else
                                                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                                        end
                                                    end

                                                    if Event.interrupted then
                                                        HandleZmFxSpark2Ext0ClipStage10(Sender, Event)
                                                        return 
                                                    else
                                                        Sender:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
                                                        Sender:setLeftRight(true, false, -22.56, 89.44)
                                                        Sender:setTopBottom(true, false, -73.29, 94.71)
                                                        Sender:setAlpha(0.59)
                                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage10)
                                                    end
                                                end

                                                if Event.interrupted then
                                                    HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    return 
                                                else
                                                    Sender:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
                                                    Sender:setLeftRight(true, false, -18.56, 93.44)
                                                    Sender:setTopBottom(true, false, -72.29, 95.71)
                                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage9)
                                                end
                                            end

                                            if Event.interrupted then
                                                HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                return 
                                            else
                                                Sender:beginAnimation("keyframe", 59, false, false, CoD.TweenType.Linear)
                                                Sender:setLeftRight(true, false, -9.56, 102.44)
                                                Sender:setTopBottom(true, false, -75.29, 92.71)
                                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage8)
                                            end
                                        end

                                        if Event.interrupted then
                                            HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            return 
                                        else
                                            Sender:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)
                                            Sender:setLeftRight(true, false, -5.56, 106.44)
                                            Sender:setTopBottom(true, false, -82.29, 85.71)
                                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage7)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 79, false, false, CoD.TweenType.Linear)
                                        Sender:setLeftRight(true, false, -7.56, 104.44)
                                        Sender:setTopBottom(true, false, -94.29, 73.71)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 89, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -14.09, 97.91)
                                    Sender:setTopBottom(true, false, -110.82, 57.18)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 290, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -23.56, 88.44)
                                Sender:setTopBottom(true, false, -110.29, 57.71)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 179, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -22.56, 89.44)
                            Sender:setTopBottom(true, false, -133.29, 34.71)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, -15.45, 96.55)
                        Sender:setTopBottom(true, false, -136.61, 31.39)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -7.56, 104.44)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -140.29, 27.71)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark2Ext00:completeAnimation()
                Widget.ZmFxSpark2Ext00:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext00, {})
            end
        }, 
        Six = {
            DefaultClip = function()
                Widget:setupElementClipCounter(32)
                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                Widget.clipFinished(Widget.Nine, {})

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(0)
                Widget.clipFinished(Widget.NineLight, {})

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                Widget.clipFinished(Widget.NineGlow, {})

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                Widget.clipFinished(Widget.Eight, {})

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(0)
                Widget.clipFinished(Widget.EightLight, {})

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                Widget.clipFinished(Widget.EightGlow, {})

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                Widget.clipFinished(Widget.Seven, {})

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(0)
                Widget.clipFinished(Widget.SevenLight, {})

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                Widget.clipFinished(Widget.SevenGlow, {})

                local function HandleSixClip(Sender, Event)
                    local function HandleSixClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1549, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleSixClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1470, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleSixClipStage2)
                    end
                end

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                HandleSixClip(Widget.Six, {})

                local function HandleSixLightClip(Sender, Event)
                    local function HandleSixLightClipStage2(Sender, Event)
                        local function HandleSixLightClipStage3(Sender, Event)
                            local function HandleSixLightClipStage4(Sender, Event)
                                if not Event.interrupted then
                                    Sender:beginAnimation("keyframe", 509, false, false, CoD.TweenType.Linear)
                                end

                                Sender:setAlpha(0)
                                Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                                Sender:setShaderVector(0, 1, 0, 0, 0)
                                Sender:setShaderVector(1, 0, 0, 0, 0)
                                Sender:setShaderVector(2, 1, 0, 0, 0)
                                Sender:setShaderVector(3, 0.2, 0, 0, 0)

                                if Event.interrupted then
                                    Widget.clipFinished(Sender, Event)
                                else
                                    Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                end
                            end

                            if Event.interrupted then
                                HandleSixLightClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 629, false, false, CoD.TweenType.Linear)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleSixLightClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleSixLightClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 720, false, false, CoD.TweenType.Linear)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleSixLightClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleSixLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 159, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleSixLightClipStage2)
                    end
                end

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(1)
                Widget.SixLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.SixLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.SixLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.SixLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.SixLight:setShaderVector(3, 0.2, 0, 0, 0)
                HandleSixLightClip(Widget.SixLight, {})

                local function HandleSixGlowClip(Sender, Event)
                    local function HandleSixGlowClipStage2(Sender, Event)
                        local function HandleSixGlowClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleSixGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1600, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleSixGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleSixGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 419, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleSixGlowClipStage2)
                    end
                end

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                HandleSixGlowClip(Widget.SixGlow, {})

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                Widget.clipFinished(Widget.Five, {})

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(0)
                Widget.clipFinished(Widget.FiveLight, {})

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                Widget.clipFinished(Widget.FiveGlow, {})

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                Widget.clipFinished(Widget.Four, {})

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(0)
                Widget.clipFinished(Widget.FourLight, {})

                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                Widget.clipFinished(Widget.FourGlow, {})

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                Widget.clipFinished(Widget.Three, {})

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(0)
                Widget.clipFinished(Widget.ThreeLight, {})

                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                Widget.clipFinished(Widget.ThreeGlow, {})

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                Widget.clipFinished(Widget.Two, {})

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.clipFinished(Widget.TwoLight, {})

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                Widget.clipFinished(Widget.TwoGlow, {})

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                Widget.clipFinished(Widget.One, {})

                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(0)
                Widget.clipFinished(Widget.OneLight, {})

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                Widget.clipFinished(Widget.OneGlow, {})

                Widget.Zero:completeAnimation()
                Widget.Zero:setAlpha(0)
                Widget.clipFinished(Widget.Zero, {})

                Widget.ZeroLight:completeAnimation()
                Widget.ZeroLight:setAlpha(0)
                Widget.clipFinished(Widget.ZeroLight, {})

                Widget.ZeroGlow:completeAnimation()
                Widget.ZeroGlow:setAlpha(0)
                Widget.clipFinished(Widget.ZeroGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    local function HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        local function HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            local function HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                local function HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    local function HandleZmFxSpark2Ext0ClipStage10(Sender, Event)
                                                        if not Event.interrupted then
                                                            Sender:beginAnimation("keyframe", 340, false, false, CoD.TweenType.Linear)
                                                        end

                                                        Sender:setLeftRight(true, false, -21.56, 90.44)
                                                        Sender:setTopBottom(true, false, -96.29, 71.71)
                                                        Sender:setAlpha(0)

                                                        if Event.interrupted then
                                                            Widget.clipFinished(Sender, Event)
                                                        else
                                                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                                        end
                                                    end

                                                    if Event.interrupted then
                                                        HandleZmFxSpark2Ext0ClipStage10(Sender, Event)
                                                        return 
                                                    else
                                                        Sender:beginAnimation("keyframe", 79, false, false, CoD.TweenType.Linear)
                                                        Sender:setLeftRight(true, false, -21.56, 90.44)
                                                        Sender:setTopBottom(true, false, -96.29, 71.71)
                                                        Sender:setAlpha(0.65)
                                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage10)
                                                    end
                                                end

                                                if Event.interrupted then
                                                    HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    return 
                                                else
                                                    Sender:beginAnimation("keyframe", 19, false, false, CoD.TweenType.Linear)
                                                    Sender:setLeftRight(true, false, -16.76, 95.24)
                                                    Sender:setTopBottom(true, false, -102.69, 65.31)
                                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage9)
                                                end
                                            end

                                            if Event.interrupted then
                                                HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                return 
                                            else
                                                Sender:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
                                                Sender:setLeftRight(true, false, -15.56, 96.44)
                                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage8)
                                            end
                                        end

                                        if Event.interrupted then
                                            HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            return 
                                        else
                                            Sender:beginAnimation("keyframe", 110, false, false, CoD.TweenType.Linear)
                                            Sender:setLeftRight(true, false, -7.56, 104.44)
                                            Sender:setTopBottom(true, false, -104.29, 63.71)
                                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage7)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 120, false, false, CoD.TweenType.Linear)
                                        Sender:setLeftRight(true, false, -14.21, 97.79)
                                        Sender:setTopBottom(true, false, -78.46, 89.54)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 120, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -23.56, 88.44)
                                    Sender:setTopBottom(true, false, -73.29, 94.71)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 129, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -25.52, 86.48)
                                Sender:setTopBottom(true, false, -94.65, 73.35)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 340, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -25.56, 86.44)
                            Sender:setTopBottom(true, false, -105.29, 62.71)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 159, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, -14, 98)
                        Sender:setTopBottom(true, false, -127.05, 40.95)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -8.56, 103.44)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -137.29, 30.71)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark2Ext00:completeAnimation()
                Widget.ZmFxSpark2Ext00:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext00, {})
            end
        },
        Seven = {
            DefaultClip = function()
                Widget:setupElementClipCounter(32)
                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                Widget.clipFinished(Widget.Nine, {})

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(0)
                Widget.clipFinished(Widget.NineLight, {})

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                Widget.clipFinished(Widget.NineGlow, {})

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                Widget.clipFinished(Widget.Eight, {})

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(0)
                Widget.clipFinished(Widget.EightLight, {})

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                Widget.clipFinished(Widget.EightGlow, {})

                local function HandleSevenClip(Sender, Event)
                    local function HandleSevenClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1559, false, false, CoD.TweenType.Linear)
                        end
                        Sender:setAlpha(1)
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleSevenClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1450, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleSevenClipStage2)
                    end
                end

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                HandleSevenClip(Widget.Seven, {})

                local function HandleSevenLightClip(Sender, Event)
                    local function HandleSevenLightClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 929, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(0)
                        Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                        Sender:setShaderVector(0, 1, 0, 0, 0)
                        Sender:setShaderVector(1, 0, 0, 0, 0)
                        Sender:setShaderVector(2, 1, 0, 0, 0)
                        Sender:setShaderVector(3, 0.2, 0, 0, 0)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleSevenLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1080, false, false, CoD.TweenType.Linear)
                        Sender:setShaderVector(2, 1, 0, 0, 0)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleSevenLightClipStage2)
                    end
                end

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(1)
                Widget.SevenLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.SevenLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.SevenLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.SevenLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.SevenLight:setShaderVector(3, 0.2, 0, 0, 0)
                HandleSevenLightClip(Widget.SevenLight, {})

                local function HandleSevenGlowClip(Sender, Event)
                    local function HandleSevenGlowClipStage2(Sender, Event)
                        local function HandleSevenGlowClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 990, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleSevenGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1529, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleSevenGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleSevenGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 490, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleSevenGlowClipStage2)
                    end
                end

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                HandleSevenGlowClip(Widget.SevenGlow, {})

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                Widget.clipFinished(Widget.Six, {})

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(0)
                Widget.clipFinished(Widget.SixLight, {})

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                Widget.clipFinished(Widget.SixGlow, {})

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                Widget.clipFinished(Widget.Five, {})

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(0)
                Widget.clipFinished(Widget.FiveLight, {})

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                Widget.clipFinished(Widget.FiveGlow, {})

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                Widget.clipFinished(Widget.Four, {})

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(0)
                Widget.clipFinished(Widget.FourLight, {})

                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                Widget.clipFinished(Widget.FourGlow, {})

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                Widget.clipFinished(Widget.Three, {})

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(0)
                Widget.clipFinished(Widget.ThreeLight, {})

                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                Widget.clipFinished(Widget.ThreeGlow, {})

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                Widget.clipFinished(Widget.Two, {})

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.clipFinished(Widget.TwoLight, {})

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                Widget.clipFinished(Widget.TwoGlow, {})

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                Widget.clipFinished(Widget.One, {})

                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(0)
                Widget.clipFinished(Widget.OneLight, {})

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                Widget.clipFinished(Widget.OneGlow, {})

                Widget.Zero:completeAnimation()
                Widget.Zero:setAlpha(0)
                Widget.clipFinished(Widget.Zero, {})

                Widget.ZeroLight:completeAnimation()
                Widget.ZeroLight:setAlpha(0)
                Widget.clipFinished(Widget.ZeroLight, {})

                Widget.ZeroGlow:completeAnimation()
                Widget.ZeroGlow:setAlpha(0)
                Widget.clipFinished(Widget.ZeroGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    local function HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        if not Event.interrupted then
                                            Sender:beginAnimation("keyframe", 480, false, false, CoD.TweenType.Linear)
                                        end

                                        Sender:setLeftRight(true, false, -11.56, 100.44)
                                        Sender:setTopBottom(true, false, -73.29, 94.71)
                                        Sender:setAlpha(0)
                                        
                                        if Event.interrupted then
                                            Widget.clipFinished(Sender, Event)
                                        else
                                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 39, false, false, CoD.TweenType.Linear)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 480, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -11.56, 100.44)
                                    Sender:setTopBottom(true, false, -73.29, 94.71)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 60, false, false, CoD.TweenType.Linear)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 250, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -7.56, 104.44)
                            Sender:setTopBottom(true, false, -132.29, 35.71)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 189, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -29.56, 82.44)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -121.29, 46.71)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                Widget.ZmFxSpark2Ext00:completeAnimation()
                Widget.ZmFxSpark2Ext00:setAlpha(0)
                Widget.clipFinished(Widget.ZmFxSpark2Ext00, {})
            end
        }, 
        Eight = {
            DefaultClip = function()
                Widget:setupElementClipCounter(32)
                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                Widget.clipFinished(Widget.Nine, {})

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(0)
                Widget.clipFinished(Widget.NineLight, {})

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                Widget.clipFinished(Widget.NineGlow, {})

                local function HandleEightClip(Sender, Event)
                    local function HandleEightClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1529, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)
                        
                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleEightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1470, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleEightClipStage2)
                    end
                end

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                HandleEightClip(Widget.Eight, {})

                local function HandleEightLightClip(Sender, Event)
                    local function HandleEightLightClipStage2(Sender, Event)
                        local function HandleEightLightClipStage3(Sender, Event)
                            local function HandleEightLightClipStage4(Sender, Event)
                                if not Event.interrupted then
                                    Sender:beginAnimation("keyframe", 549, false, false, CoD.TweenType.Linear)
                                end

                                Sender:setAlpha(0)
                                Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                                Sender:setShaderVector(0, 1, 0, 0, 0)
                                Sender:setShaderVector(1, 0, 0, 0, 0)
                                Sender:setShaderVector(2, 1, 0, 0, 0)
                                Sender:setShaderVector(3, 0.2, 0, 0, 0)
                                
                                if Event.interrupted then
                                    Widget.clipFinished(Sender, Event)
                                else
                                    Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                end
                            end

                            if Event.interrupted then
                                HandleEightLightClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 360, false, false, CoD.TweenType.Linear)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleEightLightClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleEightLightClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 999, false, false, CoD.TweenType.Linear)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleEightLightClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleEightLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 180, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleEightLightClipStage2)
                    end
                end

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(1)
                Widget.EightLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.EightLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.EightLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.EightLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.EightLight:setShaderVector(3, 0.2, 0, 0, 0)
                HandleEightLightClip(Widget.EightLight, {})

                local function HandleEightGlowClip(Sender, Event)
                    local function HandleEightGlowClipStage2(Sender, Event)
                        local function HandleEightGlowClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleEightGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1490, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleEightGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleEightGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 509, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleEightGlowClipStage2)
                    end
                end

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                HandleEightGlowClip(Widget.EightGlow, {})

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                Widget.clipFinished(Widget.Seven, {})

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(0)
                Widget.clipFinished(Widget.SevenLight, {})

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                Widget.clipFinished(Widget.SevenGlow, {})

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                Widget.clipFinished(Widget.Six, {})

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(0)
                Widget.clipFinished(Widget.SixLight, {})

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                Widget.clipFinished(Widget.SixGlow, {})

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                Widget.clipFinished(Widget.Five, {})

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(0)
                Widget.clipFinished(Widget.FiveLight, {})

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                Widget.clipFinished(Widget.FiveGlow, {})

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                Widget.clipFinished(Widget.Four, {})

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(0)
                Widget.clipFinished(Widget.FourLight, {})

                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                Widget.clipFinished(Widget.FourGlow, {})

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                Widget.clipFinished(Widget.Three, {})

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(0)
                Widget.clipFinished(Widget.ThreeLight, {})

                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                Widget.clipFinished(Widget.ThreeGlow, {})

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                Widget.clipFinished(Widget.Two, {})

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.clipFinished(Widget.TwoLight, {})

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                Widget.clipFinished(Widget.TwoGlow, {})

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                Widget.clipFinished(Widget.One, {})

                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(0)
                Widget.clipFinished(Widget.OneLight, {})

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                Widget.clipFinished(Widget.OneGlow, {})

                Widget.Zero:completeAnimation()
                Widget.Zero:setAlpha(0)
                Widget.clipFinished(Widget.Zero, {})

                Widget.ZeroLight:completeAnimation()
                Widget.ZeroLight:setAlpha(0)
                Widget.clipFinished(Widget.ZeroLight, {})

                Widget.ZeroGlow:completeAnimation()
                Widget.ZeroGlow:setAlpha(0)
                Widget.clipFinished(Widget.ZeroGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    local function HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        local function HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            local function HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                local function HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    if not Event.interrupted then
                                                        Sender:beginAnimation("keyframe", 360, false, false, CoD.TweenType.Linear)
                                                    end

                                                    Sender:setLeftRight(true, false, -15.56, 96.44)
                                                    Sender:setTopBottom(true, false, -76, 92)
                                                    Sender:setAlpha(0)

                                                    if Event.interrupted then
                                                        Widget.clipFinished(Sender, Event)
                                                    else
                                                        Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                                    end
                                                end

                                                if Event.interrupted then
                                                    HandleZmFxSpark2Ext0ClipStage9(Sender, Event)
                                                    return 
                                                else
                                                    Sender:beginAnimation("keyframe", 9, false, false, CoD.TweenType.Linear)
                                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage9)
                                                end
                                            end

                                            if Event.interrupted then
                                                HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                return 
                                            else
                                                Sender:beginAnimation("keyframe", 129, false, false, CoD.TweenType.Linear)
                                                Sender:setLeftRight(true, false, -15.56, 96.44)
                                                Sender:setTopBottom(true, false, -76, 92)
                                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage8)
                                            end
                                        end

                                        if Event.interrupted then
                                            HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            return 
                                        else
                                            Sender:beginAnimation("keyframe", 99, false, false, CoD.TweenType.Linear)
                                            Sender:setTopBottom(true, false, -88, 80)
                                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage7)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 139, false, false, CoD.TweenType.Linear)
                                        Sender:setLeftRight(true, false, -6.56, 105.44)
                                        Sender:setTopBottom(true, false, -99.29, 68.71)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 160, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -17.56, 94.44)
                                    Sender:setTopBottom(true, false, -107.29, 60.71)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 219, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -29.56, 82.44)
                                Sender:setTopBottom(true, false, -118.29, 49.71)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 239, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -24.56, 87.44)
                            Sender:setTopBottom(true, false, -130.29, 37.71)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 180, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -19.56, 92.44)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -137.29, 30.71)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                local function HandleZmFxSpark2Ext00Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext00ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext00ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext00ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext00ClipStage5(Sender, Event)
                                    local function HandleZmFxSpark2Ext00ClipStage6(Sender, Event)
                                        local function HandleZmFxSpark2Ext00ClipStage7(Sender, Event)
                                            local function HandleZmFxSpark2Ext00ClipStage8(Sender, Event)
                                                local function HandleZmFxSpark2Ext00ClipStage9(Sender, Event)
                                                    if not Event.interrupted then
                                                        Sender:beginAnimation("keyframe", 360, false, false, CoD.TweenType.Linear)
                                                    end

                                                    Sender:setLeftRight(true, false, -17, 95)
                                                    Sender:setTopBottom(true, false, -76, 92)
                                                    Sender:setAlpha(0)

                                                    if Event.interrupted then
                                                        Widget.clipFinished(Sender, Event)
                                                    else
                                                        Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                                    end
                                                end

                                                if Event.interrupted then
                                                    HandleZmFxSpark2Ext00ClipStage9(Sender, Event)
                                                    return 
                                                else
                                                    Sender:beginAnimation("keyframe", 9, false, false, CoD.TweenType.Linear)
                                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage9)
                                                end
                                            end

                                            if Event.interrupted then
                                                HandleZmFxSpark2Ext00ClipStage8(Sender, Event)
                                                return 
                                            else
                                                Sender:beginAnimation("keyframe", 129, false, false, CoD.TweenType.Linear)
                                                Sender:setLeftRight(true, false, -17, 95)
                                                Sender:setTopBottom(true, false, -76, 92)
                                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage8)
                                            end
                                        end

                                        if Event.interrupted then
                                            HandleZmFxSpark2Ext00ClipStage7(Sender, Event)
                                            return 
                                        else
                                            Sender:beginAnimation("keyframe", 99, false, false, CoD.TweenType.Linear)
                                            Sender:setLeftRight(true, false, -31, 81)
                                            Sender:setTopBottom(true, false, -82.29, 85.71)
                                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage7)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleZmFxSpark2Ext00ClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 139, false, false, CoD.TweenType.Linear)
                                        Sender:setLeftRight(true, false, -28, 84)
                                        Sender:setTopBottom(true, false, -94.29, 73.71)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext00ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 160, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -17.56, 94.44)
                                    Sender:setTopBottom(true, false, -111.29, 56.71)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext00ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 219, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -3.56, 108.44)
                                Sender:setTopBottom(true, false, -118.29, 49.71)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext00ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 239, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -6.56, 105.44)
                            Sender:setTopBottom(true, false, -134.29, 33.71)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext00ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 180, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext00:completeAnimation()
                Widget.ZmFxSpark2Ext00:setLeftRight(true, false, -19.56, 92.44)
                Widget.ZmFxSpark2Ext00:setTopBottom(true, false, -137.29, 30.71)
                Widget.ZmFxSpark2Ext00:setAlpha(0)
                HandleZmFxSpark2Ext00Clip(Widget.ZmFxSpark2Ext00, {})
            end
        }, 
        Nine = {
            DefaultClip = function()
                Widget:setupElementClipCounter(32)

                local function HandleNineClip(Sender, Event)
                    local function HandleNineClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1460, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleNineClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1549, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleNineClipStage2)
                    end
                end

                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                HandleNineClip(Widget.Nine, {})

                local function HandleNineLightClip(Sender, Event)
                    local function HandleNineLightClipStage2(Sender, Event)
                        local function HandleNineLightClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1009, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1, 0, 0, 0)
                            Sender:setShaderVector(3, 0.2, 0, 0, 0)
                            
                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleNineLightClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 149, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleNineLightClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleNineLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 850, false, false, CoD.TweenType.Linear)
                        Sender:setShaderVector(2, 1, 0, 0, 0)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleNineLightClipStage2)
                    end
                end

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(1)
                Widget.NineLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.NineLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.NineLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.NineLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.NineLight:setShaderVector(3, 0.2, 0, 0, 0)
                HandleNineLightClip(Widget.NineLight, {})

                local function HandleNineGlowClip(Sender, Event)
                    local function HandleNineGlowClipStage2(Sender, Event)
                        local function HandleNineGlowClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleNineGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1620, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleNineGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleNineGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 389, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleNineGlowClipStage2)
                    end
                end

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                HandleNineGlowClip(Widget.NineGlow, {})

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                Widget.clipFinished(Widget.Eight, {})

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(0)
                Widget.clipFinished(Widget.EightLight, {})

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                Widget.clipFinished(Widget.EightGlow, {})

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                Widget.clipFinished(Widget.Seven, {})

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(0)
                Widget.clipFinished(Widget.SevenLight, {})

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                Widget.clipFinished(Widget.SevenGlow, {})

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                Widget.clipFinished(Widget.Six, {})

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(0)
                Widget.clipFinished(Widget.SixLight, {})

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                Widget.clipFinished(Widget.SixGlow, {})

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                Widget.clipFinished(Widget.Five, {})

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(0)
                Widget.clipFinished(Widget.FiveLight, {})

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                Widget.clipFinished(Widget.FiveGlow, {})

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                Widget.clipFinished(Widget.Four, {})

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(0)
                Widget.clipFinished(Widget.FourLight, {})

                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                Widget.clipFinished(Widget.FourGlow, {})

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                Widget.clipFinished(Widget.Three, {})

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(0)
                Widget.clipFinished(Widget.ThreeLight, {})

                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                Widget.clipFinished(Widget.ThreeGlow, {})

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                Widget.clipFinished(Widget.Two, {})

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.clipFinished(Widget.TwoLight, {})

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                Widget.clipFinished(Widget.TwoGlow, {})

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                Widget.clipFinished(Widget.One, {})

                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(0)
                Widget.clipFinished(Widget.OneLight, {})

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                Widget.clipFinished(Widget.OneGlow, {})

                Widget.Zero:completeAnimation()
                Widget.Zero:setAlpha(0)
                Widget.clipFinished(Widget.Zero, {})

                Widget.ZeroLight:completeAnimation()
                Widget.ZeroLight:setAlpha(0)
                Widget.clipFinished(Widget.ZeroLight, {})

                Widget.ZeroGlow:completeAnimation()
                Widget.ZeroGlow:setAlpha(0)
                Widget.clipFinished(Widget.ZeroGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    local function HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        if not Event.interrupted then
                                            Sender:beginAnimation("keyframe", 590, false, false, CoD.TweenType.Linear)
                                        end

                                        Sender:setLeftRight(true, false, -8.56, 103.44)
                                        Sender:setTopBottom(true, false, -120.9, 47.1)
                                        Sender:setAlpha(0)
                                        
                                        if Event.interrupted then
                                            Widget.clipFinished(Sender, Event)
                                        else
                                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 30, false, false, CoD.TweenType.Linear)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 159, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -8.56, 103.44)
                                    Sender:setTopBottom(true, false, -120.9, 47.1)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 180, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -19.91, 92.09)
                                Sender:setTopBottom(true, false, -107.78, 60.22)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 299, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -30.56, 81.44)
                            Sender:setTopBottom(true, false, -107.9, 60.1)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 180, false, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, -22.56, 89.44)
                        Sender:setTopBottom(true, false, -130, 38)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -4.56, 107.44)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -135, 33)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                local function HandleZmFxSpark2Ext00Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext00ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext00ClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 590, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setLeftRight(true, false, -19.56, 92.44)
                            Sender:setTopBottom(true, false, -71, 97)
                            Sender:setAlpha(0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext00ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 670, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -19.56, 92.44)
                            Sender:setTopBottom(true, false, -71, 97)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext00ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 180, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage2)
                    end
                end
                
                Widget.ZmFxSpark2Ext00:completeAnimation()
                Widget.ZmFxSpark2Ext00:setLeftRight(true, false, 4.44, 116.44)
                Widget.ZmFxSpark2Ext00:setTopBottom(true, false, -135, 33)
                Widget.ZmFxSpark2Ext00:setAlpha(0)
                HandleZmFxSpark2Ext00Clip(Widget.ZmFxSpark2Ext00, {})
            end
        }, 
        Zero = {
            DefaultClip = function()
                Widget:setupElementClipCounter(32)

                Widget.Nine:completeAnimation()
                Widget.Nine:setAlpha(0)
                Widget.clipFinished(Widget.Nine, {})

                Widget.NineLight:completeAnimation()
                Widget.NineLight:setAlpha(0)
                Widget.clipFinished(Widget.NineLight, {})

                Widget.NineGlow:completeAnimation()
                Widget.NineGlow:setAlpha(0)
                Widget.clipFinished(Widget.NineGlow, {})

                Widget.Eight:completeAnimation()
                Widget.Eight:setAlpha(0)
                Widget.clipFinished(Widget.Eight, {})

                Widget.EightLight:completeAnimation()
                Widget.EightLight:setAlpha(0)
                Widget.clipFinished(Widget.EightLight, {})

                Widget.EightGlow:completeAnimation()
                Widget.EightGlow:setAlpha(0)
                Widget.clipFinished(Widget.EightGlow, {})

                Widget.Seven:completeAnimation()
                Widget.Seven:setAlpha(0)
                Widget.clipFinished(Widget.Seven, {})

                Widget.SevenLight:completeAnimation()
                Widget.SevenLight:setAlpha(0)
                Widget.clipFinished(Widget.SevenLight, {})

                Widget.SevenGlow:completeAnimation()
                Widget.SevenGlow:setAlpha(0)
                Widget.clipFinished(Widget.SevenGlow, {})

                Widget.Six:completeAnimation()
                Widget.Six:setAlpha(0)
                Widget.clipFinished(Widget.Six, {})

                Widget.SixLight:completeAnimation()
                Widget.SixLight:setAlpha(0)
                Widget.clipFinished(Widget.SixLight, {})

                Widget.SixGlow:completeAnimation()
                Widget.SixGlow:setAlpha(0)
                Widget.clipFinished(Widget.SixGlow, {})

                Widget.Five:completeAnimation()
                Widget.Five:setAlpha(0)
                Widget.clipFinished(Widget.Five, {})

                Widget.FiveLight:completeAnimation()
                Widget.FiveLight:setAlpha(0)
                Widget.clipFinished(Widget.FiveLight, {})

                Widget.FiveGlow:completeAnimation()
                Widget.FiveGlow:setAlpha(0)
                Widget.clipFinished(Widget.FiveGlow, {})

                Widget.Four:completeAnimation()
                Widget.Four:setAlpha(0)
                Widget.clipFinished(Widget.Four, {})

                Widget.FourLight:completeAnimation()
                Widget.FourLight:setAlpha(0)
                Widget.clipFinished(Widget.FourLight, {})

                Widget.FourGlow:completeAnimation()
                Widget.FourGlow:setAlpha(0)
                Widget.clipFinished(Widget.FourGlow, {})

                Widget.Three:completeAnimation()
                Widget.Three:setAlpha(0)
                Widget.clipFinished(Widget.Three, {})

                Widget.ThreeLight:completeAnimation()
                Widget.ThreeLight:setAlpha(0)
                Widget.clipFinished(Widget.ThreeLight, {})

                Widget.ThreeGlow:completeAnimation()
                Widget.ThreeGlow:setAlpha(0)
                Widget.clipFinished(Widget.ThreeGlow, {})

                Widget.Two:completeAnimation()
                Widget.Two:setAlpha(0)
                Widget.clipFinished(Widget.Two, {})

                Widget.TwoLight:completeAnimation()
                Widget.TwoLight:setAlpha(0)
                Widget.clipFinished(Widget.TwoLight, {})

                Widget.TwoGlow:completeAnimation()
                Widget.TwoGlow:setAlpha(0)
                Widget.clipFinished(Widget.TwoGlow, {})

                Widget.One:completeAnimation()
                Widget.One:setAlpha(0)
                Widget.clipFinished(Widget.One, {})

                Widget.OneLight:completeAnimation()
                Widget.OneLight:setAlpha(0)
                Widget.clipFinished(Widget.OneLight, {})

                Widget.OneGlow:completeAnimation()
                Widget.OneGlow:setAlpha(0)
                Widget.clipFinished(Widget.OneGlow, {})

                local function HandleZeroClip(Sender, Event)
                    local function HandleZeroClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 1500, false, false, CoD.TweenType.Linear)
                        end

                        Sender:setAlpha(1)

                        if Event.interrupted then
                            Widget.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleZeroClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1529, false, false, CoD.TweenType.Linear)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZeroClipStage2)
                    end
                end

                Widget.Zero:completeAnimation()
                Widget.Zero:setAlpha(0)
                HandleZeroClip(Widget.Zero, {})

                local function HandleZeroLightClip(Sender, Event)
                    local function HandleZeroLightClipStage2(Sender, Event)
                        local function HandleZeroLightClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1019, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)
                            Sender:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                            Sender:setShaderVector(0, 1, 0, 0, 0)
                            Sender:setShaderVector(1, 0, 0, 0, 0)
                            Sender:setShaderVector(2, 1.08, 0, 0, 0)
                            Sender:setShaderVector(3, 0.21, -0.23, 0, 0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleZeroLightClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 810, false, false, CoD.TweenType.Linear)
                            Sender:setShaderVector(2, 1.08, 0, 0, 0)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZeroLightClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZeroLightClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 189, false, false, CoD.TweenType.Linear)
                        Sender:setShaderVector(2, 0.26, 0, 0, 0)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZeroLightClipStage2)
                    end
                end

                Widget.ZeroLight:completeAnimation()
                Widget.ZeroLight:setAlpha(1)
                Widget.ZeroLight:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
                Widget.ZeroLight:setShaderVector(0, 1, 0, 0, 0)
                Widget.ZeroLight:setShaderVector(1, 0, 0, 0, 0)
                Widget.ZeroLight:setShaderVector(2, 0, 0, 0, 0)
                Widget.ZeroLight:setShaderVector(3, 0.21, -0.23, 0, 0)
                HandleZeroLightClip(Widget.ZeroLight, {})

                local function HandleZeroGlowClip(Sender, Event)
                    local function HandleZeroGlowClipStage2(Sender, Event)
                        local function HandleZeroGlowClipStage3(Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                            end

                            Sender:setAlpha(0)

                            if Event.interrupted then
                                Widget.clipFinished(Sender, Event)
                            else
                                Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                            end
                        end

                        if Event.interrupted then
                            HandleZeroGlowClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 1019, false, false, CoD.TweenType.Linear)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZeroGlowClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZeroGlowClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(1)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZeroGlowClipStage2)
                    end
                end

                Widget.ZeroGlow:completeAnimation()
                Widget.ZeroGlow:setAlpha(0)
                HandleZeroGlowClip(Widget.ZeroGlow, {})

                local function HandleZmFxSpark2Ext0Clip(Sender, Event)
                    local function HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        local function HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            local function HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                local function HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    local function HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        local function HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            local function HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                if not Event.interrupted then
                                                    Sender:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
                                                end

                                                Sender:setLeftRight(true, false, -21.56, 90.44)
                                                Sender:setTopBottom(true, false, -73, 95)
                                                Sender:setAlpha(0)
                                                
                                                if Event.interrupted then
                                                    Widget.clipFinished(Sender, Event)
                                                else
                                                    Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                                end
                                            end

                                            if Event.interrupted then
                                                HandleZmFxSpark2Ext0ClipStage8(Sender, Event)
                                                return 
                                            else
                                                Sender:beginAnimation("keyframe", 99, false, false, CoD.TweenType.Linear)
                                                Sender:setLeftRight(true, false, -21.56, 90.44)
                                                Sender:setTopBottom(true, false, -73, 95)
                                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage8)
                                            end
                                        end

                                        if Event.interrupted then
                                            HandleZmFxSpark2Ext0ClipStage7(Sender, Event)
                                            return 
                                        else
                                            Sender:beginAnimation("keyframe", 90, false, false, CoD.TweenType.Linear)
                                            Sender:setLeftRight(true, false, -28, 84)
                                            Sender:setTopBottom(true, false, -79.83, 88.17)
                                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage7)
                                        end
                                    end

                                    if Event.interrupted then
                                        HandleZmFxSpark2Ext0ClipStage6(Sender, Event)
                                        return 
                                    else
                                        Sender:beginAnimation("keyframe", 99, false, false, CoD.TweenType.Linear)
                                        Sender:setLeftRight(true, false, -34.56, 77.44)
                                        Sender:setTopBottom(true, false, -88, 80)
                                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage6)
                                    end
                                end

                                if Event.interrupted then
                                    HandleZmFxSpark2Ext0ClipStage5(Sender, Event)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 110, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -36.08, 75.92)
                                    Sender:setTopBottom(true, false, -98.38, 69.62)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage5)
                                end
                            end

                            if Event.interrupted then
                                HandleZmFxSpark2Ext0ClipStage4(Sender, Event)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 159, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, -33.56, 78.44)
                                Sender:setTopBottom(true, false, -120.29, 47.71)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage4)
                            end
                        end

                        if Event.interrupted then
                            HandleZmFxSpark2Ext0ClipStage3(Sender, Event)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, -28, 84)
                            Sender:setTopBottom(true, false, -128, 40)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage3)
                        end
                    end

                    if Event.interrupted then
                        HandleZmFxSpark2Ext0ClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 189, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext0ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext0:completeAnimation()
                Widget.ZmFxSpark2Ext0:setLeftRight(true, false, -14.56, 97.44)
                Widget.ZmFxSpark2Ext0:setTopBottom(true, false, -137.29, 30.71)
                Widget.ZmFxSpark2Ext0:setAlpha(0)
                HandleZmFxSpark2Ext0Clip(Widget.ZmFxSpark2Ext0, {})

                local function HandleZmFxSpark2Ext00Clip(Sender, f182_arg1)
                    local function HandleZmFxSpark2Ext00ClipStage2(Sender, f195_arg1)
                        local function HandleZmFxSpark2Ext00ClipStage3(Sender, f196_arg1)
                            local function HandleZmFxSpark2Ext00ClipStage4(Sender, f197_arg1)
                                local function HandleZmFxSpark2Ext00ClipStage5(Sender, f198_arg1)
                                    if not f198_arg1.interrupted then
                                        Sender:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
                                    end
                                    Sender:setLeftRight(true, false, -10, 102)
                                    Sender:setTopBottom(true, false, -74.01, 94.01)
                                    Sender:setAlpha(0)
                                    if f198_arg1.interrupted then
                                        Widget.clipFinished(Sender, f198_arg1)
                                    else
                                        Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                                    end
                                end

                                if f197_arg1.interrupted then
                                    HandleZmFxSpark2Ext00ClipStage5(Sender, f197_arg1)
                                    return 
                                else
                                    Sender:beginAnimation("keyframe", 259, false, false, CoD.TweenType.Linear)
                                    Sender:setLeftRight(true, false, -10, 102)
                                    Sender:setTopBottom(true, false, -74.01, 94.01)
                                    Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage5)
                                end
                            end

                            if f196_arg1.interrupted then
                                HandleZmFxSpark2Ext00ClipStage4(Sender, f196_arg1)
                                return 
                            else
                                Sender:beginAnimation("keyframe", 289, false, false, CoD.TweenType.Linear)
                                Sender:setLeftRight(true, false, 4.44, 116.44)
                                Sender:setTopBottom(true, false, -94, 74)
                                Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage4)
                            end
                        end

                        if f195_arg1.interrupted then
                            HandleZmFxSpark2Ext00ClipStage3(Sender, f195_arg1)
                            return 
                        else
                            Sender:beginAnimation("keyframe", 159, false, false, CoD.TweenType.Linear)
                            Sender:setLeftRight(true, false, 1.57, 113.57)
                            Sender:setTopBottom(true, false, -113.45, 54.55)
                            Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage3)
                        end
                    end

                    if f182_arg1.interrupted then
                        HandleZmFxSpark2Ext00ClipStage2(Sender, f182_arg1)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 189, false, false, CoD.TweenType.Linear)
                        Sender:setAlpha(0.8)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZmFxSpark2Ext00ClipStage2)
                    end
                end

                Widget.ZmFxSpark2Ext00:completeAnimation()
                Widget.ZmFxSpark2Ext00:setLeftRight(true, false, -3.56, 108.44)
                Widget.ZmFxSpark2Ext00:setTopBottom(true, false, -128, 40)
                Widget.ZmFxSpark2Ext00:setAlpha(0)
                HandleZmFxSpark2Ext00Clip(Widget.ZmFxSpark2Ext00, {})
            end
        }
    }

	LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function(Sender)
		Sender.ZmFxSpark2Ext0:close()
		Sender.ZmFxSpark2Ext00:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(Widget, InstanceRef, HudRef)
	end
    
	return Widget
end