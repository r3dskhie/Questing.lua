-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'Route 1'
local description = 'from Route 1 to Viridian City'

local dialogs = {
	tree = Dialog:new({
		"Select a Pokemon that has Headbutt."
		
	})
	
}

local Route1Quest = Quest:new()
function Route1Quest:new()
	return Quest.new(Route1Quest, name, description, _, dialogs)
end

function Route1Quest:isDoable()
	if self:hasMap() then
		return true
	end
	return false
end

function Route1Quest:isDone()
	return getMapName() == "Viridian City"
end


function Route1Quest:Route1()
	if isNpcOnCell(6,7) then
		pushDialogAnswer(butter)
	log("---Headbutting 1st tree---")
		return talkToNpcOnCell(6,7)	--Tree 1
	elseif isNpcOnCell(19,5) then
		pushDialogAnswer(butter)
	log("---Headbutting 2nd tree---")
		return talkToNpcOnCell(19,5)	--Tree 2
	elseif isNpcOnCell(13,23) then
		pushDialogAnswer(butter)
	log("---Headbutting 3rd tree---")
		return talkToNpcOnCell(13,23)	--Tree 3
	elseif isNpcOnCell(17,23) then
		pushDialogAnswer(butter)
			log("---Headbutting 4th tree---")
		return talkToNpcOnCell(17,23)	--Tree 4
	elseif isNpcOnCell(14,28) then
		pushDialogAnswer(butter)
	log("---Headbutting 5th tree---")
		return talkToNpcOnCell(14,28)	--Tree 5
	elseif isNpcOnCell(17,35) then
		pushDialogAnswer(butter)
	log("---Headbutting 6th tree---")
		return talkToNpcOnCell(17,35)	--Tree 6
	elseif isNpcOnCell(9,37) then
		pushDialogAnswer(butter)
	log("---Headbutting 7th tree---")
		return talkToNpcOnCell(9,37)	--Tree 7
	elseif isNpcOnCell(28,43) then
		pushDialogAnswer(butter)
	log("---Headbutting Last tree---")
		return talkToNpcOnCell(28,43)	--Tree 8
	else
	log("---"..getMapName().." Cleared... Moving to next Map---")
		moveToMap("Route 1 Stop House")
	end
end

function PalletTownQuest:battle()
	if getOpponentName() == "Charmander" or getOpponentName() == "Bulbasaur" or getOpponentName() == "Squirtle" or getOpponentName() == "Murkrow" or getOpponentName() == "Fletchling" or getOpponentName() == "Starly" then

		return useItem("Pokeball") or useItem("Ultra Ball") or useItem("Great Ball") or sendAnyPokemon() or run()
	else
		return run() or sendAnyPokemon()
	end
end

return Route1Quest

