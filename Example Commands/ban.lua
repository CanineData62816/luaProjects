module = require(script.Parent.Parent.utils)
checkPerms = module.checkPerms
getSelector = module.getSeletor
searchForMember = module.searchForMember
searchForTeam = module.searchForTeam
starts = module.starts

return {
	["info"]={
		["name"]='ban';
		["description"]='Ban a player from that server.';
		["usage"]=';ban <player> <reason>';
		["perms"]='Facilitator';
		["checkperms"]=function(plr): boolean
			local isAllowed = false
			if checkPerms(plr, 400) == true then isAllowed = true end
			return isAllowed
		end;
		["prefix"]=';',
		["Aliases"]={''}
	};
	["execute"]=function(player, args)
		local targets = table.unpack(args)
		targets = getSelector(player, targets)
		for i, target in pairs(targets) do
			local value = Instance.new('BoolValue')
			value.Parent = game.ServerStorage.GameBannedUsers
			value.Value = true
			value.Name = target.Name
			target:Kick([[
		╔═══════════════════════╗
		     Proton Systems:    
		   Banned by an admin 
		╚═══════════════════════╝
		]])
		end
	end
}
