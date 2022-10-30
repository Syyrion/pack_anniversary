MAIN_PATH = "level/fsor/"

u_execScript(MAIN_PATH .. "Anything/BasicPatterns.lua")
u_execScript(MAIN_PATH .. "Anything/SupportFunctions.lua")
u_execScript(MAIN_PATH .. "Anything/StandartPatterns.lua")
u_execScript(MAIN_PATH .. "Everything/FSoR stuff.lua")
u_execScript(MAIN_PATH .. "Everything/FSoR patterns.lua")
u_execScript(MAIN_PATH .. "Everything/FSoR diffs.lua")

allowPreDelay = 0

minDelayOneSide = 1
minDelayTwoSides = 1.575
minDelayThreeSides = 1.9

thickness = 60 -- global variable

-- a specific delay for each type of patterns based on the chosen min delay
function x1() return minDelayOneSide * getCommonDelayMult() * 1.1 end
function x3() return minDelayThreeSides * getCommonDelayMult() * 1.1 end

function delayPreStd() 
	return halfSidesMinDelay() * l_getDelayMult() * allowPreDelay
end

function addPattern(mKey)
	-- pattern(/"main delay"/, "pre pattern delay", "amount of walls {min, max}", "mode")
	if     mKey == 0 then oneOpenSide(x1(), delayPreStd(), {3, 6}, 0) -- one direction
	elseif mKey == 1 then oneOpenSide(x1(), delayPreStd() * 1.05, {4, 6}, 2) -- changing direction in the middle
	elseif mKey == 2 then oneOpenSide(x3(), delayPreStd() * 1.05, {2, 3}, 4) -- inverted
	elseif mKey == 3 then oneOpenSide(x1(), delayPreStd(), {4, 7}, 5) -- left right

	elseif mKey == 11 then twoOpenSides(x1(), delayPreStd(), {2, 3}, 1) -- changing direction in the middle {2, 3}
	
	elseif mKey == 20 then altBarrage(x1(), delayPreStd(), {3, 5})
	
	elseif mKey == 21 then separateWalls(delayPreStd() * 0.85, {2, 4}, 0) -- inverted, two closed
	elseif mKey == 22 then separateWalls(delayPreStd() * 0.95, {2, 4}, 1) -- inverted, two opened
	elseif mKey == 23 then separateWalls(delayPreStd() * 0.85, {2, 4}, 2) -- alt
	elseif mKey == 24 then separateWalls(delayPreStd(), {1, 3}, 3) -- one open
	end
end

if getRoundedDifficulty3() < 1.002 then
	keys = { 0, 0, 1, 1, 2, 2, 3, 11, 11, 20, 20, 21, 22, 23, 24 }
else
	keys = { 0, 0, 1, 1, 3, 11, 11, 20, 20, 21, 22, 23, 24 }
end

shuffle(keys)
index = 0

function onInit()
	setDiffParams(getRoundedDifficulty3())
	if u_getDifficultyMult() ~= 1 then l_addTracked("DIFF_NAME", "Diff") end

	speedR, speed = getBpmPulses(20, 146 / 16 * 2, 6)
	speedBuild = getSpeedForWallAccs()

	-- speed					-- rotation						-- delay
	l_setSpeedMult(speedBuild)	l_setRotationSpeed(-0.1) 		l_setDelayMult(INTRO_DELAY)
	l_setSpeedInc(0.65)			l_setRotationSpeedInc(0.1)		l_setDelayInc(0)
	
	-- sides					-- pattern pulse				-- beatpulse
	l_setSides(6)				l_setPulseMin(70)				l_setBeatPulseMax(10)
	l_setSidesMin(6)			l_setPulseMax(90)				l_setBeatPulseDelayMax(0)
	l_setSidesMax(6)			l_setPulseSpeed(speed)			l_setBeatPulseSpeedMult(0)
	l_setIncTime(9999)			l_setPulseSpeedR(speedR)
								l_setPulseDelayMax(0)
								
	-- random
	l_setFastSpin(80)
	l_setCameraShake(0)
	coreLevelSettings()

	l_setManualBeatPulseControl(true)
end

function onLoad()
	s_setStyle("FSoR")
	
	for i = 0, 19 do
		createBlackSquare(0, 1200, i * 18, i * 18 + 18)	
	end

	-- create first cover stuff
	l_setWallAngleRight(0.07)
	l_setWallAngleLeft(0.07)

	l_setWallSkewLeft(-25)
	l_setWallSkewRight(-25)
	l_setSides(60)

	createCoverStuff()

	-- return back settings for usual walls
	e_waitUntilS(0.1015)
	e_eval([[l_setWallAngleRight(0)]])
	e_eval([[l_setWallAngleLeft(0)]])
	e_eval([[l_setWallSkewRight(10)]])
	e_eval([[l_setWallSkewLeft(0)]])
	e_eval([[l_setSpeedMult(INTRO_SPEED)]])
	e_eval([[l_setSides(6)]])
	e_eval([[l_setWallSpawnDistance(1600 / 3 * INTRO_SPEED)]])
end

function onStep()
	if patternsEnabled == true then
		addPattern(keys[index])
		index = index + 1

		if index - 1 == #keys then
			index = 1
			shuffle(keys)
		end
	end
end

function onIncrement()
end

function onUnload()
end

function onUpdate(mFrameTime)
	timersAndStuff()
end
