u_execDependencyScript("ohvrvanilla","base","vittorio romeo","utils.lua")
u_execDependencyScript("ohvrvanilla","base","vittorio romeo","common.lua")
u_execDependencyScript("ohvrvanilla","base","vittorio romeo","commonpatterns.lua")
u_execDependencyScript("ohvrvanilla","base","vittorio romeo","alternativepatterns.lua")

-- Adds string formatting to ct_eval and prevents crashing from runtime errors
local ct_eval_unsafe = ct_eval
function ct_eval(handle,string,...)
	ct_eval_unsafe(handle,("xpcall(function() "..string.." end,print)"):format(...))
end

-- Checks if a number is between 2 numbers regardless of the order of the numbers
function isBetween(number,bound1,bound2)
	return (number-bound1) * (number-bound2) <= 0
end

-- Creates a color in the HSL format where S is 1
function fromHL(hue,light,range)
	light,range = clamp(light,0,1),range or 1
	local r,g,b = fromHSV(hue,math.min(1,2-2*light),math.min(1,2*light))
	return {r*range/255,g*range/255,b*range/255}
end

-- Converts a color to be grayscale
function grayscale(color)
	local average = (color[1]+color[2]+color[3])/3
	return {average,average,average}
end

-- Creates coordinates for a wall
-- Also can be used as an all-in-one function for polar math
function getWallCoords(ang,rad,skw,off,posX,posY)
	local rad,skw,off,posX,posY = rad or 1, skw or 1, off or 0, posX or 0, posY or 0
	return {posX +  rad * math.cos(ang) + off * math.cos(ang - math.pi/2),
		    posY + (rad * math.sin(ang) + off * math.sin(ang - math.pi/2)) / skw}
end

-- Iterates through a numeric table backwards
-- Useful for using table.remove without skipping indices
function bipairs(obj)
	return function(t,i)
		i = i - 1
		if i > 0 then return i,t[i] end
	end,obj,#obj+1
end

-- Iterates through a table recursively
-- Usage: for value,keys... in reiter(object),iterator do
function reiter(obj)
	return coroutine.wrap(function(iterator)
		local function iterate(t,...)
			local keys = {...}
			local level = #keys+1
			for k,v in iterator(t) do
				if type(v) == "table" then iterate(v,unpack(keys))
				else coroutine.yield(v,unpack(keys)) end
			end
		end
		iterate(obj)
	end)
end

-- Unpacks a table recursively
-- An optional 2nd argument can be used to determine which iterator to use when unpacking
function reunpack(obj,iterator)
	local values = {}
	for v in reiter(obj),iterator or ipairs do
		table.insert(values,v)
	end
	return unpack(values)
end

-- Reimplementation of custom timelines in lua
local timelines = {}
function lt_create()
	table.insert(timelines,{time = 0})
	return #timelines
end
function lt_eval(handle,callback,...)
	local args = {...}
	table.insert(timelines[handle],function() callback(unpack(args)) end)
end
function lt_wait(handle,frames)
	table.insert(timelines[handle],frames/60)
end
function lt_clear(handle)
	timelines[handle] = {time = 0}
end
function lt_update(handle,dt)
	local timeline = timelines[handle]
	timeline.time = timeline.time + dt
	while timeline[1] do
		if type(timeline[1]) == "function" then timeline[1]()
		elseif timeline[1] <= timeline.time then timeline.time = timeline.time - timeline[1]
		else return end
		table.remove(timeline,1)
	end
end