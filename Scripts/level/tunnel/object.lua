u_execDependencyScript('library_extbase', 'extbase', 'syyrion', 'utils.lua')
u_execDependencyScript("library_slider", "slider", "syyrion", "master.lua")
u_execDependencyScript("library_polywall", "polywall", "syyrion", "master.lua")

MAJOR_RADIUS = 1000
MINOR_RADIUS = SliderTriangle:new(0.485833333, 6, 100)
MINOR_RADIUS:setPhase(-10)
MINOR_RADIUS:setAsymmetry(0.05)

u_execScript("level/tunnel/3d.lua")

TorusAngle = {
    inc = Incrementer:new(1, 13, 24),
    angle = SliderSawtooth:new(7, math.pi),
    increment = function(self)
        self.angle:setTimescale(self.inc:increment())
    end,
    getValue = function(self)
        return self.angle:getValue()
    end,

    step = function(self, mFrameTime)
        self.angle:step(mFrameTime)
    end
}

local MAJOR_DIVISIONS = 256
local MAJOR_ARC = math.tau / MAJOR_DIVISIONS
local MINOR_ARC = math.tau / SIDES

local FRONT_LIMIT = 37
local REAR_LIMIT = -6

Torus = {}

function Torus:create()
    self.points = {}
    self.quads = {}

    for i = 0, SIDES - 1 do
        self.points[i] = {}
        for j = REAR_LIMIT, FRONT_LIMIT do
            self.points[i][j] = Point:new()
            if i > 0 and j > REAR_LIMIT then
                table.insert(self.quads, Quad:new(
                    self.points[i - 1][j],
                    self.points[i][j],
                    self.points[i][j - 1],
                    self.points[i - 1][j - 1]
                ))
            end
        end
    end
    for j = REAR_LIMIT + 1, FRONT_LIMIT do
        table.insert(self.quads, Quad:new(
            self.points[SIDES - 1][j],
            self.points[0][j],
            self.points[0][j - 1],
            self.points[SIDES - 1][j - 1]
        ))
    end
    self:update()
end

function Torus:update()
    local ta = TorusAngle:getValue()
    local r = MINOR_RADIUS:getValue()
    for i, axialArc in pairs(self.points) do
        local theta = i * MINOR_ARC + ta
        local ctheta, stheta = math.cos(theta), math.sin(theta)
        local x = r * ctheta
        local Rrstheta = MAJOR_RADIUS + r * stheta
        for j, point in pairs(axialArc) do
            local phi = j * MAJOR_ARC
            local cphi, sphi = math.cos(phi), math.sin(phi)
            point.x = x
            point.y = Rrstheta * cphi
            point.z = Rrstheta * sphi
            point:update()
        end
    end
    for _, quad in pairs(self.quads) do
        quad:update()
    end
end

Player = {
    WIDTH = 6,
    HEIGHT = 2,
    LENGTH = 30,
    OFFSET = -24
}

function Player:create()
    self.points = {
        n = Point:new(nil, nil, 0),
        s = Point:new(nil, nil, 0),
        e = Point:new(nil, nil, 0),
        w = Point:new(nil, nil, 0),
        t = Point:new(nil, nil, self.LENGTH)
    }
    self.quads = {
        ne = Quad:new(self.points.n, self.points.e, self.points.t, self.points.t, 0.15),
        nw = Quad:new(self.points.w, self.points.n, self.points.t, self.points.t, 0.15),
        b = Quad:new(self.points.n, self.points.w, self.points.s, self.points.e)
    }

    self:update()
end

function Player:update()
    local theta = u_getPlayerAngle() + TorusAngle:getValue()
    local ctheta, stheta = math.cos(theta), math.sin(theta)
    local r = MINOR_RADIUS:getValue() + self.OFFSET

    self.points.n.x = (r - self.HEIGHT) * -stheta
    self.points.n.y = MAJOR_RADIUS + (r - self.HEIGHT) * ctheta

    self.points.s.x = (r + self.HEIGHT) * -stheta
    self.points.s.y = MAJOR_RADIUS + (r + self.HEIGHT) * ctheta

    self.points.e.x = self.WIDTH * ctheta - r * stheta
    self.points.e.y = MAJOR_RADIUS + self.WIDTH * stheta + r * ctheta

    self.points.w.x = -self.WIDTH * ctheta - r * stheta
    self.points.w.y = MAJOR_RADIUS - self.WIDTH * stheta + r * ctheta

    self.points.t.x = r * -stheta
    self.points.t.y = MAJOR_RADIUS + r * ctheta

    for _, point in pairs(self.points) do
        point:update()
    end

    for _, quad in pairs(self.quads) do
        quad:update()
    end
end

local RADIANS_PER_THICKNESS = MAJOR_ARC * 2 / THICKNESS

local SPAWN_POSITION = FRONT_LIMIT * MAJOR_ARC

local MIN_DESPAWN_POSITION = REAR_LIMIT * MAJOR_ARC

Wall = {
    pw = PolyWall:new(),
    OFFSET = -27,
    instances = {
        [0] = {},
        [1] = {},
        [2] = {},
        [3] = {},
        [4] = {},
        [5] = {}
    }
}

Wall.pw.vertex:chset(0, 0, 0, 0)
Wall.pw.limit.origin:set(750)

Wall.pw.speed:freeze()

Wall.pw:template(0, SIDES)
Wall.pw:regularize(0, SIDES, -MINOR_ARC)

function Wall:new(side, thickness)
    local sections = RADIANS_PER_THICKNESS * ((thickness or THICKNESS) + 4) / MAJOR_ARC

    local newInst = {
        position = SPAWN_POSITION,
        despawn = MIN_DESPAWN_POSITION - sections * MAJOR_ARC,
        points = {},
        quads = {}
    }

    local a, b, c, d = Point:new(), Point:new(), Point:new(), Point:new()
    newInst.points[0] = { a = a, b = b, c = c, d = d }
    table.insert(newInst.quads, Quad:new(a, b, c, d))

    local whole, partial = math.modf(sections)

    for i = 1, whole do
        local na, nb, nc, nd = Point:new(), Point:new(), Point:new(), Point:new()
        newInst.points[i] = { a = na, b = nb, c = nc, d = nd }
        table.insert(newInst.quads, Quad:new(a, b, nb, na, 0.25))
        table.insert(newInst.quads, Quad:new(b, c, nc, nb, 0.25))
        table.insert(newInst.quads, Quad:new(c, d, nd, nc, 0.25))
        a, b, c, d = na, nb, nc, nd
    end

    if partial > 0 then
        local na, nb, nc, nd = Point:new(), Point:new(), Point:new(), Point:new()
        newInst.points[sections] = { a = na, b = nb, c = nc, d = nd }
        table.insert(newInst.quads, Quad:new(a, b, nb, na, 0.25))
        table.insert(newInst.quads, Quad:new(b, c, nc, nb, 0.25))
        table.insert(newInst.quads, Quad:new(c, d, nd, nc, 0.25))
    end

    side = side % SIDES
    self.instances[side][newInst] = true
    self.pw[side]:sWall(0, thickness)
end

function Wall:update(mFrameTime)
    self.pw:fill(1)
    self.pw:move(1, mFrameTime)
    local speed = RADIANS_PER_THICKNESS * self.pw.speed:get()
    local ta = TorusAngle:getValue()
    local r0 = MINOR_RADIUS:getValue()
    local r1 = r0 + self.OFFSET
    for side, group in pairs(self.instances) do
        local thetaa, thetab = side * MINOR_ARC + ta, (side + 1) * MINOR_ARC + ta
        local cthetaa, sthetaa, cthetab, sthetab = math.cos(thetaa), math.sin(thetaa), math.cos(thetab), math.sin(thetab)

        local ra = MAJOR_RADIUS + r0 * sthetaa
        local rb = MAJOR_RADIUS + r1 * sthetaa
        local rc = MAJOR_RADIUS + r1 * sthetab
        local rd = MAJOR_RADIUS + r0 * sthetab

        local xa = r0 * cthetaa
        local xb = r1 * cthetaa
        local xc = r1 * cthetab
        local xd = r0 * cthetab
        for wall, _ in pairs(group) do
            wall.position = wall.position - mFrameTime * speed
            if wall.position < wall.despawn then
                for _, quad in pairs(wall.quads) do
                    quad:delete()
                end
                group[wall] = nil
            else
                for j, point in pairs(wall.points) do
                    local phi = j * MAJOR_ARC + wall.position
                    local cphi, sphi = math.cos(phi), math.sin(phi)
                    point.a.x = xa
                    point.a.y = ra * cphi
                    point.a.z = ra * sphi
                    point.a:update()

                    point.b.x = xb
                    point.b.y = rb * cphi
                    point.b.z = rb * sphi
                    point.b:update()

                    point.c.x = xc
                    point.c.y = rc * cphi
                    point.c.z = rc * sphi
                    point.c:update()

                    point.d.x = xd
                    point.d.y = rd * cphi
                    point.d.z = rd * sphi
                    point.d:update()
                end
                for _, quad in pairs(wall.quads) do
                    quad:update()
                end
            end
        end
    end
end

function cWall(side, thickness)
    Wall:new(side, thickness)
end
