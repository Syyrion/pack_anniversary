-- include useful files

-- utils
u_execScript("level/memoriesReappear/utils/march31o_common.lua")
u_execScript("level/memoriesReappear/utils/march31o_utils.lua")
u_execScript("level/memoriesReappear/utils/march31o_utility_classes.lua")

-- patterns
u_execScript("level/memoriesReappear/patterns/march31o_patterns_common.lua")
u_execScript("level/memoriesReappear/patterns/march31o_patterns_additional.lua")
u_execScript("level/memoriesReappear/patterns/march31o_patterns_additional_tunnel.lua")
u_execScript("level/memoriesReappear/patterns/march31o_patterns_cage.lua")
--
u_execScript("level/memoriesReappear/other/march31o_pattern_sets.lua")

-- others
u_execScript("level/memoriesReappear/other/zcustomWall1.92Utils.lua")
u_execScript("level/memoriesReappear/other/WallAccHelper1.1.lua")

-- override common wall code
function cWallBasePrimary(_side, _thickness, ...)
    if curStyle == "HXDS4pieChartV2" then
            if _side % 6 == 5 then for ex = 0, 2 do w_wall(35 + ex, _thickness or THICKNESS) end
        elseif _side % 6 == 0 then for ex = 0, 3 do w_wall(2  + ex, _thickness or THICKNESS) end
        elseif _side % 6 == 1 then for ex = 0, 4 do w_wall(6  + ex, _thickness or THICKNESS) end
        elseif _side % 6 == 2 then for ex = 0, 6 do w_wall(11 + ex, _thickness or THICKNESS) end
        elseif _side % 6 == 3 then for ex = 0, 7 do w_wall(18 + ex, _thickness or THICKNESS) end
        elseif _side % 6 == 4 then for ex = 0, 8 do w_wall(26 + ex, _thickness or THICKNESS) end
        end
    else w_wall(_side, _thickness or THICKNESS)
    end
end

-- inspired taken from modern year pack from The Sun XIX

-- Pattern constants
local march31oFirstPatternSpawn = false;
local march31oCurrentSpawning = true;
local march31oPatternSpawnAmount = 0;

-- configs can be changed (IMPORTANT FOR OH 2.0.2+ USERS: Delete the current replay file before changing the config)
march31oPat_timesDo = 999; --cycle do
march31oPat_thickness = 40; --thickness tho
march31oPatDel_AdditionalDelay = 0; --delay increment after patterns loaded (FOR PATTERNS ONLY)
march31oPatDel_AddMult = 1; --additional delay mult, seriously delay decreaser...i think (FOR PATTERNS ONLY)
march31oPatDel_isRebootingSide = false; --rebooting side (FOR PATTERNS ONLY)
rotation = 0.005
rotdir = 1
rotmult = 1
levSync = 50
-- delay config
    march31oPatDel_SDMult = 0; --delay-speed multiplier (FOR PATTERNS ONLY)

-- Pattern effect
function p_patternEffectStart()
end
function p_patternEffectCycle()
end
function p_patternEffectEnd()
end

zoomFactor = 40
isNostalgiaStarts = false

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0)
    l_setRotationSpeed(0.005)
    l_setRotationSpeedMax(1.9)
    l_setRotationSpeedInc(0.01)
    l_setDelayMult(1)
    l_setDelayInc(0.0)
    l_setFastSpin(80.0)
    l_setSides(300)
    l_setSidesMin(36)
    l_setSidesMax(36)
    l_setIncEnabled(false) l_setIncTime(math.huge)

    l_setPulseMin(zoomFactor)
    l_setRadiusMin(zoomFactor)

    s_set3dPulseSpeed(0)
    s_set3dSkew(0)

    --etMalfEvent = PulseDetector:new(getBPM(levSync, 1, 48), 0, levSync * 2, true, 0, nil, nil, 0, true, 1)
    etEvent = EventTimer:new(0, -256, 0, true, 1)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
    if math.ceil(u_getDifficultyMult()) == 2 then
        hellDiff = "hell difficulty engaged"
        l_addTracked("hellDiff", "attention")
        e_messageAdd("difficulty > 1\nhell difficulty engaged!", 60)
    end
    if math.floor(u_getDifficultyMult()) == 0 then
        l_addTracked("sh_levelName", "level name")
        l_addTracked("sh_level", "level")
        u_log("note: inspired from Super Hexagon")
        e_messageAdd("difficulty < 1\ncompletable difficulty engaged!", 60)
        e_messageAdd("complete until after mega hexagonest.", 300)
    end
    getMainKey()
    if not u_inMenu() then
        s_setStyle("memoriesreappear_intro")
        wallFromPicture("Packs/anniversary_leftovers/Scripts/level/memoriesReappear/image.bmp", 0, 0, 15, 2.5, 0, getRandomSide(), 0.015, 2.75)
        t_eval([[l_setSides(6) l_setSpeedMult(1)]])
        t_eval([[u_setFlashColor(0, 0, 0) u_setFlashEffect(255)]])
    end
end

local lnr_pos = 0

function retSpeedMultExpectCurLevel(mSpdInc)
    if curStyle ~= "HXDS4leftNRight" then l_setSpeedMult(l_getSpeedMult() + mSpdInc) end
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
    p_setOverrideShape(0, l_getSides())
    if math.ceil(u_getDifficultyMult()) == 2 then
        l_setSides(u_rndInt(3, 9))
        retSpeedMultExpectCurLevel(0.05)
    else
        l_setSides(6)
        retSpeedMultExpectCurLevel(0.015)
    end
    if (march31oCurrentSpawning) then
        if (not march31oFirstPatternSpawn) then march31oFirstPatternSpawn = true;
        end
        if curStyle == "HXDS4leftNRight" then
            l_setSides(10)
            cBarrage(lnr_pos)
            lnr_pos = lnr_pos + u_rndIntUpper(4) * getRandomDir()
            t_wait(getPerfectDelay(THICKNESS) * 5.6 * 1.25)
        else
            if (isNostalgiaStarts) then
                if math.floor(u_getDifficultyMult()) == 0 then
                    local sh_patType = (sh_level < 4 and 0) or (sh_level >= 4 and sh_level < 7 and 1) or 2
                    local sh_hyperMode = (sh_level == 3 and true) or (sh_level == 6 and true) or false
                    spawnSHPattern(getKeys[pat_index], sh_patType, sh_hyperMode, sh_level > 9)
                    pat_index = pat_index + 1
                    march31oPatternSpawnAmount = march31oPatternSpawnAmount + 1

                    if pat_index - 1 == #getKeys then
                        pat_index = 1
                        shuffle(getKeys)
                    end
                else
                    local sh_patType = (sh_level < 4 and 0) or (sh_level >= 4 and sh_level < 7 and 1) or 2
                    local sh_hyperMode = (sh_level == 3 and true) or (sh_level == 6 and true) or false
                        if curStyle == "SHhexagon"       then spawnSHPattern(getKeys[pat_index], sh_patType, sh_hyperMode, sh_level > 9)
                    elseif curStyle == "HXDS1cPentagon"  then l_setSides(5) spawnHxdsCrazyPentPattern(getKeys[pat_index])
                    elseif curStyle == "HXDS1rubberer"   then l_setSides(4) spawnHxdsHexV1Pattern(getKeys[pat_index])
                    elseif curStyle == "HXDS2solaris1"   then p_setOverrideShape(2, 6) l_setSides(30) spawnHxdsV2Pattern(getKeys[pat_index], true)
                    elseif curStyle == "HXDS2r7bberBlue" then l_setSides(7) spawnHxdsV2Pattern(getKeys[pat_index], false)
                    elseif curStyle == "HXDS3shadB"      then spawnHxdsV2Pattern(getKeys[pat_index], true)
                    elseif curStyle == "HXDS3sinkhole"   then spawnHxdsV2Pattern(getKeys[pat_index], false)
                    elseif curStyle == "HXDS4pieChartV2" then l_setSides(36) p_setOverrideShape(1, 6) spawnHxdsV2Pattern(getKeys[pat_index], false)
                    else                                      spawnMainPattern(getKeys[pat_index])
                    end
                end
                pat_index = pat_index + 1
                march31oPatternSpawnAmount = march31oPatternSpawnAmount + 1

                if pat_index - 1 == #getKeys then
                    pat_index = 1
                    shuffle(getKeys)
                end
            else
                    if u_getManualIncrementTimes() == 0 then cWall(getRandomSide()) t_wait(getPerfectDelay(THICKNESS) * 11)
                elseif u_getManualIncrementTimes() == 1 then
                        if u_rndIntUpper(5) == 1 then rWall(getRandomSide())
                    elseif u_rndIntUpper(5) == 2 then cAltBarrage(getRandomSide())
                    elseif u_rndIntUpper(5) == 3 then cBarrageVorta(getRandomSide())
                    elseif u_rndIntUpper(5) == 4 then cBarrageExHoles(getRandomSide(), 1)
                    else                              cBarrage(getRandomSide())
                    end
                    t_wait(getPerfectDelay(THICKNESS) * 11)
                else
                    local patterns = u_rndInt(0, 4)
                    if patterns == 0 then -- barrage spiral
                        local t, d = getRandomSide(), getRandomDir()
                        for a = 0, u_rndIntUpper(4) do
                            cBarrage(t + (a * d))
                            t_wait(getPerfectDelay(THICKNESS) * 4)
                        end
                    elseif patterns == 1 then -- alt barrage spiral
                        local t, d = getRandomSide(), getRandomDir()
                        for a = 0, u_rndIntUpper(4) do
                            cAltBarrage(t + (a * d))
                            t_wait(getPerfectDelay(THICKNESS) * 4)
                        end
                    elseif patterns == 2 then -- vorta/vortex barrage spiral
                        local t, d = getRandomSide(), getRandomDir()
                        for a = 0, u_rndIntUpper(4) do
                            cBarrageVorta(t + (a * d))
                            t_wait(getPerfectDelay(THICKNESS) * 4)
                        end
                    elseif patterns == 3 then -- 2-holed barrage spiral
                        local t, d = getRandomSide(), getRandomDir()
                        for a = 0, u_rndIntUpper(4) do
                            cBarrageN(t + (a * d), 1) cWall(t + (a * d))
                            t_wait(getPerfectDelay(THICKNESS) * 4)
                        end
                    else -- alt half barrage
                        local t, d = getRandomSide(), getRandomDir()
                        for a = 0, u_rndIntUpper(4) do
                            cBarrageHalf(t + ((a % 2) * 3))
                            t_wait(getPerfectDelay(THICKNESS) * 4)
                        end
                    end
                    t_wait(getPerfectDelay(THICKNESS) * 8)
                end
            end
        end
    end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onInput is a hardcoded function invoked when the player executes input
function onInput(mFrameTime, mMovement, mFocus, mSwap)
end

---- level vars
curStyle = ""
oldCurStyle = ""
local stylePulse = 0
local stylePulseCur = -1

-- hues used for color changes
hexest_hues = { 120, 0, 315, 180, 210, 255 }
hexest_targetHue = 0
hexest_oldHue = 0

sh_level = 0
rgb_color = 0

local curStyleRadar = 1

local style3dSkew = 0
oldRot = 0

ftl_pulse = 70
asymptote_spacing = 0
asymptote_intensity = 200

shadows_spacingMult = 1.3

styles = {
    --super hexagon
    "SHhexagon", "SHhhexagon", "SHmhexagon",
    "SHhexagoner", "SHhhexagoner", "SHmhexagoner",
    "SHhexagonest", "SHhhexagonest", "SHmhexagonest",

    --vee
    "CUBEpointless", "CUBEflatteringshape", "CUBEseconddimension", "CUBEapeirogon",

    --exschwaison
    "EXSCH1ftl", "EXSCH1glitched",
    "EXSCHLmalfunction", "EXSCHLsesism",
    "EXSCH2space", "EXSCH2invert_blackwhite",
    "EXSCH3reversal", "EXSCH3stutter",
    "EXSCH4radar1", "EXSCH4asymptote",

    --hexadorsip
    "HXDS1cPentagon", "HXDS1rubberer",
    "HXDS2r7bberBlue", "HXDS2solaris1",
    "HXDS3shadB", "HXDS3sinkhole",
    "HXDS4leftNRight", "HXDS4pieChartV2"
}

sh_isFinalEngage = false
sh_levelName = "wait for it"
sh_style = { "hexagon", "hhexagon", "mhexagon", "hexagoner", "hhexagoner", "mhexagoner", "hexagonest", "hhexagonest", "mhexagonest", "fhexagonest" }
sh_levelNames = { "Hexagon", "Hyper Hexagon", "Mega Hexagon", "Hexagoner", "Hyper Hexagoner", "Mega Hexagoner", "Hexagonest", "Hyper Hexagonest", "Mega Hexagonest", "Final" }
sh_levelNumbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
r7bber_styleCol = { "Red", "Green", "Blue", "Purple" }
shadows_styleCol = { "B", "G", "G2", "G3", "M", "O", "P", "Pp", "R", "W", "Y" }
----

---- level functions
function malfRot()
    oldRot = rotation
    rotation = u_rndInt(10, 30) * getRandomDir()
    local hue = u_rndInt(0, 360)
    s_setHueMin(hue)
    s_setHueMax(hue + 20)
    l_setRotation(l_getRotation() + (u_rndIntUpper(5) * 60 * getRandomDir()))
end

function invRot()
    rotmult = u_rndReal() * 2
    rotdir = getRandomDir()
    l_setRotation(l_getRotation() + 180)
end

function initGlotch()
    l_setPulseMin(u_rndInt(30, 70))
    l_setRotation(l_getRotation() + u_rndInt(0, 180) * getRandomDir())
end

function init3dSpacingShake()
    if asymptote_spacing >= -250 and asymptote_spacing <= 250 then
        asymptote_spacing = asymptote_spacing + u_rndReal() * asymptote_intensity * 2 - asymptote_intensity
    else
        asymptote_spacing = u_rndInt(0, 250) * getRandomDir() * 1.5
        l_setRotationSpeed(u_rndReal() - 0.5)
    end
    s_set3dSpacing(asymptote_spacing)
    l_setPulseMin(u_rndInt(70, 90))
    l_setPulseMax(u_rndInt(90, 110))
    s_set3dSkew(u_rndReal())
end

function spawnSolarisCover()
    for j = 0, 29 do v192WallAcc(j * 1, THICKNESS * 7.5, 3.2, -0.125, 0, 3.2, 30, 2.2) end
    for j = 0, 14 do v192WallAcc(j * 2, THICKNESS * 25, 3.2, -0.125, 0, 3.2, 30, 2.2) end
end
----

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
    etEvent:step()
    v192UpdateWalls(mFrameTime)

    if curStyle == "SHhexagonest" then
        if etEvent:detect(0, 0, false) then
            repeat hexest_targetHue = hexest_hues[u_rndIntUpper(#hexest_hues)]
            until  hexest_targetHue ~= hexest_oldHue
            hexest_oldHue = hexest_targetHue
        elseif etEvent:detect(getBPM(levSync, 1, 2), 1, false) then etEvent:resetEvents(true)
        end
        if hexest_targetHue < s_getHueMin() then forceSetHue((s_getHueMin() - 1))
        elseif hexest_targetHue > s_getHueMin() then forceSetHue((s_getHueMin() + 1))
        end
    elseif curStyle == "SHfhexagonest" then l_setRotation(0)
    elseif curStyle == "EXSCH1ftl" then
            if etEvent:detect(0,                     0, false) then ftl_pulse = 45;
        elseif etEvent:detect(getBPM(levSync, 1, 1), 1, false) then etEvent:resetEvents(true)
        end
        ftl_pulse = ftl_pulse + 0.25 * mFrameTime
        l_setPulseMin(closeValue(ftl_pulse, 45, 70))
        l_setRotationSpeed(rotation * rotdir * rotmult)
    elseif curStyle == "EXSCHLmalfunction" then
            if etEvent:detect(0,                     0, false) then malfRot()
        elseif etEvent:detect(0.05,                  1, false) then rotation = 0
        elseif etEvent:detect(getBPM(levSync, 1, 1), 2, false) then etEvent:resetEvents(true)
        end
    elseif curStyle == "EXSCH1glitched" then
            if etEvent:detect(0,                     0, false) then initGlotch()
        elseif etEvent:detect(getBPM(levSync, 1, 2), 1, false) then etEvent:resetEvents(true)
        end
    elseif curStyle == "EXSCHLsesism" then
        l_setRotationSpeed(u_rndReal() * getRandomDir())
        s_set3dSkew(u_rndReal() * 0.67)
        s_set3dPulseSpeed(u_rndReal() * 5 + 0.05)
        s_set3dPulseMax(u_rndInt(5, 15))
    elseif curStyle == "EXSCH2space" then
        rgb_color = (rgb_color + 120)%360
        forceSetPulse(rgb_color)
        l_setRotationSpeed(rotation * rotdir * rotmult)
    elseif curStyle == "EXSCH2invert_blackwhite" then
            if etEvent:detect(0,                     0, false) then s_setStyle("memoriesreappear_EXSCH2invert_blackwhite") invRot()
        elseif etEvent:detect(getBPM(levSync, 1, 1), 1, false) then s_setStyle("memoriesreappear_EXSCH2invert_whiteblack") invRot()
        elseif etEvent:detect(getBPM(levSync, 1, 2), 2, false) then etEvent:resetEvents(true)
        end
        l_setRotationSpeed(rotation * rotdir * rotmult)
    elseif curStyle == "EXSCH3stutter" then
            if etEvent:detect(0,                     0, false) then l_setRotationSpeed(3.5 * rotdir) s_setStyle("memoriesreappear_EXSCH3stutter")
        elseif etEvent:detect(0.05,                  1, false) then l_setRotationSpeed(0) s_setStyle("memoriesreappear_EXSCH3stutter_main")
        elseif etEvent:detect(getBPM(levSync, 2, 1), 2, false) then etEvent:resetEvents(true)
        end
    elseif curStyle == "EXSCH4radar1" then
            if etEvent:detect(0,   0, false) then s_setStyle("memoriesreappear_EXSCH4radar" .. ((curStyleRadar % 12) + 1)) curStyleRadar = curStyleRadar + 1
        elseif etEvent:detect(0.1, 1, false) then etEvent:resetEvents(true)
        end
        l_setRotationSpeed(rotation * rotdir * rotmult)
    elseif curStyle == "EXSCH4asymptote" then
            if etEvent:detect(0,   0, false) then init3dSpacingShake()
        elseif etEvent:detect(0.1, 1, false) then etEvent:resetEvents(true)
        end
        l_setRotationSpeed(rotation * rotdir * rotmult)
    elseif curStyle == "HXDS3shadB" then
        if s_get3dSpacing() > 80 then shadows_spacingMult = -shadows_spacingMult; s_set3dSpacing(20)        
        elseif s_get3dSpacing() < -80 then shadows_spacingMult = -shadows_spacingMult s_set3dSpacing(-20)    
        else s_set3dSpacing(s_get3dSpacing() + shadows_spacingMult * mFrameTime * 5)
        end
        l_setRotationSpeed(rotation * rotdir * rotmult)
    elseif curStyle == "HXDS3sinkhole" then
        local fall = 1.6
        if s_get3dSpacing() < -350 then s_set3dSpacing(350)
        elseif s_get3dSpacing() > 350 then s_set3dSpacing(-350)
        else s_set3dSpacing(s_get3dSpacing() + fall * mFrameTime * 5)
        end
        l_setRotationSpeed(rotation * rotdir * rotmult)
    else
        if (sh_isFinalEngage) or curStyle == "SHfhexagonest" then l_setRotationSpeed(0) l_setRotation(45)
        else                                                      l_setRotationSpeed(rotation * rotdir * rotmult)
        end
    end

    if u_hasIncrementedManually() then
        rotation = rotation + 0.025
        rotdir = rotdir * -1
        u_setFlashColor(255, 255, 255)
    end

    if l_isPulseActiveOnce() then
    end

    if l_isPulseDetectedOnce() then
        stylePulseCur = -stylePulseCur
        if l_getPulseDetectorTimes() == 9 then s_setStyle("memoriesreappear_rainbowmain") forceSetPulse(-1)
        elseif l_getPulseDetectorTimes() > 12 then
            isNostalgiaStarts = true
            if (l_getPulseDetectorTimes() % 2 == 1) then
                rotmult = 1
                shadows_spacingMult = 1.3
                l_setPulseMin(50)
                l_setPulseMax(70)
                v192ClearWalls()
                if math.floor(u_getDifficultyMult()) == 0 then
                    sh_level = sh_level + 1
                    s_setStyle("memoriesreappear_SH" .. sh_style[closeValue(sh_level, 1, #sh_style)])
                    sh_levelName = sh_levelNames[closeValue(sh_level, 1, 10)]
                    if sh_level == 10 then
                        sh_isFinalEngage = true
                        a_setMusic("[MemoriesReappearSHFL] Antriksh Bali - Memories, Reappear (Paulstretched)")
                        e_messageAddImportant("You've been reached after mega hexagonest.\nGreatestest job.", 120)
                        e_messageAddImportant("You can now beat the high scores\nif you completed this level.", 120)
                    end
                        if sh_level < 4  then getKeySHHexagon()
                    elseif sh_level >= 4 then getKeySHAfterHexagon()
                    end
                else
                    repeat curStyle = styles[u_rndIntUpper(#styles)]
                    until  curStyle ~= oldCurStyle
                    oldCurStyle = curStyle
                    sh_level = sh_levelNumbers[closeValue(u_rndIntUpper(#styles), 1, 10)]
                    s_setStyle("memoriesreappear_" .. curStyle)
                end
                etEvent:resetEvents(true)
                    if curStyle == "SHhexagon"    or curStyle == "SHhhexagon"    or curStyle == "SHmhexagon" then getKeySHHexagon()
                elseif curStyle == "SHhexagoner"  or curStyle == "SHhhexagoner"  or curStyle == "SHmhexagoner" or
                       curStyle == "SHhexagonest" or curStyle == "SHhhexagonest" or curStyle == "SHmhexagonest" or curStyle == "SHfhexagonest" then getKeySHAfterHexagon()
                end
                    if curStyle == "HXDS1cPentagon"  then getKeyHxdsCrazyPent()
                elseif curStyle == "HXDS1rubberer"   then getKeyHxdsHexV1()
                elseif curStyle == "HXDS2r7bberBlue" then getKeyHxdsV2() s_setStyle("memoriesreappear_HXDS2r7bber" .. r7bber_styleCol[u_rndIntUpper(#r7bber_styleCol)])
                elseif curStyle == "HXDS2solaris1"   then getKeyHxdsV2() spawnSolarisCover() s_setStyle("memoriesreappear_HXDS2solaris" .. u_rndIntUpper(3))
                elseif curStyle == "HXDS3shadB"      then getKeyHxdsV2() s_setStyle("memoriesreappear_HXDS3shad" .. shadows_styleCol[u_rndIntUpper(#shadows_styleCol)])
                elseif curStyle == "HXDS3sinkhole"   then getKeyHxdsV2()
                elseif curStyle == "HXDS4pieChartV2" then getKeyHxdsV2()
                else                                      getMainKey()
                end
            end
        end
    end

    if sh_level == 7 then
        if etEvent:detect(0, 0, false) then
            repeat hexest_targetHue = hexest_hues[u_rndIntUpper(#hexest_hues)]
            until  hexest_targetHue ~= hexest_oldHue
            hexest_oldHue = hexest_targetHue
        elseif etEvent:detect(getBPM(levSync, 1, 2), 1, false) then etEvent:resetEvents(true)
        end
        if hexest_targetHue < s_getHueMin() then forceSetHue((s_getHueMin() - 1))
        elseif hexest_targetHue > s_getHueMin() then forceSetHue((s_getHueMin() + 1))
        end
    end
    
    if u_getManualIncrementTimes() <= 2 then
        s_set3dSkew(style3dSkew)
    end
    stylePulse = stylePulse + stylePulseCur * mFrameTime

    if u_getManualIncrementTimes() == 0     then forceSetPulse(stylePulse * 0.0015)
        style3dSkew = convValue(mFrameTime, style3dSkew, 0, 0.05)
    elseif u_getManualIncrementTimes() == 1 then forceSetPulse(stylePulse * 0.00375)
        style3dSkew = convValue(mFrameTime, style3dSkew, 0.15, 0.05)
    elseif u_getManualIncrementTimes() == 2 then forceSetPulse(stylePulse * 0.00625 - 1)
        style3dSkew = convValue(mFrameTime, style3dSkew, 0.3, 0.05)
        if l_getPulseDetectorTimes() == 12 then
            u_setFlashEffect(closeValue(255 - (stylePulse * 5 * mFrameTime), 0, 255))
        end
    elseif u_getManualIncrementTimes() > 2 then
        if (not sh_isFinalEngage) then
            u_setFlashEffect(255 - (stylePulse * 2.5 * mFrameTime))
        end
    end

    if (not sh_isFinalEngage) then
        u_doManualIncrements(getBPM(levSync, 1, 16), 0, 0, 0, 2.15, true);
        l_setPulseDetector(levSync / 4, true, 0, true);
    end
end

-- onDeath is an hardcoded function that is called when the player is killed
function onDeath()
end

-- onPreDeath is an hardcoded function that is called when the player is killed, even
-- in tutorial mode
function onPreDeath()
end

--[[
                                     .....
                                   ..::::::.
                                   .:::::::::.
                                    .:::::::::::::::.......
                               .....::::::::::::::::::::::::....
                            ..:::::::::::::::::::::::::::::::::::...
                         ..::::::::::::::::::::::::::::::::::::::::::..
                       ..:::::::::::::::::::::::::::::::::::::::::::::::.
                     .::::::::::::::::::::::::::::::::::::::::::::::::::::.
                  ..::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
             ..::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
            .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
           .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
           .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
            .::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
            ..::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
             .::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
              .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
              .::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::. ...:::..
              .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
       ........::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
    ..:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
   .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
   .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
   .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
   .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
   .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
    .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
     .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
      .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
       .:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.
         .::::::::::::::::::::::::::::::::::::::::::::::::::^^^^^:::::::::::::^^^^:::..
           ..:::::::::::::::::::::::::::::::::::::^^^^^^^^^^^^^^~^:::::::..::^^^^:
              ....:::::::::::::::::::::::::^^^^^^^^~~~~~~~~~~~~~~:.::::::::^~~~~^:
                  .::::::::::::::::::::^^^^~~~!!!!!!777777777!!!^..:::.:~!!!!!~~^
                  .::::::::::::::::::::^~~!!77??JJJYYYYYJJJ???!:.::....^7?77777!.
                   .::::::^^^^:........:^7?JJJJYYYYYYYYYYYYJ?~:.....:^7Y5YYYYY?:
                     .^^~~~~~!!~^^::::^^::^~7?JYYYYYYYJ?7!~:.!P5YYY5GBBBBGGGP7.
                       :~!7777??JJYY5PGJ:.....::::^^:::....:Y#&&&&&&&###&#BJ^
                         :!?JJJY55PGGBB#P!~^^^^^^^^^^^^^^~JB&&&&#####&#B5!.
                           .~?Y5PGGBBB##&#BPYJ7!!!!!7?J5G#&&#######BPJ!.
                             .:!?5GB########BBBGGGGGBBB#########G5?^.
                        ..........^!?PB##&&&&##BBGGBB##&&###BGJ!:. ..........
                  .................. ^J5PPGGGB##&&&&&##BBBGPY:  ...................
              ....::..................:JYY7..:^~~!!!!~^:J555^ ..............::::::::...
           ...:::......................:P#Y.  ...   .  :YPG!...............:::.::::::::..
         ...::........:..........::.....^B@BJ~.......^Y#&@5..:::::::.....::::::::::::::::..
        ....:.....::..:.::....:........:.^B@@P.......~&@@G:.::::::::::...::::::::::::::::::.
       .:::::::..:..:...........:......:..^G@J.::::::.Y@B^.:::::::::....::::::::::::::::::::.
      .::::::::::::.:::..::.......::::::::.^P7.::::::.!#~.:::::::......::::::::::::::::::::::.
     .......................................::........:^......................................
     ..........................................................................................
    .................................  ...................... .................................
    ..................................     ..............    ...................................
   .   ..........  ....................           .        ...................... ..............
]]