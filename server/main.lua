RegisterCommand(Config.Commands.StartTutorial, function(source, args, rawCommand)
    Debug('Command /tutorial executed by', tostring(source))
    TriggerClientEvent('qs-tutorial:start', source, Config.Locations, Config.Speed)
end, false)

CreateThread(function()
    local resource = GetCurrentResourceName()
    if resource == 'qs-tutorial' then
        verify = true
    end
    if verify ~= true then
        repeat
            Wait(3000)
            Error('The console will close because ^4qs-tutorial ^0changed its name')
            Wait(5000)
            os.exit()
        until verify == true
    end
end)
