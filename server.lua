local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('fivem_system:server:getData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM fivem_system WHERE player_id = @player_id', {
            ['@player_id'] = xPlayer.identifier
        }, function(result)
            if result[1] then
                cb(json.decode(result[1].data))
            else
                cb({})
            end
        end)
    else
        cb({})
    end
end)

RegisterNetEvent('fivem_system:server:update')
AddEventHandler('fivem_system:server:update', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.execute('INSERT INTO fivem_system (player_id, data) VALUES (@player_id, @data) ON DUPLICATE KEY UPDATE data = @data', {
            ['@player_id'] = xPlayer.identifier,
            ['@data'] = json.encode(data)
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('fivem_system:client:update', source, data)
            end
        end)
    end
end)