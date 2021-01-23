local assert = assert
local tonumber = tonumber
local createElement = createElement
local setElementData = setElementData
local getElementData = getElementData
local isElement = isElement
local tinsert = table.insert

local spawnpointTable = {}

function createSpawnpoint(x, y, z, rot, skin, interior, dimension, team)
	assert(tonumber(x), 'createSpawnpoint: Bad [x] position specified')
	assert(tonumber(y), 'createSpawnpoint: Bad [y] position specified')
	assert(tonumber(z), 'createSpawnpoint: Bad [z] position specified')

	rot = rot or 0
	skin = skin or 0
	interior = interior or 0
	dimension = dimension or 0

	local spawnElement = createElement('spawnpoint')
	if not spawnElement then
		return false
	end

	tinsert(spawnpointTable, spawnElement)

	setElementData(spawnElement, 'position', { x, y, z }, false)
	setElementData(spawnElement, 'rot', rot, false)
	setElementData(spawnElement, 'skin', skin, false)
	setElementData(spawnElement, 'interior', interior, false)
	setElementData(spawnElement, 'dimension', dimension, false)
	setElementData(spawnElement, 'team', team, false)

	return spawnElement
end

function getRandomSpawnpoint()
	return spawnpointTable[math.random(1, #spawnpointTable)]
end

function getRandomPositionInRange(corner, offset) -- Vector2(positionX, positionY), Vector2(math.random(radiusX), math.random(radiusY))
	return corner + offset
end

function playerAtSpawnpoint(thePlayer, spawnElement, rot, skin, dimension, theTeam)
	assert(isElement(spawnElement), 'spawnPlayerAtSpawnpoint: Invalid variable specified as spawnElement.')
	assert(isElement(thePlayer), 'spawnPlayerAtSpawnpoint: Invalid variable specified as player.')

	local position, interior = getElementData(spawnElement, 'position'), getElementData(spawnElement, 'interior')

	rot = rot or getElementData(spawnElement, 'rot')
	skin = skin or getElementData(spawnElement, 'skin')
	dimension = dimension or getElementData(spawnElement, 'dimension')

	theTeam = theTeam or getElementData(spawnElement, 'team')
	if type(team) == 'string' then
		theTeam = getTeamFromName(theTeam)
	end

	local rangeInPosition = getRandomPositionInRange(
		Vector2(position[1], position[2]),
		Vector2(math.random(0, 20), math.random(0, 20))
	)

	local isPlayerSpawned = spawnPlayer(thePlayer, rangeInPosition.x, rangeInPosition.y, position[3] + 1, rot, skin, interior, dimension, theTeam)
	if not isPlayerSpawned then
		return false
	end

	setCameraTarget(thePlayer, thePlayer)
	fadeCamera(thePlayer, false)
	fadeCamera(thePlayer, true)

	return thePlayer
end
