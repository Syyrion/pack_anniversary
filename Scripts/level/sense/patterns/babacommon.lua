-- these are mainly to make complicated things simpler, they arent required, but useful as all heck!
u_execScript("utils.lua")
u_execScript("common.lua")

isPressed = 0



function getThirdSides() return math.ceil(l_getSides() / 3) end

function getQuarterSides() return math.ceil(l_getSides() / 4) end

function getQuintSides() return math.ceil(l_getSides() / 5) end

function getHexaSides() return math.ceil(l_getSides() / 6) end

function getOctaSides() return math.ceil(l_getSides() / 8) end

function getBarrageSide() return l_getSides() - 1 end

-- measured in degrees, you can easily convert to radians with math.rad(getSideAngle(mSide))
function getSideAngle(mSide) return (mSide * 360 / l_getSides()) end

-- yes this is almost entirely useless. if you cant deal with my yandere dev ways of 'its my code gtfo' then youll have to face the power of no indents and numbers!!1!!!1!11!
function levelTimeSine(mSpeed, mDelay) return math.sin(l_getLevelTime() * mSpeed - mDelay) end

function isEven(mValue, mMax)
	if math.floor(mValue) % 2 == 1 then
		return false
	else
		return true
	end
end

function getRotationDir()
	if l_getRotationSpeed() > 0 then
		return 1
	elseif l_getRotationSpeed() < 0 then
		return -1
	else
		return 0
	end
end

-- getRotationDir() made me realise how useful it could be to check for if a value is negative, or the 'direction' of a value
function getNegative(mValue)
	if mValue > 0 then -- the reason why it checks if the value is ABOVE 0, and not ABOVE OR EQUAL TO 0, is because... 0 isnt a direction at all
		return 1
	elseif mValue < 0 then
		return -1
	else
		return 0
	end
end

--[[ i find it overly tedious to put a value "inside" two set numbers, so i decided to just make this for myself, i dont care really ]]
function closeValue(mValue, mMin, mMax)
	if mValue < mMin then
		mValue = mMin
	elseif mValue > mMax then
		mValue = mMax
	end
	
	return mValue
end

--[[ i found it really werid how onIncrement() works when all the walls are gone, not as soon as
it levels up, this is a form of replacement ]]
isLeveled = 0

function hasLeveledUp()
	if u_isFastSpinning() then
		if isLeveled == 0 then
			isLeveled = 1
			return true
		else
			return false
		end
	
	else
		isLeveled = 0
	end
end

-- doing the sync through an equasion here is more accurate than the way i did it, as it includes more decimals
-- it was already crazy precise though, but this makes it so much easier, and it gets extra precision while there so
function getSync(mTempo, mDivision) return ((mTempo / 60) ^ -1) / mDivision end

syncTimer = 0

-- i am a pulse addict
function syncPulse(mSync, mPulseSpeed, mPulseSpeedR, mDirection, mRevDelay)

	if l_getLevelTime() > syncTimer then
		syncTimer = syncTimer + mSync
		
		if mDirection == 1 then
			l_setPulseSpeed(mPulseSpeed)
			l_setPulseSpeedR(0)
		elseif mDirection == -1 then
			l_setPulseSpeed(0)
			l_setPulseSpeedR(mPulseSpeedR)
		end
	end
	
	if l_getLevelTime() > syncTimer - mSync + mRevDelay then
		if mDirection == 1 then
			l_setPulseSpeed(0)
			l_setPulseSpeedR(mPulseSpeedR)
		elseif mDirection == -1 then
			l_setPulseSpeed(mPulseSpeed)
			l_setPulseSpeedR(0)
		end
	end
	
	
end


-- returns true if the player is moving, else false
function isMoving()
	if u_isKeyPressed(0) or u_isKeyPressed(3) or u_isKeyPressed(71) or u_isKeyPressed(72) or u_isMouseButtonPressed(0) or u_isMouseButtonPressed(1) then
	return true
	else
	return false
	end
end

-- returns true if the player has pressed, but not held, else false
function isTapped()
	if u_isKeyPressed(0) or u_isKeyPressed(3) or u_isKeyPressed(71) or u_isKeyPressed(72) or u_isMouseButtonPressed(0) or u_isMouseButtonPressed(1) then
		if isPressed == 0 then
		isPressed = 1
		return true
		end
	else
	isPressed = 0
	return false
	end
end

-- functions that return true if the player is moving left, or right, else false
function isMovingLeft()
	if u_isKeyPressed(0) or u_isKeyPressed(71) or u_isMouseButtonPressed(0) then
		return true
	else
		return false
	end

end

function isMovingRight()
	if u_isKeyPressed(3) or u_isKeyPressed(72) or u_isMouseButtonPressed(1) then
		return true
	else
		return false
	end

end

invincibilityTimer = 1
invincibilityDuration = 0

function emergencyInvinciblity(mWait, mDuration)
	if l_getLevelTime() > invincibilityTimer then
		invincibilityTimer = l_getLevelTime() + mWait
		invincibilityDuration = l_getLevelTime() + mDuration
		l_setSwapEnabled(false)
	end
end

function emergencyInvinciblityReset()
	if l_getLevelTime() > invincibilityDuration then
		l_setTutorialMode(false)
	else
		l_setTutorialMode(true)
	end
	
	if l_getLevelTime() > invincibilityTimer then
		l_setSwapEnabled(true)
	end
end

delayOverride = 1

function custWait(mDelay)
	return (getPerfectDelayDM(THICKNESS) * (mDelay * delayOverride) * (u_getSpeedMultDM()) / 2)
end

--[[ if your confused on why its based on delay, thats because this is specifically used in tunnel patterns!
because of the large wall needing to have  a calculation for its size it cant be based on getPerfectDelay()

instead it uses regular THICKNESS (depends actually, ill update this if that changes) ]]
function custThickness(mDelay)
	return ((THICKNESS * u_getDelayMultDM()) * (mDelay * delayOverride) * (u_getSpeedMultDM()) / 2)
end

-- because of how fixed delay is with this, this function will let you multiply the delay and thickness functions above
-- a good example is skytrace,  a level with high speed, the delay however makes the patterns spaced out, which isnt the
-- main appeal of that level, so this is used to lower the delay to make it harder
function overrideDelay(mDelay)
delayOverride = mDelay
end

function cHalf(mSide, mThickness)
	for i = 1, getHalfSides() do
		w_wall(i + mSide, mThickness)
	end
end
