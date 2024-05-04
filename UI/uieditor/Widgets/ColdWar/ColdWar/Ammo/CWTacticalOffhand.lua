require( "ui.utility.CoreUtil" )

CoD.CWTacticalOffhand = InheritFrom( LUI.UIElement )

function CoD.CWTacticalOffhand.new( menu, controller )

	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setClass( CoD.CWTacticalOffhand )
	self.id = "CWTacticalOffhand"
	self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
	self:setLeftRight( true, false, 0, 34 )
    self:setTopBottom( true, false, 0, 30 )

	local TacticalOffhandIcon = LUI.UIImage.new()
    TacticalOffhandIcon:setLeftRight( true, false, 10, 34 )
    TacticalOffhandIcon:setTopBottom( true, false, 0, 30 )
    TacticalOffhandIcon:setImage( RegisterImage( "blacktransparent" ) )
	TacticalOffhandIcon:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentSecondaryOffhand.secondaryOffhand" ), function( ModelRef )
		if Engine.GetModelValue( ModelRef ) == nil then
			TacticalOffhandIcon:setImage( RegisterImage( "blacktransparent" ) )
		elseif Engine.GetModelValue( ModelRef ) == "hud_cymbal_monkey_bo3" then
            TacticalOffhandIcon:setImage( RegisterImage( "rex_coldwar_ui_monkeybomb" ) )
		else
			TacticalOffhandIcon:setImage( RegisterImage( Engine.GetModelValue( ModelRef ) ) )
		end
	end)
	self:addElement( TacticalOffhandIcon )
	self.TacticalOffhandIcon = TacticalOffhandIcon

    local TacticalOffhandAmmo = CoD.TextWithBg.new()
	TacticalOffhandAmmo.Text:setLeftRight( true, false, 0, 13 )
	TacticalOffhandAmmo.Text:setTopBottom( true, false, 13.5, 30 )
    TacticalOffhandAmmo.Text:setText( "" )
    TacticalOffhandAmmo.Text:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    TacticalOffhandAmmo.Text:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
	TacticalOffhandAmmo.Bg:setLeftRight( true, false, 0, 13.5 )
	TacticalOffhandAmmo.Bg:setTopBottom( true, false, 15, 28.5 )
    TacticalOffhandAmmo:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentSecondaryOffhand.secondaryOffhandCount" ), function( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
			TacticalOffhandAmmo.Text:setText( Engine.GetModelValue( ModelRef ) )

        	if Engine.GetModelValue(ModelRef) == 0 then
				TacticalOffhandIcon:setAlpha( 0 )
				TacticalOffhandAmmo.Text:setAlpha( 0 )
				TacticalOffhandAmmo.Bg:setAlpha( 0 )
			else
				TacticalOffhandIcon:setAlpha( 1 )
				TacticalOffhandAmmo.Text:setAlpha( 1 )
				TacticalOffhandAmmo.Bg:setAlpha( 0.6 )
            end
        end
    end)
	self:addElement( TacticalOffhandAmmo )
	self.TacticalOffhandAmmo = TacticalOffhandAmmo

	self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 2 )

				self.TacticalOffhandIcon:completeAnimation()
				self.TacticalOffhandIcon:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.clipFinished( self.TacticalOffhandIcon, {} )

                self.TacticalOffhandAmmo:completeAnimation()
				self.TacticalOffhandAmmo.Bg:setRGB( 0, 0, 0 )
                self.clipFinished( self.TacticalOffhandAmmo, {} )
            end
        }
    }
	
	SubscribeToModelAndUpdateState( controller, menu, self, "CurrentSecondaryOffhand.secondaryOffhand" )
	SubscribeToModelAndUpdateState( controller, menu, self, "CurrentSecondaryOffhand.secondaryOffhandCount" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.TacticalOffhandIcon:close()
		element.TacticalOffhandAmmo:close()
	end)

	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
    
	return self
end