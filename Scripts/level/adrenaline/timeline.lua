PARAMS = { 'f', 's', 'o' }

Timeline = {}
Timeline.__index = Timeline

function Timeline:new(timings, offset)
    offset = offset or 1
	local newInst = setmetatable({
		timings = timings or error('Timings are required', 2),
        position = Incrementer:new(offset, #timings - 1, #timings - offset - 1)
	}, self)
	return newInst
end

function Timeline:reset()
	self.position:restart()
end

function Timeline:getPosition()
    return self.position:get()
end

function Timeline:getData(index)
    index = index or self:getPosition()
    return self.timings[index]
end

function Timeline:getTime(index)
    index = index or self:getPosition()
    local data = self:getData(index)
	if data == nil then
		print(index, #self.timings)
		u_kill()
	end
    return data[1] or data['t']
end

function Timeline:getPattern(index)
    index = index or self:getPosition()
    return self:getData(index)['p']
end

function Timeline:getParams(index)
	index = index or self:getPosition()
	local params = nil
	for k, v in ipairs(PARAMS) do
		local data = self:getData(index)[v]
		if data ~= nil then
			if params == nil then params = {} end
			params[v] = data
		end
	end
	return params
end

function Timeline:advance(time)
    local value = self:getTime()
    if (time >= value) then
        self.position:increment()
        return true
    else
        return false
    end
end

TIMELINE = {
	[1] = {
		{
			['t'] = 0.000,
			['p'] = { "cWallEx", { 3 } }
		},
		{ 0.200 },
		{ 0.400 },
		{ 0.600 },
		{
			['t'] = 0.800,
			['p'] = { "cWallEx", { 4 } }
		},
		{
			['t'] = 1.200,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 1.600,
			['p'] = { "cWallEx", { 5 } }
		},
		{
			['t'] = 1.900,
			['p'] = { "cWallEx", { 3 } }
		},
		{ -- not consistent?!
			['t'] = 2.200,
			['p'] = { "Alt Barrage Ex", {} },
			['o'] = 1,
		},
		{
			['t'] = 2.400,
			['p'] = { "Alt Barrage Ex", {} },
			['o'] = 2
		},
		{ 2.500 },
		{ 2.600 },
		{
			['t'] = 2.900,
			['p'] = { "cWallEx", { 4 } },
			['o'] = 0
		},
		{
			['t'] = 3.200,
			['p'] = { "cWallEx", { 5 } }
		},
		{
			['t'] = 3.500,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 3.800,
			['f'] = true,
			['p'] = { "Tunnel", { "dif+", 1 } }
		},
		{ 4.400 },
		{
			['t'] = 4.800,
			['f'] = false,
			['p'] = { "cWallEx", { 5 } }
		},
		{
			['t'] = 5.100,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 5.400,
			['p'] = { "Mirror Spiral", { Note.THIRTYSECOND, 6 } }
		},
		{
			['t'] = 6.200,
			['f'] = true,
			['p'] = { "Swap Barrage", { "dif+", 5 } }
		},
		{ 6.400 },
		{
			['t'] = 6.800,
			['f'] = false,
			['p'] = { "cWallEx", { 4 } }
		},
		{ 7.200 },
		{
			['t'] = 7.600,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 8.000,
			['p'] = { "cWallEx", { 5 } }
		},
		{
			['t'] = 8.300,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 8.600,
			['f'] = true,
			['p'] = { "Swap Barrage", { "dif+", 5 } }
		},
		{ 8.800 },
		{
			['t'] = 9.300,
			['f'] = false,
			['p'] = { "cWallEx", { 4 } }
		},
		{
			['t'] = 9.600,
			['p'] = { "cWallEx", { 5 } }
		},
		{
			['t'] = 9.900,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 10.200,
			['f'] = true,
			['p'] = { "Swap Barrage", { "dif+", 5 } }
		},
		{ 10.400 },
		{
			['t'] = 10.800,
			['f'] = false,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 11.200,
			['p'] = { "cWallEx", { 5 } }
		},
		{
			['t'] = 11.500,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 11.800,
			['f'] = true,
			['p'] = { "Swap Barrage", { "dif+", 5 } }
		},
		{ 12.000 },
		{
			['t'] = 12.400,
			['f'] = false,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 12.800,
			['p'] = { "cWallEx", { 5 } }
		},
		{
			['t'] = 13.100,
			['p'] = { "cWallEx", { 3 } }
		},
		{
			['t'] = 13.400,
			['f'] = true,
			['p'] = { "Swap Barrage", { "dif+", 5 } }
		},
		{ 13.600 },
		{
			['t'] = 14.400,
			['f'] = false,
			['p'] = { "cWallEx", { 5 } }
		},
		{
			['t'] = 14.800,
			['p'] = { "cWallEx", { 3 } },
			['o'] = u_rndInt(1, l_getSides())
		},
		{
			['t'] = 15.100,
			['o'] = { '+', (l_getSides() / 2) }
		},
		{ 15.400 },
		{ 15.700 },
		{
			['t'] = 16.000,
			['s'] = 2,
			['p'] = { "Tunnel Straight", { "dif+", 2 } },
			['o'] = 0
		},
		{ 16.400 },
		{ 16.800 },
		{
			['t'] = 17.000,
			['f'] = true,
			['s'] = 0,
			['p'] = { "Death Barrage", { "dif+", 4 } }
		},
		{ 17.300 },
		{ 17.600 },
		{ 17.900 },
		{ 18.200 },
		{
			['t'] = 18.400,
			['f'] = false,
			['p'] = { "Alt Barrage Ex", { "dif+" } }
		},
		{
			['t'] = 18.600,
			['f'] = true,
			['p'] = { "Death Barrage", { "dif+", 4 } }
		},
		{ 18.900 },
		{ 19.200 },
		{ 19.500 },
		{ 19.800 },
		{
			['t'] = 20.000,
			['f'] = false,
			['p'] = { "Alt Barrage Ex", { "dif+" } }
		},
		{
			['t'] = 20.200,
			['p'] = { "rWallEx", { 1 } },
			['o'] = u_rndInt(1, l_getSides())
		},
		{ 20.300 },
		{ 20.400 },
		{ 20.500 },
		{ 20.600 },
		{
			['t'] = 20.800,
			['p'] = { "cWallEx", { 5 } },
			['o'] = { "+", 1 }
		},
		{ 21.200 },
		{ 21.500 },
		{ 21.800 },
		{
			['t'] = 22.100,
			['o'] = { "-", 1 }
		},
		{ 22.400 },
		{ 22.700 },
		{
			['t'] = 23.200,
			['s'] = 2,
			['p'] = { "Alt Barrage Ex Death", { Note.HALF } },
			['o'] = 0
		},
		{ 23.200 },
		{ 24.800 },
		{
			['t'] = 25.600,
			['s'] = 0,
			['p'] = { "Alt Barrage Ex", {} },
			['o'] = 2
		},
		{ 25.700 },
		{
			['t'] = 25.900,
			['o'] = 1
		},
		{ 26.000 },
		{
			['t'] = 26.200,
			['o'] = 2
		},
		{ 26.300 },
		{
			['t'] = 26.400,
			['p'] = { "Mirror Spiral", { Note.THIRTYSECOND, 6 } },
			['o'] = 1
		},
		{
			['t'] = 27.200,
			['p'] = { "Alt Barrage Ex", {} },
			['o'] = 0
		},
		{
			['t'] = 27.400,
			['s'] = 1,
			['p'] = { "cWallEx Random", { "dif+", 2 } }
		},
		{ 27.500 },
		{ 27.700 },
		{ 27.800 },
		{
			['t'] = 28.000,
			['s'] = 2,
			['p'] = { "cWallEx Random", { "dif+", 3 } }
		},
		{ 28.100 },
		{ 28.200 },
		{
			['t'] = 28.400,
			['s'] = 1,
			['p'] = { "cWallEx Random", { "dif+", 2 } }
		},
		{ 28.500 },
		{ 28.700 },
		{ 28.800 },
		{ 29.000 },
		{ 29.100 },
		{
			['t'] = 29.300,
			['s'] = 3,
			['p'] = { "cWallEx Random", { "dif+", 2 } }
		},
		{ 29.400 },
		{ 29.500 },
		{
			['t'] = 29.600,
			['f'] = true,
			['s'] = 0,
			['p'] = { "Tunnel Straight", { "dif+", 2 } }
		},
		{ 30.000 },
		{ 30.400 },
		{
			['t'] = 30.600,
			['f'] = false,
			['p'] = { "cWallEx", { 4 } },
			['o'] = u_rndInt(1, l_getSides())
		},
		{
			['t'] = 30.700,
			['o'] = { '+', 1 }
		},
		{ 30.800 },
		{ 30.900 },
		{ 31.000 },
		{
			['t'] = 31.300,
			['p'] = { "rWallEx", { 2 } },
			['o'] = u_rndInt(1, l_getSides())
		},
		{
			['t'] = 31.600,
			['p'] = { "cWallEx Death", { 4 } },
			['o'] = { '+', 1 }
		},
		{ 31.700 },
		{ 31.800 },
		{ 31.900 },
		{ 32.000 },
		{ 32.100 },
		{
			['t'] = 32.200,
			['o'] = { '-', 1 }
		},
		{ 32.300 },
		{ 32.400 },
		{ 32.500 },
		{ 32.600 },
		{ 32.700 },
		{ 32.800 },
		{
			['t'] = 33.000,
			['s'] = 1,
			['p'] = { "Swap Barrage", { "dif+", 5 } },
		},
		{ 33.200 },
		{
			['t'] = 33.600,
			['s'] = 0,
			['p'] = { "Alt Barrage Ex", {} },
			['o'] = 0
		},
		{
			['t'] = 33.800,
			['s'] = 1,
			['p'] = { "cWallEx Random", { "dif+", 2 } }
		},
		{ 33.900 },
		{ 34.100 },
		{ 34.200 },
		{
			['t'] = 34.400,
			['s'] = 2,
			['p'] = { "cWallEx Random", { "dif+", 3 } }
		},
		{ 34.500 },
		{ 34.600 },
		{
			['t'] = 34.800,
			['s'] = 1,
			['p'] = { "cWallEx Random", { "dif+", 2 } }
		},
		{ 34.900 },
		{ 35.100 },
		{ 35.200 },
		{ 35.400 },
		{ 35.500 },
		{ 35.700 },
		{ 35.800 },
		{
			['t'] = 36.000,
			['s'] = 0,
			['p'] = { "Alt Barrage Ex Death", { Note.THIRTYSECOND } }
		},
		{
			['t'] = 36.800,
			['s'] = 5,
			['p'] = { "Tunnel Random", { "dif+", 4 } },
			['o'] = u_rndInt(1, l_getSides())
		},
		{ 37.200 },
		{ 37.600 },
		{ 38.000 },
		{ 38.400 },
		{ 38.600 },
		{
			['t'] = 38.700,
			['s'] = 0,
			['p'] = { "rWallEx Repeat", { 1 } },
			['o'] = {'+', 1 }
		},
		{ 38.900 },
		{ 39.200 },
		{ 39.500 },
		{
			['t'] = 39.800,
			['s'] = 1,
			['p'] = { "Swap Barrage", { "dif+", 5 } },
			['o'] = 0
		},
		{ 40.000 },
		{
			['t'] = 40.200,
			['p'] = { "cWallEx Random", { "dif+", 2 } }
		},
		{ 40.300 },
		{ 40.500 },
		{ 40.600 },
		{
			['t'] = 40.800,
			['s'] = 2,
			['p'] = { "cWallEx Random", { "dif+", 3 } }
		},
		{ 40.900 },
		{ 41.000 },
		{
			['t'] = 41.200,
			['s'] = 1,
			['p'] = { "cWallEx Random", { "dif+", 2 } }
		},
		{ 41.300 },
		{ 41.500 },
		{ 41.600 },
		{
			['t'] = 41.800,
			['s'] = 3,
			['p'] = { "cWallEx Random", { "dif+", 3} }
		},
		{ 41.900 },
		{ 42.000 },
		{ 42.100 },
		{
			['t'] = 42.200,
			['s'] = 0,
			['p'] = { "Alt Barrage Ex", {} }
		},
		{
			['t'] = 42.400,
			['s'] = 2,
			['p'] = { "Tunnel Straight Death", { "dif+", 2 } },
		},
		{ 42.800 },
		{ 43.200 },
		{
			['t'] = 43.600,
			['s'] = 1,
			['p'] = { "Tunnel Death", { "dif+", 1 } }
		},
		{ 44.200 },
		{
			['t'] = 44.800,
			['s'] = 2,
			['p'] = { "Alt Barrage Ex Death", { "dif+" } }
		},
		{ 45.600 },
		{ 45.800 },
		{
			['t'] = 45.900,
			['s'] = 0,
			['p'] = { "cWallEx", { 3 } },
			['o'] = u_rndInt(1, l_getSides())
		},
		{
			['t'] = 46.000,
			['o'] = { '+', 1 }
		},
		{ 46.000 },
		{ 46.100 },
		{ 46.200 },
		{ 46.300 },
		{ 46.400 },
		{
			['t'] = 46.600,
			['s'] = 1,
			['p'] = { "cWallEx Random", { "dif+", 2 } },
			['o'] = 0
		},
		{ 46.700 },
		{ 46.900 },
		{ 47.000 },
		{
			['t'] = 47.200,
			['s'] = 2,
		},
		{ 47.300 },
		{ 47.400 },
		{
			['t'] = 47.600,
			['s'] = 1,
		},
		{ 47.700 },
		{ 47.900 },
		{ 48.000 },
		{
			['t'] = 48.200,
			['s'] = 3
		},
		{ 48.300 },
		{ 48.400 },
		{ 48.500 },
		{
			['t'] = 48.600,
			['s'] = 0,
			['p'] = { "Alt Barrage Ex", {} }
		},
		{
			['t'] = 48.800,
			['s'] = 1,
			['p'] = { "cWallEx Random", { "dif+", 2 } }
		},
		{ 48.900 },
		{ 49.100 },
		{ 49.200 },
		{
			['t'] = 49.400,
			['s'] = 2
		},
		{ 49.500 },
		{ 49.600 },
		{
			['t'] = 49.800,
			['p'] = { "cWallEx Death", { 3 } },
			['o'] = u_rndInt(1, l_getSides())
		},
		{
			['t'] = 49.900,
			['o'] = { '+', 1 }
		},
		{ 50.000 },
		{ 50.100 },
		{ 50.200 },
		{ 50.300 },
		{ 50.400 },
		{ 50.500 },
		{ 50.600 },
		{ 50.700 },
		{ 50.800 }
	},
	[2] = {
		{ 0.000 },
		{ 0.200 },
		{ 0.400 },
		{ 0.600 },
		{ 0.800 },
		{ 1.600 },
		{ 2.000 },
		{ 2.800 },
		{ 3.200 },
		{ 3.800 },
		{ 4.400 },
		{ 4.800 },
		{ 5.400 },
		{ 6.200 },
		{ 6.400 },
		{ 6.800 },
		{ 7.200 },
		{ 8.000 },
		{ 8.800 },
		{ 9.300 },
		{ 9.600 },
		{ 10.400 },
		{ 11.200 },
		{ 12.000 },
		{ 12.800 },
		{ 13.600 },
		{ 14.400 },
		{ 15.200 },
		{ 16.000 },
		{ 16.800 },
		{ 17.600 },
		{ 18.400 },
		{ 19.200 },
		{ 20.000 },
		{ 20.200 },
		{ 20.300 },
		{ 20.500 },
		{ 20.600 },
		{ 20.700 },
		{ 20.800 },
		{ 21.600 },
		{ 22.400 },
		{ 23.200 },
		{ 24.800 },
		{ 26.400 },
		{ 27.200 },
		{ 27.600 },
		{ 28.400 },
		{ 28.800 },
		{ 29.600 },
		{ 30.400 },
		{ 31.000 },
		{ 31.600 },
		{ 32.000 },
		{ 32.800 },
		{ 33.600 },
		{ 34.200 },
		{ 35.000 },
		{ 35.200 },
		{ 36.000 },
		{ 36.800 },
		{ 37.200 },
		{ 38.000 },
		{ 38.400 },
		{ 40.000 },
		{ 40.800 },
		{ 41.600 },
		{ 42.400 },
		{ 43.200 },
		{ 43.600 },
		{ 44.200 },
		{ 44.800 },
		{ 45.600 },
		{ 45.800 },
		{ 45.900 },
		{ 46.000 },
		{ 46.100 },
		{ 46.200 },
		{ 46.300 },
		{ 46.400 },
		{ 46.600 },
		{ 47.200 },
		{ 47.800 },
		{ 48.000 },
		{ 48.800 },
		{ 49.600 },
		{ 50.200 },
		{ 50.800 }
	}
}