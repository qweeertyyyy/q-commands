-- Show commands
-----------------------------------------
RegisterCommand(q.showcoms, function(source, args, rawcommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        n(source, 'You can type in chat next commands > /'..q.bank..' /'..q.cash..' /'..q.dirty..' /'..q.job..' /'..q.name..' /'..q.showcoms)
    end
end, false)


-- Money
-----------------------------------------
RegisterCommand(q.bank, function(source, args, rawcommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local account = xPlayer.getAccount('bank')
        local balance = account.money
        n(source, 'You have ' .. balance .. '$ in your account')
    end
end, false)

RegisterCommand(q.cash, function(source, args, rawcommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cash = xPlayer.getMoney()

    if xPlayer then
        n(source, 'you have money in your pocket '..cash..'$')
    end
end, false)

RegisterCommand(q.dirty, function(source, args, rawcommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local account = xPlayer.getAccount('black_money')
    local balance = account.money

    if xPlayer then
        n(source, 'You have ' .. balance .. '$ dirty money')
    end
end, false)

-- Job
-----------------------------------------
RegisterCommand(q.job, function(source, args, rawcommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label

    if xPlayer then
        n(source, 'Your job is '..job..' and grade is '..jobgrade)
    end
end, false)

-- Name
-----------------------------------------
RegisterCommand(q.name, function(source, args, rawcommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()

    if xPlayer then
        n(source, 'Your name is '..name)
    end
end, false)

-- Admin comms 
-----------------------------------------
RegisterCommand(q.time, function(source, args, rawCommand)
    if #args == 2 then
        local hour = tonumber(args[1])
        local minute = tonumber(args[2])
        local xPlayer = ESX.GetPlayerFromId(source)
        
        if xPlayer then
            local admin = xPlayer.getGroup()
            if admin == q.group then
                if hour and minute then 
                    if hour >= 0 and hour <= 23 and minute >= 0 and minute <= 59 then 
                        TriggerClientEvent('q:coms:time', -1, hour, minute)
                        n(source, 'Time is changed to ' .. hour .. ':' .. minute)
                    else
                        n(source, 'Invalid time format. Please use /time [hour] [minute]')
                    end
                else
                    n(source, 'Invalid time format. Please use /time [hour] [minute]')
                end
            else
                n(source, 'You need to be '..q.group..' to do this')
            end
        else
            n(source, 'Error fetching player data.')
        end
    else
        n(source, 'Please use /time [hour] [minute]')
    end
end, false)

RegisterCommand(q.weather, function(source, args, rawCommand)
    if #args == 1 then
        local weatherType = tostring(args[1])
        local xPlayer = ESX.GetPlayerFromId(source)
        
        if xPlayer then
            local admin = xPlayer.getGroup()
            
            if admin == q.group then
                if weatherType then 
                    TriggerClientEvent('q:coms:weather', -1, weatherType)
                    n(source, 'Weather is changed to ' .. weatherType)
                else
                    n(source, 'Invalid weather type. Please use /weather [type]')
                end
            else
                n(source, 'You need to be '..q.group..' to do this')
            end
        else
            n(source, 'Error fetching player data.')
        end
    else
        n(source, 'Please use /weather [type]')
    end
end, false)

function n(source, message)
    if q.notify == 'esx' then
        TriggerClientEvent('esx:showNotification', source, message)
    elseif q.notify == 'ox' then
        TriggerClientEvent('ox_lib:notify', source, {title = 'Usefull Commands', description = message, position = q.position, type = 'info'})
    end
end


