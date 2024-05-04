require( "ui.utility.CoreUtil" )

CoD.CWWeaponRarity = InheritFrom( LUI.UIElement )

function CoD.CWWeaponRarity.new( menu, controller )
    
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( menu, controller )
    end 

    self:setClass( CoD.CWWeaponRarity )
    self.id = "CWWeaponRarity"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 176 )
    self:setTopBottom( true, false, 0, 17.5 )

    local WeaponRarity = LUI.UIImage.new()
    WeaponRarity:setLeftRight( true, false, 0, 176 )
    WeaponRarity:setTopBottom( true, false, 0, 17.5 )
    WeaponRarity:setImage( RegisterImage( "rex_coldwar_ui_weaponrarity_bg" ) )
    WeaponRarity:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.WeaponRarityNotif" ), function( ModelRef )
        local val = tonumber( Engine.GetModelValue( ModelRef ) )
        if val ~= nil then
            if val == 0 then
                WeaponRarity:setRGB( 0.807843137254902, 0.058823529411764705, 0.11764705882352941 ) -- Default Loadout
            elseif val == 1 then
                WeaponRarity:setRGB( 0.6588235294117647, 0.6823529411764706, 0.6823529411764706 ) -- Common
            elseif val == 2 then
                WeaponRarity:setRGB( 0.4823529411764706, 0.6588235294117647, 0.30980392156862746 ) -- Uncommon
            elseif val == 3 then
                WeaponRarity:setRGB( 0.403921568627451, 0.5803921568627451, 0.807843137254902 ) -- Rare
            elseif val == 4 then
                WeaponRarity:setRGB( 0.7568627450980392, 0.4117647058823529, 0.9490196078431372 ) -- Epic
            elseif val == 5 then
                WeaponRarity:setRGB( 0.9568627450980393, 0.4823529411764706, 0.07058823529411765 ) -- Legendary
            elseif val == 6 then
                WeaponRarity:setRGB( 0.9294117647058824, 0.796078431372549, 0.33725490196078434 ) -- Mythic
            end
        end
    end)
    self:addElement( WeaponRarity )
    self.WeaponRarity = WeaponRarity
    
    local WeaponName = LUI.UIText.new()
    WeaponName:setLeftRight( true, false, -16, 168 )
    WeaponName:setTopBottom( true, false, 2, 15 )
    WeaponName:setText( "" )
    WeaponName:setTTF( "fonts/DroidSans-Bold.ttf" )
    WeaponName:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
    WeaponName:subscribeToGlobalModel( controller, "CurrentWeapon", "WeaponName", function( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            WeaponName:setText( Engine.Localize( Engine.ToUpper( Engine.GetModelValue( ModelRef ) ) ) )
        end
    end)
    self:addElement( WeaponName )
    self.WeaponName = WeaponName

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 2 )

                WeaponRarity:completeAnimation()
                self.WeaponRarity:setAlpha( 0.85 )
                self.clipFinished( WeaponRarity, {} )

                WeaponName:completeAnimation()
                self.WeaponName:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.WeaponName:setAlpha( 1 )
                self.clipFinished( WeaponName, {} )
            end
        }
    }
    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.WeaponRarityNotif" )
    SubscribeToModelAndUpdateState( controller, menu, self, "CurrentWeapon.WeaponName" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.WeaponRarity:close()
        element.WeaponName:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( menu, controller )
    end
    
    return self

end