CoD.KeypadLock_ListItem = InheritFrom( LUI.UIElement )

CoD.KeypadLock_ListItem.new = function( menu, controller )

    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( menu, controller )
    end

    self:setClass( CoD.KeypadLock_ListItem )
    self.id = "KeypadLock_ListItem"
    self.soundSet = "default"
    self:setLeftRight( true, false, 0, 55 )
    self:setTopBottom( true, false, 0, 55 )
    self.anyChildUsesUpdateState = true
    self:setHandleMouse( true )
    self:makeFocusable()

    local ButtonText = LUI.UIText.new()
    ButtonText:setLeftRight( true, true, 0, 0 )
    ButtonText:setTopBottom( true, true, 0, 0 )
    ButtonText:setTTF( "fonts/Digital7.ttf" )
    ButtonText:setRGB( 1, 1, 1 )
    ButtonText:linkToElementModel( self, "button", true, function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )

        if val then
            if val == "CLEAR" or val == "ENTER" then
                ButtonText:setScale( 0.35 )
            end
            ButtonText:setText( Engine.Localize( val ) )
        end
    end)
    self:addElement( ButtonText )
    self.ButtonText = ButtonText
    
    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 0.25 )
                self.clipFinished( ButtonText, {} )
            end,
            GainFocus = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            LoseFocus = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 0.25 )
                self.clipFinished( ButtonText, {} )
            end,
            Focus = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end
        },
        GainFocus = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            GainFocus = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            Focus = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end
        },
        Focus = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            LoseFocus = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 0.25 )
                self.clipFinished( ButtonText, {} )
            end
        },
        LoseFocus = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 1 )
                self.clipFinished( ButtonText, {} )
            end,
            DefaultState = function()
                self:setupElementClipCounter( 1 )
            
                ButtonText:completeAnimation()
                self.ButtonText:setAlpha( 0.25 )
                self.clipFinished( ButtonText, {} )
            end
        }
    }

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.ButtonText:close()
    end)

    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end

    return self
end