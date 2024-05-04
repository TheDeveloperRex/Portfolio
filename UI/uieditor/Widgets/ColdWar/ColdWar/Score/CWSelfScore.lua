require( "ui.utility.CoreUtil" )

local ClientColor = {
    { 0.5294117647, 0.1294117647, 0.8274509804 },
    { 0.8980392157, 0.5921568627, 0.1333333333 },
    { 0.4274509804, 0.6784313725, 0.1294117647 },
    { 0.3764705882, 0.7529411765, 0.8588235294 }
}

local PreLoadFunc = function( menu, controller )
    Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.HealthBarNum" )
end

CoD.CWSelfScore = InheritFrom( LUI.UIElement )

function CoD.CWSelfScore.new( menu, controller )

	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

    self:setClass( CoD.CWSelfScore )
	self.id = "CWSelfScore"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 200 )
    self:setTopBottom( true, false, 0, 75 )

    local Bracket = LUI.UIImage.new()
    Bracket:setLeftRight( true, false, 26.5, 29.5 )
    Bracket:setTopBottom( true, false, 5, 51.5 )
    Bracket:setImage( RegisterImage( "rex_coldwar_ui_bracket" ) )
    Bracket:linkToElementModel( self, "clientNum", true, function( ModelRef )
        local val = Engine.GetModelValue( ModelRef );
        
		Bracket:setRGB( ClientColor[ val + 1 ][ 1 ], ClientColor[ val + 1 ][ 2 ], ClientColor[ val + 1 ][ 3 ] )
	end)
    self:addElement( Bracket )
	self.Bracket = Bracket

    local Essence = LUI.UIImage.new()
    Essence:setLeftRight( true, false, 35, 53.5 )
    Essence:setTopBottom( true, false, 2, 21 )
    Essence:setImage( RegisterImage( "rex_coldwar_ui_essence" ) )
    self:addElement( Essence )
	self.Essence = Essence

    local Score = LUI.UIText.new()
    Score:setLeftRight( true, false, 55.5, 200 )
    Score:setTopBottom( true, false, 2.5, 22 )
    Score:setText( "" )
	Score:setTTF( "fonts/DroidSans-Bold.ttf" )
    Score:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    Score:linkToElementModel( self, "playerScore", true, function( ModelRef )
        Score:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
    end)
    self:addElement( Score )
	self.Score = Score

    local Circle = LUI.UIImage.new()
    Circle:setLeftRight( true, false, 32, 41.5 )
    Circle:setTopBottom( true, false, 42, 52 )
    Circle:setImage( RegisterImage( "rex_coldwar_ui_playerdot" ) )
    Circle:linkToElementModel( self, "clientNum", true, function( ModelRef )
        local val = Engine.GetModelValue( ModelRef );

		Circle:setRGB( ClientColor[ val + 1 ][ 1 ], ClientColor[ val + 1 ][ 2 ], ClientColor[ val + 1 ][ 3 ] )
	end)
    self:addElement( Circle )
	self.Circle = Circle

    local Name = LUI.UIText.new()
    Name:setLeftRight( true, false, 44.5, 200 )
    Name:setTopBottom( true, false, 40, 54.65 )
    Name:setText( "" )
    Name:setTTF( "fonts/DroidSans-Bold.ttf" )
    Name:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    Name:linkToElementModel( self, "playerName", true, function( ModelRef )
        Name:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
    end)
    self:addElement( Name )
	self.Name = Name

    local ShieldBacking = LUI.UIImage.new()
    ShieldBacking:setLeftRight( true, false, 33.5, 156.5 )
    ShieldBacking:setTopBottom( true, false, 21.5, 26.75 )
    ShieldBacking:setImage( RegisterImage( "rex_coldwar_ui_shieldbar_bg" ) )
    ShieldBacking:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_normal" ) )
    ShieldBacking:setShaderVector( 0, 1, 0, 0, 0 )
    ShieldBacking:setShaderVector( 1, 0, 0, 0, 0 )
    ShieldBacking:setShaderVector( 2, 1, 0, 0, 0 )
    ShieldBacking:setShaderVector( 3, 0, 0, 0, 0 )
    ShieldBacking:linkToElementModel( self, "clientNum", true, function( ModelRef ) 
        local val = Engine.GetModelValue( ModelRef )
        val = ( ( val == -1 ) and 0 or val )

        if val then
            ShieldBacking:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "hudItems.ShieldBGNotif" .. val ) ), function( ModelRef )
                local val = Engine.GetModelValue( ModelRef )
                if val then
                    ShieldBacking:setShaderVector( 0, AdjustStartEnd(0, 1,
                        CoD.GetVectorComponentFromString( val, 1 ),
                        CoD.GetVectorComponentFromString( val, 2 ),
                        CoD.GetVectorComponentFromString( val, 3 ),
                        CoD.GetVectorComponentFromString( val, 4 ))
                    )
                end
            end)
        end
    end)
    self:addElement( ShieldBacking )
	self.ShieldBacking = ShieldBacking

    local Shield = LUI.UIImage.new()
    Shield:setLeftRight( true, false, 33.5, 156.5 )
    Shield:setTopBottom( true, false, 22, 26.5 )
    Shield:setImage( RegisterImage( "rex_coldwar_ui_shieldbar" ) )
    Shield:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_normal" ) )
    Shield:setShaderVector( 0, 1, 0, 0, 0 )
    Shield:setShaderVector( 1, 0, 0, 0, 0 )
    Shield:setShaderVector( 2, 1, 0, 0, 0 )
    Shield:setShaderVector( 3, 0, 0, 0, 0 )
    Shield:linkToElementModel( self, "clientNum", true, function( ModelRef ) 
        local val = Engine.GetModelValue( ModelRef )
        val = ( ( val == -1 ) and 0 or val )

        if val then
            Shield:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "hudItems.ShieldBarNotif" .. val ) ), function( ModelRef )
                local val = Engine.GetModelValue( ModelRef )
                if val then
                    Shield:setShaderVector( 0, AdjustStartEnd(0, 1,
                        CoD.GetVectorComponentFromString( val, 1 ),
                        CoD.GetVectorComponentFromString( val, 2 ),
                        CoD.GetVectorComponentFromString( val, 3 ),
                        CoD.GetVectorComponentFromString( val, 4 ))
                    )
                end
            end)
            Shield:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "hudItems.ShieldBar" .. val ) ), function( ModelRef )
                local val = Engine.GetModelValue( ModelRef )
                if val then
                    ShieldBacking:setAlpha( val )
                    Shield:setAlpha( val )
                end
            end)
        end
    end)
    self:addElement( Shield )
	self.Shield = Shield

    local HealthBacking = LUI.UIImage.new()
    HealthBacking:setLeftRight( true, false, 33.5, 156.5 )
    HealthBacking:setTopBottom( true, false, 28.25, 35 )
    HealthBacking:setImage( RegisterImage( "rex_coldwar_ui_healthbar_bg" ) )
    self:addElement( HealthBacking )
	self.HealthBacking = HealthBacking
    
    local HealthDecrement = LUI.UIImage.new()
    HealthDecrement:setLeftRight( true, false, 33.25, 156.75 )
    HealthDecrement:setTopBottom( true, false, 28, 35 )
    HealthDecrement:setImage( RegisterImage( "rex_coldwar_ui_healthbar" ) )
    HealthDecrement:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_normal" ) )
    HealthDecrement:setShaderVector( 0, 1, 0, 0, 0 )
    HealthDecrement:setShaderVector( 1, 0, 0, 0, 0 )
    HealthDecrement:setShaderVector( 2, 1, 0, 0, 0 )
    HealthDecrement:setShaderVector( 3, 0, 0, 0, 0 )
    HealthDecrement:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "hudItems.HealthBarNotif" .. Engine.GetClientNum( controller ) ) ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )
        if val then
            HealthDecrement:beginAnimation( "keyframe", 350, false, false, CoD.TweenType.Linear )
            HealthDecrement:setShaderVector( 0, AdjustStartEnd(0, 1,
                CoD.GetVectorComponentFromString( val, 1 ),
                CoD.GetVectorComponentFromString( val, 2 ),
                CoD.GetVectorComponentFromString( val, 3 ),
                CoD.GetVectorComponentFromString( val, 4 )))
        end
    end)
    self:addElement( HealthDecrement )
	self.HealthDecrement = HealthDecrement

    local Health = LUI.UIImage.new()
    Health:setLeftRight( true, false, 33.25, 156.75 )
    Health:setTopBottom( true, false, 28, 35 )
    Health:setImage( RegisterImage( "rex_coldwar_ui_healthbar" ) )
    Health:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_normal" ) )
    Health:setShaderVector( 0, 1, 0, 0, 0 )
    Health:setShaderVector( 1, 0, 0, 0, 0 )
    Health:setShaderVector( 2, 1, 0, 0, 0 )
    Health:setShaderVector( 3, 0, 0, 0, 0 )
    Health:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "hudItems.HealthBarNotif" .. Engine.GetClientNum( controller ) ) ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )
        if val then
            Health:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
            Health:setShaderVector( 0, AdjustStartEnd(0, 1,
                CoD.GetVectorComponentFromString( val, 1 ),
                CoD.GetVectorComponentFromString( val, 2 ),
                CoD.GetVectorComponentFromString( val, 3 ),
                CoD.GetVectorComponentFromString( val, 4 )))
        end
    end)
    self:addElement( Health )
	self.Health = Health
    
    local HealthNumber = LUI.UIText.new()
    HealthNumber:setLeftRight( true, false, 166.5, 200.5 )
    HealthNumber:setTopBottom( true, false, 22, 45 )
    HealthNumber:setText( "" )
    HealthNumber:setTTF( "fonts/DroidSans-Bold.ttf" )
	HealthNumber:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    HealthNumber:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.HealthBarNum" ), function( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            HealthNumber:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
        end
    end)
    self:addElement( HealthNumber )
	self.HealthNumber = HealthNumber

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 11 )

            	self.Bracket:completeAnimation()
                self.Bracket:setAlpha( 1 )
                self.clipFinished( self.Bracket, {} )

                self.Essence:completeAnimation()
                self.Essence:setAlpha( 1 )
                self.clipFinished( self.Essence, {} )

            	self.Score:completeAnimation()
                self.Score:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.clipFinished( self.Score, {} )

                self.Circle:completeAnimation()
                self.Circle:setAlpha( 1 )
                self.clipFinished( self.Circle, {} )

                self.Name:completeAnimation()
                self.Name:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.clipFinished( self.Name, {} )

                self.ShieldBacking:completeAnimation()
                self.ShieldBacking:setRGB( 0, 0, 0 )
                self.clipFinished( self.ShieldBacking, {} )

                self.Shield:completeAnimation()
                self.Shield:setAlpha( 0 )
                self.clipFinished( self.Shield, {} )

                self.HealthBacking:completeAnimation()
                self.HealthBacking:setRGB( 0, 0, 0 )
                self.clipFinished( self.HealthBacking, {} )

                self.HealthDecrement:completeAnimation()
                self.HealthDecrement:setRGB( 0.5490196078431373, 0.09803921568627451, 0.01568627450980392 ) -- almost white
                self.clipFinished( self.HealthDecrement, {} )

                self.Health:completeAnimation()
                self.Health:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.clipFinished( self.Health, {} )

                self.HealthNumber:completeAnimation()
                self.HealthNumber:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.clipFinished( self.HealthNumber, {} )
            end
        }
	}
    --SubscribeToModelAndUpdateState( controller, menu, self, "ZMInventory.shield_health" )
    --SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.showDpadDown" )
    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.HealthBarNum" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Bracket:close()
		element.Essence:close()
		element.Score:close()
		element.Circle:close()
		element.Name:close()
        element.Shield:close()
        element.ShieldBacking:close()
        element.HealthBacking:close()
        element.HealthDecrement:close()
		element.Health:close()
        element.HealthNumber:close()
	end)

	if PostLoadFunc then
		PostLoadFunc( menu, controller )
	end

	return self
end