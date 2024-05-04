require( "ui.uieditor.widgets.HUD.ZM_Perks.PerkListItemFactory" )

local perksImages = {
    quick_revive 						= "rex_coldwar_ui_perk_quickrevive",
    doubletap2 							= "rex_coldwar_ui_perk_doubletap2",
    juggernaut 							= "rex_coldwar_ui_perk_juggernaut",
    sleight_of_hand 					= "rex_coldwar_ui_perk_speedcola",
    dead_shot 							= "rex_coldwar_ui_perk_deadshot",
    phdflopper 							= "rex_coldwar_ui_perk_phd",
    marathon 							= "rex_coldwar_ui_perk_staminup",
    additional_primary_weapon 			= "rex_coldwar_ui_perk_mulekick",
    tombstone 							= "rex_coldwar_ui_perk_tombstone",
    whoswho 							= "rex_coldwar_ui_perk_whoswho",
    electric_cherry 					= "rex_coldwar_ui_perk_electric_cherry",
    vultureaid 							= "rex_coldwar_ui_perk_vultureaid",
    widows_wine 						= "rex_coldwar_ui_perk_widowswine",
	elemental_pop                       = "rex_coldwar_ui_perk_elemental_pop"
}

local GetPerkFromList = function( perksList, perkCF )
	if perksList ~= nil then
		for index = 1, #perksList, 1 do
			if perksList[ index ].properties.key == perkCF then
				return index
			end
		end
	end

	return nil
end

local GetPerkFromStatus = function( perksList, perkCF, perkStatusModel )
	if perksList ~= nil then
		for index = 1, #perksList, 1 do
			if perksList[ index ].properties.key == perkCF and perksList[ index ].models.status ~= perkStatusModel then
				return index
			end
		end
	end

	return -1
end

local PerksListUpdate = function( element, controller )
	if not element.perksList then
		element.perksList = {}
	end

	local tableUpdated = false

	for perkCF, perkImage in pairs( perksImages ) do
		local perkModelValue = Engine.GetModelValue( Engine.GetModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks" ), perkCF ) )

		if perkModelValue ~= nil and perkModelValue > 0 then
			if not GetPerkFromList( element.perksList, perkCF ) then
				table.insert( element.perksList, {
					models = {
						image = perkImage,
						status = perkModelValue,
						newPerk = false
					},
					properties = {
						key = perkCF
					}
				})

				tableUpdated = true
			end

			if GetPerkFromStatus( element.perksList, perkCF, perkModelValue ) > 0 then
				element.perksList[ GetPerkFromStatus( element.perksList, perkCF, perkModelValue ) ].models.status = perkModelValue

				Engine.SetModelValue( Engine.GetModel( Engine.GetModel( Engine.GetModelForController( controller ), "ZMPerksFactory" ), tostring( GetPerkFromStatus( element.perksList, perkCF, perkModelValue ) ) .. ".status" ), perkModelValue )
			end
		else
			if GetPerkFromList( element.perksList, perkCF ) then
				table.remove( element.perksList, GetPerkFromList( element.perksList, perkCF ) )

				tableUpdated = true
			end
		end
	end

	if tableUpdated then
		for index = 1, #element.perksList, 1 do
			element.perksList[ index ].models.newPerk = index == #element.perksList
		end

		return true
	else
		for index = 1, #element.perksList, 1 do
			Engine.SetModelValue( Engine.GetModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks" ), element.perksList[ index ].properties.key ), element.perksList[ index ].models.status )
		end
	
		return false
	end
end

DataSources.ZMPerksFactory = DataSourceHelpers.ListSetup( "ZMPerksFactory", function( controller, element )
	PerksListUpdate( element, controller )
	return element.perksList
end, true )

local PreLoadFunc = function( self, controller )
	for perkCF, perkImage in pairs( perksImages ) do
		self:subscribeToModel( Engine.CreateModel( Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.perks" ), perkCF ), function ( modelRef )
			if PerksListUpdate( self.PerkList, controller ) then
				self.PerkList:updateDataSource()
			end
		end, false )
	end
end

CoD.CWPerksContainer = InheritFrom( LUI.UIElement )
CoD.CWPerksContainer.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.CWPerksContainer )
	self.id = "CWPerksContainer"
	self.soundSet = "default"
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 0, 0 )
	self.anyChildUsesUpdateState = true

	self.PerkList = LUI.UIList.new( menu, controller, 2, 0, nil, false, false, 0, 0, false, false )
	self.PerkList:makeFocusable()
	self.PerkList:setLeftRight( false, false, 0, 0 )
	self.PerkList:setTopBottom( true, false, 670, 706 )
	self.PerkList:setWidgetType( CoD.PerkListItemFactory )
	self.PerkList:setHorizontalCount( 10 )
	self.PerkList:setVerticalCount( 2 )
	self.PerkList:setDataSource( "ZMPerksFactory" )
	self:addElement( self.PerkList )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 1 )
				self.clipFinished( self.PerkList, {} )
			end,
			Hidden = function()
				self:setupElementClipCounter( 1 )

				local HiddenTransition = function( sender, event )
					if not event.interrupted then
						sender:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					sender:setAlpha( 0 )
	
					if event.interrupted then
						self.clipFinished( sender, event )
					else
						sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
	
				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 1 )
				HiddenTransition( self.PerkList, {} )
			end
		},
		Hidden = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 0 )
				self.clipFinished( self.PerkList, {} )
			end,
			DefaultState = function()
				self:setupElementClipCounter( 1 )

				local DefaultStateTransition = function ( sender, event )
					if not event.interrupted then
						sender:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					sender:setAlpha( 1 )
	
					if event.interrupted then
						self.clipFinished( sender, event )
					else
						sender:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 0 )
				DefaultStateTransition( self.PerkList, {} )
			end
		}
	}

	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
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
		}
	})

    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE )

	self.PerkList.id = "PerkList"

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.PerkList:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end
