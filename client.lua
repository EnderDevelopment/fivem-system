local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('fivem_system:client:update')
AddEventHandler('fivem_system:client:update', function(data)
    ESX.ShowNotification('System updated: ' .. json.encode(data))
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        TriggerServerEvent('fivem_system:server:update', {example = 'data'})
    end
end)