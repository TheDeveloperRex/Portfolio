require( "ui.uieditor.widgets.REX.ColdWar.Challenge.CWChallengeWidget" )
require( "ui.utility.DiscordUtil" )

local PreLoadFunc = function( menu, controller )
    local ChallengeModel = Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.CWChallengeNotif" )
    Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.CWChallengeGlow" )

    Engine.SetModelValue( ChallengeModel, 2 )
end

CoD.CWChallengeContainer = InheritFrom( LUI.UIElement )

function CoD.CWChallengeContainer.new( menu, controller )
    
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( menu, controller )
    end

    self:setClass( CoD.CWChallengeContainer )
    self.id = "CWChallengeContainer"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 300 )
    self:setTopBottom( true, false, 0, 70 )

    local CWChallengeWidget = CoD.CWChallengeWidget.new( menu, controller )
    CWChallengeWidget:setLeftRight( true, false, 70, 300 )
    CWChallengeWidget:setTopBottom( true, false, 0, 70 )
    self:addElement( CWChallengeWidget )
    self.CWChallengeWidget = CWChallengeWidget

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()                
                self:setupElementClipCounter( 1 )
    
                CWChallengeWidget:completeAnimation()
                self.CWChallengeWidget:setAlpha( 0 )
                self.clipFinished( CWChallengeWidget, {} )
            end
        },
        PopIn = {
            DefaultClip = function()
                local function HandleChallengeClipStage1( Sender, Event )
                    local function HandleChallengeClipStage2( Sender, Event )
                        local function HandleChallengeClipStage3( Sender, Event )
                            if not Event.interrupted then
                                Sender:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
                            end
                            
                            Sender:setLeftRight( true, false, 70, 300 )
                            
                            if Event.interrupted then
                                self.clipFinished( Sender, Event )
                            else
                                Sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                            end
                        end
    
                        if Event.interrupted then
                            return HandleChallengeClipStage3( Sender, Event )
                        end
    
                        Sender:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
                        Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeClipStage3 )
                    end
    
                    if Event.interrupted then
                        return HandleChallengeClipStage2( Sender, Event )
                    end
    
                    Sender:beginAnimation( "keyframe", 350, false, false, CoD.TweenType.Linear )
                    Sender:setLeftRight( true, false, 100, 330 )
                    Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeClipStage2 )
                end
    
                self:setupElementClipCounter( 1 )
    
                CWChallengeWidget:completeAnimation()
                self.CWChallengeWidget:setLeftRight( true, false, -230, 0 )
                self.CWChallengeWidget:setAlpha( 1 )
                HandleChallengeClipStage1( CWChallengeWidget, {} )
            end
        }, 
        PopOut = {
            DefaultClip = function()
                local function HandleChallengeOutClipStage1( Sender, Event )
                    local function HandleChallengeOutClipStage2( Sender, Event )
                        local function HandleChallengeOutClipStage3( Sender, Event )
                            local function HandleChallengeOutClipStage4( Sender, Event )
                                if not Event.interrupted then
                                    Sender:beginAnimation( "keyframe", 350, false, false, CoD.TweenType.Linear )
                                end
                                
                                Sender:setLeftRight( true, false, -230, 0 )
                                Sender:setAlpha( 0 )
                                
                                if Event.interrupted then
                                    self.clipFinished( Sender, Event )
                                else
                                    Sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                                end
                            end
        
                            if Event.interrupted then
                                return HandleChallengeOutClipStage4( Sender, Event )
                            end
                            
                            Sender:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
                            Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeOutClipStage4 )
                        end
        
                        if Event.interrupted then
                            return HandleChallengeClipOutStage3( Sender, Event )
                        end
        
                        Sender:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
                        Sender:setLeftRight( true, false, 100, 330 )
                        Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeOutClipStage3 )
                    end

                    if Event.interrupted then
                        return HandleChallengeClipOutStage2( Sender, Event )
                    end
    
                    Sender:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
                    Sender:registerEventHandler( "transition_complete_keyframe", HandleChallengeOutClipStage2 )
                end

                self:setupElementClipCounter( 1 )
                
                CWChallengeWidget:completeAnimation()
                self.CWChallengeWidget:setLeftRight( true, false, 70, 300 )
                self.CWChallengeWidget:setAlpha( 1 )
                HandleChallengeOutClipStage1( CWChallengeWidget, {} )
            end
        }
    }

    self.StateTable = {
        {
            stateName = "PopOut",
            condition = function( menu, ItemRef, UpdateTable )
                return IsModelValueEqualTo( controller, "hudItems.CWChallengeNotif", 0 )
            end
        },
        {
            stateName = "PopIn",
            condition = function( menu, ItemRef, UpdateTable )
                return IsModelValueEqualTo( controller, "hudItems.CWChallengeNotif", 1 )
            end
        }
    }

	self:mergeStateConditions( self.StateTable )

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.CWChallengeNotif" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.CWChallengeWidget:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( menu, controller )
    end
    
    return self
end