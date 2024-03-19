local tuna_interior_id    = GetInteriorAtCoords(vector3(-1350.0, 160.0, -100.0))
local meetup_interior_id  = GetInteriorAtCoords(vector3(-2000.0, 1113.211, -25.36243))
local methlab_interior_id = GetInteriorAtCoords(vector3(981.9999, -143.0, -50.0))
local enteredInteriorId   = nil

local EntitySetsTuner = {
    ['entity_set_bedroom']           = true,
    ['entity_set_bedroom_empty']     = true,
    ['entity_set_bombs']             = true,
    ['entity_set_box_clutter']       = false,
    ['entity_set_cabinets']          = true,
    ['entity_set_car_lift_cutscene'] = true,
    ['entity_set_car_lift_default']  = true,
    ['entity_set_car_lift_purchase'] = true,
    ['entity_set_chalkboard']        = true,
    ['entity_set_container']         = true,
    ['entity_set_cut_seats']         = true,
    ['entity_set_def_table']         = true,
    ['entity_set_drive']             = true,
    ['entity_set_ecu']               = true,
    ['entity_set_IAA']               = true,
    ['entity_set_jammers']           = true,
    ['entity_set_laptop']            = true,
    ['entity_set_lightbox']          = true,
    ['entity_set_methLab']           = true,
    ['entity_set_plate']             = true,
    ['entity_set_scope']             = true,
    ['entity_set_table']             = true,
    ['entity_set_thermal']           = true,
    ['entity_set_tints']             = true,
    ['entity_set_train']             = true,
    ['entity_set_virus']             = true,
}

local entitySetsMeet = {
    ['entity_set_meet_crew']         = true,
    ['entity_set_meet_lights']       = true,
    ['entity_set_meet_lights_cheap'] = true,
    ['entity_set_player']            = true,
    ['entity_set_test_crew']         = true,
    ['entity_set_test_lights']       = true,
    ['entity_set_test_lights_cheap'] = true,
    ['entity_set_time_trial']        = true,
}

local EntitySetMeth = {
    ['tintable_walls'] = true,
}

-- Load base entity sets
Citizen.CreateThread(function()
    
    RequestIpl('tr_tuner_meetup')
    RequestIpl('tr_tuner_race_line')
    RequestIpl('tr_tuner_shop_burton')
    RequestIpl('tr_tuner_shop_mesa' )
    RequestIpl('tr_tuner_shop_mission' )
    RequestIpl('tr_tuner_shop_rancho')
    RequestIpl('tr_tuner_shop_strawberry')
    
    if IsValidInterior(tuna_interior_id) then
      RefreshInterior(tuna_interior_id)
    end

    if IsValidInterior(meetup_interior_id) then
        RefreshInterior(meetup_interior_id)
    end

    if IsValidInterior(methlab_interior_id) then
        RefreshInterior(methlab_interior_id)
    end

    for k, v in pairs(EntitySetsTuner) do
        if v then
            ActivateInteriorEntitySet(tuna_interior_id, k)
        else
            DeactivateInteriorEntitySet(tuna_interior_id, k)
        end

    end

    for k, v in pairs(entitySetsMeet) do
        if v then
            ActivateInteriorEntitySet(meetup_interior_id, k)
        else
            DeactivateInteriorEntitySet(meetup_interior_id, k)
        end
    end

    for k, v in pairs(EntitySetMeth) do
        if v then
            ActivateInteriorEntitySet(methlab_interior_id, k)
        else
            DeactivateInteriorEntitySet(methlab_interior_id, k)
        end
    end

    SetInteriorEntitySetColor(284673, "tintable_walls", 2)
end)

-- Main thread
--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        -- Enable the Los Santos Car Meet?
        if TunerConfig.EnableCarMeet then
            if GetDistanceBetweenCoords(GetEntityCoords(playerPed), TunerConfig.CarMeet.enter.x, TunerConfig.CarMeet.enter.y, TunerConfig.CarMeet.enter.z, true) < 5.0 then
                if KeyTips(TunerConfig.CarMeet.name, true) and IsControlJustPressed(0, 51) then
                    TeleportPlayerWithCar(playerPed, TunerConfig.CarMeet.leave.x, TunerConfig.CarMeet.leave.y, TunerConfig.CarMeet.leave.z, TunerConfig.CarMeet.leave.h)
                end
            elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), TunerConfig.CarMeet.leave.x, TunerConfig.CarMeet.leave.y, TunerConfig.CarMeet.leave.z, true) < 5.0 then
                if KeyTips(TunerConfig.CarMeet.name, false) and IsControlJustPressed(0, 51) then
                    TeleportPlayerWithCar(playerPed, TunerConfig.CarMeet.enter.x, TunerConfig.CarMeet.enter.y, TunerConfig.CarMeet.enter.z, TunerConfig.CarMeet.enter.h)
                end
            elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), TunerConfig.DriftTrack.enter.x, TunerConfig.DriftTrack.enter.y, TunerConfig.DriftTrack.enter.z, true) < 5.0 then
                if KeyTips(TunerConfig.DriftTrack.name, true) and IsControlJustPressed(0, 51) then
                    TeleportPlayerWithCar(playerPed, TunerConfig.DriftTrack.leave.x, TunerConfig.DriftTrack.leave.y, TunerConfig.DriftTrack.leave.z, TunerConfig.DriftTrack.leave.h)
                end
            elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), TunerConfig.DriftTrack.leave.x, TunerConfig.DriftTrack.leave.y, TunerConfig.DriftTrack.leave.z, true) < 5.0 then
                if KeyTips(TunerConfig.DriftTrack.name, false) and IsControlJustPressed(0, 51) then
                    TeleportPlayerWithCar(playerPed, TunerConfig.DriftTrack.enter.x, TunerConfig.DriftTrack.enter.y, TunerConfig.DriftTrack.enter.z, TunerConfig.DriftTrack.enter.h)
                end
            end
        end
        -- Enable the autoshop garage?
        if TunerConfig.EnableGarage then
            for k, v in pairs(TunerConfig.Garage) do
                if GetDistanceBetweenCoords(GetEntityCoords(playerPed), v.enter.x, v.enter.y, v.enter.z, true) < 5.0 then
                    if KeyTips(v.name, true) and IsControlJustPressed(0, 51) then
                        enteredInteriorId = k
                        DisableInteriors()
                        ActivateInteriorEntitySet(tuna_interior_id, v.style)
                        RefreshInterior(tuna_interior_id)
                        TeleportPlayerWithCar(playerPed, v.leave.x, v.leave.y, v.leave.z, v.leave.h)
                    end
                elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.leave.x, v.leave.y, v.leave.z, true) < 5.0 then
                    if KeyTips(v.name, false) and IsControlJustPressed(0, 51) then
                        if enteredInteriorId ~= nil then
                            TeleportPlayerWithCar(playerPed, TunerConfig.Garage[enteredInteriorId].enter.x, TunerConfig.Garage[enteredInteriorId].enter.y, TunerConfig.Garage[enteredInteriorId].enter.z, TunerConfig.Garage[enteredInteriorId].enter.h)
                        else
                            TeleportPlayerWithCar(playerPed, v.enter.x, v.enter.y, v.enter.z, v.enter.h)
                        end
                        DisableInteriors()
                    end
                end
            end
        end
    end
end)]]

function DisplayHelpText(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function IsBlackListVehicle(vehicle)
    if not DoesEntityExist(vehicle) then return false end
    local vehicleClass = GetVehicleClass(vehicle)
    if not TunerConfig.AllowClass[vehicleClass] then
        return true
    end
    for _, v in pairs(TunerConfig.BlackListModels) do
        if v == GetEntityModel(vehicle) then
            return true
        end
    end
    return false
end

function KeyTips(name, enter)
    if IsBlackListVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
        DisplayHelpText(string.format("%s %s", TunerConfig.Language["black_lists"], name))
        return false
    elseif enter then
        DisplayHelpText(string.format("%s %s", TunerConfig.Language["press_enter"], name))
        return true
    else
        DisplayHelpText(string.format("%s %s", TunerConfig.Language["press_leave"], name))
        return true
    end
end

function TeleportPlayerWithCar(playerPed, x, y, z, heading)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    SetPedCoordsKeepVehicle(playerPed, x, y, z)
    if IsPedInAnyVehicle(playerPed, false) then
        SetEntityHeading(GetVehiclePedIsIn(playerPed, false), heading)
    else
        SetEntityHeading(heading)
    end
    Citizen.Wait(1000)
    DoScreenFadeIn(250)
end

function DisableInteriors()
    local interiors = {
        ['entity_set_style_1'] = false,
        ['entity_set_style_2'] = false,
        ['entity_set_style_3'] = false,
        ['entity_set_style_4'] = false,
        ['entity_set_style_5'] = false,
        ['entity_set_style_6'] = false,
        ['entity_set_style_7'] = false,
        ['entity_set_style_8'] = false,
        ['entity_set_style_9'] = false,
    }
    for k, v in pairs(interiors) do
        DeactivateInteriorEntitySet(tuna_interior_id, k)
    end
    RefreshInterior(tuna_interior_id)
end




-- east tuner garage 

Citizen.CreateThread(function()


    RequestIpl("tunergarage_milo_")
    
        interiorID = GetInteriorAtCoords(810.46170000,-962.07540000,25.30295000)
    
        
        if IsValidInterior(interiorID) then
        EnableInteriorProp(interiorID, "entity_set_bedroom") 
        DisableInteriorProp(interiorID, "entity_set_bedroom_empty") 
        EnableInteriorProp(interiorID, "entity_set_bombs") 
        DisableInteriorProp(interiorID, "entity_set_box_clutter") 
        EnableInteriorProp(interiorID, "entity_set_cabinets") 
        DisableInteriorProp(interiorID, "entity_set_car_lift_cutscene") 
        EnableInteriorProp(interiorID, "entity_set_car_lift_default") 
        EnableInteriorProp(interiorID, "entity_set_car_lift_purchase") 
        EnableInteriorProp(interiorID, "entity_set_chalkboard") 
        EnableInteriorProp(interiorID, "entity_set_container") 
        EnableInteriorProp(interiorID, "entity_set_cut_seats") 
        EnableInteriorProp(interiorID, "entity_set_def_table") 
        EnableInteriorProp(interiorID, "entity_set_drive") 
        EnableInteriorProp(interiorID, "entity_set_ecu") 
        EnableInteriorProp(interiorID, "entity_set_IAA") 
        EnableInteriorProp(interiorID, "entity_set_laptop") 
        EnableInteriorProp(interiorID, "entity_set_lightbox") 
        EnableInteriorProp(interiorID, "entity_set_methLab") 
        EnableInteriorProp(interiorID, "entity_set_plate") 
        EnableInteriorProp(interiorID, "entity_set_scope") 
        DisableInteriorProp(interiorID, "entity_set_style_1") 
        DisableInteriorProp(interiorID, "entity_set_style_2") 
        DisableInteriorProp(interiorID, "entity_set_style_3") 
        DisableInteriorProp(interiorID, "entity_set_style_4") 
        DisableInteriorProp(interiorID, "entity_set_style_5") 
        EnableInteriorProp(interiorID, "entity_set_style_6") 
        DisableInteriorProp(interiorID, "entity_set_style_7") 
        DisableInteriorProp(interiorID, "entity_set_style_8") 
        DisableInteriorProp(interiorID, "entity_set_style_9") 
        DisableInteriorProp(interiorID, "entity_set_table") 
        EnableInteriorProp(interiorID, "entity_set_thermal") 
        EnableInteriorProp(interiorID, "entity_set_tints") 
        EnableInteriorProp(interiorID, "entity_set_train") 
        EnableInteriorProp(interiorID, "entity_set_virus") 
        
        RefreshInterior(interiorID)
        
        end
        
    end)
    