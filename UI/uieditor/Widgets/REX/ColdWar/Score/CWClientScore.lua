require( "ui.utility.CoreUtil" )

local ClientColor = {
    { 0.5294117647, 0.1294117647, 0.8274509804 },
    { 0.8980392157, 0.5921568627, 0.1333333333 },
    { 0.4274509804, 0.6784313725, 0.1294117647 },
    { 0.3764705882, 0.7529411765, 0.8588235294 }
}

CoD.CWClientScore = InheritFrom( LUI.UIElement )

function CoD.CWClientScore.new( menu, controller )

	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

    self:setClass( CoD.CWClientScore )
	self.id = "CWClientScore"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 122 )
    self:setTopBottom( true, false, 0, 42 )

    local Bracket = LUI.UIImage.new()
    Bracket:setLeftRight( true, false, 26.5, 29.5 )
    Bracket:setTopBottom( true, false, 0, 42 )
    Bracket:linkToElementModel( self, "clientNum", true, function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )
        
		Bracket:setRGB( ClientColor[ val + 1 ][ 1 ], ClientColor[ val + 1 ][ 2 ], ClientColor[ val + 1 ][ 3 ] )
	end)
    self:addElement( Bracket )
	self.Bracket = Bracket

    local Essence = LUI.UIImage.new()
    Essence:setLeftRight( true, false, 34, 47 )
    Essence:setTopBottom( true, false, 1.5, 14.75 )
    Essence:setImage( RegisterImage( "rex_coldwar_ui_essence" ) )
    self:addElement( Essence )
	self.Essence = Essence

    local Score = LUI.UIText.new()
    Score:setLeftRight( true, false, 49.5, 130 )
    Score:setTopBottom( true, false, 1.5, 15.5 )
    Score:setText( "" )
	Score:setTTF( "fonts/DroidSans-Bold.ttf" )
    Score:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    Score:linkToElementModel( self, "playerScore", true, function( ModelRef )
        Score:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
    end)
    self:addElement( Score )
	self.Score = Score

    local Circle = LUI.UIImage.new()
    Circle:setLeftRight( true, false, 30.5, 40 )
    Circle:setTopBottom( true, false, 31, 41 )
    Circle:setImage( RegisterImage( "rex_coldwar_ui_playerdot" ) )
    Circle:linkToElementModel( self, "clientNum", true, function( ModelRef )
        local val = Engine.GetModelValue( ModelRef );
        
		Circle:setRGB( ClientColor[ val + 1 ][ 1 ], ClientColor[ val + 1 ][ 2 ], ClientColor[ val + 1 ][ 3 ] )
	end)
    self:addElement( Circle )
	self.Circle = Circle

    local NameShadow = LUI.UIText.new()
    NameShadow:setLeftRight( true, false, 44, 130 )
    NameShadow:setTopBottom( true, false, 29.75, 43.25 )
    NameShadow:setText( "" )
    NameShadow:setTTF( "fonts/DroidSans-Bold.ttf" )
    NameShadow:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    NameShadow:linkToElementModel( self, "playerName", true, function( ModelRef )
        NameShadow:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
    end)
    self:addElement( NameShadow )
	self.NameShadow = NameShadow

    local Name = LUI.UIText.new()
    Name:setLeftRight( true, false, 43.5, 130 )
    Name:setTopBottom( true, false, 29, 42.5 )
    Name:setText( "" )
    Name:setTTF( "fonts/DroidSans-Bold.ttf" )
    Name:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    Name:linkToElementModel( self, "playerName", true, function( ModelRef )
        Name:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
    end)
    self:addElement( Name )
	self.Name = Name

    local ShieldBacking = LUI.UIImage.new()
    ShieldBacking:setLeftRight( true, false, 33.5, 125.5 )
    ShieldBacking:setTopBottom( true, false, 15.75, 19.5 )
    ShieldBacking:setImage( RegisterImage( "rex_coldwar_ui_shieldbar_bg" ) )
    self:addElement( ShieldBacking )
	self.ShieldBacking = ShieldBacking

    local Shield = LUI.UIImage.new()
    Shield:setLeftRight( true, false, 33.5, 125.5 )
    Shield:setTopBottom( true, false, 15.75, 19 )
    Shield:setImage( RegisterImage( "rex_coldwar_ui_shieldbar" ) )
    Shield:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_normal" ) )
    Shield:setShaderVector( 0, 1, 0, 0, 0 )
    Shield:setShaderVector( 1, 0, 0, 0, 0 )
    Shield:setShaderVector( 2, 1, 0, 0, 0 )
    Shield:setShaderVector( 3, 0, 0, 0, 0 )
    Shield:linkToElementModel( self, "clientNum", true, function( ModelRef )
		if Engine.GetModelValue( ModelRef ) then
            Shield:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "hudItems.ShieldBarNotif" .. Engine.GetModelValue( ModelRef ) ) ), function( ModelRef )
                local val = Engine.GetModelValue( ModelRef )
                if val then
                    Shield:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
                    Shield:setShaderVector( 0, AdjustStartEnd(0, 1,
                        CoD.GetVectorComponentFromString( val, 1 ),
                        CoD.GetVectorComponentFromString( val, 2 ),
                        CoD.GetVectorComponentFromString( val, 3 ),
                        CoD.GetVectorComponentFromString( val, 4 )))
                end
            end)
		end
        Shield:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "hudItems.ShieldBar" .. Engine.GetModelValue( ModelRef ) ) ), function( ModelRef )
            local val = Engine.GetModelValue( ModelRef )

            if val then
                ShieldBacking:setAlpha( val )
                Shield:setAlpha( val )
            end
	    end)
    end)
    self:addElement( Shield )
	self.Shield = Shield

    local HealthBacking = LUI.UIImage.new()
    HealthBacking:setLeftRight( true, false, 33, 125.5 )
    HealthBacking:setTopBottom( true, false, 21, 25.5 )
    HealthBacking:setImage( RegisterImage( "rex_coldwar_ui_healthbar_bg" ) )
    self:addElement( HealthBacking )
	self.HealthBacking = HealthBacking

    local Health = LUI.UIImage.new()
    Health:setLeftRight( true, false, 33, 125.5 )
    Health:setTopBottom( true, false, 21, 25 )
    Health:setImage( RegisterImage( "rex_coldwar_ui_healthbar" ) )
    Health:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_normal" ) )
    Health:setShaderVector( 0, 1, 0, 0, 0 )
    Health:setShaderVector( 1, 0, 0, 0, 0 )
    Health:setShaderVector( 2, 1, 0, 0, 0 )
    Health:setShaderVector( 3, 0, 0, 0, 0 )
    Health:linkToElementModel( self, "clientNum", true, function( ModelRef )
		if Engine.GetModelValue( ModelRef ) then
            Health:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "hudItems.HealthBarNotif" .. Engine.GetModelValue( ModelRef ) ) ), function( ModelRef )
                local val = Engine.GetModelValue( ModelRef )
                if val then
                    Health:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
                    Health:setShaderVector( 0, AdjustStartEnd(0, 1,
                        CoD.GetVectorComponentFromString( val, 1 ),
                        CoD.GetVectorComponentFromString( val, 2 ),
                        CoD.GetVectorComponentFromString( val, 3 ),
                        CoD.GetVectorComponentFromString( val, 4 )))
                end
            end)
		end
	end)
    self:addElement( Health )
	self.Health = Health

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 10 )

                self.Bracket:completeAnimation()
                self.Bracket:setAlpha( 0 )
                self.clipFinished( self.Bracket, {} )

                self.Essence:completeAnimation()
                self.Essence:setAlpha( 0 )
                self.clipFinished( self.Essence, {} )

                self.Score:completeAnimation()
                self.Score:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.Score:setAlpha( 0 )
                self.clipFinished( self.Score, {} )

                self.Circle:completeAnimation()
                self.Circle:setAlpha( 0 )
                self.clipFinished( self.Circle, {} )

                self.NameShadow:completeAnimation()
                self.NameShadow:setRGB( 0, 0, 0 )
                self.NameShadow:setAlpha( 0 )
                self.clipFinished( self.NameShadow, {} )

                self.Name:completeAnimation()
                self.Name:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.Name:setAlpha( 0 )
                self.clipFinished( self.Name, {} )

                self.ShieldBacking:completeAnimation()
                self.ShieldBacking:setRGB( 0, 0, 0 )
                self.ShieldBacking:setAlpha( 0 )
                self.clipFinished( self.ShieldBacking, {} )

                self.Shield:completeAnimation()
                self.Shield:setAlpha( 0 )
                self.clipFinished( self.Shield, {} )

            	self.HealthBacking:completeAnimation()
                self.HealthBacking:setRGB( 0, 0, 0 )
                self.HealthBacking:setAlpha( 0 )
                self.clipFinished( self.HealthBacking, {} )

                self.Health:completeAnimation()
                self.Health:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.Health:setAlpha( 0 )
                self.clipFinished( self.Health, {} )
            end
        },
		Visible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )
                
                self.Bracket:completeAnimation()
                self.Bracket:setAlpha( 1 )
                self.clipFinished( self.Bracket, {} )

                self.Essence:completeAnimation()
                self.Essence:setAlpha( 1 )
                self.clipFinished( self.Essence, {} )

                self.Score:completeAnimation()
                self.Score:setAlpha( 1 )
                self.clipFinished( self.Score, {} )

                self.Circle:completeAnimation()
                self.Circle:setAlpha( 1 )
                self.clipFinished( self.Circle, {} )

                self.NameShadow:completeAnimation()
                self.NameShadow:setAlpha( 1 )
                self.clipFinished( self.NameShadow, {} )

                self.Name:completeAnimation()
                self.Name:setAlpha( 1 )
                self.clipFinished( self.Name, {} )

                self.ShieldBacking:completeAnimation()
                self.ShieldBacking:setAlpha( 0 )
                self.clipFinished( self.ShieldBacking, {} )

                self.Shield:completeAnimation()
                self.Shield:setAlpha( 0 )
                self.clipFinished( self.Shield, {} )

				self.HealthBacking:completeAnimation()
                self.HealthBacking:setAlpha( 1 )
                self.clipFinished( self.HealthBacking, {} )

                self.Health:completeAnimation()
                self.Health:setAlpha( 1 )
                self.clipFinished( self.Health, {} )
			end
		}
	}

    self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function( menu, element, event )
				return not IsSelfModelValueEqualTo( element, controller, "playerScoreShown", 0 )
			end
		}
	})
    LinkToElementModelAndUpdateState( menu, self, "playerScoreShown", true )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.Bracket:close()
        element.Essence:close()
        element.Score:close()
        element.Circle:close()
        element.NameShadow:close()
        element.Name:close()
        element.ShieldBacking:close()
        element.Shield:close()
		element.HealthBacking:close()
		element.Health:close()
	end)

	if PostLoadFunc then
		PostLoadFunc( menu, controller )
	end

	return self
end