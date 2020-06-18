ESX              = nil
local PlayerData = {}


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




function rollAnim()
    loadAnimDict( "anim@mp_player_intcelebrationmale@wank" ) 
    Citizen.Wait(500)
    TaskPlayAnim( PlayerPedId(), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(1500)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'dice', 0.1)
    ClearPedTasks(PlayerPedId())
    Citizen.Wait(500)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local playerPed = GetPlayerPed(-1)
    local playerLocalisation = GetEntityCoords(playerPed)
    ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 350.0)
  end
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
        -- These natives has to be called every frame.
      SetVehicleDensityMultiplierThisFrame(0.5)
      SetPedDensityMultiplierThisFrame(0.4)
      SetRandomVehicleDensityMultiplierThisFrame(0.5)
      SetParkedVehicleDensityMultiplierThisFrame(0.5)
      SetScenarioPedDensityMultiplierThisFrame(0.5, 0.5)
  end
end)




function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end




RegisterCommand('roll', function(source, args, rawCommand)

	times = tonumber(args[1])
	weight = tonumber(args[2])
	rollAnim()
	local strg = ""
	for i = 1, times do
		if i == 1 then
			strg = strg .. " " .. math.random(times, weight) .. "/" .. weight
		else
			strg = strg .. " | " .. math.random(times, weight) .. "/" .. weight
		end
		
	end
	TriggerServerEvent('chat:shareDisplay', 'Dice rolled ' .. strg)
end)



AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)