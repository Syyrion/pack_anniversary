u_execScript("level/memoriesReappear/utils/march31o_utils.lua")

--[[
    usigned input TimerFrameTime:new(_timescale)
    var void TimerFrameTime:setTimescale(_timescale)
    var number TimerFrameTime:getTimescale()
    var void TimerFrameTime:setTimerValue(_amount)
    var number TimerFrameTime:getTimerValue()
    var void TimerFrameTime:step(mFrameTime, _fps, ...)

    usigned input PulseDetector:new(_dur_start, _launch_time, _dur_input, _is_using_bpm, _rev_del, _function_ETL, _function_OETL, _loop_amount_start, _is_sync_to_dm, _timescale)
    var void PulseDetector:setDurationInput(_dur_input)
    var number PulseDetector:getDurationInput()
    var void PulseDetector:setIfUsingBPM(_is_using_bpm)
    var bool PulseDetector:getIfUsingBPM()
    var void PulseDetector:setRevDelay(_rev_del)
    var number PulseDetector:getRevDelay()
    var void PulseDetector:setFunctionETL(_function_ETL)
    var number PulseDetector:getFunctionETL()
    var void PulseDetector:getFunctionOETL(_function_OETL)
    var number PulseDetector:setFunctionOETL()
    var void PulseDetector:setDurationOffset(_dur_offset)
    var number PulseDetector:getDurationOffset()
    var void PulseDetector:setLoopAmount(_loop_amount)
    var number PulseDetector:getLoopAmount()
    var void PulseDetector:setTimescale(_timescale)
    var number PulseDetector:getTimescale()
    var bool PulseDetector:isDetectedHeld()
    var bool PulseDetector:isDetectedOnce()
    var void PulseDetector:step(_timer_input, ...)

    usigned input EventTimer:new(_dur_start, _section, _launch_time, _is_sync_to_dm, _timescale)
    var void EventTimer:setEventDurationOffset(_dur_offset)
    var number EventTimer:getEventDurationOffset()
    var void EventTimer:setEventSection(_section)
    var number EventTimer:getEventSection()
    var void EventTimer:setTimescale(_timescale)
    var number EventTimer:getTimescale()
    var number EventTimer:getEventTimeDuration()
    var void EventTimer:resetEvents(_is_full_reset, _timer_input)
    var void EventTimer:step(_timer_input, ...)
    var int bool EventTimer:target(_duration_target, _section_target, _is_halt_advance)
    var int bool EventTimer:detectDebounceIfHalterStarts()
    var int bool EventTimer:advanceIfHalted(_duration_target)
]]

--i didn't remember how to learn metatable classes in lua ._.
--[[ REMEMBER: use var varname = PulseDetector:new() on onInit/onLoad before using it
and then put varname:step() on onUpdate ]]

--timers

--homemade timer class
TimerFrameTime = {}
TimerFrameTime.__index = TimerFrameTime

-- <_timescale> timescale
function TimerFrameTime:new(_timescale)
    local newInst = {}
    setmetatable(newInst, self)

    newInst.timerAmount = 0
    newInst:setTimescale(_timescale)

    return newInst
end

function TimerFrameTime:setTimescale(_timescale) self.timescale = type(_timescale) == 'number' and math.max(_timescale, 0) or 1 end
function TimerFrameTime:getTimescale() return self.timescale end

-- set/resets the timer value
function TimerFrameTime:setTimerValue(_amount) self.timerAmount = type(_amount) == 'number' and _amount or 0 end
function TimerFrameTime:getTimerValue() return self.timerAmount end

-- extra parameters can be passed to the step function
function TimerFrameTime:step(mFrameTime, _fps, ...)
    self.timerAmount = self.timerAmount + mFrameTime / (_fps or 60) * self.timescale
end

-- pulse detector
PulseDetector = {}
PulseDetector.__index = PulseDetector

-- <_dur_start> duration starts at
-- <_dur_input> timer input
-- <_is_using_bpm> bool of using bpm
-- <_rev_del> reversion delay
-- <_function_ETL> exceeded timer limit function
-- <_function_OETL> opposite of exceeded timer limit function
-- <_loop_amount_start> loop amount starts at
-- <_is_sync_to_dm> boolean of sync to music difficulty mult
-- <_timescale> timescale
function PulseDetector:new(_dur_start, _launch_time, _dur_input, _is_using_bpm, _rev_del, _function_ETL, _function_OETL, _loop_amount_start, _is_sync_to_dm, _timescale)
    local newInst = {}
    setmetatable(newInst, self)

    newInst:setDurationOffset(_dur_start)
    newInst.currentTime = 0;
    newInst.launchTime = _launch_time or 0;
    newInst:setDurationInput(_dur_input)
    newInst:setIfUsingBPM(_is_using_bpm)
    newInst:setRevDelay(_rev_del)
    newInst:setFunctionETL(_function_ETL)
    newInst:setFunctionOETL(_function_OETL)
    newInst:setLoopAmount(_loop_amount_start)
    newInst.syncToDM = getBooleanNumber(_is_sync_to_dm) or false;
    newInst:setTimescale(_timescale)
    newInst.isPulseDetectedHeld = false;
    newInst.isPulseDetectedOnce = false;

    return newInst
end

function PulseDetector:setDurationInput(_dur_input) self.durationInput = _dur_input or 15 end
function PulseDetector:getDurationInput() return self.durationInput end

function PulseDetector:setIfUsingBPM(_is_using_bpm) self.boolOfUsingBPM = getBooleanNumber(_is_using_bpm) or false end
function PulseDetector:getIfUsingBPM() return self.boolOfUsingBPM end

function PulseDetector:setRevDelay(_rev_del) self.revDelay = _rev_del or 0.1 end
function PulseDetector:getRevDelay() return self.revDelay end

function PulseDetector:setFunctionETL(_function_ETL) self.functionETL = (type(_function_ETL) == 'function' and _function_ETL) or function() end end
function PulseDetector:getFunctionETL() return self.functionETL end

function PulseDetector:setFunctionOETL(_function_OETL) self.functionOETL = (type(_function_OETL) == 'function' and _function_OETL) or function() end end
function PulseDetector:getFunctionOETL() return self.functionOETL end

function PulseDetector:setDurationOffset(_dur_offset) self.durationOffset = _dur_offset or 0 end
function PulseDetector:getDurationOffset() return self.durationOffset end

function PulseDetector:setLoopAmount(_loop_amount) self.loopTimesAmount = _loop_amount or 0 end
function PulseDetector:getLoopAmount() return self.loopTimesAmount end

function PulseDetector:setTimescale(_timescale) self.timescale = _timescale and math.max(_timescale, 0) or 1 end
function PulseDetector:getTimescale() return self.timescale end

-- get bool of pulse has detected
function PulseDetector:isDetectedHeld() return self.isPulseDetectedHeld end
function PulseDetector:isDetectedOnce()
    if (self.isPulseDetectedOnce) then self.isPulseDetectedOnce = false; return true; end
    return false;
end

-- extra parameters can be passed to the step function
-- step function will return anything that the assigned function returns
function PulseDetector:step(_timer_input, ...)
    _timer_input = _timer_input or l_getLevelTime();
    local _syncToDMState = (self.syncToDM == true and u_getDifficultyMult() ^ 0.12) or 1;
    local _usingBPMState = (self.boolOfUsingBPM == true and convertBPMtoSeconds(self.durationInput)) or self.durationInput;

    self.currentTime = ((_timer_input - self.launchTime) * _syncToDMState * self.timescale)
    if ((self.currentTime) > self.durationOffset) then
        self.durationOffset = (self.durationOffset + _usingBPMState);
        self.loopTimesAmount = (self.loopTimesAmount + 1);
        self.isPulseDetectedHeld = true;
        self.isPulseDetectedOnce = true;
        return self.functionETL(...);
    end
    if ((self.currentTime) > self.durationOffset - _usingBPMState + self.revDelay) then
        self.isPulseDetectedHeld = false;
        return self.functionOETL(...);
    end
end

-- reset pulse detector timer
function PulseDetector:resetTimer(_is_full_reset, _timer_input)
    if getBooleanNumber(_is_full_reset) then self.loopTimesAmount = 0;  end
    self.durationOffset = 0; self.launchEventTime = _timer_input or l_getLevelTime();
end

--events

--event timer
EventTimer = {}
EventTimer.__index = EventTimer

-- <_dur_start> duration starts at
-- <_section> section starts at
-- <_launch_time> set the <<LaunchTime = os.clock()>> variable when if the 'l_getLevelTime()' function currently unavailable
-- <_is_sync_to_dm> boolean of sync to music difficulty mult
-- <_timescale> timescale
function EventTimer:new(_dur_start, _section, _launch_time, _is_sync_to_dm, _timescale)
    local newInst = {}
    setmetatable(newInst, self)

    newInst:setEventDurationOffset(_dur_start)
    newInst:setEventSection(_section)
    newInst.currentEventTime = 0;
    newInst.launchEventTime = _launch_time or 0;
    newInst.isDebounce = false;
    newInst.isDebounceInAdvanceEventHalter = true;
    newInst.haltAdvance = false;
    newInst.syncToDM = getBooleanNumber(_is_sync_to_dm);
    newInst:setTimescale(_timescale)

    return newInst
end

function EventTimer:setEventDurationOffset(_dur_offset) self.eventDurationOffset = _dur_offset or 0; end
function EventTimer:getEventDurationOffset() return self.eventDurationOffset end

function EventTimer:setEventSection(_section) self.eventSection = _section or 0; end
function EventTimer:getEventSection() return self.eventSection end

function EventTimer:setTimescale(_timescale) self.timescale = _timescale and math.max(_timescale, 0) or 1 end
function EventTimer:getTimescale() return self.timescale end

-- gets the current event time duration
function EventTimer:getEventTimeDuration() return self.currentEventTime end

-- reset the current event
function EventTimer:resetEvents(_is_full_reset, _timer_input)
    if getBooleanNumber(_is_full_reset) then self.eventDurationOffset = 0; end
    self.eventSection = 0; self.launchEventTime = _timer_input or l_getLevelTime();
end

-- extra parameters can be passed to the step function
function EventTimer:step(_timer_input, ...)
    _timer_input = _timer_input or l_getLevelTime();
    local _syncToDMState = (self.syncToDM == true and u_getDifficultyMult() ^ 0.12) or 1;

    self.currentEventTime = ((_timer_input - self.launchEventTime + self.eventDurationOffset) * _syncToDMState * self.timescale)
end

-- detects if the event section's <_duration_target> and <_section_target> exists, if the <_is_halt_advance> is true, current secton will no longer be advanced
function EventTimer:detect(_duration_target, _section_target, _is_halt_advance)
    if (self.currentEventTime >= _duration_target and self.eventSection == _section_target) then
        if getBooleanNumber(_is_halt_advance) == false then self.eventSection = (self.eventSection + 1);
        else self.haltAdvance = true;
            if (self.isDebounceInAdvanceEventHalter) and (not self.isDebounce) then
                self.isDebounceInAdvanceEventHalter = false; self.isDebounce = true;
            end
        end
        return true;
    end
    return false;
end

-- detects if the event debounce section when if event section halter starts
function EventTimer:detectDebounceIfHalterStarts()
    if (self.isDebounce) then self.isDebounce = false; return true; end
    return false;
end

-- advance if the event section was halted when if duration is <_duration_target> was reached
function EventTimer:advanceIfHalted(_duration_target)
    _duration_target = _duration_target or 0
    if (self.currentEventTime >= _duration_target) and (self.haltAdvance) then
        self.eventSection = (self.eventSection + 1);
        self.haltAdvance = false; self.isDebounceInAdvanceEventHalter = true;
        return true;
    end
    return false;
end