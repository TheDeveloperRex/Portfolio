require( "ui.utility.CoreUtil" )

local PreLoadFunc = function( menu, controller )
    Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.CWChallengeNotif" )
    Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.CWChallengeInfo" )
end

CoD.CWChallengeWidget = InheritFrom( LUI.UIElement )

function CoD.CWChallengeWidget.new( menu, controller )
    
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass( CoD.CWChallengeWidget )
    self.id = "CWChallengeWidget"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 230 )
    self:setTopBottom( true, false, 0, 70 )

    local ChallengeGlow = LUI.UIImage.new()
	ChallengeGlow:setLeftRight( false, false, -10, 240 )
	ChallengeGlow:setTopBottom( true, false, 5, 70 )
    ChallengeGlow:setImage( RegisterImage( "rex_coldwar_ui_light_glow_square" ) )
	ChallengeGlow:setZoom( 2.5 )
	self:addElement( ChallengeGlow )
	self.ChallengeGlow = ChallengeGlow

    local ChallengeBG = LUI.UIImage.new()
	ChallengeBG:setLeftRight( true, false, 0, 230 )
	ChallengeBG:setTopBottom( true, false, 5, 70 )
    ChallengeBG:setImage( RegisterImage( "rex_coldwar_ui_challenge_bg" ) )
    self:addElement( ChallengeBG )
    self.ChallengeBG = ChallengeBG

    local TimerBG = LUI.UIImage.new()
    TimerBG:setLeftRight( true, false, 70, 155 )
    TimerBG:setTopBottom( true, false, -2, 18 )
    TimerBG:setImage( RegisterImage( "rex_coldwar_ui_challenge_timer_bg" ) )
    self:addElement( TimerBG )
    self.TimerBG = TimerBG

    local Timer = LUI.UIText.new()
    Timer:setLeftRight( true, false, 70, 155 )
    Timer:setTopBottom( true, false, -2, 18 )
    Timer:setText( "" )
    Timer:setTTF( "fonts/default.ttf" )
    Timer:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    self:addElement( Timer )
    self.Timer = Timer
    
    local Desc = LUI.UIText.new()
    Desc:setLeftRight( true, false, 0, 230 )
    Desc:setTopBottom( true, false, 25, 45 )
    Desc:setText( "" )
    Desc:setTTF( "fonts/default.ttf" )
    Desc:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    self:addElement( Desc )
    self.Desc = Desc

    local Location = LUI.UIText.new()
    Location:setLeftRight( true, false, 0, 230 )
    Location:setTopBottom( true, false, 52, 64 )
    Location:setText( "" )
    Location:setTTF( "fonts/default.ttf" )
    Location:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    self:addElement( Location )
    self.Location = Location

    self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.CWChallengeInfo" ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )
        if val then
            local strToks = LUI.splitString( val, "," )

            if IsSelfInState( self, "HideInfo" ) then
                return
            end

            Desc:setText( Engine.Localize( strToks[ 1 ] ) or "" )
            Location:setText( Engine.ToUpper( Engine.Localize( strToks[ 3 ] and strToks[ 3 ] or "" ) ) )

            if strToks[ #strToks ] then
                local div = string.find( strToks[ 2 ], "/", 1, true )
                if not div then
                    local s = tonumber( strToks[ 2 ] )
                    local h = 0
                    local m = 0
                    if s > 59 then
                        m = floor( s / 60 )
                        s = ( ( floor( s * 1000 ) ) % 60000 )
                        s = s * 0.001
                        if m > 59 then
                            h = floor( m / 60 )
                            m = ( ( floor( m * 1000 ) ) % 60000 )
                            m = m * 0.001
                        end
                    end
                    h = ( ( h < 10 ) and ( h > 0 and ( "0" .. h .. ":" ) or "" ) or h .. ":" )
                    m = ( ( m < 10 ) and ( "0" .. m ) or m )
                    s = ( ( s < 10 ) and ( "0" .. s ) or s )
                    local str = ( ( ( h .. m ) .. ":" ) .. s )
                    Timer:setText( Engine.Localize( tonumber( strToks[ 2 ] ) ~= 0 and str or "COMPLETED" ) or "" ) 
                else
                    local v_min, v_max = strToks[ 2 ]:match( "^(.+)/(.+)$" )
                    local str = ( ( v_min:find( ".", 1, true ) and string.format( "%.2f", v_min ) or v_min ) .. "/" .. v_max .. ( strToks[ 4 ] and strToks[ 4 ] or "" ) )
                    Timer:setText( Engine.Localize( ( v_min < v_max ) and str or "COMPLETED" ) or "" )
                end
                
                if IsSelfInState( self, "ShowInfo" ) then
                    if not div then
                        if tonumber( strToks[ 2 ] ) <= 10 then
                            self:playClip( "ValueGlow" )
                        end
                    else
                        if tonumber( string.sub( strToks[ 2 ], 0, div - 1 ) ) > 0 then
                            self:playClip( "ValueGlow" )
                        end
                    end
                end
            end
        end
    end)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 6 )

                ChallengeGlow:completeAnimation()
                self.ChallengeGlow:setAlpha( 0 )
                self.ChallengeGlow:setRGB( 1, 0, 0 )
                self.clipFinished( ChallengeGlow, {} )

                ChallengeBG:completeAnimation()
                self.ChallengeBG:setAlpha( 0 )
                self.clipFinished( ChallengeBG, {} )

                TimerBG:completeAnimation()
                self.TimerBG:setAlpha( 0 )
                self.clipFinished( TimerBG, {} )

                Timer:completeAnimation()
                self.Timer:setAlpha( 0 )
                self.Desc:setRGB( 1, 1, 1 )
                self.clipFinished( Timer, {} )

                Desc:completeAnimation()
                self.Desc:setAlpha( 0 )
                self.Desc:setRGB( 0, 0, 0 )
                self.clipFinished( Desc, {} )

                Location:completeAnimation()
                self.Location:setAlpha( 0 )
                self.Location:setRGB( 1, 0, 0 )
                self.clipFinished( Location, {} )
            end
        },
        ShowInfo = {
            DefaultClip = function()
                local function HandleChallengeInfoClipStage1( Sender, Event )
                    local function HandleChallengeInfoClipStage2( Sender, Event )
                        local function HandleChallengeInfoClipStage3( Sender, Event )
                            local function HandleChallengeInfoClipStage4( Sender, Event )
                                if not Event.interrupted then
                                    Sender:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
                                end
                                
                                Sender:setScale( 1 )
                                
                                if Event.interrupted then
                                    self.clipFinished( Sender, Event )
                                else
                                    Sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                                end
                            end

                            if Event.interrupted then
                                return HandleChallengeInfoClipStage4( Sender, Event )
                            end
            
                            Sender:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
                            Sender:setScale( 1.35 )
                            Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeInfoClipStage4 )
                        end

                        if Event.interrupted then
                            return HandleChallengeInfoClipStage3( Sender, Event )
                        end
        
                        Sender:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
                        Sender:setAlpha( 1 )
                        Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeInfoClipStage3 )
                    end
    
                    if Event.interrupted then
                        return HandleChallengeInfoClipStage2( Sender, Event )
                    end
                    
                    Sender:setScale( 1 )
                    Sender:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
                    Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeInfoClipStage2 )
                end
    
                self:setupElementClipCounter( 6 )

                ChallengeGlow:completeAnimation()
                self.ChallengeGlow:setAlpha( 0 )
                self.clipFinished( ChallengeGlow, {} )

                ChallengeBG:completeAnimation()
                self.ChallengeBG:setAlpha( 1 )
                self.clipFinished( ChallengeBG, {} )

                TimerBG:completeAnimation()
                self.TimerBG:setAlpha( 1 )
                self.clipFinished( TimerBG, {} )
                
                Timer:completeAnimation()
                self.Timer:setAlpha( 0 )
                HandleChallengeInfoClipStage1( Timer, {} )

                Desc:completeAnimation()
                self.Desc:setAlpha( 0 )
                HandleChallengeInfoClipStage1( Desc, {} )

                Location:completeAnimation()
                self.Location:setAlpha( 0 )
                HandleChallengeInfoClipStage1( Location, {} )
            end,
            ValueGlow = function()
                local function HandleChallengeValueClipStage1( Sender, Event )
                    local function HandleChallengeValueClipStage2( Sender, Event )
                        if not Event.interrupted then
                            Sender:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
                        end
                        
                        Sender:setTopBottom( true, false, 5, 70 )
                        Sender:setAlpha( 0 )
                        
                        if Event.interrupted then
                            self.clipFinished( Sender, Event )
                        else
                            Sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                        end
                    end

                    if Event.interrupted then
                        return HandleChallengeValueClipStage2( Sender, Event )
                    end
                    
                    Sender:setTopBottom( true, false, -5, 80 )
                    Sender:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
                    Sender:setAlpha( 1 )
                    Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeValueClipStage2 )
                end

                self:setupElementClipCounter( 6 )

                ChallengeGlow:completeAnimation()
                self.ChallengeGlow:setAlpha( 0 )
                HandleChallengeValueClipStage1( ChallengeGlow, {} )

                ChallengeBG:completeAnimation()
                self.ChallengeBG:setAlpha( 1 )
                self.clipFinished( ChallengeBG, {} )

                TimerBG:completeAnimation()
                self.TimerBG:setAlpha( 1 )
                self.clipFinished( TimerBG, {} )
                
                Timer:completeAnimation()
                self.Timer:setAlpha( 1 )
                self.clipFinished( Timer, {} )

                Desc:completeAnimation()
                self.Desc:setAlpha( 1 )
                self.clipFinished( Desc, {} )

                Location:completeAnimation()
                self.Location:setAlpha( 1 )
                self.clipFinished( Location, {} )
            end
        },
        HideInfo = {
            DefaultClip = function()
                local function HandleChallengeValueClipStage1( Sender, Event )
                    local function HandleChallengeValueClipStage2( Sender, Event )
                        local function HandleChallengeValueClipStage3( Sender, Event )
                            local function HandleChallengeValueClipStage4( Sender, Event )
                                if not Event.interrupted then
                                    Sender:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
                                end
                                
                                Sender:setRGB( 1, 1, 1 )
                                Sender:setAlpha( 0 )
                                
                                if Event.interrupted then
                                    self.clipFinished( Sender, Event )
                                else
                                    Sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                                end
                            end

                            if Event.interrupted then
                                return HandleChallengeValueClipStage4( Sender, Event )
                            end
            
                            Sender:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
                            Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeValueClipStage4 )
                        end

                        if Event.interrupted then
                            return HandleChallengeValueClipStage3( Sender, Event )
                        end
        
                        Sender:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
                        Sender:setScale( 1 )
                        Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeValueClipStage3 )
                    end

                    if Event.interrupted then
                        return HandleChallengeValueClipStage2( Sender, Event )
                    end
                    
                    Sender:setRGB( 115/255, 235/255, 85/255 )
                    Sender:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
                    Sender:setScale( 1.35 )
                    Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeValueClipStage2 )
                end

                local function HandleChallengeInfoClipStage1( Sender, Event )
                    local function HandleChallengeInfoClipStage2( Sender, Event )
                        if not Event.interrupted then
                            Sender:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
                        end
                        
                        Sender:setAlpha( 0 )
                        
                        if Event.interrupted then
                            self.clipFinished( Sender, Event )
                        else
                            Sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                        end
                    end

                    if Event.interrupted then
                        return HandleChallengeInfoClipStage2( Sender, Event )
                    end
                    
                    Sender:setScale( 1 )
                    Sender:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
                    Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeInfoClipStage2 )
                end
    
                self:setupElementClipCounter( 6 )

                ChallengeGlow:completeAnimation()
                self.ChallengeGlow:setAlpha( 0 )
                HandleChallengeInfoClipStage1( ChallengeGlow, {} )

                ChallengeBG:completeAnimation()
                self.ChallengeBG:setAlpha( 1 )
                HandleChallengeInfoClipStage1( ChallengeBG, {} )

                TimerBG:completeAnimation()
                self.TimerBG:setAlpha( 1 )
                HandleChallengeInfoClipStage1( TimerBG, {} )
                
                Timer:completeAnimation()
                self.Timer:setAlpha( 1 )
                HandleChallengeValueClipStage1( Timer, {} )

                Desc:completeAnimation()
                self.Desc:setAlpha( 1 )
                HandleChallengeInfoClipStage1( Desc, {} )

                Location:completeAnimation()
                self.Location:setAlpha( 1 )
                HandleChallengeInfoClipStage1( Location, {} )
            end
        }
    }

    self.StateTable = {
        {
            stateName = "ShowInfo",
            condition = function( menu, ItemRef, UpdateTable )
                return IsModelValueEqualTo( controller, "hudItems.CWChallengeNotif", 1 )
            end
        },
        {
            stateName = "HideInfo",
            condition = function( menu, ItemRef, UpdateTable )
                return IsModelValueEqualTo( controller, "hudItems.CWChallengeNotif", 0 )
            end
        }
    }
    
	self:mergeStateConditions( self.StateTable )

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.CWChallengeNotif" )
    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.CWChallengeInfo" )
    
    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.ChallengeGlow:close()
        element.ChallengeBG:close()
        element.TimerBG:close()
        element.Timer:close()
        element.Desc:close()
        element.Location:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end
    
    return self
end