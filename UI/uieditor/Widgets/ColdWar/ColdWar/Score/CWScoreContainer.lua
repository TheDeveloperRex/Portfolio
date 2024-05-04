require( "ui.uieditor.widgets.REX.ColdWar.Score.CWClientScore" )
require( "ui.uieditor.widgets.REX.ColdWar.Score.CWSelfScore" )
require( "ui.utility.CoreUtil" )

CoD.CWScoreContainer = InheritFrom( LUI.UIElement )

function CoD.CWScoreContainer.new( menu, controller )

	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end
	
	self:setClass( CoD.CWScoreContainer )
	self.id = "CWScoreContainer"
	self.soundSet = "HUD"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	self:setLeftRight( true, false, 0, 200 )
    self:setTopBottom( true, false, 0, 720 )

	local SelfScore = LUI.UIList.new( menu, controller, 2, 0, nil, false, false, 0, 0, false, false )
	SelfScore:setLeftRight( true, false, 0, 200 )
	SelfScore:setTopBottom( true, false, 645, 720 )
	SelfScore:setWidgetType( CoD.CWSelfScore )
	SelfScore:setDataSource( "PlayerListZM" )
	self:addElement( SelfScore )
    self.SelfScore = SelfScore

	local Client2Score = CoD.CWClientScore.new( menu, controller )
	Client2Score:setLeftRight( true, false, 0, 130 )
	Client2Score:setTopBottom( true, false, 592, 634 )
	Client2Score:subscribeToGlobalModel( controller, "ZMPlayerList", "1", function ( ModelRef )
		Client2Score:setModel( ModelRef, controller )
	end)
	self:addElement( Client2Score )
	self.Client2Score = Client2Score
	
	local Client3Score = CoD.CWClientScore.new( menu, controller )
	Client3Score:setLeftRight( true, false, 0, 130 )
	Client3Score:setTopBottom( true, false, 545, 587 )
	Client3Score:subscribeToGlobalModel( controller, "ZMPlayerList", "2", function ( ModelRef )
		Client3Score:setModel( ModelRef, controller )
	end)
	self:addElement( Client3Score )
	self.Client3Score = Client3Score
	
	local Client4Score = CoD.CWClientScore.new( menu, controller )
	Client4Score:setLeftRight( true, false, 0, 130 )
	Client4Score:setTopBottom( true, false, 498, 540 )
	Client4Score:subscribeToGlobalModel( controller, "ZMPlayerList", "3", function ( ModelRef )
		Client4Score:setModel( ModelRef, controller )
	end)
	self:addElement( Client4Score )
	self.Client4Score = Client4Score

	self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 4 )

                SelfScore:completeAnimation()
                self.SelfScore:setAlpha( 1 )
                self.clipFinished( SelfScore, {} )

				Client2Score:completeAnimation()
                self.Client2Score:setAlpha( 1 )
                self.clipFinished( Client2Score, {} )

				Client3Score:completeAnimation()
                self.Client3Score:setAlpha( 1 )
                self.clipFinished( Client3Score, {} )

				Client4Score:completeAnimation()
                self.Client4Score:setAlpha( 1 )
                self.clipFinished( Client4Score, {} )
            end
        },
		Hidden = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

                SelfScore:completeAnimation()
                self.SelfScore:setAlpha( 0 )
                self.clipFinished( SelfScore, {} )

				Client2Score:completeAnimation()
                self.Client2Score:setAlpha( 0 )
                self.clipFinished( Client2Score, {} )

				Client3Score:completeAnimation()
                self.Client3Score:setAlpha( 0 )
                self.clipFinished( Client3Score, {} )

				Client4Score:completeAnimation()
                self.Client4Score:setAlpha( 0 )
                self.clipFinished( Client4Score, {} )
            end
		}
    }

	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				if not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
				and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) then
					return false
				else
					return true
				end
			end
		}
	})

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.playerSpawned" )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )

	self.SelfScore.id = "SelfScore"

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.SelfScore:close()
		element.Client2Score:close()
		element.Client3Score:close()
		element.Client4Score:close()
	end)

	if PostLoadFunc then
		PostLoadFunc( menu, controller )
	end

	return self
end

