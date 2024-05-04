CoD.CWPowerUpsPopUp = InheritFrom( LUI.UIElement )

CoD.CWPowerUpsPopUp.new = function( menu, controller )
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setUseStencil( false )
    self:setClass( CoD.CWPowerUpsPopUp )
    self.id = "CWPowerUpsPopUp"
    self.soundSet = "HUD"
    self:setLeftRight( true, true, 0, 0 )
    self:setTopBottom( true, true, 0, 0 )
    self.anyChildUsesUpdateState = true

    local Background = LUI.UIImage.new()
    Background:setLeftRight( false, false, -150, 150 )
    Background:setTopBottom( false, true, -175, -75 )
    Background:setImage( RegisterImage( "rex_coldwar_ui_powerup_bg" ) )
    self:addElement( Background )
    self.Background = Background

    local Icon = LUI.UIImage.new()
    Icon:setLeftRight( false, false, -50, 50 )
    Icon:setTopBottom( false, true, -240, -140 )
    Icon:setImage( RegisterImage( "rex_coldwar_ui_powerup_instakill" ) )
    self:addElement( Icon )
    self.Icon = Icon

    local Name = LUI.UIText.new()
    Name:setLeftRight( true, true, 0, 0 )
    Name:setTopBottom( false, true, -145, -115 )
    Name:setRGB( 0, 0, 0 )
    Name:setTTF( "fonts/DroidSans-Bold.ttf" )
    Name:setText( "" )
    self:addElement( Name )
    self.Name = Name

    self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.PowerUpNotif" ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )
        if val then
            local strToks = LUI.splitString( val, "," )
                        
            if #strToks > 0 then
                self.Icon:setImage( RegisterImage( strToks[ 2 ] ) )
                self.Name:setText( Engine.Localize( strToks[ 1 ] ) )
                self:playClip( "NotifClip" )
            end
        end
    end)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 3 )
                
                Background:completeAnimation()
                self.Background:setAlpha( 0 )
                self.clipFinished( Background, {} )

                Icon:completeAnimation()
                self.Icon:setAlpha( 0 )
                self.clipFinished( Icon, {} )

                Name:completeAnimation()
                self.Name:setAlpha( 0 )
                self.clipFinished( Name, {} )
            end,
            NotifClip = function()
                self:setupElementClipCounter( 3 )
                
                local HandlePowerUpNotifStage1 = function( Sender, Event )
                    local HandlePowerUpNotifStage2 = function( Sender, Event )
                        local HandlePowerUpNotifStage3 = function( Sender, Event )
                            local HandlePowerUpNotifStage4 = function (Sender, Event)
                                if not Event.interrupted then
                                    Sender:beginAnimation( "keyframe", 679, false, false, CoD.TweenType.Linear )
                                end
                                Sender:setAlpha( 0 )
                                if Event.interrupted then
                                    self.clipFinished( Sender, Event )
                                else
                                    Sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                                end
                            end

                            if Event.interrupted then
                                return HandlePowerUpNotifStage4( Sender, Event )
                            else
                                Sender:beginAnimation( "keyframe", 1970, false, false, CoD.TweenType.Linear )
                                Sender:registerEventHandler("transition_complete_keyframe", HandlePowerUpNotifStage4 )
                            end
                        end

                        if Event.interrupted then
                            return HandlePowerUpNotifStage3( Sender, Event )
                        else
                            Sender:beginAnimation( "keyframe", 290, false, false, CoD.TweenType.Linear )
                            Sender:setAlpha( 1 )
                            Sender:registerEventHandler( "transition_complete_keyframe", HandlePowerUpNotifStage3 )
                        end
                    end

                    if Event.interrupted then
                        return HandlePowerUpNotifStage2( Sender, Event )
                    else
                        Sender:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
                        Sender:registerEventHandler( "transition_complete_keyframe", HandlePowerUpNotifStage2 )
                    end
                end

                Background:completeAnimation()
                self.Background:setAlpha( 0 )
                HandlePowerUpNotifStage1( Background, {} )

                Icon:completeAnimation()
                self.Icon:setAlpha( 0 )
                HandlePowerUpNotifStage1( Icon, {} )

                Name:completeAnimation()
                self.Name:setAlpha( 0 )
                HandlePowerUpNotifStage1( Name, {} )
            end
        }
    }

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.Background:close()
        element.Icon:close()
        element.Name:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc( menu, controller )
    end
    
    return self
end