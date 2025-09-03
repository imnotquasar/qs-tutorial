function Debug(...)
    if not Config.Debug then return end
    local msg = '^2[TUTORIAL DEBUG]:^0 '
    for i, v in pairs({ ... }) do
        if type(v) == 'table' then
            msg = msg .. json.encode(v) .. '\t'
        else
            msg = msg .. tostring(v) .. '\t'
        end
    end
    msg = msg
    print(msg)
end

function Error(...)
    local msg = '^1[TUTORIAL ERROR]:^0 '
    for i, v in pairs({ ... }) do
        msg = msg .. tostring(v) .. '\t'
    end
    msg = msg
    print(msg)
end