--[========[   ---   ACCELERATING WALLS - HELPER SCRIPT   ---   ]========]--
--                      ----[[  VERSION: 1.1  ]]----                      --
-- A few functions to help you place your wallAcc exactly where you want. --
--	                                                                      --
--  Written by Oshisaure. Credit not necessary, but highly appreciated ♥  --
--[======================================================================]--

----------------------------------------------------------------------------
--[[
If the Open Hexagon 2 functions are not defined, make them be the 1.92 ones.
That means you can use this script in both 2.0 and 1.92 versions of the game!
]]
w_wallAcc = w_wallAcc or wallAcc
l_getSpeedMult = l_getSpeedMult or getSpeedMult
l_getSides = l_getSides or getSides
----------------------------------------------------------------------------

--[[
execute included <reader.lua>, Reader:open() is avail right there.
]]
u_execScript('reader.lua')

--[[
wallDist: main function, allows you to place a wall at a certain distance
    from the center of the center of the level.

side: side of the wall to spawn.
thickness: thickness of the wall to spawn.
speedmult: starting speed of the wall, working like regular wallAcc.
    Also affects time taken by the wall to reach its stopping distance.
dist: distance travelled by the wall before its speed reaches 0.
minspeed: ending speed of the wall, working like regular wallAcc.
]]
function wallDist(side, thickness, speedmult, dist, minspeed)
    w_wallAcc(side, thickness, speedmult / l_getSpeedMult(), -1 / 60 * (speedmult / l_getSpeedMult()) ^ 2 / dist,
        minspeed / l_getSpeedMult(), speedmult / l_getSpeedMult())
end

--[[
wallFromPCoord: from a table of polar coordinates, allows you to place walls
    to form a shape stopping at a certain distance form the center

tablecoords: a table of tables containing the polar coordinates of the
    walls: tablecoords = {{distance, angle}, {distance2, angle2}, ...}
thickness, speedmult, minspeed: same as above.
offset: what side you wish 0° to be.
scale: stretches (if greater than 1), squishes (if lower than 1), or even
    flips (if negative) the pattern made by your coordinates.
origin: a linear offset applied to every wall. Should be
    set so (0,0) is the center of the level.
]]
function wallFromPCoord(tablecoords, thickness, speedmult, minspeed, offset, scale, origin)
    for n, coords in ipairs(tablecoords) do
        local dist, ang = unpack(coords)
        wallDist(offset - math.floor(l_getSides() * (ang) / 360), thickness, speedmult, origin - dist * scale, minspeed)
    end
end

----------------------------------------------------------------------------
--[[
XYtoP: convert a table of points {{x1, y1}, {x2, y2}, ...} into a table of
    the same points, except in polar coordinates.
]]
function XYtoP(XYcoords)
    local polar = {}
    for _, XY in ipairs(XYcoords) do
        local x, y = unpack(XY)
        table.insert(polar, { (x ^ 2 + y ^ 2) ^ 0.5, math.atan2(y, x) * 180 / math.pi })
    end
    return polar
end

--[[
wallFromXYCoord: same as wallFromPCoord, except the coordinates of the
    points are in X/Y instead of polar.
]]
function wallFromXYCoord(tablecoords, thickness, speedmult, minspeed, offset, scale, origin)
    wallFromPCoord(XYtoP(tablecoords), thickness, speedmult, minspeed, offset, scale, origin)
end

----------------------------------------------------------------------------
--[[
loadBMPPicture: loads a 24 bits per pixel bitmap file and returns a table
    containing a list of X/Y coordinates for every black pixel in the
    picture. Note that any other color than black will be ignored.
    NB: 24 bits per pixel ONLY, or else you'll get... weird results, if any.

path: path of the image to load, from the Open Hexagon folder.
xos, yos: the X/Y offset of the center of the resulting pattern, 1 being
    half the width (xos) or the height (yos) of the picture.
]]
function loadBMPPicture(path, xos, yos)
    local input, reason = Reader:open(path)
    if not input then
        print("can't open BMP picture:\n" .. (reason or ""))
        return {} -- return a empty table if the level files couldn't be found
    else
        -- helper function to read a byte as number and not as ASCII
        local function readHex(bytes)
            local result = 0
            for i = 0, bytes - 1 do
                result = result + (256 ^ i) * string.byte(input:read(1))
            end
            return result
        end

        input:seek("set", 0x0A)
        -- get where the image starts
        local offset = readHex(2)
        local width, height
        input:seek("set", 0x12)
        width = readHex(4)
        height = readHex(4)
        --u_log("offset: "..offset)
        --u_log("size: "..width.."x"..height)

        -- decode the pixel grid
        input:seek("set", offset)
        local grid = {}
        local rowsize = math.floor((24 * width + 31) / 32) * 4
        for y = 0, height - 1 do
            for x = 0, width - 1 do
                pixel = readHex(3)
                if pixel == 0 then
                    table.insert(grid, { (x - width / 2) * width / height + xos * width / 2, y - height / 2 + yos * height / 2 })
                elseif pixel <= 0xff then
                    for i = 1, pixel do
                        table.insert(grid, { (x - width / 2) * width / height + xos * width / 2, y - height / 2 + yos * height / 2 })
                    end
                end
            end
            if width % 4 ~= 0 then readHex(width % 4) end
        end
        input:close()
        return grid
    end
end

--[[
wallFromPicture: draw your pattern, export it as 24bpp bitmap, and you get
    it in the game.
    NB: Loading an entire picture may take some time, so storing the
    coordinates of the points to reuse them later may avoid a freeze every
    time the function is called.

picpath, Xoffset, Yoffset: see path, xos, yos in loadBMPPicture above.
thickness, speedmult, minspeed, offset, scale, origin: see in wallFromPCoord
]]
function wallFromPicture(picpath, Xoffset, Yoffset, thickness, speedmult, minspeed, offset, scale, origin)
    wallFromXYCoord(loadBMPPicture(picpath, Xoffset, Yoffset), thickness, speedmult, minspeed, offset, scale, origin)
end
