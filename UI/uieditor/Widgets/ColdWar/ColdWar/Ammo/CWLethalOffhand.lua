require( "ui.utility.CoreUtil" )

CoD.CWLethalOffhand = InheritFrom( LUI.UIElement )

function CoD.CWLethalOffhand.new( menu, controller )

	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setClass( CoD.CWLethalOffhand )
	self.id = "CWLethalOffhand"
	self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
	self:setLeftRight( true, false, 0, 34 )
    self:setTopBottom( true, false, 0, 30 )

	local LethalOffhandIcon = LUI.UIImage.new()
    LethalOffhandIcon:setLeftRight( true, false, 10, 34 )
    LethalOffhandIcon:setTopBottom( true, false, 0, 30 )
    LethalOffhandIcon:setImage( RegisterImage( "blacktransparent" ) )
	LethalOffhandIcon:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentPrimaryOffhand.primaryOffhand" ), function( ModelRef )
		if Engine.GetModelValue( ModelRef ) == nil then
			LethalOffhandIcon:setImage( RegisterImage( "blacktransparent" ) )
		elseif Engine.GetModelValue( ModelRef ) == "uie_t7_zm_hud_inv_icnlthl" then
            LethalOffhandIcon:setImage( RegisterImage( "rex_coldwar_ui_fraggrenade" ) )
		else
			LethalOffhandIcon:setImage( RegisterImage( Engine.GetModelValue( ModelRef ) ) )
		end
	end)
	self:addElement( LethalOffhandIcon )
	self.LethalOffhandIcon = LethalOffhandIcon

    local LethalOffhandAmmo = CoD.TextWithBg.new()
	LethalOffhandAmmo.Text:setLeftRight( true, false, 0, 13 )
	LethalOffhandAmmo.Text:setTopBottom( true, false, 13.5, 30 )
    LethalOffhandAmmo.Text:setText( "" )
    LethalOffhandAmmo.Text:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    LethalOffhandAmmo.Text:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
	LethalOffhandAmmo.Bg:setLeftRight( true, false, 0, 13.5 )
	LethalOffhandAmmo.Bg:setTopBottom( true, false, 15, 28.5 )
	LethalOffhandAmmo:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentPrimaryOffhand.primaryOffhandCount" ), function( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
			LethalOffhandAmmo.Text:setText( Engine.GetModelValue( ModelRef ) )

        	if Engine.GetModelValue( ModelRef ) == 0 then
				LethalOffhandIcon:setAlpha( 0 )
				LethalOffhandAmmo.Text:setAlpha( 0 )
				LethalOffhandAmmo.Bg:setAlpha( 0 )
			else
				LethalOffhandIcon:setAlpha( 1 )
				LethalOffhandAmmo.Text:setAlpha( 1 )
				LethalOffhandAmmo.Bg:setAlpha( 0.6 )
            end
        end
    end)
	self:addElement( LethalOffhandAmmo )
	self.LethalOffhandAmmo = LethalOffhandAmmo
	
	self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 2 )

				LethalOffhandIcon:completeAnimation()
				self.LethalOffhandIcon:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.clipFinished( LethalOffhandIcon, {} )

                LethalOffhandAmmo:completeAnimation()
				self.LethalOffhandAmmo.Bg:setRGB( 0, 0, 0 )
                self.clipFinished( LethalOffhandAmmo, {} )
            end
        }
    }

	SubscribeToModelAndUpdateState( controller, menu, self, "CurrentPrimaryOffhand.primaryOffhand" )
	SubscribeToModelAndUpdateState( controller, menu, self, "CurrentPrimaryOffhand.primaryOffhandCount" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.LethalOffhandIcon:close()
		element.LethalOffhandAmmo:close()
	end)

	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
    
	return self
end