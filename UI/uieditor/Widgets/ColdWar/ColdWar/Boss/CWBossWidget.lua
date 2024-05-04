require( "ui.utility.CoreUtil" )

local PreLoadFunc = function( menu, controller )
    Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.CWBossHealth" )
    Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.CWBossName" )
end

CoD.CWBossWidget = InheritFrom( LUI.UIElement )

function CoD.CWBossWidget.new( menu, controller )
    
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass( CoD.CWBossWidget )
    self.id = "CWBossWidget"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 500 )
    self:setTopBottom( true, false, 0, 32 )

    local HealthBacking = LUI.UIImage.new()
	HealthBacking:setLeftRight( true, false, 0, 500 )
	HealthBacking:setTopBottom( true, false, 0, 10 )
    self:addElement( HealthBacking )
    self.HealthBacking = HealthBacking

    local Name = LUI.UIText.new()
	Name:setLeftRight( true, false, 0, 500 )
	Name:setTopBottom( true, false, 16, 32 )
	Name:setText( "" )
    Name:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    Name:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    Name:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.CWBossName" ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )

        if val then
            Name:setText( Engine.ToUpper( Engine.Localize( val ) or "" ) )
        end
    end)
    self:addElement( Name )
    self.Name = Name

    local Health = LUI.UIImage.new()
	Health:setLeftRight( true, false, 0, 500 )
	Health:setTopBottom( true, false, 0, 10 )
    Health:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_normal" ) )
    Health:setShaderVector( 0, 1, 0, 0, 0 )
    Health:setShaderVector( 1, 0, 0, 0, 0 )
    Health:setShaderVector( 2, 1, 0, 0, 0 )
    Health:setShaderVector( 3, 0, 0, 0, 0 )
    Health:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.CWBossHealth" ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )

        if val then
            Health:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
            Health:setShaderVector( 0, AdjustStartEnd(0, 1,
                CoD.GetVectorComponentFromString( val, 1 ),
                CoD.GetVectorComponentFromString( val, 1 ),
                CoD.GetVectorComponentFromString( val, 1 ),
                CoD.GetVectorComponentFromString( val, 1 ))
            )
        end
    end)
    self:addElement( Health )
    self.Health = Health

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 3 )

                Name:completeAnimation()
                self.Name:setRGB( 255/255, 255/255, 255/255 )
                self.Name:setAlpha( 1 )
                self.clipFinished( Name, {} )

                HealthBacking:completeAnimation()
                self.HealthBacking:setRGB( 0/255, 0/255, 0/255 )
                self.HealthBacking:setAlpha( 1 )
                self.clipFinished( HealthBacking, {} )

                Health:completeAnimation()
                self.Health:setRGB( 255/255, 0/255, 0/255 )
                self.Health:setAlpha( 1 )
                self.clipFinished( Health, {} )
            end
        }
    }

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.CWBossHealth" )
    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.CWBossName" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.Name:close()
        element.HealthBacking:close()
        element.Health:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end
    
    return self
end