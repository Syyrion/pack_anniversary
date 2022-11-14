-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- cWallEx: creates a wall with mExtra walls attached to it
function cWallEx(mSide, mExtra)
    cWall(mSide)
    local exLoopDir = 1

    if mExtra < 0 then exLoopDir = -1 end
    for i = 0, mExtra, exLoopDir do cWall(mSide + i) end
end

function pRandomBarrageLR(mTimes, mStep, delay)
    local delay = delay or getPerfectDelay(THICKNESS) * 7
    local side = math.random(0, l_getSides())
    local mStep = mStep or 1
    local loopDir = mStep * getRandomDir()
    local j = 0

    for i = 0, mTimes do
        barrage(side + j)
        local loopDir = mStep * getRandomDir()
        j = j + loopDir
        t_wait(delay)
    end
    t_wait(delay * 0.7)
end

function pLRBarrage(mTimes, delay)
    local side = math.random(0, l_getSides())
    local delay = delay or getPerfectDelay(THICKNESS) * 6

    for i = 0, mTimes do
        barrage(side)
        t_wait(delay)
        w_wall(side + l_getSides() - 1, THICKNESS)
        t_wait(delay)
    end
    t_wait(delay * 0.85)
end

function pLRBarrage2(mTimes, delay)
    local side = math.random(0, l_getSides())
    local delay = delay or getPerfectDelay(THICKNESS) * 6

    if math.random(0, 1) == 0 then
        for i = 0, mTimes do
            barrage(side)
            t_wait(delay)
            barrage(side + 1)
            t_wait(delay)
        end
    else
        for i = 0, mTimes do
            barrage(side + 1)
            t_wait(delay)
            barrage(side)
            t_wait(delay)
        end
    end
    t_wait(delay)
end

function pRandomBarrageEdited(mTimes, mDelayMult)
    local side = getRandomSide()
    local oldSide = 0

    for i = 0, mTimes do
        cBarrage(side)
        oldSide = side
        side = getRandomSide()
        t_wait(getPerfectDelay(THICKNESS) * (2 + (getSideDistance(side, oldSide) * mDelayMult)))
    end

    t_wait(getPerfectDelay(THICKNESS) * 6.6)
end

function pAltBarrageEdited(mTimes, mStep, mDelayMult)
    mDelayMult = mDelayMult or 1
    local delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult

    for i = 1, mTimes do
        cAltBarrage(i, mStep)
        t_wait(delay * l_getSpeedMult() / 3.2)
    end

    t_wait(delay * l_getSpeedMult() / 3.8)
end

function barrage(side)
    for i = 0, l_getSides() - 2 do
        w_wall(side + i, THICKNESS)
    end
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
    if mKey == 0 then pAltBarrageEdited(math.random(3, 5), 2)
    elseif mKey == 1 then pLRBarrage(math.random(1, 2), 15)
    elseif mKey == 2 then pLRBarrage2(math.random(1, 2))
    elseif mKey == 3 then pRandomBarrageEdited(math.random(3, 6), 4.3)
    elseif mKey == 4 then pRandomBarrageLR(math.random(2, 3), 2, 23)
    elseif mKey == 5 then pRandomBarrageLR(math.random(3, 5))
    end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 1, 2, 3, 4, 5 }
shuffle(keys)
index = 0
achievementUnlocked = false
hardAchievementUnlocked = false

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    diff = simplifyFloat(u_getDifficultyMult(), 3)
    if diff == 1.000 then
        l_setRotationSpeed(0.2)
        l_setSpeedMult(3.1)
        difficultyTrackedName = "Normal"
        l_addTracked("difficultyTrackedName", "Difficulty")
    elseif diff == 1.001 then
        l_setRotationSpeed(0.5)
        l_setSpeedMult(4)
        s_set3dSkew(0.16)
        difficultyTrackedName = "Hard"
        l_addTracked("difficultyTrackedName", "Difficulty")
    end

    -- l_setSpeedMult(3)
    l_setSpeedInc(0.14)
    l_setSpeedMax(4.9)
    -- l_setRotationSpeed(0.2)
    l_setRotationSpeedMax(5)
    l_setRotationSpeedInc(0.07)
    l_setDelayMult(1.0)
    l_setDelayInc(0)
    l_setFastSpin(50.0)
    l_setSides(5)
    l_setSidesMin(5)
    l_setSidesMax(5)
    l_setIncTime(12)
    l_setDarkenUnevenBackgroundChunk(false)

    l_setPulseMin(35)
    l_setPulseMax(51)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(1.5)
    l_setPulseDelayMax(24.9)

    l_setBeatPulseMax(23)
    l_setBeatPulseDelayMax(14.8)

    l_setRadiusMin(60)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
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

currentIncrements = 0
time = 20
dirChangeTime = math.random(10, 50)

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
    time = time - mFrameTime;
    if time < 0 then
        s_setHueIncrement(math.random(1, 10))
        s_set3dSpacing(math.random(-3, 20))
        time = 10
        s_set3dDepth(math.random(1, 30))
        s_setBGTileRadius(math.random(-1600, 1600))
    end

    if l_getCurrentIncrements() ~= currentIncrements then
        currentIncrements = l_getCurrentIncrements()

        s_set3dSkew(s_get3dSkew() + 0.01)
    end

    dirChangeTime = dirChangeTime - mFrameTime;
    if dirChangeTime < 0 and u_isFastSpinning() == false then
        l_setRotationSpeed(l_getRotationSpeed() * -1.0)
        dirChangeTime = math.random(10, 50)
    end

end
