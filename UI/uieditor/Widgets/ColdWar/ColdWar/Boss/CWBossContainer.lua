require( "ui.uieditor.widgets.REX.ColdWar.Boss.CWBossWidget" )
require( "ui.utility.CoreUtil" )

local PreLoadFunc = function( menu, controller )
    local CWBossHealthBar = Engine.GetModel( Engine.GetModelForController( InstanceRef ), "hudItems.CWBossHealthBar" )
    Engine.SetModelValue( CWBossHealthBar, 0 )
end

CoD.CWBossContainer = InheritFrom( LUI.UIElement )

function CoD.CWBossContainer.new( menu, controller )
    
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass( CoD.CWBossContainer )
    self.id = "CWBossContainer"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 500 )
    self:setTopBottom( true, false, 0, 32 )

    local CWBossWidget = CoD.CWBossWidget.new( menu, controller )
    CWBossWidget:setLeftRight( true, false, 0, 500 )
    CWBossWidget:setTopBottom( true, false, 0, 32 )
    self:addElement( CWBossWidget )
    self.CWBossWidget = CWBossWidget

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()                
                self:setupElementClipCounter( 1 )
    
                CWBossWidget:completeAnimation()
                self.CWBossWidget:setAlpha( 0 )
                self.clipFinished( CWBossWidget, {} )
            end
        },
        Visible = {
            DefaultClip = function()                
                self:setupElementClipCounter( 1 )
    
                CWBossWidget:completeAnimation()
                self.CWBossWidget:setAlpha( 1 )
                self.clipFinished( CWBossWidget, {} )
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "DefaultState",
            condition = function( menu, ItemRef, UpdateTable )
                return IsModelValueEqualTo( controller, "hudItems.CWBossHealthBar", 0 )
            end
        },
        {
            stateName = "Visible",
            condition = function( menu, ItemRef, UpdateTable )
                return IsModelValueEqualTo( controller, "hudItems.CWBossHealthBar", 1 )
            end
        }
    })

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.CWBossHealthBar" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.CWBossWidget:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end
    
    return self
end