QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('esx_communityservice:finishCommunityService')
AddEventHandler('esx_communityservice:finishCommunityService', function(key)
	local src = source 
	
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer then
			xPlayer.Functions.SetMetaData("communityservice", 0)
			TriggerClientEvent('esx_communityservice:finishCommunityService', xPlayer.PlayerData.source)
		end
	
end)

RegisterServerEvent('esx_communityservice:sendToCommunityService')
AddEventHandler('esx_communityservice:sendToCommunityService', function(player, count, key)
	local src = source 
		local tPlayer = QBCore.Functions.GetPlayer(player)
		TriggerClientEvent("esx_communityservice:inCommunityService", player, count)
		tPlayer.Functions.SetMetaData("communityservice", count)

end)

RegisterServerEvent('esx_communityservice:completeService')
AddEventHandler('esx_communityservice:completeService', function(key)
	local src = source
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer then
			xPlayer.Functions.SetMetaData("communityservice", xPlayer.PlayerData.metadata["communityservice"] - 1)
		end
end)

RegisterServerEvent('esx_communityservice:extendService') 
AddEventHandler('esx_communityservice:extendService', function()
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		xPlayer.Functions.SetMetaData("communityservice", xPlayer.PlayerData.metadata["communityservice"] + Config.ServiceExtensionOnEscape)
	end
end)

RegisterServerEvent('sendserverdatass', function(data)
local player_id = data.id
local kamu = data.kamu
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.PlayerData.job.name == "police" then
		local tPlayer = QBCore.Functions.GetPlayer(tonumber(player_id))
		if tPlayer then
			local count = tonumber(kamu)
			TriggerClientEvent("esx_communityservice:inCommunityService", tPlayer.PlayerData.source, count)
			tPlayer.Functions.SetMetaData("communityservice", count)
			TriggerClientEvent("QBCore:Notify", src, "Player has been sentenced of community service.")
		else
			TriggerClientEvent("QBCore:Notify", source, "There Is No Such Player!", "error")
				end
	end
end)

QBCore.Commands.Add("endcomserv", "", {{name="id", help="Player ID"}}, true, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.name == "police" then
		local tPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if tPlayer then
			tPlayer.Functions.SetMetaData("communityservice", 0)
			TriggerClientEvent('esx_communityservice:finishCommunityService', tPlayer.PlayerData.source)
		else
			TriggerClientEvent("QBCore:Notify", source, "There Is No Such Player!", "error")
		end
	end
end)