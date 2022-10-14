u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")

-- Exschwasion's patterns (and some adds)

-- pBackAndForth: spawns the back and forth pattern from super hexagon
function pBackAndForth(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 8 * l_getSpeedMult() * delay)
			w_wall(startSide+(l_getSides()/2), myThickness + 8 * l_getSpeedMult() * delay)
		end
		
		rWallThick(startSide+1, oldThickness*2)
		t_wait(delay*0.5*mDelayMult)
		rWallThick(startSide+2, oldThickness*2)
		t_wait(delay*0.5*mDelayMult)
		
	end
	
	THICKNESS = oldThickness
	t_wait(delay)
end

-- longer delay (modified by Hexadorsip)
function pBackAndForth2(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 9 * l_getSpeedMult() * delay)
			w_wall(startSide+(l_getSides()/2), myThickness + 9 * l_getSpeedMult() * delay)
		end
		
		rWallThick(startSide+1, oldThickness*2)
		t_wait(delay*0.5*mDelayMult)
		rWallThick(startSide+2, oldThickness*2)
		t_wait(delay*0.5*mDelayMult)
		
	end
	
	THICKNESS = oldThickness
	t_wait(delay)
end

--it's the weird pattern from super hexagon where you turn 3 then turn 2 then turn 1
function pWrapAround(mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5 * mDelayMult
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	cWallEx(startSide, l_getSides() - 2)
	t_wait(delay)
	cWallEx(startSide + getHalfSides(), l_getSides() - 2)
	cWallExThick(startSide + getHalfSides() + 1, l_getSides() - 4, THICKNESS*2.5)
	w_wall(startSide - 1, myThickness + 8 * l_getSpeedMult() * delay)
	t_wait(delay)
	cWallEx(startSide  + 1, l_getSides() - 4)
	w_wall(startSide + 2, THICKNESS*2)
	t_wait(delay*0.7)
	cWallEx(startSide + getHalfSides() + 1, l_getSides() - 4)
	
	
	THICKNESS = oldThickness
	t_wait(delay)
end

-- pTunnelDouble: doubly thick wall to rotate around
function pTunnelDouble(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 3.6
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 17 * l_getSpeedMult() * delay)
			w_wall(startSide+1, myThickness + 17 * l_getSpeedMult() * delay)
		end
		
		cBarrage(startSide + 5)
		t_wait(delay*1.1)
		cBarrage(startSide + 2)
		t_wait(delay*1.1)
		
	end
	
	THICKNESS = oldThickness
end

-- same pattern with mDelayMult (by Hexadorsip)
function pDMTunnelDouble(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 4.5
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 17 * l_getSpeedMult() * delay)
			w_wall(startSide+1, myThickness + 17 * l_getSpeedMult() * delay)
		end
		
		cBarrage(startSide + 5)
		t_wait(delay*1.1*mDelayMult)
		cBarrage(startSide + 2)
		t_wait(delay*1.1*mDelayMult)
		
	end
	
	t_wait(delay)
	THICKNESS = oldThickness
end

function pTunnelTriple(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 3.6
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 6 * l_getSpeedMult() * delay)
			w_wall(startSide+1, myThickness + 6 * l_getSpeedMult() * delay)
			w_wall(startSide+2, myThickness + 6 * l_getSpeedMult() * delay)
		end
		
		cBarrage(startSide + 1 + 2*loopDir)
		t_wait(delay)
		
		loopDir = loopDir * -1
		
	end
	
	THICKNESS = oldThickness
end

-- same pattern with mDelayMult (by Hexadorsip)
function pDMTunnelTriple(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 3.5
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 8 * l_getSpeedMult() * delay)
			w_wall(startSide+1, myThickness + 8 * l_getSpeedMult() * delay)
			w_wall(startSide+2, myThickness + 8 * l_getSpeedMult() * delay)
		end
		
		cBarrage(startSide + 1 + 2*loopDir)
		t_wait(delay*mDelayMult)
		
		loopDir = loopDir * -1
		
	end
	
	t_wait(delay)
	THICKNESS = oldThickness
end

-- pTunnelShort: the fast tunnel pattern from hexagoner
function pTunnelShort(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 3.6
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 10 * l_getSpeedMult() * delay)
		end
		
		cWallExThick(startSide + 3, l_getSides() - 4, oldThickness)
		t_wait(delay*0.65)
		cWallExThick(startSide - 5, l_getSides() - 4, oldThickness)
		t_wait(delay*0.65)
		
	end
	t_wait(delay*2)
	THICKNESS = oldThickness
end

-- same pattern with mDelayMult (by Hexadorsip)
function pDMTunnelShort(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 3.5
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 12 * l_getSpeedMult() * delay)
		end
		
		cWallExThick(startSide + 3, l_getSides() - 4, oldThickness)
		t_wait(delay*0.65*mDelayMult)
		cWallExThick(startSide - 5, l_getSides() - 4, oldThickness)
		t_wait(delay*0.65*mDelayMult)
		
	end
	t_wait(delay*1)
	THICKNESS = oldThickness
end