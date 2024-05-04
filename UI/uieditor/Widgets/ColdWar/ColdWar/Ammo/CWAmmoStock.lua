require( "ui.utility.CoreUtil" )

CoD.CWAmmoStock = InheritFrom( LUI.UIElement )

function CoD.CWAmmoStock.new( menu, controller )
    
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( menu, controller )
    end

    self:setClass( CoD.CWAmmoStock )
    self.id = "CWAmmoStock"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 52 )
    self:setTopBottom( true, false, 0, 28.5 )

    local Backing = LUI.UIImage.new()
    Backing:setLeftRight( true, false, 0, 52 )
    Backing:setTopBottom( true, false, 0, 28.5 )
    Backing:setImage( RegisterImage( "rex_coldwar_ui_reserve_bg") )
    self:addElement( Backing )
    self.Backing = Backing

    local StockAmmo = LUI.UIText.new()
    StockAmmo:setLeftRight( true, true, -12, -4 )
    StockAmmo:setTopBottom( true, true, 0.5, 0.5 )
    StockAmmo:setText( "" )
    StockAmmo:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
    StockAmmo:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    StockAmmo:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoStock" ), function( ModelRef )
        local AmmoInStock = Engine.GetModelValue( ModelRef )

        if AmmoInStock ~= nil then
            StockAmmo:setText( Engine.Localize( AmmoInStock ) )
        end
    end)
    self:addElement( StockAmmo )
    self.StockAmmo = StockAmmo

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 2 )

                Backing:completeAnimation()
                self.Backing:setAlpha( 0.75 )
                self.clipFinished( Backing, {} )

                StockAmmo:completeAnimation()
                self.StockAmmo:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.StockAmmo:setAlpha( 1 )
                self.clipFinished( StockAmmo, {} )
            end
        }
    }
 
    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.Backing:close()
        element.StockAmmo:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( menu, controller )
    end
    
    return self
end