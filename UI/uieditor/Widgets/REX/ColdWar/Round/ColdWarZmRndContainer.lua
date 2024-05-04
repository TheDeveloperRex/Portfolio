require("ui.uieditor.widgets.REX.ColdWar.Round.ColdWarZmRnd")

CoD.ColdWarZmRndContainer = InheritFrom(LUI.UIElement)
CoD.ColdWarZmRndContainer.new = function(HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(Widget, InstanceRef)
	end

    local spawnedBreadcrumbModel = Engine.CreateModel(Engine.GetModelForController(InstanceRef), "spawnedBreadcrumb")
    Engine.SetModelValue(spawnedBreadcrumbModel, false)

	Widget:setUseStencil(false)
	Widget:setClass(CoD.ColdWarZmRndContainer)
	Widget.id = "ColdWarZmRndContainer"
	Widget.soundSet = "HUD"
	Widget:setLeftRight(true, false, 0, 224)
	Widget:setTopBottom(true, false, 0, 200)
	Widget.anyChildUsesUpdateState = true

    -- Added double container so that I can manipulate position of child but alpha of parent, allowing movement to occur independently of visibility state - 12/25/2020
    Widget.ZmRndMoverContainer = LUI.UIElement.new()
    Widget.ZmRndMoverContainer:setLeftRight(true, true, 0, 0)
    Widget.ZmRndMoverContainer:setTopBottom(true, true, 0, 0)
    Widget:addElement(Widget.ZmRndMoverContainer)

	Widget.ZmRndMoverContainer.ZmRnd = CoD.ColdWarZmRnd.new(HudRef, InstanceRef)
	Widget.ZmRndMoverContainer.ZmRnd:setLeftRight(true, false, 0, 224)
	Widget.ZmRndMoverContainer.ZmRnd:setTopBottom(false, true, -200, 0)
	Widget.ZmRndMoverContainer:addElement(Widget.ZmRndMoverContainer.ZmRnd)

	Widget.ZmRndMoverContainer.ZmRnd:subscribeToGlobalModel(InstanceRef, "GameScore", nil, function(ModelRef)
		Widget.ZmRndMoverContainer.ZmRnd:setModel(ModelRef, InstanceRef)
	end)

	Widget.ZmRndMoverContainer.ZmRnd:linkToElementModel(Widget.ZmRndMoverContainer.ZmRnd, "roundsPlayed", true, function(ModelRef)
		Widget.ZmRndMoverContainer:playClip("BeginTransition")
        Widget.ZmRndMoverContainer.nextClip = "EndTransition"
	end)

    -- Adjust position of ZmRnd element based on round number.
    local function CalculateZMRndOffset()
        local offset = 704
        local roundNumber = Engine.GetModelValue(Engine.GetModel(Widget.ZmRndMoverContainer.ZmRnd:getModel(), "roundsPlayed")) - 1

        if roundNumber <= 3 then
            offset = offset - 24
        elseif roundNumber > 5 and roundNumber < 10 then
            offset = offset + 20
        elseif roundNumber > 99 then
            offset = offset - 20    
        end

        return offset
    end
    Widget.ZmRndMoverContainer.clipsPerState = {
        DefaultState = {
            BeginTransition = function()
                Widget.ZmRndMoverContainer:setupElementClipCounter(1)

                local function HandleZMRndClip(Sender, Event)
                    local function HandleZMRndClipStage2(Sender, Event)
                        if not Event.interrupted then
                            Sender:beginAnimation("keyframe", 2300, false, false, CoD.TweenType.Linear)
                        end

                        if Event.interrupted then
                            Widget.ZmRndMoverContainer.clipFinished(Sender, Event)
                        else
                            Sender:registerEventHandler("transition_complete_keyframe", Widget.ZmRndMoverContainer.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleZMRndClipStage2(Sender, Event)
                        return 
                    else
                        Sender:beginAnimation("keyframe", 125, true, false, CoD.TweenType.Linear)
                        Sender:setLeftRight(true, false, 0-CalculateZMRndOffset(), 244-CalculateZMRndOffset())
                        Sender:setScale(1.25)
                        Sender:registerEventHandler("transition_complete_keyframe", HandleZMRndClipStage2)
                    end
                end
                
                Widget.ZmRndMoverContainer.ZmRnd:completeAnimation()
                Widget.ZmRndMoverContainer.ZmRnd:setLeftRight(true, false, 0, 244)
                HandleZMRndClip(Widget.ZmRndMoverContainer.ZmRnd, {})
	        end,
            EndTransition = function()
                Widget.ZmRndMoverContainer:setupElementClipCounter(1)

                local function HandleZMRndClip(Sender, Event)
                    if not Event.interrupted then
                        Sender:beginAnimation("keyframe", 175, false, true, CoD.TweenType.Linear)
                    end

                    Sender:setLeftRight(true, false, 0, 244)
                    Sender:setScale(1)

                    if Event.interrupted then
                        Widget.ZmRndMoverContainer.clipFinished(Sender, Event)
                    else
                        Sender:registerEventHandler("transition_complete_keyframe", Widget.ZmRndMoverContainer.clipFinished)
                    end
                end
                
                Widget.ZmRndMoverContainer.ZmRnd:completeAnimation()
                Widget.ZmRndMoverContainer.ZmRnd:setLeftRight(true, false, 0-CalculateZMRndOffset(), 244-CalculateZMRndOffset())
                Widget.ZmRndMoverContainer.ZmRnd:setScale(1.15)
                HandleZMRndClip(Widget.ZmRndMoverContainer.ZmRnd, {})
	        end
        }
    }

	Widget.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Widget:setupElementClipCounter(1)

                Widget.ZmRndMoverContainer:completeAnimation()
                Widget.ZmRndMoverContainer:setAlpha(1)
                Widget.clipFinished(Widget.ZmRndMoverContainer, {})
	        end,
            Invisible = function()
                Widget:setupElementClipCounter(1)

                local function HandleZMRndClip(Sender, Event)
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
                
                Widget.ZmRndMoverContainer:completeAnimation()
                Widget.ZmRndMoverContainer:setAlpha(1)
                HandleZMRndClip(Widget.ZmRndMoverContainer, {})
	        end
        },
        Invisible = {
            DefaultClip = function()
                Widget:setupElementClipCounter(1)

                Widget.ZmRndMoverContainer:completeAnimation()
                Widget.ZmRndMoverContainer:setAlpha(0)
                Widget.clipFinished(Widget.ZmRndMoverContainer, {})
	        end,
            DefaultState = function()
                Widget:setupElementClipCounter(1)

                local function HandleZMRndClip(Sender, Event)
                    if not Event.interrupted then
                        Sender:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)
                    end

                    Sender:setAlpha(1)

                    if Event.interrupted then
                        Widget.clipFinished(Sender, Event)
                    else
                        Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
                    end
                end

                Widget.ZmRndMoverContainer:completeAnimation()
                Widget.ZmRndMoverContainer:setAlpha(0)
                HandleZMRndClip(Widget.ZmRndMoverContainer, {})
            end
        }
    }

    Widget.StateTable = {
        {
            stateName = "Invisible",
            condition = function(HudRef, ItemRef, UpdateTable)
                if IsModelValueTrue(InstanceRef, "hudItems.playerSpawned") then
                    if Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_GAME_ENDED) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_KILLCAM) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_SCOPED) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_VEHICLE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC) then
                        if Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_EMP_ACTIVE) then
                            return true
                        else
                            return false
                        end
                    end

                    return not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_GAME_ENDED)
                end
                
                return false
            end
        }
    }
	Widget:mergeStateConditions(Widget.StateTable)

	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "hudItems.playerSpawned"), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "hudItems.playerSpawned"})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE), function(ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE})
	end)

    LUI.OverrideFunction_CallOriginalFirst(Widget, "setState", function(Widget, StateName)
        if Engine.GetModelValue(spawnedBreadcrumbModel) == false then
            if IsSelfInState(Widget, "DefaultState") then
                Widget.ZmRndMoverContainer:playClip("BeginTransition")
                Widget.ZmRndMoverContainer.nextClip = "EndTransition"
            end
        end

        Engine.SetModelValue(spawnedBreadcrumbModel, true)
    end)

	LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function(Sender)
		Sender.ZmRndMoverContainer.ZmRnd:close()
		Sender.ZmRndMoverContainer:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(Widget, InstanceRef, HudRef)
	end
    
	return Widget
end