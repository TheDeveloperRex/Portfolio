require( "ui.uieditor.widgets.HUD.ZM_Perks.ZMPerksContainerFactory" )
require( "ui.uieditor.widgets.HUD.ZM_RoundWidget.ZmRndContainer" )
require( "ui.uieditor.widgets.HUD.ZM_AmmoWidgetFactory.ZmAmmoContainerFactory" )
require( "ui.uieditor.widgets.HUD.ZM_Score.ZMScr" )
require( "ui.uieditor.widgets.DynamicContainerWidget" )
require( "ui.uieditor.widgets.Notifications.Notification" )
require( "ui.uieditor.widgets.HUD.ZM_NotifFactory.ZmNotifBGB_ContainerFactory" )
require( "ui.uieditor.widgets.HUD.ZM_CursorHint.ZMCursorHint" )
require( "ui.uieditor.widgets.HUD.CenterConsole.CenterConsole" )
require( "ui.uieditor.widgets.HUD.DeadSpectate.DeadSpectate" )
require( "ui.uieditor.widgets.MPHudWidgets.ScorePopup.MPScr" )
require( "ui.uieditor.widgets.HUD.ZM_PrematchCountdown.ZM_PrematchCountdown" )
require( "ui.uieditor.widgets.Scoreboard.CP.ScoreboardWidgetCP" )
require( "ui.uieditor.widgets.HUD.ZM_TimeBar.ZM_BeastmodeTimeBarWidget" )
require( "ui.uieditor.widgets.ZMInventory.RocketShieldBluePrint.RocketShieldBlueprintWidget" )
require( "ui.uieditor.widgets.Chat.inGame.IngameChatClientContainer" )
require( "ui.uieditor.widgets.BubbleGumBuffs.BubbleGumPackInGame" )

require( "ui.utility.Progression" )
require( "ui.utility.FontLoader" )
require( "ui.utility.CoreUtil" )
require( "ui.utility.json" )

--require( "ui.uieditor.menus.StartMenu.T6StartMenu_Main" )

-- REX - ColdWar HUD
require( "ui.uieditor.widgets.REX.ColdWar.Perks.CWPerksContainer" )
require( "ui.uieditor.widgets.REX.ColdWar.Ammo.CWAmmoContainer" )
require( "ui.uieditor.widgets.REX.ColdWar.Score.CWScoreContainer" )
require( "ui.uieditor.widgets.REX.ColdWar.Scoreboard.CWScoreboardContainer" )
require( "ui.uieditor.widgets.REX.ColdWar.Round.ColdWarZmRndContainer" )
require( "ui.uieditor.widgets.REX.ColdWar.PowerUps.CWPowerUpsPopUp" )
require( "ui.uieditor.widgets.REX.ColdWar.PowerUps.CWPowerUps" )
require( "ui.uieditor.widgets.REX.ColdWar.Misc.CWProgressionPopup" )
require( "ui.uieditor.widgets.REX.ColdWar.Misc.CWHitmarker" )
require( "ui.uieditor.widgets.REX.ColdWar.Boss.CWBossContainer" )

CoD.Zombie.CommonHudRequire()

CoD.PowerUps.ClientFieldNames = {
    {
        clientFieldName = "powerup_instant_kill",
        material = RegisterMaterial("rex_coldwar_ui_powerup_insta_kill" )
    },
    {
        clientFieldName = "powerup_double_points",
        material = RegisterMaterial( "rex_coldwar_ui_powerup_double_points" ),
        z_material = RegisterMaterial( "specialty_doublepoints_zombies_blue" )
    },
    {
        clientFieldName = "powerup_fire_sale",
        material = RegisterMaterial( "rex_coldwar_ui_powerup_fire_sale" )
    },
    {
        clientFieldName = "powerup_bon_fire",
        material = RegisterMaterial( "rex_coldwar_ui_powerup_fire_sale" )
    },
    {
        clientFieldName = "powerup_mini_gun",
        material = RegisterMaterial( "rex_coldwar_ui_powerup_minigun" )
    },
    {
        clientFieldName = "powerup_zombie_blood",
        material = RegisterMaterial( "rex_coldwar_ui_powerup_zombie_blood" )
    }
}

local PreLoadFunc = function( self, controller )
    FontLoader( self, { 
		"MaximaTOTBold-Regular",
		"MaximaEF-Medium",
		"DroidSans-Bold",
		"Digital7"
	})
	CoD.Zombie.CommonPreLoadHud( self, controller )
end	

local PostLoadFunc = function( self, controller )
    CoD.Zombie.CommonPostLoadHud( self, controller )
end

LUI.createMenu.T7Hud_zm_factory = function( controller )
    local self = CoD.Menu.NewForUIEditor("T7Hud_zm_factory")

    if PreLoadFunc then
        PreLoadFunc(self, controller)
    end

    self.soundSet = "HUD"
    self:setOwner( controller )
    self:setLeftRight( true, true, 0, 0 )
    self:setTopBottom( true, true, 0, 0 )
    self:playSound( "menu_open", controller )
    self.buttonModel = Engine.CreateModel( Engine.GetModelForController( controller ), "T7Hud_zm_factory.buttonPrompts" )
    self.anyChildUsesUpdateState = true
    
    self.PerksWidget = CoD.CWPerksContainer.new( self, controller )
    self.PerksWidget:setLeftRight( true, true, 0, 0 )
    self.PerksWidget:setTopBottom( true, true, 0, 0 )
    self:addElement( self.PerksWidget )
    self.ZMPerksContainerFactory = self.PerksWidget

    self.RoundCounter = CoD.ColdWarZmRndContainer.new( self, controller )
    self.RoundCounter:setLeftRight( false, true, -170, 56 )
    self.RoundCounter:setTopBottom( true, false, -50, 150 )
    self.RoundCounter:setScale( 0.8 )
    self:addElement(self.RoundCounter)
    self.Rounds = self.RoundCounter
    
    self.AmmoWidget = CoD.CWAmmoContainer.new( self, controller )
    self.AmmoWidget:setLeftRight( false, true, -400, 0 )
    self.AmmoWidget:setTopBottom( false, true, -100, 0 )
    self:addElement( self.AmmoWidget )
    self.Ammo = self.AmmoWidget
    
    self.ScoreWidget = CoD.CWScoreContainer.new( self, controller )
    self.ScoreWidget:setLeftRight( true, false, 0, 200 )
    self.ScoreWidget:setTopBottom( false, true, -720, 0 )
    self:addElement( self.ScoreWidget )
    self.Score = self.ScoreWidget

    self.fullscreenContainer = CoD.DynamicContainerWidget.new( self, controller )
	self.fullscreenContainer:setLeftRight( false, false, -640, 640 )
	self.fullscreenContainer:setTopBottom( false, false, -360, 360 )
	self:addElement( self.fullscreenContainer )
	
	self.Notifications = CoD.Notification.new( self, controller )
	self.Notifications:setLeftRight( true, true, 0, 0 )
	self.Notifications:setTopBottom( true, true, 0, 0 )
	self:addElement( self.Notifications )
	
	self.ZmNotifBGBContainerFactory = CoD.ZmNotifBGB_ContainerFactory.new( self, controller )
	self.ZmNotifBGBContainerFactory:setLeftRight( false, false, -156, 156 )
	self.ZmNotifBGBContainerFactory:setTopBottom( true, false, -6, 247 )
	self.ZmNotifBGBContainerFactory:setScale( 0.75 )
	--self:addElement( self.ZmNotifBGBContainerFactory )
	
	self.ZmNotifBGBContainerFactory:subscribeToGlobalModel( controller, "PerController", "scriptNotify", function( ModelRef )
		if IsParamModelEqualToString( ModelRef, "zombie_bgb_token_notification" ) then
			AddZombieBGBTokenNotification( self, self.ZmNotifBGBContainerFactory, controller, ModelRef )
		elseif IsParamModelEqualToString( ModelRef, "zombie_bgb_notification" ) then
			AddZombieBGBNotification(self, self.ZmNotifBGBContainerFactory, ModelRef )
		elseif IsParamModelEqualToString( ModelRef, "zombie_notification" ) then
			AddZombieNotification( self, self.ZmNotifBGBContainerFactory, ModelRef )
		end
	end)
    
    self.CursorHint = CoD.ZMCursorHint.new( self, controller )
	self.CursorHint:setLeftRight( false, false, -250, 250 )
	self.CursorHint:setTopBottom( true, false, 522, 616 )
    self.CursorHint.cursorhinttext0.CursorHintText:setTTF( "fonts/DroidSans-Bold.ttf" )
	self.CursorHint.cursorhinttext0.CursorHintText:setLeftRight( false, false, -256, 256 )
	self.CursorHint.cursorhinttext0.CursorHintText:setTopBottom( true, false, -10, 6 )
    self.CursorHint.cursorhinttext0.FEButtonPanel0:setRGB( 1, 1, 1 )
    self.CursorHint.cursorhinttext0.FEButtonPanel0:setAlpha( 0.9 )
    self.CursorHint.cursorhinttext0.FEButtonPanel0.Image:setImage( RegisterImage( "rex_coldwar_ui_cursorhint_bg" ) )
    self.CursorHint.cursorhinttext0.FEButtonPanel0.Image:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
    self.CursorHint.cursorhinttext0.FEButtonPanel0.Image:setLeftRight( true, true, -10, 10 )
    self.CursorHint.cursorhinttext0.FEButtonPanel0.Image:setTopBottom( true, true, -20, 0 )
	self:addElement( self.CursorHint )

	self.CursorHint.StateTable = {
		{
			stateName = "Active_1x1",
			condition = function( self, ItemRef, UpdateTable )
				local Active = IsCursorHintActive( controller )
				if Active then
					if Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE ) or not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) or Engine.GetModelValue( Engine.GetModel( DataSources.HUDItems.getModel( controller ), "cursorHintIconRatio" ) ) ~= 1 then
						Active = false
					else
						Active = true
					end
				end
				return Active
			end
		},
		{
			stateName = "Active_2x1",
			condition = function(self, ItemRef, UpdateTable)
				local Active = IsCursorHintActive( controller )
				if Active then
					if Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE ) or not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) or Engine.GetModelValue( Engine.GetModel( DataSources.HUDItems.getModel( controller ), "cursorHintIconRatio" ) ) ~= 2 then
						Active = false
					else
						Active = true
					end
				end
				return Active
			end
		},
		{
			stateName = "Active_4x1",
			condition = function( self, ItemRef, UpdateTable )
				local Active = IsCursorHintActive( controller )
				if Active then
					if Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE ) or not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT ) or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) or Engine.GetModelValue( Engine.GetModel( DataSources.HUDItems.getModel( controller ), "cursorHintIconRatio" ) ) ~= 4 then
						Active = false
					else
						Active = true
					end
				end
				return Active
			end
		},
		{
			stateName = "Active_NoImage",
			condition = function( self, ItemRef, UpdateTable )
				local Active = IsCursorHintActive( controller )
				if Active then
					if not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE ) and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE ) and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ) and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING ) and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ) and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK ) and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT ) and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) then
						Active = IsModelValueEqualTo( controller, "hudItems.cursorHintIconRatio", 0 )
					else
						Active = false
					end
				end
				return Active
			end
		}
	}
	self.CursorHint:mergeStateConditions(self.CursorHint.StateTable)

    SubscribeToModelAndUpdateState( controller, self, self.CursorHint, "hudItems.showCursorHint" )
    SubscribeToModelAndUpdateState( controller, self, self.CursorHint, "hudItems.cursorHintIconRatio" )

    SubscribeToVisibilityBitAndUpdateElementState( controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
    SubscribeToVisibilityBitAndUpdateElementState( controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
    SubscribeToVisibilityBitAndUpdateElementState( controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
    SubscribeToVisibilityBitAndUpdateElementState( controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_UI_ACTIVE )
    SubscribeToVisibilityBitAndUpdateElementState( controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
    SubscribeToVisibilityBitAndUpdateElementState( controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT )
    SubscribeToVisibilityBitAndUpdateElementState( controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK )
    SubscribeToVisibilityBitAndUpdateElementState( controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING )
    
    self.ConsoleCenter = CoD.CenterConsole.new(self, controller)
	self.ConsoleCenter:setLeftRight(false, false, -370, 370)
	self.ConsoleCenter:setTopBottom(true, false, 68.5, 166.5)
	self:addElement(self.ConsoleCenter)
	
	self.DeadSpectate = CoD.DeadSpectate.new(self, controller)
	self.DeadSpectate:setLeftRight(false, false, -150, 150)
	self.DeadSpectate:setTopBottom(false, true, -180, -120)
	self:addElement(self.DeadSpectate)
	
	self.MPScore = CoD.MPScr.new( self, controller )
	self.MPScore:setLeftRight(true, false, 763.5, 863.5)
	self.MPScore:setTopBottom(true, false, 331, 356)
    self.MPScore.ScoreFeedGlow:setScale( 0 )
    self.MPScore.Score:setLeftRight(false, false, 0, 0 )
    self.MPScore.Score:setTopBottom(false, false, 0, 0 )
	self.MPScore.Score:setTTF( "fonts/DroidSans-Bold.ttf" )
	self.MPScore.ScoreFeedItem0.TextBox:setTTF( "fonts/DroidSans-Bold.ttf" )
	self.MPScore:subscribeToGlobalModel( controller, "PerController", "scriptNotify", function( ModelRef )
		if IsParamModelEqualToString( ModelRef, "score_event" ) and PropertyIsTrue( self, "menuLoaded" ) then
			PlayClipOnElement( self, {
				elementName = "MPScore",
				clipName = "NormalScore"
			}, controller )

			SetMPScoreText( self, self.MPScore, controller, ModelRef )

			for elemNum = 10, 1, -1 do
				local elem = self.MPScore[ "ScoreFeedItem" .. elemNum ]
				
				if elem and elem.text then
					elem.TextBox:setTTF( "fonts/DroidSans-Bold.ttf" )
				end
			end
		end
	end)
	self:addElement( self.MPScore )
    
    self.ZMPrematchCountdown0 = CoD.ZM_PrematchCountdown.new(self, controller)
	self.ZMPrematchCountdown0:setLeftRight(false, false, -640, 640)
	self.ZMPrematchCountdown0:setTopBottom(false, false, -360, 360)
	self:addElement(self.ZMPrematchCountdown0)
	
	self.Scoreboard = CoD.CWScoreboardContainer.new( self, controller )
	self.Scoreboard:setLeftRight( true, true, 0, 0 )
	self.Scoreboard:setTopBottom( true, true, 0, 0 )
	self:addElement( self.Scoreboard )
	
	self.ZMBeastBar = CoD.ZM_BeastmodeTimeBarWidget.new(self, controller)
	self.ZMBeastBar:setLeftRight(false, false, -242.5, 321.5)
	self.ZMBeastBar:setTopBottom(false, true, -174, -18)
	self.ZMBeastBar:setScale(0.7)
	self:addElement(self.ZMBeastBar)
	
	self.RocketShieldBlueprintWidget = CoD.RocketShieldBlueprintWidget.new(self, controller)
	self.RocketShieldBlueprintWidget:setLeftRight(true, false, -36.5, 277.5)
	self.RocketShieldBlueprintWidget:setTopBottom(true, false, 104, 233)
	self.RocketShieldBlueprintWidget:setScale(0.8)
	self:addElement(self.RocketShieldBlueprintWidget)
	
	self.RocketShieldBlueprintWidget.StateTable = {
		{
			stateName = "Scoreboard",
			condition = function(self, ItemRef, UpdateTable)
				local condition = Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
				if condition then
					condition = AlwaysFalse()
				end

				return condition
			end
		}
	}
	self.RocketShieldBlueprintWidget:mergeStateConditions(self.RocketShieldBlueprintWidget.StateTable)

    SubscribeToModelAndUpdateState(controller, self, self.CursorHint, "zmInventory.widget_shield_parts")
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
    
    self.IngameChatClientContainer = CoD.IngameChatClientContainer.new(self, controller)
	self.IngameChatClientContainer:setLeftRight(true, false, 0, 360)
	self.IngameChatClientContainer:setTopBottom(true, false, -2.5, 717.5)
	self:addElement(self.IngameChatClientContainer)
	
	self.IngameChatClientContainer0 = CoD.IngameChatClientContainer.new(self, controller)
	self.IngameChatClientContainer0:setLeftRight(true, false, 0, 360)
	self.IngameChatClientContainer0:setTopBottom(true, false, -2.5, 717.5)
	self:addElement(self.IngameChatClientContainer0)
	
	self.BubbleGumPackInGame = CoD.BubbleGumPackInGame.new(self, controller)
	self.BubbleGumPackInGame:setLeftRight(false, false, -184, 184)
	self.BubbleGumPackInGame:setTopBottom(true, false, 36, 185)
	--self:addElement(self.BubbleGumPackInGame)

	self.Hitmarker = CoD.CWHitmarker.new( self, controller )
	self.Hitmarker:setLeftRight( false, false, 0, 0 )
	self.Hitmarker:setTopBottom( false, false, 0, 0 )
	self.Hitmarker:setScale( 0.5 )
	self:addElement( self.Hitmarker )

	self.BossHealthBar = CoD.CWBossContainer.new( self, controller )
	self.BossHealthBar:setLeftRight( false, false, -250, 250 )
	self.BossHealthBar:setTopBottom( true, false, 48, 80 )
	self:addElement( self.BossHealthBar )

	self.PowerUpsPopUp = CoD.CWPowerUpsPopUp.new( self, controller )
	self.PowerUpsPopUp:setLeftRight( true, true, 0, 0 )
	self.PowerUpsPopUp:setTopBottom( true, true, 0, 0 )
	self:addElement( self.PowerUpsPopUp )

	self.ProgressionPopup = CoD.CWProgressionPopup.new( self, controller )
	self.ProgressionPopup:setLeftRight( false, false, -70, 70 )
	self.ProgressionPopup:setTopBottom( true, false, 10, 185 )
	self:addElement( self.ProgressionPopup )

	self.Score.navigation = {
		up = self.Scoreboard,
		right = self.Scoreboard
	}

	self.Scoreboard.navigation = {
		left = self.Score,
		down = self.Score
	}
	
	CoD.Menu.AddNavigationHandler( self, self, controller )
    
    self:registerEventHandler( "menu_loaded", function( element, Event )
		SizeToSafeArea( element, controller )
		SetProperty( self, "menuLoaded", true )
		return element:dispatchEventToChildren( Event )
	end)

	self:subscribeToGlobalModel( controller, "PerController", "scriptNotify", function( ModelRef )
		if IsParamModelEqualToString( ModelRef, "WriteData" ) then
			local val = CoD.GetScriptNotifyData( ModelRef )
            
			UpdateFileData( self, controller, val[ 1 ] )
		elseif IsParamModelEqualToString( ModelRef, "RetrieveData" ) then
			local val = CoD.GetScriptNotifyData( ModelRef )
            
            if val and val[ 1 ] == 1 then
				Prestige( self, controller )
			end
			local currentData = RetrieveFileData( self, controller )
			Engine.SendMenuResponse( controller, "ProgressionData", currentData )
		end
	end)

	self.Score.id = "Score"
	self.Scoreboard.id = "ScoreboardContainer"

	self:processEvent({
		name = "menu_loaded",
		controller = controller
	})
	self:processEvent({
		name = "update_state",
		menu = self
	})

	if not self:restoreState() then
		self.Scoreboard:processEvent({
			name = "gain_focus",
			controller = controller
		})
	end

	SubscribeToModelAndUpdateState( controller, self, self, "hudItems.ProgressionData" )
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(element)
		element.ZMPerksContainerFactory:close()
		element.Rounds:close()
		element.Ammo:close()
		element.Score:close()
		element.fullscreenContainer:close()
		element.Notifications:close()
		element.ZmNotifBGBContainerFactory:close()
		element.CursorHint:close()
		element.ConsoleCenter:close()
		element.DeadSpectate:close()
		element.MPScore:close()
		element.ZMPrematchCountdown0:close()
		element.Scoreboard:close()
		element.ZMBeastBar:close()
		element.RocketShieldBlueprintWidget:close()
		element.IngameChatClientContainer:close()
		element.IngameChatClientContainer0:close()
		element.BubbleGumPackInGame:close()
		element.Hitmarker:close()
		element.BossHealthBar:close()
		element.PowerUpsPopUp:close()
		element.ProgressionPopup:close()

		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "T7Hud_zm_factory.buttonPrompts"))
	end)

	if PostLoadFunc then
		PostLoadFunc( self, controller )
	end

	return self
end