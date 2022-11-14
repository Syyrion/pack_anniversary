u_execScript("level/memoriesReappear/utils/march31o_utils.lua")

globalWallType = 0
local curHueMod = 0
local curAdj = 0
local curAcc = 0
local curMinSpd = 0
local curMaxSpd = 0
local curCurve = 0
local curCurveAcc = 0
local curCurveMin = 0
local curCurveMax = 0
local curPingPong = false

-- enableSwapIfDMGreaterThan: If the player chooses to play a level that exceeds the given difficulty, turn on swap.
function enableSwapIfDMGreaterThan(_DM)
    if (u_getDifficultyMult() > _DM) then
        e_messageAdd("difficulty > " .. _DM .. "\nswap enabled!", 65)
        l_setSwapEnabled(true)
    end
end

-- enableSwapIfSpeedGEThan: If the player reaches a given speed on a level, turn on swap.
function enableSwapIfSpeedGEThan(_speed)
    if (u_getSpeedMultDM() >= _speed and not l_getSwapEnabled()) then
        e_messageAddImportant("Speed >= " .. _speed .. "\nswap enabled!", 120)
        l_setSwapEnabled(true)
    end
end

-- disableIncIfDMGreaterThan: If the player chooses to play a level that exceeds the given difficulty, disable incrementing.
function disableIncIfDMGreaterThan(_DM)
    if (u_getDifficultyMult() > _DM) then
        e_messageAdd("difficulty > " .. _DM .. "\nincrement disabled!", 65)
        l_setIncEnabled(false)
    end
end

-- disableSpeedIncIfDMGreaterThan: If the player chooses to play a level that exceeds the given difficulty, make speed not increase upon incrementing.
function disableSpeedIncIfDMGreaterThan(_DM)
    if (u_getDifficultyMult() > _DM) then
        e_messageAdd("difficulty > " .. _DM .. "\nspeed increment disabled!", 65)
        l_setSpeedInc(0.0)
    end
end

-- cWallBasePrimary: a primary base wall, which one is wall type being used
function cWallBasePrimary(_side, _thickness, ...)
    if (globalWallType == 1) then w_wallAdj(_side, _thickness or THICKNESS, curAdj)
    elseif (globalWallType == 2) then w_wallAcc(_side, _thickness or THICKNESS, curAdj, curAcc, curMinSpd, curMaxSpd)
    elseif (globalWallType == 3) then w_wallHModSpeedData(curHueMod, _side, _thickness or THICKNESS, curAdj, curAcc,
        curMinSpd, curMaxSpd, curPingPong)
    elseif (globalWallType == 4) then w_wallHModCurveData(curHueMod, _side, _thickness or THICKNESS, curCurve,
        curCurveAcc, curCurveMin, curCurveMax, curPingPong)
    else w_wall(_side, _thickness or THICKNESS)
    end
end

-- [LOCAL FUNCTION] cWallBaseSecondary: a secondary base wall, which one is side was imitated into circle or not
local function cWallBaseSecondary(_side, _thickness, ...)
    if (SHAPE_TYPE == 2) then
        local _sideLength = getFakeSideLength(EMULATED_SIDES_AMOUNT);
        for i = 0, _sideLength - 1 do cWallBasePrimary(i + _side * _sideLength, _thickness, ...) end
    else cWallBasePrimary(_side, _thickness, ...)
    end
end

-- cu_setWallBaseSettingsOfWallAdj: replaces an original wall to adjusted wall
function cu_setWallBaseSettingsOfWallAdj(_adj)
    globalWallType = 1;
    curAdj = _adj or 0;
end

-- cu_setWallBaseSettingsOfWallAcc: replaces an original wall to acceleration wall
function cu_setWallBaseSettingsOfWallAcc(_adj, _acc, _minSpd, _maxSpd)
    globalWallType = 2;
    curAdj = _adj or 0;
    curAcc = _acc or 0;
    curMinSpd = _minSpd or 0;
    curMaxSpd = _maxSpd or 0;
end

-- cu_setWallBaseSettingsOfWallAcc: replaces an original wall to speed wall
function cu_setWallBaseSettingsOfWallHModSpeed(_hueMod, _adj, _acc, _minSpd, _maxSpd, _isPingPong)
    globalWallType = 3;
    curHueMod = _hueMod or 0;
    curAdj = _adj or 0;
    curAcc = _acc or 0;
    curMinSpd = _minSpd or 0;
    curMaxSpd = _maxSpd or 0;
    curPingPong = getBooleanNumber(_isPingPong)
end

-- cu_setWallBaseSettingsOfWallAcc: replaces an original wall to curve wall
function cu_setWallBaseSettingsOfWallHModCurve(_hueMod, _curve, _curveAcc, _curveMin, _curveMax, _isPingPong)
    globalWallType = 4;
    curHueMod = _hueMod or 0;
    curCurve = _curve or 0;
    curCurveAcc = _curveAcc or 0;
    curCurveMin = _curveMin or 0;
    curCurveMax = _curveMax or 0;
    curPingPong = getBooleanNumber(_isPingPong)
end

-- cu_resetWallBaseSettings: reset the current wall overriden into an original wall
function cu_resetWallBaseSettings() globalWallType = 0; end

-- cWall: creates a wall with the common THICKNESS or _thickness (optional)
function cWall(_side, _thickness, ...) cWallBaseSecondary(_side, _thickness, ...) end

-- oWall: creates a wall opposite to the _side passed
function oWall(_side, _thickness, ...) cWall(_side + getHalfSides(), _thickness, ...) end

-- rWall: union of cwall and owall (created 2 walls facing each other)
function rWall(_side, _thickness, ...)
    cWall(_side, _thickness, ...)
    oWall(_side, _thickness, ...)
end

-- cWallEx: creates a wall with _extra walls attached to it
function cWallEx(_side, _extra, _thickness, ...)
    _extra = _extra or 0;
    local exLoopDir = _extra > 0 and 1 or -1;
    for i = 0, _extra, exLoopDir do cWall(_side + i, _thickness, ...) end
end

-- oWallEx: creates a wall with _extra walls opposite to _side
function oWallEx(_side, _extra, _thickness, ...)
    cWallEx(_side + getHalfSides(), _extra, _thickness, ...)
end

-- rWallEx: union of cwallex and owallex
function rWallEx(_side, _extra, _thickness, ...)
    cWallEx(_side, _extra, _thickness, ...)
    oWallEx(_side, _extra, _thickness, ...)
end

-- [SHOUTOUTS TO KODIHPER] rWallExFlip: union of cwallex and owallex + flips
function rWallExFlip(_side, _extra, _thickness, ...)
    cWallEx(_side, _extra, _thickness, ...)
    oWallEx(_side, _extra * -1, _thickness, ...)
end

-- cWallExM: same common wall + extra multiplier
function cWallExM(_side, _extra, _extraMult, _thickness, ...)
    _extra = _extra or 0;
    _extraMult = _extraMult or 1;
    local exLoopDir = _extra > 0 and 1 or -1;
    for i = 0, _extra, exLoopDir do cWall(_side + (i * _extraMult), _thickness, ...) end
end

-- oWallExM: (same common wall + opposite to _side) + extra multiplier
function oWallExM(_side, _extra, _extraMult, _thickness, ...)
    cWallExM(_side + getHalfSides(), _extra, _extraMult, _thickness, ...)
end

-- rWallExM: union of cwallexm and owallexm
function rWallExM(_side, _extra, _extraMult, _thickness, ...)
    cWallExM(_side, _extra, _extraMult, _thickness, ...)
    oWallExM(_side, _extra, _extraMult, _thickness, ...)
end

-- [SHOUTOUTS TO KODIHPER] rWallExMFlip: union of cwallexm and owallexm + flips
function rWallExMFlip(_side, _extra, _thickness, ...)
    cWallExM(_side, _extra, _extraMult, _thickness, ...)
    oWallExM(_side, _extra * -1, _extraMult, _thickness, ...)
end

-- cBarrageN: spawns a barrage of walls, with a free _side plus _neighbors
function cBarrageN(_side, _neighbors, _thickness, ...)
    for i = _neighbors, getProtocolSides() - 2 - _neighbors, 1 do
        cWall(_side + i + 1, _thickness, ...)
    end
end

-- [SHOUTOUTS TO KODIHPER] cBarrageNGap: same common function + only wall gap neighbors <<i = i + 1>>
function cBarrageNGap(_side, _neighbors, _thickness, ...)
    local i
    local n = getProtocolSides()

    if _neighbors >= 0 then
        i = 1 + _neighbors
        while i < n do cWall(_side + i, _thickness, ...); i = i + 1 end
    else
        i = 1 - _neighbors
        while i < n do cWall(_side - i, _thickness, ...); i = i + 1 end
    end
end

-- [SHOUTOUTS TO KODIHPER] cBarrageNBlock: same 'cBarrageNGap' function + blocks table
function cBarrageNBlock(_side, _neighbors, _blocksTable, _thickness, ...)
    cBarrageNGap(_side, _neighbors, _thickness, ...)

    local i
    local n = #_blocksTable
    for i = 1, n, 1 do
        cWall(_side + _blocksTable[i], _thickness, ...);
    end
end

-- cBarrage: spawns a barrage of walls, with a single free _side
function cBarrage(_side, _thickness, ...) cBarrageN(_side, 0, _thickness, ...) end

-- cBarrageGap: spawns a barrage of walls with a gap
function cBarrageGap(_side, _gap, _thickness, ...)
    _gap = _gap or 1
    for i = 1, getBarrageSide(_gap), 1 do cWall(_side + i, _thickness, ...) end
end

-- cBarrageOnlyN: spawns a barrage of wall, with only free _neighbors
function cBarrageOnlyN(_side, _neighbors, _thickness, ...)
    cWall(_side, _thickness, ...)
    cBarrageN(_side, _neighbors, _thickness, ...)
end

-- cAltBarrage: spawns a barrage of alternate walls
function cAltBarrage(_side, _step, _thickness, ...)
    _step = _step or 2
    for i = 0, getProtocolSides(), _step do
        cWall(_side + i, _thickness, ...)
    end
end

-- cBarrageAltEx: spawns a alternate wall with _extra walls attached to it.
function cBarrageAltEx(_side, _step, _extra, _thickness, ...)
    _step = _step or 2;
    for spacingWalls = 0, getProtocolSides(), _step do
        cWallEx(_side + spacingWalls, _extra, _thickness, ...);
    end
end

-- cWallTkns: spawns a several thickness wall attached to it.
function cWallTkns(_side, _thick_mult_step, _thick_mult_step_limit, _extra, _step_dir, _thick_mult, _thickness, ...)
    _thick_mult = _thick_mult or THICKNESS * (6 / getProtocolSides());
    _thick_mult_step = _thick_mult_step or 1;
    _step_dir = _step_dir or 1;
    if _extra == nil or _extra < 0 then _extra = 0; end
    if _thick_mult_step_limit == nil or _thick_mult_step_limit < 0 then _thick_mult_step_limit = 0; end

    local thickStep = 0;
    local thickAmount = 1;
    local curThickInc = 0;

    if _step_dir > 0 then
        for amount = 0, _extra, 1 do cWall(_side + amount, (_thickness + curThickInc), ...);
            if amount < _extra - _thick_mult_step_limit then thickStep = thickStep + 1;
                if thickStep >= _thick_mult_step then curThickInc = (thickAmount * _thick_mult);
                thickStep = 0;
                thickAmount = thickAmount + 1;
                end
            end
        end
    else
        for amount = 0, _extra, 1 do cWall(_side - amount + (getProtocolSides() + _extra), (_thickness + curThickInc),
                ...);
            if amount < _extra - _thick_mult_step_limit then thickStep = thickStep + 1;
                if thickStep >= _thick_mult_step then curThickInc = (thickAmount * _thick_mult);
                thickStep = 0;
                thickAmount = thickAmount + 1;
                end
            end
        end
    end
end

-- cWallGrow: spawns a growing wall including _extend walls attached to it, plus the large walls growing at each direction.
function cWallGrow(_side, _extend, _thickness, ...)
    _extend = _extend or 0;
    for largeWallsWidth = -_extend, _extend, 1 do cWall(_side + largeWallsWidth, _thickness, ...); end
end

-- cWallGrowEx: spawns a growing wall with _extra walls attached to it.
function cWallGrowEx(_side, _extend, _extra, _thickness, ...)
    _extend = _extend or 0;
    for largeWallsWidth = -_extend, _extend, 1 do cWallEx(_side + largeWallsWidth, _extra, _thickness, ...); end
end

-- cWallMirror: spawns a mirror wall with specified mirror offsets.
function cWallMirror(_side, _mirror_step, _thickness, ...)
    for spacingWalls = 0, _mirror_step - 1, 1 do cWall(_side +
        math.floor(spacingWalls * (getProtocolSides() / _mirror_step)), _thickness, ...); end
end

-- cWallMirrorEx: spawns a mirror wall with specified mirror offsets with _extra walls attached to it.
function cWallMirrorEx(_side, _mirror_step, _extra, _thickness, ...)
    for spacingWalls = 0, _mirror_step - 1, 1 do cWallEx(_side +
        math.floor(spacingWalls * (getProtocolSides() / _mirror_step)), _extra, _thickness, ...); end
end

-- cWallDraw: spawns a wall, but you can draw everything
function cWallDraw(_side, _wallMin, _wallMax, _thickness, ...)
    for i = _wallMin, _wallMax, 1 do cWall(_side + i, _thickness, ...) end
end

-- cBarrageTkns: same as 'cWallTkns' function + barrage logic
function cBarrageTkns(_side, _thick_mult_step, _thick_mult_step_limit, _gap, _step_dir, _thick_mult, _thickness, ...)
    _thick_mult = _thick_mult or THICKNESS * (6 / getProtocolSides());
    _thick_mult_step = _thick_mult_step or 1;
    _step_dir = _step_dir or 1;
    if _gap == nil or _gap < 1 then _gap = 1; end
    if _thick_mult_step_limit == nil or _thick_mult_step_limit < 0 then _thick_mult_step_limit = 0; end

    local thickStep = 0;
    local thickAmount = 1;
    local curThickInc = 0;

    if _step_dir > 0 then
        for amount = 1, getProtocolSides() - _gap, 1 do cWall(_side + amount, (_thickness + curThickInc), ...);
            if amount < (getProtocolSides() - _gap) - _thick_mult_step_limit then thickStep = thickStep + 1;
                if thickStep >= _thick_mult_step then curThickInc = (thickAmount * _thick_mult);
                thickStep = 0;
                thickAmount = thickAmount + 1;
                end
            end
        end
    else
        for amount = 1, getProtocolSides() - _gap, 1 do cWall(_side - amount + ((getProtocolSides() - _gap) + 1),
                (_thickness + curThickInc), ...);
            if amount < (getProtocolSides() - _gap) - _thick_mult_step_limit then thickStep = thickStep + 1;
                if thickStep >= _thick_mult_step then curThickInc = (thickAmount * _thick_mult);
                thickStep = 0;
                thickAmount = thickAmount + 1;
                end
            end
        end
    end
end

-- cBarrageVorta: spawns a vorta/vortex wall that every sides will work properly.
function cBarrageVorta(_side, _free, _thickness, ...)
    _free = _free or 0;
    for largeWallsWidth_001 = 0, math.ceil(getProtocolSides() * 0.5 - 2) - _free, 1 do cWall(_side + largeWallsWidth_001
        , _thickness, ...); end
    for largeWallsWidth_002 = 0, math.floor(getProtocolSides() * 0.5 - 2) - _free, 1 do cWall(_side + getPolySides(2) +
        largeWallsWidth_002, _thickness, ...); end
end

-- cBarrageHalf: spawns a half-barrage wall.
function cBarrageHalf(_side, _thickness, ...)
    for largeWallsWidth = 0, getPolySides(2) - 1, 1 do cWall(_side + largeWallsWidth, _thickness, ...); end
end

-- cBarrageDoubleHoled: spawns a double-holed barrage wall that every sides will work properly.
function cBarrageDoubleHoled(_side, _2nd_hole_offset, _hole_free, _thickness, ...)
    _2nd_hole_offset = _2nd_hole_offset or 0;
    _hole_free = _hole_free or 0;
    for largeWallsWidth_001 = _2nd_hole_offset + 2 + _hole_free, getProtocolSides() - 2 - _hole_free, 1 do cWall(_side +
        largeWallsWidth_001, _thickness, ...); end
    for largeWallsWidth_002 = 0, _2nd_hole_offset, 1 do cWall(_side + largeWallsWidth_002, _thickness, ...); end
end

-- cBarrageExHoles: spawns a holed barrage wall with extra holes attached to it.
function cBarrageExHoles(_side, _extra_holes, _thickness, ...)
    _extra_holes = closeValue((_extra_holes or 0), 0, math.floor(getProtocolSides() / 2))
    for barrageWalls = _extra_holes * 2, getProtocolSides() - 2, 1 do cWall(_side + barrageWalls, _thickness, ...); end
    for shiftWalls = 0, math.floor(getProtocolSides() / 2) - 1, 1 do cWall(_side + (shiftWalls * 2), _thickness, ...); end
end

-- cSwapBarrageN: A barrage with _neighbors to have an opening pocket, forcing the players to go into the pocket and swap.
function cSwapBarrageN(_side, _neighbors, _delMult, _isSpdMode, _thickness, ...)
    _delMult = _delMult or 1
    _neighbors = _neighbors or 1
    _isSpdMode = _isSpdMode or true
    _thickness = _thickness or THICKNESS
    cBarrageN(_side, _neighbors, _thickness, ...)
    cWall(_side + _neighbors, customizePatternThickness(2.5 * _delMult, _isSpdMode) + (_thickness / 2))
    cWall(_side - _neighbors, customizePatternThickness(2.5 * _delMult, _isSpdMode) + (_thickness / 2))
    t_wait(customizePatternDelay(2.5 * _delMult))
    for i = -_neighbors, _neighbors, 1 do cWall(_side + i, _thickness, ...) end
end

-- cSwapBarrage: A barrage, but the opening is instead a pocket that is fully enclosed, forcing the player to swap to escape the pocket.
function cSwapBarrage(_side, _delMult, _isSpdMode, _thickness, ...)
    _delMult = _delMult or 1
    _isSpdMode = _isSpdMode or true
    _thickness = _thickness or THICKNESS
    cBarrageN(_side, 1, _thickness, ...)
    cWall(_side + 1, customizePatternThickness(2.5 * _delMult, _isSpdMode) + (_thickness / 2))
    cWall(_side - 1, customizePatternThickness(2.5 * _delMult, _isSpdMode) + (_thickness / 2))
    t_wait(customizePatternDelay(2.5 * _delMult))
    for i = -1, 1, 1 do cWall(_side + i, _thickness, ...) end
end

-- cSwapCorridor: A barrage, but the neighbors of the opening have elongated thicknesses
function cSwapCorridor(_side, _isEnding, _delMult, _isSpdMode, _thickness, ...)
    _isEnding = _isEnding or 0
    _delMult = _delMult or 1
    _isSpdMode = _isSpdMode or true
    _thickness = _thickness or THICKNESS
    cBarrageN(_side, 1, _thickness, ...)
    cWall(_side + 1, customizePatternThickness(4 * _delMult, _isSpdMode) + (_thickness / 2))
    cWall(_side - 1, customizePatternThickness(4 * _delMult, _isSpdMode) + (_thickness / 2))
    t_wait(customizePatternDelay(4 * _delMult))
    if getBooleanNumber(_isEnding) then for i = -1, 1, 1 do cWall(_side + i, _thickness, ...) end end
end

---------------------------------------------------------------------------------------- END OF COMMON UTILS

-- randomArray: randomizes the array
function randomArray(_number, _lower, _upper)
    local a = {}
    for k = 1, _number, 1 do a[k] = u_rndInt(_lower, _upper) end
    return a
end

-- cycleSide: cycles side of array
function cycleSide(_sides, _sidePosInput)
    local eArray = {}
    local j = _sidePosInput or getRandomSide()
    for i = 1, _sides, 1 do eArray[i] = (i + j) % _sides + 1 end
    return eArray
end

---------------------------------------------------------------------------------------- END OF ALTERNATIVE UTILS

-- getPerfectAccelDM: returns a constant that is used to perfectly adjust wallAcc acceleration to speed and difficulty multiplier
function getPerfectAccelDM()
    local requiredDecel = (u_getSpeedMultDM() ^ 2.02);
    local diffAdjust = (u_getDifficultyMult() ^ 0.65);
    if (u_getDifficultyMult() < 1) then
        if (u_getDifficultyMult() < 0.5) then
            diffAdjust = 1.2 *
                (0.256289 * math.sin(u_getDifficultyMult()) - 36.5669 * math.cos(u_getDifficultyMult()) + 36.5674);
        else
            diffAdjust = 1 - (-2 * u_getDifficultyMult() + 2) ^ 2 / 2.7;
        end
    end
    return diffAdjust * requiredDecel * ((1600 / (l_getWallSpawnDistance() or 1600)) ^ 1.225)
end

local wallAccelType = 0

-- [LOCAL FUNCTION] wallAccBase: a base wall acc, which one is side was imitated into circle
local function wallAccBase(_hueMod, _side, _adj, _acc, _minSpd, _maxSpd, _isPingPong, _thickness, ...)
    if (SHAPE_TYPE == 2) then
        local _sideLength = getFakeSideLength(EMULATED_SIDES_AMOUNT);
        for i = 0, _sideLength - 1 do
            if (wallAccelType == 1) then w_wallAcc(i + _side * _sideLength, _thickness or THICKNESS, _adj, _acc, _minSpd
                , _maxSpd)
            elseif (wallAccelType == 2) then w_wallHModSpeedData(_hueMod, i + _side * _sideLength,
                _thickness or THICKNESS, _adj, _acc, _minSpd, _maxSpd, _isPingPong)
            else w_wallAdj(i + _side * _sideLength, _thickness or THICKNESS, _adj)
            end
        end
    else
        if (wallAccelType == 1) then w_wallAcc(_side, _thickness or THICKNESS, _adj, _acc, _minSpd, _maxSpd)
        elseif (wallAccelType == 2) then w_wallHModSpeedData(_hueMod, _side, _thickness or THICKNESS, _adj, _acc, _minSpd
            , _maxSpd, _isPingPong)
        else w_wallAdj(_side, _thickness or THICKNESS, _adj)
        end
    end
end

-- wallSAdj: returns a wall with common _thickness or THICKNESS and multiplies the speed by _adj
function wallSAdj(_side, _adj, _thickness, ...)
    wallAccelType = 0;
    local speedMult = u_getSpeedMultDM()
    wallAccBase(false, _side, _adj * speedMult, 0, 0, 0, false, _thickness, ...)
end

-- wallSAcc: returns a wallAcc perfectly adjusted to speed and difficulty multiplier
function wallSAcc(_side, _adj, _acc, _minSpd, _maxSpd, _thickness, ...)
    wallAccelType = 1;
    local speedMult, adjust = u_getSpeedMultDM(), getPerfectAccelDM()
    wallAccBase(false, _side, _adj * speedMult, _acc * adjust, _minSpd, _maxSpd, false, _thickness, ...)
end

-- wallSHAcc: Creates a wallHModSpeedData adjusted the perfect acceleration adjustment (for OH v2+ only)
function wallSHAcc(_hueMod, _side, _adj, _acc, _minSpd, _maxSpd, _isPingPong, _thickness, ...)
    wallAccelType = 2;
    local speedMult, adjust = u_getSpeedMultDM(), getPerfectAccelDM()
    wallAccBase(_hueMod, _side, _adj * speedMult, _acc * adjust, _minSpd, _maxSpd, _isPingPong, _thickness, ...)
end

---------------------------------------------------------------------------------------- END OF NEXT UTILS

--[[ !!! - OH v2+ are required of this function, otherwise doesn't work ]] --

globalHueModifier = 0.2 -- constant used to shift the color offset work with the style's hue
local rotSpdSync = false -- constant used to sync curving walls with that rotation speed
local spdSyncRndMin = 0 -- minimum random displacement from the synced speed
local spdSyncRndMax = 0 -- maximum random displacement from the synced speed

-- constant used to multiply the global curve speed of curving walls, incuding 2 constants type
local normalCurveMult = 1

local function wallSpawnDistanceFix()
    return (1600 / (l_getWallSpawnDistance() or 1600))
end

-- syncCurveToSideDistance: Returns an appropriate constant that, if applied to a curving wall travelling at constant speed, will cause it go one full side.
function syncCurveToSideDistance()
    return (0.2 * u_getSpeedMultDM() + 0.005) * (6 / getProtocolSides()) * wallSpawnDistanceFix() *
        (u_getDifficultyMult() ^ -0.25);
end

-- getPerfectCurveDecel: Returns a constant that, if applied to a curving wall, will make the wall stop accelerating on a side panel.
function getPerfectCurveDecel()
    -- Coordinates tested: (0, 0), (1, .134), (1.5, .295), (2, .52), (2.5, .81), (3, 1.162), (3.5, 1.579), (4, 2.06)
    -- Cubic Formula (full accuracy): 0.000233918 x^3 + 0.125985 x^2 + 0.00730493 x + 0.0000701754
    -- Current formula has ~100% accuracy
    return (0.127378 * u_getSpeedMultDM() ^ 2 + 0.00526331 * u_getSpeedMultDM() + 0.000431373) * (6 / getProtocolSides()
        ) * wallSpawnDistanceFix();
end

-- syncCurveWithRotationSpeed: the function to call when wanting to sync curving walls with the rotation speed
-- _rnd_min (OPTIONAL): set the spdSyncRndMin const to this value
-- _rnd_max (OPTIONAL): set the spdSyncRndMax const to this value
function syncCurveWithRotationSpeed(_rnd_min, _rnd_max)
    rotSpdSync = true
    spdSyncRndMin = _rnd_min or 0
end

-- revertSyncCurveWithRotationSpeed: the function to call reverting to sync curving walls with the rotation speed
function revertSyncCurveWithRotationSpeed()
    rotSpdSync = false
    spdSyncRndMin = 0
end

-- setCurveMult: the function to call when wanting to alter [type_name]CurveMult constant
-- _normal_curve_mult: sets the normalCurveMult const to this value
-- _synced_curve_mult: sets the syncedCurveMult const to this value
function setCurveMult(_normal_curve_mult)
    if type(_normal_curve_mult) == "number" then normalCurveMult = _normal_curve_mult end
end

-- [LOCAL FUNCTION] wallHMCurveBase: a base hue modifier wall curve, which one is side was imitated into circle
local function wallHMCurveBase(_hueMod, _side, _adj, _acc, _minSpd, _maxSpd, _isPingPong, _thickness, ...)
    if (SHAPE_TYPE == 2) then
        local _sideLength = getFakeSideLength(EMULATED_SIDES_AMOUNT);
        for i = 0, _sideLength - 1 do w_wallHModCurveData(_hueMod, i + _side * _sideLength, _thickness or THICKNESS, _adj
            , _acc, _minSpd, _maxSpd, _isPingPong) end
    else w_wallHModCurveData(_hueMod, _side, _thickness or THICKNESS, _adj, _acc, _minSpd, _maxSpd, _isPingPong)
    end
end

-- wallHMCurveAcc: creates a curving wall adhering to the constants presented by this script
-- _side: the side to spawn the curving wall on
-- _curve: the curving speed the wall will travel at
-- _curveAcc: how much acceleration to apply to the curving wall
-- _curveMin: the lowest curving speed the wall is allowed to go
-- _curveMax: the highest curving speed the wall is allowed to go
-- _curvePingPong: if accelerated to _curveMin or _curveMax, should the acceleration switch directions and go the other way?
-- _thickness (OPTIONAL): the thickness of the curving wall
function wallHMCurveAcc(_side, _curve, _curveAcc, _curveMin, _curveMax, _curvePingPong, _thickness, ...)
    _thickness = _thickness or THICKNESS
    if rotSpdSync == true then
        _curve = l_getRotationSpeed() * (10.0 / syncCurveToSideDistance())
        _curve = _curve + (u_rndInt(syncRndMin, syncRndMax) / 100.0)
    end
    wallHMCurveBase(globalHueModifier, _side,
        _curve * (u_getDifficultyMult() ^ 0.25) * normalCurveMult * syncCurveToSideDistance(), _curveAcc, _curveMin,
        _curveMax, _curvePingPong, _thickness, ...)
end

-- wallHMCurve: a simplication of wallHMCurve, only allowing customization of the curve speed
-- _side: the side to spawn the curving wall on
-- _curve: the curving speed the wall will travel at
-- _thickness (OPTIONAL): the thickness of the curving wall
function wallHMCurve(_side, _curve, _thickness, ...)
    _thickness = _thickness or THICKNESS
    wallHMCurveAcc(_side, _curve, 0, 0, 0, false, _thickness, ...)
end

-- wallHMStop: a preset of wallHMCurveAcc where getPerfectCurveDecel is used to spawn a wall to stop acceleration on a side panel
-- _side: the side that the wall will stop on
-- _offset: how much offset from the _side the wall will have when spawned. a higher offset will make a faster wall
-- _thickness (OPTIONAL): the thickness of the curving wall
function wallHMStop(_side, _offset, _thickness, ...)
    _thickness = _thickness or THICKNESS
    local curveAcc = getPerfectCurveDecel() * wallSpawnDistanceFix();
    if (getNeg(_offset) < 0) then
        wallHMCurveAcc(_side + _offset, 2 * -_offset, curveAcc * _offset / 100, 0, 2 * -_offset, false, _thickness, ...);
    else
        wallHMCurveAcc(_side + _offset, -2 * _offset, curveAcc * _offset / 100, -2 * _offset, 0, false, _thickness, ...);
    end
end

-- ▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
--                                 BEGINNING OF HMC FUNCTIONS (Hue Modified Common)
-- ▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼

-- hmcBarrageN: a barrage with additional adjacent _neighbors that composed of curving walls
-- _side: the side to spawn the curving wall on
-- _neighbors: the expansion of the barrage opening by this adjacent neighbors
-- _curve: the curving speed the wall will travel at
-- _curveAcc: how much acceleration to apply to the curving wall
-- _curveMin: the lowest curving speed the wall is allowed to go
-- _curveMax: the highest curving speed the wall is allowed to go
-- _curvePingPong: if accelerated to _curveMin or _curveMax, should the acceleration switch directions and go the other way?
-- _thickness (OPTIONAL): the thickness of the curving wall
function hmcBarrageN(_side, _neighbors, _curve, _curveAcc, _curveMin, _curveMax, _curvePingPong, _thickness, ...)
    for i = _neighbors, getProtocolSides() - 2 - _neighbors, 1 do
        wallHMCurveAcc(_side + i + 1, _curve, _curveAcc, _curveMin, _curveMax, _curvePingPong, _thickness, ...)
    end
end

-- hmcBarrageS: hmcBarrageN, but the are no additional neighbors, and the gap is only 1 side wide
function hmcBarrageS(_side, _curve, _curveAcc, _curveMin, _curveMax, _curvePingPong, _thickness, ...)
    hmcBarrageN(_side, 0, _curve, _curveAcc, _curveMin, _curveMax, _curvePingPong, _thickness, ...);
end

-- hmcBarrage: hmcBarrageS, but the side is chosen at random for you
function hmcBarrage(_curve, _curveAcc, _curveMin, _curveMax, _curvePingPong, _thickness, ...)
    hmcBarrageS(getRandomSide(), _curve, _curveAcc, _curveMin, _curveMax, _curvePingPong, _thickness, ...);
end

-- hmcBarrageStop: a barrage that comes to a full stop, similiar to how wallHMStop works
function hmcBarrageStop(_side, _offset, _neighbors, _thickness, ...)
    _neighbors = _neighbors or 0
    local curveAcc = getPerfectCurveDecel() * wallSpawnDistanceFix();
    if (getNeg(_offset) < 0) then
        hmcBarrageN(_side + _offset, _neighbors, 2 * -_offset, curveAcc * _offset / 100, 0, 2 * -_offset, false,
            _thickness, ...);
    else
        hmcBarrageN(_side + _offset, _neighbors, -2 * _offset, curveAcc * _offset / 100, -2 * _offset, 0, false,
            _thickness, ...);
    end
end

-- hmcSimpleBarrage: a simple curving barrage.
-- _side (OPTIONAL, BUT HIGHLY RECOMMENDED): the side the barrage starts at
-- _curve (OPTIONAL): the constant curving speed the barrage will travel
-- _neighbors (OPTIONAL): the expansion of the barrage opening by this many adjacent neighbors
-- _thickness (OPTIONAL): the thickness of the curving wall
function hmcSimpleBarrage(_side, _curve, _neighbors, _thickness, ...)
    hmcBarrageN(_side or 0, _neighbors or 0, _curve or 0, 0, 0, 0, false, _thickness, ...);
end

-- compatibility mappings for legacy funcs that did the same thing ;_;
hmcSimpleBarrageS = hmcSimpleBarrage
hmcSimpleBarrageSNeigh = hmcSimpleBarrage
