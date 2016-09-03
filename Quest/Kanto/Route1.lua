-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

--[[
	This is a template file to create your own Quest.
	This file is made for you. If anything is unclear, do not hesitate to
	contact me through:
		- g0ld@tuta.io
		- proshine-bot.ml
		- discord.gg/0t8HE2IMuqUTour9
		
	To add your quest to the Questing script you need to edit QuestManager.lua.
--]]

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

-- Avoid using only the name of the map since multiple quests could happen on
-- the same map
local name        = '---Route 1---'
local description = 'Moving to Viridian City if Route 1 is cleared'


-- When a dialog contains one of those strings, the state variable of the
-- created instance will be set to true.
-- You can access it with: dialogs.aDialogInstance.state == true
local dialogs = {
	aDialogInstance = Dialog:new({
	headbutt = Dialog:new({
		"Select a Pokemon that has Headbutt."
	}),
	dig = Dialog:new({
		"Select a Pokemon that has Dig."
	})
}

-- This part is always the same for every script.
-- This is the constructor of the TemplateQuest class, inheriting from Quest.
-- All The functions of Quest.lua can be used with TemplateQuest.
local Route1Quest = Quest:new()
function Route1Quest:new()
	return Quest.new(Route1Quest, name, description, dialogs)
end

-- If this function return true, the Quest will start.
-- self:hasMap() will check if this quest uses the map we are currently on.
-- See bellow how we add a map to the Quest
-- You should never assume that being on a map is enough to start a quest,
-- multiple quests can happen on the same map, always check something else at
-- the same time.
function Route1Quest:isDoable()
	if self:hasMap() then
		return true
	end
	return false
end

-- If you do not define this function, the Questing script will call the
-- default function from Quest.lua that simply returns: self:isDoable == false
-- Check it!
function Route1Quest:isDone()
	return getMapName() == "Viridian City"
end



function Route1Quest:Route1()
	if isNpcOnCell(6,7) then
		if not self.dialogs.headbutt.state then
		pushDialogAnswer(butter)
	log("---Headbutting 1st tree---")
		return talkToNpcOnCell(6,7)	--Tree 1
		else
			headbutt = headbutt + 1
		end
	elseif isNpcOnCell(19,5) then
		if not self.dialogs.headbutt.state then
		pushDialogAnswer(butter)
	log("---Headbutting 2nd tree---")
		return talkToNpcOnCell(19,5)	--Tree 2
		else
			headbutt = headbutt + 1
		end
	elseif isNpcOnCell(13,23) then
		if not self.dialogs.headbutt.state then
		pushDialogAnswer(butter)
	log("---Headbutting 3rd tree---")
		return talkToNpcOnCell(13,23)	--Tree 3
		else
			headbutt = headbutt + 1
		end
	elseif isNpcOnCell(17,23) then
		if not self.dialogs.headbutt.state then
		pushDialogAnswer(butter)
			log("---Headbutting 4th tree---")
		return talkToNpcOnCell(17,23)	--Tree 4
		else
			headbutt = headbutt + 1
		end
	elseif isNpcOnCell(14,28) then
		if not self.dialogs.headbutt.state then
		pushDialogAnswer(butter)
	log("---Headbutting 5th tree---")
		return talkToNpcOnCell(14,28)	--Tree 5
		else
			headbutt = headbutt + 1
		end
	elseif isNpcOnCell(17,35) then
		if not self.dialogs.headbutt.state then
		pushDialogAnswer(butter)
	log("---Headbutting 6th tree---")
		return talkToNpcOnCell(17,35)	--Tree 6
		else
			headbutt = headbutt + 1
		end
	elseif isNpcOnCell(9,37) then
		if not self.dialogs.headbutt.state then
		pushDialogAnswer(butter)
	log("---Headbutting 7th tree---")
		return talkToNpcOnCell(9,37)	--Tree 7
		else
			headbutt = headbutt + 1
		end
	elseif isNpcOnCell(28,43) then
		if not self.dialogs.headbutt.state then
		pushDialogAnswer(butter)
	log("---Headbutting Last tree---")
		return talkToNpcOnCell(28,43)	--Tree 8
		else
			headbutt = headbutt + 1
		end
	else
	log("---"..getMapName().." Cleared... Moving to next Map---")
		moveToMap("Viridian City")
	end
end

function Route1Quest:battle()
		return run() or sendAnyPokemon()
end

return Route1Quest

