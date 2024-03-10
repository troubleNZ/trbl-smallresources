

RegisterNetEvent("stopsign:client:Target")
AddEventHandler("stopsign:client:Target", function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, -949234773, false, false, false)
    SetEntityAsMissionEntity(obj, true, true)
    loadAnimDict("amb@prop_human_bum_bin@base")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    QBCore.Functions.Progressbar("robbing_sign", "Stealing Stop Sign..", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, function()
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("stopsign:server:additem")
        DeleteEntity(obj)
    end, "stopsign")
end)


local stopSignUsed = false
local stopSignObject = nil

RegisterNetEvent('dp:Client:UseStopSign')
AddEventHandler('dp:Client:UseStopSign', function()
  if not stopSignUsed then
    local ped = PlayerPedId()
    RequestAnimSet('WORLD_HUMAN_JANITOR')
    while not HasAnimSetLoaded('WORLD_HUMAN_JANITOR') do
      Citizen.Wait(1)
    end
    SetPedMovementClipset(ped, 'WORLD_HUMAN_JANITOR', 1.0) 
    stopSignObject = CreateObject(GetHashKey("prop_sign_road_01a"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(stopSignObject, ped, GetPedBoneIndex(ped, 57005), 0.10, -1.0, 0.0, -90.0, -250.0, 0.0, true, true, false, true, 5, true)
  else
    local ped = PlayerPedId()
    if PreviousWalkset ~= nil then
      RequestAnimSet(PreviousWalkset)
      while not HasAnimSetLoaded(PreviousWalkset) do
        Citizen.Wait(1)
      end
      SetPedMovementClipset(ped, PreviousWalkset, 1.0)
    end
    DetachEntity(stopSignObject, 0, 0)
    DeleteEntity(stopSignObject)
  end
  stopSignUsed = not stopSignUsed
end)


RegisterNetEvent("walkingmansign:client:Target")
AddEventHandler("walkingmansign:client:Target", function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, 1502931467, false, false, false)
    SetEntityAsMissionEntity(obj, true, true)
    loadAnimDict("amb@prop_human_bum_bin@base")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    QBCore.Functions.Progressbar("robbing_sign", "Stealing Pedestrian Sign..", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, function()
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("walkingmansign:server:additem")
        DeleteEntity(obj)
    end, "stopsign")
end)

RegisterNetEvent("dontblockintersectionsign:client:Target")
AddEventHandler("dontblockintersectionsign:client:Target", function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, 1191039009, false, false, false)
    SetEntityAsMissionEntity(obj, true, true)
    loadAnimDict("amb@prop_human_bum_bin@base")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    QBCore.Functions.Progressbar("robbing_sign", "Stealing Intersection Sign..", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, function()
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("dontblockintersectionsign:server:additem")
        DeleteEntity(obj)
    end)
end)

RegisterNetEvent("uturnsign:client:Target")
AddEventHandler("uturnsign:client:Target", function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, 4138610559, false, false, false)
    SetEntityAsMissionEntity(obj, true, true)
    loadAnimDict("amb@prop_human_bum_bin@base")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    QBCore.Functions.Progressbar("robbing_sign", "Stealing U Turn Sign..", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, function()
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("uturnsign:server:additem")
        DeleteEntity(obj)
    end)
end)

function loadAnimDict(dict)
    while(not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end