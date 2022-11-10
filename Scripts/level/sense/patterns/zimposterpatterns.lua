u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

--[[ vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
-- Note: DO NOT EXECUTE THIS SCRIPT WITHOUT THE IMPOSTER WALL SCRIPT STUFF IN YOUR LEVEL!
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-- Distance of a regular w_wall is 1600
-- To match the speed of a regular w_wall, use the speed mult times 5.

-- common wall
function cImpWall(mSide, mSpeed, mRed, mGreen, mBlue, mAlpha)
	wImpWall(mSide, 1605, mSpeed, THICKNESS, l_getSides(), mRed, mGreen, mBlue, mAlpha)
end

-- common simplified
function csImpWall(mSide, mSpeed)
	cImpWall(mSide, mSpeed, 0, 0, 0, 255)
end

-- common super simplified
function cssImpWall(mSide)
	csImpWall(mSide, l_getSpeedMult() * 5)
end

function cImpBarrage(mSide)
	for i = 0, l_getSides() - 2, 1 do
		cssImpWall(mSide + i + 1)
	end
end

-- cAltBarrage: spawns a barrage of alternate walls
function cImpAltBarrage(mSide, mStep)
	for i = 0, l_getSides() / mStep, 1 do
		cssImpWall(mSide + i * mStep)
	end
end

-- blablabla these are like the ones you find in common.lua
function rImpWall(mSide)
	cssImpWall(mSide)
	cssImpWall(mSide + l_getHalfSides())
end

function cssImpWallEx(mSide, mExtra)
	cssImpWall(mSide);
	local exLoopDir = 1;
	
	if mExtra < 0 then exLoopDir = -1 end
	for i = 0, mExtra, exLoopDir do cssImpWall(mSide + i) end
end

function rImpWallEx(mSide, mExtra)
	cssImpWallEx(mSide, mExtra)
	cssImpWallEx(mSide + l_getHalfSides(), mExtra)
end

-- patterns

-- spawns imposter barrages on random sides, accounting for distance to be humanly possible
function pImpRandomBarrage(mTimes, mDelayMult)
	local side = getRandomSide()
	local oldSide = 0
	
	for i = 0, mTimes do	
		cImpBarrage(side)
		oldSide = side
		side = getRandomSide()
		t_wait(getPerfectDelayDM(THICKNESS) * (2 + (getSideDistance(side, oldSide)*mDelayMult)))
	end
	
	t_wait(getPerfectDelayDM(THICKNESS) * 5.6)
end

-- pAltBarrage: spawns a series of cImpAltBarrage
function pImpAltBarrage(mTimes, mStep)
	local delay = getPerfectDelayDM(THICKNESS) * 5.6
	
	for i = 0, mTimes do
		cImpAltBarrage(i, mStep)
		t_wait(getPerfectDelayDM(THICKNESS) * 5.6)
	end
	
	t_wait(getPerfectDelayDM(THICKNESS) * 5.6)
end]]

-- actual patterns being used now
t = getRandomSide()
d = getRandomDir()
m = 0
f = 0

function impWall(mSide, mDistanceAdd, mThickness, mShape)
	wImpWall(mSide, 1605 + mDistanceAdd, l_getSpeedMult() * 5, mThickness, mShape, 255, 255, 255, 255)
end

function impBarrage(mSide, mDistanceAdd, mThickness, mShape)

	for i = 1, mShape - 1 do
		impWall(mSide + i, mDistanceAdd, mThickness, mShape)
	end
end

function impDoubleBarrage(mSide, mDistanceAdd, mThickness, mShape, mLevel)

	if mLevel == 1 then
		for i = 3, mShape - 3 do
			impWall(mSide + i, mDistanceAdd, mThickness, mShape)
		end
	impWall(mSide - 1, mDistanceAdd, mThickness, mShape)
	impWall(mSide + 1, mDistanceAdd, mThickness, mShape)
	
	else
		for i = 2, mShape - 2 do
			impWall(mSide + i, mDistanceAdd, mThickness, mShape)
		end
	impWall(mSide, mDistanceAdd, mThickness, mShape)
	
	end
end

function impWallExM(mSide, mDistanceAdd, mThickness, mAdd, mMult, mShape)
	for i = 1, 1 + mAdd do
		impWall(mSide + i * mMult, mDistanceAdd, mThickness, mShape)
	end
end

function iBarrageSpiral()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(4, 6) do
		t_eval("impBarrage(t + m, 0, 40, l_getSides())")
		t_eval("m = m + d")
		t_wait(custWait(4.8))
	end

	t_wait(custWait(8))
end

function iAltBarrage()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(4, 6) do
		t_eval("impWallExM(t + m, 0, 40, math.floor(l_getSides() / 2) + (d * 0.5 - 0.5), 2, l_getSides())")
		t_eval("m = m + d")
		t_eval("d = d * -1")
		t_wait(custWait(4.8))
	end

	t_wait(custWait(8))
end

function iTunnel(exDelay)
t = getRandomSide()
times = math.random(2, 4)
d = getRandomDir()

	impWall(t, 0, custThickness(times * 8.7 * exDelay) + 40, l_getSides())

	for a = 1, times + 1 do
		t_eval("impBarrage(t + d, 0, 40, l_getSides())")
		t_eval("d = d * -1")
		t_wait(custWait(8.7 * exDelay))
	end

	t_wait(custWait(8))
end

function iMirrorSpiral(mLevel)
t = getRandomSide()
m = 0
d = getRandomDir()
dah = mLevel

	for a = 1, math.random(6, 8) do
		if dah == 1 then
			t_eval("impWall(t + m, 0, custThickness(2), l_getSides())")
			t_eval("impWall(t + m + 3, 0, custThickness(2), l_getSides())")
			t_eval("impWall(t + m + 6, 0, custThickness(2), l_getSides())")
		else
			t_eval("impWall(t + m, 0, custThickness(2), l_getSides())")
			t_eval("impWall(t + m + getHalfSides(), 0, custThickness(2), l_getSides())")
		end
		
		t_eval("m = m + d")
		t_wait(custWait(2.3))
	end

	t_wait(custWait(8))
end

function iBarrageLRs(mDistance)
t = getRandomSide()
m = 0
d = getRandomDir()
dAd = mDistance

	for a = 1, math.random(4, 6) do
		t_eval("impBarrage(t + m, 0, 40, l_getSides())")
		t_eval("m = m + d * dAd")
		t_eval("d = d * -1")
		t_wait(custWait(4.8 * (dAd * 0.5 + 0.5)))
	end

	t_wait(custWait(8))
end

function iDoubleBarrageSpiral(mLevel)
t = getRandomSide()
m = 0
d = getRandomDir()

lvl = mLevel

	for a = 1, math.random(4, 6) do
		t_eval("impDoubleBarrage(t + m, 0, 40, l_getSides(), lvl)")
		t_eval("m = m + d")
		t_wait(custWait(4.8))
	end

	t_wait(custWait(8))
end

function iDoubleBarrageLRs(mLevel)
t = getRandomSide()
m = 0
d = getRandomDir()

lvl = mLevel

	for a = 1, math.random(4, 6) do
		t_eval("impBarrage(t + m, 0, 40, l_getSides(), lvl)")
		t_eval("m = m + d")
		t_eval("d = d * -1")
		t_wait(custWait(4.8))
	end

	t_wait(custWait(8))
end

function iVortaSpiral(mLevel)
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(4, 6) do
		if mLevel == 1 then
			t_eval("impWallExM(t + m, 0, 40, 1, 1, l_getSides())")
			t_eval("impWallExM(t + m + 3, 0, 40, 1, 1, l_getSides())")
			t_eval("impWallExM(t + m + 6, 0, 40, 1, 1, l_getSides())")
		else
			t_eval("impWallExM(t + m, 0, 40, math.ceil(l_getSides() * 0.5 - 2), 1, l_getSides())")
			t_eval("impWallExM(t + m + getHalfSides(), 0, 40, math.floor(l_getSides() * 0.5 - 2), 1, l_getSides())")
		end
		
		t_eval("m = m + d")
		t_wait(custWait(4.8))
	end

	t_wait(custWait(8))
end

function iAltTunnel(exDelay, mAdd)
t = getRandomSide()
m = 0
d = getRandomDir()
times = math.random(4, 6)

	for i = 1, mAdd do
		impWall(i + t, 0, custThickness(times * 4.8 * exDelay) + 40, l_getSides())
	end
	

	for a = 1, times + 1 do
		t_eval("impWallExM(t + m, 0, 40, math.floor(l_getSides() / 2) + (d * 0.5 - 0.5), 2, l_getSides())")
		t_eval("m = m + d")
		t_eval("d = d * -1")
		t_wait(custWait(4.8 * exDelay))
	end

	t_wait(custWait(8))
end

-- custom level bullshit 

function bsWall(mSide, mThickness, mRed, mGreen, mBlue, mAlpha)
	mRed = math.random(1, 120)

	wImpWall(mSide, 1605, l_getSpeedMult() * 5, mThickness, l_getSides(), mRed, mGreen, mBlue, mAlpha, 0)
	wImpWall(mSide, 1605, l_getSpeedMult() * 5, mThickness, l_getSides(), mRed, mGreen, mBlue, mAlpha, 1)
	w_wallAdj(0, 0, 1.25)
end

function bsMirrorWall(mSide, mThickness, mRed, mGreen, mBlue, mAlpha)
	bsWall(mSide, mThickness, mRed, mGreen, mBlue, mAlpha)
	bsWall(mSide + getHalfSides(), mThickness, mRed, mGreen, mBlue, mAlpha)
end

function bsBarrage(mSide, mThickness, mRed, mGreen, mBlue, mAlpha)
	for i = 1, l_getSides() - 1 do
		bsWall(mSide + i, mThickness, mRed, mGreen, mBlue, mAlpha)
	end
end

function bsDoubleBarrage(mSide, mThickness, mRed, mGreen, mBlue, mAlpha)
	for i = 2, l_getSides() - 2 do
		bsWall(mSide + i, mThickness, mRed, mGreen, mBlue, mAlpha)
		bsWall(mSide, mThickness, mRed, mGreen, mBlue, mAlpha)
	end
end

function bsBarrageSpiral(mRed, mGreen, mBlue, mAlpha)
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 6) do
		t_eval("bsBarrage(t + m, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("m = m + d")
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end

function bsAltBarrage(mRed, mGreen, mBlue, mAlpha)
t = getRandomSide()
m = 0

	for a = 1, math.random(3, 6) do
		t_eval("bsWall(t + m, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("bsWall(t + m + 2, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("bsWall(t + m + 4, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("bsWall(t + m + 6, 40, mRed, mGreen, mBlue, mAlpha)")
		
		t_eval("m = m + 1")
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end

function bsMirrorSpiral(mRed, mGreen, mBlue, mAlpha)
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(6, 8) do
		t_eval("bsMirrorWall(t + m, custThickness(2), mRed, mGreen, mBlue, mAlpha)")
		t_eval("m = m + d")
		t_wait(custWait(2))
	end


	t_wait(custWait(8))
end

function bsBarrageLR(mRed, mGreen, mBlue, mAlpha)
t = getRandomSide()
m = 0
suzi = math.random(1, 2)
d = getRandomDir() * suzi

	for a = 1, math.random(3, 6) do
		t_eval("bsBarrage(t + m, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("m = m + d")
		t_eval("d = d * -1")
		t_wait(custWait(4.8 * (suzi * 0.5 + 0.5)))
	end


	t_wait(custWait(8))
end

function bsBarrageInvert(mRed, mGreen, mBlue, mAlpha)
t = getRandomSide()
m = 0
d = getHalfSides()

	for a = 1, math.random(3, 5) do
		t_eval("bsBarrage(t + m, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("m = m + d")
		t_wait(custWait(8))
	end


	t_wait(custWait(8))
end

function bsDoubleBarrageSpiral(mRed, mGreen, mBlue, mAlpha)
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 6) do
		t_eval("bsDoubleBarrage(t + m, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("m = m + d")
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end

function bsDoubleBarrageInvert(mRed, mGreen, mBlue, mAlpha)
t = getRandomSide()
m = 0
d = getHalfSides()

	for a = 1, math.random(3, 6) do
		t_eval("bsDoubleBarrage(t + m, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("m = m + d")
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end

function bsDoubleBarrageLR(mRed, mGreen, mBlue, mAlpha)
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 6) do
		t_eval("bsDoubleBarrage(t + m, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("m = m + d")
		t_eval("d = d * -1")
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end

function bsAltHalfs(mRed, mGreen, mBlue, mAlpha)
t = getRandomSide()
m = 0

	for a = 1, math.random(3, 6) do
		t_eval("bsWall(t + m, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("bsWall(t + m + 1, 40, mRed, mGreen, mBlue, mAlpha)")
		t_eval("bsWall(t + m + 2, 40, mRed, mGreen, mBlue, mAlpha)")
		
		if l_getSides() == 8 then
			t_eval("bsWall(t + m + 3, 40, mRed, mGreen, mBlue, mAlpha)")
		end
		
		t_eval("m = m + getHalfSides()")
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end


function spheriWall(mSide, mThickness)
	wImpWall(mSide % 5, 1605, 1, mThickness, 5, 255, 255, 255, 255)
	w_wallAdj(0, 0, 1.2)
end

function spheriBarrage(mSide, mThickness)
	for i = 1, 4 do
		spheriWall(mSide + i, mThickness)
	end
end


function spheriBarrageSpiral()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(4, 6) do
		t_eval("spheriBarrage(t + m, 40)")
		t_eval("m = m + d")
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end

function spheriAltBarrage()
t = getRandomSide()
d = getRandomDir()
m = d * 0.5 + 0.5

s = 0

	for a = 1, math.random(4, 6) do
		t_eval("spheriWall(t + m, 40)")
		t_eval("spheriWall(t - m, 40)")
		t_eval("spheriWall(t + m - 2, 40)")
		
		t_eval("m = m + d")
		t_eval("d = d * -1")
		
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end

function spheriSpiral()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(6, 8) do
		t_eval("spheriWall(t + m, custThickness(1.4))")
		t_eval("m = m + d")
		t_wait(custWait(1.4))
	end


	t_wait(custWait(8))
end

function spheriTunnel()
t = getRandomSide()
distance = math.random(1, 3)
d = math.random(0, 1) * distance
times = math.random(3, 5)

q = 0

	for PISS = 1, distance * -1 + 4 do
		t_eval("spheriWall(t + q - 1, custThickness(times * 7) + 20)")
		t_eval("q = q - 1")
	end

	for a = 1, times + 1 do
		t_eval("spheriBarrage(t + d, 40)")
		t_eval("d = d * -1 + distance")
		t_wait(custWait(7))
	end


	t_wait(custWait(8))
end

function spheriBarrageLRs()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(4, 6) do
		t_eval("spheriBarrage(t + m, 40)")
		t_eval("m = m + d")
		t_eval("d = d * -1")
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end

function spheriBarrageTrap()
t = getRandomSide()
d = 1

	for a = 1, math.random(4, 6) do
		t_eval("spheriWall(t + d * 1, 40)")
		t_eval("spheriWall(t + d * 2, 40)")
		t_eval("spheriWall(t + d * 3, 40)")
		t_eval("spheriWall(t + d * 4, 40)")
		t_eval("d = d * -1 + 1")
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end

function spheriAltTunnel()
t = getRandomSide()
d = getRandomDir()
m = d * 0.5 + 0.5

s = 0

times = math.random(4, 6)

	spheriWall(t + (d * 0.5 + 0.5), custThickness(times * 4.8) + 40)
	spheriWall(t + 1 + (d * 0.5 + 0.5), custThickness(times * 4.8) + 40)

	for a = 1, times + 1 do
		t_eval("spheriWall(t + m, 40)")
		t_eval("spheriWall(t - m, 40)")
		t_eval("spheriWall(t + m - 2, 40)")
		
		t_eval("m = m + d")
		t_eval("d = d * -1")
		
		t_wait(custWait(4.8))
	end


	t_wait(custWait(8))
end


function cursedWall(mSide, mThickness, mDistance, mSideCount)
	wImpWall(mSide, 0, mDistance, 0, 1, mThickness, mSideCount, 255, 255, 255, 255, 0)
end

function cursedBarrage(mSide, mThickness, mDistance, mSideCount, mWallAdd)
	for i = 0, mWallAdd - 1 do
		cursedWall(mSide + i, mThickness, mDistance, mSideCount)
	end
end

function cursedCurveWall(mSide, mThickness, mDistance, mSideCount, mCurve)
	wImpWall(mSide, 0, mDistance, 0, 1, mThickness, mSideCount, 255, 255, 255, 255, mCurve)
end

function cursedCurveBarrage(mSide, mThickness, mDistance, mSideCount, mWallAdd, mCurve)
	for i = 0, mWallAdd - 1 do
		cursedCurveWall(mSide + i, mThickness, mDistance, mSideCount, mCurve)
	end
end

function cursedSkewedWall(mSide, mSideThickness, mThickness, mDistance, mDistanceRight, mSideCount)
	wImpWall(mSide, mSideThickness, mDistance, mDistanceRight, 1, mThickness, mSideCount, 255, 255, 255, 255, 0)
end

-- its too tedious to type THICKNESS * _ 30 times so i just did this-
function thilvue(mThickness)
	return mThickness * 40 * (l_getSpeedMult() / 2)
end

function breakWall(mSide)
	w_wallAcc(mSide, 40, 31, -9.15, 0.5, 30)
end

function anAltBarrage()
t = getRandomSide()

	breakWall(t)
	breakWall(t + 2)
	breakWall(t + 4)
end

function aBarrage()
t = getRandomSide()

	breakWall(t)
	breakWall(t + 1)
	breakWall(t + 2)
	breakWall(t + 3)
	breakWall(t + 4)
end

function aHalf()
t = getRandomSide()

	breakWall(t)
	breakWall(t + 1)
	breakWall(t + 2)
end

function aDoubleBarrage()
t = getRandomSide()

	breakWall(t)
	breakWall(t + 1)
	breakWall(t + 2)
	breakWall(t + 4)
end

-- cursed shit
function crstForceSwap()
t = getRandomSide()

cursedWall(t + 1, thilvue(5), 0, 6)
cursedWall(t + 4, thilvue(6.1), 0, 6)

cursedBarrage(t + 2, thilvue(1), thilvue(1), 6, 2)
cursedWall(t + 5, thilvue(4.1), thilvue(1), 6)

cursedWall(t + 0, thilvue(1), thilvue(5), 6)

cursedWall(t + 3, thilvue(1), thilvue(6), 6)
end

function crstCurveForceSwap()
t = getRandomSide()
local dir = getRandomDir()

cursedWall(t + 1, thilvue(5.2), 0, 6)
cursedWall(t + 4, thilvue(5.2), 0, 6)
cursedBarrage(t + 5, thilvue(1), 0, 6, 2)

cursedBarrage(t + 2, thilvue(1), thilvue(4.2), 6, 2)

	for i = 1, 3 do
		cursedCurveWall(t + i * 2, thilvue(1), thilvue(4.2), 6, 0.25 * dir)
	end
end

function crstFuckedUpAltBarrage(mLength)
t = getRandomSide()

	for a = 0, mLength * 2 do
		cursedWall(t + 1, thilvue(1), a * thilvue(3), 6)
		cursedWall(t + 3, thilvue(1), a * thilvue(3), 6)
		cursedWall(((t / 6) * 4) + 3.333, thilvue(1), a * thilvue(3), 4)
		t = t + 3
	end

end

function crstSmallGap()
t = getRandomSide()

	for i = 1, 3 do
		cursedWall(t + i * 2, thilvue(2.9), 0, 6)
		cursedWall(t + i * 2 + 1, thilvue(1), thilvue(3), 6)
	end
end

function crstPrecisionSwapping()
t = getRandomSide()

cursedWall(t + 1, thilvue(5), 0, 7)
cursedWall(t + 2, thilvue(1), 0, 7)
cursedWall(t + 3, thilvue(5), 0, 7)
cursedWall(t + 4, thilvue(1), 0, 7)
cursedWall(t + 5, thilvue(5), 0, 7)


cursedWall(t + 6, thilvue(1), thilvue(4), 7)
cursedWall(t + 7, thilvue(1), thilvue(4), 7)
end

function crstFuckedUpTunnel(mLength)
t = getRandomSide()
d = getRandomDir()

	cursedWall(((t / 6) * 8), thilvue(mLength * 8.5), 0, 8)
		
	for i = 0, mLength do
		cursedBarrage(t + d + 1, thilvue(1), i * thilvue(8.5), 6, 5)
		d = d * -1
	end
end

function crstLongPipe()
t = getRandomSide()
local dir = getRandomDir()
local pipeSide = math.random() * 8

cursedCurveWall(pipeSide + 0, thilvue(13), 0, 8, 0.12 * dir)
cursedCurveWall(pipeSide + 4, thilvue(13), 0, 8, 0.12 * dir)

	for a = 1, 4 do
		for i = 0, 2 do
			cursedWall(t + i * 2 + a, thilvue(1), a * thilvue(3), 6)
		end
	end
end

function crstRandomBarrage(mLength)
t = getRandomSide()
oldT = t
m = 0
tAdd = math.random(-3, 2)

sides = 6

	for a = 1, 2 + mLength do
		oldT = t

		cursedBarrage((t / 6) * sides - (sides - 1), thilvue(1), (a - 1) * thilvue(4.6), sides, sides - 1)

		tAdd = math.random(-2, 3) * 1
		t = t + tAdd
		m = tAdd * getNegative(tAdd)
		
		sides = 6 - m
	end

end

function crstPyramidVortex(mLength)
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, 2 + mLength do
		cursedBarrage(t + m + 1, thilvue(1), a * thilvue(4.2), 6, 2)
		cursedBarrage(t + m + 4, thilvue(1), a * thilvue(4.2), 6, 2)
		cursedWall((((t + m)  / 6) * 3) + 0.75, thilvue(1), a * thilvue(4.2), 3)
		cursedWall((((t + m)  / 6) * 3) + 2.25, thilvue(1), a * thilvue(4.2), 3)
		
		m = m + d
	end
	
end

function crstRealisticSpiral(mLength)
t = getRandomSide() * 5

for a = 0, mLength do
	cursedSkewedWall(t + 2 - a, 0, thilvue(3), a * thilvue(0.5), thilvue(0.5), 30)
	cursedSkewedWall(t + 17 - a, 0, thilvue(3), a * thilvue(0.5), thilvue(0.5), 30)
end

end

function crstWhatWalls(mCount)
t = getRandomSide() * 5
local sides = math.random(4, 6)
local thickness = math.random() * 1.5 + 0.6

for a = 0, mCount do
	cursedSkewedWall(math.random() * sides, math.random() * (0.225 *  (sides / 6)) * getRandomDir() * thickness, thilvue(thickness), math.random() * (a + 2) * 20, math.random() * 50 * getRandomDir(), sides)
end

end

function crstBrokenGameSynth()
t = getRandomSide()
--[[
	cursedSkewedWall(t, -1, thilvue(0.5), thilvue(1.75), 0, 6)
	cursedSkewedWall(t + 1, -1, thilvue(0.5), thilvue(1.75), 0, 6)
	cursedSkewedWall(t + 2, -1, thilvue(0.5), thilvue(1.75), 0, 6)]]
	
	
	cursedSkewedWall(t + 0, 0, thilvue(0.5), thilvue(1), thilvue(1), 6)
	cursedSkewedWall(t + 1, 0, thilvue(0.5), thilvue(0), thilvue(1), 6)
	cursedSkewedWall(t + 2, 0, thilvue(0.5), thilvue(0), thilvue(0), 6)
	cursedSkewedWall(t + 3, 0, thilvue(0.5), thilvue(0), thilvue(0), 6)
	cursedSkewedWall(t + 4, 0, thilvue(0.5), thilvue(1), -thilvue(1), 6)
	cursedSkewedWall(t + 5, 0, thilvue(0.5), thilvue(2), -thilvue(1), 6)


end

function crstTriangle()
t = getRandomSide()
local dir = math.random(0, 1)

	cursedWall(t / 2 + 1.5, thilvue(0.7), thilvue(0), 3)
	
	cursedWall(t + 1.5, thilvue(5.5), thilvue(0), 6)
	cursedWall(t + 4.5, thilvue(5.5), thilvue(0), 6)
	
	cursedWall(t - 0.5 + dir, thilvue(0.7), thilvue(0), 6)
	
	cursedWall(t / 2 + 3, thilvue(0.7), thilvue(5), 3)
	
	cursedWall(t + 1.5, thilvue(0.7), thilvue(5), 6)
	cursedWall(t + 4.5, thilvue(0.7), thilvue(5), 6)

	cursedWall(t + 3.5 - dir, thilvue(0.7), thilvue(5), 6)
	
end

function crstOddestBarrage(mLength)
t = getRandomSide()
local extra = math.random(0, 1)

	for a = 0, mLength - 1 do
		if (a + extra) % 2 == 1 then
			cursedWall(t / 2 + 1.25, thilvue(1.5), thilvue(a * 3.2), 3)
			cursedWall(t / 2 + 2.75, thilvue(1.5), thilvue(a * 3.2), 3)
		else
			cursedWall(t + 1, thilvue(1), thilvue(a * 3.2), 6)
			cursedWall(t + 4, thilvue(1), thilvue(a * 3.2), 6)
		end
	
	end

end

function crstBarrageCap(mLength)
t = getRandomSide()
local dir = getRandomDir()

	cursedBarrage(t + 0, thilvue(1), thilvue(0), 6, 5)
	cursedWall((t * 4) / 6 - 0.666, thilvue(1), thilvue(4), 4)
	cursedWall((t * 4) / 6 + 1.5 - 0.666, thilvue(1), thilvue(4), 4)
	cursedWall((t * 4) / 6 + 2.5 - 0.666, thilvue(1), thilvue(4), 4)
	cursedBarrage(t + 0, thilvue(1), thilvue(8), 6, 5)
	
	if mLength == 2 then
	cursedWall((t * 4) / 6 - 0.666, thilvue(1), thilvue(12), 4)
	cursedWall((t * 4) / 6 + 1.5 - 0.666, thilvue(1), thilvue(12), 4)
	cursedWall((t * 4) / 6 + 2.5 - 0.666, thilvue(1), thilvue(12), 4)
	cursedBarrage(t + 0, thilvue(1), thilvue(16), 6, 5)
	end
end

function crstUglyBarrageSpiral(mLength)
t = getRandomSide()
d = getRandomDir()


	for a = 1, mLength do
		for i = 1, 5 do
		cursedWall(t + i + (a - 1) * d * 1.25, thilvue(1), thilvue((a - 1) * 3.5) + math.random() * 18, 6)
		end
	end
end



function gonWall(mSide, mThickness)
	for i = 1, 5 do
		wImpWall(i + (mSide * 5), mThickness)
	end
end

function gonBarrage(mSide, mThickness, mGap)
	for i = 1, 6 - mGap do
		gonWall(i + mSide, mThickness)
	end
end

function gonDoubleBarrage(mSide, mThickness)
	for i = 2, 4 do
		gonWall(i + mSide, mThickness)
	end
	gonWall(mSide, mThickness)
end

function gonBarrageSpiral()
t = math.random(1, 6)
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
		t_eval("gonBarrage(t + m, 30, 1)")
		
		t_eval("m = m + d")
		t_wait(custWait(4.5))
	end
	
	t_wait(custWait(8))
end

function gonAltBarrage()
t = math.random(1, 6)
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
		t_eval("gonWall(t + m, 30)")
		t_eval("gonWall(t + m + 2, 30)")
		t_eval("gonWall(t + m + 4, 30)")
		
		t_eval("m = m + 1")
		t_wait(custWait(4.5))
	end
	
	t_wait(custWait(8))
end

function gonMirrorSpiral()
t = math.random(1, 6)
m = 0
d = getRandomDir()

	for a = 1, math.random(4, 6) do
		t_eval("gonWall(t + m, 30)")
		t_eval("gonWall(t + m + 3, 30)")
		
		t_eval("m = m + d")
		t_wait(custWait(3.5))
	end
	
	t_wait(custWait(8))
end

function gonTunnel()
t = math.random(1, 6)
d = getRandomDir()
times = math.random(1, 3)

	gonWall(t, custThickness(9.5 * times) + 30)

	for a = 1, times + 1 do
		t_eval("gonBarrage(t + d, 30, 1)")
		
		t_eval("d = d * -1")
		t_wait(custWait(9.5))
	end
	
	t_wait(custWait(8))
end

function gonBarrageLRs()
t = math.random(1, 6)
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
		t_eval("gonBarrage(t + m, 30, 1)")
		
		t_eval("m = m + d")
		t_eval("d = d * -1")
		t_wait(custWait(4.5))
	end
	
	t_wait(custWait(8))
end

function gonBarrageInverts()
t = math.random(1, 6)
m = 0

	for a = 1, math.random(3, 5) do
		t_eval("gonBarrage(t + m, 30, 1)")
		
		t_eval("m = m + 3")
		t_wait(custWait(7.25))
	end
	
	t_wait(custWait(8))
end

function gonDoubleBarrageSpiral()
t = math.random(1, 6)
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
		t_eval("gonDoubleBarrage(t + m, 30)")
		
		t_eval("m = m + d")
		t_wait(custWait(4.5))
	end
	
	t_wait(custWait(8))
end

function gonDoubleBarrageLRs()
t = math.random(1, 6)
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
		t_eval("gonDoubleBarrage(t + m, 30)")
		
		t_eval("m = m + d")
		t_eval("d = d * -1")
		t_wait(custWait(4.5))
	end
	
	t_wait(custWait(8))
end

function gonDoubleBarrageInverts()
t = math.random(1, 6)
m = 0

	for a = 1, math.random(3, 5) do
		t_eval("gonDoubleBarrage(t + m, 30)")
		
		t_eval("m = m + 3")
		t_wait(custWait(4.5))
	end
	
	t_wait(custWait(8))
end


function whatFractalWall(mSide, mThickness, mDistance, mSideCount, mWidth)

	if u_getDifficultyMult() == 1 then
		for i = 0, math.ceil(mThickness / 8) do
			qye = i * 8
			wImpWall(mSide, qye + mDistance - 1605, 0, 8, mSideCount, 255, 255, 255, 255, 0, mWidth)
		end
	else 
		for i = 0, math.floor(mThickness / 20) do
			qye = i * 20
			wImpWall(mSide, qye + mDistance - 1605, 0, 24, mSideCount, 255, 255, 255, 255, 0, mWidth)
		end
		wImpWall(mSide, qye + mDistance - 1605,   0, mThickness - qye, mSideCount, 255, 255, 255, 255, 0, mWidth)
	end
end

function whatFractal(mTimes, mSideAdd, mSideMult, mSideCount, mThickness, mDistance, mDistanceAdd, mWidth)
	for a = 0, mTimes - 1 do
		for i = 1, math.floor(mSideCount / mSideMult) do
		whatFractalWall(i * mSideMult + a * mSideAdd, mThickness, mDistance + a * mDistanceAdd, mSideCount, mWidth)
		end
	end
end

function whatWalls(mSide, mThickness)
	if u_getDifficultyMult() == 1 then
		for i = 1, math.ceil(mThickness / 8) do
			qye = i * 8
			wImpWall(mSide, qye, l_getSpeedMult() * 5.05, 8, 6, 255, 255, 255, 255, 0, 1)
		end
	else
		for i = 1, math.floor(mThickness / 20) do
			qye = i * 20
			wImpWall(mSide, qye, l_getSpeedMult() * 5.05, 24, 6, 255, 255, 255, 255, 0, 1)
		end	
	wImpWall(mSide, qye, l_getSpeedMult() * 5.05, mThickness - qye, 6, 255, 255, 255, 255, 0, 1)
	end
end

function whatBarrage(mSide, mThickness)
	for i = 1, 5 do
		qye = i
		whatWalls(mSide + i, mThickness)
	end
end

function whatDoubleBarrage(mSide, mThickness)
	for i = 2, 4 do
		qye = i
		whatWalls(mSide + i, mThickness)
	end
	
	whatWalls(mSide, mThickness)
end


function whatBarrageSpiral()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
	t_eval("whatBarrage(t + m, 40)")
	t_eval("m = m + d")
	
	t_wait(custWait(4.5))
	end


t_wait(custWait(8))
end

function whatAltBarrage()
t = getRandomSide()
m = 0

	for a = 1, math.random(3, 5) do
	t_eval("whatWalls(t + m, 40)")
	t_eval("whatWalls(t + m + 2, 40)")
	t_eval("whatWalls(t + m + 4, 40)")
	t_eval("m = m + 1")
	
	t_wait(custWait(4.5))
	end


t_wait(custWait(8))
end

function whatTunnel()
t = getRandomSide()
d = getRandomDir()
times = math.random(1, 3)

	whatWalls(t, custThickness(9.625 * times) + 40)
	
	for a = 1, times + 1 do
	t_eval("whatBarrage(t + d, 60)")
	t_eval("d = d * -1")
	
	t_wait(custWait(9.5))
	end


t_wait(custWait(4))
end

function whatMirrorSpiral()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
	t_eval("whatWalls(t + m, 60)")
	t_eval("whatWalls(t + m + 3, 60)")
	t_eval("m = m + d")
	
	t_wait(custWait(3.5))
	end


t_wait(custWait(8))
end

function whatDoubleTunnel()
t = getRandomSide()
d = getRandomDir()
times = math.random(3, 5)

	whatWalls(t, custThickness(4.1 * times) + 20)
	whatWalls(t + 3, custThickness(4.1 * times) + 20)
	
	for a = 1, times + 1 do
	t_eval("whatWalls(t + d, 40)")
	t_eval("whatWalls(t + d + 3, 40)")
	t_eval("whatWalls(t, 40)")
	t_eval("whatWalls(t + 3, 40)")
	t_eval("d = d * -1")
	
	t_wait(custWait(4))
	end


t_wait(custWait(7))
end

function whatBarrageInverse()
t = getRandomSide()
m = 0

	for a = 1, math.random(3, 5) do
	t_eval("whatBarrage(t + m, 40)")
	t_eval("m = m + 3")
	
	t_wait(custWait(7.5))
	end


t_wait(custWait(8))
end

function whatBarrageLRs()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
	t_eval("whatBarrage(t + m, 40)")
	t_eval("m = m + d")
	t_eval("d = d * -1")
	
	t_wait(custWait(4.5))
	end


t_wait(custWait(8))
end

function whatDoubleBarrageSpiral()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
	t_eval("whatDoubleBarrage(t + m, 40)")
	t_eval("m = m + d")
	
	t_wait(custWait(4.5))
	end


t_wait(custWait(8))
end

function whatDoubleBarrageLRs()
t = getRandomSide()
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
	t_eval("whatDoubleBarrage(t + m, 40)")
	t_eval("m = m + d")
	t_eval("d = d * -1")
	
	t_wait(custWait(4.5))
	end


t_wait(custWait(8))
end

function whatDoubleBarrageInverts()
t = getRandomSide()
m = 0

	for a = 1, math.random(3, 5) do
	t_eval("whatDoubleBarrage(t + m, 40)")
	t_eval("m = m + 3")
	
	t_wait(custWait(4.5))
	end


t_wait(custWait(8))
end


addT = math.random(-2, 3)

function confinedWall(mSide, mThickness)
	wImpWall(mSide, 2000, l_getSpeedMult(), mThickness, 6, 0)
end

function confinedBarrage(mSide, mThickness, mGap)
	for i = 1, 6 - mGap do
		confinedWall(mSide + i, mThickness)
	end
end

function confinedDoubleBarrage(mSide, mThickness)
	for i = 2, 4 do
		confinedWall(mSide + i, mThickness)
	end
	confinedWall(mSide, mThickness)
end

function confBarrageSpiral()
addT = math.random(-2, 3)
t = t + addT
d = getRandomDir()

	t_wait(custWait(4.5))

	for a = 1, math.random(3, 5) - 1 do
		t_eval("confinedBarrage(t + m, 40, 1)")
		t_eval("m = m + d")
		
		t_wait(custWait(4.5))
	end

	t_eval("confinedBarrage(t + m, 40, 1)")
		t_eval("m = m + d")
end

function confAltBarrage()
addT = 0
t = t + math.random(1, 6)

	t_wait(custWait(4.5))

	for a = 1, math.random(3, 5) - 1 do
		t_eval("confinedWall(t + m, 40)")
		t_eval("confinedWall(t + m + 2, 40)")
		t_eval("confinedWall(t + m + 4, 40)")
		t_eval("m = m + 1")
		
		t_wait(custWait(4.5))
	end

		t_eval("confinedWall(t + m, 40)")
		t_eval("confinedWall(t + m + 2, 40)")
		t_eval("confinedWall(t + m + 4, 40)")
end

function confTunnel()
addT = math.random(-2, 3)
t = t + addT
d = getRandomDir()
times = math.random(1, 3)

	t_wait(custWait(4.5))

	t_eval("confinedWall(t, custThickness((9.5 / delay) * times) + 40)")
		
	for a = 1, times + 1 do
		t_eval("confinedBarrage(t + d, 40, 1)")

		t_eval("d = d * -1")
	
		if a <= times then
			t_wait(custWait(9.5 / delay))
		end
	end
	
end

function confMirrorSpiral()
addT = 0
t = t + math.random(1, 6)
d = getRandomDir()

t_wait(custWait(4.5))

	for a = 1, math.random(4, 6) - 1 do
		t_eval("confinedWall(t + m, custThickness(1.8 / delay))")
		t_eval("confinedWall(t + m + 3, custThickness(1.8 / delay))")
		t_eval("m = m + d")
		
		t_wait(custWait(1.8 / delay))
	end

	t_eval("confinedWall(t + m, custThickness(1.8 / delay))")
	t_eval("confinedWall(t + m + 3, custThickness(1.8 / delay))")
		t_eval("m = m + d")

end

function confOddAltBarrage()
addT = 0
t = t + math.random(1, 6)
d = getRandomDir()

	t_wait(custWait(4.5))

	for a = 1, math.random(3, 5) - 1 do
		t_eval("confinedWall(t + d, 40)")
		t_eval("confinedWall(t - d + 1, 40)")
		t_eval("confinedWall(t + d + 3, 40)")
		t_eval("confinedWall(t - d + 4, 40)")
		t_eval("d = d * -1")
	
		t_wait(custWait(4.5))
	end

	t_eval("confinedWall(t + d, 40)")
	t_eval("confinedWall(t - d + 1, 40)")
	t_eval("confinedWall(t + d + 3, 40)")
	t_eval("confinedWall(t - d + 4, 40)")
end

function confDoubleBarrageSpiral()
addT = math.random(-2, 3)
t = t + addT
d = getRandomDir()

	t_wait(custWait(4.5))

	for a = 1, math.random(3, 5) - 1 do
		t_eval("confinedDoubleBarrage(t + m, 40)")
		t_eval("m = m + d")
		
		t_wait(custWait(4.5))
	end

	t_eval("confinedDoubleBarrage(t + m, 40)")
	t_eval("m = m + d")
end

function confDoubleBarrageLRs()
addT = math.random(-2, 3)
t = t + addT
d = getRandomDir()

	t_wait(custWait(4.5))

	for a = 1, math.random(3, 5) - 1 do
		t_eval("confinedDoubleBarrage(t + m, 40)")
		t_eval("m = m + d")
		t_eval("d = d * -1")
		
		t_wait(custWait(4.5))
	end

	t_eval("confinedDoubleBarrage(t + m, 40)")
	t_eval("m = m + d")
end



function gradWallFractal(mSide, mThickness, mDistance)
	wImpWall(mSide + 2, mDistance, 1, mThickness, 30, 0, 0, 0, 255, 1)

end

function gradWallBase(mSide, mThickness)
	qye = 0

	for i = 0, math.floor(mThickness / 20) - 1 do
		qye = i * 20
		wImpWall(mSide, 1605 + qye, 1, 20, 30, 0, 0, 0, 255, 0)
	end
	
	wImpWall(mSide, 1605 + qye, 1, mThickness - qye, 30, 0, 0, 0, 255, 0)
end


function gradWall(mSide, mThickness)

	for i = 2, 6 do
		gradWallBase(mSide * 5 + i, mThickness)
	end
end

function gradBarrage(mSide, mThickness, mGap)

	for i = 1, 6 - mGap do
		gradWall(mSide + i, mThickness)
	end
end

function gradDoubleBarrage(mSide, mThickness)

	for i = 2, 4 do
		gradWall(mSide + i, mThickness)
	end
	gradWall(mSide, mThickness)
end


function gradBarrageSpiral()
t = getRandomSide() 
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
		t_eval("gradBarrage(t + m, 40, 1)")
		
		t_eval("m = m + d")
		
		t_wait(custWait(4.5))
	end

	t_wait(custWait(7))
end

function gradBarrageLRs()
t = getRandomSide() 
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
		t_eval("gradBarrage(t + m, 40, 1)")
		
		t_eval("m = m + d")
		t_eval("d = d * -1")
		
		t_wait(custWait(4.5))
	end

	t_wait(custWait(7))
end

function gradBarrageInverts()
t = getRandomSide() 
m = 0

	for a = 1, math.random(3, 5) do
		t_eval("gradBarrage(t + m, 40, 1)")
		
		t_eval("m = m + 3")
		
		t_wait(custWait(6.5))
	end

	t_wait(custWait(7))
end

function gradAltBarrage()
t = getRandomSide() 
m = 0

	for a = 1, math.random(3, 5) do
		t_eval("gradWall(t + m, 40)")
		t_eval("gradWall(t + m + 2, 40)")
		t_eval("gradWall(t + m + 4, 40)")
		
		t_eval("m = m + 1")
		
		t_wait(custWait(4.5))
	end

	t_wait(custWait(7))
end

function gradMirrorSpiral()
t = getRandomSide() 
m = 0
d = getRandomDir()

	for a = 1, math.random(3, 5) do
		t_eval("gradWall(t + m, custThickness(2.2))")
		t_eval("gradWall(t + m + 3, custThickness(2.2))")
		
		t_eval("m = m + d")
		
		t_wait(custWait(2.2))
	end

	t_wait(custWait(7))
end

function gradTunnel()
t = getRandomSide() 
d = getRandomDir()
times = math.random(1, 3)

	gradWall(t, custThickness(times * 8) + 40)
		
	for a = 1, times + 1 do
		t_eval("gradBarrage(t + d, 40, 1)")
		
		t_eval("d = d * -1")
		
		t_wait(custWait(8))
	end

	t_wait(custWait(7))
end

function gradAltHalf()
t = getRandomSide() 
m = 0

	for a = 1, math.random(3, 5) do
		t_eval("gradWall(t + m, 40)")
		t_eval("gradWall(t + m + 1, 40)")
		t_eval("gradWall(t + m + 2, 40)")
		
		t_eval("m = m + 3")
		
		t_wait(custWait(4.5))
	end

	t_wait(custWait(7))
end

function gradDoubleBarrageSpiral()
t = getRandomSide() 
m = 0
d = getRandomDir()

	for a = 1, math.random(4, 5) do
		t_eval("gradDoubleBarrage(t + m, 40)")
		
		t_eval("m = m + d")
		
		t_wait(custWait(4.5))
	end

	t_wait(custWait(7))
end

function gradDoubleBarrageLRs()
t = getRandomSide() 
m = 0
d = getRandomDir()

	for a = 1, math.random(4, 5) do
		t_eval("gradDoubleBarrage(t + m, 40)")
		
		t_eval("m = m + d")
		t_eval("d = d * -1")
		
		t_wait(custWait(4.5))
	end

	t_wait(custWait(7))
end

function gradDoubleBarrageInverts()
t = getRandomSide() 
m = 0

	for a = 1, math.random(4, 5) do
		t_eval("gradDoubleBarrage(t + m, 40)")
		
		t_eval("m = m + 3")
		
		t_wait(custWait(4.5))
	end

	t_wait(custWait(7))
end

red = 1
blue = 2 
white = 3

clr = 0

function switchWall(mSide, mThickness, mColor)
	wImpWall(mSide, 1605, l_getSpeedMult() * 5.05, mThickness, 6, 255, 255, 255, 255, mColor)
end

function switchBarrage(mSide, mThickness, mColor, mGap)
	for i = 1, 6 - mGap do
		switchWall(mSide + i, mThickness, mColor)
	end
end


function switchBarrageSpiral()
t = getRandomSide()
m = 0
d = getRandomDir()
clr = getRandomDir()

	for a = 1, math.random(4, 6) do
		t_eval("switchBarrage(t + m, 40, white, 1)")
		
		t_eval("switchWall(t + m, 40, clr * 0.5 + 1.5)")
		
		t_eval("clr = clr * -1")
		t_eval("m = m + d")
		
		t_wait(custWait(4.5))
	end

	t_wait(custWait(7))
end

function switchAltBarrage()
t = getRandomSide()
m = 0
clr = math.random(0, 1)

	for a = 1, math.random(4, 6) do
		t_eval("switchWall(t + m, 40, (clr) % 2 + 1)")
		t_eval("switchWall(t + m + 2, 40, (clr) % 2 + 1)")
		t_eval("switchWall(t + m + 4, 40, (clr) % 2 + 1)")
		
		t_eval("switchWall(t + m + 1, 40, (clr + 1) % 2 + 1)")
		t_eval("switchWall(t + m + 3, 40, (clr + 1) % 2 + 1)")
		t_eval("switchWall(t + m + 5, 40, (clr + 1) % 2 + 1)")
		
		t_eval("m = m + 1")
		
		t_wait(custWait(4.5))
	end

	t_wait(custWait(7))
end






