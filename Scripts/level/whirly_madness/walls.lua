Walls = { walls = {}, currentSpeed, speedMult = 1 }

function Walls:spawn(side, thickness, positionFunction)
    positionFunction = positionFunction or function(frametime, wall)
        -- set wall position and determine when it's killed (if nil is returned)
        if wall.pos == nil then
            wall.pos = l_getWallSpawnDistance()
        end
        wall.pos = wall.pos - frametime * Walls.currentSpeed
        if wall.pos + wall.thickness >= Status.radius * 0.5 then
            return wall.pos
        end
    end

    thickness = thickness or 40

    -- create 2 cws for the fake 3D effect
    local cws = { cw_create(), cw_createNoCollision() }
    cw_setVertexPos4(cws[1], 0, 0, 0, 0, 0, 0, 0, 0)
    cw_setVertexPos4(cws[2], 0, 0, 0, 0, 0, 0, 0, 0)
    cw_setVertexColor4Same(cws[1], 255, 255, 255, 255)
    cw_setVertexColor4Same(cws[2], 255, 255, 255, 255)

    -- calculate the angles of the wall vertices
    local div = math.pi / l_getSides()
    local angle = side * div * 2
    table.insert(self.walls, {
        cws = cws,
        posFunc = positionFunction,
        thickness = thickness,
        angles = {
            angle - div,
            angle + div,
        }
    })
end

function Walls:update(frametime)
    -- calculate current speed based on levelTime (to increment overtime) and based on 3D pulse to make the level more playable
    self.currentSpeed = 12 * (levelTime / 120 + 1) / (Fake.pulse3D * 0.2 + 1) * self.speedMult
    local del_queue = {}
    local radius = Status.radius * 0.75 -- walls disappear at a smaller radius
    for i = 1, #self.walls do
        local wall = self.walls[i]
        local pos = wall.posFunc(frametime, wall)
        if pos == nil then
            cw_destroy(wall.cws[1])
            cw_destroy(wall.cws[2])
            table.insert(del_queue, 1, i)
        else
            -- don't move vertices closer if they touch the pivot
            local upperPos = pos + wall.thickness
            if pos < radius then
                pos = radius
            end
            if upperPos < radius then
                upperPos = radius
            end

            -- calculate and set vertices
            local vertices = {
                Fake:getOrbit(wall.angles[1], pos, { 0, 0 }),
                Fake:getOrbit(wall.angles[2], pos, { 0, 0 }),
                Fake:getOrbit(wall.angles[2], upperPos, { 0, 0 }),
                Fake:getOrbit(wall.angles[1], upperPos, { 0, 0 }),
            }
            for i = 1, 4 do
                cw_setVertexPos(wall.cws[1], i - 1, unpack(vertices[i]))
            end
        end
    end
    for _, i in pairs(del_queue) do
        table.remove(self.walls, i)
    end
end

function Walls:clear()
    for _, wall in pairs(self.walls) do
        cw_destroy(wall.cws[1])
        cw_destroy(wall.cws[2])
    end
    self.walls = {}
end

function Walls:update3D()
    -- add the 3D offset and set vertices of the 2nd set of cws
    for _, wall in pairs(self.walls) do
        local vertices = { cw_getVertexPos4(wall.cws[1]) }
        for i = 0, 7 do
            vertices[i + 1] = vertices[i + 1] + Fake.newPos[i % 2 + 1]
        end
        cw_setVertexPos4(wall.cws[2], unpack(vertices))
    end
end
