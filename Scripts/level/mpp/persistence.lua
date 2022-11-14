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
dys = false
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

--cw decoration

--layer 1 - rings
cw11 = cw_createNoCollision()
cw12 = cw_createNoCollision()
cw13 = cw_createNoCollision()
cw14 = cw_createNoCollision()
cw15 = cw_createNoCollision()
cw16 = cw_createNoCollision()

cw17 = cw_createNoCollision()
cw18 = cw_createNoCollision()
cw19 = cw_createNoCollision()
cw10 = cw_createNoCollision()
cw1a = cw_createNoCollision()
cw1b = cw_createNoCollision()

cw21 = cw_createNoCollision()
cw22 = cw_createNoCollision()
cw23 = cw_createNoCollision()
cw24 = cw_createNoCollision()
cw25 = cw_createNoCollision()
cw26 = cw_createNoCollision()
--layer 3 - cross
cw31 = cw_createNoCollision()
cw32 = cw_createNoCollision()
cw33 = cw_createNoCollision()
cw34 = cw_createNoCollision()
cw35 = cw_createNoCollision()
cw36 = cw_createNoCollision()

function cwspawnwalllayer1(cw)
    local length = 5
    local width = 100
    local displacement = 700
    local alpha = 200
    local conical = 0
    cw_setVertexPos(cw, 0, displacement + width, length + conical)
    cw_setVertexPos(cw, 1, displacement + width, 0 - length - conical)
    cw_setVertexPos(cw, 2, displacement - width, 0 - length)
    cw_setVertexPos(cw, 3, displacement - width, length)
    cw_setVertexColor4Same(cw, alpha, alpha, alpha, 255)
end

function cwspawnwalllayer1a(cw)
    local length = 3
    local width = 50
    local displacement = 450
    local alpha = 200
    local conical = 0
    cw_setVertexPos(cw, 0, displacement + width, length + conical)
    cw_setVertexPos(cw, 1, displacement + width, 0 - length - conical)
    cw_setVertexPos(cw, 2, displacement - width, 0 - length)
    cw_setVertexPos(cw, 3, displacement - width, length)
    cw_setVertexColor4Same(cw, alpha, alpha, alpha, 255)
end

function cwspawnwalllayer2(cw)
    local length = 2
    local width = 20
    local displacement = 350
    local alpha = 255
    local conical = 0
    cw_setVertexPos(cw, 0, displacement + width, length + conical)
    cw_setVertexPos(cw, 1, displacement + width, 0 - length - conical)
    cw_setVertexPos(cw, 2, displacement - width, 0 - length)
    cw_setVertexPos(cw, 3, displacement - width, length)
    cw_setVertexColor4Same(cw, alpha, alpha, alpha, 255)
end

function cwspawnwalllayer3(cw)
    local length = 1000
    local width = 1000
    local displacement = 1550
    local alpha = 0
    local conical = 30
    cw_setVertexPos(cw, 0, displacement + width, length + conical)
    cw_setVertexPos(cw, 1, displacement + width, 0 - length - conical)
    cw_setVertexPos(cw, 2, displacement - width, 0 - length)
    cw_setVertexPos(cw, 3, displacement - width, length)
    cw_setVertexColor4Same(cw, alpha, alpha, alpha, 100)
end

function cwspawn()
    cwspawnwalllayer1(cw11)
    cwspawnwalllayer1(cw12)
    cwspawnwalllayer1(cw13)
    cwspawnwalllayer1(cw14)
    cwspawnwalllayer1(cw15)
    cwspawnwalllayer1(cw16)
    cwspin(cw12, (math.pi / 3))
    cwspin(cw13, (math.pi / 3) * 2)
    cwspin(cw14, (math.pi / 3) * 3)
    cwspin(cw15, (math.pi / 3) * 4)
    cwspin(cw16, (math.pi / 3) * 5)
    cwspawnwalllayer1a(cw17)
    cwspawnwalllayer1a(cw18)
    cwspawnwalllayer1a(cw19)
    cwspawnwalllayer1a(cw10)
    cwspawnwalllayer1a(cw1a)
    cwspawnwalllayer1a(cw1b)
    cwspin(cw18, (math.pi / 3))
    cwspin(cw19, (math.pi / 3) * 2)
    cwspin(cw10, (math.pi / 3) * 3)
    cwspin(cw1a, (math.pi / 3) * 4)
    cwspin(cw1b, (math.pi / 3) * 5)
    cwspawnwalllayer2(cw21)
    cwspawnwalllayer2(cw22)
    cwspawnwalllayer2(cw23)
    cwspawnwalllayer2(cw24)
    cwspawnwalllayer2(cw25)
    cwspawnwalllayer2(cw26)
    cwspin(cw22, (math.pi / 3))
    cwspin(cw23, (math.pi / 3) * 2)
    cwspin(cw24, (math.pi / 3) * 3)
    cwspin(cw25, (math.pi / 3) * 4)
    cwspin(cw26, (math.pi / 3) * 5)
    cwspawnwalllayer3(cw31)
    cwspawnwalllayer3(cw32)
    cwspawnwalllayer3(cw33)
    cwspawnwalllayer3(cw34)
    cwspawnwalllayer3(cw35)
    cwspawnwalllayer3(cw36)
    cwspin(cw32, (math.pi / 3))
    cwspin(cw33, (math.pi / 3) * 2)
    cwspin(cw34, (math.pi / 3) * 3)
    cwspin(cw35, (math.pi / 3) * 4)
    cwspin(cw36, (math.pi / 3) * 5)
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
    e_eval([[shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, blackflash)]])
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

    cw_setVertexColor4Same(cw31, 0, 0, 0, 100)
    cw_setVertexColor4Same(cw32, 0, 0, 0, 100)
    cw_setVertexColor4Same(cw33, 0, 0, 0, 100)
    cw_setVertexColor4Same(cw34, 0, 0, 0, 100)
    cw_setVertexColor4Same(cw35, 0, 0, 0, 100)
    cw_setVertexColor4Same(cw36, 0, 0, 0, 100)


    cw_setVertexColor4Same(cw11, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw12, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw13, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw14, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw15, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw16, 250, 0, 0, 255)

    cw_setVertexColor4Same(cw21, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw22, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw23, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw24, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw25, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw26, 250, 0, 0, 255)

    cw_setVertexColor4Same(cw17, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw18, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw19, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw10, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw1a, 250, 0, 0, 255)
    cw_setVertexColor4Same(cw1b, 250, 0, 0, 255)

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
    cwspin(cw11, dec1 * (math.pi / 3) / 45)
    cwspin(cw12, dec1 * (math.pi / 3) / 45)
    cwspin(cw13, dec1 * (math.pi / 3) / 45)
    cwspin(cw14, dec1 * (math.pi / 3) / 45)
    cwspin(cw15, dec1 * (math.pi / 3) / 45)
    cwspin(cw16, dec1 * (math.pi / 3) / 45)
    cwspin(cw17, dec2 * (math.pi / 3) / 45)
    cwspin(cw18, dec2 * (math.pi / 3) / 45)
    cwspin(cw19, dec2 * (math.pi / 3) / 45)
    cwspin(cw10, dec2 * (math.pi / 3) / 45)
    cwspin(cw1a, dec2 * (math.pi / 3) / 45)
    cwspin(cw1b, dec2 * (math.pi / 3) / 45)
    cwspin(cw21, dec3 * (math.pi / 3) / 45)
    cwspin(cw22, dec3 * (math.pi / 3) / 45)
    cwspin(cw23, dec3 * (math.pi / 3) / 45)
    cwspin(cw24, dec3 * (math.pi / 3) / 45)
    cwspin(cw25, dec3 * (math.pi / 3) / 45)
    cwspin(cw26, dec3 * (math.pi / 3) / 45)

    if l_getLevelTime() > nextLoop then -- clock
        loopcount = loopcount + 1
        nextLoop = loopcount * (60 / BPM) -- bpm = 160
        --on beat events
        u_setFlashEffect(10)
        hardPulse()
        shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, spinscan)
        if notSkew < 0 then
            cw_setVertexColor4Same(cw31, 0, 0, 0, 100)
            cw_setVertexColor4Same(cw32, 0, 0, 0, 100)
            cw_setVertexColor4Same(cw33, 0, 0, 0, 100)
            cw_setVertexColor4Same(cw34, 0, 0, 0, 100)
            cw_setVertexColor4Same(cw35, 0, 0, 0, 100)
            cw_setVertexColor4Same(cw36, 0, 0, 0, 100)
        end
        if dys then dys = false else dys = true end
        pshift = roundThousand((math.random() * 6) / 1000)
        l_setRotation(l_getRotation() + pshift * 60)


        beatCount = beatCount + 1
        ibeatCount = 0
    end

    if ibeatCount == ((60 / BPM) * 240) / 2 then
        shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, blackflash)
        if roundThousand(u_getDifficultyMult()) > 999 then
            cw_setVertexColor4Same(cw31, 0, 0, 0, 255)
            cw_setVertexColor4Same(cw32, 0, 0, 0, 255)
            cw_setVertexColor4Same(cw33, 0, 0, 0, 255)
            cw_setVertexColor4Same(cw34, 0, 0, 0, 255)
            cw_setVertexColor4Same(cw35, 0, 0, 0, 255)
            cw_setVertexColor4Same(cw36, 0, 0, 0, 255)
        end
    end

    FFrames = FFrames + 1
    --ring colors
    if FFrames % 10 == 0 then
        cw_setVertexColor4Same(cw11, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw12, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw13, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw14, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw15, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw16, 250, 250, 250, 255)

        cw_setVertexColor4Same(cw21, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw22, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw23, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw24, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw25, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw26, 250, 250, 250, 255)

        if notSkew > -1 then
            cw_setVertexColor4Same(cw17, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw18, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw19, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw10, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw1a, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw1b, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
        else
            cw_setVertexColor4Same(cw17, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw18, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw19, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw10, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw1a, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw1b, 0, 250, 250, 255)
        end
    end
    if FFrames % 10 == 7 then
        if notSkew > -1 then
            cw_setVertexColor4Same(cw11, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw12, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw13, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw14, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw15, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw16, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)

            cw_setVertexColor4Same(cw21, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw22, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw23, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw24, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw25, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
            cw_setVertexColor4Same(cw26, 250 * math.sin(FFrames / 360), 250 * math.cos(FFrames / 360), 250, 255)
        else
            cw_setVertexColor4Same(cw11, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw12, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw13, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw14, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw15, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw16, 0, 250, 250, 255)

            cw_setVertexColor4Same(cw21, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw22, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw23, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw24, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw25, 0, 250, 250, 255)
            cw_setVertexColor4Same(cw26, 0, 250, 250, 255)
        end
        cw_setVertexColor4Same(cw17, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw18, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw19, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw10, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw1a, 250, 250, 250, 255)
        cw_setVertexColor4Same(cw1b, 250, 250, 250, 255)
    end
    if dys then
        notSkew = 2
        s_set3dSkew(0)
        s_set3dDepth(0)
    else
        notSkew = -2
    end
    if rinc % 2 == 0 then
        l_setRotation(l_getRotation() + (notRotation * (600 / 240)))
    else
        l_setRotation(l_getRotation() + ((notRotation * (600 / 240)) * -1))
    end
    ibeatCount = ibeatCount + 1
end

function onRenderStage(rs) --cringe

    shdr_setUniformFVec2(spinscan, "u_resolution", u_getWidth(), u_getHeight())
    shdr_setUniformF(spinscan, "u_skew", notSkew)
    shdr_setUniformF(spinscan, "u_time", l_getLevelTime())
    shdr_setUniformF(spinscan, "u_rotation", math.rad(l_getRotation()))

    shdr_setUniformFVec2(blackflash, "u_resolution", u_getWidth(), u_getHeight())
    shdr_setUniformF(blackflash, "u_skew", s_get3dSkew())
    shdr_setUniformF(blackflash, "u_rotation", math.rad(l_getRotation()))
    shdr_setUniformI(blackflash, "u_dead", killed)

    shdr_setUniformF(arrow, "u_skew", notSkew)
    shdr_setUniformI(arrow, "u_dead", killed)
end
