local QBCore = exports['qb-core']:GetCoreObject()

-- Print resource start message
Citizen.CreateThread(function()
    local resourceName = "^2 X-Ample Development Started ("..GetCurrentResourceName()..")"
    print("\n^1----------------------------------------------------------------------------------^7")
    print(resourceName)
    print("^1----------------------------------------------------------------------------------^7")
end)

Citizen.CreateThread(function()
    while true do
        -- Retrieve player data
        local playerData = QBCore.Functions.GetPlayerData()  -- Adjust if necessary based on your QBCore version or methods
        local PlayerName = GetPlayerName(PlayerId())
        local charName = playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname
        local id = GetPlayerServerId(PlayerId())
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        -- Get the street name and crossing
        local streetHash, crossingHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local streetName = GetStreetNameFromHashKey(streetHash)
        local crossingName = crossingHash and GetStreetNameFromHashKey(crossingHash) or ""
        local location = crossingName ~= "" and (streetName .. " and " .. crossingName) or streetName

        -- Determine player status
        local status
        if IsPedInAnyVehicle(ped, false) then
            status = "Driving"
        else
            local velocity = GetEntityVelocity(ped)
            local speed = math.sqrt(velocity.x^2 + velocity.y^2 + velocity.z^2)
            if speed > 0.1 then
                status = "Walking on"
            else
                status = "Standing on"
            end
        end

        -- Update Discord Rich Presence
        SetDiscordAppId(1264119260213673984)
        SetRichPresence(string.format("%s - ID: %d\n%s %s", charName, id, status, location))

        -- Set large icon and hover text
        SetDiscordRichPresenceAsset('amari_rp')
        SetDiscordRichPresenceAssetText('Amari Roleplay')

        -- Set buttons for Discord Rich Presence
        SetDiscordRichPresenceAction(0, "Fly In", "fivem://connect/cfx.re/join/3o49jr")
        SetDiscordRichPresenceAction(1, "Discord", "https://discord.gg/fxdBZAjTVC")

        -- Wait 60 seconds before updating again
        Citizen.Wait(60000)
    end
end)
