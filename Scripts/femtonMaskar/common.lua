-- common variables
THICKNESS = 40.0;

-- shuffle: shuffles an array
function shuffle(t)
	local iterations = #t
	local j
	for i = iterations, 2, -1 do
			j = math.random(i)
			t[i], t[j] = t[j], t[i]
	end

	return t
end

-- swaps: shuffle every x items
function swaps(t, x)
	local iterations = #t
	local j
	for i = iterations, 2, -2 do
		n = math.random(1, x)
		for k = n, 1, -1 do
			if k == 1 then end
			j = i-k+1
			t[i], t[j] = t[j], t[i]
		end
	end

	return t
end

-- clamp: clamps a number between two values
function clamp(input, min_val, max_val)
	if input < min_val then
		input = min_val
	elseif input > max_val then
		input = max_val
	end
	return input
end

-- From: https://stackoverflow.com/questions/12394841/
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

-- From: https://stackoverflow.com/questions/1318220/lua-decimal-sign#1318344
function sign(x)
	if x<0 then
		return -1
	elseif x>0 then
		return 1
	else
		return 0
	end
end

function enableSwapIfDMGreaterThan(mDM)
	if(u_getDifficultyMult() > mDM) then
		m_messageAdd(" difficulty > " ..mDM.. "\nswap enabled!", 65)
		l_setSwapEnabled(true)
	end	
end

function disableIncIfDMGreaterThan(mDM)
	if(u_getDifficultyMult() > mDM) then
		m_messageAdd(" difficulty > " ..mDM.. "\nincrement disabled!", 65)
		l_setIncEnabled(false)
	end	
end

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

-- getRotationDir: returns either 1 or -1
function getRotationDir()
	return sign(l_getRotationSpeed())
end

-- getPerfectDelay: returns time to wait for two walls to be next to each other
function getPerfectDelay(mThickness) return mThickness / (5.02 * u_getSpeedMultDM()) * u_getDelayMultDM() end

-- getPerfectDelayDM: returns getPerfectDelay calculated with difficulty mutliplier
function getPerfectDelayDM(mThickness) return mThickness / (5.02 * u_getSpeedMultDM()) * u_getDelayMultDM() end

-- getPerfectThickness: returns a good THICKNESS value in relation to human reflexes
function getPerfectThickness(mThickness) return mThickness * u_getSpeedMultDM() end

-- getPerfectThicknessDM: returns a good THICKNESS value given a delay
function getPerfectThicknessDM(mDelay) return 5.4 * u_getSpeedMultDM() * u_getDelayMultDM() * mDelay end

-- getSideDistance: returns shortest distance from a side to another
function getSideDistance(mSide1, mSide2)
	local dist = math.abs(mSide2 % l_getSides() - mSide1 % l_getSides());
	if (dist > getHalfSides()) then
		dist = dist - (dist - getHalfSides());
	end
	return dist;
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
	for i = 0, mExtra, loopDir do cWall(mSide + i) end
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
function cBarrage(mSide) cBarrageN(mSide, 0) end

-- cBarrageOnlyN: spawns a barrage of wall, with only free mNeighbors
function cBarrageOnlyN(mSide, mNeighbors)
	cWall(mSide)
	cBarrageN(mSide, mNeighbors)
end

-- cAltBarrage: spawns a barrage of alternate walls
function cAltBarrage(mSide, mStep)
	for i = 0, l_getSides() / mStep, 1 do
		cWall(mSide + i * mStep)
	end
end

-- cJukeAltBarrage: spawns a barrage of alternate walls with tricks
function cJukeAltBarrage(mSide, mStep)
	for i = 0, l_getSides() / mStep, 1 do
		cWall(mSide + i * mStep)
	end
	cWall(mSide + 3)
end

-- cBarrageS: spawns a barrage of walls, with a free mSide plus mNeighbors
function cBarrageS(mSide, mNeighbors, mSpeed)
	spd = mSpeed--math.random(-10,10)/2000
	for i = mNeighbors, l_getSides() - 2 - mNeighbors, 1 do
		wImpWall(mSide + i + 1, THICKNESS, 0, 45, 180, 45, 255, 1.0, 8, spd)
	end
	wImpWall(mSide, THICKNESS, 0, 45, 180, 45, 255, 1.0, 6, spd)
	wImpWall(mSide, THICKNESS, 0, 45, 180, 45, 255, 1.0, 7, spd)
end

-- cAltBarrageS: spawns a barrage of alternate walls
function cAltBarrageS(mSide, mStep, mSpeed)
	spd = mSpeed--math.random(-10,10)/2000
	for i = 0, l_getSides() / mStep, 1 do
		wImpWall(mSide + i * mStep, THICKNESS, 0, 45, 180, 45, 255, 1.0, 6, spd)
		wImpWall(mSide + i * mStep, THICKNESS, 0, 45, 180, 45, 255, 1.0, 7, spd)
	end
end

-- cBarrageL: spawns a barrage of walls, with a free mSide plus mNeighbors. for the level "luna Ascension"
function cBarrageL(mSide, mNeighbors, mThickness)
	mRed,mGreen,mBlue = s_getCapColorResult()
	for i = mNeighbors, l_getSides() - 2, 1 do
		wImpWall(mSide + i + 1, mThickness, 0, 255, 255, 255, 0, 1.0, 31, 0)
	end
	for i = mNeighbors, 0, -1 do
		wImpWall(mSide + i, mThickness, 0, 255, 255, mBlue, 254, 1.0, 32, 0)
	end
end