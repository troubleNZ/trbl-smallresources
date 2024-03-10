-- Transfer vehicle to player in passenger seat

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('fw-vehicleshop:server:transferVehicle', function(plate, buyerId, amount)
    local src = source
    local plate = plate
    local buyerId = tonumber(buyerId)
    local sellAmount = tonumber(amount)
    local ped = GetPlayerPed(src)
    local player = QBCore.Functions.GetPlayer(src)
    local target = QBCore.Functions.GetPlayer(buyerId)
    local citizenid = player.PlayerData.citizenid
    if target ~= nil then
        if sellAmount then
            if target.Functions.GetMoney('cash') > sellAmount then
                local targetcid = target.PlayerData.citizenid
                MySQL.Async.execute('UPDATE player_vehicles SET citizenid = ? WHERE plate = ?', {targetcid, plate})
                player.Functions.AddMoney('cash', sellAmount)
                TriggerClientEvent('QBCore:Notify', src, 'You sold your vehicle for $'..comma_value(sellAmount), 'success')
                target.Functions.RemoveMoney('cash', sellAmount)
                TriggerClientEvent('vehiclekeys:client:SetOwner', target.PlayerData.source, plate)
                TriggerClientEvent('QBCore:Notify', target.PlayerData.source, 'You bought a vehicle for $'..comma_value(sellAmount), 'success')
            elseif target.Functions.GetMoney('bank') > sellAmount then
                local targetcid = target.PlayerData.citizenid
                MySQL.Async.execute('UPDATE player_vehicles SET citizenid = ? WHERE plate = ?', {targetcid, plate})
                player.Functions.AddMoney('bank', sellAmount)
                TriggerClientEvent('QBCore:Notify', src, 'You sold your vehicle for $'..comma_value(sellAmount), 'success')
                target.Functions.RemoveMoney('bank', sellAmount)
                TriggerClientEvent('vehiclekeys:client:SetOwner', target.PlayerData.source, plate)
                TriggerClientEvent('QBCore:Notify', target.PlayerData.source, 'You bought a vehicle for $'..comma_value(sellAmount), 'success')
            else
                TriggerClientEvent('QBCore:Notify', src, 'Not enough money', 'error')
            end
        else
            local targetcid = target.PlayerData.citizenid
            MySQL.Async.execute('UPDATE player_vehicles SET citizenid = ? WHERE plate = ?', {targetcid, plate})
            TriggerClientEvent('QBCore:Notify', src, 'You gifted your vehicle', 'success')
            TriggerClientEvent('vehiclekeys:client:SetOwner', target.PlayerData.source, plate)
            TriggerClientEvent('QBCore:Notify', target.PlayerData.source, 'You were gifted a vehicle', 'success')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Couldn\'t get purchaser info.', 'error')
    end
end)

-- Transfer vehicle to player in passenger seat
QBCore.Commands.Add('transferVehicle', 'Gift or sell your vehicle', {{name = 'ID', help = 'ID of buyer'}, {name = 'amount', help = 'Sell amount'}}, false, function(source, args)
    if args[1] ~= nil and args[2] ~= nil then
        TriggerClientEvent('fw-vehicleshop:client:transferVehicle', source, args[1], args[2])
    else
        TriggerClientEvent('QBCore:Notify', source, 'Check who you\'re selling to or the amount to sell for.', 'error')
    end
end)