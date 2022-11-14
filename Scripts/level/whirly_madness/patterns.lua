u_execScript("level/whirly_madness/walls.lua")

PLAYER_SPEED = 9.45
Patterns = { delayMult = 2.5, index = 1, interPatternDelayMult = 1.5 }

function Patterns:init()
    self.patterns = {
        self.inverseBarrage,
        self.altBarrage,
        self.vortex
    }
    shuffle(self.patterns)
end

function Patterns:simpleWall(side, thickness)
    -- spawn walls on the timeline
    thickness = thickness or 40
    t_eval("Walls:spawn(" .. side .. ", " .. thickness .. ")")
end

function Patterns:spawn()
    -- select a random pattern by shuffling and then going over the list of patterns
    local pattern = self.patterns[self.index]
    self.index = self.index + 1
    if self.index > #self.patterns then
        self.index = 1
        shuffle(self.patterns)
    end

    local side = math.random(1, l_getSides())
    local delayMult = self.delayMult
    self.delayMult = self.interPatternDelayMult
    self:waitForDistance(3)
    self.delayMult = delayMult
    pattern(self, side)
    self.delayMult = delayMult
    -- delayMult is resetted in case a pattern modifies it
end

function Patterns:waitForDistance(dist)
    -- calculate and wait delay based on the side distance the player has to go
    local anglePerSide = 360 / l_getSides()
    local delay = dist * anglePerSide / PLAYER_SPEED * self.delayMult
    t_wait(delay)
    self.waited = true

    -- return the thickness a wall needs to match the delay at the current speed
    return delay * Walls.currentSpeed
end

function Patterns:barrage(side)
    for i = 1, l_getSides() - 1 do
        self:simpleWall(side + i)
    end
end

function Patterns:inverseBarrage(side)
    local dist = math.floor(l_getSides() / 2)
    self:barrage(side)
    for i = 1, math.random(2, 3) do
        self:waitForDistance(dist)
        self:barrage(side + dist * (i % 2))
    end
end

function Patterns:altBarrage(side)
    for j = 0, math.random(3, 5) do
        self:waitForDistance(1)
        for i = 0, math.floor(l_getSides() / 2) do
            self:simpleWall(side + i * 2 + j % 2)
        end
    end
end

function Patterns:halfBarrage(side)
    for i = 1, l_getSides() - 1 do
        if i ~= math.floor(l_getSides() / 2) then
            self:simpleWall(side + i)
        end
    end
end

function Patterns:vortex(side)
    for i = 1, 3 do
        self:waitForDistance(1)
        self:halfBarrage(side + i)
    end
    for i = 2, 1, -1 do
        self:waitForDistance(1)
        self:halfBarrage(side + i)
    end
end
