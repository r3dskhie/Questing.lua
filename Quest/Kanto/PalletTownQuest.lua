-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'PalletTown'
local description = 'from PalletTown to Route 1'

local dialogs = {
	tree = Dialog:new({
		"Select a Pokemon that has Headbutt."
		headbutt = headbutt + 1
	})
	
}

local PalletTownQuest = Quest:new()
function PalletTownQuest:new()
	return Quest.new(PalletTownQuest, name, description, _, dialogs)
end

function PalletTownQuest:isDoable()
	if (isNpcOnCell(28, 22) or isNpcOnCell(27, 16)) and self:hasMap() then
		return true
	end
	return false
end

function PalletTownQuest:isDone()
	return getMapName() == "Route 1"
end


function PalletTownQuest:PalletTown()
	if isNpcOnCell(28, 22) then
  		pushDialogAnswer(butter)
		log("---Headbutting 1st tree---")
		return talkToNpcOnCell(28, 22)	--Tree 1
	elseif isNpcOnCell(27, 16) then
		pushDialogAnswer(butter)
		log("---Headbutting 2nd tree---")
		return talkToNpcOnCell(27, 16)	--Tree 2
	elseif isNpcOnCell(20, 7) then
		pushDialogAnswer(butter)
		log("---Headbutting 3rd tree---")
		return talkToNpcOnCell(20, 7)	--Tree 3
	elseif isNpcOnCell(8, 5) then
		pushDialogAnswer(butter)
		log("---Headbutting 4th tree---")
		return talkToNpcOnCell(8, 5)	--Tree 4
	elseif isNpcOnCell(4, 7) then
		pushDialogAnswer(butter)
		log("---Headbutting 5th tree---")
		return talkToNpcOnCell(4, 7)	--Tree 5
	elseif isNpcOnCell(13, 17) then
		pushDialogAnswer(butter)
		log("---Headbutting Last tree---")
		return talkToNpcOnCell(13, 17)	--Tree 6
	else
	log("---"..getMapName().." Cleared... Moving to next Map---")
		moveToMap("Route 1")
	end
end

function PalletTownQuest:battle()
	if getOpponentName() == "Charmander" or getOpponentName() == "Bulbasaur" or getOpponentName() == "Squirtle" or getOpponentName() == "Murkrow" then

		return useItem("Pokeball") or useItem("Ultra Ball") or useItem("Great Ball") or sendAnyPokemon() or run()
	else
		return run() or sendAnyPokemon()
	end
end

return PalletTownQuest
