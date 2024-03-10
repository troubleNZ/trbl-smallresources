local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("stopsign:server:additem")
AddEventHandler("stopsign:server:additem", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("stopsign", 1, false)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stopsign'], "add")
end)

RegisterNetEvent("walkingmansign:server:additem")
AddEventHandler("walkingmansign:server:additem", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("walkingmansign", 1, false)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['walkingmansign'], "add")
end)

RegisterNetEvent("dontblockintersectionsign:server:additem")
AddEventHandler("dontblockintersectionsign:server:additem", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("dontblockintersectionsign", 1, false)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['dontblockintersectionsign'], "add")
end)

RegisterNetEvent("uturnsign:server:additem")
AddEventHandler("uturnsign:server:additem", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("uturnsign", 1, false)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['uturnsign'], "add")
end)

QBCore.Functions.CreateUseableItem("stopsign", function(source, item)
    --TriggerClientEvent('710-carFobs:openKeyRing', source)
    local src = source
    --TriggerClientEvent('dp:Client:UseStopSign', source)
    TriggerClientEvent('animations:client:EmoteCommandStart', src, {"stopsign"})
end)