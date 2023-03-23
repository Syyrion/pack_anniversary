u_execScript("level/doubletrouble/apeiroutil.lua")
u_execScript("level/doubletrouble/lvlinst.lua")
shader = shdr_getShaderId("splitscreenbg.frag")
invis = shdr_getShaderId("transparent.frag")

-- TODO for next pull request:
-- * Add singleplayer difficulty. Active screen will swap every couple of seconds. Inactive screen will be frozen and darkened
--   Redo patterns to be more interesting now that there will be a playable singleplayer option. No need for repetitive patterns to make playing multiplayer alone barely possible
-- * Potentially more speed options
-- * Make death effect that mimics OH's
-- * Respect invincibility setting when official mode is turned off
--   Fix any bugs if they arise

active = 2
graybg = 0
bgtime = {0,0}
bgspeed = 1
previnc = 0
swapdelay = 2
tracked = "2 sec"

-- Music Sync Config
spb = .48 -- 125 bpm
beatalpha = 0
beatstart = 13.922
musiclen = 203.950
keyframes = {{2,2},{2,4},{4,1},{127,1/14},{1,1/2},{7,1},{164,1/5},{1,1},{64,0}}

function addPattern(key)
	key = (l_getSides() > 5 or key < 7) and key or u_rndInt(0,6)
		if key == 0 then pAltBarrage(u_rndInt(3,6),2)
	elseif key == 1 then pBarrageSpiral(u_rndInt(4,7),l_getSides() > 5 and 1 or .7)
	elseif key == 2 then pSpiral(l_getSides()*u_rndInt(2,3),0)
	elseif key == 3 then THICKNESS = l_getSides() > 5 and 40 or 20 pAltTunnel(u_rndInt(3,5),1) THICKNESS = 40
	elseif key == 4 then pInverseBarrage(u_rndInt(1,2))
	elseif key == 5 then pRandomBarrage(u_rndInt(4,7),2.3)
	elseif key == 6 then pTunnel(1)
	elseif key == 7 then pWallExVortex(0,3,1) end
end

function onInit()
	a_overrideIncrementSound("silence.ogg")
	l_setManualBeatPulseControl(true)
	l_setShadersRequired(true)
	a_syncMusicToDM(false)
	l_setWallSpawnDistance(1300)
	l_setRotationSpeedMax(1)
	l_setRotationSpeed(.075)
	l_setSpeedMult(1.5)
	l_setSpeedInc(.2)
	l_setSides(6)
end

function onLoad()
	multiplayer = u_getDifficultyMult() % .1 > 0
	difficulty = ({"Normal","Hard","Harder"})[math.floor(u_getDifficultyMult()*2)-1]
	if u_inMenu() then return end
	if multiplayer then e_messageAdd("\n\n\n\n\n\nP1: <= LEFT    RIGHT =>\nP2: <= FOCUS    SWAP =>",200)
	else l_addTracked("tracked","Swap Delay") graybg = 2 end
	l_addTracked("difficulty","Difficulty")
	-- Cancels out Config::getZoomFactor() in https://github.com/vittorioromeo/SSVOpenHexagon/blob/master/src/SSVOpenHexagon/Core/HGUpdate.cpp#L776
	l_setPulse(1) l_setPulseMin(math.max(1024/u_getWidth(),768/u_getHeight()))
	shdr_setActiveFragmentShader(RenderStage.BACKGROUNDTRIS,shader)
	shdr_setActiveFragmentShader(RenderStage.PLAYERTRIS,invis)
	shdr_setActiveFragmentShader(RenderStage.PIVOTQUADS,invis)
	l_setRotationSpeed(0)
	s_setPulseMin(1)
	s_setPulseMax(1)
	LVI.new(0,-u_getHeight()/4,-1)
	LVI.new(0,u_getHeight()/4,1)
	LVI[1].keys = {0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7}
	shuffle(LVI[1].keys)
	LVI[2].keys = {0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7}
	shuffle(LVI[2].keys)
	onIncrement(LVI[1])
	onIncrement(LVI[2])
	LVI[1]:update(0)
	LVI[2]:update(0)
	randomizeRotation(ct_create(),1)
	randomizeRotation(ct_create(),2)
	switchActiveScreen(ct_create())
	musicSync(ct_create())
end

function onIncrement(self)
	if not self then
		swapdelay = 4/(1.2^l_getCurrentIncrements()+1)
		tracked = ("%.2f sec"):format(swapdelay)
		return
	end
	self.sides = u_rndInt(5,7)
	self.skewMin = randomFloat(1,1.5)
	self.skewMax = self.skewMin + randomFloat(.5,3)
	self.skewSpeed = randomFloat(.75,2.5)
	self.rsMin = (self.rsMin or .55) + .15
	self.rsMax = (self.rsMax or 1.8) + .2
	self.shader = self.shader or {}
	local hue,alpha,colornum = randomFloat(0,360),randomFloat(.4,.55),u_rndInt(2,3)
	self.shader.colors = {fromHL(hue,alpha),fromHL(hue,alpha*.75),fromHL(hue,alpha*.5)}
	self.shader.uses3C = self.sides ~= 6 or colornum > 2
	self.shader.revLoop = colornum > 2 and u_rndInt(0,1) == 1
	local inverse = u_rndInt(0,1) == 1
	self.shader.funcargs = {
		inverse and 1 or randomFloat(.5,2) * getRandomDir(),
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
		self.rotationSpeed = randomFloat(self.rsMin,self.rsMax) * getRandomDir() * u_getDifficultyMult()
	]],id)
	ct_waitS(timeline,randomFloat(.5,2))
	ct_eval(timeline,"randomizeRotation(%i,%i)",timeline,id)
end

function switchActiveScreen(timeline)
	if multiplayer then return end
	ct_eval(timeline,"active = active == 1 and 2 or 1")
	ct_waitS(timeline,swapdelay*.75)
	local blinks = swapdelay > 1.2 and 2 or 1
	for i = 1,blinks*2+1 do
		ct_eval(timeline,"graybg = graybg == 1 and 2 or 1")
		if i % 2 == 1 then ct_eval(timeline,'a_playSound("beep.ogg")') end
		if i > blinks*2 then break end
		ct_waitS(timeline,swapdelay/8/blinks)
	end
	ct_eval(timeline,"switchActiveScreen(%i)",timeline)
end

function musicSync(timeline,n)
	n = n or 1
	local curmult,time = 1,beatstart + (n-1) * musiclen
	ct_waitUntilS(timeline,time)
	for _,keyframe in ipairs(keyframes) do
		local wait,mult = unpack(keyframe)
		for i = 1,wait do
			ct_eval(timeline,"beatalpha = 1")
			time = time + spb/curmult
			ct_waitUntilS(timeline,time)
		end
		curmult = mult
	end
	ct_waitUntilS(timeline,n*musiclen)
	ct_eval(timeline,"musicSync(%i,%i)",timeline,n+1)
end

function onUpdate(dt)
	dt = dt/60
	for index,instance in ipairs(LVI) do
		instance.incrementing = instance.incrementing or previnc ~= l_getCurrentIncrements()
		if active == index or multiplayer then
			instance:update(dt)
			bgtime[index] = bgtime[index] + bgspeed*dt
		end
	end
	previnc = l_getCurrentIncrements()
	beatalpha = math.max(0,beatalpha - 3 * dt)
	LVI.radius = 40 + 15 * easeInQuad(beatalpha)
end

function onInput(_,p1dir,left,right)
	local p2dir = p1dir
	if multiplayer then
		if left and not right then p2dir,lastdir = lastdir,-1
		elseif right and not left then p2dir,lastdir = lastdir,1
		elseif left and right then p2dir = -lastdir
		else p2dir,lastdir = 0,0 end
	end
	LVI[1].plrDirection = (active == 1 or multiplayer) and p1dir or 0
	LVI[2].plrDirection = (active == 2 or multiplayer) and p2dir or 0
	return true
end

function onDeath()
	dead = true
	if not multiplayer then
		graybg = active == 1 and 2 or 1
	end
end

function onRenderStage(stage,dt)
	if stage ~= RenderStage.BACKGROUNDTRIS then return end
	shdr_setUniformFVec2(shader,"u_resolution",u_getWidth(),u_getHeight())
	-- Scrolling Design
	shdr_setUniformFVec4(shader,"u_s1_fnarg",unpack(LVI[1].shader.funcargs))
	shdr_setUniformFVec4(shader,"u_s2_fnarg",unpack(LVI[2].shader.funcargs))
	shdr_setUniformFVec4(shader,"u_s1_scarg",unpack(LVI[1].shader.scrollargs))
	shdr_setUniformFVec4(shader,"u_s2_scarg",unpack(LVI[2].shader.scrollargs))
	shdr_setUniformF(shader,"u_s1_time",bgtime[1])
	shdr_setUniformF(shader,"u_s2_time",bgtime[2])
	-- Colors
	shdr_setUniformI(shader,"u_colconf", -- Me when no shdr_setUniformBool
		(LVI[1].shader.uses3C  and 8 or 0)+
		(LVI[1].shader.revLoop and 4 or 0)+
		(LVI[2].shader.uses3C  and 2 or 0)+
		(LVI[2].shader.revLoop and 1 or 0))
	shdr_setUniformFVec3(shader,"u_s1_col1",unpack(graybg ~= 1 and LVI[1].shader.colors[1] or grayscale(LVI[1].shader.colors[1])))
	shdr_setUniformFVec3(shader,"u_s1_col2",unpack(graybg ~= 1 and LVI[1].shader.colors[2] or grayscale(LVI[1].shader.colors[2])))
	shdr_setUniformFVec3(shader,"u_s1_col3",unpack(graybg ~= 1 and LVI[1].shader.colors[3] or grayscale(LVI[1].shader.colors[3])))
	shdr_setUniformFVec3(shader,"u_s2_col1",unpack(graybg ~= 2 and LVI[2].shader.colors[1] or grayscale(LVI[2].shader.colors[1])))
	shdr_setUniformFVec3(shader,"u_s2_col2",unpack(graybg ~= 2 and LVI[2].shader.colors[2] or grayscale(LVI[2].shader.colors[2])))
	shdr_setUniformFVec3(shader,"u_s2_col3",unpack(graybg ~= 2 and LVI[2].shader.colors[3] or grayscale(LVI[2].shader.colors[3])))
	-- Transformations
	shdr_setUniformF(shader,"u_s1_sides",LVI[1].sides)
	shdr_setUniformF(shader,"u_s1_angle",-LVI[1].rotation)
	shdr_setUniformF(shader,"u_s1_skew",LVI[1].skew)
	shdr_setUniformF(shader,"u_s2_sides",LVI[2].sides)
	shdr_setUniformF(shader,"u_s2_angle",-LVI[2].rotation)
	shdr_setUniformF(shader,"u_s2_skew",LVI[2].skew)
	
	if not dead then return end
	dt = dt/60
	bgspeed = math.max(0,bgspeed-dt/2)
	for index,instance in ipairs(LVI) do
		if active == index or multiplayer then
			bgtime[index] = bgtime[index] + bgspeed*dt
			instance.rotationSpeed = math.max(0,math.abs(instance.rotationSpeed) - 2*dt) * getSign(instance.rotationSpeed)
			instance:update(dt)
		end
	end
end

function onStep() end
function onUnload() end