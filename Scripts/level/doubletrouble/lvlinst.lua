LVI = { -- Defaults
    clipDir = 1, sides = 6, rotation = 0, rotationSpeed = 0,
    skew = 0, skewMin = 1, skewMax = 2, skewSpeed = 0,
    plrAngle = 0, plrSpeed = 9.45, plrDirection = 0, plrDistance = 15,
    plrSize = 8, radius = 40, keys = { 1 }, keyindex = 1,
    speed = 1, anticrash = 0, color = { 255, 255, 255 }, deathColor = { 0, 255, 0 } }
LVI.__index = LVI

function LVI:addWall(side, thickness)
    ct_eval(self.timeline, [[
        table.insert(LVI[%i].walldata,{
            side = %i, thickness = %f,
            polygons = {}, position = l_getWallSpawnDistance()
        })
    ]], self.id, side, thickness or THICKNESS)
end

function LVI:wait(frames)
    self.anticrash = 0
    ct_wait(self.timeline, frames)
end

function LVI:step()
    if self.incrementing then return end
    local wall, wait, sides = w_wall, t_wait, l_getSides
    function w_wall(s, t) self:addWall(s, t) end

    function t_wait(t) self:wait(t) end

    function l_getSides() return self.sides end

    self.anticrash = self.anticrash + 1
    addPattern(self.keys[self.keyindex])
    self.keyindex = self.keyindex + 1
    if self.keyindex - 1 == #self.keys then
        self.keyindex = 1
        shuffle(self.keys)
    end
    w_wall, t_wait, l_getSides = wall, wait, sides
    assert(self.anticrash < 100, "step called too many times without waiting")
    ct_eval(self.timeline, "LVI[%i]:step()", self.id)
end

function LVI:increment()
    self.incrementing = false
    self.speed = u_getSpeedMultDM()
    onIncrement(self)
    a_playSound("beep.ogg")
    ct_eval(self.timeline, "LVI[%i]:step()", self.id)
end

function LVI:update(dt)
    if dead then return end
    local sliding
    local color = { reunpack { self.color, 255, self.color, 255, self.color, 255, self.color, 255 } }
    local deathColor = { reunpack { self.deathColor, 255, self.deathColor, 255, self.deathColor, 255, self.deathColor, 255 } }
    if self.incrementing and #self.walldata == 0 then self:increment() else
        for index, wall in bipairs(self.walldata) do
            wall.position = wall.position - self.speed * 240 * dt
            if wall.position + wall.thickness < 0 then
                table.remove(self.walldata, index)
                for _, v in ipairs(wall.polygons) do cw_destroy(v) end
            else
                -- Calculate Wall Vertices
                local vertices, slopes, quads, quadindex, intersect, killCollision, slideCollision = {}, {}, {}, 1, nil, nil, nil
                for i, corner in ipairs({ { 0, 1 }, { 1, 1 }, { 1, 0 }, { 0, 0 }, false }) do
                    vertices[i] = corner and
                        { getWallCoords(self.rotation + (wall.side + corner[1]) * math.tau / self.sides,
                            math.max(0, wall.position + wall.thickness * corner[2]), self.skew, 0, unpack(self.position)) } or nil
                    intersect = intersect or (corner and (self.clipDir * vertices[i][2] < 0))
                    if i > 1 then
                        local x1, y1, x2, y2 = reunpack { vertices[i - 1], vertices[corner and i or 1] }
                        slopes[i - 1] = (y2 - y1) / (x2 - x1)
                    end
                end
                -- Check Collision
                local plrPos = { getWallCoords(self.rotation + self.plrAngle, self.radius + self.plrDistance, self.skew, 0,
                    unpack(self.position)) }
                local movPos = { getWallCoords(self.rotation + self.plrAngle + self.plrSpeed * self.plrDirection * dt,
                    self.radius + self.plrDistance, self.skew, 0, unpack(self.position)) }
                local j = #vertices
                for i = 1, #vertices do
                    local ix, iy, jx, jy = reunpack { vertices[i], vertices[j] }
                    if (iy > plrPos[2]) ~= (jy > plrPos[2]) and plrPos[1] < (jx - ix) * (plrPos[2] - iy) / (jy - iy) + ix then killCollision = not
                            killCollision
                    end
                    if (iy > movPos[2]) ~= (jy > movPos[2]) and movPos[1] < (jx - ix) * (movPos[2] - iy) / (jy - iy) + ix then slideCollision = not
                            slideCollision
                    end
                    j = i
                end
                dead = dead or (killCollision and l_getOfficial())
                sliding = sliding or slideCollision
                -- Algorithm to cut quads is based on https://www.desmos.com/calculator/5khkhcrgvx
                if intersect then
                    local oldvertices = vertices;
                    vertices = {}
                    for i, p1 in ipairs(oldvertices) do
                        local p2 = oldvertices[i % 4 + 1]
                        local xint = p1[1] - p1[2] / slopes[i]
                        if self.clipDir * p1[2] >= 0 then table.insert(vertices, p1) end
                        if isBetween(xint, p1[1], p2[1]) and isBetween(0, p1[2], p2[2]) then
                            table.insert(vertices, { xint, 0 })
                        end
                    end
                    for i, point in ipairs(vertices) do
                        quads[quadindex] = quads[quadindex] or {}
                        table.insert(quads[quadindex], point)
                        if #quads[quadindex] > 3 then
                            quadindex = quadindex + 1
                            if i ~= #vertices then
                                quads[quadindex] = {}
                                table.insert(quads[quadindex], point)
                            end
                        elseif i == #vertices then
                            while #quads[quadindex] < 4 do
                                table.insert(quads[quadindex], vertices[1])
                            end
                        end
                    end
                else quads = { vertices } end
                local quadpts = {}
                for i, v in ipairs(quads) do
                    quadpts[i] = {}
                    for i2, v2 in ipairs(v) do table.insert(quadpts[i], v2[1]) table.insert(quadpts[i], v2[2]) end
                end
                for i = 1, 2 do
                    wall.polygons[i] = wall.polygons[i] or cw_createNoCollision()
                    if not quadpts[i] then
                        cw_destroy(wall.polygons[i])
                        wall.polygons[i] = nil
                    else
                        cw_setVertexColor4(wall.polygons[i], unpack(killCollision and deathColor or color))
                        cw_setVertexPos4(wall.polygons[i], unpack(quadpts[i]))
                    end
                end
            end
        end
    end
    for side, polygon in bipairs(self.polygons.center) do
        if side > self.sides then
            cw_destroy(polygon)
            table.remove(self.polygons.center, side)
        else
            cw_setVertexColor4(polygon, unpack(color))
            cw_setVertexPos4(polygon, reunpack {
                { getWallCoords(self.rotation + side * math.tau / self.sides, self.radius, self.skew, 0, unpack(self.position)) },
                { getWallCoords(self.rotation + (side + 1) * math.tau / self.sides, self.radius, self.skew, 0, unpack(self.position)) },
                self.position, self.position
            })
            if #self.polygons.center < self.sides then
                table.insert(self.polygons.center, cw_createNoCollision())
            end
        end
    end
    self.plrAngle = self.plrAngle + (sliding and 0 or (self.plrSpeed * self.plrDirection * dt))
    self.rotation = self.rotation + self.rotationSpeed * dt
    self.skew = clamp(self.skew + self.skewSpeed * dt, self.skewMin, self.skewMax)
    self.skewSpeed = (self.skew == self.skewMin or self.skew == self.skewMax) and -self.skewSpeed or self.skewSpeed
    cw_setVertexColor4(self.polygons.player, unpack(color))
    cw_setVertexPos4(self.polygons.player, reunpack {
        { getWallCoords(self.rotation + self.plrAngle, self.radius + self.plrDistance, self.skew, 0, unpack(self.position)) },
        { getWallCoords(self.rotation + self.plrAngle, self.radius + self.plrDistance, self.skew, 0, unpack(self.position)) },
        { getWallCoords(self.rotation + self.plrAngle, self.radius + self.plrDistance - self.plrSize / 1.25, self.skew,
            -self.plrSize, unpack(self.position)) },
        { getWallCoords(self.rotation + self.plrAngle, self.radius + self.plrDistance - self.plrSize / 1.25, self.skew,
            self.plrSize, unpack(self.position)) },
    })
    if dead then t_kill() end
end

function LVI.new(pX, pY, clipDir)
    local self = setmetatable({}, LVI)
    table.insert(LVI, self)
    self.id = #LVI
    self.clipDir = clipDir
    self.speed = u_getSpeedMultDM()
    self.position = { x = pX, y = pY, [1] = pX, [2] = pY }
    self.timeline = ct_create()
    self.walldata = {}
    self.polygons = {
        player = cw_createNoCollision(),
        center = { cw_createNoCollision() },
    }
    ct_eval(self.timeline, "LVI[%i]:step()", self.id)
    return self
end

local previnc = 0
function LVI.updateAll(dt)
    for _, instance in ipairs(LVI) do
        instance.incrementing = instance.incrementing or previnc ~= l_getCurrentIncrements()
        instance:update(dt)
    end
    previnc = l_getCurrentIncrements()
end
