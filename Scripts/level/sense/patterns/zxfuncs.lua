function randomWeighted(min, max, exponent)
	min = min or 0
	max = max or 1
	exponent = exponent or 0.5
	return min + (max - min) * (math.random()^exponent)
end

function ArrayRemove(t, fnRemove)
    local j, n = 1, #t;

    for i=1,n do
        if (not fnRemove(t, i, j)) then
            -- Move i's kept value to j's position, if it's not already there.
            if (i ~= j) then
                t[j] = t[i];
                t[i] = nil;
            end
            j = j + 1; -- Increment position of where we'll place the next kept value.
        else
            t[i] = nil;
        end
    end

    return t;
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


