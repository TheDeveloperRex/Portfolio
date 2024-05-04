require( "ui.uieditor.widgets.REX.ColdWar.Scoreboard.CWScoreboard" )
require( "ui.uieditor.widgets.REX.ColdWar.Scoreboard.CWSelfScoreboard" )

CoD.CWScoreboardContainer = InheritFrom(LUI.UIElement)

CoD.CWScoreboardContainer.new = function( menu, controller )

	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.CWScoreboardContainer )
	self.id = "CWScoreboardContainer"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

    local Background = LUI.UIImage.new()
    Background:setLeftRight( true, false, 136.5, 1143.5 )
    Background:setTopBottom( true, false, 109.5, 495 )
    Background:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_bg" ) )
    Background:setAlpha( 0.8 )
    self:addElement( Background )
    self.Background = Background

    local TopBar = LUI.UIImage.new()
    TopBar:setLeftRight( true, false, 0, 1280 )
    TopBar:setTopBottom( true, false, 0, 26 )
    TopBar:setRGB( 0, 0, 0 )
    TopBar:setAlpha( 0.6 )
    self:addElement( TopBar )
    self.TopBar = TopBar

    local BottomBar = LUI.UIImage.new()
    BottomBar:setLeftRight( true, false, 0, 1280 )
    BottomBar:setTopBottom( false, true, -40, 0 )
    BottomBar:setRGB( 0, 0, 0 )
    BottomBar:setAlpha( 0.6 )
    self:addElement( BottomBar )
    self.BottomBar = BottomBar

    local MapName = LUI.UIText.new()
    MapName:setLeftRight(true, false, 136.5, 1280)
    MapName:setTopBottom(true, false, 70, 102)
    MapName:setTTF( "fonts/DroidSans-Bold.ttf" )
    MapName:setText( "" ) -- change this to a client system later
    self:addElement( MapName )
    self.MapName = MapName

    local Dividers = LUI.UIImage.new()
    Dividers:setLeftRight( true, false, 136.5, 1143.5 )
    Dividers:setTopBottom( true, false, 109.5, 495 )
    Dividers:setAlpha( 1 )
    self:addElement( Dividers )
    self.Dividers = Dividers

	local TeamList = LUI.UIList.new( menu, controller, 1, 0, nil, false, false, 0, 0, false, false )
    TeamList:setLeftRight( true, false, 0, 1280 )
    TeamList:setTopBottom( true, false, 0, 720 )
    TeamList:setWidgetType( CoD.CWScoreboard )
    TeamList:setVerticalCount( 1 )
    TeamList:setSpacing( 9.5 ) 
    TeamList:setDataSource( "ScoreboardTeam1List" )
	self:addElement( TeamList )
    self.TeamList = TeamList

	local ClientInfo = LUI.UIList.new( menu, controller, 2, 0, nil, false, false, 0, 0, false, false )
    ClientInfo:setLeftRight(true, false, 0, 1280 )
    ClientInfo:setTopBottom(true, false, 0, 720 )
    ClientInfo:setWidgetType( CoD.CWSelfScoreboard ) 
    ClientInfo:setDataSource( "PlayerListZM" )
	self:addElement( ClientInfo )
    self.ClientInfo = ClientInfo

    local Header = LUI.UIImage.new()
    Header:setLeftRight( true, false, 140, 1140 )
    Header:setTopBottom( true, false, 112.5, 133.5 )
    Header:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_header" ) )
    self:addElement( Header )
    self.Header = Header

    local Score = LUI.UIImage.new()
    Score:setLeftRight( true, false, 519.5, 557.5 )
    Score:setTopBottom( true, false, 441.5, 483.5 )
    Score:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_essence" ) )
    Score:setAlpha( 1 )
    self:addElement( Score )
    self.Score = Score

    local RareScrap = LUI.UIImage.new()
    RareScrap:setLeftRight( true, false, 956.5, 1000.5 )
    RareScrap:setTopBottom( true, false, 447.5, 481.5 )
    RareScrap:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_rarescrap" ) )
    RareScrap:setAlpha( 1 )
    self:addElement( RareScrap )
    self.RareScrap = RareScrap

    local CommonScrap = LUI.UIImage.new()
    CommonScrap:setLeftRight(true, false, 735.5, 779.5 )
    CommonScrap:setTopBottom(true, false, 445, 480 )
    CommonScrap:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_commonscrap" ) )
    CommonScrap:setAlpha( 1 )
    self:addElement( CommonScrap )
    self.CommonScrap = CommonScrap

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 11 )

                Background:completeAnimation()
				self.Background:setAlpha( 0 )
				self.clipFinished( Background, {} )

                TopBar:completeAnimation()
				self.TopBar:setAlpha( 0 )
				self.clipFinished( TopBar, {} )

                BottomBar:completeAnimation()
				self.BottomBar:setAlpha( 0 )
				self.clipFinished( BottomBar, {} )

                MapName:completeAnimation()
				self.MapName:setAlpha( 0 )
				self.clipFinished( MapName, {} )

                Dividers:completeAnimation()
				self.Dividers:setAlpha( 0 )
				self.clipFinished( Dividers, {} )

                TeamList:completeAnimation()
				self.TeamList:setAlpha( 0 )
				self.clipFinished( TeamList, {} )

                ClientInfo:completeAnimation()
				self.ClientInfo:setAlpha( 0 )
				self.clipFinished( ClientInfo, {} )

                Header:completeAnimation()
				self.Header:setAlpha( 0 )
				self.clipFinished( Header, {} )

                Score:completeAnimation()
				self.Score:setAlpha( 0 )
				self.clipFinished( Score, {} )

                RareScrap:completeAnimation()
				self.RareScrap:setAlpha( 0 )
				self.clipFinished( RareScrap, {} )

                CommonScrap:completeAnimation()
				self.CommonScrap:setAlpha( 0 )
				self.clipFinished( CommonScrap, {} )
            end
        },
        Visible = {
            DefaultClip = function()
                self:setupElementClipCounter( 11 )

                Background:completeAnimation()
				self.Background:setAlpha( 0.8 )
				self.clipFinished( Background, {} )

                TopBar:completeAnimation()
				self.TopBar:setAlpha( 0.6 )
				self.clipFinished( TopBar, {} )

                BottomBar:completeAnimation()
				self.BottomBar:setAlpha( 0.6 )
				self.clipFinished( BottomBar, {} )

                MapName:completeAnimation()
				self.MapName:setAlpha( 1 )
				self.clipFinished( MapName, {} )

                Dividers:completeAnimation()
				self.Dividers:setAlpha( 1 )
				self.clipFinished( Dividers, {} )

                TeamList:completeAnimation()
				self.TeamList:setAlpha( 1 )
				self.clipFinished( TeamList, {} )

                ClientInfo:completeAnimation()
				self.ClientInfo:setAlpha( 1 )
				self.clipFinished( ClientInfo, {} )

                Header:completeAnimation()
				self.Header:setAlpha( 1 )
				self.clipFinished( Header, {} )

                Score:completeAnimation()
				self.Score:setAlpha( 1 )
				self.clipFinished( Score, {} )

                RareScrap:completeAnimation()
				self.RareScrap:setAlpha( 1 )
				self.clipFinished( RareScrap, {} )

                CommonScrap:completeAnimation()
				self.CommonScrap:setAlpha( 1 )
				self.clipFinished( CommonScrap, {} )
            end
        }
    }

    self:mergeStateConditions({
		{
			stateName = "Visible", 
			condition = function( menu, ItemRef, UpdateTable )
                if not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED) and not
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) then
                    return false
                else
                    return true
                end
            end
		}
	})

    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED )

    self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function( ModelRef )
		menu:updateElementState( self, {
			name = "model_validation", 
			menu = menu, 
			modelValue = Engine.GetModelValue( ModelRef ), 
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN 
        })
        local scoreboardInfoModel = Engine.GetModel( Engine.GetGlobalModel(), "scoreboard.team1" )

        self.TeamList.teamCountSubscription = self.TeamList:subscribeToModel( Engine.GetModel( scoreboardInfoModel, "count" ), function( ModelRef )
            self.TeamList:setVerticalCount( Engine.GetModelValue( ModelRef ) )
        end)

        if self.TeamList.teamCountSubscription then
            self.TeamList:removeSubscription( self.TeamList.teamCountSubscription )
        end

        self.Dividers.teamCountSubscription = self.Dividers:subscribeToModel( Engine.GetModel( scoreboardInfoModel, "count" ), function( ModelRef )
            self.Dividers:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_divider_" .. Engine.GetModelValue( ModelRef ) ) )
        end)

        if self.Dividers.teamCountSubscription then
            self.Dividers:removeSubscription( self.Dividers.teamCountSubscription )
        end
	end)

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Background:close()
        element.TopBar:close()
        element.BottomBar:close()
        element.MapName:close()
        element.Dividers:close()
        element.TeamList:close()
        element.ClientInfo:close()
        element.Header:close()
        element.Score:close()
        element.RareScrap:close()
        element.CommonScrap:close()
	end)

	return self
end