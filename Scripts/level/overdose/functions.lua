THICKNESS = 45.0;

-- getHalfSides: returns half the number of sides (integer)
function getHalfSides() return math.ceil(l_getSides() / 2) end

-- getRandomSide: returns random mSide
function getRandomSide() return math.random(0, l_getSides() - 1) end

-- getPlayerSide: gets the current side that the player is in
function getPlayerSide()
    local playerPosition = math.deg(u_getPlayerAngle())
    local sideLength = (360 / l_getSides())
    local offset = sideLength / 2

    return math.floor((playerPosition + offset) % 360 / sideLength)
end

-- getRandomDir: returns either 1 or -1
function getRandomDir()
    return math.random(1, 2) * 2 - 3
end

function getSideDistance(mSide1, mSide2, mShape)
    mShape = mShape or l_getSides()
    local diff = (mSide1 - mSide2) % mShape
    return math.min(math.abs(diff), math.abs(diff - mShape))
end

function getRotationDir()
    if l_getRotationSpeed() >= 0 then return 1 end
    return (-1)
end

-- cWall: creates a wall with the common THICKNESS
function cWall(mSide) w_wall(mSide, THICKNESS) end

-- oWall: creates a wall opposite to the mSide passed
function oWall(mSide) cWall(mSide + getHalfSides()) end

-- rWall: union of cwall and owall (created 2 walls facing each other)
function rWall(mSide)
    cWall(mSide)
    oWall(mSide)
end

-- cWallEx: creates a wall with mExtra walls attached to it
function cWallEx(mSide, mExtra)
    cWall(mSide);
    loopDir = 1;

    if mExtra < 0 then loopDir = -1 end
    for i = 1, mExtra do cWall(mSide + i) end
end

-- oWallEx: creates a wall with mExtra walls opposite to mSide
function oWallEx(mSide, mExtra)
    cWallEx(mSide + getHalfSides(), mExtra)
end

-- rWallEx: union of cwallex and owallex
function rWallEx(mSide, mExtra)
    cWallEx(mSide, mExtra)
    oWallEx(mSide, mExtra)
end

-- cBarrageN: spawns a barrage of walls, with a free mSide plus mNeighbors
function cBarrageN(mSide, mNeighbors)
    for i = mNeighbors, l_getSides() - 2 - mNeighbors, 1 do
        cWall(mSide + i + 1)
    end
end

-- cBarrage: spawns a barrage of walls, with a single free mSide
function cBarrage(mSide, mShape)
    mShape = mShape or l_getSides()

    for i = 1, mShape - 1 do
        cWall(mSide + i)
    end
end

-- cBarrageOnlyN: spawns a barrage of wall, with only free mNeighbors
function cBarrageOnlyN(mSide, mNeighbors)
    cWall(mSide)
    cBarrageN(mSide, mNeighbors)
end

-- cAltBarrage: spawns a barrage of alternate walls
function cAltBarrage(mSide, mStep)
    for i = 0, math.ceil(l_getSides() / mStep) - 1 do
        cWall(mSide + i * mStep)
    end
end

function cSpacedWalls(mSide, mStep)
    for i = 0, mStep do
        cWall(mSide + i * 2)
    end
end

function roundThousand(mFloat)
    return math.floor(mFloat * 1000 + 0.1)
end

function shuffle(t)
    -- "Shuffles" an array by swapping elements randomly across a table.
    local j
    for i = #t, 2, -1 do
        j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

RenderStage = {
    BACKGROUNDTRIS = 0,
    WALLQUADS3D = 1,
    PIVOTQUADS3D = 2,
    PLAYERTRIS3D = 3,
    WALLQUADS = 4,
    CAPTRIS = 5,
    PIVOTQUADS = 6,
    PLAYERTRIS = 7
}

-- Helper function for "fromHSV()", which translates from Hue and Saturation
-- to RGB values.
local function fromHS(h, s)
    -- Find a color from hue and saturation.
    h = (h % 360) / 60
    local i, f, g, t
    i, f = math.modf(h)
    g = 1 - f -- For descending gradients
    t = 1 - s -- Minimum color intensity based on saturation
    f, g = s * f + t, s * g + t -- Apply saturation

    if i == 0 then return 1, f, t
    elseif i == 1 then return g, 1, t
    elseif i == 2 then return t, 1, f
    elseif i == 3 then return t, g, 1
    elseif i == 4 then return f, t, 1
    elseif i == 5 then return 1, t, g
    end
    return 1, 1, 1 -- Fallback
end

-- Converts HSV color values to RGB color values in a 0 - 255 range (alpha not included).
function fromHSV(h, s, v)
    -- Saturation and Value are optional parameters
    s = s or 1
    v = v or 1

    local r, g, b = fromHS(h, s)
    r = math.floor(r * v * 255)
    g = math.floor(g * v * 255)
    b = math.floor(b * v * 255)
    return r, g, b
end

function clamp(input, min_val, max_val)
    --[[
    Clamps a number "input" between two values. The value can not go 
    below min_val and can not go above max_val.
    ]]
    if input < min_val then
        input = min_val
    elseif input > max_val then
        input = max_val
    end
    return input
end

function sign(x)
    return (x >= 0) and 1 or -1
end

function event(mTime, mScript)
    e_waitUntilS(mTime - 0.106)
    e_eval(mScript)
end

function setBackgroundShader(mShader)
    local gradientShaderId = shdr_getShaderId(mShader)

    shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, gradientShaderId)
    shdr_setActiveFragmentShader(RenderStage.CAPTRIS, gradientShaderId)
    currentBackgroundShader = gradientShaderId
end

function setWallShader(mShader)
    local gradientShaderId = shdr_getShaderId(mShader)

    shdr_setActiveFragmentShader(RenderStage.WALLQUADS, gradientShaderId)
    currentWallShader = gradientShaderId
end

function set3DShader(mShader)
    local gradientShaderId = shdr_getShaderId(mShader)

    shdr_setActiveFragmentShader(RenderStage.WALLQUADS3D, gradientShaderId)
    shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS3D, gradientShaderId)
    shdr_setActiveFragmentShader(RenderStage.PLAYERTRIS3D, gradientShaderId)
    current3DShader = gradientShaderId
end

function setPivotShader(mShader)
    local gradientShaderId = shdr_getShaderId(mShader)

    shdr_setActiveFragmentShader(RenderStage.PLAYERTRIS, gradientShaderId)
    shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS, gradientShaderId)
    currentPivotShader = gradientShaderId
end

-- based on "mix" and "smoothstep" from glsl
-- was used to create really neat transitions, but i ended up going with something else for the final level
function ColorMix(c1, c2, x)
    local lerpfactor = x * x * (3 - 2 * x) -- smooth transition from 0 to 1

    local r = (1 - lerpfactor) * c1[1] + c2[1] * lerpfactor
    local g = (1 - lerpfactor) * c1[2] + c2[2] * lerpfactor
    local b = (1 - lerpfactor) * c1[3] + c2[3] * lerpfactor

    return r, g, b
end
