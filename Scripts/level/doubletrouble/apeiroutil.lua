u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "alternativepatterns.lua")

-- Adds string formatting to ct_eval and prevents crashing from runtime errors
local ct_eval_unsafe = ct_eval
function ct_eval(handle, string, ...)
    ct_eval_unsafe(handle, ("xpcall(function() " .. string .. " end,print)"):format(...))
end

local e_eval_unsafe = e_eval
function e_eval(string, ...)
    e_eval_unsafe(("xpcall(function() " .. string .. " end,print)"):format(...))
end

-- Checks if a number is between 2 numbers regardless of the order of the numbers
function isBetween(number, bound1, bound2)
    return (number - bound1) * (number - bound2) <= 0
end

-- Like fromHSV but with saturation and value combined to 1 argument
function shaderColor(hue, alpha, range)
    alpha, range = clamp(alpha, 0, 1), range or 1
    local r, g, b = fromHSV(hue, math.min(1, 2 - 2 * alpha), math.min(1, 2 * alpha))
    return r * range / 255, g * range / 255, b * range / 255
end

-- Creates coordinates for a wall
-- Also can be used as an all-in-one function for polar math
function getWallCoords(ang, rad, skw, off, posX, posY)
    local rad, skw, off, posX, posY = rad or 1, skw or 1, off or 0, posX or 0, posY or 0
    return posX + rad * math.cos(ang) + off * math.cos(ang - math.pi / 2),
        posY + (rad * math.sin(ang) + off * math.sin(ang - math.pi / 2)) / skw
end

-- Iterates through a numeric table backwards
-- Useful for using table.remove without skipping indices
function bipairs(obj)
    return function(t, i)
        i = i - 1
        if i > 0 then return i, t[i] end
    end, obj, #obj + 1
end

-- Iterates through a table recursively
-- Usage: for value,keys... in reiter(object),iterator do
function reiter(obj)
    return coroutine.wrap(function(iterator)
        local function iterate(t, ...)
            local keys = { ... }
            local level = #keys + 1
            for k, v in iterator(t) do
                if type(v) == "table" then iterate(v, unpack(keys))
                else coroutine.yield(v, unpack(keys)) end
            end
        end

        iterate(obj)
    end)
end

-- Unpacks a table recursively
-- An optional 2nd argument can be used to determine which iterator to use when unpacking
function reunpack(obj, iterator)
    local values = {}
    for v in reiter(obj), iterator or ipairs do
        table.insert(values, v)
    end
    return unpack(values)
end
