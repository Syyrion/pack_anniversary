-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")
u_execScript("zimposterpatterns.lua")

-- our wall
imposterWall = {}
imposterWall.__index = imposterWall
-- list of all walls
imposterWalls = {}

-- functions and walls and patterns and dungeons and dragons and drivers and other shit below
-- constructions: functions used to make patterns
-- imposter walls look like normal walls but can be manipulated

function imposterWall:new(handle)
	local obj = {}
	setmetatable(obj, imposterWall)
	-- Our handle, our name, our identifier
	obj.cwHandle = handle
	-- There are only 2 things certain in life, death and taxes
	obj.dead = false
	return obj
end

function imposterWall:move(mFrameTime)
	local range = 2 * math.pi / self.shape
	
	-- move it move it
	self.distance = math.max(self.distance - (mFrameTime * self.speed), 0)
	-- babe you're in the shape, time to die
	if math.floor(self.distance) < 1 then self.dead = true end
	
	r1 = self.distance
	r2 = self.distance + self.thickness
	a1 = (self.side + 0.5) * range
	a2 = (self.side - 0.5) * range
	
	cw_setVertexPos(self.cwHandle, 0, r1 * math.cos(a1), r1 * math.sin(a1))
	cw_setVertexPos(self.cwHandle, 1, r1 * math.cos(a2), r1 * math.sin(a2))
	cw_setVertexPos(self.cwHandle, 2, r2 * math.cos(a2), r2 * math.sin(a2))
	cw_setVertexPos(self.cwHandle, 3, r2 * math.cos(a1), r2 * math.sin(a1))
end

-- side is side, distance how far away the wall is, speed how much distance to reduce per frame times mframetime, thickness is thickness, shape is the shape to use for wall vertex calculations, and the last 4 are colors
function wImpWall(mSide, mDistance, mSpeed, mThickness, mShape, mRed, mGreen, mBlue, mAlpha)
	cwHandle = cw_create()
	cw_setVertexColor(cwHandle, 0, mRed, mGreen, mBlue, mAlpha)
	cw_setVertexColor(cwHandle, 1, mRed, mGreen, mBlue, mAlpha)
	cw_setVertexColor(cwHandle, 2, mRed, mGreen, mBlue, mAlpha)
	cw_setVertexColor(cwHandle, 3, mRed, mGreen, mBlue, mAlpha)
	cw_setVertexPos(cwHandle, 0, 0, 0)
	cw_setVertexPos(cwHandle, 1, 0, 0)
	cw_setVertexPos(cwHandle, 2, 0, 0)
	cw_setVertexPos(cwHandle, 3, 0, 0)
	
	
	
	iw = imposterWall:new(cwHandle)
	-- set up The Shit™
	iw.distance = mDistance
	iw.speed = mSpeed
	iw.side = mSide
	iw.shape = mShape
	iw.thickness = mThickness
	table.insert(imposterWalls, iw)
end

-- common stuff like cImpWall and patterns in imposterpatterns.lua

-- ACTUAL LEVEL BELOW

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey == 0 then pImpAltBarrage(0, 2)
	elseif mKey == 1 then pImpRandomBarrage(0, 2.5) 
	elseif mKey == 2 then
	elseif mKey == 3 then 
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = {  }
keys = shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(1)
	l_setSpeedInc(0.045)
	l_setSpeedMax(2.35);
	l_setRotationSpeed(0.17)
	l_setRotationSpeedMax(0.45)
	l_setRotationSpeedInc(0.045)
	l_setDelayMult(1.8)
	l_setDelayInc(-0.01)
	l_setDelayMin(1.07)
	l_setFastSpin(71.0)
	l_setSides(6)
	l_setSidesMin(6)
	l_setSidesMax(6)
	l_setIncTime(15)
	
	-- debug! only use for testing wall spawns
	--l_setPulseMin(20)
	--l_setRadiusMin(20)
	
	l_setIncEnabled(false)
end



-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	l_setRotationSpeed(l_getRotationSpeed() * getRandomDir())
	--cssImpWall(0)
	pImpRandomBarrage(0, 2.5) 
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	addPattern(keys[index])
	index = index + 1

	if index - 1 == #keys then
		index = 1
		keys = shuffle(keys)
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	-- remove dead walls (walls whose distance is 0)
	ArrayRemove(imposterWalls, function(t, i, j)
		local v = t[i]
		if v.dead then
			cw_destroy(v.cwHandle)
			return true
		else
			return false
		end
	end);
	
	-- Loop through all imposter walls to handle their movement
	for _, iw in ipairs(imposterWalls) do
		iw:move(mFrameTime)
	end
end