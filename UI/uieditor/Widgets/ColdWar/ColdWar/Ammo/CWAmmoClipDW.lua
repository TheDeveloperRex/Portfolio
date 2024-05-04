require( "ui.utility.CoreUtil" )

CoD.CWAmmoClipDW = InheritFrom( LUI.UIElement )

function CoD.CWAmmoClipDW.new( menu, controller )
    
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass( CoD.CWAmmoClipDW )
    self.id = "CWAmmoClipDW"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 114 )
    self:setTopBottom( true, false, 0, 30 )

    local ClipAmmoDW = LUI.UIText.new()
    ClipAmmoDW:setLeftRight( true, false, 0, 107.5 )
    ClipAmmoDW:setTopBottom( true, false, 0, 30 )
    ClipAmmoDW:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
	ClipAmmoDW:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	ClipAmmoDW:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoInDWClip", function( ModelRef )
		if Engine.GetModelValue( ModelRef ) then
			if IsLowAmmoDWClip( controller ) then
				ClipAmmoDW:setRGB( 0.7843137254901961, 0.0313725490196078, 0 ) -- almost red
			else
				ClipAmmoDW:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
			end

			ClipAmmoDW:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
		end
	end)
    self:addElement( ClipAmmoDW )
    self.ClipAmmoDW = ClipAmmoDW

    local Divider = LUI.UIImage.new()
    Divider:setLeftRight( true, false, 112.45, 113.95 )
    Divider:setTopBottom( true, false, 6, 23.5 )
    Divider:setImage( RegisterImage( "rex_coldwar_ui_divider_dw" ) )
    self:addElement( Divider )
    self.Divider = Divider

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 2 )

                ClipAmmoDW:completeAnimation()
                self.ClipAmmoDW:setAlpha( 1 )
                self.clipFinished( ClipAmmoDW, {} )

                Divider:completeAnimation()
                self.Divider:setAlpha( 1 )
                self.clipFinished( Divider, {} )
            end
        }
    }

    SubscribeToModelAndUpdateState( controller, menu, self, "CurrentWeapon.ammoInDWClip" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.ClipAmmoDW:close()
        element.Divider:close()

    end)

    if PostLoadFunc then
        PostLoadFunc( menu, controller )
    end
    
    return self
end