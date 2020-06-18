ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterCommand('givecash', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    local daddy = args[1]
    local giveMoney = tonumber(args[2])

    local xTarget = ESX.GetPlayerFromId(daddy)


    if GetPlayerName(daddy) ~= nil then

        if giveMoney ~= nil then
            if xPlayer.getMoney() >= giveMoney then
                xPlayer.removeMoney(giveMoney)
                xTarget.addMoney(giveMoney)
            else
                TriggerClientEvent('ShortText',source, 'You dont have that much')
            end
        else
            TriggerClientEvent('DoLongHudText',source, 'Incorrect Amount')
        end

    else
        TriggerClientEvent('DoLongHudText',source, 'No Player')
    end
end)
