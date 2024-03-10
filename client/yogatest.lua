--Declare an global varible
--[[
	QBCore = nil


--Wait to get the Object
Citizen.CreateThread(function()

    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(100)
    end
	
end)


showblips = true

yogamats = {}
yogamats[0] = {name="Yogamat", id=197, x=212.68, y=-84.1, z=69.22}


--Thread that will display the blips at resource start
Citizen.CreateThread(function()

	--Wait for 1 second
	Citizen.Wait(1000)
	
	--If [showblips] is true
	if showblips then
		for i,v in pairs(yogamats) do
		
			--Define coords for the Blip
			local blip = AddBlipForCoord(v.x, v.y, v.z)

			--Set the sprite for the Blip
			SetBlipSprite(blip, v.id)

			--Type of display (map + gps)
			SetBlipDisplay(blip, 2)

			--scale of the Blip
			SetBlipScale(blip, 0.9)
			
			--Color of the Blip(green)
			SetBlipColour(blip, 2)
			
			
			SetBlipAlpha(BlipsGoFast, 200)

			--Blip only show at short range
			SetBlipAsShortRange(blip, true)

			--Set the text of the BLip
			AddTextEntry('MYBLIP', v.name)
			BeginTextCommandSetBlipName('MYBLIP')

			EndTextCommandSetBlipName(blip)
			
			PulseBlip(blip)

		end
	end

end)
]]

--[[--Main Thread that checks every second if the player is near the Yogamat position
Citizen.CreateThread(function()

	while true do 

		Citizen.Wait(1000)
	
		--If the player is near the yogamat coords
		if( nearYoga() )  then 

			--Show an help notification to Press E to start (showed for 31 seconds)
			--ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to start yoga ~g~" , false, true, 31000)
            QBCore:Notify("Press ~INPUT_PICKUP~ to start yoga ~g~", success, 5000)
			
			--Wait until the actual HelpNotification desepear before displaying another one if the player is still their (otherwise it would blink)
			Citizen.Wait(35000)
			
		end 
	
	end

end)

Citizen.CreateThread(function()

	while true do 

		Citizen.Wait(1000)
	
		--If the player is near the yogamat coords
		if( nearYoga() )  then 

			--Call the function [ displayNotification() ] 
			displayNotification()
			
		end 
	
	end

end)


--Function that will display the HelpNotification (for 31 seconds) and will capture the key press
function displayNotification()

	local loopTimer = 0
	
	--The loop will run for 31 seconds (310 times 10 milliseconds) 
	while loopTimer < 31000 do
	
		Citizen.Wait(10)
		ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to start yoga ~g~" , true, true, 31000)
					
		--If the [ E ] key is pressed then do somthing
		if IsControlJustPressed(0, 38) then
			--Here you can do what you want when the player press [ E ] (the print is just for testing)
			print("JUST PRESSED [ E ]!!!")
		end
			
		loopTimer = loopTimer + 10
		
	end
	

end


--Function to test if the player is near the coordonates of the Yogamat pos
function nearYoga()

	local player = PlayerPedId()
	
	local playerloc = GetEntityCoords(player, 0)
	
	for _, coords in pairs(yogamats) do
		
		--Last arg is set to false otherwise we have a weird result for the return value if we set the 3D mode
		local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.y, playerloc.x, playerloc.y, playerloc.z, false)
	
		if( distance <= 3 ) then
		
			return true
		
		end
	
	end

end

]]

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("yoga:client:startYoga")
AddEventHandler("yoga:client:startYoga", function()
    QBCore.Functions.Progressbar("yoja_time", "ready to stretch..", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        --TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["joint"], "remove")
        --[[if IsPedInAnyVehicle(PlayerPedId(), false) then
            --TriggerEvent('animations:client:EmoteCommandStart', {"yoga"})
			QBCore.Functions.Notify("No. You must be on foot.")
            --TriggerServerEvent('hud:Server:RelieveStress', math.random(20, 32))
            --TriggerServerEvent('hud:server:remove:stress', math.random(20, 32))
            
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"yoga"})
            --TriggerServerEvent('hud:Server:RelieveStress', math.random(20, 32))
            --TriggerServerEvent('hud:server:remove:stress', math.random(20, 32))
        end]]
        --TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
        TriggerEvent('animations:client:EmoteCommandStart', {"yoga"})
        TriggerServerEvent('hud:Server:RelieveStress', math.random(20, 32))
        --TriggerServerEvent('hud:server:remove:stress', math.random(12, 18))
        QBCore.Functions.Notify("Feeling better already..", "primary")
    --end)
	end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Feeling better already..", "primary")
    end, "fa-solid fa-circle-notch")
end)

