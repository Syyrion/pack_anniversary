Patterns = {}
Patterns.__index = Patterns

function Patterns:new(patterns, patternizer)
	local newInst = setmetatable({
        patterns = patterns or error("Patterns are required", 2),
        patternizer = patternizer or error("Patternizer is required", 2),
        timings = {},
        queue = { {}, {} },
        params = {},
        action = {},
        freeze = false,
        skip = 0,
        origin = { 0, 0 }
	}, self)
	return newInst
end

function Patterns:reset()
    self.queue = { {}, {} }
    self.params = {}
    self.action = {}
    self.freeze = false
    self.skip = 0
    self.origin = { 0, 0 }
end

function Patterns:spawn()
    self:processQueue(2)
    if not self:getFreeze() and self:getSkip() == 0 then
        local pattern = self.patterns[self.action[1]]
        local data = self:processData()
        if self:getOrigin(true) > 0 then pattern = CUSTOM_SIDE .. pattern end
        self.patternizer:send(pattern, unpack(data))
    end
    self:advanceSkip()
    self:processQueue(1)
end

function Patterns:setQueue(data)
    local actions = {
        ['f'] = function(value)
                    local action = 0
                    if value then action = 1 else action = 2 end
                    self.queue[action]['f'] = value
                end,
        ['s'] = function(value)
                    local action = 0
                    if value > 0 then action = 1 else action = 2 end
                    self.queue[action]['s'] = value
                end,
        ['o'] = function(value)
                    self.queue[2]['o'] = value
                end
    }

    for k, v in pairs(data) do
        local action = actions[k]
        if action ~= nil then
            actions[k](v)
        end
    end
end
function Patterns:processQueue(index)
    -- index 1 processing things to do on next step (usually enable things)
    -- index 2 processing things to do instantly (usually disable things)
    local actions = {
        ['f'] = function(value) self:setFreeze(value) end,
        ['s'] = function(value) self:setSkip(value) end,
        ['o'] = function(value) self:setOrigin(value) end
    }

    for k, v in pairs(self.queue[index]) do
        local action = actions[k]
        if action ~= nil then
            actions[k](v)
        end
    end

    self:clearQueue(index)
end
function Patterns:clearQueue(index)
    if index ~= nil then
        self.queue[index] = {}
    else
        self.queue[1] = {}
        self.queue[2] = {}
    end
end

function Patterns:setParams(params) table.insert(self.params, params) end
function Patterns:delParams(index) table.remove(self.params, index) end

function Patterns:setPattern(pattern) self.action = pattern end
function Patterns:getPattern() return self.action end

function Patterns:setFreeze(enabled) self.freeze = enabled end
function Patterns:getFreeze() return self.freeze end

function Patterns:setOrigin(side)
    if Filter.TABLE(side) and Filter.STRING(side[1]) then
        if Filter.TABLE(self.origin[1]) then
            __NOP()
        elseif self.origin[1] ~= 0 then
            self.origin[2] = self.origin[1]
        else
            self.origin[2] = 1
        end
        self.origin[1] = side
    elseif side == -1 then
        self.origin[1] = self.origin[2]
    else
        self.origin[2] = self.origin[1]
        self.origin[1] = side
    end

    self.patternizer.mirroring:set(side == 0)
    self.patternizer.randsideinit:set(side == 0)
end
function Patterns:getOrigin(set)
    set = set or false
    local origin = self.origin[1]
    if Filter.TABLE(origin) then
        local actions = {
            ['+']  =    function(value) return self.origin[2] + value end,
            ['-']  =    function(value) return self.origin[2] - value end,
            ['+-'] =    function(value)
                            if u_rndInt(0, 1) == 1 then
                                return self.origin[2] + value
                            else
                                return self.origin[2] - value
                            end
                        end
        }
        local side = actions[origin[1]](origin[2]) % (l_getSides() + 1)
        if side == 0 and origin[1] == '+' then side = side + 1 end
        if set then self.origin[2] = side end
        return side
    else
        return self.origin[1]
    end
end

function Patterns:setSkip(amount)
    if amount == 0 then
        self.skip = 0
    else
        self.skip = Incrementer:new(amount, 0, amount)
    end
end
function Patterns:getSkip()
    local amount = 0
    if self.skip ~= 0 then
        amount = self.skip:get()
    end
    return amount
end

function Patterns:setTimings(timings) self.timings = timings end
function Patterns:getTimings(index)
    if index == "dif+" then
        return self.timings[3] - self.timings[2]
    elseif index == "dif-" then
        return self.timings[2] - self.timings[1]
    elseif index == "cur" then
        return self.timings[2]
    end
    return nil
end

function Patterns:advanceSkip()
    if self.skip == 0 then
        return
    elseif self.skip:get() > 0 then
        self.skip:increment()
    elseif self.skip:get() == 0 then
        self.skip:restart()
    end
end

function Patterns:processData()
    local action = { unpack(self.action[2]) }
    local side = self:getOrigin()
    if side > 0 then    
        table.insert(action, side)
        table.insert(action, 1)
    end 
    if Filter.STRING(action[1]) then
        local data = { unpack(action) }
        local option = self:getTimings(data[1])
        if option ~= nil then
            data[1] = option
        end
        return data
    else
        return action
    end
end

CUSTOM_SIDE = "if 1 - amv end "

PATTERNS = {
    ["cWallEx"] =
        [[
            for
                r $th h:c
                1 rmv
            end
        ]],
    ["rWallEx"] =
        [[
            for
                r $th h:r
                1 rmv
            end
        ]],
    ["cWallEx Random"] =
        [[
            1 $sides 1 - rnd
            swap for
                r $th h:c
                over rmv
                r $th h:dd
                3 1 roll
                dup sleep
                3 -1 roll
                0 amv
            end
        ]],
    ["Mirror Spiral"] =
        [[
            for
                over s2th
                r swap $tolerance - p:r
                1 rmv
            end
        ]],
    ["Alt Barrage"] =
        [[
            for
                r $th 2 * h:|._
                1 rmv
                over
                sleep
            end
        ]],
    ["cWallEx Death"] =
        [[
            for
                r $th h:d
                1 rmv
            end
        ]],
    ["rWallEx Repeat"] =
        [[
            for
                r $th h:rd
                1 rmv
            end
        ]],
    ["Death Barrage"] =
        [[
            for
                over 2 / s2th
                r swap t:__|d
                -1 1 rnd rmv
                over sleep
            end
        ]],
    ["cWallExE"] =
        [[
            for
                r $th h:c
                1 rmv
            end
            s2th
            a swap $th + h:c
        ]],
    ["oWallExE"] =
        [[
            for
                over
                for
                    r $th h:c
                    1 rmv
                end
                $hsides rmv
                2 1 roll
                dup sleep
                2 1 roll
            end
        ]],
    ["Tunnel"] =
        [[
            over over *
            s2th $th +
            r swap h:c
            dup 2 % if 1 else -1 end
            rmv
            r $th h:_|.
            for
                over sleep
                dup 2 % if 2 else -2 end
                rmv
                r $th h:_|.
            end
        ]],
    ["Tunnel Death"] =
        [[
            over over *
            s2th $th +
            r swap h:d
            dup 2 % if 1 else -1 end
            rmv
            r $th h:_|d
            for
                over sleep
                dup 2 % if 2 else -2 end
                rmv
                r $th h:_|d
            end
        ]],
    ["Tunnel Straight"] =
        [[
            over over *
            s2th $th +
            r swap h:c
            dup 2 % if 1 else -1 end
            rmv
            dup 2 % if 
                r $th h:__|.
            else
                r $th h:~__|.
            end
            for
                over sleep
                dup 2 % if 2 else -2 end
                rmv
                dup 2 % if
                    r $th h:__|.
                else
                    r $th h:~__|.
                end
            end
        ]],
    ["Tunnel Straight Death"] =
        [[
            over over *
            s2th $th +
            r swap h:d
            dup 2 % if 1 else -1 end
            rmv
            dup 2 % if 
                r $th h:__|d
            else
                r $th h:~__|d
            end
            for
                over sleep
                dup 2 % if 2 else -2 end
                rmv
                dup 2 % if
                    r $th h:__|d
                else
                    r $th h:~__|d
                end
            end
        ]],
    ["Tunnel Random"] =
        [[
            over over *
            s2th $th +
            r swap h:c
            $hsides rmv
            r $th h:_|.
            for
                over sleep
                $hsides $hsides 2 * - 1 +
                $hsides 1 -
                rnd r + $th h:_|.
            end
        ]],
    ["Alt Barrage Ex"] =
        [[
            r $th h:|._
        ]],
    ["Alt Barrage Ex Death"] =
        [[
            r $th t:|c_
            $th th2s sleep
            dup
            $th th2s - s2th r swap t:|d_
        ]],
    ["Swap Barrage"] =
        [[
            for
                r $th h:c
                1 rmv
            end
            -3 rmv
            2 for
                2 rmv
                over s2th $th 2 * +
                r swap h:c
            end
            -1 rmv
            $th th2s +
            sleep
            r $th h:c
        ]]
}