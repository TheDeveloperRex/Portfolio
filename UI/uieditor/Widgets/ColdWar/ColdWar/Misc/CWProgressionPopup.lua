CoD.CWProgressionPopup = InheritFrom( LUI.UIElement )

CoD.CWProgressionPopup.new = function( menu, controller )
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setUseStencil( false )
    self:setClass( CoD.CWProgressionPopup )
    self.id = "CWProgressionPopup"
    self.soundSet = "HUD"
    self:setLeftRight( true, true, 0, 140 )
    self:setTopBottom( true, true, 0, 175 )
    self.anyChildUsesUpdateState = true

    local RankIcon = LUI.UIImage.new()
    RankIcon:setLeftRight( true, false, 20, 120 )
    RankIcon:setTopBottom( true, false, 0, 100 )
    RankIcon:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_emblem" ) )
    self:addElement( RankIcon )
    self.RankIcon = RankIcon

    local RankTitle = CoD.TextWithBg.new()
	RankTitle.Text:setLeftRight( true, false, 0, 140 )
	RankTitle.Text:setTopBottom( true, false, 104, 116 )
    RankTitle.Text:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    RankTitle.Text:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    RankTitle.Text:setText( "" )
	RankTitle.Bg:setLeftRight( true, false, 0, 140 )
	RankTitle.Bg:setTopBottom( true, false, 95, 125 )
    RankTitle.Bg:setRGB( 0, 0, 0 )
    RankTitle.Bg:setAlpha( 0.35 )
	self:addElement( RankTitle )
	self.RankTitle = RankTitle

    local Rank = LUI.UIText.new()
    Rank:setLeftRight( true, false, 0, 140 )
    Rank:setTopBottom( true, false, 140, 155 )
    Rank:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    Rank:setTTF( "fonts/DroidSans-Bold.ttf" )
    Rank:setText( "" )
    self:addElement( Rank )
    self.Rank = Rank

    self:subscribeToGlobalModel( controller, "PerController", "scriptNotify", function( ModelRef )
		if IsParamModelEqualToString( ModelRef, "RankPopup" ) then
            local rankTable = "gamedata/tables/mp/cu_ranktable.csv"
			local val = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.ProgressionData" ) ) --prestige,xp,level,title,icon

            if val then
                local strToks = LUI.splitString( val, "," )

                if #strToks > 0 then
                    --self.RankIcon:setImage( RegisterImage( strToks[ 5 ] ) )
                    self.RankTitle.Text:setText( Engine.ToUpper( Engine.Localize( strToks[ 4 ] ) ) )
                    self.Rank:setText( Engine.ToUpper( Engine.Localize( string.format( "NEW RANK: %s", strToks[ 3 ] ) ) ) )
                end
                self:playClip( "NotifClip" )
            end
		end
	end)
    

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 3 )
                
                RankIcon:completeAnimation()
                self.RankIcon:setAlpha( 0 )
                self.clipFinished( RankIcon, {} )

                RankTitle:completeAnimation()
                self.RankTitle:setAlpha( 0 )
                self.clipFinished( RankTitle, {} )

                Rank:completeAnimation()
                self.Rank:setAlpha( 0 )
                self.clipFinished( Rank, {} )
            end,
            NotifClip = function()
                self:setupElementClipCounter( 3 )
                
                local HandleProgressionUpNotifStage1 = function( Sender, Event )
                    local HandleProgressionUpNotifStage2 = function( Sender, Event )
                        local HandleProgressionUpNotifStage3 = function (Sender, Event)
                            if not Event.interrupted then
                                Sender:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Linear )
                            end
                            Sender:setAlpha( 0 )
                            if Event.interrupted then
                                self.clipFinished( Sender, Event )
                            else
                                Sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                            end
                        end

                        if Event.interrupted then
                            return HandleProgressionUpNotifStage3( Sender, Event )
                        else
                            Sender:beginAnimation( "keyframe", 4500, false, false, CoD.TweenType.Linear )
                            Sender:registerEventHandler("transition_complete_keyframe", HandleProgressionUpNotifStage3 )
                        end
                    end

                    if Event.interrupted then
                        return HandleProgressionUpNotifStage2( Sender, Event )
                    else
                        Sender:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Linear )
                        Sender:setAlpha( 1 )
                        Sender:registerEventHandler( "transition_complete_keyframe", HandleProgressionUpNotifStage2 )
                    end
                end

                RankIcon:completeAnimation()
                self.RankIcon:setAlpha( 0 )
                HandleProgressionUpNotifStage1( RankIcon, {} )

                RankTitle:completeAnimation()
                self.RankTitle:setAlpha( 0 )
                HandleProgressionUpNotifStage1( RankTitle, {} )

                Rank:completeAnimation()
                self.Rank:setAlpha( 0 )
                HandleProgressionUpNotifStage1( Rank, {} )
            end
        }
    }

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.ProgressionRankNotif" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.RankIcon:close()
        element.RankTitle:close()
        element.Rank:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc( menu, controller )
    end
    
    return self
end