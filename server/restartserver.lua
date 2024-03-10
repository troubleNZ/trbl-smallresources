local restartTimes = { '02:30', '06:30', '10:30', '14:30', '18:30', '22:30' }	-- local server time
local QBCore = exports['qb-core']:GetCoreObject()
local announceHeader = '<div class="announcement"><i class="fa fa-bullhorn"></i> {0}<br>^0{1}</div>'


--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)
		local time = os.date("%X"):sub(1, -4)
		for i=1, #restartTimes, 1 do
			if restartTimes[i] == time then
				TriggerEvent('fw-weathersync:server:setWeather', "rain")
				TriggerClientEvent('chat:addMessage', -1, {
					template = announceHeader,
					args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 30 minutes!" }
				})
				Citizen.Wait(900000)
				TriggerClientEvent('chat:addMessage', -1, {
					template = announceHeader,
					args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 15 minutes!" }
				})
				
				local ran1 = math.random(0,1)
				local ran2 = math.random(0,1)
				print("tornado coin flip")				-- actually 2 coins
				print(ran1.." "..ran2)
				if ran1 == 1 and ran2 == 1 then			-- 25% chance
					TriggerEvent("tornado:summon")
				end

				Citizen.Wait(300000)
				TriggerClientEvent('chat:addMessage', -1, {
					template = announceHeader,
					args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 10 minutes!" }
				})
				Citizen.Wait(300000)
				TriggerEvent('fw-weathersync:server:setWeather', "thunder")
				TriggerClientEvent('chat:addMessage', -1, {
					template = announceHeader,
					args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 5 minutes!" }
				})
				
				Citizen.Wait(180000)
				TriggerClientEvent('chat:addMessage', -1, {
					template = announceHeader,
					args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 2 minutes!" }
				})
				Citizen.Wait(60000)
				TriggerClientEvent('chat:addMessage', -1, {
					template = announceHeader,
					args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 1 minute!" }
				})
				Citizen.Wait(30000)
				TriggerClientEvent('chat:addMessage', -1, {
					template = announceHeader,
					args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 30 seconds. Exit Now!" }
				})
				Citizen.Wait(30000)
			end
		end
	end
end)]]

function restart()
	local xPlayers = QBCore.Functions.GetPlayers()
	for i=1, #xPlayers, 1 do
		DropPlayer(xPlayers[i], "All Roleplay situations have ended. Your progress has been saved. City is restarting and will be back in 2 minutes!")
	end
	Citizen.Wait(10000)
	os.exit()
end

QBCore.Commands.Add("restartcity", "5 Minute City Restart", {}, false, function(source, args, user)
    Citizen.CreateThread(function()
		TriggerClientEvent('chat:addMessage', -1, {
			template = announceHeader,
			args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 5 minutes!" }
		})
		TriggerEvent("tornado:summon")
		Citizen.Wait(180000)
		TriggerClientEvent('chat:addMessage', -1, {
			template = announceHeader,
			args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 2 minutes!" }
		})
		Citizen.Wait(60000)
		TriggerClientEvent('chat:addMessage', -1, {
			template = announceHeader,
			args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 1 minute!" }
		})
		Citizen.Wait(30000)
		TriggerClientEvent('chat:addMessage', -1, {
			template = announceHeader,
			args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 30 seconds!" }
		})
		Citizen.Wait(30000)
		restart()
	end)
end, "god")

QBCore.Commands.Add("restartcitynow", "Restart the city instantly.", {}, false, function(source, args, user)
    Citizen.CreateThread(function()
		restart()
	end)
end, "god")



--[[AddEventHandler('txAdmin:events:scheduledRestart', function(eventData) -- Gets called every [30, 15, 10, 5, 4, 3, 2, 1] minutes by default according to config
    if eventData.secondsRemaining == 1800 then -- 30mins
        TriggerEvent('fw-weathersync:server:setWeather', "rain")
        TriggerClientEvent('chat:addMessage', -1, {
            template = announceHeader,
            args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 30 minutes!" }
        })
    elseif eventData.secondsRemaining == 900 then -- 15mins
        TriggerClientEvent('chat:addMessage', -1, {
            template = announceHeader,
            args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 15 minutes!" }
        })
		TriggerEvent("tornado:summon")
    elseif eventData.secondsRemaining == 300 then -- 5mins
        TriggerEvent('fw-weathersync:server:setWeather', "thunder")
        TriggerClientEvent('chat:addMessage', -1, {
            template = announceHeader,
            args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 5 minutes!" }
        })
    elseif eventData.secondsRemaining == 120 then -- 2mins
        TriggerClientEvent('chat:addMessage', -1, {
            template = announceHeader,
            args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 2 minutes!" }
        })
    elseif eventData.secondsRemaining == 60 then -- 1min
        TriggerClientEvent('chat:addMessage', -1, {
            template = announceHeader,
            args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 1 minutes!" }
        })
        Citizen.Wait(30000) -- Because this event does not get called at the 30second mark
        TriggerClientEvent('chat:addMessage', -1, {
            template = announceHeader,
            args = { "Emergency Announcement!", "Attention citizens! 🌊 Tsunami is going to hit the city in 30 Seconds!" }
        })
    end
end)]]