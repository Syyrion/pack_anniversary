-- Include useful files or existing libraries. These are found in the `Scripts`
-- folder.
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execScript("level/mpp/commonpatternsv2.lua")
u_execScript("level/mpp/expatterns.lua")
u_execScript("level/mpp/hxdshexpatterns.lua")
l_setShadersRequired(true)
a_syncMusicToDM(false)
loopcount = 1
nextLoop = 0.35
-- This function adds a pattern to the level "timeline" based on a numeric key.
function addPattern(mKey)
    --hex patterns from Hexadorsip
    if mKey == 0 then pAltBarrage(math.random(3, 5), 2)
    elseif mKey == 1 then pAltBarrageThick(0, 2)
    elseif mKey == 2 then pBarrageSpiralLeft(math.random(2, 3), 0.85, 1)
    elseif mKey == 3 then pBackAndForth2(math.random(3, 4), 0.83)
    elseif mKey == 4 then pBarrageSpiralDouble(math.random(1, 2), 0.96, 1)
    elseif mKey == 5 then pDMInverseBarrage(math.random(1, 2), 1.36)
    elseif mKey == 6 then pMirrorWallStrip(1, 0)
    elseif mKey == 7 then pMirrorWallStripThick(0, 1)
    elseif mKey == 8 then pRandomBarrage(math.random(2, 5), 3.2)
    elseif mKey == 9 then pTunnel(math.random(1, 2))
    elseif mKey == 10 then pTunnelQuadruple(math.random(3, 4), 0.84)
    elseif mKey == 11 then pWallExVortexLL(0, 3, 1)
    elseif mKey == 12 then pBarrageSpiralLR(math.random(2, 3), 1)
    elseif mKey == 13 then pAltBarrageStrip(1, 0)
    elseif mKey == 14 then pBat(0.5)
    end
end

beatCount = 0
-- Shuffle the keys, and then call them to add all the patterns.
-- Shuffling is better than randomizing - it guarantees all the patterns will
-- be called.
keys = { 0, 0, 1, 2, 3, 3, 4, 5, 5, 6, 7, 8, 8, 11, 12, 12, 13, 14 }
shuffle(keys)
index = 0
dys = true
FFrames = 0
BPM = 160
notSkew = 2
notRotation = 0.0
rinc = 0
pshift = 0
dec1 = -1
dec2 = -1
dec3 = -1
difficultyName = "not loaded"
local scanning = 0
function roundThousand(mFloat)
    return math.floor(mFloat * 1000 + 0.1)
end

speedd = roundThousand(l_getSpeedMult())
l_addTracked("speedd", "speed")
l_addTracked("notRotation", "rotation")
l_addTracked("pshift", "shift")
l_addTracked("difficultyName", "difficulty")

--same wall + THICKNESS (created by Exschwasion)
function rWallThick(mSide, THICKNESS)
    w_wall(mSide, THICKNESS)
    w_wall(mSide + getHalfSides(), THICKNESS)
end

--same wall + mThick (created by Exschwasion)
function cWallExThick(mSide, mExtra, mThick)
    w_wall(mSide, mThick);
    loopDir = 1;

    if mExtra < 0 then loopDir = -1 end
    for i = 0, mExtra, loopDir do w_wall(mSide + i, mThick) end
end

--same wall + mThick
function cBarrageThick(mSide, mThick) cBarrageNThick(mSide, 0, mThick) end

--same wall + mThick
function cAltBarrageThick(mSide, mStep, mThick)
    for i = 0, l_getSides() / mStep, 1 do
        w_wall(mSide + i * mStep, mThick)
    end
end

--same wall + mThick
function cAltBarrageThick(mSide, mStep, mThick)
    for i = 0, l_getSides() / mStep, 1 do
        w_wall(mSide + i * mStep, mThick)
    end
end

function pointSpin(theta, x, y, a)
    local r = math.sqrt((x * x) + (y * y))
    local ct = math.atan2(y, x)
    ct = ct + theta
    if a then
        return r * math.cos(ct)
    else
        return r * math.sin(ct)
    end
end

function cwspin(cw, theta)
    --convert to polar
    local x0, y0 = cw_getVertexPos(cw, 0)
    local x1, y1 = cw_getVertexPos(cw, 1)
    local x2, y2 = cw_getVertexPos(cw, 2)
    local x3, y3 = cw_getVertexPos(cw, 3)
    --cringe
    cw_setVertexPos4(cw,
        pointSpin(theta, x0, y0, true), pointSpin(theta, x0, y0, false),
        pointSpin(theta, x1, y1, true), pointSpin(theta, x1, y1, false),
        pointSpin(theta, x2, y2, true), pointSpin(theta, x2, y2, false),
        pointSpin(theta, x3, y3, true), pointSpin(theta, x3, y3, false)
    )
end

--cw decoration--

-- radials
cwrad1 = {}
cwrad2 = {}
cwrad3 = {}

-- rings
cwring1 = {}
cwring2 = {}

-- obstruction
cwborder = {}

for i = 0, 5 do
    cwrad1[i] = cw_createNoCollision()
    cwrad2[i] = cw_createNoCollision()
    cwrad3[i] = cw_createNoCollision()

    cwring1[i] = cw_createNoCollision()
    cwring2[i] = cw_createNoCollision()

    cwborder[i] = cw_createNoCollision()
end

function cwspawnwalllayer(cw, width, length, displacement, shade, conical, alpha)
    cw_setVertexPos(cw, 0, displacement + length, width + conical)
    cw_setVertexPos(cw, 1, displacement + length, 0 - width - conical)
    cw_setVertexPos(cw, 2, displacement - length, 0 - width)
    cw_setVertexPos(cw, 3, displacement - length, width)
    cw_setVertexColor4Same(cw, shade, shade, shade, alpha)
end

function cwspawn()
    for i = 0, 5 do 
        cwspawnwalllayer(cwrad1[i], 5, 100, 800, 255, 0, 255)
        cwspin(cwrad1[i], (math.pi / 3)*i)
        cwspawnwalllayer(cwrad2[i], 3, 60, 500, 255, 0, 255)
        cwspin(cwrad2[i], (math.pi / 3)*i)
        cwspawnwalllayer(cwrad3[i], 2, 30, 300, 255, 0, 255)
        cwspin(cwrad3[i], (math.pi / 3)*i)


        cwspawnwalllayer(cwring1[i], 600/math.sqrt(3), 5, 595, 255, 0, 255)
        cwspin(cwring1[i], (math.pi / 3)*i)
        cwspawnwalllayer(cwring2[i], 370/math.sqrt(3), 3, 367, 255, 0, 255)
        cwspin(cwring2[i], (math.pi / 3)*i)

        cwspawnwalllayer(cwborder[i], 10000, 1000, 1600, 0, 30, 100)
        cwspin(cwborder[i], (math.pi / 3)*i)
    end
end

pulsDist = 1
pulsMin = 1
function hardPulse()
    --the fast beat pulse
    l_setManualPulseControl(true)
    l_setPulse(pulsMin)
    l_setManualPulseControl(false) -- i have no clue whether i actually need to reset the pulse each cycle
    l_setPulseMin(pulsMin)
    l_setPulseMax(pulsMin + pulsDist)
    l_setPulseSpeed(1200)
    l_setPulseSpeedR((pulsDist * 1200 * BPM) / (4320000 - (pulsDist * BPM)))
    l_setPulseDelayMax(0)

end

-- `onInit` is an hardcoded function that is called when the level is first
-- loaded. This can be used to setup initial level parameters.
function onInit()
    l_setSpeedMult(1.5)
    l_setSpeedInc(0.1)
    l_setSpeedMax(3.5)
    l_setRotationSpeed(10000)
    l_setRotationSpeedMax(9999)
    l_setRotationSpeedInc(0)
    l_setDelayMult(1.0)
    l_setDelayInc(-0.01)
    l_setDelayMin(0.01)
    l_setFastSpin(0.0)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)
    l_setIncTime(15)
    l_setRadiusMin(40)

    l_setPulseMin(60)
    l_setPulseMax(100)
    l_setPulseSpeed(4)
    l_setPulseSpeedR(2)
    l_setPulseDelayMax(18)

    l_setWallSpawnDistance(1400)

    l_setDarkenUnevenBackgroundChunk(false)
    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(21.818181818181818181818181818182)
    enableSwapIfDMGreaterThan(2.5)
    disableIncIfDMGreaterThan(3)
end

-- `onLoad` is an hardcoded function that is called when the level is started
-- or restarted.
killed = 0
blackflash = shdr_getShaderId("bc_blackflash.frag")
spinscan = shdr_getShaderId("bc_spinscan.frag")
arrow = shdr_getShaderId("bc_arrow.frag")

function seeCheck()
    if roundThousand(u_getDifficultyMult()) < 1000 then
        s_setStyle("bc_grey")
        shdr_setActiveFragmentShader(RenderStage.PLAYERTRIS, arrow)
        difficultyName = "high vis"
        speedd = roundThousand(l_getSpeedMult()) / 1000
    end
    if roundThousand(u_getDifficultyMult()) > 1000 then
        l_setDelayMult(0.85)
        l_setSpeedMult(2.0)
        l_setSpeedMax(4.0)
        difficultyName = "hard"
        speedd = roundThousand(l_getSpeedMult()) / 1000
    end
    if roundThousand(u_getDifficultyMult()) == 1000 then
        difficultyName = "normal"
        speedd = roundThousand(l_getSpeedMult()) / 1000
    end
end

function onLoad()
    killed = 0
    e_eval([[s_setStyle("bc_kesd2")]])
    e_eval([[seeCheck()]])
    e_eval([[cwspawn()]])
    e_eval([[shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, spinscan)]])
    e_eval([[hardPulse()]])
    e_eval([[l_setRadiusMin(40)]])
    e_eval([[l_setBeatPulseMax(10)]])
    e_eval([[l_setBeatPulseDelayMax(3600/160)]])
    e_eval([[l_setBeatPulseSpeedMult(1)]])
    e_eval([[l_setRotationSpeed(0)]])
    e_eval([[t_clear()]])
end

function onDeath()
    shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, blackflash)
    s_setStyle("bc_death")

    for i = 0,5 do
        cw_setVertexColor4Same(cwborder[i], 0, 0, 0, 100)
        cw_setVertexColor4Same(cwrad1[i], 250, 0, 0, 255)
        cw_setVertexColor4Same(cwrad2[i], 250, 0, 0, 255)
        cw_setVertexColor4Same(cwrad3[i], 250, 0, 0, 255)
        cw_setVertexColor4Same(cwring1[i], 250, 250, 250, 255)
        cw_setVertexColor4Same(cwring2[i], 250, 250, 250, 255)
    end

    killed = 1
end

-- `onStep` is an hardcoded function that is called when the level "timeline"
-- is empty. The level timeline is a queue of pending actions.
-- `onStep` should generally contain your pattern spawning logic.
function onStep()
    addPattern(keys[index])
    index = index + 1

    if index - 1 == #keys then
        index = 1
        shuffle(keys)
    end
end

-- `onIncrement` is an hardcoded function that is called when the level
-- difficulty is incremented.
function onIncrement()
    speedd = roundThousand(l_getSpeedMult()) / 1000
    if roundThousand(u_getDifficultyMult()) > 1000 then
        notRotation = notRotation + 0.1
    else
        notRotation = notRotation + 0.05
    end
    rinc = rinc + 1
end

-- `onUnload` is an hardcoded function that is called when the level is
-- closed/restarted.
function onUnload()
    -- ...
end

ibeatCount = 0
-- `onUpdate` is an hardcoded function that is called every frame. `mFrameTime`
-- represents the time delta between the current and previous frame.

function onUpdate(mFrameTime)

    if l_getLevelTime() > nextLoop then -- clock
        loopcount = loopcount + 1
        nextLoop = loopcount * (60 / BPM) -- bpm = 160
        --on beat events
        u_setFlashEffect(10)
        hardPulse()
        scanning = 1
        if notSkew < 0 then
            for i = 0,5 do
                cw_setVertexColor4Same(cwborder[i], 0, 0, 0, 100)
            end
        end
        if dys then dys = false else dys = true end
        pshift = roundThousand((math.random() * 6) / 1000)
        l_setRotation(l_getRotation() + pshift * 60)

        if dys then
            for i = 0,5 do
                cw_setVertexColor4Same(cwring1[i], 250, 250, 250, 255)
                cw_setVertexColor4Same(cwring2[i], 250, 250, 250, 255)
            end
        else
            for i = 0,5 do
                cw_setVertexColor4Same(cwring1[i], 0, 250, 250, 255)
                cw_setVertexColor4Same(cwring2[i], 0, 250, 250, 255)
            end
        end
        beatCount = beatCount + 1
        ibeatCount = 0
    end

    if ibeatCount == ((60 / BPM) * 240) / 2 then
        scanning = 0
        if roundThousand(u_getDifficultyMult()) > 999 then
            for i = 0,5 do
                cw_setVertexColor4Same(cwborder[i], 0, 0, 0, 255)
            end
        end
    end

    --ring colors
    if FFrames % 10 == 0 then
        for i = 0,5 do
            cw_setVertexColor4Same(cwrad1[i], 250, 250, 250, 255)
            cw_setVertexColor4Same(cwrad3[i], 250, 250, 250, 255)
        end

        if notSkew > -1 then
            for i = 0,5 do
                cw_setVertexColor4Same(cwrad2[i], 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            end
        else
            for i = 0,5 do
                cw_setVertexColor4Same(cwrad2[i], 0, 250, 250, 255)
            end
        end
    end
    if FFrames % 10 == 7 then
        if notSkew > -1 then
            for i = 0,5 do
                cw_setVertexColor4Same(cwrad1[i], 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
                cw_setVertexColor4Same(cwrad3[i], 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            end
        else
            for i = 0,5 do
                cw_setVertexColor4Same(cwrad1[i], 0, 250, 250, 255)
                cw_setVertexColor4Same(cwrad3[i], 0, 250, 250, 255)
            end
        end
        for i = 0,5 do
            cw_setVertexColor4Same(cwrad2[i], 250, 250, 250, 255)
        end
    end
    if dys then
        notSkew = 2
    else
        notSkew = -2
    end
    if rinc % 2 == 0 then
        l_setRotation(l_getRotation() + (notRotation * (600 / 240)))
    else
        l_setRotation(l_getRotation() + ((notRotation * (600 / 240)) * -1))
    end
    if FFrames % 90 == 0 then
        local gen = (math.random() * 8)
        gen = roundThousand(gen / 1000)
        if gen == 0 then
            dec1 = 1
            dec2 = 1
            dec3 = 1
        elseif gen == 1 then
            dec1 = -1
            dec2 = 1
            dec3 = 1
        elseif gen == 2 then
            dec1 = 1
            dec2 = -1
            dec3 = 1
        elseif gen == 3 then
            dec1 = -1
            dec2 = -1
            dec3 = 1
        elseif gen == 4 then
            dec1 = 1
            dec2 = 1
            dec3 = -1
        elseif gen == 5 then
            dec1 = -1
            dec2 = 1
            dec3 = -1
        elseif gen == 6 then
            dec1 = 1
            dec2 = -1
            dec3 = -1
        else
            dec1 = -1
            dec2 = -1
            dec3 = -1
        end
    end
    for i = 0,5 do
        cwspin(cwrad1[i], dec1 * (math.pi / 3) / 45)
        cwspin(cwrad2[i], dec2 * (math.pi / 3) / 45)
        cwspin(cwrad3[i], dec3 * (math.pi / 3) / 45)
    end
    ibeatCount = ibeatCount + 1
    FFrames = FFrames + 1
end

function onRenderStage(rs) --cringe

    shdr_setUniformFVec2(spinscan, "u_resolution", u_getWidth(), u_getHeight())
    shdr_setUniformF(spinscan, "u_skew", notSkew)
    shdr_setUniformF(spinscan, "u_time", l_getLevelTime())
    shdr_setUniformF(spinscan, "u_rotation", math.rad(l_getRotation()))
    shdr_setUniformI(spinscan, "u_scanning", scanning)

    shdr_setUniformFVec2(blackflash, "u_resolution", u_getWidth(), u_getHeight())
    shdr_setUniformF(blackflash, "u_skew", notSkew)
    shdr_setUniformF(blackflash, "u_rotation", math.rad(l_getRotation()))
    shdr_setUniformI(blackflash, "u_dead", killed)

    shdr_setUniformF(arrow, "u_skew", notSkew)
    shdr_setUniformI(arrow, "u_dead", killed)
end
