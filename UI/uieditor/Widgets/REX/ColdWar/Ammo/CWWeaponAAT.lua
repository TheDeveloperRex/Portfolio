require( "ui.utility.CoreUtil" )

CoD.CWWeaponAAT = InheritFrom( LUI.UIElement )

function CoD.CWWeaponAAT.new( menu, controller )

	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setClass( CoD.CWWeaponAAT )
	self.id = "CWWeaponAAT"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 30 )
    self:setTopBottom( true, false, 0, 30 )

	local AATIcon = LUI.UIImage.new()
    AATIcon:setLeftRight( true, false, 0, 30 )
    AATIcon:setTopBottom( true, false, 0, 30 )
    AATIcon:setImage( RegisterImage( "blacktransparent" ) )
    AATIcon:subscribeToGlobalModel( controller, "CurrentWeapon", "aatIcon", function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )

        if val == "t7_icon_zm_aat_blast_furnace" then
            AATIcon:setImage( RegisterImage( "rex_coldwar_ui_aat_blastfurnace" ) )
        elseif val == "t7_icon_zm_aat_dead_wire" then
            AATIcon:setImage( RegisterImage( "rex_coldwar_ui_aat_deadwire" ) )
        elseif val == "t7_icon_zm_aat_fire_works" then
            AATIcon:setImage( RegisterImage( "rex_coldwar_ui_aat_fireworks" ) )
        elseif val == "t7_icon_zm_aat_thunder_wall" then
            AATIcon:setImage( RegisterImage( "rex_coldwar_ui_aat_thunderwall" ) )
        elseif val == "t7_icon_zm_aat_turned" then
            AATIcon:setImage( RegisterImage( "rex_coldwar_ui_aat_turned" ) )
        else
            AATIcon:setImage( RegisterImage( "blacktransparent" ) )
        end
    end)
    self:addElement( AATIcon )
    self.AATIcon = AATIcon

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )
		
				AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 1 )
				self.clipFinished( AATIcon, {} )
			end
		}
	}

    SubscribeToModelAndUpdateState( controller, menu, self, "CurrentWeapon.aatIcon" )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.AATIcon:close()
	end)

	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end

	return self
end

