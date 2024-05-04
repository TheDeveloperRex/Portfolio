CoD.MusicSelector_ListItem = InheritFrom( LUI.UIElement )

CoD.MusicSelector_ListItem.new = function( menu, controller )

    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( menu, controller )
    end

    self:setClass( CoD.MusicSelector_ListItem )
    self.id = "MusicSelector_ListItem"
    self.soundSet = "default"
    self:setLeftRight( true, false, 0, 144 )
    self:setTopBottom( true, false, 0, 38 )
    self.anyChildUsesUpdateState = true
    self:setHandleMouse( true )
    self:makeFocusable()

    local ButtonBG = LUI.UIImage.new()
    ButtonBG:setLeftRight( true, true, 0, 0 )
    ButtonBG:setTopBottom( true, true, 0, 0 )
    ButtonBG:setImage( RegisterImage( "rex_cu_mode_selector_button_bg" ) )
    self:addElement( ButtonBG )
    self.ButtonBG = ButtonBG

    local ButtonText = LUI.UIText.new()
    ButtonText:setLeftRight( true, true, 0, 0 )
    ButtonText:setTopBottom( true, true, 0, 0 )
    ButtonText:setRGB( 0.1, 0.1, 0.1 )
    ButtonText:linkToElementModel( self, "title", true, function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )

        if val then
            ButtonText:setText( Engine.Localize( val ) )
        end
    end)
    self:addElement( ButtonText )
    self.ButtonText = ButtonText
    
    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 0.25 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 0.25 )
                self.clipFinished( ButtonText, {} )
            end,
            GainFocus = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 1 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            LoseFocus = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 0.25 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 0.25 )
                self.clipFinished( ButtonText, {} )
            end,
            Focus = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 1 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end
        },
        GainFocus = {
            DefaultClip = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 1 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            GainFocus = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 1 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            Focus = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 1 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end
        },
        Focus = {
            DefaultClip = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 1 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            LoseFocus = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 0.25 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 0.25 )
                self.clipFinished( ButtonText, {} )
            end
        },
        LoseFocus = {
            DefaultClip = function()
                self:setupElementClipCounter( 2 )
  
                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 1 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            DefaultState = function()
                self:setupElementClipCounter( 2 )

                ButtonBG:completeAnimation()
                self.ButtonBG:setAlpha( 0.25 )
                self.clipFinished( ButtonBG, {} )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 0.25 )
                self.clipFinished( ButtonText, {} )
            end
        }
    }

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.ButtonBG:close()
        element.ButtonText:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end

    return self
end