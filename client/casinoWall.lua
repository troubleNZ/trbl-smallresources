local inCasino              = false
local videoWallRenderTarget = nil
local showBigWin            = false

--
-- Threads
--

function startCasinoThreads()
    RequestStreamedTextureDict('Prop_Screen_Vinewood')

    while not HasStreamedTextureDictLoaded('Prop_Screen_Vinewood') do
        Citizen.Wait(100)
    end

    RegisterNamedRendertarget('casinoscreen_01')

    LinkNamedRendertarget(`vw_vwint01_video_overlay`)

    videoWallRenderTarget = GetNamedRendertargetRenderId('casinoscreen_01')

    Citizen.CreateThread(function()
        local lastUpdatedTvChannel = 0

        while true do
            Citizen.Wait(0)

            if not inCasino then
                ReleaseNamedRendertarget('casinoscreen_01')

                videoWallRenderTarget = nil
                showBigWin            = false

                break
            end

            if videoWallRenderTarget then
                local currentTime = GetGameTimer()

                if showBigWin then
                    setVideoWallTvChannelWin()

                    lastUpdatedTvChannel = GetGameTimer() - 33666
                    showBigWin           = false
                else
                    if (currentTime - lastUpdatedTvChannel) >= 42666 then
                        setVideoWallTvChannel()

                        lastUpdatedTvChannel = currentTime
                    end
                end

                SetTextRenderId(videoWallRenderTarget)
                SetScriptGfxDrawOrder(4)
                SetScriptGfxDrawBehindPausemenu(true)
                DrawInteractiveSprite('Prop_Screen_Vinewood', 'BG_Wall_Colour_4x4', 0.25, 0.5, 0.5, 1.0, 0.0, 255, 255, 255, 255)
                DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            end
        end
    end)
end

--
-- Functions
--

function setVideoWallTvChannel()
    SetTvChannelPlaylist(0, CasinoConfig.VideoType, true)
    SetTvAudioFrontend(true)
    SetTvVolume(-100.0)
    SetTvChannel(0)
end

function setVideoWallTvChannelWin()
    SetTvChannelPlaylist(0, 'CASINO_WIN_PL', true)
    SetTvAudioFrontend(true)
    SetTvVolume(-100.0)
    SetTvChannel(-1)
    SetTvChannel(0)
end

--
-- Events
--

AddEventHandler(CasinoConfig.EnterEvent, function()
    inCasino = true

    startCasinoThreads()
end)

AddEventHandler(CasinoConfig.ExitEvent, function()
    inCasino = false
end)

AddEventHandler(CasinoConfig.BigWinEvent, function()
    if not inCasino then
        return
    end

    showBigWin = true
end)

RegisterCommand('ontest', function()
    TriggerEvent(CasinoConfig.EnterEvent)
end)

RegisterCommand('offtest', function()
    TriggerEvent(CasinoConfig.ExitEvent)
end)

RegisterCommand('wintest', function()
    TriggerEvent(CasinoConfig.BigWinEvent)
end)



local casinoWallpoly = PolyZone:Create({
    vector2(928.62, 49.46),
    vector2(935.84, 45.37),
    vector2(926.09, 54.96),
    vector2(929.85, 49.36),
  }, {
    debug=true,
    name="casinoWallpoly",
    minZ = 65.0,
    maxZ = 78.0
})
local inZone = false

casinoWallpoly:onPlayerInOut(function(isPointInside)
    if isPointInside then
        inZone = true
        
        CreateThread(function()
            while inZone do
                if not inCasino then
                    TriggerEvent(CasinoConfig.EnterEvent)
                end
                Wait(10000)
            end
        end)
    else
        inCasino = false
        ClosestShop = nil
    end
end)