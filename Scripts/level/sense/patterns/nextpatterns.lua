u_execScript("common.lua")
u_execScript("commonpatterns.lua")
u_execScript("utils.lua")
u_execScript("alternativepatterns.lua")

function wallSAdj(mSide, mAdj) w_wallAdj(mSide, THICKNESS, mAdj) end
function wallSAcc(mSide, mAdj, mAcc, mMinSpd, mMaxSpd) w_wallAcc(mSide, THICKNESS, mAdj, mAcc * (u_getDifficultyMult()), mMinSpd, mMaxSpd) end
-- side, starting speed, acceleration, min speed, max speed
-- mAcc * (u_getDifficultyMult())
-- even when using w_wallAcc, difficulty affects these walls...
-- ...why...

function pTrapBarrage(mSide)
	delay = getPerfectDelayDM(THICKNESS) * 3.7
		
	cBarrage(mSide)
	t_wait(delay * 3)
	wallSAdj(mSide, 1.9)

	t_wait(delay * 2.5)
end

function pTrapBarrageDouble(mSide)
	delay = getPerfectDelayDM(THICKNESS) * 3.7
	side2 = mSide + getHalfSides();
	
	for i = 0, l_getSides() - 1 do
		currentSide = mSide + i
		if((currentSide ~= mSide) and (currentSide ~= side2)) then cWall(currentSide) end
	end

	t_wait(delay * 3)
	wallSAdj(mSide, 1.9)
	wallSAdj(side2, 1.9)
	
	t_wait(delay * 2.5)
end

function pTrapBarrageInverse(mSide)
	delay = getPerfectDelayDM(THICKNESS) * 3.7
	
	cWall(mSide)	
	t_wait(delay * 3)

	for i = 0, l_getSides() - 1 do
		currentSide = mSide + i
		if(currentSide ~= mSide) then wallSAdj(currentSide, 1.9) end
	end

	t_wait(delay * 2.5)
end

function pTrapBarrageAlt(mSide)
	delay = getPerfectDelayDM(THICKNESS) * 3.7

	for i = 0, l_getSides() - 1 do
		currentSide = mSide + i
		if(currentSide % 2 ~= 0) then cWall(currentSide) end
	end

	t_wait(delay * 3)

	for i = 0, l_getSides() - 1 do
		currentSide = mSide + i
		if(currentSide % 2 == 0) then wallSAdj(currentSide, 1.9) end
	end

	t_wait(delay * 2.5)
end

function pTrapSpiral(mSide)
	delay = getPerfectDelayDM(THICKNESS) * 3.7
	loopDir = getRandomDir()		

	if(l_getSides() < 6) then delay = delay + 4 end

	for i = 0, l_getSides() + getHalfSides() do
		currentSide = (mSide + i) * loopDir
		for j = 0, getHalfSides() do wallSAdj(currentSide + j, 1.2 + (i / 7.9)) end
		t_wait((delay * 0.75) - (i * 0.45) + 3)
	end

	t_wait(delay * 2.5)
end







