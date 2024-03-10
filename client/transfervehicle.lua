QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('fw-vehicleshop:client:transferVehicle', function(buyerId, amount)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local plate = QBCore.Functions.GetPlate(vehicle)
    local tcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(buyerId)))
    if #(GetEntityCoords(ped)-tcoords) < 5.0 then
        TriggerServerEvent('fw-vehicleshop:server:transferVehicle', plate, buyerId, amount)
    else
        QBCore.Functions.Notify('The person you are selling to is too far away.')
    end
end)

