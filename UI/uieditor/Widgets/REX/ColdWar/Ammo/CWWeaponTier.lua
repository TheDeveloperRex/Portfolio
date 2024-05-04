require( "ui.utility.CoreUtil" )

CoD.CWWeaponTier = InheritFrom( LUI.UIElement )

function CoD.CWWeaponTier.new( menu, controller )

	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setClass( CoD.CWWeaponTier )
	self.id = "CWWeaponTier"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 26.5 )
    self:setTopBottom( true, false, 0, 24.5 )

	local PAPTierIcon = LUI.UIImage.new()
    PAPTierIcon:setLeftRight( true, false, 0, 26 )
    PAPTierIcon:setTopBottom( true, false, 0, 24.5 )
    PAPTierIcon:setImage( RegisterImage( "blacktransparent" ) )
    PAPTierIcon:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.WeaponTierNotif" ), function( ModelRef )
        local val = tonumber( Engine.GetModelValue( ModelRef ) )

        if val ~= nil then
            PAPTierIcon:setImage( RegisterImage( ( ( val > 0 ) and ( "rex_coldwar_ui_pap_tier" .. val ) or "blacktransparent" ) ) )
        end
    end)
    self:addElement( PAPTierIcon )
    self.PAPTierIcon = PAPTierIcon

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )
		
				PAPTierIcon:completeAnimation()
				self.PAPTierIcon:setAlpha( 1 )
				self.clipFinished( PAPTierIcon, {} )
			end
		}
	}

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.WeaponTierNotif" )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.PAPTierIcon:close()
	end)

	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end

	return self
end

