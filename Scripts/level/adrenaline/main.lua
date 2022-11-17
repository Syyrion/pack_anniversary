--[[
    
# Adrenaline
Made by fentras https://fentras.me https://gitlab.com/fentras

### Special thanks
- Vee and the contributors for this awesome game https://openhexagon.org
- Syyrion for the ultimate libraries https://github.com/Syyrion
- Discord community for helping throughout the level creation

### Disclaimer
The code structure is a mess and the library that is being
utilised is not documented at all because everything was quite rushed
at the end. It could be done way better but I didn't have enough time
and strength to make it the best level so far. For now, enjoy this
small creation. I hope I can make something better in the future.

The code is undocumented but the library might end up as a separate
project on my GitLab page, so feel free to check it out if I will
ever make it into an actual project (at least in proof-of-concept state).

]]--

u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("library_extbase", "extbase", "syyrion", "utils.lua")
u_execDependencyScript("library_slider", "slider", "syyrion", "master.lua")
u_execDependencyScript("library_polywall", "polywall", "syyrion", "master.lua")
u_execDependencyScript("library_patternizer", "patternizer", "syyrion", "master.lua")

difficulty = u_getDifficultyMult()
deathMode = false
deathAlpha = 255

multiplier = 1
timeOffset = 0

Music = {
    LENGTH = 51.194,
    OFFSET = 0,
    COMPENSATION = -3,
    BPM = 75
}

Epoch = {
    MINUTE = 60,
    SPEED_IN_SECONDS = 300
}

Note = {
    WHOLE = Epoch.MINUTE / (Music.BPM / 4),
    HALF = Epoch.MINUTE / (Music.BPM / 2),
    QUARTER = Epoch.MINUTE / Music.BPM,
    EIGHTH = Epoch.MINUTE / (Music.BPM * 2),
    SIXTEENTH = Epoch.MINUTE / (Music.BPM * 4),
    THIRTYSECOND = Epoch.MINUTE / (Music.BPM * 8),
    SIXTYFOURTH = Epoch.MINUTE / (Music.BPM * 16)
}

Colors = {
    TRANSPARENT = function () return unpack({ 0, 0, 0, 0 }) end,
    WHITE = function() return unpack({ 255, 255, 255, 255 }) end,
    RED = function () return unpack({ 255, 0, 0, 255 }) end,
    GREEN = function () return unpack({ 0, 0, 255, 255 }) end,
    BLUE = function () return unpack({ 0, 255, 0, 255 }) end,
    CYAN = function () return unpack({ 0, 255, 255, 255 }) end,
    MAGENTA = function () return unpack({ 255, 0, 255, 255 }) end,
    YELLOW = function () return unpack({ 255, 255, 0, 255 }) end
}

-- Executing scripts after constants to include them
u_execScript("level/adrenaline/timeline.lua")
u_execScript("level/adrenaline/patterns.lua")

local PW, PT, PS, ST, TLW1, TLW2, TLE1, TLE2, shader, swapped, eraseQueue

beat_multiplier = { 0, 0 }
pulse_multiplier = 10
pulse_switch = u_rndInt(0, 1) == 0
rotation_mult = 0.1
rotation_switch = u_rndInt(0, 1) == 0

local curColor = 1
local setColor = {
    [1] = Colors.CYAN,
    [2] = Colors.MAGENTA,
    [3] = Colors.YELLOW
}

local Timer = {
    main = function() return l_getLevelTime() + Music.OFFSET - timeOffset end,
    offset = function() return l_getLevelTime() + Music.OFFSET - timeOffset + calculateWallOffset() end
}

local function polyWallSort()
    PW:sort(3)
end

local function configureSides(sides)
    local backgroundSize = l_getWallSpawnDistance()

	l_setSides(sides)

    PW[0]:xremove(1)
    PW[1]:xremove(1)
    PW[2]:xremove(1)

    PW[0]:template(0, sides)
    PW[1]:template(0, sides)
    PW[2]:template(0, sides)

    PW[0]:regularize(0, sides)
    PW[1]:regularize(0, sides)
    PW[2]:regularize(0, sides)

    PW[0].vertex:chset(Colors.TRANSPARENT())
    PW[2].vertex:chset(Colors.WHITE())

    PW[1].limit.extent:set(0)

    polyWallSort()
end

function calculateMusicOffset(timings)
    for i = 1, #timings do
        local timing = timings[i]
        local timestamp = timing[1] or timing['t']
        if (timestamp > Music.OFFSET) then
            return i
        end
    end
    return 1
end

function calculateWallStart(timings)
    local offset = calculateWallOffset()
    for i = 1, #timings do
        local timing = timings[i]
        local timestamp = timing[1] or timing['t']
        if (timestamp - Music.OFFSET > offset) then
            return i
        end
    end
    return 1
end

function calculateWallOffset()
    return (l_getWallSpawnDistance() - (getDistanceBetweenCenterAndPlayerTip() + THICKNESS)) / (Epoch.SPEED_IN_SECONDS * u_getSpeedMultDM())
end

function onInit()
    if difficulty == -1 then
        deathMode = true
        difficulty = 3
    end

    if difficulty == 3 then
        s_setStyle("adrenalineDark")
    end

    l_setRotationSpeedMax(2)
    l_setSpeedMax(5)

    l_setRotationSpeed(0.025)
    l_setSides(6)
    l_setDelayMult(0)
    
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0)
    l_setPulseDelayMax(0)

    l_setPulse(1)
    l_setRotation(u_rndInt(0, 360))
    
    l_setRadiusMin(60)
    l_setBeatPulseMax(120)
    
    l_setIncEnabled(false)
    l_setSwapEnabled(false)
    l_enableRndSideChanges(false)

    l_setManualPulseControl(true)
    l_setManualBeatPulseControl(true)

    s_set3dSkew(0.5)

    a_syncMusicToDM(false)
    a_overrideDeathSound("hit.ogg")
    a_overrideSwapSound("clap.ogg")

    setMultiplier()
end

function cWall(side, thickness)
    side = side % l_getSides()
    thickness = thickness or THICKNESS

    collider = PW[0][side]:sWall()
    collider.thickness:set(thickness)

    fragment = PW[2][side]:nWall()
    fragment.thickness:set(thickness)
end

function dWall(side, thickness)
    side = side % l_getSides()

    collider = PW[0][side]:dWall()
    collider.thickness:set(thickness)

    fragment = PW[2][side]:nWall()
    fragment.thickness:set(thickness)
    fragment.vertex:chsetcolor(255, 0, 0)
end

function setMultiplier()
    local rotMult = 1
    local multMult = 1

    if difficulty > 1 then
        rotMult = 1 + (difficulty * 0.05)
    end

    if multiplier > 1 then
        multMult = 1 + (multiplier * 0.00125)
    end

    l_setSpeedMult(2.5 * multiplier)
    l_setPlayerSpeedMult(1.05 * multMult * rotMult)
    l_setPulseMin(10 * multiplier)
    l_setPulseMax(14 * multiplier)
end

function onLoad()
    PW = PolyWall:new()
    PW:template(0, 3)
    
    configureSides(l_getSides())
    
    PT = Patternizer:new()
    PT:link(".", cWall)
    PT:link("d", dWall)
    
    local wallIndex = calculateWallStart(TIMELINE[1])
    local musicIndex = calculateMusicOffset(TIMELINE[1])

    shader = shdr_getShaderId("morphing_noise.frag")
    swapped = false
    eraseQueue = true
    
    PS = Patterns:new(PATTERNS, PT)
    TLW1 = Timeline:new(TIMELINE[1], wallIndex)
    TLW2 = Timeline:new(TIMELINE[1])
    TLE1 = Timeline:new(TIMELINE[1])
    TLE2 = Timeline:new(TIMELINE[2])
    
    PS:setPattern(TLW1:getPattern(1))
    PW[2].P:fill(1)
    
    polyWallSort()

    ST = TimerPeriodic:new(Note.THIRTYSECOND, function ()
		polyWallSort()
	end)

    if not u_inMenu() then
        e_messageAdd("Swap Enabled", 100)
        -- Loading music before seems to remove potential lag when switching it later
        a_setMusicSeconds("astraLow", 0)
        a_setMusicSeconds("astraHigh", 0)
        a_setMusicSeconds("astra", Music.OFFSET)
        u_haltTime(Music.COMPENSATION)
        shdr_setActiveFragmentShader(RenderStage.WALLQUADS, shader)
        shdr_setActiveFragmentShader(RenderStage.WALLQUADS3D, shader)
        if difficulty == 3 then
            shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, shader)
        end
    end
end

function onInput(mFrameTime, mMovement, mFocus, mSwap)
    if mSwap and not swapped then
        u_swapPlayer(true)
        beat_multiplier[1] = 25
        swapped = true
    elseif not mSwap and swapped then
        swapped = false
    end
    PW[2].P:move(1, mFocus)
end

function onUpdate(mFrameTime)
    shdr_setUniformFVec2(shader, "u_resolution", u_getWidth(), u_getHeight())
    shdr_setUniformF(shader, "u_rotation", math.rad(-l_getRotation()))
    shdr_setUniformF(shader, "u_time", l_getLevelTime())
    shdr_setUniformF(shader, "u_skew", s_get3dSkew())

    if Timer.main() >= Music.LENGTH then
        TLW1:reset()
        TLW2:reset()
        TLE1:reset()
        TLE2:reset()

        timeOffset = timeOffset + Music.LENGTH

        local idMusic = "astra"
        local rndMusic = u_rndInt(1, 3)
        if rndMusic == 2 then
            idMusic = "astraLow"
        elseif rndMusic == 3 then
            idMusic = "astraHigh"
        end

        multiplier = multiplier + 0.25
        setMultiplier()
        
        a_playSound("levelUp.ogg")
        a_setMusicSeconds(idMusic, Music.OFFSET)
        u_haltTime(Music.COMPENSATION)
    end

    if Timer.offset() < Music.LENGTH - calculateWallOffset() then
        if TLW1:advance(Timer.offset()) then
            PS:spawn()
        end
        
        if TLW2:advance(Timer.offset()) then
            local position = TLW2:getPosition()
            local pattern = TLW2:getPattern()
            local params = TLW2:getParams()

            PS:setTimings({
                TLW2:getTime(position - 1),
                TLW2:getTime(position),
                TLW2:getTime(position + 1)
            })

            if pattern ~= nil then PS:setPattern(pattern) end
            if params ~= nil then PS:setQueue(params) end

            -- effects queue (freeze, skip, etc.) needs to be cleared otherwise the effects will lock themselves on
            -- that still doesn't help with Music.OFFSET
            if eraseQueue and position >= calculateWallStart(TIMELINE[1]) then
                PS:clearQueue()
                eraseQueue = false
            end
        end
        
        if TLE1:advance(Timer.main()) then
            beat_multiplier[1] = 25
            if deathMode then
                deathAlpha = 255
                PW[2].vertex:chsetcolor(setColor[curColor]())
                curColor = curColor + 1
                if curColor > #setColor then
                    curColor = 1
                end
            end
            a_playPackSound("clack.ogg")
        end

        if TLE2:advance(Timer.main()) then
            pulse_switch = not pulse_switch
            rotation_switch = not rotation_switch
        end
    else
        PS:reset()
    end
    
    beat_multiplier[1] = lerp(0, beat_multiplier[1], 0.925)
    
    if deathMode then
        deathAlpha = lerp(deathAlpha, 10, 0.025)
        PW[2].vertex:chsetalpha(deathAlpha)
    end
    if pulse_switch then
        pulse_multiplier = lerp(l_getPulse(), l_getPulseMax(), 0.0125)
    else
        pulse_multiplier = lerp(l_getPulse(), l_getPulseMin(), 0.0125)
    end
    if rotation_switch then
        rotation_mult = lerp(l_getRotationSpeed(), 2 * multiplier * (difficulty * 0.5), 0.001333)
    else
        rotation_mult = lerp(l_getRotationSpeed(), -2 * multiplier * (difficulty * 0.5), 0.001333)
    end

    l_setBeatPulse(beat_multiplier[1])
    l_setPulse(pulse_multiplier)
    l_setRotationSpeed(rotation_mult)
    s_setBGRotationOffset(rotation_mult*-100)

    PW[2].P:fill(1)
    ST:step(mFrameTime)
    PW:run(2, mFrameTime)
    PT:step(mFrameTime)
end

--[[

### Fun Fact
This level supposed to be called "Hopes" but I started working on it
too late for this pack and had to change the direction of the development.

Maybe you will see this scraped level somewhere later? :)

]]