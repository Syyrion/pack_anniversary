u_execScript('bit.lua')

local STEAM_WORKSHOP_PATH = "../../workshop/content/1358090/2875237264/Scripts/"
-- Replace "pack_anniversary" with your local folder name.
local LOCAL_PATH = "Packs/pack_anniversary/Scripts/"

Reader = {}
Reader.__index = Reader

function Reader:open(filename)
    local newInst = setmetatable({
        f = io.open(STEAM_WORKSHOP_PATH .. filename, 'rb') or io.open(LOCAL_PATH .. filename, 'rb')
    }, self)
    if not newInst.f then
        e_messageAddImportantSilent("Level files not found", 10)
        e_stopTimeS(10)
        e_kill()
        return nil
    end
    return newInst
end

function Reader:read(...) return self.f:read(...) end

function Reader:seek(...) self.f:seek(...) end

function Reader:close() self.f:close() end

-- Reads a number of bytes as an int in little endian order
-- Returns nil if not all bytes could be read
function Reader:readInt(bytes)
    bytes = type(bytes) == 'number' and math.floor(clamp(bytes, 1, 4)) or 1
    local buffer = 0
    for i = 0, bytes - 1 do
        local byte = self:read(1)
        if not byte then return nil end
        buffer = OR(buffer, SL(string.byte(byte), i * 8))
    end
    return buffer
end

-- Reads the next 3 bytes and returns them as an RGB color
function Reader:readColor(alpha)
    if alpha then return self:readInt(), self:readInt(), self:readInt(), self:readInt() end
    return self:readInt(), self:readInt(), self:readInt()
end
