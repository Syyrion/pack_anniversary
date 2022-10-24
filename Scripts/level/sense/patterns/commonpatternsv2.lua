u_execScript("common.lua")

-- commonpatternsv2: second version of commonpatterns (modifications made by Hexadorsip and other players)

-- pAltBarrageThick: thick version of pAltBarrage
function pAltBarrageThick(mTimes, mStep)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 5.6
	
	for i = 0, mTimes do
		cAltBarrageThick(i, mStep, THICKNESS*2.5)
		t_wait(delay)
	end
	
	t_wait(delay)
end

-- pAltBarrageStrip: shorter version of pAltBarrage with cWallEx close to one another on the same side
function pAltBarrageStrip(mTimes, mExtra)
	delay = getPerfectDelay(THICKNESS) * 3.65
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cWallEx(startSide + 1, l_getSides() - 6, mExtra)
		cWallEx(startSide + 3, l_getSides() - 6, mExtra)
		cWallEx(startSide + 5, l_getSides() - 6, mExtra)
		t_wait(delay)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 5.00)
end

function pAltBarrageSpiral(mTimes, mStep, mDelayMult)
	delay = getPerfectDelay(THICKNESS)* 5.6 * mDelayMult
	
	for i = 0, mTimes do
		cAltBarrage(i, mStep)
		t_wait(delay)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 6.1)
end

function pcWallEx(mTimes, mSide, mExtra)
	if mExtra == 0 then delay = getPerfectDelay(THICKNESS) * 1.0
	elseif mExtra == 1 then delay = getPerfectDelay(THICKNESS) * 2.0
	elseif mExtra == 2 then delay = getPerfectDelay(THICKNESS) * 2.8
	elseif  mExtra == 3 then delay = getPerfectDelay(THICKNESS) * 3.2
	end
	for i = 0, mTimes do
		cWallEx(getRandomSide(), mExtra)
		t_wait(delay)
	end
	
	t_wait(delay)
end

function pcfastWallEx(mTimes, mSide, mExtra)
	delay = getPerfectDelay(THICKNESS) * 0.8
	for i = 0, mTimes do
		cWallEx(getRandomSide(), mExtra)
		t_wait(delay)
	end
	
	t_wait(delay)
end

function pMirrorSpiralv2(mTimes, mExtra)
	delay = getPerfectDelay(THICKNESS)
	startSide = getRandomSide()
	loopDir = getRandomDir()
	j = 0
	
	for i = 0, mTimes do
		rWallEx(startSide + j, mExtra)
		j = j + loopDir
		t_wait(delay*3)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
end

function pMirrorSpiralLeft(mTimes, mExtra)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(THICKNESS)
	startSide = getRandomSide()
	loopDir = getRandomDir()
	j = 0
	
	for i = 0, mTimes do
		rWallEx(startSide + j, mExtra)
		j = j - 1
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
end

function pMirrorSpiralThin(mTimes, mExtra, mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult
	startSide = getRandomSide()
	loopDir = getRandomDir()
	j = 0
	
	for i = 0, mTimes do
		rWallEx(startSide + j, mExtra)
		j = j + loopDir
		t_wait(delay)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
end

-- pSingleSpiral: spawns a spiral of cWallEx
function pSingleSpiral(mTimes, mExtra)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(THICKNESS)
	startSide = getRandomSide()
	loopDir = getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		cWallEx(startSide + j, mExtra)
		j = j + loopDir
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
end
	
function pSingleSpiralLeft(mTimes, mExtra)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(THICKNESS)
	startSide = getRandomSide()
	loopDir = getRandomDir()
	j = 0
	
	for i = 0, mTimes do
		cWallEx(startSide + j, mExtra)
		j = j - 1
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
	end
		
-- pSingleSpiralDouble: spawns a spiral of cWallEx where you need to change direction
function pSingleSpiralDouble(mTimes, mExtra)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(THICKNESS)
	startSide = getRandomSide()
	currentSide = startSide
	loopDir = getRandomDir()
	j = 0
	k = 0
	
	for k = 0, mTimes do
	
	if math.random(0, 1) == 0 then
	for i = 0, math.random(mTimes, 2*mTimes) do
		cWallEx(currentSide + j, mExtra)
		j = j + loopDir
		t_wait(delay*0.65)
	end
	
	cWallEx(currentSide + j, mExtra)
	t_wait(delay*0.65)
	cWallEx(currentSide + j, mExtra)
	t_wait(delay*0.65)
	
	else
	for i = 0, math.random(mTimes, 2*mTimes) do
		cWallEx(currentSide + j, mExtra)
		j = j - loopDir
		t_wait(delay*0.65)
	end
	
	cWallEx(currentSide + j, mExtra)
	t_wait(delay*0.65)
	cWallEx(currentSide + j, mExtra)
	t_wait(delay*0.65)
	
	end
	--loopDir = loopDir * -1
	
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
end	

function pBarrageSpiralLeft(mTimes, mDelayMult, mStep)
	delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult
	startSide = getRandomSide()
	j = 0
	
	for i = 0, mTimes do
		cBarrage(startSide + j)
		j = j - 1
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.6) end
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 6.1)
end

function pBarrageSpiralDouble(mTimes, mDelayMult, mStep)
	delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult
	startSide = getRandomSide()
	currentSide = startSide	
	loopDir = mStep * getRandomDir()
	j = 0
	
	for i = 0, mTimes do
		cBarrage(startSide + j)
		j = j + loopDir
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.6) end
	end
	
    cBarrage(startSide + j)
    t_wait(delay)
    if(l_getSides() < 6) then t_wait(delay * 0.6) end  
	
	loopDir = loopDir * -1
	
	for i = 0, mTimes do
		cBarrage(startSide + j - 1, currentSide)
		j = j + loopDir
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.6) end
	end		
	
	t_wait(getPerfectDelay(THICKNESS) * 6.1)
end

-- pBarrageSpiralLR: spawns left-right spiral of cBarrage
function pBarrageSpiralLR(mTimes, mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cBarrage(startSide)
		t_wait(delay)
		cBarrage(startSide + 1)
		t_wait(delay)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 6.1)
end

-- pWallExVortexLL: spawns left-left left-left spiral patterns
function pWallExVortexLL(mTimes, mStep, mExtraMult)
	delay = getPerfectDelay(THICKNESS) * 5.0 
	startSide = getRandomSide()
	loopDir = getRandomDir()
	currentSide = startSide
	
	for j = 0, mTimes do
		for i = 0, mStep do
			currentSide = currentSide + loopDir
			rWallEx(currentSide, loopDir * mExtraMult)
			t_wait(delay)
		end
		
		loopDir = loopDir * -1
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 5.5)
end

-- pDMInverseBarrage: pInverseBarrage pattern + mDelayMult
function pDMInverseBarrage(mTimes, mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 5 * mDelayMult
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cBarrage(startSide)
		t_wait(delay*mDelayMult)
		cBarrage(startSide + getHalfSides())
		t_wait(delay*mDelayMult)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 2.5)
end

-- pInverseBarrageMin1Sid: pInverseBarrage pattern with two free sides
function pInverseBarrageMin1Sid(mTimes, mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 5 * mDelayMult
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cBarrage2(startSide)
		t_wait(delay*mDelayMult)
		cBarrage2(startSide + getHalfSides())
		t_wait(delay*mDelayMult)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 2.5)
end

-- pInverseBarrageMin2Sid: pInverseBarrage pattern with three free sides
function pInverseBarrageMin2Sid(mTimes, mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 5 * mDelayMult
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cBarrage3(startSide)
		t_wait(delay*mDelayMult)
		cBarrage3(startSide + getHalfSides())
		t_wait(delay*mDelayMult)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 2.5)
end

-- pInverseBarrageMin3Sid: pInverseBarrage pattern with four free sides
function pInverseBarrageMin3Sid(mTimes, mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 5 * mDelayMult
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cBarrage4(startSide)
		t_wait(delay*mDelayMult)
		cBarrage4(startSide + getHalfSides())
		t_wait(delay*mDelayMult)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 2.5)
end

-- pMirrorWallStripThick: thick version of pMirrorWallStrip
function pMirrorWallStripThick(mTimes, mExtra)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS) * 1
	delay = getPerfectDelay(THICKNESS) * 3.65
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		rWallEx(startSide, mExtra)
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 5.00)
end

-- pDMTunnel: the pTunnel pattern with mDelayMult
function pDMTunnel(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 4
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 6 * l_getSpeedMult() * delay)
		end
		
		cBarrage(startSide + loopDir)
		t_wait(delay*mDelayMult)
		
		loopDir = loopDir * -1
	end
	
	THICKNESS = oldThickness
	t_wait(delay)
end

function pTunnelThin(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 7 * l_getSpeedMult() * delay)
		end
		
		cBarrageThick(startSide + loopDir, oldThickness)
		t_wait(delay*mDelayMult)
		
		loopDir = loopDir * -1
	end
	
	t_wait(delay)
	THICKNESS = oldThickness
end