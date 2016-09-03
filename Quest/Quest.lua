-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys  = require "Libs/syslib"
local game = require "Libs/gamelib"


local Quest = {}

function Quest:new(name, description, level, dialogs)
	local o = {}
	setmetatable(o, self)
	self.__index     = self
	o.name        = name
	o.description = description
	o.dialogs     = dialogs
	return o
end

function Quest:isDoable()
	sys.error("Quest:isDoable", "function is not overloaded in quest: " .. self.name)
	return nil
end

function Quest:isDone()
	return self:isDoable() == false
end

function Quest:mapToFunction()
	local mapName = getMapName()
	local mapFunction = sys.removeCharacter(mapName, ' ')
	mapFunction = sys.removeCharacter(mapFunction, '.')
	return mapFunction
end

function Quest:hasMap()
	local mapFunction = self:mapToFunction()
	if self[mapFunction] then
		return true
	end
	return false
end

function Quest:pokecenter(exitMapName) -- idealy make it work without exitMapName
	self.registeredPokecenter = getMapName()
	sys.todo("add a moveDown() or moveToNearestLink() or getLinks() to PROShine")
	if not game.isTeamFullyHealed() then
		return usePokecenter()
	end
	return moveToMap(exitMapName)
end

-- at a point in the game we'll always need to buy the same things
-- use this function then

function Quest:needPokecenter()
	if getTeamSize() == 1 then
		if getPokemonHealthPercent(1) <= 50 then
			return true
		end
	-- else we would spend more time evolving the higher level ones
	elseif not self:isTrainingOver() then
		if getUsablePokemonCount() <= 1
			or game.getUsablePokemonCountUnderLevel(self.level) == 0
		then
			return true
		end
	else
		if not game.isTeamFullyHealed() then
			if self.healPokemonOnceTrainingIsOver then
				return true
			end
		else
			-- the team is healed and we do not need training
			self.healPokemonOnceTrainingIsOver = false
		end
	end
	return false
end

function Quest:message()
	return self.name .. ': ' .. self.description
end


function Quest:path()
	if self.inBattle then
		self.inBattle = false
		self:battleEnd()
	end
	if self:evolvePokemon() then
		return true
	end
	if not isTeamSortedByLevelAscending() then
		return sortTeamByLevelAscending()
	end
	if self:leftovers() then
		return true
	end
	local mapFunction = self:mapToFunction()
	assert(self[mapFunction] ~= nil, self.name .. " quest has no method for map: " .. getMapName())
	self[mapFunction](self)
end



function Quest:battleBegin()
	self.canRun = true
end

function Quest:battleEnd()
	self.canRun = true
end
function IsPokemonOnCaptureList()
	result = false
	if toCatch[1] ~= "" then
	for i = 1, TableLength(toCatch), 1 do
		if getOpponentName() == toCatch[i] then
			result = true
			break
		end
	end
	end
	return result
end
function TableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function Quest:wildBattle()
	if isOpponentShiny() then
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return true
		end
	elseif not isAlreadyCaught() then
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return true
		end
	elseif isPokemonOnCaptureList() then
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return true
		end
	end
	
	
end


function Quest:battle()
	if not self.inBattle then
		self.inBattle = true
		self:battleBegin()
	end
	if isWildBattle() then
		return self:wildBattle()
	else
		return self:trainerBattle()
	end
end

function Quest:dialog(message)
	if self.dialogs == nil then
		return false
	end
	for _, dialog in pairs(self.dialogs) do
		if dialog:messageMatch(message) then
			dialog.state = true
			return true
		end
	end
	return false
end

function Quest:battleMessage(message)
	if sys.stringContains(message, "You can not run away!") then
		sys.canRun = false
	
	end
	return false
end

function Quest:systemMessage(message)
	return false
end


return Quest
