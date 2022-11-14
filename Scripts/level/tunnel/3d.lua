local camera = {
    pos = {
        x = 0,
        y = MAJOR_RADIUS,
        z = -256
    },

    plane = {
        x = 0,
        y = 0,
        -- Image plane location
        z = 750
    }
}

local light = {
    x = 0,
    y = (MAJOR_RADIUS + 60) * math.cos(-0.2),
    z = (MAJOR_RADIUS + 60) * math.sin(-0.2)
}

Point = {}
Point.__index = Point


function Point:new(x, y, z)
    return setmetatable({
        x = x,
        y = y,
        z = z
    }, self)
end

function Point:update()
    local cx, cy, cz = camera.pos.x, camera.pos.y, camera.pos.z
    self.dx = self.x - cx
    self.dy = self.y - cy
    self.dz = self.z - cz
end

function Point:project()
    local ex, ey, ez = camera.plane.x, camera.plane.y, camera.plane.z
    local bx = (ez / self.dz) * self.dx + ex
    local by = (ez / self.dz) * self.dy + ey

    return bx, by, self.dz > 0
end

local function brighnessToColor(x)
    local xx = x * x
    local xxx = x * x * x
    local xxxx = x * x * x * x
    return -620.371075881 * xxx + 834.985674352 * xx + 34.0619887022 * x,
        -996.417831034 * xxxx + 1951.46886177 * xxx - 863.482003891 * xx + 124.918415674 * x,
        2936.31315588 * xxxx - 4794.63594112 * xxx + 1544.55658236 * xx + 401.812305939 * x,
        255
end

Quad = {
    instances = {}
}
Quad.__index = Quad

function Quad:new(a, b, c, d, i)
    local newInst = setmetatable({
        key = { K = cw_createNoCollision() },
        a = a, b = b, c = c, d = d,
        x = 0, y = 0, z = 0,
        i = i or 0
    }, self)
    self.instances[newInst] = true
    return newInst
end

function Quad:updateCameraDistance()
    local adx, ady, adz = camera.pos.x - self.a.x, camera.pos.y - self.a.y, camera.pos.z - self.a.z
    local bdx, bdy, bdz = camera.pos.x - self.b.x, camera.pos.y - self.b.y, camera.pos.z - self.b.z
    local cdx, cdy, cdz = camera.pos.x - self.c.x, camera.pos.y - self.c.y, camera.pos.z - self.c.z
    local ddx, ddy, ddz = camera.pos.x - self.d.x, camera.pos.y - self.d.y, camera.pos.z - self.d.z
    self.dist = math.max(
        adx * adx + ady * ady + adz * adz,
        bdx * bdx + bdy * bdy + bdz * bdz,
        cdx * cdx + cdy * cdy + cdz * cdz,
        ddx * ddx + ddy * ddy + ddz * ddz
    ) ^ 0.5
end

-- Returns the unit vector from the quad position pointing towards the light source.
function Quad:light()
    local x = (self.a.x + self.b.x + self.c.x + self.d.x) * 0.25
    local y = (self.a.y + self.b.y + self.c.y + self.d.y) * 0.25
    local z = (self.a.z + self.b.z + self.c.z + self.d.z) * 0.25
    local dx, dy, dz = light.x - x, light.y - y, light.z - z
    local invsqrt = (dx * dx + dy * dy + dz * dz) ^ -0.5
    return dx * invsqrt, dy * invsqrt, dz * invsqrt, invsqrt
end

-- Returns the unit normal vector of the quad.
function Quad:normal()
    local ax, ay, az = self.b.x - self.a.x, self.b.y - self.a.y, self.b.z - self.a.z
    local bx, by, bz = self.d.x - self.a.x, self.d.y - self.a.y, self.d.z - self.a.z
    local cx, cy, cz = ay * bz - az * by, az * bx - ax * bz, ax * by - ay * bx
    local invsqrt = (cx * cx + cy * cy + cz * cz) ^ -0.5
    return cx * invsqrt, cy * invsqrt, cz * invsqrt
end

-- Sets the current brightness of the quad
function Quad:getBrightness()
    local ax, ay, az, dist = self:light()
    local bx, by, bz = self:normal()
    local dprod = ax * bx + ay * by + az * bz
    local b = (dprod + 1) * 0.5
    return clamp(b * b * dist * 300 + self.i, 0, 1)
end

function Quad:update()
    cw_setVertexColor4Same(self.key.K, brighnessToColor(self:getBrightness()))

    local x0, y0, f0 = self.a:project()
    local x1, y1, f1 = self.b:project()
    local x2, y2, f2 = self.c:project()
    local x3, y3, f3 = self.d:project()
    if f0 and f1 and f2 and f3 then
        cw_setVertexPos4(self.key.K, x0, y0, x1, y1, x2, y2, x3, y3)
    else
        cw_setVertexPos4(self.key.K, 0, 0, 0, 0, 0, 0, 0, 0)
    end
end

function Quad:delete()
    self.instances[self] = nil
    cw_setVertexPos4(self.key.K, 0, 0, 0, 0, 0, 0, 0, 0)
    cw_destroy(self.key.K)
end

function Quad.sort()
    local keys = {}
    local quads = {}
    for obj, _ in pairs(Quad.instances) do
        obj:updateCameraDistance()
        table.insert(keys, obj.key.K)
        table.insert(quads, obj)
    end
    table.sort(quads, function(a, b)
        return a.dist < b.dist
    end)
    table.sort(keys, function(a, b)
        return a > b
    end)
    for i, obj in pairs(quads) do
        obj.key.K = keys[i]
    end
end
