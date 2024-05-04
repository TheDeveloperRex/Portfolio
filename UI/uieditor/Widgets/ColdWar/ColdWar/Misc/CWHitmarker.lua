require( "ui.utility.CoreUtil" )

local PreLoadFunc = function( menu, controller )
	local HitmarkerState = Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.Hitmarker" )
	Engine.SetModelValue( HitmarkerState, 0 )
end

CoD.CWHitmarker = InheritFrom( LUI.UIElement )

function CoD.CWHitmarker.new( menu, controller )

	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setClass( CoD.CWHitmarker )
	self.id = "CWHitmarker"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
    self:setLeftRight( false, false, 0, 0 )
    self:setTopBottom( false, false, 0, 0 )

	local TopLeft = LUI.UIImage.new()
	self:addElement( TopLeft )
	self.TopLeft = TopLeft

	local TopRight = LUI.UIImage.new()
	self:addElement( TopRight )
	self.TopRight = TopRight

	local BottomLeft = LUI.UIImage.new()
	self:addElement( BottomLeft )
	self.BottomLeft = BottomLeft

	local BottomRight = LUI.UIImage.new()
	self:addElement( BottomRight )
	self.BottomRight = BottomRight

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )
		
				TopLeft:completeAnimation()
				self.TopLeft:setAlpha( 0 )
				self.clipFinished( TopLeft, {} )
		
				TopRight:completeAnimation()
				self.TopRight:setAlpha( 0 )
				self.clipFinished( TopRight, {} )
		
				BottomLeft:completeAnimation()
				self.BottomLeft:setAlpha( 0 )
				self.clipFinished( BottomLeft, {} )
		
				BottomRight:completeAnimation()
				self.BottomRight:setAlpha( 0 )
				self.clipFinished( BottomRight, {} )
			end
		},
		DamageState = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

				local function TopLeftStage1( element, event )
					local function TopLeftStage2( element, event )
						local function TopLeftStage3( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
							end

							element:setLeftRight( false, false, -32, -56 )
							element:setTopBottom( false, false, -56, -32 )
							element:setAlpha( 0 )

							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
		
						if event.interrupted then
							return TopLeftStage3( element, event )
						end

						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", TopLeftStage3 )
					end
		
					if event.interrupted then
						return TopLeftStage2( element, event )
					end

					element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
					element:setLeftRight( false, false, -12, -36 )
					element:setTopBottom( false, false, -36, -12 )
					element:registerEventHandler( "transition_complete_keyframe", TopLeftStage2 )
				end
		
				TopLeft:completeAnimation()
				self.TopLeft:setImage( RegisterImage( "rex_coldwar_ui_hitmarker" ) )
				self.TopLeft:setLeftRight( false, false, -32, -56 )
				self.TopLeft:setTopBottom( false, false, -56, -32 )
				self.TopLeft:setAlpha( 1 )
				TopLeftStage1( TopLeft, {} )

				local function TopRightStage1( element, event )
					local function TopRightStage2( element, event )
						local function TopRightStage3( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
							end

							element:setLeftRight( false, false, 32, 56 )
							element:setTopBottom( false, false, -56, -32 )
							element:setAlpha( 0 )

							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
		
						if event.interrupted then
							return TopRightStage3( element, event )
						end

						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", TopRightStage3 )
					end
		
					if event.interrupted then
						return TopRightStage2( element, event )
					end

					element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
					element:setLeftRight( false, false, 12, 36 )
					element:setTopBottom( false, false, -36, -12 )
					element:registerEventHandler( "transition_complete_keyframe", TopRightStage2 )
				end
		
				TopRight:completeAnimation()
				self.TopRight:setImage( RegisterImage( "rex_coldwar_ui_hitmarker" ) )
				self.TopRight:setLeftRight( false, false, 32, 56 )
				self.TopRight:setTopBottom( false, false, -56, -32 )
				self.TopRight:setAlpha( 1 )
				TopRightStage1( TopRight, {} )

				local function BottomLeftStage1( element, event )
					local function BottomLeftStage2( element, event )
						local function BottomLeftStage3( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
							end

							element:setLeftRight( false, false, -32, -56 )
							element:setTopBottom( false, false, 56, 32 )
							element:setAlpha( 0 )

							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
		
						if event.interrupted then
							return BottomLeftStage3( element, event )
						end

						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", BottomLeftStage3 )
					end
		
					if event.interrupted then
						return BottomLeftStage2( element, event )
					end

					element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
					element:setLeftRight( false, false, -12, -36 )
					element:setTopBottom( false, false, 36, 12 )
					element:registerEventHandler( "transition_complete_keyframe", BottomLeftStage2 )
				end
		
				BottomLeft:completeAnimation()
				self.BottomLeft:setImage( RegisterImage( "rex_coldwar_ui_hitmarker" ) )
				self.BottomLeft:setLeftRight( false, false, -32, -56 )
				self.BottomLeft:setTopBottom( false, false, 56, 32 )
				self.BottomLeft:setAlpha( 1 )
				BottomLeftStage1( BottomLeft, {} )

				local function BottomRightStage1( element, event )
					local function BottomRightStage2( element, event )
						local function BottomRightStage3( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
							end

							element:setLeftRight( false, false, 32, 56 )
							element:setTopBottom( false, false, 56, 32 )
							element:setAlpha( 0 )

							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
		
						if event.interrupted then
							return BottomRightStage3( element, event )
						end
						element:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
						element:registerEventHandler("transition_complete_keyframe", BottomRightStage3 )
					end
		
					if event.interrupted then
						return BottomRightStage2( element, event )
					end
					element:beginAnimation("keyframe", 75, false, false, CoD.TweenType.Linear)
					element:setLeftRight( false, false, 12, 36 )
					element:setTopBottom( false, false, 36, 12 )
					element:registerEventHandler( "transition_complete_keyframe", BottomRightStage2 )
				end
		
				BottomRight:completeAnimation()
				self.BottomRight:setImage( RegisterImage( "rex_coldwar_ui_hitmarker" ) )
				self.BottomRight:setLeftRight( false, false, 32, 56 )
				self.BottomRight:setTopBottom( false, false, 56, 32 )
				self.BottomRight:setAlpha( 1 )
				BottomRightStage1( BottomRight, {} )
			end
		},
		DeathState = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

				local function TopLeftStage1( element, event )
					local function TopLeftStage2( element, event )
						local function TopLeftStage3( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
							end

							element:setLeftRight( false, false, -32, -56 )
							element:setTopBottom( false, false, -56, -32 )
							element:setAlpha( 0 )

							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
		
						if event.interrupted then
							return TopLeftStage3( element, event )
						end

						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", TopLeftStage3 )
					end
		
					if event.interrupted then
						return TopLeftStage2( element, event )
					end

					element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
					element:setLeftRight( false, false, -12, -36 )
					element:setTopBottom( false, false, -36, -12 )
					element:registerEventHandler( "transition_complete_keyframe", TopLeftStage2 )
				end

				TopLeft:completeAnimation()
				self.TopLeft:setImage( RegisterImage( "rex_coldwar_ui_hitmarker_death" ) )
				self.TopLeft:setLeftRight( false, false, -32, -56 )
				self.TopLeft:setTopBottom( false, false, -56, -32 )
				self.TopLeft:setAlpha( 1 )
				TopLeftStage1( TopLeft, {} )

				local function TopRightStage1( element, event )
					local function TopRightStage2( element, event )
						local function TopRightStage3( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
							end

							element:setLeftRight( false, false, 32, 56 )
							element:setTopBottom( false, false, -56, -32 )
							element:setAlpha( 0 )

							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
		
						if event.interrupted then
							return TopRightStage3( element, event )
						end

						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", TopRightStage3 )
					end
		
					if event.interrupted then
						return TopRightStage2( element, event )
					end

					element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
					element:setLeftRight( false, false, 12, 36 )
					element:setTopBottom( false, false, -36, -12 )
					element:registerEventHandler( "transition_complete_keyframe", TopRightStage2 )
				end
		
				TopRight:completeAnimation()
				self.TopRight:setImage( RegisterImage( "rex_coldwar_ui_hitmarker_death" ) )
				self.TopRight:setLeftRight( false, false, 32, 56 )
				self.TopRight:setTopBottom( false, false, -56, -32 )
				self.TopRight:setAlpha( 1 )
				TopRightStage1( TopRight, {} )

				local function BottomLeftStage1( element, event )
					local function BottomLeftStage2( element, event )
						local function BottomLeftStage3( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
							end

							element:setAlpha( 0 )
							element:setLeftRight( false, false, -32, -56 )
							element:setTopBottom( false, false, 56, 32 )

							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							return BottomLeftStage3( element, event )
						end

						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", BottomLeftStage3 )
					end

					if event.interrupted then
						return BottomLeftStage2( element, event )
					end

					element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
					element:setLeftRight(false, false, -12, -36 )
					element:setTopBottom(false, false, 36, 12 )
					element:registerEventHandler( "transition_complete_keyframe", BottomLeftStage2 )
				end

				self.BottomLeft:completeAnimation()
				self.BottomLeft:setImage( RegisterImage( "rex_coldwar_ui_hitmarker_death" ) )
				self.BottomLeft:setLeftRight( false, false, -32, -56 )
				self.BottomLeft:setTopBottom( false, false, 56, 32 )
				self.BottomLeft:setAlpha( 1 )
				BottomLeftStage1( self.BottomLeft, {} )

				local function BottomRightStage1( element, event )
					local function BottomRightStage2( element, event )
						local function BottomRightStage3( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
							end

							element:setLeftRight( false, false, 32, 56 )
							element:setTopBottom( false, false, 56, 32 )
                            element:setAlpha( 0 )

							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
		
						if event.interrupted then
							return BottomRightStage3( element, event )
						end

						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", BottomRightStage3 )
					end
		
					if event.interrupted then
						return BottomRightStage2( element, event )
					end

					element:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear )
					element:setLeftRight( false, false, 12, 36 )
					element:setTopBottom( false, false, 36, 12 )
					element:registerEventHandler( "transition_complete_keyframe", BottomRightStage2 )
				end
		
				BottomRight:completeAnimation()
				self.BottomRight:setImage( RegisterImage( "rex_coldwar_ui_hitmarker_death" ) )
				self.BottomRight:setLeftRight( false, false, 32, 56 )
				self.BottomRight:setTopBottom( false, false, 56, 32 )
				self.BottomRight:setAlpha( 1 )
				BottomRightStage1( BottomRight, {} )
			end
		}
	}

	self:mergeStateConditions({
		{
			stateName = "DefaultState",
			condition = function( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.Hitmarker", 0 )
			end
		},
		{
			stateName = "DamageState",
			condition = function( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.Hitmarker", 1 )
			end
		},
		{
			stateName = "DeathState",
			condition = function( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.Hitmarker", 2 )
			end
		}
	})

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.Hitmarker" )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.TopLeft:close()
		element.TopRight:close()
		element.BottomLeft:close()
		element.BottomRight:close()
	end)

	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end

	return self
end

