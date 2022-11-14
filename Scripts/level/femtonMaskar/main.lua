-- include useful files because we dont have anything better to do
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execScript("level/femtonMaskar/shadereffects.lua")

-- yay
imposterWall = {}
imposterWall.__index = imposterWall
imposterWalls = {}
bgWall = {}
bgWall.__index = bgWall
bgWalls = {}

u_execScript("level/femtonMaskar/customwalls.lua")

-- begin patterns

function pRandomBarrage(mTimes, mDelay)
    side = getRandomSide()
    oldSide = 0
    local fastflip = false

    for i = 0, mTimes do
        cBarrage(side)
        oldSide = side
        side = getRandomSide()
        if side == oldSide then side = side + 1 end
        if (l_getSides() < 5 and math.random(0, 2) == 0 and i ~= mTimes and fastflip == false and u_getDifficultyMult() == 3.0
            ) then
            t_wait((fpb / 2) * mDelay * u_getDelayMultDM()) --brutal!!!
            fastflip = true
        else t_wait(fpb * mDelay * u_getDelayMultDM())
        end
    end
end

function cSwapBarrageN(mSide, mNeighbors, mDelayMult)
    mDelayMult = mDelayMult or 1
    local myThickness = getPerfectThickness(THICKNESS) * 2.0 * mDelayMult
    local delay = getPerfectDelay(myThickness - THICKNESS) / u_getDelayMultDM()
    cBarrageN(mSide, mNeighbors + 1) -- Create the initial barrage
    w_wall(mSide + 1 + mNeighbors, myThickness)
    w_wall(mSide + l_getSides() - 1 - mNeighbors, myThickness)
    t_wait(delay)
    if l_getSides() == 5 then cWall(mSide)
    else cBarrage(mSide + getHalfSides())
    end
    t_wait(fpb * u_getDelayMultDM())
end

function cChangeBarrage(mSide, mDelayMult)
    mDelayMult = mDelayMult or 1
    dir = getRandomDir()
    local myThickness = getPerfectThickness(THICKNESS) * 2.0 * mDelayMult
    local delay = getPerfectDelay(myThickness - THICKNESS) / u_getDelayMultDM()
    w_wall(mSide, myThickness)
    w_wall(mSide + dir, THICKNESS)
    t_wait(delay)
    w_wall(mSide - dir, THICKNESS)
    t_wait(fpb * u_getDelayMultDM())
end

function pChangeSwapBarrage(mDelayMult)
    side = getRandomSide()
    dir = getRandomDir()
    local myThickness = getPerfectThickness(THICKNESS) * 2.5 * mDelayMult
    local delay = getPerfectDelay(myThickness - THICKNESS) / u_getDelayMultDM()

    w_wall(side + dir, myThickness)
    w_wall(side - dir, myThickness)
    cBarrage(side)
    t_wait(delay)
    if l_getSides() == 6 then cBarrage(side + getHalfSides() + dir)
    elseif l_getSides() == 5 then cBarrage(side + 2 + ((dir + 2) / 2))
    elseif l_getSides() == 4 then cBarrage(side + getHalfSides())
    end
    t_wait(fpb * u_getDelayMultDM())
end

function pHalfBarrageSpiral(mTimes, mDelay)
    side = getRandomSide()
    dir = getRandomDir()

    for i = 0, mTimes do
        cWall(side)
        if l_getSides() == 4 then cWall(side + dir) end
        side = side + dir
        t_wait((fpb / 3) * mDelay * u_getDelayMultDM())
    end
    if l_getSides() == 4 then side = side + dir end
    cWall(side)
    cWall(side + dir)
    t_wait(fpb * mDelay * u_getDelayMultDM())
end

--end patterns

if u_getDifficultyMult() == 1.0 then delaytime = 1.25
elseif u_getDifficultyMult() == 2.0 then delaytime = 1.0
elseif u_getDifficultyMult() == 3.0 then delaytime = 0.8
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
    if mKey == 0 then pRandomBarrage(2, 4)
    elseif mKey == 1 then pRandomBarrage(math.random(2, 3), 1)
    elseif mKey == 2 then t_wait(fpb)
    elseif mKey == 3 then
        if (l_getSides() < 4) then
            cChangeBarrage(getRandomSide(), delaytime)
        else
            cSwapBarrageN(getRandomSide(), 0, delaytime)
        end
    elseif mKey == 4 then
        if (l_getSides() < 4) then
            pHalfBarrageSpiral(3, 1.475)
        elseif (l_getSides() < 5) then
            pHalfBarrageSpiral(3, 1.3)
        else
            pChangeSwapBarrage(delaytime)
        end
    end
end

keys = { 2, 0, 1, 3 }
newKeys = { 1, 4, 3 } --patterns can be called when the level repeats
index = 0
rawspb = 60 / 140
rawfpb = 3600 / 140
if (u_getDifficultyMult() == 2.0) then fpb = (3600 / (140 * 1.0625))
elseif (u_getDifficultyMult() == 3.0) then fpb = (3600 / (140 * 1.125))
else fpb = (3600 / 140) end
gradientShaderId = shdr_getShaderId("femtonMaskar.frag")
repeating = 0

vShift = 100.0
hShift = 0.0
shdrColor = { 0.0, 0.0, 1.0, 1.0 }
shdrPulseColor = { 0.0, 0.0, 0.0, 0.0 }
shdrMode = 2
shdrRandom = 100

timelineBGUnused = ct_create()
timelineBGPulse = ct_create()
timelineBGPulseControl = ct_create()
timelineBGFlash = ct_create()
timelineBGDiamonds = ct_create()
timelineBGDiamondsPulse = ct_create()

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.0)
    l_setSpeedInc(0.4)
    l_setSpeedMax(5.2)
    l_setPlayerSpeedMult(1.0)
    l_setRotationSpeed(0.07)
    l_setRotationSpeedMax(1.0)
    l_setRotationSpeedInc(0.05 + (u_getDifficultyMult() / 50))
    l_setDelayMult(1.0)
    l_setDelayInc(0.0)
    l_setFastSpin(3.0)
    l_setSides(6)
    l_setSidesMin(3)
    l_setSidesMax(6)
    if (u_getDifficultyMult() == 1.0) then l_setIncTime((fpb / 60) * 39)
    else l_setIncTime((fpb / 60) * 23) end
    l_setPulseMin(100)
    l_setPulseMax(100)
    l_setPulseSpeed(4)
    l_setPulseSpeedR(2)
    l_setPulseDelayMax(10 + (5 / 7)) --the "banging my head against the wall" method
    l_setBeatPulseMax(14)
    l_setSwapEnabled(false)
    l_setSwapCooldownMult(0.4)
    l_setBeatPulseDelayMax(rawfpb)
    l_setWallSpawnDistance(1300)
    a_overrideSwapSound("flip.ogg")
    a_syncMusicToDM(false)
    a_setMusicPitch(1 + ((u_getDifficultyMult() - 1) / 16))

    --shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS, gradientShaderId)
    shdr_setActiveFragmentShader(0, gradientShaderId)
    l_setDarkenUnevenBackgroundChunk(false)
    l_setRadiusMin(110)
    s_setMaxSwapTime(rawfpb * 2)
    s_setBGTileRadius(2300)
end

-- function onRenderStage(rs)
-- end

function timelineControl()
    ct_eval(timelineBGPulseControl, string.format("shdrVShiftPulse(1, 1)"))
    ct_wait(timelineBGPulseControl, fpb)
    ct_eval(timelineBGPulseControl, string.format("shdrVShiftPulse(1, -1)"))
    ct_wait(timelineBGPulseControl, fpb)
    ct_eval(timelineBGPulseControl, "timelineControl()")
end

-- `onLoad` is an hardcoded function that is called when the level is started
-- or restarted.
function onLoad()
    if u_getDifficultyMult() ~= 1.0 then
        a_setMusicSeconds("femtonMaskarIDodMansDreadlock", rawspb * 48)
        ct_eval(timelineBGPulseControl, string.format("s_setPulseInc(%f)", 1))
        ct_wait(timelineBGPulseControl, 1)
    else
        ct_eval(timelineBGPulseControl, string.format("s_setPulseInc(%f)", 1 / (fpb * 28)))
        ct_eval(timelineBGPulseControl, string.format("s_setBGColorOffset(7)"))
        ct_wait(timelineBGPulseControl, fpb * 14)
        ct_eval(timelineBGPulseControl, string.format("s_setPulseInc(%f)", 1 / (fpb * 4)))
        ct_wait(timelineBGPulseControl, fpb)
        ct_eval(timelineBGPulseControl, string.format("l_setSwapEnabled(true)"))
        ct_wait(timelineBGPulseControl, fpb)
    end
    ct_eval(timelineBGPulseControl, string.format("l_setSwapEnabled(true)"))
    ct_eval(timelineBGPulseControl, string.format("s_setBGColorOffset(7)"))
    ct_eval(timelineBGPulseControl, string.format("shdrMode = 0"))
    ct_eval(timelineBGPulseControl, string.format("shdrColorPulse(0.5, 1.0, 1.0, 1.0, 1.0)"))
    ct_eval(timelineBGPulseControl, string.format("s_setPulseInc(%f)", 0))
    ct_eval(timelineBGPulseControl, string.format("l_setPulseMin(%f)", 80))
    for i = 0, 27 do
        ct_eval(timelineBGPulseControl, string.format("shdrVShiftPulse(1, 1)"))
        ct_wait(timelineBGPulseControl, fpb)
        ct_eval(timelineBGPulseControl, string.format("shdrVShiftPulse(1, -1)"))
        ct_wait(timelineBGPulseControl, fpb)
    end
    ct_eval(timelineBGPulseControl, string.format("shdrColorPulse(0.5, 0.2, 0.0, 0.4, 1.0)"))
    ct_eval(timelineBGPulseControl, string.format("shdrColorSet(0.5, 0.4, 0.0, 1.0, 1.0)"))
    for i = 0, 18 do
        ct_eval(timelineBGPulseControl, string.format("shdrVShiftPulse(1, 1)"))
        ct_wait(timelineBGPulseControl, fpb)
        ct_eval(timelineBGPulseControl, string.format("shdrVShiftPulse(1, -1)"))
        ct_wait(timelineBGPulseControl, fpb)
    end
    ct_wait(timelineBGPulseControl, fpb * 1.75)
    ct_eval(timelineBGPulseControl, string.format("bgBlackBoxplosion(100, 1)"))
    ct_wait(timelineBGPulseControl, fpb * 0.25)
    ct_eval(timelineBGPulseControl, string.format("shdrMode = 1"))
    ct_eval(timelineBGPulseControl, string.format("shdrColorPulse(0.5, 1.0, 1.0, 1.0, 1.0)"))
    ct_eval(timelineBGPulseControl, string.format("s_setBGColorOffset(0)"))
    ct_eval(timelineBGPulseControl, string.format("bgBlackBoxes(3, 1)"))
    ct_wait(timelineBGPulseControl, fpb * 64)
    ct_eval(timelineBGPulseControl, string.format("shdrMode = 0"))
    ct_eval(timelineBGPulseControl, string.format("s_setPulseInc(%f)", -1 / (fpb * 4)))
    ct_eval(timelineBGPulseControl, string.format("shdrColorPulse(0.5, 0.5, 0.5, 0.5, 1.0)"))
    ct_eval(timelineBGPulseControl, string.format("shdrVShiftPulse(1, 1)"))
    ct_wait(timelineBGPulseControl, fpb)
    ct_eval(timelineBGPulseControl, string.format("shdrVShiftPulse(1, -1)"))
    ct_wait(timelineBGPulseControl, fpb)
    ct_eval(timelineBGPulseControl, string.format("s_setPulseInc(%f)", 0))
    ct_eval(timelineBGPulseControl, "timelineControl()")
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
    if u_getDifficultyMult() ~= 1.0 then keys = newKeys end
    addPattern(keys[index])
    index = index + 1

    if index - 1 == #keys then
        keys = newKeys
        index = 1
        shuffle(keys)
    end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
    if repeating == 0 then l_setIncTime((fpb / 60) * 32)
    elseif repeating == 1 then l_setIncTime((fpb / 60) * 40)
    elseif repeating == 2 then l_setIncTime((fpb / 60) * 32)
    end
    repeating = repeating + 1
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
    hShift = (hShift + 0.4) % u_getWidth()
    shdrRandom = math.random(u_getWidth() * u_getHeight(), u_getWidth() * u_getHeight() * 100)
    shdr_setUniformFVec2(gradientShaderId, "u_resolution", u_getWidth(), u_getHeight());
    shdr_setUniformFVec2(gradientShaderId, "u_shift", hShift, vShift);
    shdr_setUniformFVec4(gradientShaderId, "u_color", shdrColor[1], shdrColor[2], shdrColor[3], shdrColor[4]);
    shdr_setUniformFVec4(gradientShaderId, "u_pulsecolor", shdrPulseColor[1], shdrPulseColor[2], shdrPulseColor[3],
        shdrPulseColor[4]);
    shdr_setUniformF(gradientShaderId, "u_random", shdrRandom);
    shdr_setUniformI(gradientShaderId, "u_mode", shdrMode);

    ArrayRemoveIf(bgWalls, function(t, i, j)
        local v = t[i]
        if v.dead then
            cw_destroy(v.cwHandle)
            return true
        else
            return false
        end
    end);

    -- Loop through all bg walls to handle their movement
    for _, iw in ipairs(bgWalls) do
        iw:eminate(mFrameTime)
        iw:fade(0.8)
        iw:unrotate(mFrameTime)
    end
end
