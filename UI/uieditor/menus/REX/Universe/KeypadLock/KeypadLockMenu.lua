require( "ui.uieditor.menus.REX.CumUniverse.KeypadLock.KeypadLock_ListItem" )

local PreLoadFunc = function( self, controller )
    self.disableBlur = true
    self.disablePopupOpenCloseAnim = true
    self.disableDarkenElement = true
end

local PostLoadFunc = function( self, controller )
    Engine.LockInput( controller, true )
    Engine.SetUIActive( controller, true )

    self:setForceMouseEventDispatch( true )
end

DataSources.KeypadList = DataSourceHelpers.ListSetup( "KeypadList", function( controller )    
    local dataTable = {
        {
            models = { button = "1" }
        },
        {
            models = { button = "2" }
        },
        {
            models = { button = "3" }
        },
        {
            models = { button = "4" }
        },
        {
            models = { button = "5" }
        },
        {
            models = { button = "6" }
        },
        {
            models = { button = "7" }
        },
        {
            models = { button = "8" }
        },
        {
            models = { button = "9" }
        },
        {
            models = { button = "CLEAR" }
        },
        {
            models = { button = "0" }
        },
        {
            models = { button = "ENTER" }
        }
    }
    return dataTable
end, true)

LUI.createMenu.KeypadLockMenu = function( controller )

    local self = CoD.Menu.NewForUIEditor( "KeypadLockMenu" )
    
    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end
    
    self.soundSet = "HUD"
    self:setOwner( controller )
    self:setLeftRight( true, true, 0, 0 )
    self:setTopBottom( true, true, 0, 0 )
    self:playSound( "menu_open", controller )
    self.buttonModel = Engine.CreateModel( Engine.GetModelForController( controller ), "KeypadLockMenu.buttonPrompts" )
    self.anyChildUsesUpdateState = true

    local Background = LUI.UIImage.new()
    Background:setLeftRight( false, false, -125, 125 )
    Background:setTopBottom( false, false, -250, 250 )
    Background:setImage( RegisterImage( "rex_cu_keypad_lock_bg" ) )
    self:addElement( Background )
    self.Background = Background

    local EntryAction = LUI.UIImage.new()
    EntryAction:setLeftRight( false, false, -125, 125 )
    EntryAction:setTopBottom( false, false, -250, 250 )
    EntryAction:setImage( RegisterImage( "blacktransparent" ) )
    EntryAction:subscribeToGlobalModel( controller, "PerController", "scriptNotify", function( ModelRef )
		if IsParamModelEqualToString( ModelRef, "KeypadEntryAction" ) then
            local val = CoD.GetScriptNotifyData( ModelRef )
            
            if val then
                self:setupElementClipCounter( 1 )
                
                if val[ 1 ] == 0 then
                    local function IncorrectActionStage1( element, event )
                        local function IncorrectActionStage2( element, event )
                            local function IncorrectActionStage3( element, event )
                                if not event.interrupted then
                                    element:setAlpha( 1 )
                                    element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
                                end
                                
                                element:setAlpha( 0 )
                                    
                                if event.interrupted then
                                    self.clipFinished( element, event )
                                else
                                    element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                                end
                            end
    
                            if event.interrupted then
                                return IncorrectActionStage3( element, event )
                            end
                            
                            element:setAlpha( 1 )
                            element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
                            element:setAlpha( 0 )
                            element:registerEventHandler( "transition_complete_keyframe", IncorrectActionStage3 )
                        end
    
                        if event.interrupted then
                            return IncorrectActionStage2( element, event )
                        end
                        
                        element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
                        element:setAlpha( 0 )
                        element:registerEventHandler( "transition_complete_keyframe", IncorrectActionStage2 )
                    end
    
                    EntryAction:completeAnimation()
                    EntryAction:setImage( RegisterImage( "rex_cu_keypad_lock_overlay_incorrect" ) )
                    EntryAction:setAlpha( 1 )
                    IncorrectActionStage1( EntryAction, {} )
                else
                    local function CorrectActionStage1( element, event )
                        local function CorrectActionStage2( element, event )
                            if not event.interrupted then
                                element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
                            end
                            
                            element:setAlpha( 0 )
                                
                            if event.interrupted then
                                self.clipFinished( element, event )
                            else
                                element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
                            end
                        end

                        if event.interrupted then
                            return CorrectActionStage2( element, event )
                        end
                        
                        element:beginAnimation( "keyframe", 350, false, false, CoD.TweenType.Linear )
                        element:registerEventHandler( "transition_complete_keyframe", CorrectActionStage2 )
                    end
                    
                    EntryAction:completeAnimation()
                    EntryAction:setImage( RegisterImage( "rex_cu_keypad_lock_overlay_correct" ) )
                    EntryAction:setAlpha( 1 )
                    CorrectActionStage1( EntryAction, {} )
                end
            end
        end
    end)
    self:addElement( EntryAction )
    self.EntryAction = EntryAction

    local KeypadEntry = CoD.TextWithBg.new()
    KeypadEntry:setLeftRight( false, false, 0, 0 )
    KeypadEntry.Bg:setLeftRight( false, false, -100, 100 )
	KeypadEntry.Bg:setTopBottom( true, false, 150, 215 )
    KeypadEntry.Bg:setRGB( 0.3, 0.35, 0.3 )
	KeypadEntry.Text:setLeftRight( false, false, -90, 100 )
	KeypadEntry.Text:setTopBottom( true, false, 150, 215 )
    KeypadEntry.Text:setText( "" )
    KeypadEntry.Text:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    KeypadEntry.Text:setTTF( "fonts/Digital7.ttf" )
    KeypadEntry.Text:setRGB( 0.1, 0.1, 0.1 )
    KeypadEntry.Text:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.KeypadEntry" ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )
                
        if val then
            KeypadEntry.Text:setText( Engine.Localize( val ) )
        end
    end)
    self:addElement( KeypadEntry )
    self.KeypadEntry = KeypadEntry

    local KeypadList = LUI.UIList.new( self, controller, 3, 0, nil, false, false, 0, 0, false, false )
    KeypadList:setLeftRight( false, false, 0, 0 )
    KeypadList:setTopBottom( true, false, 255, 255 )
    KeypadList:setWidgetType( CoD.KeypadLock_ListItem )
    KeypadList:setDataSource( "KeypadList" )
    KeypadList:setHorizontalCount( 3 )
    KeypadList:setVerticalCount( 4 )
    KeypadList:makeFocusable()
    KeypadList.id = "KeypadList"
    self:addElement( KeypadList )
    self.KeypadList = KeypadList 

    self:AddButtonCallbackFunction( self.KeypadList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( ItemRef, self, controller, Button )        
        Engine.PlaySound( "list_right" )
        
        local button = Engine.GetModelValue( Engine.GetModel( ItemRef:getModel(), "button" ) )

        Engine.SendMenuResponse( controller, "KeypadLockMenu", ( button or "" ) )

        return true
    end, function( ItemRef, self, controller )
        return true
    end, true)

    self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "ESCAPE", function( ItemRef, self, controller, Button )
        self:close()
        Engine.SendMenuResponse( controller, "KeypadLockMenu", "close" )

        return true
    end, function( ItemRef, self, controller )
        return true
    end, true)

    self:registerEventHandler( "menu_loaded", function( element, event )
        return element:dispatchEventToChildren( element )
    end)

    self:processEvent({
        name = "menu_loaded",
        controller = controller 
    })

    self:processEvent({ 
        name = "update_state",
        menu = self
    })

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.Background:close()
        element.EntryAction:close()
        element.KeypadEntry:close()
        element.KeypadList:close()
        Engine.UnsubscribeAndFreeModel( Engine.GetModel( Engine.GetModelForController( controller ), "KeypadLockMenu.buttonPrompts" ) )
    end)
    
    if PostLoadFunc then
        PostLoadFunc( self, controller )
    end

    return self
end