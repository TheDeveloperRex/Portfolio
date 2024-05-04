local json = require( "ui.utility.json" )
local math = require( "math" )
local io = require( "io" )

local ProgressionDataTable = {};

EnableGlobals()

function UpdateFileData( self, controller, do_prestige )
    local data = nil

    if not FileExists( "players\\cumuniverse-data.json" ) then
        data = io.open( "players\\cumuniverse-data.json", "w" )
        ProgressionDataTable[ Engine.GetXUID( controller ) ] = GetDefaultData()
    else
        local val = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.ProgressionData" ) )
        local strToks = LUI.splitString( val, "|" )
        local levelData = LUI.splitString( strToks[ 1 ], "," )
        local weaponData = LUI.splitString( strToks[ 2 ], "," )

        data = io.open( "players\\cumuniverse-data.json", "w" )
        
        local defaultData = GetDefaultData()
        local userData = ProgressionDataTable[ Engine.GetXUID( controller ) ]

        for k, v in pairs( defaultData ) do
            if not TableContains( userData, k ) then
                userData[ k ] = v
            else
                if type( v ) == "table" then
                    for k2, v2 in pairs( v ) do
                        if not TableContains( userData[ k ], k2 ) then
                            userData[ k ][ k2 ] = v2
                        end
                    end
                end
            end
        end

        userData.Prestige = tonumber( levelData[ 1 ] )
        userData.XP = tonumber( levelData[ 2 ] )

        if do_prestige == 1 then
            if CanPrestige( controller ) then
                userData.Prestige = ( userData.Prestige + 1 )
                userData.XP = 0
                userData.KillstreakTokens = defaultData.KillstreakTokens
                userData.UnlockedKillstreaks = defaultData.UnlockedKillstreaks
            end
        else
            if TableContains( userData.WeaponStats, weaponData[ 1 ] ) then
                userData.WeaponStats[ weaponData[ 1 ] ] = {
                    Kills = ( userData.WeaponStats[ weaponData[ 1 ] ].Kills + tonumber( weaponData[ 2 ] ) ),
                    Headshots = ( userData.WeaponStats[ weaponData[ 1 ] ].Headshots + tonumber( weaponData[ 3 ] ) )
                }
            end
        end

        ProgressionDataTable[ Engine.GetXUID( controller ) ] = userData
    end

    for k, v in pairs( ProgressionDataTable[ Engine.GetXUID( controller ) ] ) do
        if not ProgressionModel[ Engine.GetXUID( controller ) ] then
            ProgressionModel[ Engine.GetXUID( controller ) ] = {}
        end

        if type( ProgressionDataTable[ Engine.GetXUID( controller ) ][ k ] ) ~= "table" then
            if not TableContains( ProgressionModel[ Engine.GetXUID( controller ) ], k ) then
                local model = Engine.GetModel( Engine.GetModelForController( controller ), string.format( "hudItems.%s", k ) )
                
                if not model then
                    model = Engine.CreateModel( Engine.GetModelForController( controller ), string.format( "hudItems.%s", k ) )
                end

                --self:SubscribeToProgressionModel( string.format( "hudItems.%s", k ) )
            end

            IPrintLnBold( Engine.GetModelValue( ProgressionModel[ Engine.GetXUID( controller ) ].XP ) )

            ProgressionModel[ Engine.GetXUID( controller ) ][ k ] = model
            Engine.SetModelValue( ProgressionModel[ Engine.GetXUID( controller ) ][ k ], tonumber( v ) )
            Engine.ForceNotifyModelSubscriptions( ProgressionModel[ Engine.GetXUID( controller ) ][ k ] )
        end
    end

    data:write( json.encode( ProgressionDataTable[ Engine.GetXUID( controller ) ] ) )
    data:close()
end

function RetrieveFileData( self, controller )
    if not FileExists( "players\\cumuniverse-data.json" ) then
        UpdateFileData( self, controller, false )
    end
    
    local data = io.open( "players\\cumuniverse-data.json", "r" )
    
    if data then
        ProgressionDataTable[ Engine.GetXUID( controller ) ] = json.decode( data:read() )
        data:close()
        
        local val = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.ProgressionData" ) )
        local strToks = LUI.splitString( val, "|" )

        if #strToks > 0 then
            local weaponData = LUI.splitString( strToks[ 2 ], "," )

            local userData = ProgressionDataTable[ Engine.GetXUID( controller ) ]

            local dataStr = string.format( "%s,%s|%s,%s,%s",
                userData.Prestige, 
                userData.XP,
                ( ( TableContains( userData.WeaponStats, weaponData[ 1 ] ) ) and weaponData[ 1 ] or "none" ),
                ( ( TableContains( userData.WeaponStats, weaponData[ 1 ] ) ) and userData.WeaponStats[ weaponData[ 1 ] ].Kills or 0 ),
                ( ( TableContains( userData.WeaponStats, weaponData[ 1 ] ) ) and userData.WeaponStats[ weaponData[ 1 ] ].Headshots or 0 )
            )
            return dataStr
        end
    end
end

function GetPlayerRank( self, controller )
    if not ProgressionDataTable[ Engine.GetXUID( controller ) ] then
        RetrieveFileData( self, controller )
    end

    local userData = ProgressionDataTable[ Engine.GetXUID( controller ) ]
    local rankTable = "gamedata/tables/mp/cu_ranktable.csv"

    local current_level = 1
    local prestige_level = 0

    for i = 3, 57, 1 do
        local minXp = tonumber( Engine.TableLookupGetColumnValueForRow( rankTable, i, 2 ) )
        local maxXp = tonumber( Engine.TableLookupGetColumnValueForRow( rankTable, i, 7 ) )

        if userData.XP >= minXp and userData.XP <= maxXp then
            current_level = ( tonumber( Engine.TableLookupGetColumnValueForRow( rankTable, i, 0 ) ) + 1 )
        end
    end

    if userData.Prestige == 10 and userData.XP >= 1454000 then
        prestige_level = math.floor( ( userData.XP - 1454000 ) / 12500 )
        current_level = ( ( 55 + prestige_level ) <= 1000 and ( 55 + prestige_level ) or 1000 )
    end

    return current_level
end

function CanPrestige( controller )
    local userData = ProgressionDataTable[ Engine.GetXUID( controller ) ]
    if not userData then
        return false
    end

    if userData.Prestige >= 10 or userData.XP < 1454000 then
        return false
    end

    return true
end

function GetDefaultData()
	local data = {
        Version = 0.1,
		XP = 0,
		Prestige = 0,
		PrestigeTokens = 0,
		KillstreakTokens = 3, 
		UnlockedKillstreaks = { 199, 204, 207 },
        WeaponStats = {}
	}
    local weaponTable = "gamedata/weapons/cu_weapontable.csv"

    for i = 1, 32, 1 do
        local weapon = Engine.TableLookupGetColumnValueForRow( weaponTable, i, 0 )

        data.WeaponStats[ weapon ] = {
            Kills = 0,
            Headshots = 0
        }
    end

	return data
end

function FileExists( path )
	local data = io.open( path, "r" )

	if data ~= nil then
		data:close()
		return true
	else
		return false
	end
end

function TableContains( table, key )
    if table[ key ] ~= nil then
        return true
    end

    return false
end

DisableGlobals()
