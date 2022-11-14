--taken from baum's OH converter

-- small utility class to automatically round numbers like floats
conv_float = {}
conv_float.round = function(num)
    -- this could be done with something like `return math.floor(num * 10 ^ 6 + 0.5) / 10 ^ 6` but I'm not 100% sure if it's accurate
    local speedMult = l_getSpeedMult()
    l_setSpeedMult(num)
    local num = l_getSpeedMult()
    l_setSpeedMult(speedMult)
    return num
end
conv_float.make_float = function(num)
    if type(num) == "number" then
        return conv_float:new(num)
    end
    return num
end
conv_float.__add = function(a, b)
    return conv_float:new(conv_float.make_float(a).value + conv_float.make_float(b).value)
end
conv_float.__sub = function(a, b)
    return conv_float:new(conv_float.make_float(a).value - conv_float.make_float(b).value)
end
conv_float.__mul = function(a, b)
    return conv_float:new(conv_float.make_float(a).value * conv_float.make_float(b).value)
end
conv_float.__div = function(a, b)
    return conv_float:new(conv_float.make_float(a).value / conv_float.make_float(b).value)
end
conv_float.__tostring = function(o)
    return o.value
end
function conv_float:new(value)
    return setmetatable({ value = conv_float.round(value or 0) }, conv_float)
end

conv_wall_module = {
    _getOrbit = function(degrees, distance)
        return math.cos((degrees / 57.3).value) * distance,
            math.sin((degrees / 57.3).value) * distance
    end,

    WALL_SPAWN_DIST = l_getWallSpawnDistance(),
    walls = {},

    find_self = function(self)
        if self == nil then
            return conv_wall_module
        end
        return self
    end,
    wallAcc = function(self, side, thickness, speedAdj, acceleration, minSpeed, maxSpeed, shape, speed, distance)
        self = conv_wall_module.find_self(self)
        self:_wall(side, shape, thickness, distance, speedAdj * ((speed or l_getSpeedMult()) * u_getDifficultyMult() ^ 0.65),
            acceleration, minSpeed * ((speed or l_getSpeedMult()) * u_getDifficultyMult() ^ 0.65),
            maxSpeed * ((speed or l_getSpeedMult()) * u_getDifficultyMult() ^ 0.65))
    end,
    wallAdj = function(self, side, thickness, speedAdj, shape, speed, distance)
        self = conv_wall_module.find_self(self)
        self:_wall(side, shape, thickness, distance, speedAdj * ((speed or l_getSpeedMult()) * u_getDifficultyMult() ^ 0.65), 0
            , 0, 0)
    end,
    wall = function(self, side, thickness, shape, speed, distance)
        self = conv_wall_module.find_self(self)
        self:_wall(side, shape, thickness, distance, ((speed or l_getSpeedMult()) * u_getDifficultyMult() ^ 0.65), 0, 0, 0)
    end,
    _wall = function(self, side, shape, thickness, distance, speed, acceleration, minSpeed, maxSpeed)
        local wall = { cw = cw_create() }
        local div = conv_float:new(360 / (shape or l_getSides()))
        local angle = div * side
        cw_setVertexPos(wall.cw, 0, self._getOrbit(angle - div * 0.5, (distance or self.WALL_SPAWN_DIST)))
        cw_setVertexPos(wall.cw, 1, self._getOrbit(angle + div * 0.5, (distance or self.WALL_SPAWN_DIST)))
        cw_setVertexPos(wall.cw, 2,
            self._getOrbit(angle + div * 0.5 + l_getWallAngleLeft(),
                (distance or self.WALL_SPAWN_DIST) + thickness + l_getWallSkewLeft()))
        cw_setVertexPos(wall.cw, 3,
            self._getOrbit(angle - div * 0.5 + l_getWallAngleRight(),
                (distance or self.WALL_SPAWN_DIST) + thickness + l_getWallSkewRight()))
        self._set_color(wall.cw)
        wall.speed = speed
        wall.accel = acceleration
        wall.minSpeed = minSpeed
        wall.maxSpeed = maxSpeed
        table.insert(self.walls, wall)
    end,
    _set_color = function(cw)
        for i = 0, 3 do
            cw_setVertexColor(cw, i, s_getMainColor())
        end
    end,
    empty = function(self)
        return #self.walls == 0
    end,
    clear = function(self)
        local length = #self.walls
        for i = 1, length do
            cw_destroy(self.walls[1].cw)
            table.remove(self.walls, 1)
        end
    end,
    update_walls = function(self, frametime)
        local delete_queue = {}
        local radius = (l_getRadiusMin() * (l_getPulse() / l_getPulseMin()) + l_getBeatPulse()) * 0.65
        for i = 1, #self.walls do
            local wall = self.walls[i]
            self._set_color(wall.cw)
            if wall.accel ~= 0 then
                wall.speed = wall.speed + wall.accel * frametime
                if wall.speed > wall.maxSpeed then
                    wall.speed = wall.maxSpeed
                end
                if wall.speed < wall.minSpeed then
                    wall.speed = wall.minSpeed
                end
            end
            local points_on_center = 0
            for vertex = 0, 3 do
                local x, y = cw_getVertexPos(wall.cw, vertex)
                if math.abs(x) < radius and math.abs(y) < radius then
                    points_on_center = points_on_center + 1
                else
                    local magnitude = math.sqrt(x ^ 2 + y ^ 2)
                    local move_dist = wall.speed * 5 * frametime
                    cw_setVertexPos(wall.cw, vertex, x - x / magnitude * move_dist, y - y / magnitude * move_dist)
                end
            end
            if points_on_center > 3 then
                cw_destroy(wall.cw)
                table.insert(delete_queue, 1, i)
            end
        end
        for _, i in pairs(delete_queue) do
            table.remove(self.walls, i)
        end
    end
}

function v192Wall(mSide, mThickness, mShape, mSpeed, mDistance)
    conv_wall_module.wall(nil, mSide, mThickness, mShape, mSpeed, mDistance)
end

function v192WallAdj(mSide, mThickness, mSpeedAdj, mShape, mSpeed, mDistance)
    conv_wall_module.wallAdj(nil, mSide, mThickness, mSpeedAdj, mShape, mSpeed, mDistance)
end

function v192WallAcc(mSide, mThickness, mSpeedAdj, mAcceleration, mMinSpeed, mMaxSpeed, mShape, mSpeed, mDistance)
    conv_wall_module.wallAcc(nil, mSide, mThickness, mSpeedAdj, mAcceleration, mMinSpeed, mMaxSpeed, mShape, mSpeed,
        mDistance)
end

function tv192Wall(mSide, mThickness, mShape, mSpeed, mDistance)
    t_eval(([[conv_wall_module.wall(nil, %d, %d, %d, %d, %d)]]):format(mSide, mThickness, mShape, mSpeed, mDistance))
end

function tv192WallAdj(mSide, mThickness, mSpeedAdj, mShape, mSpeed)
    t_eval(([[conv_wall_module.wallAdj(nil, %d, %d, %d, %d, %d, %d)]]):format(mSide, mThickness, mSpeedAdj, mShape, mSpeed,
        mDistance))
end

function tv192WallAcc(mSide, mThickness, mSpeedAdj, mAcceleration, mMinSpeed, mMaxSpeed, mShape, mSpeed)
    t_eval(([[conv_wall_module.wallAcc(nil, %d, %d, %d, %d, %d, %d, %d, %d, %d)]]):format(mSide, mThickness, mSpeedAdj,
        mAcceleration, mMinSpeed, mMaxSpeed, mShape, mSpeed, mDistance))
end

function v192UpdateWalls(mFrameTime)
    conv_wall_module:update_walls(mFrameTime)
end

function v192ClearWalls()
    conv_wall_module:clear()
    --conv_wall_module:empty()
end
