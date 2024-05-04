require( "ui.utility.CoreUtil" )

local ClientColor = {
    { 0.5294117647, 0.1294117647, 0.8274509804 },
    { 0.8980392157, 0.5921568627, 0.1333333333 },
    { 0.4274509804, 0.6784313725, 0.1294117647 },
    { 0.3764705882, 0.7529411765, 0.8588235294 }
}

CoD.CWScoreboard = InheritFrom( LUI.UIElement )

CoD.CWScoreboard.new = function( menu, controller )

    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setUseStencil( false )
    self:setClass( CoD.CWScoreboard )
    self.id = "CWScoreboard"
    self.soundSet = "default"
    self:setLeftRight( true, false, 0, 0 )
    self:setTopBottom( true, false, 0, 63 )
    self.anyChildUsesUpdateState = true

    local Downs = LUI.UIText.new()
    Downs:setLeftRight( true, false, 0, 1127 )
    Downs:setTopBottom( true, false, 164, 181.5 )
    Downs:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    Downs:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
    Downs:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function( ModelRef )
		if Engine.GetModelValue(ModelRef) then
			Downs:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 2, Engine.GetModelValue( ModelRef ) ) ) )
		end
	end)

    self:addElement( Downs )
    self.Downs = Downs

    local Revives = LUI.UIText.new()
    Revives:setLeftRight(true, false, 0, 1003.5)
    Revives:setTopBottom(true, false, 164, 181.5)
    Revives:setTTF("fonts/MaximaTOTBold-Regular.ttf")
    Revives:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
    Revives:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function( ModelRef )
		if Engine.GetModelValue( ModelRef ) then
			Revives:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 3, Engine.GetModelValue( ModelRef ) ) ) )
		end
	end)

    self:addElement( Revives )
    self.Revives = Revives

    local Headshots = LUI.UIText.new()
    Headshots:setLeftRight( true, false, 0, 873.5 )
    Headshots:setTopBottom( true, false, 164, 181.5 )
    Headshots:setTTF("fonts/MaximaTOTBold-Regular.ttf")
    Headshots:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
    Headshots:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function( ModelRef )
		if Engine.GetModelValue( ModelRef ) then
			Headshots:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 4, Engine.GetModelValue( ModelRef ) ) ) )
		end
	end)
    self:addElement( Headshots )
    self.Headshots = Headshots

    local Kills = LUI.UIText.new()
    Kills:setLeftRight( true, false, 0, 727 )
    Kills:setTopBottom( true, false, 164, 181.5 )
    Kills:setTTF("fonts/MaximaTOTBold-Regular.ttf")
    Kills:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
    Kills:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function( ModelRef )
		if Engine.GetModelValue( ModelRef ) then
			Kills:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 1, Engine.GetModelValue( ModelRef ) ) ) )
		end
	end)
    self:addElement( Kills )
    self.Kills = Kills

    local Score = LUI.UIText.new()
    Score:setLeftRight( true, false, 0, 558.5 )
    Score:setTopBottom( true, false, 159.5, 184 )
    Score:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    Score:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
    Score:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function( ModelRef )
		if Engine.GetModelValue( ModelRef ) then
			Score:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 0, Engine.GetModelValue( ModelRef ) ) ) )
		end
	end)
    self:addElement( Score )
    self.Score = Score

    local Background = LUI.UIImage.new()
    Background:setLeftRight( true, false, 143, 372 )
    Background:setTopBottom( true, false, 142.5, 205.5 )
    Background:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_player_bg" ) )
    self:addElement( Background )
    self.Background = Background

    local Name = LUI.UIText.new()
    Name:setLeftRight( true, false, 217.5, 1280 )
    Name:setTopBottom( true, false, 157.5, 172 )
    Name:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    Name:linkToElementModel( self, "clientNum", true, function( ModelRef) 
        if Engine.GetModelValue( ModelRef ) then
            Name:setText( GetClientNameAndClanTag( controller, Engine.GetModelValue( ModelRef ) ) )
        end
    end)
    self:addElement( Name )
    self.Name = Name

    local Circle = LUI.UIImage.new()
    Circle:setLeftRight( true, false, 202.75, 214.75 )
    Circle:setTopBottom( true, false, 158.5, 170.5 )
    Circle:setImage( RegisterImage( "rex_coldwar_ui_playerdot" ) )
    Circle:linkToElementModel( self, "clientNum", true, function( ModelRef ) 
        local val = Engine.GetModelValue( ModelRef )
        val = ( ( val == -1 ) and 0 or val )

        if val then
            Circle:setRGB( ClientColor[ val + 1 ][ 1 ], ClientColor[ val + 1 ][ 2 ], ClientColor[ val + 1 ][ 3 ] )
        end
    end)
    self:addElement( Circle )
    self.Circle = Circle

    local Portrait = LUI.UIImage.new()
    Portrait:setLeftRight( true, false, 148, 184 )
    Portrait:setTopBottom( true, false, 144.5, 201.25 ) --145.5, 201
    Portrait:setImage( RegisterImage( "blacktransparent" ) )
    Portrait:linkToElementModel( self, "clientNum", true, function( ModelRef ) 
        Portrait:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "hudItems.PlayerCharIndex" .. Engine.GetModelValue( ModelRef ) ) ), function( ModelRef )
            local val = Engine.GetModelValue( ModelRef )
            if val then
                Portrait:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_portrait_test_" .. val ) )
            end
        end)
    end)
    self:addElement( Portrait )
    self.Portrait = Portrait

    self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
                self:setupElementClipCounter( 9 )

                Downs:completeAnimation()
                self.Downs:setRGB( 1, 1, 1 )
                self.clipFinished( Downs, {} )
                
                Revives:completeAnimation()
                self.Revives:setRGB( 1, 1, 1 )
                self.clipFinished( Revives, {} )
                
                Headshots:completeAnimation()
                self.Headshots:setRGB( 1, 1, 1 )
                self.clipFinished( Headshots, {} )
                
                Kills:completeAnimation()
                self.Kills:setRGB( 1, 1, 1 )
                self.clipFinished( Kills, {} )
                
                Score:completeAnimation()
                self.Score:setRGB( 1, 1, 1 )
                self.clipFinished( Score, {} )
                
                Background:completeAnimation()
                self.clipFinished( Background, {} )
                
                Name:completeAnimation()
                self.Name:setRGB( 1, 1, 1 )
                self.clipFinished( Name, {} )
                
                Circle:completeAnimation()
                self.clipFinished( Circle, {} )
                
                Portrait:completeAnimation()
                self.clipFinished( Portrait, {} )
                
            end
        },
        IsSelf = {
			DefaultClip = function()
                self:setupElementClipCounter( 9 )

                Downs:completeAnimation()
                self.Downs:setRGB( 0.8666666666666667, 0.6392156862745098, 0 )
                self.clipFinished( Downs, {} )
                
                Revives:completeAnimation()
                self.Revives:setRGB( 0.8666666666666667, 0.6392156862745098, 0 )
                self.clipFinished( Revives, {} )
                
                Headshots:completeAnimation()
                self.Headshots:setRGB( 0.8666666666666667, 0.6392156862745098, 0 )
                self.clipFinished( Headshots, {} )
                
                Kills:completeAnimation()
                self.Kills:setRGB( 0.8666666666666667, 0.6392156862745098, 0 )
                self.clipFinished( Kills, {} )
                
                Score:completeAnimation()
                self.Score:setRGB( 0.8666666666666667, 0.6392156862745098, 0 )
                self.clipFinished( Score, {} )
                
                Background:completeAnimation()
                self.clipFinished( Background, {} )
                
                Name:completeAnimation()
                self.Name:setRGB( 0.8666666666666667, 0.6392156862745098, 0 )
                self.clipFinished( Name, {} )
                
                Circle:completeAnimation()
                self.clipFinished( Circle, {} )
                
                Portrait:completeAnimation()
                self.clipFinished( Portrait, {} )
                
            end
        }
    }

    self:mergeStateConditions( {
		{
			stateName = "IsSelf",
			condition = function( menu, element, event )
				return IsScoreboardPlayerSelf( element, controller )
			end
		}
	})
    LinkToElementModelAndUpdateState( menu, self, "clientNum", true )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.Downs:close()
        element.Revives:close()
        element.Headshots:close()
        element.Kills:close()
        element.Score:close()
        element.Background:close()
        element.Name:close()
        element.Circle:close()
        element.Portrait:close()
	end)

    if PostLoadFunc then
      PostLoadFunc( menu, controller )
    end

    return self
end