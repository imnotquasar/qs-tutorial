local tutorialActive = false
local stepIndex = 1
local locations = {}
local cam = nil
local initialCoords = nil
local initialHeading = nil
local alreadyShowedTutorial = false

RegisterNUICallback('init', function(data, cb)
    Debug('updated firstSpawn to', data.alreadyShowedTutorial)
    alreadyShowedTutorial = data.alreadyShowedTutorial
    cb('ok')
end)

exports('StartTutorial', function()
    if alreadyShowedTutorial then
        Debug('There is no first spawn detected, skipping tutorial...')
        return false
    end
    Debug('Tutorial starting')
    TriggerEvent('qs-tutorial:start', Config.Locations, Config.Speed)
    Wait(100)
    while tutorialActive do
        Debug('Waiting for tutorial to finish...')
        Wait(500)
    end
    return true
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Debug('Reboot detected, resetting tutorial...')

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, true, 0)
    RenderScriptCams(false, false, 0, true, true)
    DestroyAllCams(true)

    Config.Hud:Enable()
    tutorialActive = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'hideTutorial' })
end)

RegisterNetEvent('qs-tutorial:start')
AddEventHandler('qs-tutorial:start', function(locationsData, speed)
    ClearFocus()
    tutorialActive = true
    Debug('Event qs-tutorial:start received with ' .. #locationsData .. ' locations.')
    locations = locationsData
    stepIndex = 1

    local playerPed = PlayerPedId()
    initialCoords = GetEntityCoords(playerPed)
    initialHeading = GetEntityHeading(playerPed)

    SetEntityVisible(playerPed, false, 0)
    SetNuiFocus(true, true)
    Config.Hud:Disable()


    DoScreenFadeOut(1000)
    Citizen.Wait(1200)

    local firstLocation = locations[1]

    FreezeEntityPosition(playerPed, true)

    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(cam, firstLocation.coords.x, firstLocation.coords.y, firstLocation.coords.z + 10.0)
    SetCamRot(cam, -25.0, 0.0, firstLocation.heading, 2)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 0, true, true)
    RequestCollisionAtCoord(firstLocation.coords.x, firstLocation.coords.y, firstLocation.coords.z)
    SetEntityCollision(playerPed, false, false)

    Citizen.Wait(500)
    DoScreenFadeIn(1000)
    Citizen.Wait(1000)
    SendNUIMessage({ action = 'showTutorial' })

    StartNextStep()
end)

function StartNextStep()
    if stepIndex > #locations then
        EndTutorial()
        return
    end

    local location = locations[stepIndex]
    Debug('Moving camera to location', location.coords.x, location.coords.y, location.coords.z)

    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, location.coords.x, location.coords.y, location.coords.z + 10.0)
    SetEntityAlpha(playerPed, 0, false)
    FreezeEntityPosition(playerPed, true)

    SetCamCoord(cam, location.coords.x, location.coords.y, location.coords.z + 10.0)
    SetCamRot(cam, -25.0, 0.0, location.heading, 2)
    SetCamActive(cam, true)
    RequestCollisionAtCoord(location.coords.x, location.coords.y, location.coords.z)
    SetPlayerControl(playerPed, false, 0)
    SetEntityAlpha(playerPed, 0, false)
    NetworkResurrectLocalPlayer(location.coords.x, location.coords.y, location.coords.z, location.heading, 0, true)
    SetEntityAlpha(playerPed, 255, false)
    SetPlayerControl(playerPed, true, 0)

    SendNUIMessage({
        action = 'updateTutorial',
        image = location.image,
        text = location.text,
        button = location.button,
        vibrate = location.vibrate
    })
end

RegisterNUICallback('continue', function(data, cb)
    stepIndex = stepIndex + 1
    StartNextStep()
    cb('ok')
end)

function EndTutorial()
    Debug('Ending tutorial')
    SendNUIMessage({ action = 'hideTutorial' })
    Citizen.Wait(500)

    DoScreenFadeOut(1000)
    Citizen.Wait(1200)

    TriggerEvent('qs-tutorial:end')

    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, initialCoords.x, initialCoords.y, initialCoords.z)
    SetEntityHeading(playerPed, initialHeading)
    SetEntityVisible(playerPed, true, 0)
    SetEntityAlpha(playerPed, 255, false)
    FreezeEntityPosition(playerPed, false)

    RenderScriptCams(false, true, 0, true, true)
    DestroyCam(cam, false)

    Citizen.Wait(500)
    DoScreenFadeIn(1000)

    DisplayRadar(true, true)
    tutorialActive = false
    SetNuiFocus(false, false)
end

RegisterCommand(Config.Commands.ResetTutorial, function()
    SendNUIMessage({
        action = 'resetTutorial'
    })
    Debug('Tutorial reset!')
end, false)
