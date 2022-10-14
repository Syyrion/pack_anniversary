u_execDependencyScript('library_extbase', 'extbase', 'syyrion', 'utils.lua')

local lua_version = 5.1
local game_version = 2.15

--2.x.x+ & 1.92 conv functs
local t_wait = t_wait or wait
local l_getSides = l_getSides or getSides
local l_getSpeedMult = l_getSpeedMult or getSpeedMult
local l_getDelayMult = l_getDelayMult or getDelayMult
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_getDelayMultDM = u_getDelayMultDM or getDelayMult
local u_isFastSpinning = u_isFastSpinning or isFastSpinning
local u_getDifficultyMult = u_getDifficultyMult or getDifficultyMult
local u_rndInt = u_rndInt or math.random
local u_rndIntUpper = u_rndIntUpper or math.random
local u_rndReal = u_rndReal or math.random
--deprecated functs
local e_waitS = e_waitS or e_eventWaitS
local e_waitUntilS = e_waitUntilS or e_eventWaitUntilS
local a_playSound = a_playSound or u_playSound
local e_messageAddImportant = e_messageAddImportant or m_messageAddImportant or messageImportantAdd

--[[
    var: number THICKNESS
    var: number DELAY_CONSTANT
    var: number PLAYER_SPEED
    var: number THICKNESS_PERFECT_ADD_ENDED
    var: number EMULATED_SIDES_AMOUNT
    var: number SHAPE_TYPE
    var: number TARGET_PATTERN_SIDE
    var: number GLOBAL_TEMPO
    var: number GLOBAL_TEMPO_DM_STATE
    var: number GLOBAL_SPAWN_DISTANCE_MULT
    var: number GLOBAL_SPAWN_DISTANCE_ADD
    var: number GLOBAL_TIME_SIGNATURE

    int getProtocolSides()
    int getPolySides(_side_amount, _float_type)
    int getFakeSideLength(_fake_sides_amount)

    number u_getTrueSpeedMult()
    number u_getTrueDelayMult()

    number getWallFrameTime(_fps)

    int doDecide(_val1, _val2)
    void setVariable(_varName, _varInput)

    void getValOfOddOrEven(_value, _odd_or_even)

    number getSecondsNumber(_amount)

    bool number getBooleanNumber(_numb_val)

    int isValueType(_input, _type, _is_opposite, _val1_result, _val2_result)
    int bool verifyValueType(_input, _type)
    int anythingButNil(_input, _input_to_avoid)

    table u_rndTablePick(_table_of_tables)
    number table math_sum(_table_of_numbers)

    var: bool pstr_currentResultBool
    var: number pstr_currentDelayMultOfSpeedLessThan
    var: number pstr_currentThickness

    bool p_getDelayPatternBool()
    number p_getDelayPatternOfSpeedLessThan()
    number p_getPatternThickness()

    void p_setDelayPatternBool(_bool)
    void p_setDelayPatternOfSpeedLessThan(_thickMult_amount)
    void p_setPatternThickness(_corridorThick)

    void p_resetPatternDelaySettings()
    void p_adjustPatternDelaySettings(_spdMultDMIsGreaterThanEqual, _delMultOfSpeedLessThan, _corridorThickOfSpdGreaterThanEqual, _corridorThickOfSpdLessThan)

    void p_setOverrideShape(_sideType, _emulatedSides)

    var: number marchiocommon_currentTimerAmount

    void l_updateLevelFrameTime(mFrameTime, _fps)
    number l_getLevelFrameTime()

    void l_getSyncLevelTimeToMusicDM(_timer_input)
    void l_getTargetLevelTimeDuration(_min_timer, _max_timer, _is_sync_to_dm, _timer_input)

    void t_applyPatDel(_wait_amount)

    void e_waitSecDM(_duration)
    void e_waitUntilSecDM(_duration)

    var: number marchiocommon_currentEventTime
    var: number marchiocommon_currentEventSection
    var: bool marchiocommon_isDebounceInAdvanceEventHalter
    var: bool marchiocommon_isDebounce
    var: bool marchiocommon_isAdvanceHalted

    void e_updateEventSection(_is_sync_to_dm, _dur_offset, _timer_input, _launch_time)
    int bool e_detectEventSection(_duration_target, _section_target, _is_halt_advance)
    int bool e_detectEventDebounceIfHalterStarts()
    int bool e_advanceEventSectionIfHalted(_duration_target)

    number e_getEventTimeDuration()
    number e_getEventSection()
    void e_setEventSection(_amount)

    number getPatternDelayMult(_delay_amount)
    number getSpeedWallThickness(_thickness_amount, _division, _is_delay_mult)


    int getHalfSides(_float_type)
    int getTriSides(_float_type)
    int getQuadSides(_float_type)
    int getPentaSides(_float_type)
    int getHexaSides(_float_type)
    int getHeptaSides(_float_type)
    int getOctaSides(_float_type)
    int getNonaSides(_float_type)
    int getDecaSides(_float_type)
    int getRandomSide(_side)

    int getPlayerSide()
    int getSideDistance(_side1, _side2)
    number getRandomNeg()
    impl: number getRandomDir = getRandomNeg

    number getPerfectDelay(_delay_amount)
    number getPerfectThickness(_thickness_amount)

    impl: number getPerfectDelayDM = getPerfectDelay


    int getChance(_chance)

    number getDelayWalls(_delay_amount)
    number getDelaySides(_delay_amount)
    number getDelayAngle(_delay_amount_deg)

    number getDelayWallAndSides(_delay_amount)

    number getAccurateThickness()
    number getThicknessOfDelay(_thickness_amount)


    int getDelayConstAndSides(_game_ver)
    int getPulseContribution(_game_ver)
    int getThickPulse(_game_ver)
    void l_setZoom(_factor, _base1, _base2, _base3, _base4, _game_ver)
    int winding(_min_val, _max_val)


    int getRebootPatternSide()
    int getRebootPatternHalfSide(_side_div)
    int getPolygonExcept(_side, _side_div)
    number getSpeedDelay(_startSpeed)


    int getBarrageSide(_gap)

    number getNeg(_val)
    impl: number getDir = getNeg
    int getRotationDir(_game_ver)

    number convValue(mFrameTime, _value, _valueTo, _strength)
    number closeValue(_input, _min_val, _max_val, _lim_type)
    number getLevelTimeSine(_spd, _del, _timer_input)
    number isOddOrEven(_value, _odd_or_even)
    number quantiseValue(_val, _div_primary, _div_secondary)
    number getRndReal(_maxVal)
    number forceAbsValue(_value, _is_opposite)

    number math_add(_val, _amount)
    number math_sub(_val, _amount)
    number math_mul(_val, _amount)
    number math_div(_val, _amount)
    number math_mod(_val, _amount)
    number math_pow(_val, _amount)
    number math_root(_val, _amount)

    var: number marchiocommon_isManualIncrementing
    var: number marchiocommon_currentManualIncrementTimer
    var: number marchiocommon_currentManualIncrementTimes

    void u_forceManualIncrement(_rot_inc, _spd_inc, del_inc)
    void u_forceManualIncrementV1Compatibility(_rot_inc, _spd_inc, del_inc)
    void u_doManualIncrements(_inc_duration, _rot_inc, _spd_inc, del_inc, _game_ver, _is_sync_to_dm, _timer_input)
    bool u_hasIncrementedManually()
    impl: bool u_hasManualIncremented = u_hasIncrementedManually

    number u_getManualIncrementTimes()
    void u_setManualIncrementTimes(_amount)

    number u_getManualIncrementDurationOffset()
    void u_setManualIncrementDurationOffset(_offset_amount)

    var: number marchiocommon_isIncrementing
    bool u_hasIncremented()

    int convertBPMtoSeconds(_tempo, _division, _multiply)
    impl: int getBPM = convertBPMtoSeconds
    impl: int getSync = convertBPMtoSeconds

    var: number marchiocommon_currentSyncedPulseTimer
    var: number marchiocommon_currentSyncedPulseTimerOffsetFix
    var: number marchiocommon_currentSyncedPulseTimes
    var: number marchiocommon_currentBeatPulse
    var: bool marchiocommon_boolPulseActiveHeld
    var: bool marchiocommon_boolPulseActiveOnce

    void l_setSyncedPulse(mFrameTime, _tempo_input, _is_advanced_tempo, _effect_type, _is_instant_pul_spd, _lvl_pul_min, _lvl_pul_max, _lvl_pul_spd, _lvl_pul_spd_r, _lvl_pul_dir, _lvl_beat_pul_max, _lvl_beat_pul_spd, _lvl_rot_spd, _lvl_rot_spd_mult, _lvl_rot_spd_dir, _rev_del, _is_sync_to_dm, _timer_input)
    void l_setSyncedPulseInstant(mFrameTime, _tempo_input, _is_advanced_tempo, _effect_type, _lvl_pul_min, _lvl_pul_max, _lvl_pul_spd, _lvl_pul_spd_r, _lvl_pul_dir, _lvl_beat_pul_max, _lvl_beat_pul_spd, _lvl_rot_spd, _lvl_rot_spd_mult, _lvl_rot_spd_dir, _rev_del, _is_sync_to_dm, _timer_input)
    void l_setSyncedPulseV1Compatibility(_tempo_input, _is_advanced_tempo, _effect_type, _is_instant_pul_spd, _lvl_pul_min, _lvl_pul_max, _lvl_pul_spd, _lvl_pul_spd_r, _lvl_pul_dir, _lvl_beat_pul_max, _lvl_beat_pul_spd, _lvl_rot_spd, _lvl_rot_spd_mult, _lvl_rot_spd_dir, _rev_del, _is_sync_to_dm, _timer_input)
    bool l_isPulseActiveHeld()
    bool l_isPulseActiveOnce()

    number l_getSyncedPulseTimes()
    void l_setSyncedPulseTimes(_amount)

    number l_getSyncedPulseTimerOffset()
    void l_setSyncedPulseTimerOffset(_offset_amount)

    var: number marchiocommon_currentPulseDetectorTimer
    var: number marchiocommon_currentPulseDetectorTimes
    var: bool marchiocommon_boolPulseDetectedHeld
    var: bool marchiocommon_boolPulseDetectedOnce

    void l_setPulseDetector(_dur_input, _is_using_bpm, _rev_del, _is_sync_to_dm, _timer_input)
    bool l_isPulseDetectedHeld()
    bool l_isPulseDetectedOnce()

    number l_getPulseDetectorTimes()
    void l_setPulseDetectorTimes(_amount)

    number l_getPulseDetectorTimerOffset()
    void l_setPulseDetectorTimerOffset(_offset_amount)

    var: number marchiocommon_currentInvincibilityTimer
    var: number marchiocommon_currentInvincibilityDuration
    var: bool marchiocommon_boolIsInvincibilityDeployed

    void mch_getEmergencyInvinciblity(_wait_amount, _duration_amount, _timer_input)
    void mch_doEmergencyInvinciblityReset(_timer_input)

    bool mch_isEmergencyInvinciblityDeployed()

    number mch_getEmergencyInvincibilityTimerOffset()
    void mch_setEmergencyInvincibilityTimerOffset(_offset_amount)

    var: number marchiocommon_currentOverridePatternDelay

    number p_getOverridePatternDelay()
    void p_setOverridePatternDelay(_override_amount)
    impl: void overrideDelay = p_setOverridePatternDelay

    number customizePatternDelay(_delay_amount, _is_spd_mult)
    number customizePatternThickness(_thickness_amount, _is_spd_mult)
    impl: number custWait = customizePatternDelay
    impl: number custThickness = customizePatternThickness
    number customizeTempoPatternDelay(_delay_amount)
    number customizeTempoPatternThickness(_thickness_amount)

    void p_updateGlobalSyncedPatterns()

    var: number marchiocommon_oldSyncedPatternRepairSeconds

    void p_setGlobalSyncedPatternSettings(_tempo, _spawn_dist_mult, _spawn_dist_add, _1st_time_signature, _2nd_time_signature, _is_sync_to_dm)

    var: number marchiocommon_currentSyncedPatternRepairDuration
    var: number marchiocommon_currentSyncedPatternRepairTimes

    void p_updateSyncedPatternRepair(_beat_duration_amount, _beat_delay_amount, _is_spd_inc_fix, _func_primary, _func_secondary, _timer_input)

    number p_getSyncedPatternRepairUpdaterTimes()
    void p_setSyncedPatternRepairUpdaterTimes(_amount)

    number p_getSyncedPatternRepairUpdaterTimerOffset()
    void p_setSyncedPatternRepairUpdaterTimerOffset(_offset_amount)


    int getRandomNegVal(_input)
    impl: int number getRandomDirVal = getRandomNegVal
    number loopValue(_input, _min_val, _max_val)

    int convertSecondsToBPM(_input)
    impl: int revertBPM = convertSecondsToBPM
    impl: int revertSync = convertSecondsToBPM

    var: number marchiocommon_currentRotSpdMultOfFastSpin

    void  u_updateRotSpdOfFastSpinning(mFrameTime, _conv_mult)
    number  u_getRotSpdOfFastSpinning()
    void  u_setRotSpdOfFastSpinning(_amount)

    var: number marchiocommon_currentSyncedBeatPulseTimer
    var: number marchiocommon_currentSyncedBeatPulseTimes
    var: number marchiocommon_currentSyncedBeatPulseAmount
    var: bool marchiocommon_boolBeatPulseActive

    void l_setSyncedBeatPulse(mFrameTime, _game_ver, _tempo_input, _is_advanced_tempo, _lvl_beat_pul_max, _lvl_beat_pul_spd, _is_sync_to_dm, _timer_input)
    bool l_isBeatPulseActive()

    number l_getSyncedBeatPulseTimes()
    void l_setSyncedBeatPulseTimes(_amount)

    number l_getSyncedBeatPulseTimerOffset()
    void l_setSyncedBeatPulseTimerOffset(_offset_amount)

    var: number marchiocommon_currentInvincibilityTimer
    var: number marchiocommon_currentInvincibilityTimes
    var: number marchiocommon_currentAdvPulse
    var: number marchiocommon_currentAdvPulseSpd
    var: number marchiocommon_currentAdvBeatPulse
    var: bool marchiocommon_boolPulseActiveHeld
    var: bool marchiocommon_boolPulseActiveOnce

    void l_setSyncedAdvancedPulse(_frameTime, _game_ver, _tempo_input, _is_advanced_tempo, _pul_override_amount, _lvl_pul_min, _lvl_pul_max, _lvl_pul_spd, _lvl_pul_spd_r, _lvl_pul_dir, _pul_rev_del, _lvl_beat_pul_max, _lvl_beat_pul_spd, _lvl_rad_min, _is_sync_to_dm, _timer_input)
    bool l_isAdvancedPulseActiveHeld()
    bool l_isAdvancedPulseActiveOnce()

    number l_getSyncedAdvancedPulseTimes()
    void l_setSyncedAdvancedPulseTimes(_amount)

    number l_getSyncedAdvancedPulseTimerOffset()
    void l_setSyncedAdvancedPulseTimerOffset(_offset_amount)

    var: number marchiocommon_currentWallRemovalTimer
    var: number marchiocommon_currentWallRemovalDuration
    var: bool marchiocommon_boolIsWallRemovalDeployed

    void mch_getEmergencyWallRemoval(_wait_amount, _timer_input)
    void mch_doEmergencyWallRemovalReset(_timer_input)

    bool mch_isEmergencyWallRemovalDeployed()

    number mch_getEmergencyWallRemovalTimerOffset()
    void mch_setEmergencyWallRemovalTimerOffset(_offset_amount)
]]

--march31onne utils. i created this.

-- common variables
THICKNESS = 40.0;
DELAY_CONSTANT = 800 / 21
PLAYER_SPEED = 9.449999809265137; --deg/frame
THICKNESS_PERFECT_ADD_ENDED = 4.0;
EMULATED_SIDES_AMOUNT = 6;
SHAPE_TYPE = 0;
TARGET_PATTERN_SIDE = -256;
-- for synced common variables
GLOBAL_TEMPO = 128;
GLOBAL_TEMPO_DM_STATE = 1;
GLOBAL_SPAWN_DISTANCE_MULT = 1;
GLOBAL_SPAWN_DISTANCE_ADD = 0;
GLOBAL_TIME_SIGNATURE = 4 / 4;

if lua_version < 5.3 then
    -- did realize not doing this gave call a nil value error on lua v5.1
    function table.unpack (t, i)
        i = i or 1
        if t[i] ~= nil then
            return t[i], table.unpack(t, i + 1)
        end
    end
end

-- formatted warning messages (made by me)
function warnf(_is_msg, _label, _message, ...)
    local usethismsg = e_messageAddImportant or m_messageAddImportant or messageImportantAdd;
    if (_is_msg) then usethismsg(("-= WARNING RAISED (%s) // CHECK CONSOLE =-"):format(_label), 999) end
    print(('[%sWarning] '):format(_label) .. _message:format(...))
end

--[ Begin Marchionne's commons ]--

--sides
function getProtocolSides()
    if (SHAPE_TYPE >= 1) then return EMULATED_SIDES_AMOUNT; end
    return l_getSides();
end

function getPolySides(_side_amount, _float_type)
    if type(_float_type) == "string" then _float_type = (_float_type == "floor" and math.floor) or (_float_type == "ceil" and math.ceil) or math.ceil; else _float_type = math.ceil; end
    return _float_type(getProtocolSides() / (type(_side_amount) == "number" and math.floor(_side_amount) or 2));
end
function getFakeSideLength(_fake_sides_amount) return math.floor(l_getSides() / (type(_fake_sides_amount) == "number" and math.floor(_fake_sides_amount) or 6)); end

--utils
function u_getTrueSpeedMult() return l_getSpeedMult() * (u_getDifficultyMult() ^ 0.65) * 1.25; end
function u_getTrueDelayMult() return l_getDelayMult() * (u_getDifficultyMult() ^ 0.1); end

--obsolete funct, maybe ._.
function getWallFrameTime(_fps) return (THICKNESS * u_getSpeedMultDM()) / (_fps or 60) end

function doDecide(_val1, _val2) return (_val1 or _val2); end
function setVariable(_varName, _varInput) _varName = _varInput; end

function getValOfOddOrEven(_value, _odd_or_even)
    _value = type(_value) == "number" and math.floor(_value) and 0;
    _odd_or_even = (_odd_or_even > 0 and 1) or 0;
    if _value % 2 == _odd_or_even then return _value; end
    return (_value - 1);
end

function getSecondsNumber(_amount) return _amount * 60; end

function getBooleanNumber(_numb_val)
    if (_numb_val == nil) then _numb_val = false;
    elseif (_numb_val ~= true) and (_numb_val ~= false) then
        if (_numb_val > 0) then _numb_val = true;
        elseif (_numb_val <= 0) then _numb_val = false;
        end
    end
    return _numb_val;
end

function isValueType(_input, _type, _is_opposite, _val1_result, _val2_result)
    if type(_type) ~= "string" then errorf(2, "Input", "argument #2 is not a string.") end
    if getBooleanNumber(_is_opposite) then return (type(_input) ~= _type and _val1_result) or _val2_result;
    else return (type(_input) == _type and _val1_result) or _val2_result;
    end
end

function verifyValueType(_input, _type)
    if type(_type) ~= "string" then errorf(2, "Verification", "argument #2 is not a string.") end
    return type(_input) == _type
end

function anythingButNil(_input, _input_to_avoid)
    if (_input_to_avoid == nil) then errorf(2, "AvoidNilInput", "DO NOT INPUT <nil> IN THIS ARGUMENT #2") end
    if (_input == nil) then return _input_to_avoid or 0; end
    return _input
end

--maths
--i found a randomPick & tSum from L3010's utils, from L3010's pack.
function u_rndTablePick(_table_of_tables)
    return _table_of_tables[u_rndIntUpper(#_table_of_tables)]
end

function math_sum(_table_of_numbers)
    local _curSum = 0;
    if #_table_of_numbers > 0 then
        for a = 1, #_table_of_numbers, 1 do
            if type(_table_of_numbers[a]) ~= "number" then errorf(2, "Sum", "table #%d is not a number. why did you input a non-number value?", a) end
            _curSum = _curSum + _table_of_numbers[a]
        end
        return _curSum;
    end
    return _curSum;
end

--pattern settings
local pstr_currentResultBool = false;
local pstr_currentDelayMultOfSpeedLessThan = 0;
local pstr_currentThickness = THICKNESS;

function p_getDelayPatternBool() return pstr_currentResultBool; end
function p_getDelayPatternOfSpeedLessThan() return pstr_currentDelayMultOfSpeedLessThan; end
function p_getPatternThickness() return pstr_currentThickness; end

function p_setDelayPatternBool(_bool) pstr_currentResultBool = getBooleanNumber(_bool); end
function p_setDelayPatternOfSpeedLessThan(_thickMult_amount) pstr_currentDelayMultOfSpeedLessThan = _thickMult_amount; end
function p_setPatternThickness(_corridorThick) pstr_currentThickness = _corridorThick; end

function p_resetPatternDelaySettings()
    pstr_currentResultBool = false; pstr_currentDelayMultOfSpeedLessThan = 0; pstr_currentThickness = THICKNESS;
end

function p_adjustPatternDelaySettings(_spdMultDMIsGreaterThanEqual, _delMultOfSpeedLessThan, _corridorThickOfSpdLessThan, _corridorThickOfSpdGreaterThanEqual)
    if u_getSpeedMultDM() < _spdMultDMIsGreaterThanEqual then pstr_currentDelayMultOfSpeedLessThan = _delMultOfSpeedLessThan; pstr_currentResultBool = false; pstr_currentThickness = _corridorThickOfSpdLessThan or THICKNESS;
    elseif u_getSpeedMultDM() >= _spdMultDMIsGreaterThanEqual then pstr_currentDelayMultOfSpeedLessThan = 1; pstr_currentResultBool = true; pstr_currentThickness = _corridorThickOfSpdGreaterThanEqual or _corridorThickOfSpdLessThan;
    end
end

function p_setOverrideShape(_sideType, _emulatedSides)
    if type(_sideType) ~= "number" then errorf(2, "SideType", "argument #1 is not a number. why did you input a non-number value?") end
    if type(_emulatedSides) ~= "number" then errorf(2, "EmluateSide", "argument #2 is not a number. why did you input a non-number value?") end
    SHAPE_TYPE = math.floor(_sideType) or 0; EMULATED_SIDES_AMOUNT = math.floor(_emulatedSides) or 6;
end

--timers
local marchiocommon_currentTimerAmount = 0;

function l_updateLevelFrameTime(mFrameTime, _fps) marchiocommon_currentTimerAmount = marchiocommon_currentTimerAmount + (mFrameTime / (_fps or 60)); end
function l_getLevelFrameTime() return marchiocommon_currentTimerAmount; end

function l_getSyncLevelTimeToMusicDM(_timer_input)
    _timer_input = _timer_input or l_getLevelTime();
    return _timer_input * (u_getDifficultyMult() ^ 0.12);
end
l_getLevelTimeDM = l_getSyncLevelTimeToMusicDM;

function l_getTargetLevelTimeDuration(_min_timer, _max_timer, _is_sync_to_dm, _timer_input)
    if _is_sync_to_dm == nil then _is_sync_to_dm = false; end
    _timer_input = _timer_input or l_getLevelTime();

    local marchiocommon_DMvalue = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;

    if ((_timer_input * marchiocommon_DMvalue) >= _min_timer) and (_max_timer > (_timer_input * marchiocommon_DMvalue)) then return true; end
    return false;
end

--timelines
function t_applyPatDel(_wait_amount) t_wait(_wait_amount) end

--events
function e_waitSecDM(_duration) e_waitS(_duration * (u_getDifficultyMult() ^ -0.12)); end
function e_waitUntilSecDM(_duration) e_waitUntilS(_duration * (u_getDifficultyMult() ^ -0.12)); end

local marchiocommon_currentEventTime = 0;
local marchiocommon_currentEventSection = 0;
local marchiocommon_isDebounceInAdvanceEventHalter = true;
local marchiocommon_isDebounce = false;
local marchiocommon_isAdvanceHalted = false;

function e_updateEventSection(_is_sync_to_dm, _dur_offset, _timer_input, _launch_time)
    _timer_input = _timer_input or l_getLevelTime();
    local marchiocommon_DMvalue = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;
    marchiocommon_currentEventTime = (_timer_input - (_launch_time or 0) + (_dur_offset or 0)) * marchiocommon_DMvalue;
end

function e_detectEventSection(_duration_target, _section_target, _is_halt_advance)
    if (marchiocommon_currentEventTime >= _duration_target and marchiocommon_currentEventSection == _section_target) then
        if getBooleanNumber(_is_halt_advance) == false then marchiocommon_currentEventSection = (marchiocommon_currentEventSection + 1);
        else
            marchiocommon_isAdvanceHalted = true;
            if (marchiocommon_isDebounceInAdvanceEventHalter) and (not marchiocommon_isDebounce) then
                marchiocommon_isDebounceInAdvanceEventHalter = false; marchiocommon_isDebounce = true;
            end
        end
        return true;
    end
    return false;
end

function e_detectEventDebounceIfHalterStarts()
    if (marchiocommon_isDebounce) then marchiocommon_isDebounce = false; return true; end
    return false;
end

function e_advanceEventSectionIfHalted(_duration_target)
    _duration_target = _duration_target or 0
    if (marchiocommon_currentEventTime >= _duration_target) and (marchiocommon_isAdvanceHalted) then
        marchiocommon_currentEventSection = (marchiocommon_currentEventSection + 1);
        marchiocommon_isAdvanceHalted = false; marchiocommon_isDebounceInAdvanceEventHalter = true;
        return true;
    end
    return false;
end

function e_getEventTimeDuration() return marchiocommon_currentEventTime; end

function e_getEventSection() return marchiocommon_currentEventSection; end
function e_setEventSection(_amount) marchiocommon_currentEventSection = _amount; end

--delay & thickness
function getPatternDelayMult(_delay_amount) return (_delay_amount * u_getDelayMultDM()); end

function getSpeedWallThickness(_thickness_amount, _division, _is_delay_mult)
    _is_delay_mult = getBooleanNumber(_is_delay_mult)
    local _delayMultState = (_is_delay_mult and u_getDelayMultDM()) or 1;
    return (_thickness_amount * (u_getSpeedMultDM()) / (_division or 2) * _delayMultState);
end

--[ Begin main commons ]--

--sides
function getHalfSides(_float_type)  return getPolySides(2,  _float_type); end
function getTriSides(_float_type)   return getPolySides(3,  _float_type); end
function getQuadSides(_float_type)  return getPolySides(4,  _float_type); end
function getPentaSides(_float_type) return getPolySides(5,  _float_type); end
function getHexaSides(_float_type)  return getPolySides(6,  _float_type); end
function getHeptaSides(_float_type) return getPolySides(7,  _float_type); end
function getOctaSides(_float_type)  return getPolySides(8,  _float_type); end
function getNonaSides(_float_type)  return getPolySides(9,  _float_type); end
function getDecaSides(_float_type)  return getPolySides(10, _float_type); end

function getRandomSide(_side) return u_rndInt(0, (type(_side) == "number" and _side or getProtocolSides()) - 1) end

function getPlayerSide()
    local playerPosition = math.deg(u_getPlayerAngle())
    local sideLength = (360 / getProtocolSides())
    local offset = sideLength / 2

    return math.floor((playerPosition + offset) % 360 / sideLength)
end

function getSideDistance(_side1, _side2)
    if (_side1 == _side2) then
        return 0
    end
    -- Pick out the lower and higher side
    local low = math.min(_side1, _side2)
    local high = math.max(_side1, _side2)
    -- We need to get both high and low positive for modulus to work properly
    -- We only need to check the lower number for this.
    if (low < 0) then
        high = high - low
        low = 0
    end
    -- Calculate the difference and make any last minute adjustments accordingly
    local diff = (high - low) % getProtocolSides()
    if (diff > getHalfSides()) then
        return getProtocolSides() - diff
    end
    return diff
end

--dirs
function getRandomNeg() return u_rndInt(0, 100) > 50 and 1 or -1; end
getRandomDir = getRandomNeg;

--delay & thickness
function getPerfectDelay(_delay_amount) return _delay_amount / (5.02 * u_getSpeedMultDM()) * u_getDelayMultDM() end
function getPerfectThickness(_thickness_amount) return _thickness_amount * u_getSpeedMultDM() end

--implemented getPerfectDelayDM's implementation to getPerfectDelay -- keeping the name for compatibility reasons
getPerfectDelayDM = getPerfectDelay;

--[ Begin Kodipher's common ]--

--utils
function getChance(_chance) return ((u_rndReal() * 1) <= _chance); end

--delays
function getDelayWalls(_delay_amount) return ((THICKNESS - THICKNESS_PERFECT_ADD_ENDED) / (5.02 * u_getSpeedMultDM()) * u_getDelayMultDM()) * _delay_amount; end
function getDelaySides(_delay_amount) return (360 / getProtocolSides()) / PLAYER_SPEED * _delay_amount; end
function getDelayAngle(_delay_amount_deg) return _delay_amount_deg / PLAYER_SPEED; end

function getDelayWallAndSides(_delay_amount) return getDelayWalls(1) + getDelaySides(_delay_amount); end

--thickness
function getAccurateThickness() return ((360 / getProtocolSides()) / PLAYER_SPEED) / u_getDelayMultDM() * (5.02 * u_getSpeedMultDM()) + THICKNESS_PERFECT_ADD_ENDED; end
function getThicknessOfDelay(_delay_amount) return _delay_amount * 5.02 * u_getSpeedMultDM() * u_getDelayMultDM() + THICKNESS_PERFECT_ADD_ENDED; end

--[ Begin Quantum's common ]--

--utils
function getDelayConstAndSides(_del_mult)
    return DELAY_CONSTANT / getProtocolSides() * (_del_mult or 1), getProtocolSides()
end

-- for ease of use
-- thickPulse = THICKNESS + l_getBeatPulseMax() + l_getRadiusMin() * (l_getPulseMax() / l_getPulseMin() - 1)
-- pulseContrib = l_getBeatPulseMax() + l_getRadiusMin() * (l_getPulseMax() / l_getPulseMin() - 1)
function getPulseContribution(_game_ver)
    _game_ver = _game_ver and game_version
    if _game_ver >= 2 then return l_getBeatPulseMax() + l_getRadiusMin() * (l_getPulseMax() / l_getPulseMin() - 1)
    else                   return getLevelValueFloat("beatpulse_max") + getLevelValueFloat("radius_min") * (getLevelValueFloat("pulse_max") / getLevelValueFloat("pulse_min") - 1)
    end
end

function getThickPulse(_game_ver)
    return THICKNESS + getPulseContribution(_game_ver)
end

--this function allows you to set a winding amount rather than number of walls for spiral.
function winding(_min_val, _max_val)
    if _max_val == nil then _max_val = _min_val end
    if _min_val < 1 + (1/getProtocolSides()) then _min_val = 1 + (1/getProtocolSides()) end

    return u_rndInt(math.floor(_min_val * getProtocolSides()), math.floor(_max_val * getProtocolSides()))
end

--takes the base value and zooms out by factor.
function l_setZoom(_factor, _base1, _base2, _base3, _base4, _game_ver)
    _game_ver = _game_ver and game_version
    if _game_ver >= 2 then
        l_setRadiusMin(   (_base1 or l_getRadiusMin())    / _factor)
        l_setPulseMax(    (_base2 or l_getPulseMax())     / _factor)
        l_setPulseMin(    (_base3 or l_getPulseMin())     / _factor)
        l_setBeatPulseMax((_base4 or l_getBeatPulseMax()) / _factor)
    else
        setLevelValueFloat("radius_min",    (_base1 or getLevelValueFloat("radius_min"))    / _factor)
        setLevelValueFloat("pulse_max",     (_base2 or getLevelValueFloat("pulse_max"))     / _factor)
        setLevelValueFloat("pulse_min",     (_base3 or getLevelValueFloat("pulse_min"))     / _factor)
        setLevelValueFloat("beatpulse_max", (_base4 or getLevelValueFloat("beatpulse_max")) / _factor)
    end
end

--[ Begin The Sun XIX's common ]--

--sides
function getRebootPatternSide() return u_rndInt(1, getProtocolSides() - 1); end -- if _curSide == TARGET_PATTERN_SIDE...
function getRebootPatternHalfSide(_side_div) return u_rndInt(1, math.floor(getProtocolSides() / (type(_side_div) == "number" and _side_div or 2)) - 1); end -- u_rndInt(1, halfsides)
function getPolygonExcept(_side, _side_div) return math.floor((getProtocolSides() - (type(_side) == "number" and _side or 6)) / (type(_side_div) == "number" and _side_div or 2)); end -- non-polygon boost

--delays
function getSpeedDelay(_startSpeed) return (u_getSpeedMultDM() - (_startSpeed or u_getSpeedMultDM())); end

--[ Begin babadrake's common ]--

--sides
function getBarrageSide(_gap) return getProtocolSides() - (_gap or 1); end

--dirs
function getNeg(_val) return (_val > 0 and 1) or (_val < 0 and -1) or 0 end
getDir = getNeg;

function getRotationDir(_game_ver)
    _game_ver = _game_ver or game_version;
    if _game_ver >= 2 then return (l_getRotationSpeed() > 0 and 1) or (l_getRotationSpeed() < 0 and -1) or 0
    else return (getLevelValueFloat("rotation_speed") > 0 and 1) or (getLevelValueFloat("rotation_speed") < 0 and -1) or 0
    end
end

--utils
function convValue(mFrameTime, _value, _valueTo, _strength) return _value - (0.1 * _strength * (_value - _valueTo)) * mFrameTime end
function closeValue(_input, _min_val, _max_val, _lim_type)
    if not _lim_type then _lim_type = "all"; end
        if _lim_type == "min" then return (_input < _min_val and _min_val) or _input;
    elseif _lim_type == "max" then return (_input > _max_val and _max_val) or _input;
    elseif _lim_type == "all" then return (_input < _min_val and _min_val) or (_input > _max_val and _max_val) or _input;
    else errorf(2, "Clamp", "just type to nil or 'all' w/ string value on closeValue funct located on <_lim_type>.")
    end
end

function getLevelTimeSine(_spd, _del, _timer_input)
    _timer_input = _timer_input or l_getLevelTime();
    return math.sin(_timer_input * _spd - _del);
end

function quantizeValue(_val, _div_primary, _div_secondary) return math.floor(_val * _div_primary) / (_div_secondary or _div_primary); end
function getRndReal(_maxVal) return u_rndReal() * _maxVal; end
function forceAbsValue(_value, _is_opposite)
    if (not _is_opposite) then return (_value < 0 and -_value) or _value
    else return (_value > 0 and -_value) or _value
    end
end

function isOddOrEven(_value, _odd_or_even)
    _odd_or_even = (_odd_or_even > 0 and 1) or 0;
    if math.floor(_value) % 2 == _odd_or_even then return true; end
    return false;
end

--maths
function math_add(_val, _amount)  return _val + _amount;       end
function math_sub(_val, _amount)  return _val - _amount;       end
function math_mul(_val, _amount)  return _val * _amount;       end
function math_div(_val, _amount)  return _val / _amount;       end
function math_mod(_val, _amount)  return _val % _amount;       end
function math_pow(_val, _amount)  return _val ^ _amount;       end
function math_root(_val, _amount) return _val ^ (1 / _amount); end

--increments
local marchiocommon_isManualIncrementing = 0;
local marchiocommon_currentManualIncrementTimer = 0;
local marchiocommon_currentManualIncrementTimes = 0;

function u_forceManualIncrement(_rot_inc, _spd_inc, _del_inc)
    _rot_inc = type(_rot_inc) == "number" and _rot_inc or 0;
    _spd_inc = type(_spd_inc) == "number" and _spd_inc or 0;
    _del_inc = type(_del_inc) == "number" and _del_inc or 0;
    l_setRotationSpeed(math_add(l_getRotationSpeed(), _rot_inc * getDir(l_getRotationSpeed())) * -1);
    l_setSpeedMult(math_add(l_getSpeedMult(), _spd_inc));
    l_setDelayMult(math_add(l_getDelayMult(), _del_inc));
    a_playSound("levelUp.ogg");
    marchiocommon_isManualIncrementing = 1;
    marchiocommon_currentManualIncrementTimes = marchiocommon_currentManualIncrementTimes + 1;
end

function u_forceManualIncrementV1Compatibility(_rot_inc, _spd_inc, _del_inc)
    _rot_inc = type(_rot_inc) == "number" and _rot_inc or 0;
    _spd_inc = type(_spd_inc) == "number" and _spd_inc or 0;
    _del_inc = type(_del_inc) == "number" and _del_inc or 0;
    setLevelValueFloat("rotation_speed", math_add(getLevelValueFloat("rotation_speed"), _rot_inc * getDir(getLevelValueFloat("rotation_speed"))) * -1);
    setLevelValueFloat("speed_multiplier", math_add(getLevelValueFloat("speed_multiplier"), _spd_inc));
    setLevelValueFloat("delay_multiplier", math_add(getLevelValueFloat("delay_multiplier"), _del_inc));
    playSound("levelUp.ogg");
    marchiocommon_isManualIncrementing = 1;
    marchiocommon_currentManualIncrementTimes = marchiocommon_currentManualIncrementTimes + 1;
end

function u_doManualIncrements(_inc_duration, _rot_inc, _spd_inc, _del_inc, _game_ver, _is_sync_to_dm, _timer_input)
    _inc_duration = _inc_duration or 15
    _game_ver = _game_ver or game_version
    if _is_sync_to_dm == nil then _is_sync_to_dm = false; end
    _timer_input = _timer_input or l_getLevelTime();

    local marchiocommon_DMvalue = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentManualIncrementTimer + _inc_duration) then
        marchiocommon_currentManualIncrementTimer = marchiocommon_currentManualIncrementTimer + _inc_duration;
        if _game_ver >= 2 then u_forceManualIncrement(_rot_inc, _spd_inc, _del_inc);
        else u_forceManualIncrementV1Compatibility(_rot_inc, _spd_inc, marchiocommon_currentDelMultInc);
        end
    end
end

function u_hasIncrementedManually()
    if marchiocommon_isManualIncrementing == 1 then marchiocommon_isManualIncrementing = 0; return true; end
    return false;
end
u_hasManualIncremented = u_hasIncrementedManually;

function u_getManualIncrementTimes() return marchiocommon_currentManualIncrementTimes; end
function u_setManualIncrementTimes(_amount) marchiocommon_currentManualIncrementTimes = _amount or 0; end

function u_getManualIncrementDurationOffset() return marchiocommon_currentManualIncrementTimer; end
function u_setManualIncrementDurationOffset(_offset_amount) marchiocommon_currentManualIncrementTimer = _offset_amount or 0; end

local marchiocommon_isIncrementing = 0;

function u_hasIncremented()
    if u_isFastSpinning() then
        if marchiocommon_isIncrementing == 0 then marchiocommon_isIncrementing = 1; return true;
        else return false;
        end
    else marchiocommon_isIncrementing = 0;
    end
end

--syncs
function convertBPMtoSeconds(_tempo, _division, _multiply) return (((_tempo / 60) ^ -1) / (_division or 1)) * (_multiply or 1); end
getBPM = convertBPMtoSeconds;
getSync = convertBPMtoSeconds; -- babadrake's common implementation

local marchiocommon_currentSyncedPulseTimer = 0;
local marchiocommon_currentSyncedPulseTimerOffsetFix = 0;
local marchiocommon_currentSyncedPulseTimes = 0;
local marchiocommon_currentBeatPulse = 0;
local marchiocommon_boolPulseActiveHeld = false;
local marchiocommon_boolPulseActiveOnce = false;

function l_setSyncedPulse(mFrameTime, _tempo_input, _is_advanced_tempo, _effect_type, _is_instant_pul_spd, _lvl_pul_min, _lvl_pul_max, _lvl_pul_spd, _lvl_pul_spd_r, _lvl_pul_dir, _lvl_beat_pul_max, _lvl_beat_pul_spd, _lvl_rot_spd, _lvl_rot_spd_mult, _lvl_rot_spd_dir, _rev_del, _is_sync_to_dm, _timer_input)
    if _is_advanced_tempo == nil then _is_advanced_tempo = false; end
    if _lvl_rot_spd_mult == nil then _lvl_rot_spd_mult = 1; end
    if _lvl_beat_pul_spd == nil then _lvl_beat_pul_spd = 1; end
    if _lvl_rot_spd_dir == nil or _lvl_rot_spd_dir == 0 or _lvl_rot_spd_dir > 1 or _lvl_rot_spd_dir < -1 then _lvl_rot_spd_dir = 1; end
    if _is_sync_to_dm == nil then _is_sync_to_dm = false; end
    _timer_input = _timer_input or l_getLevelTime();

    local marchiocommon_DMvalue = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;
    local marchiocommon_tempoState = (getBooleanNumber(_is_advanced_tempo) == true and convertBPMtoSeconds(_tempo_input)) or _tempo_input;
    local marchiocommon_instPulSpdState = (getBooleanNumber(_is_instant_pul_spd) == true and _lvl_pul_spd) or 0;
    local marchiocommon_instPulSpdRState = (getBooleanNumber(_is_instant_pul_spd) == true and _lvl_pul_spd_r) or 0;

    if (type(_lvl_pul_min) == "number") then l_setPulseMin(_lvl_pul_min) end
    if (type(_lvl_pul_max) == "number") then l_setPulseMax(_lvl_pul_max) end
    if type(_lvl_pul_spd) ~= "number" then errorf(2, "SyncPulse", "argument #8 is not a number. why did you input a non-number value?") end
    if type(_lvl_pul_spd_r) ~= "number" then errorf(2, "SyncPulse", "argument #9 is literally not a number. why did you input a non-number value?") end
    if type(_lvl_pul_dir) ~= "number" then errorf(2, "SyncPulse", "argument #10 is LITERALLY LITERALLY not a number. why did you input a non-number value?") end

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedPulseTimer) then
        marchiocommon_currentSyncedPulseTimer = (marchiocommon_currentSyncedPulseTimer + marchiocommon_tempoState);
        marchiocommon_currentSyncedPulseTimes = (marchiocommon_currentSyncedPulseTimes + 1);
        marchiocommon_currentBeatPulse = (type(_lvl_beat_pul_max) == "number" and _lvl_beat_pul_max) or 0;
        marchiocommon_boolPulseActiveHeld = true;
        marchiocommon_boolPulseActiveOnce = true;
    end

    if (_lvl_beat_pul_max ~= 0 and type(_lvl_beat_pul_max) == "number") then
        marchiocommon_currentBeatPulse = closeValue(marchiocommon_currentBeatPulse - (_lvl_beat_pul_spd * mFrameTime * 2), 0, 9999, "min");
        l_setBeatPulseMax(marchiocommon_currentBeatPulse);
        l_setBeatPulseDelayMax(0);
    end

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedPulseTimerOffsetFix) then
        l_setPulseDelayMax(0);
        if ((_timer_input * marchiocommon_DMvalue) < marchiocommon_currentSyncedPulseTimer - marchiocommon_tempoState + _rev_del) then
            if _effect_type == 0 or _effect_type >= 256 then
                if _lvl_pul_dir > 0 and _lvl_pul_spd > 0 then l_setPulseSpeed(_lvl_pul_spd); l_setPulseSpeedR(marchiocommon_instPulSpdRState);
                elseif _lvl_pul_dir < 0 and _lvl_pul_spd_r > 0 then l_setPulseSpeed(marchiocommon_instPulSpdState); l_setPulseSpeedR(_lvl_pul_spd_r);
                end
            end if _effect_type == 1 or _effect_type >= 256 then
                l_setRotationSpeed(_lvl_rot_spd * _lvl_rot_spd_mult * _lvl_rot_spd_dir)
            end
        end

        if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedPulseTimer - marchiocommon_tempoState + _rev_del) then
            marchiocommon_boolPulseActiveHeld = false;

            if _effect_type == 0 or _effect_type >= 256 then
                if _lvl_pul_dir > 0 and _lvl_pul_spd_r > 0 then l_setPulseSpeed(0); l_setPulseSpeedR(_lvl_pul_spd_r);
                elseif _lvl_pul_dir < 0 and _lvl_pul_spd > 0 then l_setPulseSpeed(_lvl_pul_spd); l_setPulseSpeedR(0);
                end
            end if _effect_type == 1 or _effect_type >= 256 then
                l_setRotationSpeed(_lvl_rot_spd * _lvl_rot_spd_dir)
            end
        end
    end
end

function l_setSyncedPulseInstant(mFrameTime, _tempo_input, _is_advanced_tempo, _effect_type, _lvl_pul_min, _lvl_pul_max, _lvl_pul_spd, _lvl_pul_spd_r, _lvl_pul_dir, _lvl_beat_pul_max, _lvl_beat_pul_spd, _lvl_rot_spd, _lvl_rot_spd_mult, _lvl_rot_spd_dir, _rev_del, _is_sync_to_dm, _timer_input)
    if _is_advanced_tempo == nil then _is_advanced_tempo = false; end
    if _lvl_rot_spd_mult == nil then _lvl_rot_spd_mult = 1; end
    if _lvl_beat_pul_spd == nil then _lvl_beat_pul_spd = 1; end
    if _lvl_rot_spd_dir == nil or _lvl_rot_spd_dir == 0 or _lvl_rot_spd_dir > 1 or _lvl_rot_spd_dir < -1 then _lvl_rot_spd_dir = 1; end
    if _is_sync_to_dm == nil then _is_sync_to_dm = false; end
    _timer_input = _timer_input or l_getLevelTime();

    local marchiocommon_DMvalue = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;
    local marchiocommon_tempoState = (getBooleanNumber(_is_advanced_tempo) == true and convertBPMtoSeconds(_tempo_input)) or _tempo_input

    if type(_lvl_pul_dir) ~= "number" then errorf(2, "SyncPulse", "argument #9 is LITERALLY LITERALLY not a number. why did you input a non-number value?") end

    if (type(_lvl_pul_min) == "number") then l_setPulseMin(_lvl_pul_min) end
    if (type(_lvl_pul_max) == "number") then l_setPulseMax(_lvl_pul_max) end

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedPulseTimer) then
        if (type(_lvl_pul_spd) == "number" and _lvl_pul_spd > 0) then l_setPulseSpeed(_lvl_pul_spd) end
        if (type(_lvl_pul_spd_r) == "number" and _lvl_pul_spd_r > 0) then l_setPulseSpeedR(_lvl_pul_spd_r) end

        marchiocommon_currentSyncedPulseTimer = (marchiocommon_currentSyncedPulseTimer + marchiocommon_tempoState);
        marchiocommon_currentSyncedPulseTimes = (marchiocommon_currentSyncedPulseTimes + 1);
        marchiocommon_currentBeatPulse = (type(_lvl_beat_pul_max) == "number" and _lvl_beat_pul_max) or 0;
        marchiocommon_boolPulseActiveHeld = true;
        marchiocommon_boolPulseActiveOnce = true;
    end

    if (_lvl_beat_pul_max ~= 0 and type(_lvl_beat_pul_max) == "number") then
        marchiocommon_currentBeatPulse = closeValue(marchiocommon_currentBeatPulse - (_lvl_beat_pul_spd * mFrameTime * 2), 0, 9999, "min");
        l_setBeatPulseMax(marchiocommon_currentBeatPulse);
        l_setBeatPulseDelayMax(0);
    end

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedPulseTimerOffsetFix) then
        l_setPulseDelayMax(0);
        if ((_timer_input * marchiocommon_DMvalue) < marchiocommon_currentSyncedPulseTimer - marchiocommon_tempoState + _rev_del) then
            if _effect_type == 0 or _effect_type >= 256 then l_setPulseDirection(_lvl_pul_dir) end
            if _effect_type == 1 or _effect_type >= 256 then  l_setRotationSpeed(_lvl_rot_spd * _lvl_rot_spd_mult * _lvl_rot_spd_dir) end
        end

        if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedPulseTimer - marchiocommon_tempoState + _rev_del) then
            marchiocommon_boolPulseActiveHeld = false;

            if _effect_type == 0 or _effect_type >= 256 then l_setPulseDirection(-_lvl_pul_dir) end
            if _effect_type == 1 or _effect_type >= 256 then l_setRotationSpeed(_lvl_rot_spd * _lvl_rot_spd_dir) end
        end
    end
end

function l_setSyncedPulseV1Compatibility(mFrameTime, _tempo_input, _is_advanced_tempo, _effect_type, _is_instant_pul_spd, _lvl_pul_min, _lvl_pul_max, _lvl_pul_spd, _lvl_pul_spd_r, _lvl_pul_dir, _lvl_beat_pul_max, _lvl_beat_pul_spd, _lvl_rot_spd, _lvl_rot_spd_mult, _lvl_rot_spd_dir, _rev_del, _is_sync_to_dm, _timer_input)
    if _is_advanced_tempo == nil then _is_advanced_tempo = false; end
    if _lvl_rot_spd_mult == nil then _lvl_rot_spd_mult = 1; end
    if _lvl_beat_pul_spd == nil then _lvl_beat_pul_spd = 1; end
    if _lvl_rot_spd_dir == nil or _lvl_rot_spd_dir == 0 or _lvl_rot_spd_dir > 1 or _lvl_rot_spd_dir < -1 then _lvl_rot_spd_dir = 1; end
    if _is_sync_to_dm == nil then _is_sync_to_dm = false; end
    _timer_input = _timer_input or l_getLevelTime();

    local marchiocommon_DMvalue = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;
    local marchiocommon_tempoState = (getBooleanNumber(_is_advanced_tempo) == true and convertBPMtoSeconds(_tempo_input)) or _tempo_input;
    local marchiocommon_instPulSpdState = (getBooleanNumber(_is_instant_pul_spd) == true and _lvl_pul_spd) or 0;
    local marchiocommon_instPulSpdRState = (getBooleanNumber(_is_instant_pul_spd) == true and _lvl_pul_spd_r) or 0;

    if (type(_lvl_pul_min) == "number") then setLevelValueFloat("pulse_min", _lvl_pul_min) end
    if (type(_lvl_pul_max) == "number") then setLevelValueFloat("pulse_max", _lvl_pul_max) end
    if type(_lvl_pul_spd) ~= "number" then errorf(2, "SyncPulse", "argument #8 is not a number. why did you input a non-number value?") end
    if type(_lvl_pul_spd_r) ~= "number" then errorf(2, "SyncPulse", "argument #9 is literally not a number. why did you input a non-number value?") end
    if type(_lvl_pul_dir) ~= "number" then errorf(2, "SyncPulse", "argument #10 is LITERALLY LITERALLY not a number. why did you input a non-number value?") end

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedPulseTimer) then
        marchiocommon_currentSyncedPulseTimer = (marchiocommon_currentSyncedPulseTimer + marchiocommon_tempoState);
        marchiocommon_currentSyncedPulseTimes = (marchiocommon_currentSyncedPulseTimes + 1);
        marchiocommon_currentBeatPulse = (type(_lvl_beat_pul_max) == "number" and _lvl_beat_pul_max) or 0;
        marchiocommon_boolPulseActiveHeld = true;
        marchiocommon_boolPulseActiveOnce = true;
    end

    if (_lvl_beat_pul_max ~= 0 and type(_lvl_beat_pul_max) == "number") then
        marchiocommon_currentBeatPulse = closeValue(marchiocommon_currentBeatPulse - (_lvl_beat_pul_spd * mFrameTime * 2), 0, 9999, "min");
        setLevelValueFloat("beatpulse_max", marchiocommon_currentBeatPulse);
        setLevelValueFloat("beatpulse_delay_max", 0);
    end

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedPulseTimerOffsetFix) then
        setLevelValueFloat("pulse_delay_max", 0);
        if ((_timer_input * marchiocommon_DMvalue) < marchiocommon_currentSyncedPulseTimer - marchiocommon_tempoState + _rev_del) then
            if _effect_type == 0 or _effect_type >= 256 then
                if _lvl_pul_dir > 0 and _lvl_pul_spd > 0 then setLevelValueFloat("pulse_speed", _lvl_pul_spd); setLevelValueFloat("pulse_speed_r", marchiocommon_instPulSpdState);
                elseif _lvl_pul_dir < 0 and _lvl_pul_spd_r > 0 then setLevelValueFloat("pulse_speed", marchiocommon_instPulSpdRState); setLevelValueFloat("pulse_speed_r", _lvl_pul_spd_r);
                end
            end if _effect_type == 1 or _effect_type >= 256 then
                setLevelValueFloat("rotation_speed", _lvl_rot_spd * _lvl_rot_spd_mult * _lvl_rot_spd_dir)
            end
        end

        if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedPulseTimer - marchiocommon_tempoState + _rev_del) then
            marchiocommon_boolPulseActiveHeld = false;

            if _effect_type == 0 or _effect_type >= 256 then
                if _lvl_pul_dir > 0 and _lvl_pul_spd_r > 0 then setLevelValueFloat("pulse_speed", 0); setLevelValueFloat("pulse_speed_r", _lvl_pul_spd_r);
                elseif _lvl_pul_dir < 0 and _lvl_pul_spd > 0 then setLevelValueFloat("pulse_speed", _lvl_pul_spd); setLevelValueFloat("pulse_speed_r", 0);
                end
            end if _effect_type == 1 or _effect_type >= 256 then
                setLevelValueFloat("rotation_speed", _lvl_rot_spd * _lvl_rot_spd_dir)
            end
        end
    end
end

function l_isPulseActiveHeld() return marchiocommon_boolPulseActiveHeld; end
function l_isPulseActiveOnce()
    if (marchiocommon_boolPulseActiveOnce) then marchiocommon_boolPulseActiveOnce = false; return true; end
    return false;
end

function l_getSyncedPulseTimes() return marchiocommon_currentSyncedPulseTimes; end
function l_setSyncedPulseTimes(_amount) marchiocommon_currentSyncedPulseTimes = _amount or 0; end

function l_getSyncedPulseTimerOffset() return marchiocommon_currentSyncedPulseTimer; end
function l_setSyncedPulseTimerOffset(_offset_amount)
    marchiocommon_currentSyncedPulseTimerOffsetFix = _offset_amount or 0;
    marchiocommon_currentSyncedPulseTimer = _offset_amount or 0;
end

--alternative name: loop event logic (march31o's inspiration/modification commons)
local marchiocommon_currentPulseDetectorTimer = 0;
local marchiocommon_currentPulseDetectorTimes = 0;
local marchiocommon_boolPulseDetectedHeld = false;
local marchiocommon_boolPulseDetectedOnce = false;

function l_setPulseDetector(_dur_input, _is_using_bpm, _rev_del, _is_sync_to_dm, _timer_input)
    if not _is_using_bpm then _is_using_bpm = false; end
    if not _is_sync_to_dm then _is_sync_to_dm = false; end
    _timer_input = _timer_input or l_getLevelTime();

    local marchiocommon_DMvalue = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;
    local marchiocommon_tempoState = (getBooleanNumber(_is_using_bpm) == true and convertBPMtoSeconds(_dur_input)) or _dur_input;

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentPulseDetectorTimer) then
        marchiocommon_currentPulseDetectorTimer = (marchiocommon_currentPulseDetectorTimer + marchiocommon_tempoState);
        marchiocommon_currentPulseDetectorTimes = (marchiocommon_currentPulseDetectorTimes + 1);
        marchiocommon_boolPulseDetectedHeld = true;
        marchiocommon_boolPulseDetectedOnce = true;
        return true;
    end
    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentPulseDetectorTimer - marchiocommon_tempoState + _rev_del) then
        marchiocommon_boolPulseDetectedHeld = false;
        return false;
    end
end

function l_isPulseDetectedHeld() return marchiocommon_boolPulseDetectedHeld; end
function l_isPulseDetectedOnce()
    if (marchiocommon_boolPulseDetectedOnce) then marchiocommon_boolPulseDetectedOnce = false; return true; end
    return false;
end

function l_getPulseDetectorTimes() return marchiocommon_currentPulseDetectorTimes; end
function l_setPulseDetectorTimes(_amount) marchiocommon_currentPulseDetectorTimes = _amount or 0; end

function l_getPulseDetectorTimerOffset() return marchiocommon_currentPulseDetectorTimer; end
function l_setPulseDetectorTimerOffset(_offset_amount) marchiocommon_currentPulseDetectorTimer = _offset_amount or 0; end

--mechanics
local marchiocommon_currentInvincibilityTimer = 1;
local marchiocommon_currentInvincibilityDuration = 0;
local marchiocommon_boolIsInvincibilityDeployed = false;

function mch_getEmergencyInvinciblity(_wait_amount, _duration_amount, _timer_input)
    _timer_input = _timer_input or l_getLevelTime();

    if _wait_amount == nil then _wait_amount = 25; end
    if _duration_amount == nil then _duration_amount = 1; end

    if _timer_input > marchiocommon_currentInvincibilityTimer then
        marchiocommon_currentInvincibilityTimer = (_timer_input + _wait_amount);
        marchiocommon_currentInvincibilityDuration = (_timer_input + _duration_amount);
        l_setSwapEnabled(false);
    end
end

function mch_doEmergencyInvinciblityReset(_timer_input)
    _timer_input = _timer_input or l_getLevelTime();

    if _timer_input > marchiocommon_currentInvincibilityDuration then marchiocommon_boolIsInvincibilityDeployed = false;
    else marchiocommon_boolIsInvincibilityDeployed = true;
    end
    l_setTutorialMode(marchiocommon_boolIsInvincibilityDeployed);

    if _timer_input > marchiocommon_currentInvincibilityTimer then l_setSwapEnabled(true); end
end

function mch_isEmergencyInvinciblityDeployed() return marchiocommon_boolIsInvincibilityDeployed; end

function mch_getEmergencyInvincibilityTimerOffset() return marchiocommon_currentInvincibilityTimer; end
function mch_setEmergencyInvincibilityTimerOffset(_offset_amount) marchiocommon_currentInvincibilityTimer = _offset_amount; end

--override pattern delays
local marchiocommon_currentOverridePatternDelay = 1;

function p_getOverridePatternDelay() return marchiocommon_currentOverridePatternDelay; end
function p_setOverridePatternDelay(_override_amount) marchiocommon_currentOverridePatternDelay = _override_amount; end

-- my implementation of implemented overrideDelay on babadrake's common
overrideDelay = p_setOverridePatternDelay;

--delays & thickness
function customizePatternDelay(_delay_amount, _is_spd_mult)
    if _is_spd_mult == nil then _is_spd_mult = true; end
    return (getPerfectDelay(THICKNESS) * (_delay_amount * marchiocommon_currentOverridePatternDelay * pstr_currentDelayMultOfSpeedLessThan) * (getBooleanNumber(_is_spd_mult) and (u_getSpeedMultDM()) / 2 or 1));
end

function customizePatternThickness(_thickness_amount, _is_spd_mult)
    if _is_spd_mult == nil then _is_spd_mult = true; end
    return ((THICKNESS * u_getDelayMultDM()) * (_thickness_amount * marchiocommon_currentOverridePatternDelay * pstr_currentDelayMultOfSpeedLessThan) * (getBooleanNumber(_is_spd_mult) and (u_getSpeedMultDM()) / 2 or 1));
end

-- my implementation of implemented custWait & custThickness on babadrake's common
custWait = customizePatternDelay;
custThickness = customizePatternThickness;

function customizeTempoPatternDelay(_delay_amount)
    return (convertBPMtoSeconds(GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) * _delay_amount * 1) * 60;
end

function customizeTempoPatternThickness(_thickness_amount)
    return (convertBPMtoSeconds(GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) * _thickness_amount * 3.781 * 80 * u_getSpeedMultDM()) + 1;
end

--patterns
function p_updateGlobalSyncedPatterns()
    t_eval([[l_setWallSpawnDistance(]] .. 70 + 1100 * u_getSpeedMultDM() * 1.075 * convertBPMtoSeconds(GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) * GLOBAL_SPAWN_DISTANCE_MULT * GLOBAL_TIME_SIGNATURE + GLOBAL_SPAWN_DISTANCE_ADD .. [[)]])
end

local marchiocommon_oldSyncedPatternRepairSeconds = 0;

function p_setGlobalSyncedPatternSettings(_tempo, _spawn_dist_mult, _spawn_dist_add, _1st_time_signature, _2nd_time_signature, _is_sync_to_dm)
    GLOBAL_TEMPO = _tempo or 128;
    GLOBAL_SPAWN_DISTANCE_MULT = _spawn_dist_mult or 1;
    GLOBAL_SPAWN_DISTANCE_ADD = _spawn_dist_add or 0;
    GLOBAL_TIME_SIGNATURE = (type(_1st_time_signature) == "number" and _1st_time_signature or 4) / (type(_2nd_time_signature) == "number" and _2nd_time_signature or 4);
    GLOBAL_TEMPO_DM_STATE = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;
    marchiocommon_oldSyncedPatternRepairSeconds = (70 + 1100 * u_getSpeedMultDM() * 1.075 * convertBPMtoSeconds(GLOBAL_TEMPO) * GLOBAL_SPAWN_DISTANCE_MULT * GLOBAL_TIME_SIGNATURE + GLOBAL_SPAWN_DISTANCE_ADD) / (70 + 1100);
end

local marchiocommon_currentSyncedPatternRepairDuration = 0;
local marchiocommon_currentSyncedPatternRepairTimes = 0;

--[[ note for OH v2.0.4- users: if the l_setWallSpawnDistance() was currently unavailable (including [t_eval] of OH v2.0.3),
 make sure you have to obtain p_setSyncedPatternRepairUpdaterTimerOffset(_offset_amount) on
 onInit/onLoad's hardcored function in order to make the walls hits into hexagon perfectly ]]
function p_updateSyncedPatternRepair(_beat_duration_amount, _beat_delay_amount, _is_spd_inc_fix, _func_primary, _func_secondary, _timer_input)
    _timer_input = _timer_input or l_getLevelTime();
    _func_primary = _func_primary or t_clear;
    local marchiocommon_currentSyncedPatternRepairSeconds = (70 + 1100 * u_getSpeedMultDM() * 1.075 * convertBPMtoSeconds(GLOBAL_TEMPO) * GLOBAL_TIME_SIGNATURE) / (70 + 1100);
    local _spd_inc_fix_state = marchiocommon_currentSyncedPatternRepairSeconds - marchiocommon_oldSyncedPatternRepairSeconds
    local _spd_inc_timer_diff_greater_fix_state = (u_getDifficultyMult() >= 1 and (u_getDifficultyMult() ^ -0.25) * 0.65) or 0.65;
    local _spd_inc_timer_diff_less_fix_state = (u_getDifficultyMult() < 1 and (1 - u_getDifficultyMult())) or 0;
    if getBooleanNumber(_is_spd_inc_fix) then
        if ((_timer_input * GLOBAL_TEMPO_DM_STATE) - ((u_getDifficultyMult() ^ _spd_inc_timer_diff_greater_fix_state) - 1) + _spd_inc_timer_diff_less_fix_state) > marchiocommon_currentSyncedPatternRepairDuration + (_beat_duration_amount * convertBPMtoSeconds(GLOBAL_TEMPO)) + (_beat_delay_amount * convertBPMtoSeconds(GLOBAL_TEMPO)) + _spd_inc_fix_state then
            marchiocommon_currentSyncedPatternRepairDuration = marchiocommon_currentSyncedPatternRepairDuration + (_beat_duration_amount * convertBPMtoSeconds(GLOBAL_TEMPO));
            marchiocommon_currentSyncedPatternRepairTimes = math_add(marchiocommon_currentSyncedPatternRepairTimes, 1);
            _func_primary();
            if (_func_secondary) then _func_secondary(); end
        end
    else
        if (_timer_input * GLOBAL_TEMPO_DM_STATE) > marchiocommon_currentSyncedPatternRepairDuration + (_beat_duration_amount * convertBPMtoSeconds(GLOBAL_TEMPO)) + (_beat_delay_amount * convertBPMtoSeconds(GLOBAL_TEMPO)) then
            marchiocommon_currentSyncedPatternRepairDuration = marchiocommon_currentSyncedPatternRepairDuration + (_beat_duration_amount * convertBPMtoSeconds(GLOBAL_TEMPO));
            marchiocommon_currentSyncedPatternRepairTimes = math_add(marchiocommon_currentSyncedPatternRepairTimes, 1);
            _func_primary();
            if (_func_secondary) then _func_secondary(); end
        end
    end
end

function p_getSyncedPatternRepairUpdaterTimes() return marchiocommon_currentSyncedPatternRepairTimes; end
function p_setSyncedPatternRepairUpdaterTimes(_amount) marchiocommon_currentSyncedPatternRepairTimes = _amount or 0; end

function p_getSyncedPatternRepairUpdaterTimerOffset() return marchiocommon_currentSyncedPatternRepairDuration; end
function p_setSyncedPatternRepairUpdaterTimerOffset(_offset_amount) marchiocommon_currentSyncedPatternRepairDuration = _offset_amount; end

--[ Begin Marchionne's inspiration/modification commons ]--

--utils

-- common's <<getRandomNeg + value input>> function method
function getRandomNegVal(_input)
    if type(_input) ~= "number" then errorf(2, "Input", "argument #1 is not a number. why did you input a non-number value?") end
    return u_rndInt(0, 100) > 50 and _input or -_input
end
getRandomDirVal = getRandomNegVal;

-- babadrake's <<closeValue * -1>> function method
function loopValue(_input, _min_val, _max_val)
    local _remaining = 0
    if _input < _min_val then
        _remaining = _min_val - _input - 1
        return _max_val - _remaining;
    elseif _input > _max_val then
        _remaining = _input - _max_val - 1
        return _min_val + _remaining;
    end
    return _input;
end

--syncs
-- babadrake's <<convertBPMtoSeconds * -1>> function method - convert seconds to tempo
function convertSecondsToBPM(_input) return (_input ^ -1) * 60; end
revertBPM = convertSecondsToBPM;
revertSync = convertSecondsToBPM;

local marchiocommon_currentRotSpdMultOfFastSpin = 1;

function u_updateRotSpdOfFastSpinning(mFrameTime, _conv_mult) marchiocommon_currentRotSpdMultOfFastSpin = closeValue(marchiocommon_currentRotSpdMultOfFastSpin - ((_conv_mult or 1) * mFrameTime), 1, 9999, "min"); end

function u_getRotSpdOfFastSpinning() return marchiocommon_currentRotSpdMultOfFastSpin; end
function u_setRotSpdOfFastSpinning(_amount) marchiocommon_currentRotSpdMultOfFastSpin = _amount or 0; end

--syncs
local marchiocommon_currentSyncedBeatPulseTimer = 0;
local marchiocommon_currentSyncedBeatPulseTimes = 0;
local marchiocommon_currentSyncedBeatPulseAmount = 0;
local marchiocommon_boolBeatPulseActive = false;

function l_setSyncedBeatPulse(mFrameTime, _game_ver, _tempo_input, _is_advanced_tempo, _lvl_beat_pul_max, _lvl_beat_pul_spd, _is_sync_to_dm, _timer_input)
    _game_ver = _game_ver or game_version
    if not _is_using_bpm then _is_using_bpm = false; end
    if not _is_sync_to_dm then _is_sync_to_dm = false; end
    _timer_input = _timer_input or l_getLevelTime();

    local marchiocommon_DMvalue = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;
    local marchiocommon_tempoState = (getBooleanNumber(_is_advanced_tempo) == true and convertBPMtoSeconds(_tempo_input)) or _tempo_input;

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedBeatPulseTimer) then
        marchiocommon_currentSyncedBeatPulseTimer = (marchiocommon_currentSyncedBeatPulseTimer + marchiocommon_tempoState);
        marchiocommon_currentSyncedBeatPulseTimes = (marchiocommon_currentSyncedBeatPulseTimes + 1);
        marchiocommon_boolBeatPulseActive = true;
        marchiocommon_currentSyncedBeatPulseAmount = (type(_lvl_beat_pul_max) == "number" and _lvl_beat_pul_max) or 0;
    end

    marchiocommon_currentSyncedBeatPulseAmount = closeValue(marchiocommon_currentSyncedBeatPulseAmount - (_lvl_beat_pul_spd * mFrameTime * 2), 0, 9999, "min");
    if _game_ver >= 2 then
        l_setBeatPulseMax(marchiocommon_currentSyncedBeatPulseAmount);
        l_setBeatPulseDelayMax(0);
    else
        setLevelValueFloat("beatpulse_max", marchiocommon_currentSyncedBeatPulseAmount);
        setLevelValueFloat("beatpulse_delay_max", 0);
    end
end

function l_isBeatPulseActive()
    if (marchiocommon_boolBeatPulseActive) then marchiocommon_boolBeatPulseActive = false; return true; end
    return false;
end

function l_getSyncedBeatPulseTimes() return marchiocommon_currentSyncedBeatPulseTimes; end
function l_setSyncedBeatPulseTimes(_amount) marchiocommon_currentSyncedBeatPulseTimes = _amount or 0; end

function l_getSyncedBeatPulseTimerOffset() return marchiocommon_currentSyncedBeatPulseTimer; end
function l_setSyncedBeatPulseTimerOffset(_offset_amount) marchiocommon_currentSyncedBeatPulseTimer = _offset_amount or 0; end

local marchiocommon_currentSyncedAdvPulseTimer = 0;
local marchiocommon_currentSyncedAdvPulseTimes = 0;
local marchiocommon_currentAdvPulse = 0;
local marchiocommon_currentAdvPulseSpd = 0;
local marchiocommon_currentAdvBeatPulse = 0;
local marchiocommon_boolAdvPulseActiveHeld = false;
local marchiocommon_boolAdvPulseActiveOnce = false;

function l_setSyncedAdvancedPulse(mFrameTime, _game_ver, _tempo_input, _is_advanced_tempo, _pul_override_amount, _lvl_pul_min, _lvl_pul_max, _lvl_pul_spd, _lvl_pul_spd_r, _lvl_pul_dir, _pul_rev_del, _lvl_beat_pul_max, _lvl_beat_pul_spd, _lvl_rad_min, _is_sync_to_dm, _timer_input)
    _game_ver = _game_ver or game_version
    if _is_advanced_tempo == nil then _is_advanced_tempo = false; end
    if _is_sync_to_dm == nil then _is_sync_to_dm = false; end
    _timer_input = _timer_input or l_getLevelTime();

    local marchiocommon_DMvalue = (getBooleanNumber(_is_sync_to_dm) == true and u_getDifficultyMult() ^ 0.12) or 1;
    local marchiocommon_tempoState = (getBooleanNumber(_is_advanced_tempo) == true and convertBPMtoSeconds(_tempo_input)) or _tempo_input;

    if type(_lvl_pul_spd) ~= "number" then errorf(2, "SyncPulse", "argument #8 is not a number. why did you input a non-number value?") end
    if type(_lvl_pul_spd_r) ~= "number" then errorf(2, "SyncPulse", "argument #9 is literally not a number. why did you input a non-number value?") end
    if type(_lvl_pul_dir) ~= "number" then errorf(2, "SyncPulse", "argument #10 is LITERALLY LITERALLY not a number. why did you input a non-number value?") end

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedAdvPulseTimer) then
        marchiocommon_boolAdvPulseActiveHeld = true;
        marchiocommon_boolAdvPulseActiveOnce = true;
        marchiocommon_currentSyncedAdvPulseTimer = (marchiocommon_currentSyncedAdvPulseTimer + marchiocommon_tempoState);
        marchiocommon_currentSyncedAdvPulseTimes = (marchiocommon_currentSyncedAdvPulseTimes + 1);
        marchiocommon_currentAdvBeatPulse = (type(_lvl_beat_pul_max) == "number" and _lvl_beat_pul_max) or 0;

        marchiocommon_currentAdvPulseSpd = (_lvl_pul_dir > 0 and _lvl_pul_spd) or -_lvl_pul_spd_r;
    end

    if ((_timer_input * marchiocommon_DMvalue) > marchiocommon_currentSyncedAdvPulseTimer - marchiocommon_tempoState + _pul_rev_del) then
        marchiocommon_boolAdvPulseActiveHeld = false;

        marchiocommon_currentAdvPulseSpd = (_lvl_pul_dir > 0 and -_lvl_pul_spd_r) or _lvl_pul_spd;
    end

    marchiocommon_currentAdvPulse = closeValue(marchiocommon_currentAdvPulse + (marchiocommon_currentAdvPulseSpd * mFrameTime), _lvl_pul_min, _lvl_pul_max, "all");

    if (_lvl_beat_pul_max ~= 0 and type(_lvl_beat_pul_max) == "number") then
        marchiocommon_currentAdvBeatPulse = closeValue(marchiocommon_currentAdvBeatPulse - (_lvl_beat_pul_spd * mFrameTime * 2), 0, 9999, "min");
    end

    if _game_ver >= 2 then
        l_setPulseMin((_lvl_rad_min or 70) + (_pul_override_amount or 0) + (marchiocommon_currentAdvPulse * (((math.pi * 0.5) - math.pi) ^ -1) * ((_lvl_rad_min or 70) / 70)));
        l_setRadiusMin(_lvl_rad_min or 70);
        if (_lvl_beat_pul_max ~= 0 and type(_lvl_beat_pul_max) == "number") then l_setBeatPulseMax(marchiocommon_currentAdvBeatPulse); end
    else
        setLevelValueFloat("pulse_min", (_lvl_rad_min or 70) + (_pul_override_amount or 0) + (marchiocommon_currentAdvPulse * (((math.pi * 0.5) - math.pi) ^ -1) * ((_lvl_rad_min or 70) / 70)));
        setLevelValueFloat("radius_min", _lvl_rad_min or 70);
        if (_lvl_beat_pul_max ~= 0 and type(_lvl_beat_pul_max) == "number") then setLevelValueFloat("beatpulse_max", marchiocommon_currentAdvBeatPulse); end
    end
end

function l_isAdvancedPulseActiveHeld() return marchiocommon_boolAdvPulseActiveHeld; end
function l_isAdvancedPulseActiveOnce()
    if (marchiocommon_boolAdvPulseActiveOnce) then marchiocommon_boolAdvPulseActiveOnce = false; return true; end
    return false;
end

function l_getSyncedAdvancedPulseTimes() return marchiocommon_currentSyncedAdvPulseTimer; end
function l_setSyncedAdvancedPulseTimes(_amount) marchiocommon_currentSyncedAdvPulseTimer = _amount or 0; end

function l_getSyncedAdvancedPulseTimerOffset() return marchiocommon_currentSyncedAdvPulseTimer; end
function l_setSyncedAdvancedPulseTimerOffset(_offset_amount) marchiocommon_currentSyncedAdvPulseTimer = _offset_amount or 0; end

--mechanics
local marchiocommon_currentWallRemovalTimer = 1;
local marchiocommon_currentWallRemovalDuration = 0;
local marchiocommon_boolIsWallRemovalDeployed = false;

function mch_getEmergencyWallRemoval(_wait_amount, _duration_amount, _timer_input)
    _timer_input = _timer_input or l_getLevelTime();

    if _wait_amount == nil then _wait_amount = 25; end
    if _duration_amount == nil then _duration_amount = 1; end

    if _timer_input > marchiocommon_currentWallRemovalTimer then
        marchiocommon_boolIsWallRemovalDeployed = true;
        marchiocommon_currentWallRemovalTimer = (_timer_input + _wait_amount);
        marchiocommon_currentWallRemovalDuration = (_timer_input + _duration_amount);
        u_setFlashEffect(255);
        u_clearWalls();
        l_setSwapEnabled(false);
    end
end

function mch_doEmergencyWallRemovalReset(_timer_input)
    _timer_input = _timer_input or l_getLevelTime();

    if _timer_input > marchiocommon_currentWallRemovalDuration then marchiocommon_boolIsWallRemovalDeployed = false;
    else marchiocommon_boolIsWallRemovalDeployed = true;
    end

    if _timer_input > marchiocommon_currentWallRemovalTimer then l_setSwapEnabled(true); end
end

function mch_isEmergencyWallRemovalDeployed() return marchiocommon_boolIsWallRemovalDeployed; end

function mch_getEmergencyWallRemovalTimerOffset() return marchiocommon_currentWallRemovalTimer; end
function mch_setEmergencyWallRemovalTimerOffset(_offset_amount) marchiocommon_currentWallRemovalTimer = _offset_amount; end