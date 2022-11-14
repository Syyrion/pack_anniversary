MUSIC_OFFSET = -0.010 -- you are allowed to change this to make it sync better on your machine. won't affect when the song loops


u_execScript("level/overdose/functions.lua")
u_execScript("level/overdose/patterns.lua")
u_execScript("level/overdose/timings.lua")


WALLTYPES = {
    function(mSide) -- spike
        t_eval("l_setWallAngleLeft(-0.525) l_setWallAngleRight(0.525) l_setWallSkewLeft(10) l_setWallSkewRight(10)")
        w_wall(mSide, THICKNESS)
    end,
    function(mSide) -- button
        t_eval("l_setWallAngleLeft(-0.25) l_setWallAngleRight(0.25) l_setWallSkewLeft(6) l_setWallSkewRight(6)")
        w_wall(mSide, THICKNESS)
    end,
    function(mSide) -- dual spike
        t_eval("l_setWallAngleLeft(-0.25) l_setWallAngleRight(0.25) l_setWallSkewLeft(10) l_setWallSkewRight(-40)")
        w_wall(mSide, THICKNESS)
        t_eval("l_setWallAngleLeft(-0.25) l_setWallAngleRight(0.25) l_setWallSkewLeft(-40) l_setWallSkewRight(10)")
        w_wall(mSide, THICKNESS)
    end,
    function(mSide) -- stairs
        t_eval("l_setWallAngleLeft(-0.15) l_setWallAngleRight(0.15) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
        w_wall(mSide, THICKNESS)
        t_eval("l_setWallAngleLeft(-0.25) l_setWallAngleRight(0.25) l_setWallSkewLeft(3) l_setWallSkewRight(3)")
        w_wall(mSide, THICKNESS)
        t_eval("l_setWallAngleLeft(-0.375) l_setWallAngleRight(0.375) l_setWallSkewLeft(6) l_setWallSkewRight(6)")
        w_wall(mSide, THICKNESS)
    end,
}

function cWall(mSide)
    t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
    w_wall(mSide, THICKNESS)

    WALLTYPES[math.random(1, #WALLTYPES)](mSide)
end

function SetColorScheme(mScheme)
    MAIN_COLOR[1], MAIN_COLOR[2], MAIN_COLOR[3] = COLORSCHEMES[mScheme][1][1], COLORSCHEMES[mScheme][1][2],
        COLORSCHEMES[mScheme][1][3]
    BG_COLOR1[1], BG_COLOR1[2], BG_COLOR1[3] = COLORSCHEMES[mScheme][2][1], COLORSCHEMES[mScheme][2][2],
        COLORSCHEMES[mScheme][2][3]
    BG_COLOR2[1], BG_COLOR2[2], BG_COLOR2[3] = COLORSCHEMES[mScheme][3][1], COLORSCHEMES[mScheme][3][2],
        COLORSCHEMES[mScheme][3][3]
end

function randomize()
    local oldScheme = currentScheme
    local oldBGShader = currentBackgroundShader
    local oldWallShader = currentWallShader


    while oldScheme == currentScheme do
        currentScheme = math.random(1, #COLORSCHEMES)
        SetColorScheme(currentScheme)
    end

    while oldBGShader == currentBackgroundShader do
        setBackgroundShader(BG_SHADERS[math.random(1, #BG_SHADERS)])
    end

    while oldWallShader == currentWallShader do
        setWallShader(WALL_SHADERS[math.random(1, #WALL_SHADERS)])
    end
end

addPattern = {
    [1] = function() pAltBarrage(6, 1) end,
    [2] = function() pRandomBarrageNoRepeats(6, 1.25) end,
    [3] = function() pWallExVortexNew(1, 2, 1, 1) end,
    [4] = function() pWallExVortexNew(1, 3, 1, 1) end,
    [5] = function() pBarrageWall(3, 1) end,
    [6] = function() pInverseBarrage(3, 0.97) end,
    [7] = function() pBarrageLR(3, 1, 1) end,
    [8] = function() pBarrageSpiral(5, 1, 1) end,
    [9] = function() pMirrorSpiral(7, 1) end,
    [10] = function() pTunnel(3, 1) end,
    [11] = function() pWallExVortexNew(2, 1, 0, 0.8) end,
}

keys = { 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 }
shuffle(keys)
index = 1

skewMin = 0.40
skewMax = 0.65
skewSpeed = 1.7
skewPhaseShift = 0

SKEW = 0.525 -- starting value, halfway between min and max. if this doesn't match, then there will be a noticable skew change at 0.1 second as onUpdate gets called
TIME = 0

SONG_LENGTH = 292
trueSongLength = SONG_LENGTH


MAIN_COLOR = { 0, 0, 0 }
BG_COLOR1 = { 0, 0, 0 }
BG_COLOR2 = { 0, 0, 0 }

COLORSCHEMES = { -- main, bg1, bg2

    {
        { 240, 240, 240 }, { 0, 0, 0 }, { 80, 80, 80 } -- grey
    },
    {
        { 255, 30, 30 }, { 0, 0, 0 }, { 80, 0, 0 } -- red
    },
    {
        { 20, 255, 20 }, { 0, 0, 0 }, { 0, 90, 0 } -- green
    },
    {
        { 90, 140, 255 }, { 0, 0, 0 }, { 0, 0, 140 } -- light blue + blue
    },
    {
        { 255, 255, 0 }, { 0, 0, 0 }, { 70, 70, 0 } -- yellow
    },
    {
        { 255, 115, 0 }, { 0, 0, 0 }, { 90, 45, 0 } -- orange
    },
    {
        { 170, 40, 255 }, { 0, 0, 0 }, { 60, 0, 90 } -- purple
    },
    {
        { 255, 35, 255 }, { 0, 0, 0 }, { 85, 12, 85 } -- pink
    },
    {
        { 0, 255, 255 }, { 0, 0, 0 }, { 0, 75, 75 } -- cyan
    },
    {
        { 0, 255, 130 }, { 0, 0, 0 }, { 0, 90, 45 } -- mint green or something
    },
    {
        { 255, 190, 0 }, { 0, 0, 0 }, { 100, 35, 0 } -- yellow and orange
    },
    {
        { 255, 30, 150 }, { 0, 0, 0 }, { 100, 0, 20 } -- pink and redpink
    },
    {
        { 180, 60, 255 }, { 0, 0, 0 }, { 30, 0, 120 } -- pink + blue
    },
    {
        { 230, 142, 142 }, { 12, 3, 3 }, { 84, 35, 35 } -- reddish brown
    },
    {
        { 204, 255, 0 }, { 0, 0, 0 }, { 65, 81, 0 } -- funny color CCFF00
    },
    {
        { 30, 220, 255 }, { 0, 0, 5 }, { 0, 90, 30 } -- light blue + mint green
    },
}

BG_SHADERS = {
    "checkerboard.frag",
    "gradient_radial.frag",
    "gradient_sixths.frag",
    "hexagon_chops.frag",
    "hexagon_tiles.frag",
    "hexagon_tiles2.frag",
    "hypno1.frag",
    "squares.frag",
    "static.frag",
    "voronoi.frag",
    "wood.frag",
    "wtf1.frag",
    "wtf2.frag",
    "wtf3.frag",
    "wtf4.frag",
    "wtf5.frag",
    "wtf_blinds.frag"
}

WALL_SHADERS = {
    "wall_hexagon_tiles.frag",
    "wall_hexial.frag",
    "wall_hypno.frag",
    "wall_radial.frag",
    "wall_static.frag",
    "wall_straight.frag"
}

difficulty = roundThousand(u_getDifficultyMult())
if difficulty == 1000 then
    initialSpeed = 2.6
    currentRotation = -0.3

    -- first segment plays on first attempt, and never again when restarting
    SEGMENTS = { 22.322, 87.900, 132.572, 154.865 }
elseif difficulty == 1001 then -- start at 6th increment - 90
    initialSpeed = 3.26
    currentRotation = 0.63

    SEGMENTS = { 86.472, 87.900, 110.243, 132.572, 154.865, 177.155 }
elseif difficulty == 1002 then -- start at 11th increment - 165
    initialSpeed = 3.81
    currentRotation = 0.905

    SEGMENTS = { 86.472, 87.900, 110.243, 132.572, 154.865, 177.155, 221.861 }
end

difficulty = string.format("%.3f", difficulty / 1000) -- returns "1.000" or "1.001" depending on difficulty
l_addTracked("difficulty", "Difficulty")


function onInit()
    l_setSpeedMult(initialSpeed)
    l_setSpeedInc(0.11)

    l_setRotationSpeed(36) -- just for menu
    e_eval([[l_setRotationSpeed(currentRotation)]])
    rotIncrement = 0.055
    l_setRotationSpeedInc(0)

    l_setDelayMult(1)
    l_setDelayInc(0)

    l_setSides(6)
    l_enableRndSideChanges(false)

    l_setIncEnabled(true)
    l_setIncTime(15)
    l_setFastSpin(0)

    l_setSpeedMax(16)
    l_setRotationSpeedMax(16)

    l_setRadiusMin(65)
    l_setWallSpawnDistance(1100)
    l_setShadersRequired(true)
    a_syncMusicToDM(false)
end

function musicTimeline(mOffset) -- you could fill this with manual events if you wanted
    for i = 1, #TIMINGPOINTS do
        event(TIMINGPOINTS[i] - mOffset,
            [[	
                currentRotation = currentRotation * -1
                l_setRotationSpeed(currentRotation)
                randomize()
            ]])
    end
end

function onLoad()
    set3DShader("dark_gradient.frag")
    setPivotShader("passthrough.frag")

    e_eval([[
        s_setStyle("overdose_gameplay")
    ]])

    if not restarting then
        segment = SEGMENTS[1]
    else
        segment = SEGMENTS[math.random(2, #SEGMENTS)]
    end

    a_setMusicSeconds("overdose_NEURO_CLOUD_9", segment + MUSIC_OFFSET)
    musicTimeline(segment)
end

function onStep()
    addPattern[keys[index]]()
    index = index + 1

    if index > #keys then
        shuffle(keys)
        index = 1
    end
end

function onIncrement()
    currentRotation = currentRotation + rotIncrement * sign(currentRotation)
end

function onUnload()
    restarting = true
end

function onUpdate(mFrameTime)
    l_setRotationSpeed(currentRotation)

    if segment + l_getLevelTime() - 0.1 >= SONG_LENGTH then
        a_setMusicSeconds("overdose_NEURO_CLOUD_9", 0)
        musicTimeline(l_getLevelTime() * -1 - 0.1)
        SONG_LENGTH = SONG_LENGTH + trueSongLength
    end

    SKEW = (skewMax - skewMin) * 0.5 * math.sin(skewSpeed * l_getLevelTime() - skewPhaseShift) + (skewMin + skewMax) * 0.5 -- https://www.desmos.com/calculator/j8sd35wwwl
    TIME = l_getLevelTime()
    s_set3dSkew(SKEW)
end

function onRenderStage(rs) -- most shaders won't use them all, but idk any other way
    shdr_setUniformFVec2(currentBackgroundShader, "u_resolution", u_getWidth(), u_getHeight());
    shdr_setUniformF(currentBackgroundShader, "u_time", TIME)
    shdr_setUniformF(currentBackgroundShader, "u_rotation", math.rad(l_getRotation()))
    shdr_setUniformF(currentBackgroundShader, "u_skew", SKEW)
    shdr_setUniformFVec3(currentBackgroundShader, "color1", BG_COLOR1[1] / 255, BG_COLOR1[2] / 255, BG_COLOR1[3] / 255)
    shdr_setUniformFVec3(currentBackgroundShader, "color2", BG_COLOR2[1] / 255, BG_COLOR2[2] / 255, BG_COLOR2[3] / 255)

    shdr_setUniformFVec2(currentWallShader, "u_resolution", u_getWidth(), u_getHeight());
    shdr_setUniformF(currentWallShader, "u_time", TIME)
    shdr_setUniformF(currentWallShader, "u_rotation", math.rad(l_getRotation()))
    shdr_setUniformF(currentWallShader, "u_skew", SKEW)
    shdr_setUniformFVec3(currentWallShader, "u_color", MAIN_COLOR[1] / 255, MAIN_COLOR[2] / 255, MAIN_COLOR[3] / 255)

    shdr_setUniformFVec2(current3DShader, "u_resolution", u_getWidth(), u_getHeight());
    shdr_setUniformFVec3(current3DShader, "u_color", MAIN_COLOR[1] / 255, MAIN_COLOR[2] / 255, MAIN_COLOR[3] / 255)

    shdr_setUniformFVec3(currentPivotShader, "u_color", MAIN_COLOR[1] / 255, MAIN_COLOR[2] / 255, MAIN_COLOR[3] / 255)
end
