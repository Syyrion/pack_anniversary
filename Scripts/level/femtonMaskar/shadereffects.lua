--ik it says shader effects but this is basically just everything used for femton maskar
--note: put boxes, custom walls here!

function shdrVShiftPulse(mDelay, mDir)
	delay = fpb/mDelay
	
	for i = 0, 50 do
		ct_eval(timelineBGPulse, string.format("vShift = vShift + %f", 5/(i+1) * mDir ))
		ct_wait(timelineBGPulse, delay/64)
	end
end

function shdrColorPulse(mDelay, mRed, mGreen, mBlue, mAlpha)
	delay = fpb/mDelay
	shdrPulseColor = {mRed, mGreen, mBlue, mAlpha}
	
	for i = 0, 100 do
		ct_eval(timelineBGFlash, string.format("shdrPulseColor[1] = math.max(0, %f - %f)", mRed, i/100))
		ct_eval(timelineBGFlash, string.format("shdrPulseColor[2] = math.max(0, %f - %f)", mGreen, i/100))
		ct_eval(timelineBGFlash, string.format("shdrPulseColor[3] = math.max(0, %f - %f)", mBlue, i/100))
		ct_eval(timelineBGFlash, string.format("shdrPulseColor[4] = math.max(0, %f - %f)", mAlpha, i/100))
		ct_wait(timelineBGFlash, delay/64)
	end
end

function shdrColorSet(mDelay, mRed, mGreen, mBlue, mAlpha)
	shdrColor = {mRed, mGreen, mBlue, mAlpha}
end

-- adds blackboxes
function bgBlackBoxes(mDelay, mSpeed)
	delay = fpb/mDelay
	spd = mSpeed/2
	
	ct_wait(timelineBGDiamonds, delay)
	for i = 0, 5 do
		dir = math.random(0, 360)
		ct_eval(timelineBGDiamonds, string.format("wNewDeco(0, 0, 20, 0, 20, 20, 0, 20, 255, 255, 255, 110, %f, 3, 0, %f)", spd, dir))
	end
	ct_eval(timelineBGDiamonds, string.format("bgBlackBoxes(%d, %d)", mDelay, mSpeed))
end

-- adds a blackBOXSPLOSION!!
function bgBlackBoxplosion(mAmount, mSpeed)
	delay = fpb
	spd = mSpeed/3
	
	for i = 0, mAmount/2 do
		dir = math.random(0, 360)
		ct_eval(timelineBGDiamondsPulse, string.format("wNewDeco(0, 0, 20, 0, 20, 20, 0, 20, 255, 255, 255, 180, %f, 3, 0, %f)", spd, dir))
		dir = math.random(0, 360)
		ct_eval(timelineBGDiamondsPulse, string.format("wNewDeco(0, 0, 20, 0, 20, 20, 0, 20, 255, 255, 255, 180, %f, 3, 0, %f)", spd, dir))
		ct_wait(timelineBGDiamondsPulse, delay/(mAmount*4))
	end
end