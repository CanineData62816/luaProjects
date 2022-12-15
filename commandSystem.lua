local Commands = require(script.Commands)

function starts(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end

function getPermLevel(player: Player): number
	local permLevel: number = 0
	local mainRank = player:GetRankInGroup(14141941)
	local msdrank = player:GetRankInGroup(14142592)
	local mnrirank = player:GetRankInGroup(15562282)
	local mhctrank = player:GetRankInGroup(15562282)
	if mainRank == 0 and msdrank == 0 and mnrirank == 0 and mhctrank == 0 then return 0 end
	if mainRank >= 253 then return 500 end
	if mainRank == 251 then return 400 end
	if mainRank == 250 then return 300 end
	if msdrank >= 251 then return 500 end
	if msdrank == 250 then return 400 end
	if msdrank == 249 then return 350 end
	return permLevel
end

game.Players.PlayerAdded:Connect(function(player)
	local files = Instance.new('Folder')
	files.Name = 'ProtonFiles'
	files.Parent = player
	local rank = Instance.new('IntValue')
	rank.Name = 'PermLevel'
	rank.Value = getPermLevel(player)
	rank.Parent = files
	
	player.Chatted:Connect(function(chatMessage, recipient)
		if not starts(chatMessage, ';') and not starts(chatMessage, '!') and not starts(chatMessage, '/e ') then return end
		local messages = chatMessage:split(' | ')
		for i, message in pairs(messages) do
			local split = message:split(' ')
			if split[1] == '/e' then
				table.remove(split, 1)
			end
			local cmd = split[1]
			cmd = cmd:split('')
			local prefix = cmd[1]
			table.remove(cmd, 1)
			cmd = table.concat(cmd, '')
			table.remove(split, 1)
			local possibleCmds = {}
			for i, command in pairs(Commands) do
				if command.info.name == cmd or table.find(command.info.Aliases, cmd) then
					if command.info.prefix ~= prefix then continue end
					table.insert(possibleCmds, command)
				end
			end
			if #possibleCmds == 0 then return game.ReplicatedStorage.ProtonFiles.unknowncmdEvent:FireClient(player, prefix..cmd) end
			local command = possibleCmds[1]
			if not command.info.checkperms(player) then 
				game.ReplicatedStorage.ProtonFiles.nopermsEvent:FireClient(player, prefix..cmd)
				return print('Invalid perms!')
			elseif command.info.checkperms(player) then
				command.execute(player, split)
			end
			
		end
	end)
end)
