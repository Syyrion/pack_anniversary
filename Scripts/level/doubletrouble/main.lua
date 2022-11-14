u_execScript("level/doubletrouble/apeiroutil.lua")
u_execScript("level/doubletrouble/lvlinst.lua")
shader = shdr_getShaderId("splitscreenbg.frag")

-- TODO for next pull request:
--   Add singleplayer difficulty. Active screen will swap every couple of seconds. Inactive screen will be frozen and darkened
--   Redo patterns to be more interesting now that there will be a playable singleplayer option. No need for repetitive patterns to make playing multiplater alone barely possible
--   Potentially more speed options
--   Make death effect that mimics OH's
--   Respect invincibility setting when official mode is turned off
--   Fix any bugs if they arise

-- Music Sync Config
spb = .48 -- 125 bpm
beatalpha = 0
beatstart = 13.922
musiclen = 203.950
keyframes = {{2,2},{2,4},{4,1},{127,1/14},{1,1/2},{7,1},{164,1/5},{1,1},{64,0}}

function addPattern(key)
	key = (l_getSides() > 5 or key < 5) and key or u_rndInt(0,4)
		if key == 0 then pAltBarrage(u_rndInt(3,6),2)
	elseif key == 1 then pBarrageSpiral(u_rndInt(5,8))
	elseif key == 2 then pSpiral(l_getSides()*u_rndInt(2,3),0)
	elseif key == 3 then pAltTunnel(u_rndInt(3,6),1)
	elseif key == 4 then pInverseBarrage(u_rndInt(1,2))
	elseif key == 5 then pWallExVortex(0,3,1) end
end

function onInit()
	l_setManualBeatPulseControl(true)
	l_setShadersRequired(true)
	a_syncMusicToDM(false)
	l_setRotationSpeedMax(math.huge)
	l_setRotationSpeed(.075)
	l_setSpeedMult(1.5)
	l_setSpeedInc(.3)
	l_setSides(6)
end

function onLoad()
	if u_inMenu() then return end
	e_messageAdd("\n\n\n\n\n\nP1: <= LEFT    RIGHT =>\nP2: <= FOCUS    SWAP =>",200)
	-- Cancels out Config::getZoomFactor() in https://github.com/vittorioromeo/SSVOpenHexagon/blob/master/src/SSVOpenHexagon/Core/HGUpdate.cpp#L776
	l_setPulse(1) l_setPulseMin(math.max(1024/u_getWidth(),768/u_getHeight()))
	shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS,shader)
	l_setRotationSpeed(0)
	s_setPulseMin(1)
	s_setPulseMax(1)
	LVI.new(0,-u_getHeight()/4,-1)
	LVI.new(0,u_getHeight()/4,1)
	LVI[1].keys = {0,0,1,1,2,2,3,3,4,4,5,5}
	shuffle(LVI[1].keys)
	LVI[2].keys = {0,0,1,1,2,2,3,3,4,4,5,5}
	shuffle(LVI[2].keys)
	onIncrement(LVI[1])
	onIncrement(LVI[2])
	randomizeRotation(ct_create(),1)
	randomizeRotation(ct_create(),2)
	musicSync()
end

function onIncrement(self)
	if not self then return end
	self.sides = u_rndInt(5,7)
	self.skewMin = randomFloat(1,1.5)
	self.skewMax = self.skewMin + randomFloat(.5,3)
	self.skewSpeed = randomFloat(.75,2.5)
	self.rsMin = (self.rsMin or .45) + .15
	self.rsMax = (self.rsMax or 1.8) + .2
	self.shader = self.shader or {}
	local hue,alpha,colornum = randomFloat(0,360),randomFloat(.4,.55),u_rndInt(2,3)
	self.shader.colors = {{shaderColor(hue,alpha)},{shaderColor(hue,alpha*.75)},{shaderColor(hue,alpha*.5)}}
	self.deathColor = {shaderColor(hue+180,.5,255)}
	self.shader.uses3C = self.sides ~= 6 or colornum > 2
	self.shader.revLoop = colornum > 2 and u_rndInt(0,1) == 1
	local inverse = u_rndInt(0,1) == 1
	self.shader.funcargs = {
		inverse and 1 or randomFloat(-2,2),
		inverse and randomFloat(.5,3) or ({0,1,randomFloat(.5,2)})[math.min(u_rndInt(1,5),3)],
		randomFloat(.5,2),
		inverse and 1 or 0
	}
	self.shader.scrollargs = {
		randomFloat(.1,.75) * getRandomDir(),
		randomFloat(.1,.4),
		randomFloat(.1,.9),
		randomFloat(.2,.6),
	}
end

function randomizeRotation(timeline,id)
	ct_eval(timeline,[[
		local self = LVI[%i]
		self.rotationSpeed = randomFloat(self.rsMin,self.rsMax) * getRandomDir()
	]],id)
	ct_waitS(timeline,randomFloat(.5,2))
	ct_eval(timeline,"randomizeRotation(%i,%i)",timeline,id)
end

function musicSync(n)
	n = n or 1
	local curmult,time = 1,beatstart + (n-1) * musiclen
	e_waitUntilS(time)
	for _,keyframe in ipairs(keyframes) do
		local wait,mult = unpack(keyframe)
		for i = 1,wait do
			e_eval("beatalpha = 1")
			time = time + spb/curmult
			e_waitUntilS(time)
		end
		curmult = mult
	end
	e_waitUntilS(n*musiclen)
	e_eval("musicSync(%i)",n+1)
end

function onUpdate(dt)
	dt = dt/60
	LVI.updateAll(dt)
	beatalpha = math.max(0,beatalpha - 3 * dt)
	LVI.radius = 40 + 15 * easeInQuad(beatalpha)
end

function onInput(_,p1dir,left,right)
	local p2dir
	if left and not right then p2dir,lastdir = lastdir,-1
	elseif right and not left then p2dir,lastdir = lastdir,1
	elseif left and right then p2dir = -lastdir
	else p2dir,lastdir = 0,0 end
	LVI[1].plrDirection = p1dir
	LVI[2].plrDirection = p2dir
	return true
end

function onRenderStage(stage)
	if stage ~= RenderStage.BACKGROUNDTRIS then return end
	shdr_setUniformFVec2(shader,"u_resolution",u_getWidth(),u_getHeight())
	shdr_setUniformF(shader,"u_time",l_getLevelTime())
	
	-- Scrolling Design
	shdr_setUniformFVec4(shader,"u_s1_fnarg",unpack(LVI[1].shader.funcargs))
	shdr_setUniformFVec4(shader,"u_s2_fnarg",unpack(LVI[2].shader.funcargs))
	shdr_setUniformFVec4(shader,"u_s1_scarg",unpack(LVI[1].shader.scrollargs))
	shdr_setUniformFVec4(shader,"u_s2_scarg",unpack(LVI[2].shader.scrollargs))
	
	-- Colors
	shdr_setUniformI(shader,"u_colconf", -- Me when no shdr_setUniformBool
		(LVI[1].shader.uses3C  and 8 or 0)+
		(LVI[1].shader.revLoop and 4 or 0)+
		(LVI[2].shader.uses3C  and 2 or 0)+
		(LVI[2].shader.revLoop and 1 or 0))
	shdr_setUniformFVec3(shader,"u_s1_col1",unpack(LVI[1].shader.colors[1]))
	shdr_setUniformFVec3(shader,"u_s1_col2",unpack(LVI[1].shader.colors[2]))
	shdr_setUniformFVec3(shader,"u_s1_col3",unpack(LVI[1].shader.colors[3]))
	shdr_setUniformFVec3(shader,"u_s2_col1",unpack(LVI[2].shader.colors[1]))
	shdr_setUniformFVec3(shader,"u_s2_col2",unpack(LVI[2].shader.colors[2]))
	shdr_setUniformFVec3(shader,"u_s2_col3",unpack(LVI[2].shader.colors[3]))
	
	-- Transformations
	shdr_setUniformF(shader,"u_s1_sides",LVI[1].sides)
	shdr_setUniformF(shader,"u_s1_angle",-LVI[1].rotation)
	shdr_setUniformF(shader,"u_s1_skew",LVI[1].skew)
	shdr_setUniformF(shader,"u_s2_sides",LVI[2].sides)
	shdr_setUniformF(shader,"u_s2_angle",-LVI[2].rotation)
	shdr_setUniformF(shader,"u_s2_skew",LVI[2].skew)
end

function onStep() end
function onUnload() end