u_execScript("level/memoriesReappear/utils/march31o_common.lua")
u_execScript("level/memoriesReappear/utils/march31o_utils.lua")

--[ Barrages ]--

-- pMarch31osBarrageLeftRights(): spawns a barrage with left-right instead of spiral
--             _gap: the gap of this barrage
--        _distance: the distance of this barrage
-- _isDelayDistance: is distance has an accurate delay in it?
function pMarch31osBarrageLeftRights(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _sizeMult,
                                     _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult,
                                     _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, 1, 1, anythingButNil(_distance, 1), _direction, false,
        (getBooleanNumber(_isDelayDistance) and (anythingButNil(_distance, 1) * 0.333 + 0.667) or 1) * _delMult,
        _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan,
        _spdIsGreaterThanEqual)
end

-- taken from alphapatterns.lua's Vexatious pack by AlphaPromethium
-- pMarch31osWallDisplacer(): spawns a particular pattern with some walls displaced further than the others
function pMarch31osWallDisplacer(_side, _thickness, _iter, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide,
                                 _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1));
    _iter = anythingButNil(_iter, u_rndInt(3, 6));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _displaceSide = {};
    local _displaceSideDifference = false;

    --this loop generates which walls will spawn at what position.. 0 = close; 1 = far
    for i = 1, getProtocolSides(), 1 do _displaceSide[i] = u_rndInt(0, 1); end

    --this loop and the second if statement below will force a difference if there doesn't exist one
    for order = 1, getProtocolSides(), 1 do
        for index = 1, getProtocolSides(), 1 do
            --this compares the two being determined
            if _displaceSide[order] ~= _displaceSide[index] then _displaceSideDifference = true; end
        end
    end
    if not _displaceSideDifference then
        local s = _side; --chooses a random side to differentiate
        _displaceSide[s] = (_displaceSide[s] + 1) % 2;
    end

    --this loop will generate the walls needed at their defined positions
    --remember, the frequency also detemines how many times they will spawn
    for a = 0, _iter - 1, 1 do

        --1st part = spawns close walls
        --2nd part = spawns far walls
        for i = 1, getProtocolSides(), 1 do
            if _displaceSide[i] == a % 2 then cWallEx(i, 0, p_getPatternThickness() * _sizeMult); end
        end

        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osDoubleBarrageSpiralAcross(): spawns a barrage with double hole but across
function pMarch31osDoubleBarrageSpiralAcross(_side, _thickness, _iter, _delMult, _sizeMult, _skipEndDelay,
                                             _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan,
                                             _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(1, 3));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageOffset = 0;

    for a = 0, (math.floor(getProtocolSides() / 2) * 2) * _iter, 1 do

        if (a % (math.floor(getProtocolSides() / 2) * 2)) == 0 then cBarrage(_side, p_getPatternThickness() * _sizeMult); _barrageOffset = 0
        elseif (a % (math.floor(getProtocolSides() / 2) * 2)) > 0 and
            (a % (math.floor(getProtocolSides() / 2) * 2)) < math.floor(getProtocolSides() / 2) then cBarrageDoubleHoled(_side
            - (_barrageOffset / 2), _barrageOffset, 0, p_getPatternThickness() * _sizeMult); _barrageOffset = _barrageOffset
            + 2
        elseif (a % (math.floor(getProtocolSides() / 2) * 2)) >= math.floor(getProtocolSides() / 2) and
            (a % (math.floor(getProtocolSides() / 2) * 2)) < math.floor(getProtocolSides() / 2) * 2 then cBarrageDoubleHoled(_side
            - (_barrageOffset / 2), _barrageOffset, 0, p_getPatternThickness() * _sizeMult); _barrageOffset = _barrageOffset
            - 2
        end
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()))
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osAbstractBarrage(): same as pMarch31osDoubleBarrageSpiralAcross() pattern * -1 (opposite)
function pMarch31osAbstractBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _direction, _skipEndDelay,
                                   _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan,
                                   _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(1, 3));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageLoopDir = _direction;

    for a = 0, (math.floor(getProtocolSides() / 2) * 2) * _iter, 1 do

        cWall(_curSide + a, p_getPatternThickness() * _sizeMult);
        cWall(_curSide - a, p_getPatternThickness() * _sizeMult);
        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osWallExFillerSpiral(): same as Hexadorsip's pSTBBarrageSpiral() pattern, spawns a "small to big" spiral of cWallEx
-- note: this pattern has no amount of times parameter in it because works on all sides
function pMarch31osWallExFillerSpiral(_side, _thickness, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide
                                      , _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageLoopDir = _direction;

    for a = 0, getProtocolSides() - 2, 1 do

        if _barrageLoopDir > 0 then cWallEx(_curSide + a, a, p_getPatternThickness() * _sizeMult);
        else cWallEx(_curSide - (a * 2), a, p_getPatternThickness() * _sizeMult);
        end

        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osDoubleHoledBarrageSpiral(): spawns a doubled hole barrage with spiral displacement
--   _extraHole: extra amount of holes
-- _distPosMult: displacement multiplier. default = 1
function pMarch31osDoubleHoledBarrageSpiral(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _distPosMult,
                                            _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult,
                                            _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    pMarch31osBarrageTypeBase(_side, _thickness, anythingButNil(_iter, u_rndInt(4, 5)), 1,
        2 + anythingButNil(_extraHole, 0), 0, anythingButNil(_distPosMult, 1), _direction, false, _delMult, _sizeMult,
        _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
end

-- pMarch31osDoubleHoledBarrageLeftRights(): spawns a doubled hole barrage with left-right displacement
--   _extraHole: extra amount of holes
-- _distPosMult: displacement multiplier. default = 1
function pMarch31osDoubleHoledBarrageLeftRights(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _distPosMult,
                                                _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay,
                                                _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    pMarch31osBarrageTypeBase(_side, _thickness, anythingButNil(_iter, u_rndInt(4, 5)), 1,
        2 + anythingButNil(_extraHole, 0), 1, anythingButNil(_distPosMult, 1), _direction, false, _delMult, _sizeMult,
        _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
end

-- pMarch31osDoubleHoledBarrageInversions(): spawns a doubled hole barrage with invert displacement
-- _extraHole: extra amount of holes
--  _isSpiral: boolean of spiral 180 dregees displacement
function pMarch31osDoubleHoledBarrageInversions(_side, _thickness, _iter, _extraHole, _isSpiral, _delMult, _sizeMult,
                                                _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay,
                                                _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    pMarch31osBarrageTypeBase(_side, _thickness, anythingButNil(_iter, u_rndInt(4, 5)), 1,
        2 + anythingButNil(_extraHole, 0), (getBooleanNumber(_isSpiral) and 0) or 2,
        (getBooleanNumber(_isSpiral) and math.floor(getProtocolSides() / 2)) or 1, _direction, false, _delMult, _sizeMult
        , _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
end

-- pMarch31osCtoCIBarrage(): spawns one-holed barrage and double-holed barrage
function pMarch31osCtoCIBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _direction, _skipEndDelay,
                                _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan,
                                _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(4, 8));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageLoopDir = _direction;

    for a = 0, _iter, 1 do

        if _barrageLoopDir > 0 then cBarrage(_curSide, p_getPatternThickness() * _sizeMult);
        else cBarrageExHoles(_curSide, 1, p_getPatternThickness() * _sizeMult);
        end

        _barrageLoopDir = _barrageLoopDir * -1
        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osJumbleBarrage(): spawns a jumbled barrage (taken from babadrake's pattern)
-- _chance: amount of randomized wall displacement
function pMarch31osJumbleBarrage(_side, _thickness, _iter, _chance, _delMult, _sizeMult, _skipEndDelay,
                                 _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 4));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    _chance = anythingButNil(_chance, getProtocolSides() - 2);
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);

    for a = 0, _iter, 1 do

        for i = 1, _chance, 1 do cWall(_curSide + u_rndInt(0, getProtocolSides() - 1) % getProtocolSides(),
            p_getPatternThickness() * _sizeMult); end
        t_applyPatDel(customizePatternDelay(2.75 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osSprayBarrage(): spawns a spray barrage (taken from Syyrion's pattern)
-- _delay: amount of delay
-- _extra: amount of extra walls
function pMarch31osSprayBarrage(_side, _thickness, _iter, _delay, _extra, _delMult, _sizeMult, _skipEndDelay,
                                _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 4));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = u_rndInt(0, 1); end
    if _direction < 0 then _direction = 0 elseif _direction > 1 then _direction = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);

    for a = 0, _iter, 1 do
        cWallEx(_curSide + u_rndInt(0, getProtocolSides() - 1) % getProtocolSides(), u_rndInt(0, _extra or 2),
            p_getPatternThickness() * _sizeMult);
        t_applyPatDel(customizePatternDelay((_delay or 4) * _delMult * _sizeMult * _curDelaySpeed,
            p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osOddAltBarrage(): spawns a odd alt barrage
-- _barrageDir: barrage direction
function pMarch31osOddAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _barrageDir, _skipEndDelay,
                                 _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan,
                                 _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 4));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _barrageDir == nil or _barrageDir == 0 then _barrageDir = getRandomDir(); end
    if _barrageDir < -1 then _barrageDir = -1 elseif _barrageDir > 1 then _barrageDir = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDirAlt = -1;
    local _barrageLoopDir = _barrageDir;

    for a = 0, _iter, 1 do

        for i = 1, getProtocolSides(), 1 do
            if _barrageLoopDir > 0 then
                if _barrageLoopDirAlt == -1 then cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); cWall(_curSide
                    + _barrageOffset, p_getPatternThickness() * _sizeMult); end
            else
                if _barrageLoopDirAlt >= 0 then cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); cWall(_curSide
                    + _barrageOffset, p_getPatternThickness() * _sizeMult); end
            end
            _barrageOffset = _barrageOffset + 1;
            _barrageLoopDirAlt = _barrageLoopDirAlt + 1;
            if _barrageLoopDirAlt > 1 then _barrageLoopDirAlt = -1; end
        end
        _barrageOffset = 0;
        _barrageLoopDirAlt = -1;
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osEvenAltBarrage(): spawns a even alt barrage instead of odd ones
-- _barrageDir: barrage direction
function pMarch31osEvenAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _barrageDir, _skipEndDelay,
                                  _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan,
                                  _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 4));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _barrageDir == nil or _barrageDir == 0 then _barrageDir = getRandomDir(); end
    if _barrageDir < -1 then _barrageDir = -1 elseif _barrageDir > 1 then _barrageDir = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDirAlt = 0;
    local _barrageLoopDir = _barrageDir;

    for a = 0, _iter, 1 do

        for i = 1, getProtocolSides(), 1 do
            if _barrageLoopDir > 0 then
                if _barrageLoopDirAlt == 0 then cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); cWall(_curSide
                    + _barrageOffset, p_getPatternThickness() * _sizeMult); end
            else
                if _barrageLoopDirAlt > 0 then cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); cWall(_curSide
                    + _barrageOffset, p_getPatternThickness() * _sizeMult); end
            end
            _barrageOffset = _barrageOffset + 1;
            _barrageLoopDirAlt = _barrageLoopDirAlt + 1;
            if _barrageLoopDirAlt > getHalfSides() - 1 then _barrageLoopDirAlt = 0; end
        end
        _barrageOffset = 0;
        _barrageLoopDirAlt = 0;
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osAltHalfBarrage(): spawns a alternating half-barrage
-- _offset: offset of this wall
function pMarch31osAltHalfBarrage(_side, _thickness, _iter, _offset, _delMult, _sizeMult, _barrageDir, _skipEndDelay,
                                  _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan,
                                  _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(4, 6));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    _offset = anythingButNil(_offset, 0);
    if not _offset or _offset < 0 then _offset = 0; end
    if _barrageDir == nil or _barrageDir == 0 then _barrageDir = getRandomDir(); end
    if _barrageDir < -1 then _barrageDir = -1 elseif _barrageDir > 1 then _barrageDir = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDir = _barrageDir;

    for a = 0, _iter, 1 do

        if _barrageLoopDir > 0 then
            for i = 1, getHalfSides() + _offset, 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
        else
            for i = getHalfSides() + 1, getProtocolSides() + _offset, 1 do cWall(_curSide + i,
                p_getPatternThickness() * _sizeMult); end
        end
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.7 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osAltTrapBarrage(): spawns a alternating trap barrage
--        _gap: gap amount. default = 1
-- _barrageDir: barrage direction
-- _offsetType: offset type. 0 = none, 1 = spiral, 2 = left-right, 3 = inversions
-- _offsetMult: offset multiplier
--  _offsetDir: offset direction
function pMarch31osAltTrapBarrage(_side, _thickness, _iter, _gap, _delMult, _sizeMult, _barrageDir, _offsetType,
                                  _offsetMult, _offsetDir, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult
                                  , _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 5));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    _gap = anythingButNil(_gap, 1);
    _offsetType = anythingButNil(_offsetType, 0);
    if _barrageDir == nil or _barrageDir == 0 or _barrageDir < -1 or _barrageDir > 1 then _barrageDir = -1; end
    if _offsetDir == nil or _offsetDir == 0 or _offsetDir < -1 or _offsetDir > 1 then _offsetDir = getRandomDir(); end
    if _offsetMult == nil or _offsetMult == 0 or _offsetMult < 0 then _offsetMult = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageLoopDir = _barrageDir;
    local _offsetLoopDir = math.ceil(_offsetDir);

    local _typeModeModuloStat = (_offsetType == 1 and getProtocolSides()) or 2; --ye, that's the number to integer converter
    local _typeModeStat = (_offsetType == 0 and 0) or (_offsetType == 3 and getHalfSides()) or 1;
    local _typeModeMultStat = (_offsetType == 0 and 0) or (_offsetType == 3 and 0) or _offsetMult;

    for a = 0, _iter, 1 do

        for i = 1, getProtocolSides(), 1 do
            if _barrageLoopDir < 0 then
                if i > _gap then cWall(_curSide + i +
                    (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _offsetLoopDir),
                    p_getPatternThickness() * _sizeMult); end
            elseif _barrageLoopDir > 0 then
                if i <= _gap then cWall(_curSide + i +
                    (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _offsetLoopDir),
                    p_getPatternThickness() * _sizeMult); end
            end
        end
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osCustomizedAltTrapBarrage(): same as pMarch31osAltTrapBarrage(), but you can personalize everything
-- _mainDirNeigh: barrage direction 1 neighbors. default = 0
--    _capDirGap: barrage direction -1 gap, but extend. default = 1
--   _barrageDir: barrage direction
--   _offsetType: offset type. 0 = none, 1 = spiral, 2 = left-right, 3 = inversions
--   _offsetMult: offset multiplier
--    _offsetDir: offset direction
function pMarch31osCustomizedAltTrapBarrage(_side, _thickness, _iter, _mainDirNeigh, _capDirGap, _delMult, _sizeMult,
                                            _barrageDir, _offsetType, _offsetMult, _offsetDir, _skipEndDelay,
                                            _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan,
                                            _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 5));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    _mainDirNeigh = anythingButNil(_mainDirNeigh, 0);
    _capDirGap = anythingButNil(_capDirGap, 1);
    _offsetType = anythingButNil(_offsetType, 0);
    if _barrageDir == nil or _barrageDir == 0 or _barrageDir < -1 or _barrageDir > 1 then _barrageDir = -1; end
    if _offsetDir == nil or _offsetDir == 0 or _offsetDir < -1 or _offsetDir > 1 then _offsetDir = getRandomDir(); end
    if _offsetMult == nil or _offsetMult == 0 or _offsetMult < 0 then _offsetMult = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageLoopDir = _barrageDir;
    local _offsetLoopDir = math.ceil(_offsetDir);

    local _typeModeModuloStat = (_offsetType == 1 and getProtocolSides()) or 2; --ye, that's the number to integer converter
    local _typeModeStat = (_offsetType == 0 and 0) or (_offsetType == 3 and getHalfSides()) or 1;
    local _typeModeMultStat = (_offsetType == 0 and 0) or (_offsetType == 3 and 0) or _offsetMult;

    for a = 0, _iter, 1 do

        if _barrageLoopDir < 0 then cBarrageN(_curSide +
            (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _typeModeMultStat * _offsetLoopDir),
            _mainDirNeigh, p_getPatternThickness() * _sizeMult);
        elseif _barrageLoopDir > 0 then cWallGrow(_curSide +
            (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _typeModeMultStat * _offsetLoopDir),
            _capDirGap, p_getPatternThickness() * _sizeMult);
        end
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

--[ Spirals ]--

-- pMarch31osRandomWhirlwind(): spawns a spiral of using cWallExThick like the pattern from Hexagonest, Hyper Hexagoner and Hyper Hexagonest but always randomizes the direction. (Spin 2 Failure)
--                            _extra: amount of extras in this cWallMirrorEx
--                      _mirror_step: amount of mirror step
--                      _pos_spacing: position spacing amount where to displace
--                         _seamless: boolean of spiral pattern uses seamless
--                 _slopeAmountStart: amount of slope before spiral pattern spawns
--                   _slopeAmountEnd: amount of slope after spiral pattern spawns
-- [WORKS ONLY ON SIDE < 5] _is_full: boolean of full spiral
function pMarch31osRandomWhirlwind(_side, _iter, _extra, _mirror_step, _pos_spacing, _seamless, _delMult, _sizeMult,
                                   _direction, _slopeAmountStart, _slopeAmountEnd, _is_full, _skipEndDelay,
                                   _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan,
                                   _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(6, 8));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    _extra = anythingButNil(_extra, 0);
    _mirror_step = anythingButNil(_mirror_step, math.floor(getProtocolSides() / 3));
    _pos_spacing = anythingButNil(_pos_spacing, 1);
    _is_full = anythingButNil(_is_full, 0);
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and getRandomDir()) or
        getRandomDir();
    if not _slopeAmountStart or _slopeAmountStart < 0 then _slopeAmountStart = 0; end
    if not _slopeAmountEnd or _slopeAmountEnd < 0 then _slopeAmountEnd = _slopeAmountStart; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentTimesOfDelayAmountForTriangle = 4;
    local currentTimesOfThickStartAmountForSquare, currentTimesEndOfThickAmountForSquare, currentTimesOfThickAmountForGreaterThanSquare = 6
        , 8.25, 2;
    local currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = 3 * (getBooleanNumber(_seamless) and 1.1 or 1) *
        (
        (_addMult or march31oPatDel_AddMult or 1) -
            (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0))) * _delMult; -- adding the 'timesBeforeChangeDir_thickAmountForGreaterThanSquare' value when loops until direction changes
    local currentSizeOverride, currentDelayOverride = 1.25, 0.9;
    local currentTimesOfThickAmount = 2;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    local _curSpiralThick = 2 * (getBooleanNumber(_seamless) and 1.1 or 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _spiralRngLoopDir = getRandomDir();
    local _spiralPosistionOffset = 0;

    _is_full = getBooleanNumber(_is_full);
    if getProtocolSides() == 3 and ((_slopeAmountStart > 0 and _slopeAmountEnd > 0) and _is_full) then
        cBarrage(_curSide + _direction, customizePatternThickness(1 * _sizeMult, p_getDelayPatternBool()));
        for i = 0, 2, 1 do
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _direction;
            t_applyPatDel(customizePatternDelay(4 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        for a = 0, _iter, 1 do
            _spiralRngLoopDir = getRandomDir();
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
            t_applyPatDel(customizePatternDelay(4 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        for i = 0, 2, 1 do
            if i == 2 then currentTimesOfDelayAmountForTriangle = 3; end
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
            t_applyPatDel(customizePatternDelay(currentTimesOfDelayAmountForTriangle * _curDelaySpeed * _delMult *
                _sizeMult, p_getDelayPatternBool()));
        end
        cBarrage(_curSide + _spiralPosistionOffset + _spiralRngLoopDir,
            customizePatternThickness(1 * _sizeMult, p_getDelayPatternBool()));
    elseif getProtocolSides() == 4 and ((_slopeAmountStart > 0 and _slopeAmountEnd > 0) and _is_full) then
        cWall(_curSide + _spiralPosistionOffset,
            customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        _spiralPosistionOffset = _spiralPosistionOffset + _direction;
        for i = 0, 1 do cWall(_curSide + _spiralPosistionOffset + i * _direction,
            customizePatternThickness(5 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
        _spiralPosistionOffset = _spiralPosistionOffset + _direction * 2;
        t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        for a1 = 0, 1 do
            if a1 == 1 then currentTimesOfThickStartAmountForSquare = 7.5; end
            cWall(_curSide + _spiralPosistionOffset,
                customizePatternThickness(currentTimesOfThickStartAmountForSquare * currentSizeOverride * _sizeMult,
                    p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _direction;
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
        if _iter > 0 then currentTimesAmountForSquare = 2;
            for a = 0, _iter + 1, 1 do --1, _iter + 2
                _spiralRngLoopDir = getRandomDir();
                cWall(_curSide + _spiralPosistionOffset,
                    customizePatternThickness(6 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
                t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            end
        else _spiralRngLoopDir = _direction;
        currentTimesAmountForSquare = 1;

        end
        for a2 = 0, currentTimesAmountForSquare, 1 do
            currentTimesEndOfThickAmountForSquare = 8.25;
            if a2 == currentTimesAmountForSquare then currentTimesEndOfThickAmountForSquare = 6; end
            cWall(_curSide + _spiralPosistionOffset,
                customizePatternThickness(currentTimesEndOfThickAmountForSquare * currentSizeOverride * _sizeMult,
                    p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * 2;
        for k = 0, 1 do cWall(_curSide + _spiralPosistionOffset + k * _spiralRngLoopDir,
            customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * 3;
        cBarrage(_curSide + _spiralPosistionOffset,
            customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    else
        if (_slopeAmountStart > 0) then
            for fa = 0, _slopeAmountStart, 1 do
                for ia = 0, _slopeAmountStart - fa, 1 do
                    if ia > 0 then cWallMirrorEx(_curSide - (_direction * _pos_spacing * (ia - 1)), _step, _extra,
                        customizePatternThickness(3 * _delMult * _sizeMult, p_getDelayPatternBool())); end
                end
                cWallMirrorEx(_curSide + (_direction * _pos_spacing * fa) -
                    (_slopeAmountStart * _direction * _pos_spacing), _step, _extra,
                    customizePatternThickness(_curSpiralThick * _delMult * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult,
                    p_getDelayPatternBool()));
                if fa == _slopeAmountStart then _spiralPosistionOffset = _spiralPosistionOffset +
                    (_direction * _pos_spacing); end
            end
        end
        ---------------------- BEFORE RANDOM STARTS ----------------------
        for i = 0, 2, 1 do
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _step, _extra,
                customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + (_direction * _pos_spacing);
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult,
                p_getDelayPatternBool()));
        end
        -------------------------- RANDOM START --------------------------
        for a = 0, _iter, 1 do
            _spiralRngLoopDir = getRandomDir();
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _step, _extra,
                customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * _pos_spacing;
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult,
                p_getDelayPatternBool()));
        end
        ----------------------- AFTER RANDOM STARTS ----------------------
        for i = 0, 2, 1 do
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _step, _extra,
                customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * _pos_spacing;
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult,
                p_getDelayPatternBool()));
            if i == 2 then _spiralPosistionOffset = _spiralPosistionOffset + (_spiralRngLoopDir * _pos_spacing); end
        end
        -------------------------- END OF RANDOM -------------------------
        if (_slopeAmountEnd > 0) then
            for fb = 0, _slopeAmountEnd, 1 do
                if fb == _slopeAmountEnd then currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = _curSpiralThick; end
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide +
                    (_spiralPosistionOffset - (_spiralRngLoopDir * _pos_spacing)) +
                    (_spiralRngLoopDir * _pos_spacing * ib), _step, _extra,
                    customizePatternThickness(currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare * _sizeMult,
                        p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult,
                    p_getDelayPatternBool()));
            end
        end
    end
    t_applyPatDel(customizePatternDelay(2 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osFullWhirlwind(): similiar pattern from Terry's Super Hexagon. same as spiral pattern.
function pMarch31osFullWhirlwind(_side, _iter, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide,
                                 _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(7, 11));
    _delMult = anythingButNil(_delMult, 1);
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) -
        (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _spiralLoopDir = _direction;
    local _spiralPosistionOffset = 0;

    for thickIncAdj = 1, getProtocolSides() - 1, 1 do cWall(_curSide + _spiralPosistionOffset,
        customizePatternThickness(thickIncAdj * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset
        + _spiralLoopDir; end
    t_applyPatDel(customizePatternDelay((getProtocolSides() - 2) * currentSizeOverride * _sizeMult,
        p_getDelayPatternBool()));
    for a = 0, _iter, 1 do
        cWall(_curSide + _spiralPosistionOffset,
            customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
        t_applyPatDel(customizePatternDelay(1.5 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult,
            p_getDelayPatternBool()));
    end
    for thickDecAdj = 0, getProtocolSides() - 3, 1 do
        cWall(_curSide + _spiralPosistionOffset,
            customizePatternThickness((getProtocolSides() - thickDecAdj) * currentSizeOverride * _sizeMult,
                p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
    end
    cWall(_curSide + _spiralPosistionOffset,
        customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
    cBarrage(_curSide + _spiralPosistionOffset,
        customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

-- pMarch31osFullWhirlwindPrototype(): similiar pattern from Terry's Prototype of Super Hexagon. same as spiral pattern.
function pMarch31osFullWhirlwindPrototype(_side, _sizeMult, _direction, _delayMultSpdLessThan, _endAdditionalDelay,
                                          _addMult, _spdIsGreaterThanEqual, _skipEndDelay)
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end
    _isTight = anythingButNil(_isTight, 0);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentSizeOverride = 1.25;
    local spiralPosistionDirMultOffset = 1;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);


    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _spiralLoopDir = _direction;
    local _spiralPosistionOffset = 0;

    for thickIncAdj = 1, getProtocolSides() - 1, 1 do cWall(_curSide + _spiralPosistionOffset,
        customizePatternThickness(thickIncAdj * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset
        + _spiralLoopDir; end
    t_applyPatDel(customizePatternDelay((getProtocolSides() - 2) + 0.5 * currentSizeOverride * _sizeMult,
        p_getDelayPatternBool()));
    for thickDecAdj = 0, getProtocolSides() - 3, 1 do
        if thickDecAdj == getProtocolSides() - 3 then spiralPosistionDirMultOffset = 2; end
        cWall(_curSide + _spiralPosistionOffset,
            customizePatternThickness((getProtocolSides() - thickDecAdj) * currentSizeOverride * _sizeMult,
                p_getDelayPatternBool()));
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir * spiralPosistionDirMultOffset;
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    end
    cBarrage(_curSide + _spiralPosistionOffset,
        customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

-- pMarch31osZigZagSpiral(): taken from baba's line pack, same as spiral pattern
function pMarch31osZigZagSpiral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _width, _delMult, _sizeMult,
                                _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult,
                                _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    pMarch31osTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, anythingButNil(_iter, u_rndInt(3, 7)), 0, 2, 2,
        false, false, 0, 0, 1, 1, false, false, 0, 1, false, getBarrageSide(1 + anythingButNil(_width, 2)), nil, 0, nil,
        _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult,
        _delayMultSpdLessThan, _spdIsGreaterThanEqual)
end

--[ Additional cage barrages ]--

-- pMarch31osXer(): taken from kayden's takarazed pack, made by me
function pMarch31osXer(_side, _skipEndDelay, _isRebootingSide, _endAdditionalDelay)
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _currentOffset = 1;

    cWall(_curSide, 110);
    t_applyPatDel(getPerfectDelay(THICKNESS) * 2.5);
    for a = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
        cWall(_curSide - _currentOffset);
        cWall(_curSide + _currentOffset);
        _currentOffset = _currentOffset + 1;
        t_applyPatDel(getPerfectDelay(THICKNESS) / 1.2);
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osGrowingBarrage(): taken from baba's old pattern, made by me
function pMarch31osGrowingBarrage(_side, _skipEndDelay, _isRebootingSide, _endAdditionalDelay)
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide +
        getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _currentOffset = 0;
    local _amountOfGrow = 1;

    p_resetPatternDelaySettings();

    for a = 0, getHalfSides() - 2, 1 do

        for i = -_amountOfGrow, _amountOfGrow - 1, 1 do cWall(_curSide + i); end
        _amountOfGrow = _amountOfGrow + 1;
        t_applyPatDel(getPerfectDelay(THICKNESS) / 1.2);
    end

    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) +
        (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end
