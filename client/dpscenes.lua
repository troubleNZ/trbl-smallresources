--[[
QBCore = {}
QBCore.dpscenes = {
	label = "",
}

local ped = PlayerPedId()

-- player entry field
RegisterNetEvent('trbl:client:dpscene:keyboardentry')
AddEventHandler('trbl:client:dpscene:keyboardentry',function()
local keyboard = exports["fw-keyboard"]:KeyboardInput({
    header = "Enter your Text", 
    rows = {
        {
            id = 0, 
            txt = "Text"
        },
      
    }
})

    if keyboard ~= nil then
        TriggerServerEvent('trbl:dpscene:server:SceneInput', ped, keyboard[1].input)			--  the event is in the dpscene server lua
        --QBCore.dpscenes[label] = keyboard[1].input
    end
end)
]]