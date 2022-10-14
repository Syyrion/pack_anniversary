-- Include useful files or existing libraries. These are found in the `Scripts`
-- folder.
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execScript("level/mpp/commonpatternsv2.lua")
u_execScript("level/mpp/expatterns.lua")
u_execScript("level/mpp/hxdshexpatterns.lua")
l_setShadersRequired(true)
loopcount = 1
nextLoop = 0.35

-- This function adds a pattern to the level "timeline" based on a numeric key.
function addPattern(mKey)
    --hex patterns from Hexadorsip
		if mKey == 0 then pAltBarrage(math.random(3, 5), 2)
        elseif mKey == 1 then pAltBarrageThick(0, 2)
        elseif mKey == 2 then pBarrageSpiralLeft(math.random(2, 3), 0.85, 1)
        elseif mKey == 3 then pBackAndForth(math.random(3, 4), 0.83)
        elseif mKey == 4 then pBarrageSpiralDouble(math.random(1, 2), 0.96, 1)
        elseif mKey == 5 then pDMInverseBarrage(math.random(1, 2), 1.36)
        elseif mKey == 6 then pMirrorWallStrip(1, 0)
        elseif mKey == 7 then pMirrorWallStripThick(0, 1)
        elseif mKey == 8 then pRandomBarrage(math.random(2, 5), 3.2)
        elseif mKey == 9 then pTunnel(math.random(1, 2))
        elseif mKey == 10 then pTunnelQuadruple(math.random(3, 4), 0.84)
        elseif mKey == 11 then pWallExVortexLL(0, 3, 1)
        elseif mKey == 12 then pBarrageSpiralLR(math.random(2, 3), 1)
        elseif mKey == 13 then pAltBarrageStrip(1, 0)
		end
end
beatCount = 0
-- Shuffle the keys, and then call them to add all the patterns.
-- Shuffling is better than randomizing - it guarantees all the patterns will
-- be called.
keys = { 0, 0, 1, 2, 3, 3, 4, 5, 5, 6, 7, 8, 8, 11, 12, 12, 13 }
shuffle(keys)
index = 0
dys = false
FFrames = 0
BPM = 234
pastRad = 0


--same wall + THICKNESS (created by Exschwasion)
function rWallThick(mSide, THICKNESS)
	w_wall(mSide, THICKNESS)
	w_wall(mSide + getHalfSides(), THICKNESS)
end

--same wall + mThick (created by Exschwasion)
function cWallExThick(mSide, mExtra, mThick)
	w_wall(mSide, mThick);
	loopDir = 1;

	if mExtra < 0 then loopDir = -1 end
	for i = 0, mExtra, loopDir do w_wall(mSide+i, mThick) end
end

--same wall + mThick
function cBarrageThick(mSide, mThick) cBarrageNThick(mSide, 0, mThick) end

--same wall + mThick
function cAltBarrageThick(mSide, mStep, mThick)
	for i = 0, l_getSides() / mStep, 1 do
		w_wall(mSide + i * mStep, mThick)
	end
end

--same wall + mThick
function cAltBarrageThick(mSide, mStep, mThick)
	for i = 0, l_getSides() / mStep, 1 do
		w_wall(mSide + i * mStep, mThick)
	end
end

function pointSpin(theta, x, y, a)
	local r = math.sqrt((x*x) + (y*y))
	local ct = math.atan2(y, x)
	ct = ct + theta
	if a then
		return r * math.cos(ct)
	else
		return r * math.sin(ct)
	end
end

function cwspin(cw, theta)
	--convert to polar
	local x0, y0 = cw_getVertexPos(cw, 0)
	local x1, y1 = cw_getVertexPos(cw, 1)
	local x2, y2 = cw_getVertexPos(cw, 2)
	local x3, y3 = cw_getVertexPos(cw, 3)
	--cringe
	cw_setVertexPos4(cw, 
		pointSpin(theta, x0, y0, true), pointSpin(theta, x0, y0, false), 
		pointSpin(theta, x1, y1, true), pointSpin(theta, x1, y1, false), 
		pointSpin(theta, x2, y2, true), pointSpin(theta, x2, y2, false), 
		pointSpin(theta, x3, y3, true), pointSpin(theta, x3, y3, false)
	)
end
--cw decoration

--layer 1 - rings
cw11 = cw_createNoCollision()
cw12 = cw_createNoCollision()
cw13 = cw_createNoCollision()
cw14 = cw_createNoCollision()
cw15 = cw_createNoCollision()
cw16 = cw_createNoCollision()

cw17 = cw_createNoCollision()
cw18 = cw_createNoCollision()
cw19 = cw_createNoCollision()
cw10 = cw_createNoCollision()
cw1a = cw_createNoCollision()
cw1b = cw_createNoCollision()
--layer 2 - ends
cw21 = cw_createNoCollision()
cw22 = cw_createNoCollision()
cw23 = cw_createNoCollision()
cw24 = cw_createNoCollision()
cw25 = cw_createNoCollision()
cw26 = cw_createNoCollision()
--layer 3 - cross
cw31 = cw_createNoCollision()
cw32 = cw_createNoCollision()
cw33 = cw_createNoCollision()
cw34 = cw_createNoCollision()
cw35 = cw_createNoCollision()
cw36 = cw_createNoCollision()

function cwspawnwalllayer1(cw)
	local length = 400
	local width = 10
	local displacement = 700
	local alpha = 200
	local conical = 10
    cw_setVertexPos(cw, 0, displacement+width, length+conical)
    cw_setVertexPos(cw, 1, displacement+width, 0-length-conical)
    cw_setVertexPos(cw, 2, displacement-width, 0-length)
    cw_setVertexPos(cw, 3, displacement-width, length)
    cw_setVertexColor4Same(cw, alpha, alpha, alpha, 255)
end

function cwspawnwalllayer1a(cw)
local length = 50
local width = 5
local displacement = 570
local alpha = 200
local conical = 0
cw_setVertexPos(cw, 0, displacement+width, length+conical)
cw_setVertexPos(cw, 1, displacement+width, 0-length-conical)
cw_setVertexPos(cw, 2, displacement-width, 0-length)
cw_setVertexPos(cw, 3, displacement-width, length)
cw_setVertexColor4Same(cw, alpha, alpha, alpha, 255)
end

function cwspawnwalllayer2(cw)
	local length = 20
	local width = 3
	local displacement = 350
	local alpha = 255
	local conical = 0
    cw_setVertexPos(cw, 0, displacement+width, length+conical)
    cw_setVertexPos(cw, 1, displacement+width, 0-length-conical)
    cw_setVertexPos(cw, 2, displacement-width, 0-length)
    cw_setVertexPos(cw, 3, displacement-width, length)
    cw_setVertexColor4Same(cw, alpha, alpha, alpha, 255)
end

function cwspawnwalllayer3(cw)
	local length = 4
	local width = 1000
	local displacement = 1350
	local alpha = 200
	local conical = 30
    cw_setVertexPos(cw, 0, displacement+width, length+conical)
    cw_setVertexPos(cw, 1, displacement+width, 0-length-conical)
    cw_setVertexPos(cw, 2, displacement-width, 0-length)
    cw_setVertexPos(cw, 3, displacement-width, length)
    cw_setVertexColor4Same(cw, alpha, alpha, alpha, 255)
end

function cwspawn()
	cwspawnwalllayer1(cw11)
	cwspawnwalllayer1(cw12)
	cwspawnwalllayer1(cw13)
	cwspawnwalllayer1(cw14)
	cwspawnwalllayer1(cw15)
	cwspawnwalllayer1(cw16)
	cwspin(cw12, (math.pi/3))
	cwspin(cw13, (math.pi/3)*2)
	cwspin(cw14, (math.pi/3)*3)
	cwspin(cw15, (math.pi/3)*4)
	cwspin(cw16, (math.pi/3)*5)
	cwspawnwalllayer1a(cw17)
	cwspawnwalllayer1a(cw18)
	cwspawnwalllayer1a(cw19)
	cwspawnwalllayer1a(cw10)
	cwspawnwalllayer1a(cw1a)
	cwspawnwalllayer1a(cw1b)
	cwspin(cw18, (math.pi/3))
	cwspin(cw19, (math.pi/3)*2)
	cwspin(cw10, (math.pi/3)*3)
	cwspin(cw1a, (math.pi/3)*4)
	cwspin(cw1b, (math.pi/3)*5)
	cwspawnwalllayer2(cw21)
	cwspawnwalllayer2(cw22)
	cwspawnwalllayer2(cw23)
	cwspawnwalllayer2(cw24)
	cwspawnwalllayer2(cw25)
	cwspawnwalllayer2(cw26)
	cwspin(cw22, (math.pi/3))
	cwspin(cw23, (math.pi/3)*2)
	cwspin(cw24, (math.pi/3)*3)
	cwspin(cw25, (math.pi/3)*4)
	cwspin(cw26, (math.pi/3)*5)
	cwspawnwalllayer3(cw31)
	cwspawnwalllayer3(cw32)
	cwspawnwalllayer3(cw33)
	cwspawnwalllayer3(cw34)
	cwspawnwalllayer3(cw35)
	cwspawnwalllayer3(cw36)
	cwspin(cw32, (math.pi/3))
	cwspin(cw33, (math.pi/3)*2)
	cwspin(cw34, (math.pi/3)*3)
	cwspin(cw35, (math.pi/3)*4)
	cwspin(cw36, (math.pi/3)*5)
end
pulsDist = 10
pulsMin = 20
function hardPulse()
    --the fast beat pulse
    l_setManualPulseControl(true)
    l_setPulse(pulsMin)
    l_setManualPulseControl(false) -- i have no clue whether i actually need to reset the pulse each cycle
    l_setPulseMin(pulsMin)
    l_setPulseMax(pulsMin+pulsDist)
    l_setPulseSpeed(1200)
    l_setPulseSpeedR((pulsDist*1200*BPM)/(4320000-(pulsDist*BPM)))
    l_setPulseDelayMax(0)

end
function roundThousand(mFloat)
	return math.floor(mFloat * 1000 + 0.1)
end
-- `onInit` is an hardcoded function that is called when the level is first
-- loaded. This can be used to setup initial level parameters.
function onInit()
	l_setSpeedMult(1.0)
	l_setSpeedInc(0.1)
	l_setSpeedMax(3.5)
	l_setRotationSpeed(10000)
	l_setRotationSpeedMax(9999)
	l_setRotationSpeedInc(0)
	l_setDelayMult(1.5)
	l_setDelayInc(-0.01)
	l_setFastSpin(0.0)
	l_setSides(6)
	l_setSidesMin(6)
	l_setSidesMax(6)
	l_setIncTime(15)

	l_setPulseMin(60)
	l_setPulseMax(100)
	l_setPulseSpeed(4)
	l_setPulseSpeedR(2)
	l_setPulseDelayMax(18)

	l_setDarkenUnevenBackgroundChunk(false)
	l_setBeatPulseMax(17)
	l_setBeatPulseDelayMax(21.818181818181818181818181818182)

	enableSwapIfDMGreaterThan(2.5)
	disableIncIfDMGreaterThan(3)
end
-- `onLoad` is an hardcoded function that is called when the level is started
-- or restarted.

blackflash = shdr_getShaderId("bc_blackflash.frag")
spinscan = shdr_getShaderId("bc_spinscan.frag")
function onLoad()

	if roundThousand(u_getDifficultyMult()) > roundThousand(1.0) then
		l_setSpeedMult(2.0)
	else
		l_setSpeedMult(1.5)
	end
	e_eval([[cwspawn()]])
    e_eval([[shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, blackflash)]])
    e_eval([[hardPulse()]])
    e_eval([[l_setRadiusMin(40)]])
    e_eval([[l_setBeatPulseMax(10)]])
    e_eval([[l_setBeatPulseDelayMax(3600/234)]])
    e_eval([[l_setBeatPulseSpeedMult(1)]])
    e_eval([[l_setRotationSpeed(0)]])
    e_eval([[t_clear()]])
end

-- `onStep` is an hardcoded function that is called when the level "timeline"
-- is empty. The level timeline is a queue of pending actions.
-- `onStep` should generally contain your pattern spawning logic.
function onStep()
	addPattern(keys[index])
	index = index + 1

	if index - 1 == #keys then
		index = 1
		shuffle(keys)
	end
end

-- `onIncrement` is an hardcoded function that is called when the level
-- difficulty is incremented.
function onIncrement()
	-- ...
end


-- `onUnload` is an hardcoded function that is called when the level is
-- closed/restarted.
function onUnload()
	-- ...
end
ibeatCount = 0
-- `onUpdate` is an hardcoded function that is called every frame. `mFrameTime`
-- represents the time delta between the current and previous frame.
function onUpdate(mFrameTime)

	--sustain cw decoration
	theta = (l_getRotation()*math.pi)/180 - pastRad
	cwspin(cw11, theta)
	cwspin(cw12, theta)
	cwspin(cw13, theta)
	cwspin(cw14, theta)
	cwspin(cw15, theta)
	cwspin(cw16, theta)
	cwspin(cw31, theta)
	cwspin(cw32, theta)
	cwspin(cw33, theta)
	cwspin(cw34, theta)
	cwspin(cw35, theta)
	cwspin(cw36, theta)
	pastRad = (l_getRotation()*math.pi)/180
	if l_getRotationSpeed() > 0 then
		theta = theta + math.random()*10
		cwspin(cw21, theta)
		cwspin(cw22, theta)
		cwspin(cw23, theta)
		cwspin(cw24, theta)
		cwspin(cw25, theta)
		cwspin(cw26, theta)
	end


	if l_getLevelTime() > nextLoop then -- clock
        loopcount = loopcount + 1
        nextLoop = loopcount * (60/234) -- bpm = 234
        --on beat events
		hardPulse()
		shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, blackflash)
		l_setRotationSpeed(10.0+(math.random() * 100.0))

        beatCount = beatCount + 1
		ibeatCount = 0
    end

	if ibeatCount == 20 then
		shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, spinscan)
		if s_get3dSkew() < -1 then
			cw_setVertexColor4Same(cw31, 170, 170, 170, 255)
			cw_setVertexColor4Same(cw32, 170, 170, 170, 255)
			cw_setVertexColor4Same(cw33, 170, 170, 170, 255)
			cw_setVertexColor4Same(cw34, 170, 170, 170, 255)
			cw_setVertexColor4Same(cw35, 170, 170, 170, 255)
			cw_setVertexColor4Same(cw36, 170, 170, 170, 255)
		else
			if roundThousand(u_getDifficultyMult()) >= roundThousand(1.000) then
				cw_setVertexColor4Same(cw31, 250, 0, 0, 255)
				cw_setVertexColor4Same(cw32, 250, 0, 0, 255)
				cw_setVertexColor4Same(cw33, 250, 0, 0, 255)
				cw_setVertexColor4Same(cw34, 250, 0, 0, 255)
				cw_setVertexColor4Same(cw35, 250, 0, 0, 255)
				cw_setVertexColor4Same(cw36, 250, 0, 0, 255)
			end
		end
		if dys then dys = false else dys = true end
		l_setRotationSpeed(0)
	end

	FFrames = FFrames + 1
	--ring colors
	if FFrames % 10 == 0 then
		cw_setVertexColor4Same(cw11, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw12, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw13, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw14, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw15, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw16, 250, 250, 250, 255)

		cw_setVertexColor4Same(cw21, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw22, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw23, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw24, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw25, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw26, 250, 250, 250, 255)
		
		if s_get3dSkew() > -1 then
			cw_setVertexColor4Same(cw17, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw18, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw19, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw10, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw1a, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw1b, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
		else 
			cw_setVertexColor4Same(cw17, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw18, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw19, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw10, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw1a, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw1b, 250, 0, 0, 255)
		end
	end
	if FFrames % 10 == 7 then
		if s_get3dSkew() > -1 then
			cw_setVertexColor4Same(cw11, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw12, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw13, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw14, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw15, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw16, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)

			cw_setVertexColor4Same(cw21, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw22, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw23, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw24, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw25, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
			cw_setVertexColor4Same(cw26, 250*math.sin(FFrames/360), 250*math.cos(FFrames/360), 250, 255)
		else
			cw_setVertexColor4Same(cw11, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw12, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw13, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw14, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw15, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw16, 250, 0, 0, 255)
	
			cw_setVertexColor4Same(cw21, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw22, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw23, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw24, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw25, 250, 0, 0, 255)
			cw_setVertexColor4Same(cw26, 250, 0, 0, 255)
		end
		cw_setVertexColor4Same(cw17, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw18, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw19, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw10, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw1a, 250, 250, 250, 255)
		cw_setVertexColor4Same(cw1b, 250, 250, 250, 255)
	end
	if dys then
		s_set3dSkew(0.01)
		s_set3dDepth(0)
	else
		if roundThousand(u_getDifficultyMult()) >= roundThousand(1.000) then
			s_set3dSkew(-2.01)
			s_set3dDepth(3)
		end
	end
	ibeatCount = ibeatCount + 1
end
function onRenderStage(rs) --cringe

	shdr_setUniformFVec2(spinscan, "u_resolution", u_getWidth(), u_getHeight())
	shdr_setUniformF(spinscan, "u_skew", s_get3dSkew())
	shdr_setUniformF(spinscan, "u_time", l_getLevelTime())

	if roundThousand(u_getDifficultyMult()) > roundThousand(1.001) then
		shdr_setUniformI(spinscan, "u_dd", 0)
	else
		shdr_setUniformI(spinscan, "u_dd", 1)
	end

	shdr_setUniformFVec2(blackflash, "u_resolution", u_getWidth(), u_getHeight())
	shdr_setUniformF(blackflash, "u_skew", s_get3dSkew())
end