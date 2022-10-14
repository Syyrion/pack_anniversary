u_execScript("level/memoriesReappear/utils/march31o_common.lua")
u_execScript("level/memoriesReappear/utils/march31o_utils.lua")

--[[
    void pMarch31osAlternatingBarrageTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWalls, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osAlternatingBarrageTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, 2, 1, false, 1, 1, u_rndInt(0, 1), false, false, 0, 1, 1, 2
    void pMarch31osRandomBarrageTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWallDesign, _largeWalls, _delMult, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osRandomBarrageTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, 2, 1, true, 1, 1, false, false, 0, 1, 1, 2
    void pMarch31osRandomBarrageNdistanceTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWallDesign, _largeWalls, _isLargeWallOnce, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osRandomBarrageNdistanceTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, 2, 1, false, 1, 1, false, false, 0, 1, 1, 2
    void pMarch31osJumbleTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWalls, _chance, _delMult, _sizeMult, _largeWallDesign, _isLargeWallOnce, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osJumbleTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, 2, 1, false, getProtocolSides() - 3, 1, 1, false, false, 0, 1, 1, 2
    void pMarch31osRandomizationLargeWallsTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWallsDistanceMax, _isDistanceTight, _delMult, _sizeMult, _direction, _largeWallDesign, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osRandomizationLargeWallsTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, u_rndIntUpper(getProtocolSides() - 2), true, 1, 1, getRandomDir(), false, false, 0, 1, 1, 2
    void pMarch31osTrapBarrageTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWallDesign, _largeGrowWalls, _growWallClawAdd, _growWallCapAdd, _delMult, _sizeMult, _direction, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osTrapBarrageTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, 2, 1, 1, 1, 1, 1, u_rndInt(0, 1), false, false, 0, 1, 1, 2
    void pMarch31osBarrageSpiralTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _revFreq, _largeWalls, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osBarrageSpiralTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET) --, 0, 2, 1, false, 1, 1, getRandomDir(), false, false, 0, 1, 1, 2
    void pMarch31osDoubleBarrageSpiralAcrossTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeGrowWalls, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osDoubleBarrageSpiralAcrossTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, 2, 1, false, 1, 1, getRandomDir(), false, false, 0, 1, 1, 2
    void pMarch31osLRTunnelShortSpiral(_side, _corridorThickOfSLT, _corridorThickOfSGET, _largeWalls, _isHardMode, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osLRTunnelShortSpiral(_side, _corridorThickOfSLT, _corridorThickOfSGET) --, 2, 1, false, false, 0, 1, 1, false, 1, 1, getRandomDir(), false, false, 0, 1, 1, 2
    void pMarch31osBackAndForthTunnelAxis(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _free, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osBackAndForthTunnelAxis(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, 0, 2, 0, 0, 0, 0, false, (to be indexed if is nil), 1, 1, false, false, 0, 2, false, 1, 1, u_rndInt(0, 1), false, false, 0, 1, 1, 2
    void pMarch31osBackAndForthTunnelAxisInterpolated(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _free, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osBackAndForthTunnelAxisInterpolated(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, 0, 2, 0, 0, 0, 0, false, (to be indexed if is nil), 1, 1, false, false, 0, 2, false, 1, 1, u_rndInt(0, 1), false, false, 0, 1, 1, 2
    void pMarch31osBackAndForthTunnelCentral(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _free, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osBackAndForthTunnelCentral(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter) --, 0, 2, 0, 0, 0, 0, false, (to be indexed if is nil), 1, 1, false, false, 0, 2, false, 1, 1, u_rndInt(0, 1), false, false, 0, 1, 1, 2
]]

--[[
[ NOTE FOR THE PARAMETERS ]

>>                                                    _side: which side the pattern spawns on
>>                                      _corridorThickOfSLT: the thickness of the pattern of speed less than
>>                                     _corridorThickOfSGET: the thickness of the pattern of speed greater than equal
>>                                                    _iter: amount of times
>>                                              _largeWalls: amount of large walls
>>                                                 _delMult: the delay pattern multiplier of the pattern
>>                                                _sizeMult: the size pattern multiplier of the pattern
>>                                               _direction: which direction
>> [WORKS ONLY ON 2 OR HIGHER, USE STATIC] _isLargeWallOnce: boolean of optimizing large wall with one wall-spawn
>>                                         _largeWallDesign: large wall design type. 0 = default, 1 = stack, 2 = clean
>> [KODIPHER's PARAMETER]                     _skipEndDelay: skips delay after pattern spawned
>> [THE SUN XIX's PARAMETER]               _isRebootingSide: the boolean of rebooting side of the pattern
>> [THE SUN XIX's PARAMETER]            _endAdditionalDelay: amount of additional delay after pattern spawned, which 'march31oPatDel_AdditionalDelay' variable is
>> [THE SUN XIX's PARAMETER]                       _addMult: the alternative delay multiplier of the pattern, which 'march31oPatDel_AddMult' variable is
>>                                  _delayMultOfSpdLessThan: delay multiplier of speed less than...
>>                                   _spdIsGreaterThanEqual: speed is greater than equal
]]


--[ Commons ]--

local _constructDesignCWallExPart = function(_side, _largeWallDesign, _extra, _thickness)
    if _largeWallDesign > 0 and _extra > 1 then for i = 0, 1, 1 do cWall(_side + (i * _extra), _thickness); end
    else                                        cWallEx(_side, _extra, _thickness);
    end
end

local _constructDesignLargeGrowWallPart = function(_side, _largeWallDesign, _extra, _thickness)
    if _largeWallDesign > 0 and _extra > 0 then cWall(_side + _extra, _thickness); cWall(_side - _extra, _thickness);
    else                                        cWallGrow(_side, _extra, _thickness);
    end
end

local _constructTunnelGearTeethCorridorFixPart = function(_side, _thick_mult_step, _thick_mult_step_limit, _extra, _thick_inc, _thick_mult, _thickness)
    local _tunnelGearTeethStep = 0;
    local _tunnelGearTeethAmount = 1;
    local _tunnelGearTeethInc = 0;

    for tAmount = 0, _thick_inc, 1 do
        if tAmount < _thick_inc - _thick_mult_step_limit then _tunnelGearTeethStep = _tunnelGearTeethStep + 1
            if _tunnelGearTeethStep >= _thick_mult_step then _tunnelGearTeethInc = (_tunnelGearTeethAmount * _thick_mult) _tunnelGearTeethStep = 0; _tunnelGearTeethAmount = _tunnelGearTeethAmount + 1; end
        end
    end

    cWallEx(_side, _extra, _thickness + _tunnelGearTeethInc);
end

local _constructTunnelGearTeethCorridorFixDesignPart = function(_side, _thick_mult_step, _thick_mult_step_limit, _extra, _thick_inc, _thick_mult, _largeThickness, _thickness, _gearTeethSizeMult)
    if _gearTeethSizeMult > 0 then _constructTunnelGearTeethCorridorFixPart(_side, _thick_mult_step, _thick_mult_step_limit, _extra, _thick_inc, _thick_mult, _largeThickness);
    else cWallEx(_side, _extra, _thickness);
    end
end

local _constructBAFTunnelLargeWallPart = function(_side, _freqAmount, _freqCount, _largeWallThick, _corridorThick, _isLargeWallThickSpdMode, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _sizeMult, _largeWallDesign)
    _repeatCorridorAmount = _repeatCorridorAmount or 0;
    _repeatCorridorDelay = _repeatCorridorDelay or 0;
    if (getProtocolSides() > 5) then
        for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_side + (i * 3), customizePatternThickness(_largeWallThick * _sizeMult, _isLargeWallThickSpdMode) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * _freqAmount)) * _sizeMult, _isRepeatCorridorDelaySpd) + ((_corridorThick / 2) * _sizeMult)); end
    end
    if (getProtocolSides() % 3 > 0) then
        if (_largeWallDesign >= 1) then
            for i = 0, 1, 1 do cWall(_side - (i * (getProtocolSides() % 3)), customizePatternThickness(_largeWallThick * _sizeMult, _isLargeWallThickSpdMode) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * _freqAmount)) * _sizeMult, _isRepeatCorridorDelaySpd) + ((_corridorThick / 2) * _sizeMult)); end
            if (_largeWallDesign == 2 and getProtocolSides() % 3 == 2) and _freqCount == 0 then cWall(_side - 1, _corridorThick * _sizeMult); end
            if (_largeWallDesign == 1 and getProtocolSides() % 3 == 2) then cWall(_side - 1, _corridorThick * _sizeMult); end
        else
            for i = 1, getProtocolSides() % 3, 1 do cWall(_side - i, customizePatternThickness(_largeWallThick * _sizeMult, _isLargeWallThickSpdMode) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * _freqAmount)) * _sizeMult, _isRepeatCorridorDelaySpd) + ((_corridorThick / 2) * _sizeMult)); end
        end
    end
end

--[ Tunnels ]--

-- baba's inspired patterns
-- pMarch31osAlternatingBarrageTunnel(): spawns a tunnel with alternating barrage
function pMarch31osAlternatingBarrageTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWalls, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _largeWallDesign = anythingButNil(_largeWallDesign, 0); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if not _direction or _direction > 1 or _direction < -1 or _direction == 0 then _direction = getRandomDir(); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelLoopDir = getRandomDir();
    local _tunnelOffset = _tunnelLoopDir;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce)) then
        _constructDesignCWallExPart(_curSide + 1, _largeWallDesign, _largeWalls - 1, customizePatternThickness(3.9 * _iter * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult))
    end

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if a < _iter then
            if (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignCWallExPart(_curSide + 1, _largeWallDesign, _largeWalls - 1, customizePatternThickness(3.9 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
            if (_largeWallDesign == 1 and _largeWalls > 1) or (_largeWallDesign > 1 and a == 0) then cWallEx(_curSide + 1, _largeWalls - 1, p_getPatternThickness() * _sizeMult); end
        else cWallEx(_curSide + 1, _largeWalls - 1, p_getPatternThickness() * _sizeMult);
        end

        for i = 1, getProtocolSides() - _largeWalls, 1 do
            if _tunnelOffset > 0 then cWall(i + _curSide + _largeWalls, p_getPatternThickness() * _sizeMult); end
            _tunnelOffset = _tunnelOffset * -1;
        end

        _tunnelLoopDir = _tunnelLoopDir * -1; _tunnelOffset = _tunnelLoopDir;
        t_applyPatDel(customizePatternDelay(3.9 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end
pMarch31osAlternatingTunnel = pMarch31osAlternatingBarrageTunnel

-- pMarch31osRandomBarrageTunnel(): spawns a tunnel with randomized distance barrage
--        _isRepeat: is random barrage pattern has repeat in it?
-- _isDelayDistance: is random barrage pattern has distance in it?
function pMarch31osRandomBarrageTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWalls, _isRepeat, _isDelayDistance, _delMult, _sizeMult, _largeWallDesign, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(2, 5)); _largeWallDesign = anythingButNil(_largeWallDesign, 2); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _isRepeat = anythingButNil(_isRepeat, 1); _isDelayDistance = anythingButNil(_isDelayDistance, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelOldOffset = 0;
    local _tunnelOffset = 0;
    local _tunnelDistanceDelay = 0;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce) and not getBooleanNumber(_isDelayDistance)) then
        _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeWalls - 1, customizePatternThickness(5 * ((getProtocolSides() / 9) + 0.75) * _iter * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult))
    end

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if _largeWallDesign == 2 and a > 0 then
            for i = _largeWalls, getProtocolSides(), 1 do
                if i ~= _tunnelOffset + _largeWalls then cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
            end
        else
            for i = 1, getBarrageSide(), 1 do cWall(i + _curSide + _tunnelOffset + _largeWalls, p_getPatternThickness() * _sizeMult); end
        end
        _tunnelOldOffset = _tunnelOffset; _tunnelOffset = u_rndInt(0, getProtocolSides() - (_largeWalls + 1));
        if getBooleanNumber(_isRepeat) then
            _tunnelOffset = u_rndInt(0, getProtocolSides() - (_largeWalls + 1));
        else
            repeat _tunnelOffset = u_rndInt(0, getProtocolSides() - (_largeWalls + 1));
            until _tunnelOffset ~= _tunnelOldOffset
        end
        _tunnelDistanceDelay = _tunnelOldOffset - _tunnelOffset;
        if _tunnelDistanceDelay < 0 then _tunnelDistanceDelay = _tunnelDistanceDelay * -1; end
        if getBooleanNumber(_isDelayDistance) then
            _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeWalls - 1, customizePatternThickness((3 * (6 / getProtocolSides())) * _curDelaySpeed * _delMult * _sizeMult * (_tunnelDistanceDelay / 1.25) + 1.25, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
            t_applyPatDel(customizePatternDelay((3 * (6 / getProtocolSides())) * _curDelaySpeed * _delMult * _sizeMult * (_tunnelDistanceDelay / 1.25) + 1.25, p_getDelayPatternBool()));
        else
            if (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeWalls - 1, customizePatternThickness(5 * ((getProtocolSides() / 9) + 0.75) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
            t_applyPatDel(customizePatternDelay(5 * ((getProtocolSides() / 9) + 0.75) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
    end

    for i = 1, getBarrageSide(), 1 do cWall(i + _curSide + _tunnelOffset + _largeWalls, p_getPatternThickness()); end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end
pMarch31osRandomTunnel = pMarch31osRandomBarrageTunnel;

-- pMarch31osJumbleTunnel(): spawns a tunnel with jumbled barrage
-- _chance: amount of randomized wall displacement
function pMarch31osJumbleTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWalls, _chance, _delMult, _sizeMult, _largeWallDesign, _isLargeWallOnce, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _largeWallDesign = anythingButNil(_largeWallDesign, 2); _chance = anythingButNil(_chance, getProtocolSides() - 4); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1.4); _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce)) then
        _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeWalls - 1, customizePatternThickness(2.75 * _iter * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult))
    end

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if a < _iter then
            if (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeWalls - 1, customizePatternThickness(2.75 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
        else cWallEx(_curSide, _largeWalls - 1, p_getPatternThickness() * _sizeMult);
        end

        if _largeWallDesign == 2 and a == 0 then cWallEx(_curSide, _largeWalls - 1, p_getPatternThickness() * _sizeMult);
        elseif _largeWallDesign < 2 and a < _iter then cWallEx(_curSide, _largeWalls - 1, p_getPatternThickness() * _sizeMult);
        end

        for c = 1, _chance, 1 do cWall(_curSide + u_rndInt(_largeWalls, getProtocolSides() - 1), p_getPatternThickness() * _sizeMult); end

        t_applyPatDel(customizePatternDelay(2.75 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osRandomizationLargeWallsTunnel(): spawns a tunnel but large walls was random
-- _largeWallsDistanceMax: maxium large wall
--       _isDelayDistance: is random barrage pattern has distance in it?
function pMarch31osRandomizationLargeWallsTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeWallsDistanceMax, _isDistanceTight, _delMult, _sizeMult, _direction, _largeWallDesign, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _largeWallDesign = anythingButNil(_largeWallDesign, 2); _isDistanceTight = anythingButNil(_isDistanceTight, 1); _delMult = anythingButNil(_delMult, 1.4); _sizeMult = anythingButNil(_sizeMult, 1);
    _direction = closeValue(math.ceil(anythingButNil(_direction, getRandomDir())), -1, 1);
    _largeWallsDistanceMax = closeValue(anythingButNil(_largeWallsDistanceMax, getProtocolSides() - 2), 1, getProtocolSides() - 2);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelOffset = 0;
    local _tunnelLoopDir = _direction;
    local _tunnelDistance = u_rndIntUpper(_largeWallsDistanceMax);
    local _QUOS = _tunnelLoopDir * 0.5 + 0.5;
    local _curTunnelDel = 0;
    local _amountCurDistanceActivate = 0;

    _isDistanceTight = getBooleanNumber(_isDistanceTight);
    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        for i = 1, getProtocolSides() - 2, 1 do cWall(_curSide + i + _tunnelOffset + _QUOS, p_getPatternThickness() * _sizeMult); end

        _tunnelLoopDir = _tunnelLoopDir * -1;
        _QUOS = _tunnelLoopDir * 0.5 + 0.5;
        _tunnelDistance = u_rndIntUpper(_largeWallsDistanceMax);

        if _isDistanceTight then _curTunnelDel = 4 * (6 / getProtocolSides()); _amountCurDistanceActivate = _tunnelDistance * 0.5 + 0.5; else _curTunnelDel = 9; _amountCurDistanceActivate = 1; end

        if a < _iter then
            if _largeWallDesign >= 1 then
                cWall(_curSide + 1 * -_tunnelLoopDir + _tunnelOffset, customizePatternThickness(_curTunnelDel * _curDelaySpeed * _delMult * _sizeMult * (_amountCurDistanceActivate), p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
                cWall(_curSide + ((getProtocolSides() - 1) - _tunnelDistance) * -_tunnelLoopDir + _tunnelOffset, customizePatternThickness(_curTunnelDel * _curDelaySpeed * _delMult * _sizeMult * (_amountCurDistanceActivate), p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
            else
                for i = 1, (getProtocolSides() - 1) - _tunnelDistance, 1 do cWall(_curSide + i * -_tunnelLoopDir + _tunnelOffset, customizePatternThickness(_curTunnelDel * _curDelaySpeed * _delMult * _sizeMult * (_amountCurDistanceActivate), p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
            end
            t_applyPatDel(customizePatternDelay(_curTunnelDel * _curDelaySpeed * _delMult * _sizeMult * (_amountCurDistanceActivate), p_getDelayPatternBool()));
            for i = 1, (getProtocolSides() - 1) - _tunnelDistance, 1 do cWall(_curSide + i * -_tunnelLoopDir + _tunnelOffset, p_getPatternThickness() * _sizeMult); end
        elseif a == _iter then
            for i = 1, (getProtocolSides() - 1) - _tunnelDistance, 1 do cWall(_curSide + i * -_tunnelLoopDir + _tunnelOffset, p_getPatternThickness() * _sizeMult); end
        end

        _tunnelOffset = _tunnelOffset + _tunnelLoopDir * _tunnelDistance;
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end
pMarch31osTunnels = pMarch31osRandomizationLargeWallsTunnel;

-- pMarch31osTrapBarrageTunnel(): spawns a trap barrage tunnel that forces you to go in the middle
--  _largeGrowWalls: same as <_largeWalls> with cWallGrow
-- _growWallClawAdd: amount of extra arm claw
--  _growWallCapAdd: amount of extra cap
function pMarch31osTrapBarrageTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeGrowWalls, _growWallClawAdd, _growWallCapAdd, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _largeWallDesign = anythingButNil(_largeWallDesign, 2); _largeGrowWalls = anythingButNil(_largeGrowWalls, 1); _delMult = anythingButNil(_delMult, 1.4); _sizeMult = anythingButNil(_sizeMult, 1);
    if not _direction or _direction > 1 or _direction < 0 then _direction = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelLoopDir = _direction;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce)) then
        _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeGrowWalls - 1, customizePatternThickness(4.75 * _iter * _curDelaySpeed * _delMult * _sizeMult, myResultBool) + ((p_getPatternThickness() / 2) * _sizeMult))
    end

    for a = 0, _iter, 1 do
        p_patternEffectCycle(_curSide, _largeWallDesign, _largeGrowWalls - 1, customizePatternThickness(4.75 * _iter * _curDelaySpeed * _delMult * _sizeMult, myResultBool) + ((p_getPatternThickness() / 2) * _sizeMult));

        if a < _iter then
            if (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignLargeGrowWallPart(_curSide, _largeWallDesign, _largeGrowWalls - 1, customizePatternThickness(4.75 * _curDelaySpeed * _delMult * _sizeMult, myResultBool) + ((p_getPatternThickness() / 2) * _sizeMult)); end
        elseif a == _iter then cWallGrow(_curSide, _largeGrowWalls - 1, p_getPatternThickness() * _sizeMult);
        end

        if (a + _tunnelLoopDir) % 2 == 1 then
            if _largeWallDesign == 2 and (a > 0 and a < _iter) then
                for i = ((_largeGrowWalls - 1) * -1) - _growWallClawAdd, (_largeGrowWalls - 1) * -1, 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
                for i = (_largeGrowWalls - 1), (_largeGrowWalls - 1) + _growWallClawAdd, 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
            else cWallGrow(_curSide, _growWallClawAdd + (_largeGrowWalls - 1), p_getPatternThickness() * _sizeMult);
            end
        else
            if _largeWallDesign == 1 and (a + _tunnelLoopDir) % 2 == 0 then cWallGrow(_curSide, _largeGrowWallExtra, p_getPatternThickness() * _sizeMult); end
            if getProtocolSides() % 2 == 1 then
                for i = -_growWallCapAdd + 1, _growWallCapAdd, 1 do cWall(_curSide + i + math.floor(getProtocolSides() / 2), p_getPatternThickness() * _sizeMult); end
            else cWallGrow(_curSide + math.floor(getProtocolSides() / 2), _growWallCapAdd, p_getPatternThickness() * _sizeMult);
            end
        end

        t_applyPatDel(customizePatternDelay(4.75 * _curDelaySpeed * _delMult * _sizeMult, myResultBool));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osBarrageSpiralTunnel(): spawns a tunnel with spiral barrage
-- _revFreq: how many times the direction will change
function pMarch31osBarrageSpiralTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _revFreq, _largeWalls, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _revFreq = anythingButNil(_revFreq, 0); _largeWallDesign = anythingButNil(_largeWallDesign, 1); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if not _direction or _direction > 1 or _direction < -1 or _direction == 0 then _direction = getRandomDir(); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelLoopDir = _direction;
    local _tunnelOffset = (_tunnelLoopDir > 0 and _largeWalls) or getProtocolSides() - 1;

    for r = 0, _revFreq, 1 do
        --for larger wall once 
        local _amountOfRevFreqUntilEnd = (r == _revFreq and 0) or 1;

        if (getBooleanNumber(_isLargeWallOnce)) and r == 0 then
            _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeWalls - 1, customizePatternThickness(4.75 * (getProtocolSides() - (_largeWalls + _amountOfRevFreqUntilEnd)) * (_revFreq + 1) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult))
        end

        for a = 1, getProtocolSides() - (_largeWalls + _amountOfRevFreqUntilEnd), 1 do
            p_patternEffectCycle();

            if a < getProtocolSides() - _largeWalls and (not getBooleanNumber(_isLargeWallOnce)) then
                _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeWalls - 1, customizePatternThickness(4.75 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
            end

            if _largeWallDesign == 2 and (a > _amountOfRevFreqUntilEnd and a < getProtocolSides() - _largeWalls) then
                for i = _largeWalls, getProtocolSides(), 1 do
                    if i ~= _tunnelOffset then cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
                end
            else cBarrage(_curSide + _tunnelOffset, p_getPatternThickness() * _sizeMult);
            end
            t_applyPatDel(customizePatternDelay(4.75 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));

            _tunnelOffset = _tunnelOffset + _tunnelLoopDir;
        end

        _tunnelLoopDir = -_tunnelLoopDir
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end
pMarch31osSideTunnel = pMarch31osBarrageSpiralTunnel;

-- pMarch31osDoubleBarrageSpiralAcrossTunnel(): spawns a tunnel with barrage doubled-hole but across
-- _largeGrowWalls: same as <_largeWalls> with cWallGrow
function pMarch31osDoubleBarrageSpiralAcrossTunnel(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _largeGrowWalls, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(1, 4)); _largeWallDesign = anythingButNil(_largeWallDesign, 2); _largeGrowWalls = anythingButNil(_largeGrowWalls, 1); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if not _direction or _direction > 1 or _direction < -1 or _direction == 0 then _direction = getRandomDir(); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelOffset = (_tunnelLoopDir > 0 and (2 * (_largeGrowWalls - 1))) or (math.floor(getProtocolSides() / 2) * 2) - 2;
    local _tunnelLoopDir = _direction;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce)) then
        _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeGrowWalls - 1, customizePatternThickness(3.6 * ((math.floor(getProtocolSides() / 2) * _iter) - _iter - ((_largeGrowWalls - 1) * _iter)) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult))
    end

    for a = 0, (math.floor(getProtocolSides() / 2) * _iter) - _iter - ((_largeGrowWalls - 1) * _iter), 1 do
        p_patternEffectCycle();
        if a < (math.floor(getProtocolSides() / 2) * _iter) - _iter - ((_largeGrowWalls - 1) * _iter) and (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignLargeGrowWallPart(_curSide, _largeWallDesign, _largeGrowWalls - 1, customizePatternThickness(3.6 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
        if _largeWallDesign == 2 and (a > 0 and a < (math.floor(getProtocolSides() / 2) * _iter) - _iter - ((_largeGrowWalls - 1) * _iter)) then
            for i = _largeGrowWalls, math.floor(getProtocolSides() / 2) + ((getProtocolSides() % 2) - 1), 1 do
                if i ~= math.floor(_tunnelOffset / 2) + 1 then cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
            end
            for j = math.ceil(getProtocolSides() / 2), getProtocolSides() - 1, 1 do
                if j ~= (getProtocolSides() - 1) - math.floor(_tunnelOffset / 2) then cWall(_curSide + j, p_getPatternThickness() * _sizeMult); end
            end
        else cBarrageDoubleHoled(_curSide - (_tunnelOffset / 2), _tunnelOffset, 0, p_getPatternThickness() * _sizeMult);
        end
        if (a % ((math.floor(getProtocolSides() / 2) * 2) - (_largeGrowWalls * 2))) >= 0 and (a % ((math.floor(getProtocolSides() / 2) * 2) - (_largeGrowWalls * 2))) < math.floor(getProtocolSides() / 2) - _largeGrowWalls then _tunnelOffset = _tunnelOffset + 2
        elseif (a % ((math.floor(getProtocolSides() / 2) * 2) - (_largeGrowWalls * 2))) >= math.floor(getProtocolSides() / 2) - _largeGrowWalls then _tunnelOffset = _tunnelOffset - 2
        end
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _curDelaySpeed, p_getDelayPatternBool()))
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end
pMarch31osDoubleSideAcrossTunnel = pMarch31osDoubleBarrageSpiralAcrossTunnel;

-- pMarch31osLRTunnelShortSpiral(): spawns a short left-right/right-left tunnel with spiral [inspired pTunnelLLR() from Hexadorsip]
--             _isHardMode: boolean of enabling hard mode
--      _gearTeethSizeMult: several thickness/gear teeth size multiplier
--           _gearTeethInc: several thickness/gear teeth increment
--       _gearTeethStepDel: amount of several thickness/gear teeth increment will delayed
--     _gearTeethStepLimit: where the several thickness/gear teeth limit reached
-- _isBeforeGearTeethBegin: similiar from <<super hexagon: hyper hexagoner>>. boolean of when after gear teeth will started + additional iterations
function pMarch31osLRTunnelShortSpiral(_side, _corridorThickOfSLT, _corridorThickOfSGET, _largeWalls, _isHardMode, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _largeWallDesign = anythingButNil(_largeWallDesign, 2); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if not _direction or _direction > 1 or _direction < -1 or _direction == 0 then _direction = getRandomDir(); end
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelOffset = (_direction < 0 and getProtocolSides()) or 0;
    local _tunnelLoopDir = _direction;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin = 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getPatternThickness() * (6 / getProtocolSides()));

    local _constructLRTunShoSpiPart = function(_side, _extra, _gearTeethStepDir)
        if _gearTeethSizeMult > 0 then cWallTkns(_side, _gearTeethStepDel, _gearTeethStepLimit, _extra, _gearTeethStepDir, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
        else cWallEx(_side, _extra, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
        end
    end

    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin);
    _isHardMode = getBooleanNumber(_isHardMode) and 1 or 0

    for a = 2, getProtocolSides() - (_largeWalls + 1), 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end

        --for larger wall once 
        if (getBooleanNumber(_isLargeWallOnce)) then
            if a == 2 then _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeWalls - 1, customizePatternThickness((4.75 * ((getProtocolSides() * 2) - (_largeWalls + 5 + _isHardMode))) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _saveOldGearTeethSizeMult * _sizeMult)); end
        else
            _constructDesignCWallExPart(_curSide, _largeWallDesign, _largeWalls - 1, customizePatternThickness((a < getProtocolSides() - (_largeWalls) - _isHardMode and 9.5 or 4.75) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _saveOldGearTeethSizeMult * _sizeMult));
        end

        if _tunnelLoopDir > 0 then
            _constructLRTunShoSpiPart(_curSide + (_tunnelOffset + (_largeWalls + 1)), getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)), 1);
            if _isHardMode > 0 then _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1), _tunnelOffset, -1); end
            if _largeWallDesign == 1 or (_largeWallDesign == 2 and a == 2) then
                _constructTunnelGearTeethCorridorFixDesignPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)), _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult, p_getPatternThickness() * _sizeMult, _gearTeethSizeMult);
                if _isHardMode > 0 then _constructTunnelGearTeethCorridorFixDesignPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, _tunnelOffset, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult, p_getPatternThickness() * _sizeMult, _gearTeethSizeMult); end
            end
            t_applyPatDel(customizePatternDelay(4.75 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1), _tunnelOffset + (_largeWalls + 1) - (_largeWalls - 1), -1);
            if _isHardMode > 0 then _constructLRTunShoSpiPart(_curSide + (_tunnelOffset + (_largeWalls + 1)) + 2, getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)) - 2, 1); end
            if _largeWallDesign == 1 or (_largeWallDesign == 2 and a == getProtocolSides() - (_largeWalls) - _isHardMode and _isHardMode > 0) then
                _constructTunnelGearTeethCorridorFixDesignPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, _tunnelOffset + (_largeWalls + 1) - (_largeWalls - 1), _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult, p_getPatternThickness() * _sizeMult, _gearTeethSizeMult);
                if _isHardMode > 0 then _constructTunnelGearTeethCorridorFixDesignPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)) - 2, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult, p_getPatternThickness() * _sizeMult, _gearTeethSizeMult); end
            end
            t_applyPatDel(customizePatternDelay(4.75 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        else
            _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1), _tunnelOffset - (_largeWalls + 1), -1);
            if _isHardMode > 0 then _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1) + (_tunnelOffset - (_largeWalls + 1)) + 2, getProtocolSides() - (_tunnelOffset - (_largeWalls + 1)) - (_largeWalls - 1) - 2, 1); end
            if _largeWallDesign == 1 or (_largeWallDesign == 2 and a == 2) then
                _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, _tunnelOffset - (_largeWalls + 1), _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
                if _isHardMode > 0 then _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, getProtocolSides() - (_tunnelOffset - (_largeWalls + 1)) - (_largeWalls - 1) - 2, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult); end
            end
            t_applyPatDel(customizePatternDelay(4.75 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1) + (_tunnelOffset - (_largeWalls + 1)), getProtocolSides() - (_tunnelOffset - (_largeWalls + 1)) - (_largeWalls - 1), 1);
            if _isHardMode > 0 then _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1) - 2, _tunnelOffset - (_largeWalls + 1), -1); end
            if _largeWallDesign == 1 or (_largeWallDesign == 2 and a == getProtocolSides() - (_largeWalls) - _isHardMode and _isHardMode > 0) then
                _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, getProtocolSides() - (_tunnelOffset - (_largeWalls + 1)), _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
                if _isHardMode > 0 then _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, _tunnelOffset - (_largeWalls + 1), _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult); end
            end
            t_applyPatDel(customizePatternDelay(4.75 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end

        _tunnelOffset = _tunnelOffset + _tunnelLoopDir;
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
    end

    if _isHardMode < 1 then
        for i = 1, _largeWalls, 1 do cWall(_curSide + i - 1, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult); end
        if _tunnelLoopDir > 0 then _constructLRTunShoSpiPart(_curSide + (_tunnelOffset + (_largeWalls + 1)), getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)), 1);
        else _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1), _tunnelOffset - (_largeWalls + 1), -1);
        end
        t_applyPatDel(customizePatternDelay(4.75 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- back and forth (double tunnel) patterns

-- pMarch31osBackAndForthTunnelAxis(): a base version of double tunnel similar of baba's pDoubleTunnel().
-- _free: amount of free corridor side
-- _modeDesign: 0 or else = default, 1 = odd ver., 2 = all sides with tunnels, 3 = all sides with tunnels w/ odd large walls
-- _modeDesign1_offset: amount of offset of first large wall
-- _modeDesign1_adjust: amount of adjust of first large wall, and second one too
-- _gearTeethSizeMult: several thickness/gear teeth size multiplier
-- _gearTeethInc: several thickness/gear teeth increment
-- _gearTeethStepDel: amount of several thickness/gear teeth increment will delayed
-- _gearTeethStepLimit: where the several thickness/gear teeth limit reached
-- _isBeforeGearTeethBegin: similiar from <<super hexagon: hyper hexagoner>>. boolean of when after gear teeth will started + additional iterations
-- _isBeforeGearTeethEnd: reverse "_isBeforeGearTeethBegin". boolean of when after gear teeth will ended + additional iterations
-- _repeatCorridorAmount: inspired from <<Quartz's Tunnel corridor repeat by Kayden>>. amount of corridor
-- _repeatCorridorDelay: how far the repeated corridor is
-- _sidedir0gap: amount of gap of direction right. (default = 1)
-- _sidedir1gap: amount of gap of direction left. (default = 1)
-- _sidedir0offset: amount of offset of direction right. (default = 0)
-- _sidedir1offset: amount of offset of direction left. (default = 0)
function pMarch31osBackAndForthTunnelAxis(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _free, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _largeWallDesign = anythingButNil(_largeWallDesign, 2); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _free = anythingButNil(_free, 0); _modeDesign = anythingButNil(_modeDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _direction or _direction > 1 or _direction < 0 then _direction = u_rndInt(0, 1); end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0); _isAfterGearTeethEnd = anythingButNil(_isAfterGearTeethEnd, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    if not _repeatCorridorAmount or _repeatCorridorAmount < 0 then _repeatCorridorAmount = 0; end
    _repeatCorridorDelay = anythingButNil(_repeatCorridorDelay, 2); _isRepeatCorridorDelaySpd = anythingButNil(_isRepeatCorridorDelaySpd, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_direction);
    local _tunnelLoopDirGearTeeth = _tunnelLoopDir > 0 and 1 or -1;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getPatternThickness() * (6 / getProtocolSides()));

    local _constructBAFTunnelAxisCorridorPart = function()
        local _tunnelGearTeethStep = 0;
        local _tunnelGearTeethAmount = 1;
        local _tunnelGearTeethInc = 0;

        for tAmount = 0, _modeDesign1_adjust + 1, 1 do
            if tAmount < _modeDesign1_adjust then _tunnelGearTeethStep = _tunnelGearTeethStep + 1
                if _tunnelGearTeethStep >= _gearTeethStepDel then _tunnelGearTeethInc = (_tunnelGearTeethAmount * _gearTeethInc) _tunnelGearTeethStep = 0; _tunnelGearTeethAmount = _tunnelGearTeethAmount + 1; end
            end
        end

        if _gearTeethSizeMult > 0 then
            _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_offset, _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
            _constructTunnelGearTeethCorridorFixPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _gearTeethStepDel, _gearTeethStepLimit, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
        else
            cWallEx(_curSide, _modeDesign1_offset, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult)
            cWallEx(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
        end
    end

    if getProtocolSides() <= 5 then _modeDesign = 3; end
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _modeDesign == 1 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                _constructDesignCWallExPart(_curSide, _largeWallDesign, _modeDesign1_offset, customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _largeWallDesign, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount then
                    _constructDesignCWallExPart(_curSide, _largeWallDesign, _modeDesign1_offset, customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _largeWallDesign, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                end

                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (1 + _free + _modeDesign1_adjust), _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                else
                    for j = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (j + 1) + _modeDesign1_offset + (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult); end
                    for k = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (k - 1 - _modeDesign1_adjust + _free) - (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult); end
                end

                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructDesignCWallExPart(_curSide, _largeWallDesign, _modeDesign1_offset, customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _largeWallDesign, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
                end
                if (_largeWallDesign == 2 and a == 0) or (_largeWallDesign == 1 and a >= 0) then _constructBAFTunnelCentralCorridorPart()
                else _constructBAFTunnelAxisCorridorPart()
                end
            else _constructBAFTunnelAxisCorridorPart()
            end
        elseif _modeDesign == 2 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                end
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount then
                    for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                end
                cWallEx(_curSide + 0 + ((a + _tunnelLoopDir) % 2) + 1, closeValue(getProtocolSides() % 3, 0, 1), p_getPatternThickness() * _sizeMult);
                cWallEx(_curSide + (closeValue(getProtocolSides() % 3, 0, 1) + 3) - ((a + _tunnelLoopDir) % 2) + 2, closeValue((getProtocolSides() % 3) - 1, 0, 1), p_getPatternThickness() * _sizeMult);
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do
                        local _dirModuloStat = (i % 2 == 1 and -1) or 1;
                        local _dirModuloOffsetFixStat = (i % 2 == 1 and 1) or 0;
                        cWall(_curSide + (i * 3) + (((a + _tunnelLoopDir) % 2) * _dirModuloStat) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 7 + _dirModuloOffsetFixStat), p_getPatternThickness() * _sizeMult);
                    end
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then 
                    for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                    if getProtocolSides() >= 9 then
                        for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                    end
                end
            else
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), p_getPatternThickness() * _sizeMult); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), p_getPatternThickness() * _sizeMult); end
                end
            end
        elseif _modeDesign == 3 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, 4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult, p_getPatternThickness(), p_getDelayPatternBool(), _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _sizeMult, _largeWallDesign);
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount then _constructBAFTunnelLargeWallPart(_curSide, _repeatCorridorDelay, p_getPatternThickness(), _isRepeatCorridorDelaySpd, _sizeMult, _largeWallDesign); end
                for i = 0, math.floor((getProtocolSides() / 6) - 0.5), 1 do cWall(_curSide + (i * 6) + ((a + _tunnelLoopDir) % 2) + 1, p_getPatternThickness() * _sizeMult); end
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do
                    local _dirModuloStat = (i % 2 == 1 and -1) or 1;
                    local _dirModuloOffsetFixStat = (i % 2 == 1 and 2) or 1;
                    cWall(_curSide + (i * 3) + (((a + _tunnelLoopDir) % 2) * _dirModuloStat) + _dirModuloOffsetFixStat, p_getPatternThickness() * _sizeMult);
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, 4.5 * _curDelaySpeed * _delMult, p_getPatternThickness(), p_getDelayPatternBool(), _sizeMult, _largeWallDesign);
                end
            else
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_curSide + (i * 3), p_getPatternThickness() * _sizeMult); end
                for i = 1, getProtocolSides() % 3, 1 do cWall(_curSide - i, p_getPatternThickness() * _sizeMult); end
            end
        else
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then rWall(_curSide, customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and not getBooleanNumber(_isLargeWallOnce) then rWall(_curSide, customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides() + (2 + _free), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                else cBarrageDoubleHoled(_curSide + (((a + _tunnelLoopDir + 1) % 2) * getHalfSides()), 0, _free, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end
            if (a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and not getBooleanNumber(_isLargeWallOnce)) then rWall(_curSide, customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        t_applyPatDel(customizePatternDelay(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osBackAndForthTunnelAxisInterpolated(): a base version of double tunnel similar of baba's pDoubleTunnel().
-- _free: amount of free corridor side
-- _modeDesign: 0 or else = default, 1 = odd ver.
-- _modeDesign1_offset: amount of offset of first large wall
-- _modeDesign1_adjust: amount of adjust of first large wall, and second one too
-- _gearTeethSizeMult: several thickness/gear teeth size multiplier
-- _gearTeethInc: several thickness/gear teeth increment
-- _gearTeethStepDel: amount of several thickness/gear teeth increment will delayed
-- _gearTeethStepLimit: where the several thickness/gear teeth limit reached
-- _isBeforeGearTeethBegin: similiar from <<super hexagon: hyper hexagoner>>. boolean of when after gear teeth will started + additional iterations
-- _isBeforeGearTeethEnd: reverse "_isBeforeGearTeethBegin". boolean of when after gear teeth will ended + additional iterations
-- _repeatCorridorAmount: inspired from <<Quartz's Tunnel corridor repeat by Kayden>>. amount of corridor
-- _repeatCorridorDelay: how far the repeated corridor is
-- _sidedir0gap: amount of gap of direction right. (default = 1)
-- _sidedir1gap: amount of gap of direction left. (default = 1)
-- _sidedir0offset: amount of offset of direction right. (default = 0)
-- _sidedir1offset: amount of offset of direction left. (default = 0)
function pMarch31osBackAndForthTunnelAxisInterpolated(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _free, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _largeWallDesign = anythingButNil(_largeWallDesign, 2); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _free = anythingButNil(_free, 0); _modeDesign = anythingButNil(_modeDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _direction or _direction > 1 or _direction < 0 then _direction = u_rndInt(0, 1); end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0); _isAfterGearTeethEnd = anythingButNil(_isAfterGearTeethEnd, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    if not _repeatCorridorAmount or _repeatCorridorAmount < 0 then _repeatCorridorAmount = 0; end
    _repeatCorridorDelay = anythingButNil(_repeatCorridorDelay, 2); _isRepeatCorridorDelaySpd = anythingButNil(_isRepeatCorridorDelaySpd, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_direction);
    local _tunnelLoopDirGearTeeth = _tunnelLoopDir > 0 and 1 or -1;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getPatternThickness() * (6 / getProtocolSides()));

    local _constructBAFTunnelAxisInterpolatedCorridorWallDirPart = function(_dir)
        if _dir > 0 then
            if _gearTeethSizeMult > 0 then _constructTunnelGearTeethCorridorFixPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _gearTeethStepDel, _gearTeethStepLimit, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
            else cWallEx(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
            end
        else
            if _gearTeethSizeMult > 0 then _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust, _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
            else cWallEx(_curSide, _modeDesign1_adjust, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult)
            end
        end
    end

    local _constructBAFTunnelAxisInterpolatedLargeWallDirPart = function(_dir, _largeWallDesign, _thickness)
        if _dir > 0 then _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _largeWallDesign, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _thickness);
        else _constructDesignCWallExPart(_curSide, _largeWallDesign, _modeDesign1_offset, _thickness);
        end
    end

    local _constructBAFTunnelAxisInterpolatedCorridorPart = function(_iter_count, _dir) _constructBAFTunnelAxisInterpolatedCorridorWallDirPart(((_iter_count + _dir) % 2)); end

    if getProtocolSides() <= 5 then _modeDesign = 2; end
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _modeDesign == 1 then
            if (getBooleanNumber(_isLargeWallOnce)) then
                if a == 0 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir) % 2), _largeWallDesign, customizePatternThickness(4.5 * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                elseif a == 1 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir + 1) % 2), _largeWallDesign, customizePatternThickness(4.5 * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                end
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then
                    if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) + 1 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart((_tunnelLoopDir % 2), _largeWallDesign, customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                    if a > 0 and a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) + 2 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir + 1) % 2), _largeWallDesign, customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                end

                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (1 + _free + _modeDesign1_adjust), _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
                else
                    for j = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (j + 1) + _modeDesign1_offset + (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult); end
                    for k = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (k - 1 - _modeDesign1_adjust + _free) - (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult); end
                end

                if _largeWallDesign ~= 1 then
                    if a < 2 then _constructBAFTunnelAxisInterpolatedCorridorPart(a, _direction) end
                    if a > (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) - 2 then _constructBAFTunnelAxisInterpolatedCorridorPart(a, _direction) end
                else _constructBAFTunnelAxisInterpolatedCorridorPart(a, _direction)
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and (not getBooleanNumber(_isLargeWallOnce)) then
                if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir) % 2), _largeWallDesign, customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                if a > 0 and a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) + 1 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir + 1) % 2), _largeWallDesign, customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
            end
        else
            if (getBooleanNumber(_isLargeWallOnce)) then
                if a == 0 then cWall(_curSide + (((_tunnelLoopDir) % 2) * getHalfSides()), customizePatternThickness(4.5 * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                elseif a == 1 then cWall(_curSide + (((_tunnelLoopDir + 1) % 2) * getHalfSides()), customizePatternThickness(4.5 * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                end
            end
            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then
                    if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) + 1 then cWall(_curSide + (((_tunnelLoopDir) % 2) * getHalfSides()), customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                    if a > 0 and a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) + 2 then cWall(_curSide + (((_tunnelLoopDir + 1) % 2) * getHalfSides()), customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                end
                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides() + (2 + _free), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                else cWallDraw(_curSide + (((a + _tunnelLoopDir + 1) % 2) * getHalfSides()), 2 + _free, getProtocolSides() - (2 + _free), p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end
            if (not getBooleanNumber(_isLargeWallOnce)) then
                if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) then cWall(_curSide + (((_tunnelLoopDir) % 2) * getHalfSides()), customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                if a > 0 and a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) + 1 then cWall(_curSide + (((_tunnelLoopDir + 1) % 2) * getHalfSides()), customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
            end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        t_applyPatDel(customizePatternDelay(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- pMarch31osBackAndForthTunnelCentral(): a base version of double tunnel similar of baba's pDoubleTunnel().
-- _free: amount of free corridor side
-- _modeDesign: 0 or else = default, 1 = odd ver., 2 = all sides with tunnels, 3 = all sides with tunnels w/ odd large walls
-- _modeDesign1_offset: amount of offset of first large wall
-- _modeDesign1_adjust: amount of adjust of first large wall, and second one too
-- _gearTeethSizeMult: several thickness/gear teeth size multiplier
-- _gearTeethInc: several thickness/gear teeth increment
-- _gearTeethStepDel: amount of several thickness/gear teeth increment will delayed
-- _gearTeethStepLimit: where the several thickness/gear teeth limit reached
-- _isBeforeGearTeethBegin: similiar from <<super hexagon: hyper hexagoner>>. boolean of when after gear teeth will started + additional iterations
-- _isBeforeGearTeethEnd: reverse "_isBeforeGearTeethBegin". boolean of when after gear teeth will ended + additional iterations
-- _repeatCorridorAmount: inspired from <<Quartz's Tunnel corridor repeat by Kayden>>. amount of corridor
-- _repeatCorridorDelay: how far the repeated corridor is
-- _sidedir0gap: amount of gap of direction right. (default = 1)
-- _sidedir1gap: amount of gap of direction left. (default = 1)
-- _sidedir0offset: amount of offset of direction right. (default = 0)
-- _sidedir1offset: amount of offset of direction left. (default = 0)
function pMarch31osBackAndForthTunnelCentral(_side, _corridorThickOfSLT, _corridorThickOfSGET, _iter, _free, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _delMult, _sizeMult, _direction, _largeWallDesign, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _largeWallDesign = anythingButNil(_largeWallDesign, 2); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _free = anythingButNil(_free, 0); _modeDesign = anythingButNil(_modeDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _direction or _direction > 1 or _direction < 0 then _direction = u_rndInt(0, 1); end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0); _isAfterGearTeethEnd = anythingButNil(_isAfterGearTeethEnd, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    if not _repeatCorridorAmount or _repeatCorridorAmount < 0 then _repeatCorridorAmount = 0; end
    _repeatCorridorDelay = anythingButNil(_repeatCorridorDelay, 2); _isRepeatCorridorDelaySpd = anythingButNil(_isRepeatCorridorDelaySpd, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickOfSLT or THICKNESS, _corridorThickOfSGET);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1 or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternHalfSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_direction);
    local _tunnelLoopDirGearTeeth = _tunnelLoopDir > 0 and 1 or -1;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getPatternThickness() * (6 / getProtocolSides()));

    local _constructBAFTunnelCentralCorridorPart = function()
        local _tunnelGearTeethStep = 0;
        local _tunnelGearTeethAmount = 1;
        local _tunnelGearTeethInc = 0;

        for tAmount = 0, _modeDesign1_adjust + 1, 1 do
            if tAmount < _modeDesign1_adjust then _tunnelGearTeethStep = _tunnelGearTeethStep + 1
                if _tunnelGearTeethStep >= _gearTeethStepDel then _tunnelGearTeethInc = (_tunnelGearTeethAmount * _gearTeethInc) _tunnelGearTeethStep = 0; _tunnelGearTeethAmount = _tunnelGearTeethAmount + 1; end
            end
        end

        if _gearTeethSizeMult > 0 then
            _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_offset, _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
            _constructTunnelGearTeethCorridorFixPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _gearTeethStepDel, _gearTeethStepLimit, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
        else
            cWallEx(_curSide, _modeDesign1_offset, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult)
            cWallEx(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
        end
    end

    if getProtocolSides() <= 5 then _modeDesign = 3; end
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _modeDesign == 1 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                _constructDesignCWallExPart(_curSide, _largeWallDesign, _modeDesign1_offset, customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _largeWallDesign, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(4.5 * _iter * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructDesignCWallExPart(_curSide, _largeWallDesign, _modeDesign1_offset, customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _largeWallDesign, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult));
                end

                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (3 + _modeDesign1_adjust), _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult);
                else
                    cWallEx(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _modeDesign1_adjust + 1, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
                    cWallEx(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (3 + _modeDesign1_adjust), _modeDesign1_adjust + 1, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
                end

                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructDesignCWallExPart(_curSide, _largeWallDesign, _modeDesign1_offset, customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _largeWallDesign, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
                end
                if (_largeWallDesign == 2 and a == 0) or (_largeWallDesign == 1 and a >= 0) then _constructBAFTunnelCentralCorridorPart()
                else _constructBAFTunnelCentralCorridorPart()
                end
            else _constructBAFTunnelCentralCorridorPart()
            end
        elseif _modeDesign == 2 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                end
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then
                    for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                end
                cWallEx(_curSide + 0 + ((a + _tunnelLoopDir) % 2) + 1, closeValue(getProtocolSides() % 3, 0, 1), p_getPatternThickness() * _sizeMult);
                cWallEx(_curSide + (closeValue(getProtocolSides() % 3, 0, 1) + 3) + ((a + _tunnelLoopDir) % 2) + 1, closeValue((getProtocolSides() % 3) - 1, 0, 1), p_getPatternThickness() * _sizeMult);
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + ((a + _tunnelLoopDir) % 2) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 7), p_getPatternThickness() * _sizeMult); end
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then 
                    for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                    if getProtocolSides() >= 9 then
                        for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                    end
                end
            else
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), p_getPatternThickness() * _sizeMult); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), p_getPatternThickness() * _sizeMult); end
                end
            end
        elseif _modeDesign == 3 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, 4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult, p_getPatternThickness(), p_getDelayPatternBool(), _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _sizeMult, _largeWallDesign);
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, _repeatCorridorDelay, p_getPatternThickness(), _isRepeatCorridorDelaySpd, _sizeMult, _largeWallDesign); end
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_curSide + (i * 3) + ((a + _tunnelLoopDir) % 2) + 1, p_getPatternThickness() * _sizeMult); end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, 4.5 * _curDelaySpeed * _delMult, p_getPatternThickness(), p_getDelayPatternBool(), _sizeMult, _largeWallDesign);
                end
            else
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_curSide + (i * 3), p_getPatternThickness() * _sizeMult); end
                for i = 1, getProtocolSides() % 3, 1 do cWall(_curSide - i, p_getPatternThickness() * _sizeMult); end
            end
        else
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then rWall(_curSide, customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and not getBooleanNumber(_isLargeWallOnce) then rWall(_curSide, customizePatternThickness(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd) + ((p_getPatternThickness() / 2) * _sizeMult)); end
                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides(), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                else cBarrageVorta(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _free, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _sizeMult, _isRepeatCorridorDelaySpd)); end
            end
            if (a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and not getBooleanNumber(_isLargeWallOnce)) then rWall(_curSide, customizePatternThickness(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        t_applyPatDel(customizePatternDelay(4.5 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end