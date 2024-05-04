require( "ui.uieditor.widgets.REX.ColdWar.Ammo.CWAmmoClip" )
require( "ui.uieditor.widgets.REX.ColdWar.Ammo.CWAmmoClipDW" )
require( "ui.uieditor.widgets.REX.ColdWar.Ammo.CWAmmoStock" )
require( "ui.uieditor.widgets.REX.ColdWar.Ammo.CWLethalOffhand" )
require( "ui.uieditor.widgets.REX.ColdWar.Ammo.CWTacticalOffhand" )
require( "ui.uieditor.widgets.REX.ColdWar.Ammo.CWWeaponRarity" )
require( "ui.uieditor.widgets.REX.ColdWar.Ammo.CWWeaponTier" )
require( "ui.uieditor.widgets.REX.ColdWar.Ammo.CWWeaponAAT" )
require( "ui.utility.CoreUtil" )

local PreLoadFunc = function( menu, controller )
end

CoD.CWAmmoContainer = InheritFrom( LUI.UIElement )
        
function CoD.CWAmmoContainer.new( menu, controller )
    
    local self = LUI.UIElement.new()
    
    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass( CoD.CWAmmoContainer )
    self.id = "CWAmmoContainer"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 400 )
    self:setTopBottom( true, false, 0, 100 )

    local ClipAmmo = CoD.CWAmmoClip.new( menu, controller )
    ClipAmmo:setLeftRight( true, false, 0, 148 )
    ClipAmmo:setTopBottom( true, false, 22.5, 69.5 )
    self:addElement( ClipAmmo )
    self.ClipAmmo = ClipAmmo

    local ClipAmmoDW = CoD.CWAmmoClipDW.new( menu, controller )
    ClipAmmoDW:setLeftRight( true, false, 0, 114 )
    ClipAmmoDW:setTopBottom( true, false, 31.5, 61.5 )
    self:addElement( ClipAmmoDW )
    self.ClipAmmoDW = ClipAmmoDW

    local StockAmmo = CoD.CWAmmoStock.new( menu, controller )
    StockAmmo:setLeftRight( true, false, 151.5, 203.5 )
    StockAmmo:setTopBottom( true, false, 31.5, 60 )
    self:addElement( StockAmmo )
    self.StockAmmo = StockAmmo

    local AmmoDivider = LUI.UIImage.new()
    AmmoDivider:setLeftRight( true, false, 15, 203.5 )
    AmmoDivider:setTopBottom( true, false, 62.75, 64.25 )
    AmmoDivider:setImage( RegisterImage( "rex_coldwar_ui_divider" ) )
    self:addElement( AmmoDivider )
    self.AmmoDivider = AmmoDivider

    local LethalOffhand = CoD.CWLethalOffhand.new( menu, controller )
    LethalOffhand:setLeftRight( true, false, 280.5, 314.5 )
    LethalOffhand:setTopBottom( true, false, 31, 61 )
    self:addElement( LethalOffhand )
    self.LethalOffhand = LethalOffhand

    local LethalDivider = LUI.UIImage.new()
    LethalDivider:setLeftRight( true, false, 280.5, 314 )
    LethalDivider:setTopBottom( true, false, 62.75, 64.25 )
    LethalDivider:setImage( RegisterImage( "rex_coldwar_ui_divider_eq" ) )
    self:addElement( LethalDivider )
    self.LethalDivider = LethalDivider

    local TacticalOffhand = CoD.CWTacticalOffhand.new( menu, controller )
    TacticalOffhand:setLeftRight( true, false, 232.5, 266.5 )
    TacticalOffhand:setTopBottom( true, false, 31, 61 )
    self:addElement( TacticalOffhand )
    self.TacticalOffhand = TacticalOffhand

    local TacticalDivider = LUI.UIImage.new()
    TacticalDivider:setLeftRight( true, false, 228, 261.5 )
    TacticalDivider:setTopBottom( true, false, 62.75, 64.25 )
    TacticalDivider:setImage( RegisterImage( "rex_coldwar_ui_divider_eq" ) )
    self:addElement( TacticalDivider )
    self.TacticalDivider = TacticalDivider

    local WeaponRarity = CoD.CWWeaponRarity.new( menu, controller )
    WeaponRarity:setLeftRight( true, false, 30, 206 )
    WeaponRarity:setTopBottom( true, false, 65.5, 83 )
    self:addElement( WeaponRarity )
    self.WeaponRarity = WeaponRarity

    local WeaponTier = CoD.CWWeaponTier.new( menu, controller )
    WeaponTier:setLeftRight( true, false, 49.75, 76.25 )
    WeaponTier:setTopBottom( true, false, 35, 59.5 )
    self:addElement( WeaponTier )
    self.WeaponTier = WeaponTier

    local WeaponAAT = CoD.CWWeaponAAT.new( menu, controller )
    WeaponAAT:setLeftRight( true, false, 16, 46 )
    WeaponAAT:setTopBottom( true, false, 32, 62 )
    self:addElement( WeaponAAT )
    self.WeaponAAT = WeaponAAT

    -- YUMMY STUDIOS EXCLUSIVE
    local YummyIcon = LUI.UIImage.new()
    YummyIcon:setLeftRight( true, false, 326, 388 ) --326, 370
    YummyIcon:setTopBottom( true, false, 16, 78 ) --24, 68
    YummyIcon:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_emblem" ) )
    self:addElement( YummyIcon )
    self.YummyIcon = YummyIcon

    local YummyTitle = LUI.UIText.new()
    YummyTitle:setLeftRight( true, false, 314, 400 )
    YummyTitle:setTopBottom( true, false, 68, 80 )
    YummyTitle:setTTF( "fonts/DroidSans-Bold.ttf" )
    YummyTitle:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    YummyTitle:setText( "YUMMY STUDIOS" )
    self:addElement( YummyTitle )
    self.YummyTitle = YummyTitle

    local YummyQuote = LUI.UIText.new()
    YummyQuote:setLeftRight( true, false, 314, 400 )
    YummyQuote:setTopBottom( true, false, 80, 90 )
    YummyQuote:setTTF( "fonts/DroidSans-Bold.ttf" )
    YummyQuote:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    YummyQuote:setText( "ONLY THE BEST!" )
    self:addElement( YummyQuote )
    self.YummyQuote = YummyQuote

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 14 )

                ClipAmmo:completeAnimation()
                self.ClipAmmo:setAlpha( 1 )
                self.clipFinished( ClipAmmo, {} )

                ClipAmmoDW:completeAnimation()
                self.ClipAmmoDW:setAlpha( 0 )
                self.clipFinished( ClipAmmoDW, {} )

                StockAmmo:completeAnimation()
                self.StockAmmo:setAlpha( 1 )
                self.clipFinished( StockAmmo, {} )

                AmmoDivider:completeAnimation()
                self.AmmoDivider:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.AmmoDivider:setAlpha( 1 )
                self.clipFinished( AmmoDivider, {} )

                LethalOffhand:completeAnimation()
                self.LethalOffhand:setAlpha( 1 )
                self.clipFinished( LethalOffhand, {} )

                LethalDivider:completeAnimation()
                self.LethalDivider:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.LethalDivider:setAlpha( 1 )
                self.clipFinished( LethalDivider, {} )

                TacticalOffhand:completeAnimation()
                self.TacticalOffhand:setAlpha( 1 )
                self.clipFinished( TacticalOffhand, {} )

                TacticalDivider:completeAnimation()
                self.TacticalDivider:setRGB( 0.9490196078431372, 0.9490196078431372, 0.9490196078431372 ) -- almost white
                self.TacticalDivider:setAlpha( 1 )
                self.clipFinished( TacticalDivider, {} )
                
                WeaponRarity:completeAnimation()
                self.WeaponRarity:setAlpha( 1 )
                self.clipFinished( WeaponRarity, {} )

                WeaponTier:completeAnimation()
                self.WeaponTier:setAlpha( 1 )
                self.clipFinished( WeaponTier, {} )

                WeaponAAT:completeAnimation()
                self.WeaponAAT:setAlpha( 1 )
                self.clipFinished( WeaponAAT, {} )

                YummyIcon:completeAnimation()
                self.YummyIcon:setAlpha( 1 )
                self.clipFinished( YummyIcon, {} )
                
                YummyTitle:completeAnimation()
                self.YummyTitle:setAlpha( 1 )
                self.clipFinished( YummyTitle, {} )

                YummyQuote:completeAnimation()
                self.YummyQuote:setRGB( 0.5843137255, 0.8196078431, 0.8274509804 )
                self.YummyQuote:setAlpha( 1 )
                self.clipFinished( YummyQuote, {} )
            end
        },
        Hidden = {
            DefaultClip = function()
                self:setupElementClipCounter( 14 )

                ClipAmmo:completeAnimation()
                self.ClipAmmo:setAlpha( 0 )
                self.clipFinished( ClipAmmo, {} )

                ClipAmmoDW:completeAnimation()
                self.ClipAmmoDW:setAlpha( 0 )
                self.clipFinished( ClipAmmoDW, {} )

                StockAmmo:completeAnimation()
                self.StockAmmo:setAlpha( 0 )
                self.clipFinished( StockAmmo, {})

                AmmoDivider:completeAnimation()
                self.AmmoDivider:setAlpha( 0 )
                self.clipFinished( AmmoDivider, {} )

                LethalOffhand:completeAnimation()
                self.LethalOffhand:setAlpha( 0 )
                self.clipFinished( LethalOffhand, {} )

                LethalDivider:completeAnimation()
                self.LethalDivider:setAlpha( 0 )
                self.clipFinished( LethalDivider, {} )

                TacticalOffhand:completeAnimation()
                self.TacticalOffhand:setAlpha( 0 )
                self.clipFinished( TacticalOffhand, {} )

                TacticalDivider:completeAnimation()
                self.TacticalDivider:setAlpha( 0 )
                self.clipFinished( TacticalDivider, {} )

                WeaponRarity:completeAnimation()
                self.WeaponRarity:setAlpha( 0 )
                self.clipFinished( WeaponRarity, {} )

                WeaponTier:completeAnimation()
                self.WeaponTier:setAlpha( 0 )
                self.clipFinished( WeaponTier, {} )

                WeaponAAT:completeAnimation()
                self.WeaponAAT:setAlpha( 0 )
                self.clipFinished( WeaponAAT, {} )
                
                YummyIcon:completeAnimation()
                self.YummyIcon:setAlpha( 0 )
                self.clipFinished( YummyIcon, {} )

                YummyTitle:completeAnimation()
                self.YummyTitle:setAlpha( 0 )
                self.clipFinished( YummyTitle, {} )

                YummyQuote:completeAnimation()
                self.YummyQuote:setAlpha( 0 )
                self.clipFinished( YummyQuote, {} )
            end
        },
        DualWield = {
            DefaultClip = function()
                self:setupElementClipCounter( 14 )

                ClipAmmo:completeAnimation()
                self.ClipAmmo:setAlpha( 1 )
                self.clipFinished( ClipAmmo, {} )

                ClipAmmoDW:completeAnimation()
                self.ClipAmmoDW:setAlpha( 1 )
                self.clipFinished( ClipAmmoDW, {} )

                StockAmmo:completeAnimation()
                self.StockAmmo:setAlpha( 1 )
                self.clipFinished( StockAmmo, {} )

                AmmoDivider:completeAnimation()
                self.AmmoDivider:setAlpha( 1 )
                self.clipFinished( AmmoDivider, {} )

                LethalOffhand:completeAnimation()
                self.LethalOffhand:setAlpha( 1 )
                self.clipFinished( LethalOffhand, {} )

                LethalDivider:completeAnimation()
                self.LethalDivider:setAlpha( 1 )
                self.clipFinished( LethalDivider, {} )

                TacticalOffhand:completeAnimation()
                self.TacticalOffhand:setAlpha( 1 )
                self.clipFinished( TacticalOffhand, {} )

                TacticalDivider:completeAnimation()
                self.TacticalDivider:setAlpha( 1 )
                self.clipFinished( TacticalDivider, {} )
                
                WeaponRarity:completeAnimation()
                self.WeaponRarity:setAlpha( 1 )
                self.clipFinished( WeaponRarity, {} )

                WeaponTier:completeAnimation()
                self.WeaponTier:setAlpha( 1 )
                self.clipFinished( WeaponTier, {} )

                WeaponAAT:completeAnimation()
                self.WeaponAAT:setAlpha( 1 )
                self.clipFinished( WeaponAAT, {} )

                YummyIcon:completeAnimation()
                self.YummyIcon:setAlpha( 1 )
                self.clipFinished( YummyIcon, {} )
                
                YummyTitle:completeAnimation()
                self.YummyTitle:setAlpha( 1 )
                self.clipFinished( YummyTitle, {} )

                YummyQuote:completeAnimation()
                self.YummyQuote:setAlpha( 1 )
                self.clipFinished( YummyQuote, {} )
            end
        }
    }

    self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function( menu, element, event )
				if not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
				and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) then
					return false
				else
					return true
				end
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

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.playerSpawned" )
    SubscribeToModelAndUpdateState( controller, menu, self, "currentWeapon.ammoInDWClip" )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE )
	SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )

    LUI.OverrideFunction_CallOriginalSecond( menu, "close", function( element )
        element.ClipAmmo:close()
        element.ClipAmmoDW:close()
        element.StockAmmo:close()
        element.AmmoDivider:close()
        element.LethalOffhand:close()
        element.LethalDivider:close()
        element.TacticalOffhand:close()
        element.TacticalDivider:close()
        element.WeaponRarity:close()
        element.WeaponTier:close()
        element.WeaponAAT:close()
        element.YummyIcon:close()
        element.YummyTitle:close()
        element.YummyQuote:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end

    return self
end