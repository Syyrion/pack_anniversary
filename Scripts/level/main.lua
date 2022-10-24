u_execScript("babacommon.lua")
u_execScript("babapatterns.lua")
u_execScript("zcustomWallFractalRequirements.lua")
u_execScript("zimposterspecial.lua")
u_execScript("zimposterpatterns.lua")
u_execScript("sensepatterns.lua")
u_execScript("zxfuncs.lua")
u_execScript("customwalls.lua")

imposterWall = {}
imposterWall.__index = imposterWall
imposterWalls = {}
bgWall = {}
bgWall.__index = bgWall
bgWalls = {}

rbmult = 2.2
udelay = 1.15

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pAltBarrageS(5, 2, udelay)
	elseif mKey == 3 then pWallExVortexS(0, 1, 1, udelay)
	elseif mKey == 4 then pSBarrageSpiralLR(2, udelay)
	elseif mKey == 5 then pcBarrageWallLRS(math.random(1, 2), udelay)
	elseif mKey == 7 then pBarrageSpiralRandomS(math.random(4, 6), udelay)
	elseif mKey == 8 then pBackAndForth2S(math.random(2, 3), udelay)
	elseif mKey == 9 then pOddAltBarrageS(math.random(5, 7), udelay)
    elseif mKey ==  10 then pDoubleBarrageLeftRightS(math.random(3, 4), udelay)
    elseif mKey == 12 then pWallExVortexS(math.random(0, 1), 0, 1, udelay)
	end
end
keys = { 0, 0, 3, 3, 4, 4, 5, 5, 8, 9, 9, 10, 10, 12, 12 }
keys = shuffle(keys)
index = 0
achievementUnlocked = false
hardAchievementUnlocked = false


-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    
    if u_getDifficultyMult() == 1 then
        thespeed = 2.4
        l_setSpeedMult(2.4)
        l_setDelayMult(0.82)
    else
        thespeed = 3.3
        l_setSpeedMult(3.3)
        l_setDelayMult(0.78)
    end
    l_setSpeedInc(0.25)
    l_setSpeedMax(100)
    l_setRotationSpeed(-0.02)
    l_setRotationSpeedMax(1000)
   

    l_setRotationSpeedInc(0)
    
    l_setDelayInc(0.01)
    l_setFastSpin(5)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)

    l_setIncTime(1100)
	l_setRadiusMin(40)
	--l_setWallAngleLeft(-0.2)
	--l_setWallSkewLeft(0.2)
	l_setPulseMin(55)


end

l_addTracked("thespeed", "Speed")

function runincrements()
    e_waitS(10)
    e_eval([[
        t_waitS(1.5)
    ]])
    e_waitS(1.5)
    e_eval([[
        runincrements()
        l_setSpeedMult(l_getSpeedMult() + 0.3)
        l_setDelayMult(l_getDelayMult() + 0.03)
        thespeed = thespeed + 0.3
        ]])
end

function makedeco()
    --fractalCombination(mTimes, mSides, mSidewidthBase, mSidewidthThickness, mSideInc, mThickness, mDistanceStart, mDistanceInc, mRed, mGreen, mBlue, mAlpha, mCurve, mCurveStart, mCurveStartInc, mCurveSpeed)
    fractalCombination(2, 5, 0, 1 / 2, 0.5, 2000, 500, 4, 255, 255, 255, 0, 13, 0, 0, 0.01)
    fractalCombination(2, 10, 0, 1 / 4, 0.5, 2000, 300, 4, 255, 255, 255, 0, 13, 0, 0, 0.03)
    fractalCombination(2, 15, 0, 1 / 8, 0.5, 2000, 100, 4, 255, 255, 255, 0, 13, 0, 0, 0.05)
    fractalCurve(180, 2, 0.02, 0.58, 11, 130, 9, 255, 255, 255, 0, 1, 2, 3, -0.2)
end


-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
    makedeco()
    runincrements()
    a_overrideIncrementSound("silence.ogg")
    a_overrideBeepSound("silence.ogg")
end

-- onStep is an hardcoded function that is called when the level timeline is emptys
-- onStep should contain your pattern spawning logic
function onStep()
    addPattern(keys[index])
    index = index + 1

    if index - 1 == #keys then
        index = 1
        shuffle(keys)
    end

	
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- continuous direction change (even if not on level increment)

-- onUpdate is an hardcoded function that is called every frame

function onUpdate(mFrameTime)
    runCWs()
end
