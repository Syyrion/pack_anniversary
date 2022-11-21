u_execScript("level/memoriesReappear/utils/march31o_common.lua")
u_execScript("level/memoriesReappear/utils/march31o_utils.lua")
u_execScript("level/memoriesReappear/utils/march31o_utility_classes.lua")
u_execScript("level/memoriesReappear/patterns/march31o_patterns_common.lua")
u_execScript("level/memoriesReappear/patterns/march31o_patterns_additional.lua")
u_execScript("level/memoriesReappear/patterns/march31o_patterns_additional_tunnel.lua")

function spawnMainPattern(mNumbSpawn)
    local _side = getRandomSide();

    if mNumbSpawn == 0 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(2, 4), false, false, 1, 0
        , 1, false, 1, 1, getRandomDir())
    elseif mNumbSpawn == 1 then pMarch31osExWhirlwind(_side, u_rndInt(7, 11), 1, 0, 0, getPolySides(3, "floor"), 1, true
        , 1, 1, getRandomDir(), 1, 1, 1, true)
    elseif mNumbSpawn == 2 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(0, 3), 1, 1, false, 1, 1,
        getRandomDir())
    elseif mNumbSpawn == 3 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(0, 2), 1, 2, false, 1.2, 1
        , getRandomDir())
    elseif mNumbSpawn == 4 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, false, 0.7, 1,
        getRandomDir())
    elseif mNumbSpawn == 5 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 1, 1, true, 1, 1, u_rndInt(0, 1))
    elseif mNumbSpawn == 6 then pMarch31osTunnel(_side, march31oPat_thickness * 1.75, nil, u_rndIntUpper(3),
        u_rndInt(1, getProtocolSides() - 2), 1, 1, u_rndInt(0, 1), 0, 0, true)
    elseif mNumbSpawn == 7 then pMarch31osWallStrip(_side, march31oPat_thickness, u_rndInt(0, 1),
        u_rndInt(0, 1) == 0 and getPolySides(2, "floor") or 2, 0, 1, 1, u_rndInt(0, 1))
    elseif mNumbSpawn == 8 then pMarch31osVortaBarrage(_side, march31oPat_thickness, u_rndIntUpper(3), 0, 1, {}, 1, 0, 1
        , 1, getRandomDir())
    elseif mNumbSpawn == 9 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(4, 6), 1, 1, false, 0.5, 1
        , getRandomDir())
    elseif mNumbSpawn == 10 then pMarch31osRandomBarrage(_side, march31oPat_thickness, u_rndInt(2, 4), nil, nil, true,
        true, 1, 1)

    elseif mNumbSpawn == 11 then
        local _gapOffset = u_rndInt(1, getProtocolSides() - 2);
        pMarch31osTunnel(_side, march31oPat_thickness, nil, u_rndInt(4, 6), 1, 0.5, 1, u_rndInt(0, 1), 0, 0, true, false
            , _gapOffset, getProtocolSides() - (_gapOffset + 1))
    elseif mNumbSpawn == 12 then pMarch31osExWhirlwind(_side, u_rndInt(4, 7), 1, u_rndInt(1, 2), 0,
        getPolySides(3, "floor"), 1, true, 1, 1, getRandomDir(), 1, 1, 1, true)
    elseif mNumbSpawn == 13 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(2, 4), true, true, 0
        , 1, 2, false, 1, 1, getRandomDir())
    elseif mNumbSpawn == 14 then pMarch31osAlternatingTunnel(_side, march31oPat_thickness, nil, u_rndInt(3, 5),
        getProtocolSides() > 4 and getHalfSides("floor") or 1, 1, 1, getRandomDir(), 0, true)
    elseif mNumbSpawn == 15 then pMarch31osVortaBarrage(_side, march31oPat_thickness, u_rndInt(4, 6), 0, 0, {}, 1, 0, 1,
        1, getRandomDir())
    elseif mNumbSpawn == 16 then pMarch31osGrowingBarrage(_side)
    elseif mNumbSpawn == 17 then pMarch31osDoubleHoledBarrageSpiral(_side, march31oPat_thickness, u_rndInt(5, 9), 0, 1, 1
        , 1, getRandomDir())
    elseif mNumbSpawn == 18 then pMarch31osDoubleHoledBarrageLeftRights(_side, march31oPat_thickness, u_rndInt(5, 8), 0,
        1, 1, 1, getRandomDir())
    elseif mNumbSpawn == 19 then pMarch31osDoubleHoledBarrageInversions(_side, march31oPat_thickness, u_rndInt(6, 9), 0,
        true, 1, 1, getRandomDir())

    elseif mNumbSpawn == 20 then pMarch31osBarrageLeftRights(_side, march31oPat_thickness, u_rndInt(4, 6), 1,
        u_rndIntUpper(2), true, 1, 1, getRandomDir())
    elseif mNumbSpawn == 21 then pMarch31osJumbleBarrage(_side, march31oPat_thickness, u_rndInt(3, 4),
        getProtocolSides() - 2, 1.4, 1)
    elseif mNumbSpawn == 22 then pMarch31osOddAltBarrage(_side, march31oPat_thickness, u_rndInt(3, 4), 1, 1,
        getRandomDir())
    elseif mNumbSpawn == 23 then pMarch31osAltHalfBarrage(_side, march31oPat_thickness, u_rndInt(4, 6), 0, 1, 1,
        getRandomDir())
    elseif mNumbSpawn == 24 then pMarch31osAltTrapBarrage(_side, march31oPat_thickness, u_rndInt(3, 5), 1, 1, 1, -1, 0, 1
        , getRandomDir())

    elseif mNumbSpawn == 25 then pMarch31osRandomBarrageTunnel(_side, march31oPat_thickness, nil, u_rndInt(2, 4), 1, true
        , true, 1, 1)
    elseif mNumbSpawn == 26 then pMarch31osLRTunnelShortSpiral(_side, march31oPat_thickness, nil, 1, false, 1, 1,
        getRandomDir())
    elseif mNumbSpawn == 27 then pMarch31osJumbleTunnel(_side, march31oPat_thickness, nil, u_rndInt(3, 4), 1,
        getProtocolSides() - 3, 1.4, 1)
    elseif mNumbSpawn == 28 then
        local _mode = u_rndInt(0, 1)
        pMarch31osTunnel(_side, march31oPat_thickness, nil, u_rndIntUpper(4),
            _mode == 1 and math.floor(getProtocolSides() / 2) + 2 or getProtocolSides() - 1, 1, 1, u_rndInt(0, 1), 0, 1,
            true)

    elseif mNumbSpawn == 29 then pMarch31osBackAndForthTunnelAxisInterpolated(_side, march31oPat_thickness, nil,
        u_rndInt(4, 6), 0, 0, 0, 0, 1, 1, u_rndInt(0, 1), 0, true)
    elseif mNumbSpawn == 30 then pMarch31osTrapAround(_side, u_rndInt(0, 2), 0, "trap", false, false, 1, 1)
    elseif mNumbSpawn == 31 and getProtocolSides() > 5 then pMarch31osTrapAround(_side, 0, u_rndInt(4, 6), nil, false,
        false, 1, 1)
    elseif mNumbSpawn == 32 then pMarch31osAccurateBat(_side, "all", false, false, 1, 1)
    end
end

function getMainKey()
    getKeys = { 0, 0, 1, 1, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 10, 10, 10, 11, 12, 13, 14, 15, 15, 16, 16,
        16, 16, 17, 18, 19, 20, 20, 21, 21, 21, 22, 22, 23, 23, 24, 24, 25, 26, 26, 27, 28, 28, 29, 30, 31, 32, 32 }
    shuffle(getKeys)
    pat_index = 0
end

function getKeyBasic()
    getKeys = { 0, 0, 1, 1, 1, 1, 2, 2, 4, 4, 5, 5, 6, 6, 7, 7, 10, 10, 10, 11, 14, 20, 20, 21, 21, 21, 22, 22, 23, 23,
        24, 24, 25, 28, 28, 30, 31 }
    shuffle(getKeys)
    keys_index = 0
end

function spawnExschPattern(mNumbSpawn)
    local _side = getRandomSide();
    if mNumbSpawn == 0 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(3, 5), true, false, 0, 0
        , 2, false, 1, 1, getRandomDir())
    elseif mNumbSpawn == 1 then pMarch31osExWhirlwind(_side, u_rndInt(3, 6), 1, 0, 0, getPolySides(3, "floor"), 1, true,
        1, 1, getRandomDir(), 0, 0, 0, false)
    elseif mNumbSpawn == 2 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(0, 3), 1, 1, false, 1, 1,
        getRandomDir())
    elseif mNumbSpawn == 3 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(0, 2), 1, 2, false, 1.2, 1
        , getRandomDir())
    elseif mNumbSpawn == 4 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, false, 0.7, 1,
        getRandomDir())
    elseif mNumbSpawn == 5 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 1, 1, true, 1, 1, u_rndInt(0, 1))
    elseif mNumbSpawn == 6 then pMarch31osTunnel(_side, march31oPat_thickness * 1.75, nil, u_rndIntUpper(3),
        u_rndInt(1, getProtocolSides() - 2), 1, 1, u_rndInt(0, 1), 0, 0, true)
    elseif mNumbSpawn == 7 then pMarch31osWallStrip(_side, march31oPat_thickness, u_rndInt(0, 1),
        u_rndInt(0, 1) == 0 and getPolySides(2, "ceil") or 2, 0, 1, 1, u_rndInt(0, 1))
    elseif mNumbSpawn == 8 and getProtocolSides() > 5 then pMarch31osVortaBarrage(_side, march31oPat_thickness,
        u_rndIntUpper(3), 0, 1, {}, 1, 0, 1, 1, getRandomDir())
    elseif mNumbSpawn == 9 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(4, 6), 1, 1, false, 0.5, 1
        , getRandomDir())
    elseif mNumbSpawn == 10 then pMarch31osRandomBarrage(_side, march31oPat_thickness, u_rndInt(2, 4), nil, nil, true,
        true, 1, 1)
    elseif mNumbSpawn == 11 then pMarch31osBackAndForthTunnelCentral(_side, march31oPat_thickness * 2, nil,
        u_rndIntUpper(2) * 2, 0, 0, 0, 0, 1, 1, u_rndInt(0, 1), 0, true)
    elseif mNumbSpawn == 12 then pMarch31osTrapAround(_side, 0, 0, "wrap", false, false, 1, 1)
    elseif mNumbSpawn == 13 then
        local _gapOffset = u_rndInt(1, getProtocolSides() - 2);
        pMarch31osTunnel(_side, march31oPat_thickness, nil, u_rndInt(2, 4) * 2 - 1, 1, 0.5, 1, u_rndInt(0, 1), 0, 0,
            false, true, _gapOffset, getProtocolSides() - (_gapOffset + 1), 0, 0)
    end
end

function getKeyExsch()
    getKeys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 7, 8, 10, 10, 10, 11, 12, 13 }
    shuffle(getKeys)
    pat_index = 0
end

function spawnHxdsHexV1Pattern(mNumbSpawn)
    local _side = getRandomSide();
    if mNumbSpawn == 0 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(3, 5), true, false, 0, 0
        , 2, false, 1, 1, getRandomDir())
    elseif mNumbSpawn == 1 and getProtocolSides() > 5 then pMarch31osWallStrip(_side, march31oPat_thickness, 1,
        getPolySides(2, "ceil"), 0, 1, 1, true)
    elseif mNumbSpawn == 2 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(2, 3), 1, 1, false, 1, 1,
        -1)
    elseif mNumbSpawn == 3 and getProtocolSides() > 5 then pMarch31osBackAndForthTunnelCentral(_side,
        march31oPat_thickness * 2, nil, u_rndInt(3, 4) * 2, 0, 0, 0, 0, 1, 1, u_rndInt(0, 1), 0, true)
    elseif mNumbSpawn == 4 then pMarch31osBarrageSpiralRev(_side, march31oPat_thickness, u_rndIntUpper(3), 1, 1, 1, 1,
        false, 1, 1, getRandomDir())
    elseif mNumbSpawn == 5 then pMarch31osBarrageReversals(_side, march31oPat_thickness, u_rndIntUpper(2) * 2 + 1, 1,
        true, 1, 1, u_rndInt(0, 1))
    elseif mNumbSpawn == 6 and getProtocolSides() > 3 then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 2, 0, 1,
        1, false)
    elseif mNumbSpawn == 7 and getProtocolSides() > 3 then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 2, 0, 1,
        1, true)
    elseif mNumbSpawn == 8 and getProtocolSides() > 4 then pMarch31osRandomBarrage(_side, march31oPat_thickness,
        u_rndInt(2, 4), nil, nil, true, true, 1, 1)
    elseif mNumbSpawn == 9 then pMarch31osTunnel(_side, march31oPat_thickness * 2, nil, u_rndIntUpper(2), 1, 1, 1,
        u_rndInt(0, 1), 0, 0, true)
    elseif mNumbSpawn == 10 and getProtocolSides() > 4 then pMarch31osTunnel(_side, march31oPat_thickness * 2, nil,
        u_rndInt(2, 3) * 2 - 1, getProtocolSides() - 2, 1, 1, u_rndInt(0, 1), 0, 0, true)
    elseif mNumbSpawn == 11 then pMarch31osVortaBarrage(_side, march31oPat_thickness, 3, 0, 0, {}, 1, 0, 1, 1,
        getRandomDir())
    elseif mNumbSpawn == 12 then pMarch31osBarrageLeftRights(_side, march31oPat_thickness, u_rndInt(2, 3) * 2, 1, 1, true
        , 1, 1, getRandomDir())
    elseif mNumbSpawn == 13 and getProtocolSides() > 4 then pMarch31osWallStrip(_side, march31oPat_thickness, 1,
        getPolySides(2, "ceil"), 0, 1, 1, false)
    end
end

function getKeyHxdsHexV1()
    getKeys = { 0, 0, 1, 2, 3, 3, 4, 5, 5, 6, 7, 8, 8, 9, 10, 11, 12, 12, 13 }
    shuffle(getKeys)
    pat_index = 0
end

function spawnHxdsCrazyPentPattern(mNumbSpawn)
    if mNumbSpawn == 0 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(3, 4), true, false, 0, 0
        , 2, false, 1, 1, getRandomDir())
    elseif mNumbSpawn == 1 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(2, 4), 1, 1, false, 0.65,
        1, -1)
    elseif mNumbSpawn == 2 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(2, 3), 1, 1, false, 0.55,
        1, -1)
    elseif mNumbSpawn == 3 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 1, 1, false, 1.3, 1,
        u_rndInt(0, 1))
    elseif mNumbSpawn == 4 then pMarch31osBarrageSpiralRev(_side, march31oPat_thickness, u_rndIntUpper(3), 1, 1, 1, 1,
        false, 1, 1, getRandomDir())
    elseif mNumbSpawn == 5 then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 2, 0, 1, 1, false)
    elseif mNumbSpawn == 6 then pMarch31osBarrageReversals(_side, march31oPat_thickness, u_rndIntUpper(2) * 2 - 1, 1,
        false, 1.3, 1, u_rndInt(0, 1))
    elseif mNumbSpawn == 7 then pMarch31osTunnel(_side, march31oPat_thickness * 2, nil, u_rndInt(1, 2) * 2 - 1, 2, 1, 1,
        u_rndInt(0, 1), 0, 0, true)
    elseif mNumbSpawn == 8 then pMarch31osTunnel(_side, march31oPat_thickness * 2, nil, u_rndInt(3, 4), 1, 1, 1,
        u_rndInt(0, 1), 0, 0, true)
    elseif mNumbSpawn == 9 then pMarch31osRandomBarrage(_side, march31oPat_thickness, u_rndInt(2, 5), nil, nil, true,
        true, 1, 1)
    elseif mNumbSpawn == 10 then pMarch31osAccurateBat(_side, "all", false, false, 1, 1)
    elseif mNumbSpawn == 11 then pMarch31osRandomBarrage(_side, march31oPat_thickness, u_rndInt(4, 7), nil, nil, true,
        true, 1, 1)
    elseif mNumbSpawn == 12 then pMarch31osAltHalfBarrage(_side, march31oPat_thickness, u_rndIntUpper(2) * 2 - 1, 0, 1, 1
        , getRandomDir())
    elseif mNumbSpawn == 13 then pMarch31osVortaBarrage(_side, march31oPat_thickness, u_rndIntUpper(3), 0, 1, {}, 1, 0, 1
        , 1, getRandomDir())
    elseif mNumbSpawn == 14 then pMarch31osVortaBarrage(_side, march31oPat_thickness, 0, 2, 1, { 2, 4, 1 }, 1, 0, 1, 1,
        getRandomDir())
    elseif mNumbSpawn == 15 then pMarch31osBarrageLeftRights(_side, march31oPat_thickness, u_rndInt(2, 3) * 2, 1, 1, true
        , 1, 1, getRandomDir())
    elseif mNumbSpawn == 16 then pMarch31osTunnel(_side, march31oPat_thickness * 2, nil, u_rndInt(6, 9) * 2 - 1,
        getProtocolSides() - 2, 1, 1, u_rndInt(0, 1), 0, 0, true)
    end
end

function getKeyHxdsCrazyPent()
    getKeys = { 0, 1, 2, 2, 3, 4, 5, 6, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 }
    shuffle(getKeys)
    keys_index = 0
end

function spawnHxdsV2Pattern(mNumbSpawn, bIsGearTeeth)
    local _side = getRandomSide();
    local _gearTeethMult = bIsGearTeeth and 1 or 0

    if mNumbSpawn == 0 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(3, 4), true, false, 0, 0
        , 2, false, 1, 1, getRandomDir())
    elseif mNumbSpawn == 1 then pMarch31osTunnel(_side, march31oPat_thickness * 1.75, nil, u_rndInt(2, 3) * 2 - 1,
        getProtocolSides() - 2, 1, 1, u_rndInt(0, 1), 0, 0, true)
    elseif mNumbSpawn == 2 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(2, 3), 1, 1, false, 1, 1,
        getRandomDir())
    elseif mNumbSpawn == 3 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(2, 3), 1, 2, false, 1.2, 1
        , getRandomDir())
    elseif mNumbSpawn == 4 then pMarch31osBarrageSpiralRev(_side, march31oPat_thickness, 4, 1, 1, 1, 1, false, 1, 1,
        getRandomDir())
    elseif mNumbSpawn == 5 then pMarch31osWallStrip(_side, march31oPat_thickness, u_rndInt(0, 1), 2, 0, 1, 1,
        u_rndInt(0, 1)) t_applyPatDel(5)
    elseif mNumbSpawn == 6 then pMarch31osRandomBarrage(_side, march31oPat_thickness, u_rndInt(2, 4), nil, nil, true,
        true, 1, 1)
    elseif mNumbSpawn == 7 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 1, 1, true, 1, 1, u_rndInt(0, 1))
    elseif mNumbSpawn == 8 then pMarch31osTunnel(_side, march31oPat_thickness, nil, 3,
        u_rndInt(1, getProtocolSides() - 2), 1, 1, u_rndInt(0, 1), 0, 0, true, true, 1, 1, 0, 0, _gearTeethMult, nil)
    elseif mNumbSpawn == 9 then
        local _gapOffset = u_rndInt(1, getProtocolSides() - 2);
        pMarch31osTunnel(_side, march31oPat_thickness, nil, u_rndInt(4, 6), 1, 0.55, 1, u_rndInt(0, 1), 0, 0, true, true
            , _gapOffset, getProtocolSides() - (_gapOffset + 1), 0, 0, _gearTeethMult, nil)
    elseif mNumbSpawn == 10 then pMarch31osVortaBarrage(_side, march31oPat_thickness, u_rndIntUpper(3), 0, 1, {}, 1, 0, 1
        , 1, getRandomDir())
    elseif mNumbSpawn == 11 then pMarch31osTrapAround(_side, 0, 0, "wrap", false, false, 1, 1)
    elseif mNumbSpawn == 12 then pMarch31osExWhirlwind(_side, u_rndInt(5, 8), 1, 0, 0, getPolySides(3, "floor"), 1, true
        , 1, 1, getRandomDir(), 0, 0, 0, false)
    elseif mNumbSpawn == 13 then pMarch31osExWhirlwind(_side, u_rndInt(12, 15), 1, 0, 0, 1, 1, true, 0.75, 1,
        getRandomDir(), 0, 0, 0, false)
    elseif mNumbSpawn == 14 then pMarch31osVortaBarrage(_side, march31oPat_thickness, 0, u_rndInt(1, 2) * 2 - 1, 1, {}, 1
        , 0, 1, 1, getRandomDir())
    elseif mNumbSpawn == 15 then pMarch31osWallStrip(_side, march31oPat_thickness, u_rndInt(0, 1),
        getPolySides(2, "ceil"), 0, 1, 1, u_rndInt(0, 1)) t_applyPatDel(6)
    elseif mNumbSpawn == 16 then pMarch31osAccurateBat(_side, "all", false, false, 1, 1)
    elseif mNumbSpawn == 17 then pMarch31osEvenAltBarrage(_side, march31oPat_thickness, u_rndInt(2, 3) * 2 - 1, 1, 1, -1)
    end
end

function getKeyHxdsV2()
    getKeys = { 0, 1, 2, 2, 3, 4, 5, 6, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 }
    shuffle(getKeys)
    keys_index = 0
end

function spawnSHPattern(mNumbSpawn, mSpawnType, bIsHyper, bIsFinalEngage)
    local _side = getRandomSide();

    -- SOLO PALLETE
    if mNumbSpawn == 0 then rWall(_side, march31oPat_thickness); t_wait(getPerfectDelayDM(THICKNESS) * 11);
    elseif mNumbSpawn == 1 then cAltBarrage(_side, 2, march31oPat_thickness); t_wait(getPerfectDelayDM(THICKNESS) * 11);
    elseif mNumbSpawn == 2 then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 2, 0, 1, 1, false);
    elseif mNumbSpawn == 3 and getProtocolSides() >= 5 then pMarch31osWallStrip(_side, march31oPat_thickness, 1,
        getHalfSides("ceil"), 0, 1, 1, false);
    elseif mNumbSpawn == 4 then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 2, 0, 1, 1, true);
    elseif mNumbSpawn == 5 and getProtocolSides() >= 5 then pMarch31osWallStrip(_side, march31oPat_thickness, 1,
        getHalfSides("ceil"), 0, 1, 1, true);
    elseif mNumbSpawn == 6 and getProtocolSides() == 6 then cBarrageExHoles(_side, 1, march31oPat_thickness); t_wait(getPerfectDelayDM(THICKNESS)
        * 11);
    elseif mNumbSpawn == 7 then cBarrage(_side, march31oPat_thickness); t_wait(getPerfectDelayDM(THICKNESS) * 11);
    end

    -- NORMAL PALLETE
    if mSpawnType == 0 then
        if mNumbSpawn == 8 and getProtocolSides() == 4 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, 1, 1, 1
            , false, 1, 1, getRandomDir());
        elseif mNumbSpawn == 9 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 2, 1, false, 0.75, 1,
            u_rndInt(0, 1));
        elseif mNumbSpawn == 10 then
            if getProtocolSides() == 6 then pMarch31osFullWhirlwind(_side, 6, 1, 1, getRandomDir());
            elseif getProtocolSides() == 4 then pMarch31osExWhirlwind(_side, 0, 1, 0, 0, getPolySides(3, "floor"), 1,
                true, 1, 1, getRandomDir(), 1, 1, 1, true)
            end
        elseif mNumbSpawn == 11 and getProtocolSides() == 4 then pMarch31osAltTrapBarrage(_side, march31oPat_thickness, 1
            , 1, 1, 1, -1, 0, 1, 1);
        elseif mNumbSpawn == 12 and getProtocolSides() >= 5 then pMarch31osAccurateBat(_side, "all", false, false, 1, 1);
        elseif mNumbSpawn == 13 and getProtocolSides() == 6 then pMarch31osBackAndForthTunnelCentral(_side,
            march31oPat_thickness * 2, nil, 4, 0, 0, 0, 0, 1, 1, u_rndInt(0, 1), 0, true);
        elseif mNumbSpawn == 14 and (bIsHyper) and getProtocolSides() == 6 then pMarch31osVortaBarrage(_side,
            march31oPat_thickness, 4, 0, 0, {}, 0, 0, 1, 1, 1);
        elseif mNumbSpawn == 15 and (bIsHyper) and getProtocolSides() == 6 then pMarch31osTrapAround(_side, 0, 0, "trap"
            , false, false, 1, 1);
        end
    elseif mSpawnType == 1 then
        if mNumbSpawn == 8 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 2, 1, false, 1, 1,
            u_rndInt(0, 1));
        elseif mNumbSpawn == 9 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, 5, 1, 1, false, 1, 1,
            getRandomDir());
        elseif mNumbSpawn == 10 and (bIsHyper) then pMarch31osExWhirlwind(_side, 4, 1, 0, 0, getPolySides(3, "floor"), 1
            , true, 1, 1, getRandomDir(), 1, 1, 1, true);
        elseif mNumbSpawn == 11 then pMarch31osAccurateBat(_side, "all", false, false, 1, 1);
        elseif mNumbSpawn == 12 then pMarch31osTrapAround(_side, 0, 0, "trap", false, false, 1, 1);
        elseif mNumbSpawn == 13 then pMarch31osBackAndForthTunnelCentral(_side, march31oPat_thickness * 2, nil, 4, 0, 0,
            0, 0, 1, 1, u_rndInt(0, 1), 0, true);
        elseif mNumbSpawn == 14 and (not bIsHyper) then pMarch31osTunnel(_side, march31oPat_thickness, nil, 2, 1, 1, 1, 0
            , 0, 0, true, true)
        elseif mNumbSpawn == 15 and (bIsHyper) then pMarch31osTunnel(_side, march31oPat_thickness, nil, 3, 2, 1, 1, 1, 0
            , 0, true, true, 1, 1, 0, 0, 1, nil, 1, 1, true)
        elseif mNumbSpawn == 16 and (not bIsHyper) then pMarch31osTunnel(_side, march31oPat_thickness, nil, 5, 1, 0.5, 1, 1
            , 0, 0, true, true, 2, 2)
        elseif mNumbSpawn == 17 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, 4, false, false, 0, 0, 2
            , false, 1, 1, getRandomDir());
        end
    elseif mSpawnType == 2 then
        if mNumbSpawn == 8 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 2, 1, false, 1, 1,
            u_rndInt(0, 1));
        elseif mNumbSpawn == 9 and (bIsFinalEngage) then pMarch31osBarrageSpiral(_side, march31oPat_thickness, 5, 1, 1,
            false, 1, 1, getRandomDir());
        elseif mNumbSpawn == 10 then pMarch31osExWhirlwind(_side, 4, 1, 0, 0, getPolySides(3, "floor"), 1, true, 1, 1,
            getRandomDir(), 1, 1, 1, true);
        elseif mNumbSpawn == 11 and (bIsFinalEngage) then pMarch31osVortaBarrage(_side, march31oPat_thickness, 4, 0, 0,
            {}, 0, 0, 1, 1, 1);
        elseif mNumbSpawn == 12 then pMarch31osVortaBarrage(_side, march31oPat_thickness, 0, 2, 0, { 1, 3 }, 0, 0, 1, 1,
            1);
        elseif mNumbSpawn == 13 then pMarch31osTrapAround(_side, 0, 0, "trap", false, false, 1, 1);
        elseif mNumbSpawn == 14 and (bIsFinalEngage) then pMarch31osBackAndForthTunnelCentral(_side,
            march31oPat_thickness * 2, nil, 4, 0, 0, 0, 0, 1, 1, u_rndInt(0, 1), 0, true);
        elseif mNumbSpawn == 15 and (bIsFinalEngage) then pMarch31osTunnel(_side, march31oPat_thickness, nil, 2, 1, 1, 1
            , 0, 0, 0, true, true);
        elseif mNumbSpawn == 16 then pMarch31osTunnel(_side, march31oPat_thickness, nil, 3, 2, 1, 1, 1, 0, 0, true, true
            , 1, 1, 0, 0, 1, nil, 1, 1, true);
        elseif mNumbSpawn == 17 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, 4, false, false, 0, 0, 2
            , false, 1, 1, getRandomDir());
        end
    end
end

function getKeySHHexagon()
    getKeys = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }
    shuffle(getKeys)
    pat_index = 0
end

function getKeySHAfterHexagon()
    getKeys = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 }
    shuffle(getKeys)
    pat_index = 0
end
