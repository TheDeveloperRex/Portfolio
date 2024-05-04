require( "ui.utility.CoreUtil" )

CoD.CWSelfScoreboard = InheritFrom( LUI.UIElement )

CoD.CWSelfScoreboard.new = function ( menu, controller )

    local self = LUI.UIElement.new( menu, controller )
    
    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setUseStencil( false )
    self:setClass( CoD.CWSelfScoreboard )
    self.id = "CWSelfScoreboard"
    self.soundSet = "default"
    self:setLeftRight( true, false, 0, 1280 )
    self:setTopBottom( true, false, 0, 720 )
    self.anyChildUsesUpdateState = true

    local current_rank = GetPlayerRank( self, controller )

    local Score = LUI.UIText.new()
    Score:setLeftRight( true, false, 567, 1280 )
    Score:setTopBottom( true, false, 450.5, 473.5 )
    Score:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    Score:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    Score:linkToElementModel( self, "playerScore", true, function( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            Score:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
        end
    end)
    self:addElement( Score )
    self.Score = Score

    local CommonScrap = LUI.UIText.new()
    CommonScrap:setLeftRight( true, false, 786.5, 1280 )
    CommonScrap:setTopBottom( true, false, 450.5, 473.5 )
    CommonScrap:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    CommonScrap:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    CommonScrap:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.CommonScrap" ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )

        if val then
            CommonScrap:setText( Engine.Localize( val ) )
        end
    end)
    self:addElement( CommonScrap )
    self.CommonScrap = CommonScrap

    local RareScrap = LUI.UIText.new()
    RareScrap:setLeftRight( true, false, 1007.5, 1280 )
    RareScrap:setTopBottom( true, false, 450.5, 473.5 )
    RareScrap:setTTF("fonts/MaximaTOTBold-Regular.ttf")
    RareScrap:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
    RareScrap:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.RareScrap" ), function( ModelRef )
        local val = Engine.GetModelValue( ModelRef )
        
        if val then            
            RareScrap:setText( Engine.Localize( val ) )
        end
    end)
    self:addElement( RareScrap )
    self.RareScrap = RareScrap

    local Rank = LUI.UIText.new()
    Rank:setLeftRight( true, false, 413.5, 459.5 )
    Rank:setTopBottom( true, false, 473, 485 )
    Rank:setTTF( "fonts/MaximaTOTBold-Regular.ttf" )
    Rank:setText( "0" )
    Rank:setRGB( 1, 0.40784313725490196, 0 )
    Rank:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    Rank:setRGB( 1, ( ( current_rank > 55 ) and 0.40784313725490196 or 1 ), ( ( current_rank > 55 ) and 0 or 1 ) )
    Rank:setText( Engine.Localize( current_rank ) )
    self:addElement( Rank ) 
    self.Rank = Rank

    local RankIcon = LUI.UIImage.new()
    RankIcon:setLeftRight( true, false, 418.5, 454.5 )
    RankIcon:setTopBottom( true, false, 438.5, 474.5 )
    RankIcon:setImage( RegisterImage( Engine.TableLookupGetColumnValueForRow( "gamedata/tables/mp/mp_paragonrankicontable.csv", 11, 2 ) ) )
    self:addElement( RankIcon )
    self.RankIcon = RankIcon

    local CallingCard = LUI.UIImage.new()
    CallingCard:setLeftRight( true, false, 196, 408 )
    CallingCard:setTopBottom( true, false, 441.5, 484 )
    CallingCard:setImage( RegisterMaterial( "rex_coldwar_ui_scoreboard_callingcard" ) )
    self:addElement( CallingCard )
    self.CallingCard = CallingCard

    local Emblem = LUI.UIImage.new()
    Emblem:setLeftRight( true, false, 150.75, 193.25 )
    Emblem:setTopBottom( true, false, 441.5, 484 )
    Emblem:setImage( RegisterImage( "rex_coldwar_ui_scoreboard_emblem" ) )
    self:addElement( Emblem )
    self.Emblem = Emblem

    self:subscribeToGlobalModel( controller, "PerController", "scriptNotify", function( ModelRef )
		if IsParamModelEqualToString( ModelRef, "RankPopup" ) then
            local rankTable = "gamedata/tables/mp/cu_ranktable.csv"
			local val = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.ProgressionData" ) ) --prestige,xp,level,title,icon

            if val then
                local strToks = LUI.splitString( val, "," )

                if #strToks > 0 then
                    self.Rank:setRGB( 1, ( ( tonumber( strToks[ 3 ] ) > 55 ) and 0.40784313725490196 or 1 ), ( ( tonumber( strToks[ 3 ] ) > 55 ) and 0 or 1 ) )
                    self.Rank:setText( Engine.Localize( strToks[ 3 ] ) )
                end
            end
		end
	end)

    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.CommonScrap" )
    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.RareScrap" )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.Score:close()
        element.CommonScrap:close()
        element.RareScrap:close()
        element.Rank:close()
        element.RankIcon:close()
        element.CallingCard:close()
        element.Emblem:close()
	end)

    if PostLoadFunc then
        PostLoadFunc( self, controller, menu )
    end
  
    return self
end