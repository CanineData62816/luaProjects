module = require(script.Parent.Parent.utils)
checkPerms = module.checkPerms
getSelector = module.getSeletor
searchForMember = module.searchForMember
searchForTeam = module.searchForTeam
starts = module.starts

return {
	["info"]={
		["name"]='tp';
		["description"]='Teleport a player to another player';
		["usage"]=';tp <player1> <player2>';
		["perms"]='Facilitor';
		["checkperms"]=function(plr): boolean
			local isAllowed = false
			if checkPerms(plr, 250) == true then isAllowed = true end
			return isAllowed
		end;
		["prefix"]=';',
		["Aliases"]={}
	};
	["execute"]=function(admin: Player, args)
		local players, target = table.unpack(args)
		if players and target then
			players = getSelector(admin, players)
			target = searchForMember(target)[1]
			if players and target then
				for i, player in pairs(players) do
					game.ServerStorage.ProtonFiles.antiCheatExemptPlayers:FindFirstChild(player.Name).Value = true
					player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
				end
			end
		end
	end;
}