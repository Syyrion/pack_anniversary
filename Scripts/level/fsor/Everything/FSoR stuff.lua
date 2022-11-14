-- WARNING! Protected by a memetic kill agent. Unauthorized entry is forbidden.
-- WARNING! Protected by a memetic kill agent. Unauthorized entry is forbidden.
-- WARNING! Protected by a memetic kill agent. Unauthorized entry is forbidden.

-- Fadein style pulse
controlFadeInStyleSwitch = true
fadeTimerEnabled = false
fadeTime = 1
fadeBrightnessPulse = 1
fadeTimer = time()

function executeFadeIn(time)
    fadeBrightnessPulse = -1.025
    fadeTime = time
    fadeTimerEnabled = true
end

function fadeInTimer()
    fadeIncr = 0.005 / fadeTime * 1.7 * 1.7
    if time() - fadeTimer >= 0.005 then
        fadeTimer = time()
        fadeBrightnessPulse = fadeBrightnessPulse + fadeIncr

        if controlFadeInStyleSwitch == true and fadeBrightnessPulse >= 0 then
            controlFadeInStyleSwitch = false
            s_setStyle("FSoR")
            setHue(hueValue)
            s_set3dSkew(0.45)
            s_set3dSpacing(250)
            s_set3dDepth(0)
        elseif fadeBrightnessPulse >= 0.71 then
            fadeBrightnessPulse = 0.71
            fadeTimerEnabled = false
        end
    end
end

-- black style pulses
stylePulsesEnabled = false
blackPulseValue = 0
plusHue = true

function blackPulse(state)
    stylePulsesEnabled = state
end

blackPulseTimerValue = 0
function blackPulseTimer()
    if time() - blackPulseTimerValue <= 0.125 then
        blackPulseValue = -1000
        if plusHue == true then
            plusHue = false
            hueValue = hueValue + 120
            if hueValue > 360 then hueDirection = hueDirection * -1 end
            hueValue = hueValue % 360
        end
    else
        if plusHue == false then plusHue = true end
        blackPulseValue = 0
    end
end

-- Rotation flicks
flickTimerVariable = time()
requiredFlickTime = 1.644
requiredFlickMult = 1
enableFlickTimer = false
rotationFlickValue = 0
flickSize = 3
rotationFlickDivider = 1

function changeFlickSize(val)
    flickSize = val * ROTATION_FLICK_MULT
end

function enableFlick(mult)
    if enableFlickTimer == false and requiredFlickMult == 0 then flickTimerVariable = time() end

    if mult == 0 then
        enableFlickTimer = false
    else
        enableFlickTimer = true
        requiredFlickMult = mult
    end
end

function flickTimer()
    if time() - flickTimerVariable >= requiredFlickTime / requiredFlickMult then
        flickTimerVariable = time()
        rotationFlickValue = flickSize
        if stylePulsesEnabled == true then
            blackPulseTimerValue = time()
        end
    end
end

-- Rotation direction switch
rotationDirection = -1
rotationSwitchTimerValue = time()
rotationSwitchTimerEnabled = false
rotationSwitchRequiredTime = 1.644
rotationSwitchIncrease = false

function directionTimerAndIncr(timeParam, state)
    if timeParam > 0 then
        rotationSwitchTimerEnabled = true
        rotationSwitchTimerValue = time()
        rotationSwitchRequiredTime = timeParam
    else rotationSwitchTimerEnabled = false
    end

    rotationSwitchIncrease = state
end

function rotationSwitchTimer()
    if time() - rotationSwitchTimerValue >= rotationSwitchRequiredTime then
        rotationSwitchTimerValue = time()
        rotationDirection = rotationDirection * -1

        if rotationSwitchIncrease == true then
            staticRotation = staticRotation + ROTATION_INCR_WHILE_SWITCH
            l_setRotation(l_getRotation() + ROTATION_SWITCH_ADDITIONAL_ANGLE_FLICK * getSign(rotationDirection))
        end
    end
end

-- Two level statements for creating background patterns
oldSpeedValue = 0

function addAdditionalBgPatterns(stage)
    if stage == 0 then
        oldSpeedValue = l_getSpeedMult()
        oldDistance = l_getWallSpawnDistance()
        l_setSpeedMult(getSpeedForWallAccs())
        l_setWallSpawnDistance(1600)
        l_setSides(150)
        createCoverStuff2()
    elseif stage == 1 then
        l_setSpeedMult(oldSpeedValue)
        l_setWallSpawnDistance(oldDistance)
        l_setSides(6)
    end
end

-- Hue smooth switch params
hueValue = 0
hueDirection = 1

-- Force increment but it's kinda working
function emulateIncrementSomehow()
    rotationFlickValue = 0.5
    rotationFlickDivider = 45
    l_setSpeedMult(l_getSpeedMult() + SPEED_INCR)
    l_setDelayMult(l_getDelayMult() - DELAY_INCR)
    t_clear()
end

-- When you use 10 speed for wallAccs, x0.999 matters (not accurate anyway)
function getSpeedForWallAccs()
    return 10 + (1 - getRoundedDifficulty3()) * 10
end

----------------------
-- Timers and Other --
----------------------

switchedStylePulse = false

variablesIncrTimer = time()

-- MAIN EVENT
OFFSET = 0
eventTimer = time()
eventCount = 0

-- OTHER STUFF
staticPulse = 5
stylePulseIncr = 0.05
staticRotation = 0
patternsEnabled = false

-- I had ideas on how to do it better, but it's too late and pointless
function timersAndStuff()
    -- intro
    if time() - eventTimer >= 0.0000 - OFFSET and eventCount == 0 then eventCount = 0.5 changeFlickSize(3 *
        ROTATION_FLICK_MULT) staticRotation = INTRO_ROTATION s_setStyle("FSoRintro") executeFadeIn(13.151)
    elseif time() - eventTimer >= 0.3100 - OFFSET and eventCount == 0.5 then eventCount = 0.7
    patternsEnabled = true

    elseif time() - eventTimer >= 0.3200 - OFFSET and eventCount == 0.7 then eventCount = 1
    allowPreDelay = 1

    elseif time() - eventTimer >= 13.151 - OFFSET and eventCount == 1 then eventCount = 1.5 s_set3dDepth(5) fadeBrightnessPulse = 0.71 -- set fadeBrightnessPulse for smooth style switch
    elseif time() - eventTimer >= 26.301 - OFFSET and eventCount == 1.5 then eventCount = 2 enableFlick(1) l_setPulseSpeed(0) l_setPulseSpeedR(0.7)
    elseif time() - eventTimer >= 32.877 - OFFSET and eventCount == 2 then eventCount = 3 enableFlick(2)
    elseif time() - eventTimer >= 39.452 - OFFSET and eventCount == 3 then eventCount = 4 enableFlick(4)
    elseif time() - eventTimer >= 42.690 - OFFSET and eventCount == 4 then eventCount = 4.5 t_clear() patternsEnabled = false
    elseif time() - eventTimer >= 42.740 - OFFSET and eventCount == 4.5 then eventCount = 5 enableFlick(8) thickness = 40 l_setSpeedMult(l_getSpeedMult()
        + SPEED_DROP_INCR) l_setWallSkewRight(7)
    elseif time() - eventTimer >= 44.384 - OFFSET and eventCount == 5 then eventCount = 5.5
        enableFlick(0)
        s_setStyle("FSoRblack")
        addAdditionalBgPatterns(0)

        -- drop
    elseif time() - eventTimer >= 45.935 - OFFSET and eventCount == 5.5 then eventCount = 6
    patternsEnabled = true
    thickness = 30
    staticPulse = -5
    addAdditionalBgPatterns(1)
    elseif time() - eventTimer >= 47.055 - OFFSET and eventCount == 6 then eventCount = 7 s_setStyle("FSoR") fadeBrightnessPulse = 0.71
    stylePulseIncr = 0.15
    staticRotation = ROTATION_DROP
    directionTimerAndIncr(1.644, false) l_setDelayMult(DELAY_DROP) switchedStylePulse = true
    elseif time() - eventTimer >= 60.205 - OFFSET and eventCount == 7 then eventCount = 7.3 emulateIncrementSomehow() patternsEnabled = false
    elseif time() - eventTimer >= 60.7275 - OFFSET and eventCount == 7.3 then eventCount = 7.5
    patternsEnabled = true
    allowPreDelay = 0

    elseif time() - eventTimer >= 60.7375 - OFFSET and eventCount == 7.5 then eventCount = 8
    allowPreDelay = 1

    elseif time() - eventTimer >= 73.356 - OFFSET and eventCount == 8 then eventCount = 9 s_set3dSkew(0.075) l_setPulseSpeed(0.7) l_setPulseSpeedR(0) changeFlickSize(2) blackPulse(true) enableFlick(2) directionTimerAndIncr(1.644
        / 2, true) fadeBrightnessPulse = 0.8
    switchedStylePulse = false

    elseif time() - eventTimer >= 98.836 - OFFSET and eventCount == 9 then eventCount = 10
    staticRotation = ROTATION_END
    directionTimerAndIncr(0, false) enableFlick(0)
    elseif time() - eventTimer >= 99.658 - OFFSET and eventCount == 10 then eventCount = 11 whyCantIJustGoToTheMenu()
    end



    -- a lot of timers
    if fadeTimerEnabled == true then fadeInTimer() end

    if enableFlickTimer == true then flickTimer() end

    if rotationSwitchTimerEnabled == true then rotationSwitchTimer() end

    if stylePulsesEnabled == true then blackPulseTimer() end

    -- timer for variable increments
    if l_getLevelTime() - variablesIncrTimer >= 0.005 then
        variablesIncrTimer = time()

        rotationFlickValue = rotationFlickValue - 0.155 / rotationFlickDivider
        if rotationFlickValue < 0 then
            rotationFlickValue = 0
            rotationFlickDivider = 1
        end

        hueValue = hueValue + 0.1 * hueDirection
        if hueValue >= 360 then
            hueValue = 360
            hueDirection = hueDirection * -1
        elseif hueValue <= 0 then
            hueValue = 0
            hueDirection = hueDirection * -1
        end
    end


    -- set changing things
    setRotation((rotationFlickValue + staticRotation) * rotationDirection)

    if switchedStylePulse == false then
        setPulseDiff(fadeBrightnessPulse + blackPulseValue, stylePulseIncr)
    end

    setHue(hueValue)

    l_setBeatPulse(staticPulse)
end
