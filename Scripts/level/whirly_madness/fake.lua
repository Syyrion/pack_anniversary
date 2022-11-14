Fake = { pivotQuads = {}, baseThickness = 5, pulse3D = 1, pulse3DDirection = 1, newPos = { 0, 0 }, center = { 0, 0 },
    realOffset = { 0, 0 } }


function Fake:getOrbit(angle, dist, pos)
    if dist == nil and pos == nil then
        return { math.cos(angle), math.sin(angle) }
    else
        return { math.cos(angle) * dist + pos[1], math.sin(angle) * dist + pos[2] }
    end
end

function Fake:create()
    -- pivot
    local div = math.pi / l_getSides()
    for i = 0, l_getSides() - 1 do
        local sAngle = div * 2 * i
        local quad = {
            vertices = {
                self:getOrbit(sAngle - div),
                self:getOrbit(sAngle + div),
                self:getOrbit(sAngle + div),
                self:getOrbit(sAngle - div)
            },
            cw = cw_createNoCollision()
        }
        cw_setVertexColor4Same(quad.cw, 255, 255, 255, 255)
        table.insert(self.pivotQuads, quad)
    end

    -- player (need it twice since it's also replacing the real one)
    self.playerQuads = { cw_createNoCollision(), cw_createNoCollision() }
    cw_setVertexColor4Same(self.playerQuads[1], 255, 255, 255, 255)
    cw_setVertexColor4Same(self.playerQuads[2], 255, 255, 255, 255)
end

function Fake:delete()
    for _, quad in pairs(self.pivotQuads) do
        cw_destroy(quad.cw)
    end
    for _, cw in pairs(self.playerQuads) do
        cw_destroy(cw)
    end
    self.pivotQuads = {}
    self.playerQuads = {}
end

radius = 0
function Fake:updateVisuals(depth)
    -- calculate radius again since this is called in onRenderStage (after game logic)
    local radius = l_getRadiusMin() * (l_getPulse() / l_getPulseMin()) + l_getBeatPulse()

    -- recreate the 3D offset the game normally calculates internally
    local offset = s_get3dSpacing() * (depth + 1) * s_get3dPerspectiveMult() * (s_get3dSkew() * self.pulse3D * 3.6) * 1.4
    local rotation = math.rad(l_getRotation() + 90)
    self.newPos = { offset * math.cos(rotation) + self.center[1] + self.realOffset[1],
        offset * math.sin(rotation) + self.center[2] + self.realOffset[2] }

    -- apply radius, baseThickness and 3D offset to the fake pivot
    for _, quad in pairs(self.pivotQuads) do
        for i = 0, 3 do
            local vertex = quad.vertices[i + 1]
            local mult = i < 2 and radius * 0.75 or radius * 0.75 + self.baseThickness
            cw_setVertexPos(quad.cw, i, vertex[1] * mult + self.newPos[1], vertex[2] * mult + self.newPos[2])
        end
    end

    -- update the fake players vertices
    local playerSize = 7.3 + (focus and -1.5 or 3)
    local playerAngle = u_getPlayerAngle()
    local playerPos = self:getOrbit(playerAngle, radius, { 0, 0 })
    local playerTip = self:getOrbit(playerAngle, 7.3, playerPos)
    local playerVertices = {
        playerTip,
        self:getOrbit(playerAngle + math.rad(100), playerSize, playerPos),
        self:getOrbit(playerAngle - math.rad(100), playerSize, playerPos),
        playerTip
    }
    for i = 1, 4 do
        cw_setVertexPos(
            self.playerQuads[1], i - 1,
            playerVertices[i][1] + self.realOffset[1],
            playerVertices[i][2] + self.realOffset[2]
        )
    end
    for i = 1, 4 do
        cw_setVertexPos(
            self.playerQuads[2], i - 1,
            playerVertices[i][1] + self.newPos[1],
            playerVertices[i][2] + self.newPos[2]
        )
    end
end

function Fake:updatePulse3D(frametime)
    -- recreate the games internal 3D pulse logic as there is no way to get the current value from lua
    local speedMult = l_getSpeedMult()
    l_setSpeedMult(self.pulse3D + s_get3dPulseSpeed() * self.pulse3DDirection * frametime)
    self.pulse3D = l_getSpeedMult() -- use internal properties for accurate rounding (otherwise it doesn't match the game)
    l_setSpeedMult(speedMult)

    if self.pulse3D > s_get3dPulseMax() then
        self.pulse3DDirection = -1
    elseif self.pulse3D < s_get3dPulseMin() then
        self.pulse3DDirection = 1
    end
end
