function randomWeighted(min, max, exponent)
	min = min or 0
	max = max or 1
	exponent = exponent or 0.5
	return min + (max - min) * (math.random()^exponent)
end

function runCWs()
	wallArrays(mFrameTime)

	ArrayRemove(imposterWalls, function(t, i, j)
		local v = t[i]
		if v.dead then
			cw_destroy(v.cwHandle)
			return true
		else
			return false
		end
	end);
	
	ArrayRemove(bgWalls, function(t, i, j)
		local v = t[i]
		if v.dead then
			cw_destroy(v.cwHandle)
			return true
		else
			return false
		end
	end);
	
	-- Loop through all imposter walls to handle their movement
	for _, iw in ipairs(imposterWalls) do
		iw:move(mFrameTime)
	end
end


