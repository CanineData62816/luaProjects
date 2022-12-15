local players = game:GetService('Players')
local tpService = game:GetService('TeleportService')
local httpService = game:GetService('HttpService')

players.PlayerAdded:Connect(function(plr)
	local joinData = plr:GetJoinData()
	local urlInfo: string = joinData['LaunchData']
	if not urlInfo then return end
	local serverId = string.split(string.split(urlInfo, ';')[1], ':')[2]
	if #serverId == 0 then return end
	local teleportOptions = Instance.new('TeleportOptions')
	teleportOptions.ServerInstanceId = serverId
	if serverId == game.JobId then return end
	tpService:TeleportAsync(game.PlaceId, {plr}, teleportOptions)
end)
