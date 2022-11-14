u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execScript("level/whirly_madness/particles.lua")
u_execScript("level/whirly_madness/patterns.lua")
u_execScript("level/whirly_madness/events.lua")
u_execScript("level/whirly_madness/status.lua")
u_execScript("level/whirly_madness/fake.lua")


function onInit()
    l_setManualBeatPulseControl(true)
    l_setManualPulseControl(true)
    l_setIncEnabled(false)
    a_syncMusicToDM(false)
    l_set3dRequired(true)
    l_setShadersRequired(true)
    l_setShowPlayerTrail(false)
    l_setDarkenUnevenBackgroundChunk(false)
    l_setRotationSpeed(0.5)
    l_setSides(6)
end

progress = 0
function onLoad()
    if not u_inMenu() then -- prevents potential lag in menu
        -- undo default timehalt
        u_haltTime(-6)

        -- set style to in game style
        s_setStyle("whirly_madness")
        l_setRotationSpeed(0.2)

        -- load shaders
        whirl_shader = shdr_getShaderId("whirl.frag")
        transparent_shader = shdr_getShaderId("transparent.frag")
        shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, whirl_shader)
        shdr_setActiveFragmentShader(RenderStage.WALLQUADS, whirl_shader)
        shdr_setActiveFragmentShader(RenderStage.WALLQUADS3D, whirl_shader)
        shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS, transparent_shader)
        shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS3D, transparent_shader)

        -- show progress
        l_addTracked("progress", "progress")

        -- extract data from dm
        local dm = u_getDifficultyMult()
        segment = math.floor(dm)
        difficultyMult = math.floor(dm * 10 - segment * 10)
        l_addTracked("difficultyMult", "difficulty")
        difficultyAdjust = difficultyMult - 1
        pulseIntensity = difficultyMult * 0.05
        Walls.speedMult = Walls.speedMult + difficultyAdjust * 0.2
        Patterns.delayMult = Patterns.delayMult - difficultyMult * 0.2
        s_set3dPulseMax(1 + difficultyAdjust * 0.3)

        -- init patterns and fake player/pivot
        Patterns:init()
        Fake:create()

        -- skip ahead depending on selection
        if segment == 1 then
            Fake.realOffset = { 3000, 0 }
            l_setBeatPulse(3000)
            levelTimeOffset = 0
        elseif segment == 2 then
            e_messageAddImportant("Starting at the second segment!", 100)
            levelTimeOffsetGoTo = 42
        elseif segment == 3 then
            e_messageAddImportant("Starting at the third segment!", 100)
            levelTimeOffsetGoTo = 94
        end
        if levelTimeOffsetGoTo ~= nil then
            for i = 0, levelTimeOffsetGoTo * 240 do
                levelTimeOffset = i / 240
                onUpdate(0.25)
            end
            Fake.pulse3D = 1 -- 3D pulse starts at 1 and cannot be set in 2.1.5, so I need to set my recreation too
            a_setMusicSeconds("shuffle_heaven", levelTimeOffsetGoTo)
        end

        -- define functions to execute on sliders/circles
        function slide(pos, done, length, slides)
            if originalDepthOffset == nil then
                -- new slide (could be same slider)
                originalDepthOffset = depthOffset
                local fac = math.random()
                fakeCenterTargetPos = {
                    (math.random(0, 1) * 2 - 1) * length * 12 * fac - Fake.center[1],
                    (math.random(0, 1) * 2 - 1) * length * 12 * (1 - fac) - Fake.center[2]
                }
                fakeCenterStartPos = { unpack(Fake.center) }
                u_setFlashEffect(10)
            end
            currentTimingMult = 1 + (1 - pos) * 2

            -- fast spin when sliding
            l_setRotation(l_getRotation() + l_getRotationSpeed() * (1 - pos) * length * 0.1)

            if extraDepthAnimMode == 2 then
                -- move fake center around in the last part of the level
                local rot = math.rad(l_getRotation())
                Fake.center[1] = (fakeCenterStartPos[1] + fakeCenterTargetPos[1] * pos) * math.cos(rot)
                Fake.center[2] = (fakeCenterStartPos[2] + fakeCenterTargetPos[2] * pos) * math.sin(rot)
                l_setBeatPulse(l_getBeatPulse() + pos * 3)

                -- flash screen a bit if in last phase
                s_setPulseMax(1 - pos)
            end

            -- make fake center move out and back in at a different depth for the 2nd part of the level
            centerOffset = (pos - 1) * pos * length * 15
            depthOffset = originalDepthOffset + pos * depthDirection
            if depthOffset <= -12 then
                depthDirection = 1
            elseif depthOffset >= 0 then
                depthDirection = -1
            end

            if pos == 1 then
                -- slide done
                originalDepthOffset = nil
            end
            if done then
                -- slider done
                Events:atNextS(slide)
                l_setRotationSpeed(-l_getRotationSpeed())
            end
        end

        Events:atNextS(slide)

        function point()
            currentTimingMult = currentTimingMult + 0.5
            l_setRotationSpeed(-l_getRotationSpeed())
            u_setFlashEffect(10)
            Events:atNextP(point)
        end

        Events:atNextP(point)

        if not l_getOfficial() then
            l_addTracked("deathCount", "Deaths")
        end
        t_wait(30)
    end
end

setSides = 6
function onStep()
    if setSides ~= l_getSides() then
        l_setSides(setSides)
        Fake:delete()
        Fake:create()
    end
    Patterns:spawn()
end

deathCount = 0
deathEffectTimer = 0
function onPreDeath()
    if deathEffectTimer == 0 then
        deathEffectTimer = 100
        deathCount = deathCount + 1
    end
end

function onDeath()
    -- fake 3D looks weird if this continues to update after death
    s_set3dPulseSpeed(0)
    l_setRotationSpeed(0)
end

function onInput(frametime, movement, localFocus)
    focus = localFocus
end

endings = {
    [1] = {
        [0] = "Nice, easy difficulty completed!",
        [1] = "Amazing, normal difficulty completed!",
        [2] = "Holy crap, hard difficulty completed!"
    },
    [2] = {
        [0] = "Nice, but try from the beginning next time.",
        [1] = "Amazing, but try from the beginning next time.",
        [2] = "The second segment is the hardest, good job!"
    },
    [3] = {
        [0] = "Nice, but the third segment isn't actually that hard.",
        [1] = "Amazing, but the third segment isn't actually that hard.",
        [2] = "The third segment is hard on this difficulty,\nbut not as hard as the second!"
    },
}
extraDepthAnimMode = -1
lastBeats = 0
centerOffset = 0
depthOffset = 0
depthDirection = -1
shouldCallRS = false
startAnimDone = false
shaderTime = 0
timescale = 1
currentTimingMult = 1
particleIntensity = 0.5
particleAccumulator = 0
add3D = 0
lower3dIntensity = 0
lower3dIntensityGoTo = 0
lastLevelTime = 0
function onUpdate(frametime)
    -- count deaths in invincible mode properly
    deathEffectTimer = deathEffectTimer - frametime
    if deathEffectTimer < 0 then
        deathEffectTimer = 0
    end

    -- change level time for time skip
    levelTime = l_getLevelTime() + levelTimeOffset
    progress = math.ceil(levelTime / 1.16975) .. "%"

    -- modify 3D spacing to adjust to music and be lower with higher 3D pulse to make the level playable
    originalSpacing = 10 * currentTimingMult ^ 0.4
    newSpacing = math.max(originalSpacing - Fake.pulse3D * lower3dIntensity / s_get3dPulseMax() * originalSpacing + 1, 1)
    s_set3dSpacing(newSpacing)

    -- run shader time faster depending on the music
    shaderTime = shaderTime + frametime * 0.04 * currentTimingMult
    currentTimingMult = currentTimingMult * 0.99
    if currentTimingMult < 1 then
        currentTimingMult = 1
    else
        -- spawn particles particleIntensity amount per tick
        particleIntensity = currentTimingMult * 0.4
        particleAccumulator = particleAccumulator + particleIntensity
        while particleAccumulator > 1 do
            Particles:spawn()
            particleAccumulator = particleAccumulator - 1
        end
    end

    -- detect timescale and adjust music pitch
    if timescale ~= frametime * 4 then
        a_setMusicPitch(frametime * 4)
    end
    timescale = frametime * 4

    -- smoothly fade between how much spacing should be lessend with 3D pulse
    if lower3dIntensity < lower3dIntensityGoTo then
        lower3dIntensity = lower3dIntensity + frametime / 60
        if lower3dIntensity > lower3dIntensityGoTo then
            lower3dIntensity = lower3dIntensityGoTo
        end
    elseif lower3dIntensity > lower3dIntensityGoTo then
        lower3dIntensity = lower3dIntensity - frametime / 60
        if lower3dIntensity < lower3dIntensityGoTo then
            lower3dIntensity = lower3dIntensityGoTo
        end
    end

    -- calculate the radius used for various things
    Status:updateRadius()

    -- update level values based on the segment
    if levelTime >= 42 and lastLevelTime < 42 then
        pulseIntensity = 0
        l_setCameraShake((1.5 + difficultyAdjust) * 3)
        if difficultyAdjust == 1 then
            s_set3dPulseMax(1.8)
        else
            s_set3dPulseMax(2)
        end
        depthOffset = 0
        depthDirection = -1
        extraDepthAnimMode = 1
        Walls.speedMult = 1.2 + difficultyAdjust * 0.2
        Patterns.delayMult = 3 - difficultyAdjust * 0.5
        Patterns.interPatternDelayMult = 2.5 - difficultyAdjust * 0.7
        lower3dIntensityGoTo = 0.6 - difficultyAdjust * 0.2
        setSides = 5
    elseif levelTime >= 94 and lastLevelTime < 94 then
        pulseIntensity = difficultyMult * 0.1
        l_setCameraShake((2 + difficultyAdjust) * 5)
        s_set3dPulseMax(1)
        extraDepthAnimMode = 2
        Walls.speedMult = 0.7 + difficultyAdjust * 0.2
        Patterns.delayMult = 2.5 - difficultyAdjust * 0.5
        Patterns.interPatternDelayMult = Patterns.delayMult
        lower3dIntensityGoTo = 2 - difficultyAdjust * 0.2
        setSides = 6
    elseif levelTime > 111 then
        -- fade out by adding 3D to the background
        t_wait(100)
        if levelTime > 116.5 then
            Fake.center[1] = Fake.center[1] * 0.95
            Fake.center[2] = Fake.center[2] * 0.95
            add3D = add3D + add3D * 0.02 + frametime * 0.02
        end
    end

    -- have the fake pivot fly in as start animation
    if not startAnimDone then
        Fake.realOffset = { 3000 - levelTime * 3000, 0 }
        if Fake.realOffset[1] <= 0 then
            Fake.realOffset[1] = 0
            l_setRotationSpeed(0.5 + difficultyAdjust * 0.1)
            l_setBeatPulse(50)
            shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS, whirl_shader)
            shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS3D, whirl_shader)
            extraDepthAnimMode = 0
            startAnimDone = true
        end
    end

    -- asjust the center of the fake pivot/walls depending on music
    local rot = math.rad(l_getRotation() * -1)
    if extraDepthAnimMode == 1 then
        Fake.center = { centerOffset * math.cos(rot), centerOffset * math.sin(rot) }
    end

    -- pulse pivot with the bpm
    local beats = math.floor(levelTime * Status.bpm / 60)
    if beats ~= lastBeats then
        l_setBeatPulse(40)
    else
        l_setBeatPulse(l_getBeatPulse() * 0.95)
    end
    lastBeats = beats

    -- pulse walls
    l_setPulse(currentTimingMult ^ pulseIntensity * 75)

    -- update music timings
    local time = levelTime * 1000
    Status:updateTPs(time)
    if Events:updateTime(time) then
        -- No timings left
        l_setCameraShake(0)
        e_wait(200)
        local append = ""
        if not l_getOfficial() then
            append = "\n\nAnd maybe try in official mode next time."
            if deathCount == 0 then
                append = append .. "\nBut hey, at least you didn't die!"
            end
        end
        e_messageAddImportant(endings[segment][difficultyMult] .. append, 150)
        e_wait(100)
        e_kill()
    end

    shdr_setUniformF(whirl_shader, "time", shaderTime)
    shdr_setUniformF(whirl_shader, "offset",
        s_get3dSpacing() * 4 * s_get3dPerspectiveMult() * (s_get3dSkew() * (Fake.pulse3D) * 3.6) * 1.4 / 400 + add3D)
    shdr_setUniformF(whirl_shader, "skew", s_get3dSkew() * (Fake.pulse3D + add3D) + 1)
    shdr_setUniformFVec2(whirl_shader, "resolution", u_getWidth(), u_getHeight())
    shdr_setUniformF(whirl_shader, "close_factor", 1 + l_getBeatPulse() / 160 * currentTimingMult)

    Fake:updatePulse3D(frametime)
    Particles:update(frametime)
    Walls:update(frametime)

    -- ensure logic in onRenderStage is called at max once per onUpdate call
    shouldCallRS = true

    -- useful for checking if timestamp has been passed (especially with rounding errors from timescale)
    lastLevelTime = levelTime
end

function onRenderStage()
    if shouldCallRS then
        -- update visual effects that require to be updated after internal game logic
        if extraDepthAnimMode == 0 then
            Fake:updateVisuals(-(levelTime * 5 % 1))
        elseif extraDepthAnimMode == 1 then
            Fake:updateVisuals(depthOffset)
        else
            Fake:updateVisuals(0)
        end
        Walls:update3D()
        shouldCallRS = false
    end
end
