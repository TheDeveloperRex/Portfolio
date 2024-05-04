require( "ui.utility.CoreUtil" )

CoD.CWAmmoClip = InheritFrom( LUI.UIElement )

function CoD.CWAmmoClip.new( menu, controller )
    
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass( CoD.CWAmmoClip )
    self.id = "CWAmmoClip"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 148 )
    self:setTopBottom( true, false, 0, 47 )

    local ClipAmmo = LUI.UIText.new()
    ClipAmmo:setLeftRight( true, false, 0, 145.75 )
    ClipAmmo:setTopBottom( true, false, 0, 47 )
    ClipAmmo:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
	ClipAmmo:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	ClipAmmo:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoInClip", function( ModelRef )
		if Engine.GetModelValue( ModelRef ) then
			if IsLowAmmoClip( controller ) then
				ClipAmmo:setRGB( 0.7843137254901961, 0.0313725490196078, 0 ) -- almost red
			else
				ClipAmmo:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
			end
            
			ClipAmmo:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
		end
	end)
    self:addElement( ClipAmmo )
    self.ClipAmmo = ClipAmmo

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                ClipAmmo:completeAnimation()
                self.ClipAmmo:setLeftRight( true, false, 0, 145.75 )
                self.ClipAmmo:setTopBottom( true, false, 0, 47 )
                self.ClipAmmo:setAlpha( 1 )
                self.clipFinished( ClipAmmo, {} )
            end
        },
        DualWield = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                ClipAmmo:completeAnimation()
                self.ClipAmmo:setLeftRight( true, false, 0, 147.25 )
                self.ClipAmmo:setTopBottom( true, false, 9, 39 )
                self.ClipAmmo:setAlpha( 1 )
                self.clipFinished( ClipAmmo, {} )
            end
        }
    }

    self:mergeStateConditions({
		{
			stateName = "DefaultState",
			condition = function( menu, element, event )
				return IsModelValueEqualTo( controller, "currentWeapon.ammoInDWClip", -1 )
			end
		},
		{
			stateName = "DualWield",
			condition = function( menu, element, event )
				if WeaponUsesAmmo( controller ) then
					return IsModelValueGreaterThanOrEqualTo( controller, "currentWeapon.ammoInDWClip", 0 )
				end
			end
		}
	})

    SubscribeToModelAndUpdateState( controller, menu, self, "CurrentWeapon.ammoInDWClip" )
    SubscribeToModelAndUpdateState( controller, menu, self, "CurrentWeapon.ammoInClip" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.ClipAmmo:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( menu, controller )
    end
    
    return self
end