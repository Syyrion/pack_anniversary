-- Include useful files or existing libraries. These are found in the `Scripts`
-- folder.
u_execScript("level/mpp/utils.lua")
u_execScript("level/mpp/common.lua")
u_execScript("level/mpp/commonpatterns.lua")
u_execScript("level/mpp/commonpatternsv2.lua")
u_execScript("level/mpp/expatterns.lua")
u_execScript("level/mpp/hxdshexpatterns.lua")

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

function hardPulse()
    --the fast beat pulse
    l_setManualPulseControl(true)
    l_setPulse(120)
    l_setManualPulseControl(false) -- i have no clue whether i actually need to reset the pulse each cycle
    l_setPulseMin(60)
    l_setPulseMax(120)
    l_setPulseSpeed(1200)
    l_setPulseSpeedR(6800/2281)
    l_setPulseDelayMax(1)

end
function slowPulse()
    l_setManualPulseControl(true)
    l_setPulse(120)
    l_setManualPulseControl(false)
    l_setPulseMin(60)
    l_setPulseMax(120)
    l_setPulseSpeed(10)
    l_setPulseSpeedR(170/223)
    l_setPulseDelayMax(0)
end
function stopPulse(rad)
    l_setPulseMin(rad)
    l_setPulseMax(rad)
    l_setRadiusMin(rad)
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0)
    l_setPulseDelayMax(0)
    l_setBeatPulseMax(0)
    l_setBeatPulseDelayMax(0)
    l_setBeatPulseSpeedMult(0)
end
-- `onInit` is an hardcoded function that is called when the level is first
-- loaded. This can be used to setup initial level parameters.
function onInit()
	if u_getDifficultyMult() > 1.0 then
		l_setSpeedMult(2.7)
	else
		l_setSpeedMult(2.0)
	end
	l_setSpeedInc(0.125)
	l_setSpeedMax(3.5)
	l_setRotationSpeed(0)
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
whites = shdr_getShaderId("bc_white.frag")
blacks = shdr_getShaderId("bc_black.frag")
function onLoad()
    e_eval([[shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, blackflash)]])
    e_eval([[u_setFlashEffect(255)]])
    e_eval([[hardPulse()]])
    e_eval([[l_setRadiusMin(40)]])
    e_eval([[l_setBeatPulseMax(10)]])
    e_eval([[l_setBeatPulseDelayMax(3600/234)]])
    e_eval([[l_setBeatPulseSpeedMult(1)]])
    e_eval([[l_setRotationSpeed(0)]])
    e_eval([[t_clear()]])
	--m_messageAdd("pretty", 130)
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
	if l_getLevelTime() > nextLoop then -- clock

        loopcount = loopcount + 1
        nextLoop = loopcount * (60/234) -- bpm = 170
        --on beat events
		shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, blackflash)
		shdr_setActiveFragmentShader(RenderStage.PLAYERTRIS, blacks)
		shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS, blacks)
		shdr_setActiveFragmentShader(RenderStage.CAPTRIS, blacks)
		l_setRotationSpeed(1.0+(math.random() * 100.0)+(math.random() * 10.0))

        beatCount = beatCount + 1
		ibeatCount = 0
    end

	if ibeatCount == 30 then
		shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS, spinscan)
		if u_getDifficultyMult() > 1.0000 then
		else 
			if s_get3dSkew() > 0 then
				shdr_setActiveFragmentShader(RenderStage.PLAYERTRIS, whites)
				shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS, whites)
				shdr_setActiveFragmentShader(RenderStage.CAPTRIS, whites)
			end
		end
		if dys then dys = false else dys = true end
		l_setRotationSpeed(0)
	end

	FFrames = FFrames + 1
	if dys then
		s_set3dSkew(0.1)
	else
		if u_getDifficultyMult() >= 1.0000 then
			s_set3dSkew(-2.1)
		end
	end
	ibeatCount = ibeatCount + 1
end
function onRenderStage(rs) --cringe

	shdr_setUniformFVec2(spinscan, "u_resolution", u_getWidth(), u_getHeight())
	shdr_setUniformF(spinscan, "u_skew", s_get3dSkew())
	shdr_setUniformF(spinscan, "u_time", l_getLevelTime())

	shdr_setUniformFVec2(blackflash, "u_resolution", u_getWidth(), u_getHeight())
	shdr_setUniformF(blackflash, "u_skew", s_get3dSkew())
end