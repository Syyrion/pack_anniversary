u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")

--Created by Baum--

Ring = { vertices = {}, cws = {}, thickness = 40 }

function Ring:create()
    for side = 1, l_getSides() do
        table.insert(self.cws, cw_createNoCollision())
        table.insert(self.vertices, self:calculateVertices(side))
    end
end

function Ring:delete()
    for _, cw in pairs(self.cws) do
        cw_destroy(cw)
    end
    self.cws = {}
    self.vertices = {}
end

function Ring:calculateVertices(side)
    local function getOrbit(angle)
        return { math.cos(angle), math.sin(angle) }
    end

    for x = 1, 6 do
        local side = x -- side to put wall at
    end
    local div = math.pi / l_getSides() -- 2 * div = angle one side takes up
    local angle = side * div * 2
    return {
        getOrbit(angle + div),
        getOrbit(angle - div),
        getOrbit(angle - div),
        getOrbit(angle + div)
    }
end

function Ring:updatePosition(distance)
    for i = 1, #self.cws do
        local vertices = self.vertices[i]
        local cw = self.cws[i]
        for v = 0, 1 do
            local vertex = vertices[v + 1]
            cw_setVertexPos(cw, v, vertex[1] * distance, vertex[2] * distance)
            cw_setVertexColor4Same(cw, 255, 255, 255, 65)
        end
        for v = 2, 3 do
            local vertex = vertices[v + 1]
            cw_setVertexPos(cw, v, vertex[1] * (distance + self.thickness), vertex[2] * (distance + self.thickness))
            cw_setVertexColor4Same(cw, 255, 255, 255, 65)
        end
    end
end
