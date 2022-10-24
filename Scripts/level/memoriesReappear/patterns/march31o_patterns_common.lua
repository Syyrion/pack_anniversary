u_execScript("level/memoriesReappear/utils/march31o_common.lua")
u_execScript("level/memoriesReappear/utils/march31o_utils.lua")

--[[
    void pMarch31osBarrage(_side, _thickness, _neighbors, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osBarrage(_side, _thickness) --, 0, 1, false, false, 0, 1, 2
    void pMarch31osRandomBarrages(_side, _thickness, _iter, _distMin, _distMax, _isRepeat, _isDelayDistance, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osRandomBarrages(_side, _thickness, _iter) --, -getHalfSides("floor"), getHalfSides("floor"), true, true, 1, 1, false, false, 0, 1, 1, 2
    void pMarch31osAlternatingBarrage(_side, _thickness, _iter, _isSpiral, _hasContainedEnd, _gapLength, _repeatBarrageAmount, _repeatBarrageDelay, _isRepeatBarrageDelaySpd, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osAlternatingBarrage(_side, _thickness, _iter) --, false, false, 0, 0, 2, false, 1, 1, getRandomDir(), false, false, 0, 1, 1, 2
    void pMarch31osVortaBarrage(_side, _thickness, _iter, _dirType, _revFreq, _dirPoints, _modeType, _free, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osVortaBarrage(_side, _thickness, _iter) --, 0, 1, {math.floor(_iter / 2)}, 0, 0, 1, 1, getRandomDir(), false, false, 0, 1, 1, 2
    void pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, _holes, _offsetType, _offsetDistance, _mainLoopDir, _isInvertAccurate, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osBarrageTypeBase(_side, _thickness, _iter) --, 1, 1, 1, 1, getRandomDir(), false, 1, 1, false, false, 0, 1, 1, 2
    void pMarch31osBarrageSpiral(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osBarrageSpiral(_side, _thickness, _iter) --, 1, 1, false, 1, 1, getRandomDir(), false, false, 0, 1, 1, 2
    void pMarch31osBarrageSpiralRev(_side, _thickness, _iter, _revFreq, _gap, _holes, _distance, _isDelayDistance, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osBarrageSpiralRev(_side, _thickness, _iter) --, _revFreq, 1, 1, 1, 1, 1, getRandomDir(), false, false, 0, 1, 1, 2
    void pMarch31osBarrageReversals(_side, _thickness, _iter, _gap, _isInvertAccurate, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osBarrageReversals(_side, _thickness, _iter) --, 1, false, 1, 1, u_rndInt(0, 1), false, false, 0, 1, 1, 2
    void pMarch31osWallStrip(_side, _thickness, _repetitions, _mirrorStep, _extraWidth, _delMult, _sizeMult, _isThickness, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osWallStrip(_side, _thickness, _repetitions) --, u_rndInt(2, 3), 0, 1, 1, u_rndInt(0, 1), false, false, 0, 1, 1, 2

    void pMarch31osWhirlwind(_side, _iter, _extraWidth, _mirrorStep, _posSpacing, _seamless, _delMult, _sizeMult, _direction, _slopeAmountStart, _slopeAmountEnd, _is_full, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osWhirlwind(_side, _iter) --, 0, math.floor(getProtocolSides() / 3), 1, 0, 1, 1, getRandomDir(), 0, 0, false, false, false, 0, 1, 1, 2
    void pMarch31osWhirlwindRev(_side, _iter, _timesBeforeChangeDir, _revFreq, _extraWidth, _mirrorStep, _posSpacing, _seamless, _delMult, _sizeMult, _direction, _slopeAmountStart, _slopeAmountCycle, _slopeAmountEnd, _is_full, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osWhirlwindRev(_side, _iter) --, 1, 0, 1, math.floor(getProtocolSides() / 3), 1, 0, 1, 1, getRandomDir(), 0, 0, 0, false, false, false, 0, 1, 1, 2

    void pMarch31osTunnel(_side, _corridorThickOfSpeedLessThan, _corridorThickOfSpeedGEThan, _iter, _largeWalls, _delMult, _sizeMult, _direction, _dirType, _largeWallDesign, _isDistanceTight, _isLargeWallOnce, _sidedir0gap, _sidedir1gap, _sidedir0offset, _sidedir1offset, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osTunnel(_side, _corridorThickOfSpeedLessThan, _corridorThickOfSpeedGEThan, _iter) --, 1, 1, 1, u_rndInt(0, 1), 0, 0, true, false, 1, 1, 0, 0, 0, (to be indexed if is nil), 1, 1, false, false, 0, 0, false, false, false, 0, 1, 1, 2
]]

--[ Commons ]--

local _constructDesignCWallExPart = function(_side, _largeWallDesign, _extraWidth, _thickness)
    if _largeWallDesign > 0 and _extraWidth > 1 then for i = 0, 1, 1 do cWall(_side + (i * _extraWidth), _thickness); end
    else                                        cWallEx(_side, _extraWidth, _thickness);
    end
end

--[[
[ NOTE FOR THE PARAMETERS ]

>>                                         _side: which side the pattern spawns on
>>                                    _thickness: the thickness of the pattern
>>                                         _iter: amount of times
>>                                      _delMult: the delay pattern multiplier of the pattern
>>                                     _sizeMult: the size pattern multiplier of the pattern
>>                                    _direction: which direction
>> [KODIPHER's PARAMETER]          _skipEndDelay: skips delay after pattern spawned
>> [THE SUN XIX's PARAMETER]    _isRebootingSide: the boolean of rebooting side of the pattern
>> [THE SUN XIX's PARAMETER] _endAdditionalDelay: amount of additional delay after pattern spawned, which 'march31oPatDel_AdditionalDelay' variable is
>> [THE SUN XIX's PARAMETER]            _addMult: the alternative delay multiplier of the pattern, which 'march31oPatDel_AddMult' variable is
>>                       _delayMultOfSpdLessThan: delay multiplier of speed less than...
>>                        _spdIsGreaterThanEqual: speed is greater than equal
]]

--[ Barrages ]--

-- pMarch31osBarrage(): spawns a patternized cBarrageN with a delay
-- _neighbors: neighbors of the barrage
function pMarch31osBarrage(_side, _thickness, _neighbors, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _sizeMult = anythingButNil(_sizeMult, 1); _neighbors = anythingButNil(_neighbors, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;

    cBarrageN(_curSide, _neighbors, p_getPatternThickness() * _sizeMult);

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

-- pMarch31osRandomBarrage(): spawns barrages with random side, and waits humanly-possible times depending on the sides distance
--         _distMin: lower bound of randomization distance
--         _distMax: upper bound of randomization distance
--        _isRepeat: is random barrage pattern has repeat in it?
-- _isDelayDistance: is random barrage pattern has distance in it?
function pMarch31osRandomBarrage(_side, _thickness, _iter, _distMin, _distMax, _isRepeat, _isDelayDistance, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(2, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _distMin = anythingButNil(_distMin, -getHalfSides("floor")); _distMax = anythingButNil(_distMax, getHalfSides("floor"));
    _isRepeat = anythingButNil(_isRepeat, 1); _isDelayDistance = anythingButNil(_isDelayDistance, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _oldCurSideTarget = _curSide;
    local _barrageDistanceDelay = 0;
    local _curRandDist = 0;

    for a = 0, _iter, 1 do
        cBarrage(_curSide, p_getPatternThickness() * _sizeMult);
        _oldCurSideTarget = _curSide;
        _curRandDist = u_rndInt(_distMin, _distMax);
        if getBooleanNumber(_isRepeat) then
            _curRandDist = u_rndInt(_distMin, _distMax);
        else
            repeat _curRandDist = u_rndInt(_distMin, _distMax);
            until _curRandDist ~= 0
        end
        _curSide = _curSide + _curRandDist;
        _barrageDistanceDelay = _curSide - _oldCurSideTarget;
        if getBooleanNumber(_isDelayDistance) then
             if _barrageDistanceDelay < 0 then _barrageDistanceDelay = _barrageDistanceDelay * -1; end
             t_applyPatDel(customizePatternDelay((2 + (_barrageDistanceDelay * 2) * (6 / getProtocolSides())) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()))
        else t_applyPatDel(customizePatternDelay((5 * ((getProtocolSides() / 9) + 0.75)) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()))
        end
    end

    cBarrage(_curSide, p_getPatternThickness() * _sizeMult);

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

-- pMarch31osAlternatingBarrage(): spawns a series of cWallExM
--                _isSpiral: gap length of the alternating barrage
--         _hasContainedEnd: is alternating barrage has contained in it?
--               _gapLength: gap length of the alternating barrage
--     _repeatBarrageAmount: amount of barrage repeater of the alternating barrage
--      _repeatBarrageDelay: delay of barrage repeater of the alternating barrage
-- _isRepeatBarrageDelaySpd: boolean of speed mode of barrage repeater of the alternating barrage
function pMarch31osAlternatingBarrage(_side, _thickness, _iter, _isSpiral, _hasContainedEnd, _gapLength, _repeatBarrageAmount, _repeatBarrageDelay, _isRepeatBarrageDelaySpd, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1); _hasContainedEnd = anythingButNil(_hasContainedEnd, 0);
	_gapLength = closeValue(isValueType(_gapLength, "number", false, _gapLength, 0), 0, math.floor(getProtocolSides() / 2) - 1);
    if not _repeatBarrageAmount or _repeatBarrageAmount < 0 then _repeatBarrageAmount = 0; end
	_isSpiral = getBooleanNumber(anythingButNil(_isSpiral, 0));
    _repeatBarrageDelay = anythingButNil(_repeatBarrageDelay, 2); _isRepeatBarrageDelaySpd = anythingButNil(_isRepeatBarrageDelaySpd, 0);
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and getRandomDir()) or getRandomDir();
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageOffset, _barrageLoopDir, _barrageDir = 0, _direction, _direction;

    _hasContainedEnd = getBooleanNumber(_hasContainedEnd);
    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        for repeatAmount = 0, _repeatBarrageAmount, 1 do
            cWallExM(_curSide + _barrageOffset, (math.floor(getProtocolSides() / 2) - _gapLength) + (_barrageDir * 0.5 - 0.5), 2, p_getPatternThickness() * _sizeMult);
            if _barrageLoopDir > 0 and _gapLength > 0 then
                for i = getProtocolSides() - (_gapLength * 2) - (getProtocolSides() % 2), getProtocolSides(), 1 do cWall(_curSide + i + (_direction * 0.5 - 0.5), p_getPatternThickness() * _sizeMult); end
            end
            if repeatAmount < _repeatBarrageAmount then t_applyPatDel(customizePatternDelay(_repeatBarrageDelay * _sizeMult, _isRepeatBarrageDelaySpd)); end
        end

        _barrageOffset = _barrageOffset + _barrageLoopDir;
        if (not _isSpiral) then
            _barrageLoopDir = _barrageLoopDir * -1;
            _barrageDir = _barrageDir * -1;
        end
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end
    if (_hasContainedEnd) then
        for repeatAmount = 0, _repeatBarrageAmount, 1 do
                if getProtocolSides() < 5  then cBarrage(_curSide + _barrageOffset + 1, p_getPatternThickness() * _sizeMult);
            elseif getProtocolSides() == 5 then for i = 0, getProtocolSides() - 3 do cWall(_curSide + i + _barrageOffset + closeValue(_barrageLoopDir, 0, 1)); end
            elseif getProtocolSides() > 5  then cBarrageDoubleHoled(_curSide + _barrageOffset + (math.floor(_gapLength / 2) * 2), 0, 0, p_getPatternThickness() * _sizeMult);
            end
            if repeatAmount < _repeatBarrageAmount then t_applyPatDel(customizePatternDelay(_repeatBarrageDelay * _sizeMult, _isRepeatBarrageDelaySpd)); end
        end
    end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osVortaBarrage(): spawns left-left right-right, etc. of vortrex patterns
--                                 _dirType: direction type. 0 = L-L-R-R, 1 = which <_iter> amount will change direction, 2 = amount > iteration point => change direction
-- [WORKS ONLY ON <_dirType> is 0] _revFreq: how many times the direction will change
-- [WORKS ONLY ON TABLE NUMBERS] _dirPoints: iteration points before change direction
--                            _vortaBarType: vortex barrage type
--                                    _free: free amount of vortex barrage
function pMarch31osVortaBarrage(_side, _thickness, _iter, _dirType, _revFreq, _dirPoints, _vortaBarType, _free, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    -- optional args
    _iter = anythingButNil(_iter, 4); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _dirType = anythingButNil(_dirType, 0); _revFreq = anythingButNil(_revFreq, 1); _dirPoints = anythingButNil(_dirPoints, (_dirType == 2 and {u_rndInt(2, 5), u_rndInt(2, 5)} or {math.floor(_iter / 2)}));
    _vortaBarType = anythingButNil(_vortaBarType, 0); _free = anythingButNil(_free, 0);
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and getRandomDir()) or getRandomDir();
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternHalfSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _revFreqAdd = 0;

    local _vortaBarPart = function(_side, _free, _thickness, _vortaBarType)
        --spawn piece; apply delay
        if _vortaBarType == 1 then
            cWallEx(_side, closeValue(getProtocolSides() % 3, 0, 1) + 1, _thickness);
            cWallEx(_side + (closeValue(getProtocolSides() % 3, 0, 1) + 3), closeValue((getProtocolSides() % 3) - 1, 0, 1) + 1, _thickness);
            if getProtocolSides() >= 9 then
                for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWallEx(_side + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), 1, _thickness); end
            end
        else cBarrageVorta(_side, _free, _thickness);
        end
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    for r = 0, _revFreq, 1 do
        if r == _revFreq and _dirType == 0 then _revFreqAdd = 1; end

        if _dirType == 0 then
            --spawn loop
            for a = 0, _iter + _revFreqAdd, 1 do
                p_patternEffectCycle();
                _vortaBarPart(_curSide, _free, p_getPatternThickness() * _sizeMult, _vortaBarType);

                if _dirType == 1 then
                    --check of need to change dir
                    local _switchI = 1
                    if _switchI <= #_dirPoints then
                        if (_dirPoints[_switchI] == a) then
                            _direction = -_direction
                            table.remove(_dirPoints, _switchI)
                        else
                            _switchI = _switchI + 1;
                        end
                    end
                end

                --move side pointer
                _curSide = _curSide + _direction
            end
        end

        if _dirType == 0 then _direction = -_direction
        elseif _dirType == 2 then
            for _switchII = 1, #_dirPoints, 1 do
                for a = 0, _dirPoints[_switchII], 1 do
                    p_patternEffectCycle();
                    _vortaBarPart(_curSide, _free, p_getPatternThickness(), _vortaBarType);
                    _curSide = _curSide + _direction;
                end
                _direction = -_direction;
            end
        end
    end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osBarrageTypeBase(): spawns a base barrage pattern
--                                                 _gap: the gap of this barrage
--                                               _holes: the amount of holes of this barrage
--                                          _offsetType: barrage displacement type. 0 = spiral 1 = left rights, 2 = inversions
--                                      _offsetDistance: offset distance multiplier
--                                         _mainLoopDir: which direction
-- [WORKS ONLY ON <_offsetType> is 2] _isInvertAccurate: boolean of inverse barrage accuration
function pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, _holes, _offsetType, _offsetDistance, _mainLoopDir, _isInvertAccurate, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if type(_gap) ~= "number" or _gap < 1 then _gap = 1; end
    if type(_holes) ~= "number" or _holes < 1 then _holes = 1; end
    if type(_offsetDistance) ~= "number" or _offsetDistance < 1 then _offsetDistance = 1; end
    if type(_offsetType) ~= "number" then _offsetType = 0; end
    if type(_mainLoopDir) == "number" and _mainLoopDir <= 0 then _mainLoopDir = -1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageLoopDir = (type(_mainLoopDir) == "number" and getNeg(_mainLoopDir)) or getRandomDir();

    local _typeModeModuloStat = (_offsetType == 0 and getProtocolSides()) or 2; --ye, that's the number to integer converter
    local _typeModeStat = (_offsetType == 2 and getHalfSides()) or 1;
    local _typeModeMultStat = (_offsetType == 2 and 1) or _offsetDistance;

    if _holes > 1 then _gap = 1; end

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if a % 2 == 1 and (l_getSides() % 2 == 1) and _holes == 1 and _offsetType == 2 and getBooleanNumber(_isInvertAccurate) then cWallEx(_curSide + 1 + getHalfSides(), getProtocolSides() - (2 + _gap), p_getPatternThickness());
        else
            if _holes > 1 then cBarrageExHoles(_curSide + ((a % _typeModeModuloStat) * _typeModeMultStat * _typeModeStat * _barrageLoopDir), _holes - 1, p_getPatternThickness());
            else cBarrageGap(_curSide + ((a % _typeModeModuloStat) * _typeModeMultStat * _typeModeStat * _barrageLoopDir), _gap, p_getPatternThickness());
            end
        end
        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osBarrageSpiral(): spawns a spiral of this barrage
--             _gap: the gap of this barrage
--        _distance: the distance of this barrage
-- _isDelayDistance: is distance has an accurate delay in it?
function pMarch31osBarrageSpiral(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, 1, 0, anythingButNil(_distance, 1), _direction, false, (getBooleanNumber(_isDelayDistance) and (anythingButNil(_distance, 1) * 0.333 + 0.667) or 1) * _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
end

-- pMarch31osBarrageSpiralRev(): spawns a spiral of cBarrage where you need to change direction
--             _gap: the gap of this barrage
--           _holes: the amount of holes of this barrage
--         _revFreq: how many times the direction will change
--        _distance: the distance of this barrage
-- _isDelayDistance: is distance has an accurate delay in it?
function pMarch31osBarrageSpiralRev(_side, _thickness, _iter, _revFreq, _gap, _holes, _distance, _isDelayDistance, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(2, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _revFreq = anythingButNil(_revFreq, u_rndInt(1, 2)); _distance = anythingButNil(_distance, 1);
    if type(_gap) ~= "number" or _gap < 1 then _gap = 1; end
    if type(_holes) ~= "number" or _holes < 1 then _holes = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _barrageLoopDir = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and getRandomDir()) or getRandomDir();
    local _barrageOffset = 0;
    local _revIterAdd = 0;

    if _holes > 1 then _gap = 1; end

    for r = 0, _revFreq, 1 do
        if r == _revFreq then _revIterAdd = 1; end

        for a = 0, _iter + _revIterAdd, 1 do
            p_patternEffectCycle();

            if _holes > 1 then cBarrageExHoles(_curSide + (_barrageOffset * _distance), _holes - 1, p_getPatternThickness());
            else cBarrageGap(_curSide + (_barrageOffset * _distance), _gap, p_getPatternThickness());
            end
            _barrageOffset = _barrageOffset + _barrageLoopDir;
            t_applyPatDel(customizePatternDelay(4 * (getBooleanNumber(_isDelayDistance) and (_distance * 0.333 + 0.667) or 1) * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
        end

        _barrageLoopDir = _barrageLoopDir * -1;
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

-- pMarch31osBarrageReversals(): spawns a barrage who force you to turn 180 degrees
--              _gap: the gap of this barrage
-- _isInvertAccurate: boolean of inverse barrage accuration
function pMarch31osBarrageReversals(_side, _thickness, _iter, _gap, _isInvertAccurate, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, 1, 2, 1, _direction, _isInvertAccurate, _delMult * 2, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
end

-- pMarch31osWallStrip(): spawns cWallMirrorExs close to one another on the same side
-- _repetitions: same as <_iter> parameter, how many repeat in this wall
-- _mirrorStep: amount of mirror step
--       _extraWidth: amount of extras in this wall
-- _isThickness: boolean of thickness mode
function pMarch31osWallStrip(_side, _thickness, _repetitions, _mirrorStep, _extraWidth, _delMult, _sizeMult, _isThickness, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    _repetitions = anythingButNil(_repetitions, 1); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _mirrorStep = anythingButNil(_mirrorStep, u_rndInt(2, 3)); _extraWidth = anythingButNil(_extraWidth, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;

    _isThickness = getBooleanNumber(_isThickness);
    if not _isThickness then
        for a = 0, _repetitions, 1 do
            p_patternEffectCycle();
            cWallMirrorEx(_curSide, _mirrorStep, _extraWidth, p_getPatternThickness() * _sizeMult);
            t_applyPatDel(customizePatternDelay(2.75 * _delMult * _sizeMult * _curDelaySpeed, false));
        end
    else
        p_patternEffectCycle();
        cWallMirrorEx(_curSide, _mirrorStep, _extraWidth, customizePatternThickness((2.75 * _repetitions) * _delMult * _sizeMult * _curDelaySpeed, false) + (p_getPatternThickness() * _sizeMult));
        t_applyPatDel(customizePatternDelay((2.75 * (_repetitions + 1)) * _delMult * _sizeMult * _curDelaySpeed, false));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

--[ Spirals ]--

-- pMarch31osWhirlwind(): spawns a spiral of cWallMirrorEx
--                       _extraWidth: amount of extras in this cWallMirrorEx
--                       _mirrorStep: amount of mirror step
--                       _posSpacing: position spacing amount where to displace
--                         _seamless: boolean of spiral pattern uses seamless
--                 _slopeAmountStart: amount of slope before spiral pattern spawns
--                   _slopeAmountEnd: amount of slope after spiral pattern spawns
-- [WORKS ONLY ON SIDE < 5] _is_full: boolean of full spiral
function pMarch31osWhirlwind(_side, _iter, _extraWidth, _mirrorStep, _posSpacing, _seamless, _delMult, _sizeMult, _direction, _slopeAmountStart, _slopeAmountEnd, _is_full, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _extraWidth = anythingButNil(_extraWidth, 0); _mirrorStep = anythingButNil(_mirrorStep, math.floor(getProtocolSides() / 3)); _posSpacing = anythingButNil(_posSpacing, 1); _is_full = anythingButNil(_is_full, 0);
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and getRandomDir()) or getRandomDir();
    if not _slopeAmountStart or _slopeAmountStart < 0 then _slopeAmountStart = 0; end
    if not _slopeAmountEnd or _slopeAmountEnd < 0 then _slopeAmountEnd = _slopeAmountStart; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentTimesOfDelayAmountForTriangle, currentTimesOfThickAmountForSquare = 4, 8.25;
    local currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = 3 * (_seamless and 1.1 or 1) * ((_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0))) * _delMult; -- adding the 'timesBeforeChangeDir_thickAmountForGreaterThanSquare' value when loops until direction changes
    local currentSizeOverride, currentDelayOverride = 1, 0.9;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, nil, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    local _curSpiralThick = 2 * (getBooleanNumber(_seamless) and 1.1 or 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _spiralPosistionOffset = 0;

    if getProtocolSides() == 3 and ((_slopeAmountStart > 0 and _slopeAmountEnd > 0) and getBooleanNumber(_is_full)) then
        cBarrage(_curSide + _direction, customizePatternThickness(1 * _sizeMult, p_getDelayPatternBool()));
        for a = 0, _iter, 1 do
            if a == _iter then currentTimesOfDelayAmountForTriangle = 3; end
            p_patternEffectCycle();
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _direction;
            t_applyPatDel(customizePatternDelay(currentTimesOfDelayAmountForTriangle * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        cBarrage(_curSide + _spiralPosistionOffset + _direction, customizePatternThickness(1 * _sizeMult, p_getDelayPatternBool()));
    elseif getProtocolSides() == 4 and ((_slopeAmountStart > 0 and _slopeAmountEnd > 0) and _is_full) then
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _direction;
        for i = 0, 1, 1 do cWall(_curSide + _spiralPosistionOffset + i * _direction, customizePatternThickness(5 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end _spiralPosistionOffset = _spiralPosistionOffset + _direction * 2;
        t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        for a = 0, _iter + 1, 1 do --1, _iter + 2
            p_patternEffectCycle();
            if a == _iter + 1 then currentTimesOfThickAmountForSquare = 6; end
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(currentTimesOfThickAmountForSquare * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _direction;
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
        _spiralPosistionOffset = _spiralPosistionOffset + _direction * 2;
        for k = 0, 1, 1 do cWall(_curSide + _spiralPosistionOffset + k * _direction, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end 
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _direction * 3;
        cBarrage(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    else
        if (_slopeAmountStart > 0) then
            for fa = 0, _slopeAmountStart, 1 do
                for ia = 0, _slopeAmountStart - fa, 1 do
                    if ia > 0 then cWallMirrorEx(_curSide - (_direction * _posSpacing * (ia - 1)), _mirrorStep, _extraWidth, customizePatternThickness((_curSpiralThick + 1) * _delMult * _sizeMult, p_getDelayPatternBool())); end
                end
                cWallMirrorEx(_curSide + (_direction * _posSpacing * fa) - (_slopeAmountStart * _direction * _posSpacing), _mirrorStep, _extraWidth, customizePatternThickness(_curSpiralThick * _delMult * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                if fa == _slopeAmountStart then _spiralPosistionOffset = _spiralPosistionOffset + (_direction * _posSpacing); end
            end
        end
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _mirrorStep, _extraWidth, customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + (_direction * _posSpacing);
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            if a == _iter then _spiralPosistionOffset = _spiralPosistionOffset + (_direction * _posSpacing); end
        end
        if (_slopeAmountEnd > 0) then
            for fb = 0, _slopeAmountEnd, 1 do
                if fb == _slopeAmountEnd then currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = _curSpiralThick; end
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_direction * _posSpacing)) + (_direction * _posSpacing * ib), _mirrorStep, _extraWidth, customizePatternThickness(currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare * _sizeMult, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    t_applyPatDel(customizePatternDelay(2 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osWhirlwindRev(): spawns a spiral of cWallMirrorEx where you need to change direction
--             _timesBeforeChangeDir: amount of times before direction changes
--                          _revFreq: amount of times of direction changes
--                       _extraWidth: amount of extras in this cWallMirrorEx
--                       _mirrorStep: amount of mirror step
--                       _posSpacing: position spacing amount where to displace
--                         _seamless: boolean of spiral pattern uses seamless
--                 _slopeAmountStart: amount of slope before spiral pattern spawns
--                   _slopeAmountEnd: amount of slope after spiral pattern spawns
-- [WORKS ONLY ON SIDE < 5] _is_full: boolean of full spiral
function pMarch31osExWhirlwind(_side, _iter, _timesBeforeChangeDir, _revFreq, _extraWidth, _mirrorStep, _posSpacing, _seamless, _delMult, _sizeMult, _direction, _slopeAmountStart, _slopeAmountCycle, _slopeAmountEnd, _is_full, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(4, 7)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _extraWidth = anythingButNil(_extraWidth, 0); _mirrorStep = anythingButNil(_mirrorStep, math.floor(getProtocolSides() / 3)); _posSpacing = anythingButNil(_posSpacing, 1); _is_full = anythingButNil(_is_full, 0);
    _timesBeforeChangeDir = closeValue((type(_timesBeforeChangeDir) == "number" and _timesBeforeChangeDir or 0), 0, 999, "min");
    _revFreq = closeValue((type(_revFreq) == "number" and _revFreq or 0), 0, 999, "min");
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and getRandomDir()) or getRandomDir();
    if not _slopeAmountStart or _slopeAmountStart < 0 then _slopeAmountStart = 0; end
    if not _slopeAmountCycle or _slopeAmountCycle < 0 then _slopeAmountCycle = _slopeAmountStart; end
    if not _slopeAmountEnd or _slopeAmountEnd < 0 then _slopeAmountEnd = _slopeAmountStart; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, nil, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    local _curSpiralThick = 2 * (getBooleanNumber(_seamless) and 1.1 * _delMult or 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _spiralPosistionOffset = 0;

    local currentTimesOfDelayAmountForTriangle, currentTimesOfThickAmountForTriangle = 4, 4;
    local currentTimesOfDelayAmountForSquare, currentTimesOfThickAmountForSquare, currentTimesOfThickAmountBeforeDirChangeForSquare, currentThickOffsetAmountBeforeDirChangeForSquare_001, currentThickOffsetAmountBeforeDirChangeForSquare_002 = 2, 4, 6, 0, 0;
    local currentSizeOverride, currentDelayOverride = 1, 0.9;

    if getProtocolSides() == 3 and ((_slopeAmountStart > 0 and _slopeAmountCycle > 0 and _slopeAmountEnd > 0) and getBooleanNumber(_is_full)) then
        cBarrage(_curSide + _direction, customizePatternThickness(1 * _sizeMult, p_getDelayPatternBool()));
        for rev = 0, _revFreq, 1 do
            for a = 0, _iter, 1 do
                if a == _iter + 1 and rev == _revFreq then currentTimesOfDelayAmountForTriangle = 3; end
                if a == _iter and rev < _revFreq then currentTimesOfThickAmountForTriangle = 4 + (_curDelaySpeed * _delMult); end
                p_patternEffectCycle();
                cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(currentTimesOfThickAmountForTriangle * _sizeMult, p_getDelayPatternBool()));
                _spiralPosistionOffset = _spiralPosistionOffset + _direction;
                t_applyPatDel(customizePatternDelay(currentTimesOfDelayAmountForTriangle * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
            if rev < _revFreq then
                cWall(_curSide + _spiralPosistionOffset - _direction, customizePatternThickness(5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                _direction = _direction * -1;
            end
        end
        cBarrage(_curSide + _spiralPosistionOffset + _direction, customizePatternThickness(1 * _sizeMult, p_getDelayPatternBool()));
    elseif getProtocolSides() == 4 and ((_slopeAmountStart > 0 and _slopeAmountCycle > 0 and _slopeAmountEnd > 0) and _is_full) then
        if _revFreq > 0 then
            _direction = _direction * -1;
            if _iter > 0 then currentTimesOfThickAmountBeforeDirChangeForSquare = 4; end
            if _iter == 1 then currentThickOffsetAmountBeforeDirChangeForSquare_001 = 2;
            elseif _iter > 1 then currentThickOffsetAmountBeforeDirChangeForSquare_002 = 2;
            end
            cBarrage(_curSide - _direction, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            for a = 0, _iter, 1 do
                p_patternEffectCycle();
                if a == 1 then currentThickOffsetAmountBeforeDirChangeForSquare_002 = 0; end
                if a == _iter then currentTimesOfThickAmountForSquare = 11; currentTimesOfDelayAmountForSquare = 5; end
                cWall(_curSide, customizePatternThickness((currentTimesOfThickAmountForSquare + currentThickOffsetAmountBeforeDirChangeForSquare_001 + currentThickOffsetAmountBeforeDirChangeForSquare_002) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                if a < _iter then _curSide = _curSide - _direction; end
                t_applyPatDel(customizePatternDelay((currentTimesOfDelayAmountForSquare + currentThickOffsetAmountBeforeDirChangeForSquare_001 + currentThickOffsetAmountBeforeDirChangeForSquare_002) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            end
            for rev = 0, _revFreq - 1, 1 do
                cWall(_curSide - _direction, customizePatternThickness(((_iter > 0 and 4 or 6) - currentThickOffsetAmountBeforeDirChangeForSquare_001) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                cBarrage(_curSide + _direction, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                for a = 0, _iter, 1 do
                    p_patternEffectCycle();
                    currentTimesOfThickAmountForSquare = 4; currentTimesOfDelayAmountForSquare = 2;
                    if a == _iter then currentTimesOfThickAmountForSquare = 6; currentTimesOfDelayAmountForSquare = 5; end
                    cWall(_curSide + _direction, customizePatternThickness(((a == _iter and (rev < _revFreq - 1 and 11 or 6) or 4)) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                    t_applyPatDel(customizePatternDelay((a == _iter and 5 or 2) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                    _curSide = _curSide + _direction;
                end
                if rev < _revFreq - 1 then _direction = _direction * -1 end
            end
            cBarrage(_curSide - _direction, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        else
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _direction;
            for i = 0, 1, 1 do cWall(_curSide + _spiralPosistionOffset + i * _direction, customizePatternThickness(5 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end _spiralPosistionOffset = _spiralPosistionOffset + _direction * 2;
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            for a = 0, _iter + 1, 1 do
                p_patternEffectCycle();
                if a == _iter + 1 then currentTimesOfThickAmountForSquare = 6; end
                cWall(_curSide + _spiralPosistionOffset, customizePatternThickness((a == _iter + 1 and 7 or 9) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                _spiralPosistionOffset = _spiralPosistionOffset + _direction;
                t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            end
            _spiralPosistionOffset = _spiralPosistionOffset + _direction * 2;
            for k = 0, 1, 1 do cWall(_curSide + _spiralPosistionOffset + k * _direction, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end 
            t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _direction * 3;
            cBarrage(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
    else
        if (_slopeAmountStart > 0) then
            for fa = 0, _slopeAmountStart, 1 do
                for ia = 0, _slopeAmountStart - fa, 1 do
                    if ia > 0 then cWallMirrorEx(_curSide - (_direction * _posSpacing * (ia - 1)), _mirrorStep, _extraWidth, customizePatternThickness((_curSpiralThick + 1) * _sizeMult, p_getDelayPatternBool())); end
                end
                cWallMirrorEx(_curSide + (_direction * _posSpacing * fa) - (_slopeAmountStart * _direction * _posSpacing), _mirrorStep, _extraWidth, customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                if fa == _slopeAmountStart then _spiralPosistionOffset = _spiralPosistionOffset + (_direction * _posSpacing); end
            end
        end
        for rev = 0, _revFreq, 1 do
            local halt = _revFreq > 0 and rev == _revFreq and 1 or 0
            for a = 0, _iter - halt, 1 do
                p_patternEffectCycle();
                cWallMirrorEx(_curSide + _spiralPosistionOffset, _mirrorStep, _extraWidth, customizePatternThickness((_curSpiralThick + (a == _iter - halt and (_slopeAmountCycle > 0) and rev < _revFreq and 1 or 0)) * _sizeMult, p_getDelayPatternBool()));
                if a < _iter - halt then
                    t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                    _spiralPosistionOffset = _spiralPosistionOffset + (_direction * _posSpacing);
                end
                if a == _iter - halt and rev == _revFreq then _spiralPosistionOffset = _spiralPosistionOffset + (_direction * _posSpacing); end
            end
            if rev < _revFreq then
                if (_slopeAmountCycle > 0) then
                    for fb = 0, _slopeAmountCycle - 1, 1 do
                        for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_direction * _posSpacing)) + (_direction * _posSpacing * ib), _mirrorStep, _extraWidth, customizePatternThickness((_curSpiralThick + 1) * _sizeMult, p_getDelayPatternBool())); end
                        t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                    end
                    for hb = 0, _timesBeforeChangeDir, 1 do
                        if hb < _timesBeforeChangeDir then
                            for ib = 0, _slopeAmountCycle, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_direction * _posSpacing)) + (_direction * _posSpacing * ib), _mirrorStep, _extraWidth, customizePatternThickness((_curSpiralThick + 1) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool())); end
                        elseif hb == _timesBeforeChangeDir then
                            for ib = 0, _slopeAmountCycle - 1, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_direction * _posSpacing)) + (_direction * _posSpacing * ib), _mirrorStep, _extraWidth, customizePatternThickness((_curSpiralThick + 1) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool())); end
                            cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_direction * _posSpacing)) + (_direction * _posSpacing * _slopeAmountCycle), _mirrorStep, _extraWidth, customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
                        end
                        t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                    end
                    for vb = 1, _slopeAmountCycle, 1 do
                        for eb = 0, _slopeAmountCycle - (vb + 1), 1 do
                            if eb >= 0 then
                                for lb = 0, _slopeAmountCycle - (vb + 1), 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_direction * _posSpacing)) + (_direction * _posSpacing * lb), _mirrorStep, _extraWidth, customizePatternThickness((_curSpiralThick + 1) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool())); end
                            end
                        end
                        cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_direction * _posSpacing)) + (_direction * _posSpacing * (_slopeAmountCycle - vb)), _mirrorStep, _extraWidth, customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
                        t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                    end
                else
                    for hb = 0, _timesBeforeChangeDir, 1 do
                        cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_direction * _posSpacing)) + (_direction * _posSpacing * _slopeAmountCycle), _mirrorStep, _extraWidth, customizePatternThickness((_curSpiralThick + (hb < _timesBeforeChangeDir and 1 or 0)) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                        t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                    end
                end
                _spiralPosistionOffset = _spiralPosistionOffset - (_direction * _posSpacing * 2); _direction = _direction * -1; -- It's time to reversing the spiral.
            end
        end
        if (_slopeAmountEnd > 0) then
            for fb = 0, _slopeAmountEnd, 1 do
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_direction * _posSpacing)) + (_direction * _posSpacing * ib), _mirrorStep, _extraWidth, customizePatternThickness((_curSpiralThick + (fb < _slopeAmountEnd and 1 or 0)) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    t_applyPatDel(customizePatternDelay(2 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

--[ Tunnels ]--

-- pMarch31osTunnel(): a base tunnel what forces you to circle around a very thick wall...but you can personalize everything.
-- _corridorThickOfSpeedLessThan: amount of thickness of speed less than, same as <_thickness>
--   _corridorThickOfSpeedGEThan: amount of thickness pf speed greater than equal, same as <_thickness>
--              _largeWallDesign: large wall design type. 0 = default, 1 = stack, 2 = clean
--                      _dirType: direction type
--                   _largeWalls: amount of large walls
--              _isDistanceTight: boolean of distance tight
--              _isLargeWallOnce: boolean of one large wall * times instead of ones
--            _gearTeethSizeMult: several thickness/gear teeth size multiplier
--                 _gearTeethInc: several thickness/gear teeth increment
--             _gearTeethStepDel: amount of several thickness/gear teeth increment will delayed
--           _gearTeethStepLimit: where the several thickness/gear teeth limit reached
--       _isBeforeGearTeethBegin: similiar from <<super hexagon: hyper hexagoner>>. boolean of when after gear teeth will started + additional iterations
--         _isBeforeGearTeethEnd: reverse "_isBeforeGearTeethBegin". boolean of when after gear teeth will ended + additional iterations
--         _repeatCorridorAmount: inspired from <<Quartz's Tunnel corridor repeat by Kayden>>. amount of corridor
--          _repeatCorridorDelay: how far the repeated corridor is
--                  _sidedir0gap: amount of gap of direction right. (default = 1)
--                  _sidedir1gap: amount of gap of direction left. (default = 1)
--               _sidedir0offset: amount of offset of direction right. (default = 0)
--               _sidedir1offset: amount of offset of direction left. (default = 0)
function pMarch31osTunnel(_side, _corridorThickOfSpeedLessThan, _corridorThickOfSpeedGEThan, _iter, _largeWalls, _delMult, _sizeMult, _direction, _dirType, _largeWallDesign, _isDistanceTight, _isLargeWallOnce, _sidedir0gap, _sidedir1gap, _sidedir0offset, _sidedir1offset, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(1, 3)); _largeWallDesign = anythingButNil(_largeWallDesign, 0); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _dirType = anythingButNil(_dirType, 0); _largeWalls = closeValue(anythingButNil(_largeWalls, u_rndInt(1, getProtocolSides() - 2)), 1, getProtocolSides() - 2); _isDistanceTight = anythingButNil(_isDistanceTight, 0); _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0); _isAfterGearTeethEnd = anythingButNil(_isAfterGearTeethEnd, 0);
    _sidedir0gap = anythingButNil(_sidedir0gap, 1); _sidedir1gap = anythingButNil(_sidedir1gap, _sidedir0gap); _sidedir0offset = anythingButNil(_sidedir0offset, 0); _sidedir1offset = anythingButNil(_sidedir1offset, _sidedir0offset);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    if not _repeatCorridorAmount or _repeatCorridorAmount < 0 then _repeatCorridorAmount = 0; end
    _repeatCorridorDelay = anythingButNil(_repeatCorridorDelay, 2); _isRepeatCorridorDelaySpd = anythingButNil(_isRepeatCorridorDelaySpd, 0);
    if not _sidedir0gap or _sidedir0gap < 1 then _sidedir0gap = 1; end
    if not _sidedir1gap or _sidedir1gap < 1 then _sidedir1gap = 1; end
    if not _direction or _direction > 1 or _direction < 0 then _direction = u_rndInt(0, 1); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local _curTunnelCorridorDirGap, _curTunnelCorridorDirOffset = 0, 0; local _curTunnelCorridorDir, _curTunnelSpiralCorridorDir = 1, 1;
    local _amountOfBeforeGearTeethBegin, _timesOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _gearTeethBarrageAmount, _gearTeethBarrageStep, _gearTeethBarrageInc = 1, 0, 0;
    local _gearTeethWallOffsetAmount, _gearTeethWallOffsetStep, _gearTeethWallOffsetInc = 1, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, _corridorThickOfSpeedLessThan or THICKNESS, _corridorThickOfSpeedGEThan);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_direction) * (_largeWalls + 1);
    local _amountOfDesignType0, _tunnelSpiralExpected, _largeWallOnceExpected = 1, _dirType == 1, (getBooleanNumber(_isLargeWallOnce)) and (_dirType == 0 or _dirType == 2);

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getPatternThickness() * (6 / getProtocolSides()));

    local _curTunnelDel = getBooleanNumber(_isDistanceTight) and (closeValue(getProtocolSides(), 3, 9) / (_largeWalls * 0.4 + 0.175) + ((p_getPatternThickness() / 2) * (_largeWalls / (getProtocolSides() - 2)) / customizePatternThickness(closeValue(getProtocolSides(), 3, 9), true))) or 9;
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end
    _isRepeatCorridorDelaySpd = getBooleanNumber(_isRepeatCorridorDelaySpd);

    --for larger wall once 
    if (_largeWallOnceExpected) then
        _constructDesignCWallExPart(_curSide + 1, _largeWallDesign, _largeWalls - 1,
        customizePatternThickness((_curTunnelDel * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd)) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
    end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if _largeWallDesign == 2 and (a > 0 and a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) then _amountOfDesignType0 = _largeWalls;
        else _amountOfDesignType0 = 1;
        end

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _tunnelLoopDir > 0 then _curTunnelCorridorDirGap = _sidedir1gap; _curTunnelCorridorDirOffset = _sidedir1offset; _curTunnelCorridorDir = 1 * _curTunnelSpiralCorridorDir;
        else _curTunnelCorridorDirGap = _sidedir0gap; _curTunnelCorridorDirOffset = _sidedir0offset; _curTunnelCorridorDir = -1 * _curTunnelSpiralCorridorDir;
        end

        for repeatAmount = 0, _repeatCorridorAmount, 1 do
            if repeatAmount < _repeatCorridorAmount and (not _largeWallOnceExpected) then _constructDesignCWallExPart(_curSide + 1, _largeWallDesign, _largeWalls - 1, customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end

            _gearTeethBarrageAmount = 1; _gearTeethBarrageStep = 0; _gearTeethBarrageInc = 0;

            for corridorGap = _curTunnelCorridorDirGap, getBarrageSide(_curTunnelCorridorDirOffset + _amountOfDesignType0), 1 do
                if _gearTeethSizeMult > 0 then
                    cWall((corridorGap * _curTunnelCorridorDir) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir), (p_getPatternThickness() + _gearTeethBarrageInc) * _gearTeethSizeMult)
                    if corridorGap < getBarrageSide(_curTunnelCorridorDirOffset + _gearTeethStepLimit) - _largeWalls then _gearTeethBarrageStep = _gearTeethBarrageStep + 1;
                        if _gearTeethBarrageStep >= _gearTeethStepDel then _gearTeethBarrageStep = 0; _gearTeethBarrageInc = (_gearTeethBarrageAmount * _gearTeethInc); _gearTeethBarrageAmount = _gearTeethBarrageAmount + 1; end
                    end
                else cWall((corridorGap * _curTunnelCorridorDir) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir), p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult)
                end
            end

            _gearTeethWallOffsetAmount = 1; _gearTeethWallOffsetStep = 0; _gearTeethWallOffsetInc = 0;

            for offsetGap = getProtocolSides() - _curTunnelCorridorDirOffset + _amountOfDesignType0, getProtocolSides(), 1 do
                if _gearTeethSizeMult > 0 then
                    cWall((offsetGap * _curTunnelCorridorDir * -1) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir) - (_curTunnelCorridorDir * (getProtocolSides() + _curTunnelCorridorDirOffset)), (p_getPatternThickness() + _gearTeethWallOffsetInc) * _gearTeethSizeMult);
                    if offsetGap < getProtocolSides() - (_gearTeethStepLimit - 1) then _gearTeethWallOffsetStep = _gearTeethWallOffsetStep + 1;
                        if _gearTeethWallOffsetStep >= _gearTeethStepDel then _gearTeethWallOffsetStep = 0; _gearTeethWallOffsetInc = (_gearTeethWallOffsetAmount * _gearTeethInc); _gearTeethWallOffsetAmount = _gearTeethWallOffsetAmount + 1; end
                    end
                else cWall((offsetGap * _curTunnelCorridorDir) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir) - _curTunnelCorridorDir, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
                end
            end
            if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
        end

        if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and (not _largeWallOnceExpected) then
            _constructDesignCWallExPart(_curSide + 1, _largeWallDesign, _largeWalls - 1,
            customizePatternThickness(_curTunnelDel * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount) * _sizeMult * (((_dirType == 1 or _dirType >= 3) and a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd - 1 and 1) or 0), _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
        end

        if _dirType == 1 then _tunnelSpiralExpected = true;
            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd - 1 then _curSide = _curSide - ((_largeWalls + 1) + (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset) * _curTunnelCorridorDir;
            else _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1);
            end
        elseif _dirType == 2 then if u_rndInt(0, 100) > 50 then _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1); end
        elseif _dirType == 3 then
            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd - 1 then
                if u_rndInt(0, 100) > 50 then _tunnelSpiralExpected = true; _curSide = _curSide - ((_largeWalls + 1) + (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset) * _curTunnelCorridorDir; _oldCurSide = _curSide if a == _iter + _timesOfBeforeGearTeethBegin - 1 then _curSide = _curSide - (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset * _curTunnelCorridorDir; _curTunnelSpiralCorridorDir = _curTunnelSpiralCorridorDir * -1; end
                else _tunnelSpiralExpected = false; _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1);
                end
            else _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1);
            end
        else _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1);
        end

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end

        if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then t_applyPatDel(customizePatternDelay(_curTunnelDel * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool())); end
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 12)) + (customizePatternDelay(0.5, false) * (_largeWalls / (getProtocolSides() - 2))));
end