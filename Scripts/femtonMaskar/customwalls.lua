-- include useful files
u_execScript("/femtonMaskar/common.lua")

-- our wall
imposterWall = {}
imposterWall.__index = imposterWall
imposterWalls = {}
bgWall = {}
bgWall.__index = bgWall
bgWalls = {}

-- ~~stolen~~ borrowed from babadrake <3
-- imposter walls look like normal walls but can be manipulated

function imposterWall:new(handle)
	local obj = {}
	setmetatable(obj, imposterWall)
	-- Our handle, our name, our identifier
	obj.cwHandle = handle
	-- There are only 2 things certain in life: death and something else
	obj.dead = false
	return obj
end

function imposterWall:move(mFrameTime)
	local range = 2 * math.pi / self.shape
	
	if math.floor(self.thickness) < 1 then self.dead = true end
	
	if math.floor(self.distance) < 1 then
		self.thickness = math.max(self.thickness - (mFrameTime * self.speed), 0)
	else
		self.distance = math.max(self.distance - (mFrameTime * self.speed), 0)
	end
	
	if (self.type == 14 or self.type == 51) and math.floor(self.distance) > 1600 then self.dead = true end
	
	mBlue = self.blue
	mGreen = self.green
	mRed = self.red
	
	if self.type == 5 then
		r1 = self.distance - self.thickness + self.offset
		r2 = self.distance + self.offset
	else
		r1 = self.distance + self.offset
		r2 = self.distance + self.thickness + self.offset
	end
	if self.type == 20 then self.side = self.side + 0.003
	elseif self.type == 21 then self.side = self.side - 0.001
	elseif self.type == 22 then self.side = self.side + 0.002
	elseif self.type == 6 or self.type == 7 or self.type == 8 then self.side = self.side + self.pnum
	end
	if self.type == 6 then
		a1 = (self.side + 0.5) * range
		a2 = (self.side - 0.5) * range
		acc1 = (math.cos(a1)*(0.33))+(math.cos(a2)*(1-0.33))
		acy1 = (math.sin(a1)*(0.33))+(math.sin(a2)*(1-0.33))
		cw_setVertexPos(self.cwHandle, 0, r1 * acc1, r1 * acy1)
		cw_setVertexPos(self.cwHandle, 1, r1 * math.cos(a2), r1 * math.sin(a2))
		cw_setVertexPos(self.cwHandle, 2, r2 * math.cos(a2), r2 * math.sin(a2))
		cw_setVertexPos(self.cwHandle, 3, r2 * acc1, r2 * acy1)
	elseif self.type == 7 then
		a1 = (self.side + 0.5) * range
		a2 = (self.side - 0.5) * range
		acc1 = (math.cos(a1)*(1-0.33))+(math.cos(a2)*(0.33))
		acy1 = (math.sin(a1)*(1-0.33))+(math.sin(a2)*(0.33))
		cw_setVertexPos(self.cwHandle, 0, r1 * math.cos(a1), r1 * math.sin(a1))
		cw_setVertexPos(self.cwHandle, 1, r1 * acc1, r1 * acy1)
		cw_setVertexPos(self.cwHandle, 2, r2 * acc1, r2 * acy1)
		cw_setVertexPos(self.cwHandle, 3, r2 * math.cos(a1), r2 * math.sin(a1))
	else
		a1 = (self.side + 0.5) * range
		a2 = (self.side - 0.5) * range
		cw_setVertexPos(self.cwHandle, 0, r1 * math.cos(a1), r1 * math.sin(a1))
		cw_setVertexPos(self.cwHandle, 1, r1 * math.cos(a2), r1 * math.sin(a2))
		cw_setVertexPos(self.cwHandle, 2, r2 * math.cos(a2), r2 * math.sin(a2))
		cw_setVertexPos(self.cwHandle, 3, r2 * math.cos(a1), r2 * math.sin(a1))
	end
	
	if self.type == 51 then
		cw_setVertexColor(self.cwHandle, 0, 0, 0, 0, self.alpha)
		cw_setVertexColor(self.cwHandle, 1, 0, 0, 0, self.alpha)
		cw_setVertexColor(self.cwHandle, 2, 0, 0, 0, 0)
		cw_setVertexColor(self.cwHandle, 3, 0, 0, 0, 0)
	else
		cw_setVertexColor(self.cwHandle, 0, mRed, mGreen, mBlue, self.alpha)
		cw_setVertexColor(self.cwHandle, 1, mRed, mGreen, mBlue, self.alpha)
		cw_setVertexColor(self.cwHandle, 2, mRed, mGreen, mBlue, self.alpha)
		cw_setVertexColor(self.cwHandle, 3, mRed, mGreen, mBlue, self.alpha)
	end
end

function imposterWall:updateSpeed(mSpeed)
	self.speed = mSpeed
end

function imposterWall:updateThickness(mThickness)
	if self.type == 5 then self.thickness = mThickness end
	if self.thickness < 1 then self.thickness = 1 end
end

function imposterWall:updatePFlag(mPFlag)
	self.pflag = mPFlag --stands for pride flag
end

function imposterWall:updatePNum(mPNum)
	self.pnum = mPNum
end

function bgWall:new(handle)
	local obj = {}
	setmetatable(obj, bgWall)
	-- Our handle, our name, our identifier, our house in the middle of the street
	obj.cwHandle = handle
	-- There are only 2 things certain in life: jack and daxter
	obj.dead = false
	return obj
end

function bgWall:unrotate(mFrameTime)
	mRotation = math.pi*(l_getRotation()/180)
	
	if self.type == 3 or self.type == 50 then
		t0 = math.atan2(self.x0, self.y0)
		r0 = math.sqrt(self.x0^2+self.y0^2)
		t1 = math.atan2(self.x1, self.y1)
		r1 = math.sqrt(self.x1^2+self.y1^2)
		t2 = math.atan2(self.x2, self.y2)
		r2 = math.sqrt(self.x2^2+self.y2^2)
		t3 = math.atan2(self.x3, self.y3)
		r3 = math.sqrt(self.x3^2+self.y3^2)
	elseif self.y0 < 0 then
		t0 = math.atan2(self.x0, (self.y0-self.dir))
		r0 = math.sqrt(self.x0^2+(self.y0-self.dir)^2)
		t1 = math.atan2(self.x1, self.y1-self.dir)
		r1 = math.sqrt(self.x1^2+(self.y1-self.dir)^2)
		t2 = math.atan2(self.x2, self.y2-self.dir)
		r2 = math.sqrt(self.x2^2+(self.y2-self.dir)^2)
		t3 = math.atan2(self.x3, self.y3-self.dir)
		r3 = math.sqrt(self.x3^2+(self.y3-self.dir)^2)
	else
		t0 = math.atan2(self.x0, (self.y0+self.dir))
		r0 = math.sqrt(self.x0^2+(self.y0+self.dir)^2)
		t1 = math.atan2(self.x1, self.y1+self.dir)
		r1 = math.sqrt(self.x1^2+(self.y1+self.dir)^2)
		t2 = math.atan2(self.x2, self.y2+self.dir)
		r2 = math.sqrt(self.x2^2+(self.y2+self.dir)^2)
		t3 = math.atan2(self.x3, self.y3+self.dir)
		r3 = math.sqrt(self.x3^2+(self.y3+self.dir)^2)
	end
	
	--x0 = self.x0-math.cos(mRotation)
	--self.y0 = self.y0-math.sin(mRotation)
	--self.x1 = self.x1-math.cos(mRotation)
	--self.y1 = self.y1-math.sin(mRotation)
	--self.x2 = self.x2-math.cos(mRotation)
	--self.y2 = self.y2-math.sin(mRotation)
	--self.x3 = self.x3-math.cos(mRotation)
	--self.y3 = self.y3-math.sin(mRotation)
	
	cw_setVertexPos(self.cwHandle, 0, r0 * math.cos(t0+mRotation), r0 * math.sin(t0+mRotation))
	cw_setVertexPos(self.cwHandle, 1, r1 * math.cos(t1+mRotation), r1 * math.sin(t1+mRotation))
	cw_setVertexPos(self.cwHandle, 2, r2 * math.cos(t2+mRotation), r2 * math.sin(t2+mRotation))
	cw_setVertexPos(self.cwHandle, 3, r3 * math.cos(t3+mRotation), r3 * math.sin(t3+mRotation))
end

function bgWall:falldown(mFrameTime)
	if self.type == 8 then
		if self.x2 > 1100 then self.dead = true
		elseif self.x2 < -1100 then self.dead = true end
	else
		if self.x2 > 800 then self.dead = true
		elseif self.x2 < -800 then self.dead = true end
	end
	
	self.x0 = self.x0-self.speed
	self.x1 = self.x1-self.speed
	self.x2 = self.x2-self.speed
	self.x3 = self.x3-self.speed
	
	cw_setVertexPos(self.cwHandle, 0, self.x0, self.y0)
	cw_setVertexPos(self.cwHandle, 1, self.x1, self.y1)
	cw_setVertexPos(self.cwHandle, 2, self.x2, self.y2)
	cw_setVertexPos(self.cwHandle, 3, self.x3, self.y3)
end

function bgWall:fallright(mFrameTime)
	if self.type == 50 then
		if self.y2 > 1100 then self.dead = true
		elseif self.y2 < -1100 then self.dead = true end
	else
		if self.y2 > 800 then self.dead = true
		elseif self.y2 < -800 then self.dead = true end
	end
	
	self.y0 = self.y0-self.speed
	self.y1 = self.y1-self.speed
	self.y2 = self.y2-self.speed
	self.y3 = self.y3-self.speed
	
	cw_setVertexPos(self.cwHandle, 0, self.x0, self.y0)
	cw_setVertexPos(self.cwHandle, 1, self.x1, self.y1)
	cw_setVertexPos(self.cwHandle, 2, self.x2, self.y2)
	cw_setVertexPos(self.cwHandle, 3, self.x3, self.y3)
end

function bgWall:eminate(mFrameTime)
	if self.x2 > 800 then self.dead = true
	elseif self.x2 < -800 then self.dead = true end
	
	xspeed = self.speed * math.cos(self.dir)
	yspeed = self.speed * math.sin(self.dir)
	
	self.x0 = self.x0-xspeed
	self.y0 = self.y0-yspeed
	self.x1 = self.x1-xspeed
	self.y1 = self.y1-yspeed
	self.x2 = self.x2-xspeed
	self.y2 = self.y2-yspeed
	self.x3 = self.x3-xspeed
	self.y3 = self.y3-yspeed
	
	cw_setVertexPos(self.cwHandle, 0, x0, y0)
	cw_setVertexPos(self.cwHandle, 1, x1, y1)
	cw_setVertexPos(self.cwHandle, 2, x2, y2)
	cw_setVertexPos(self.cwHandle, 3, x3, y3)
end

function bgWall:pulse(mMode, mValue)
	if mMode == 0 then --fade out
		mRed = self.blue-(mValue*(self.blue/64))
		mGreen = self.blue-(mValue*(self.blue/64))
		mBlue = self.blue
		cw_setVertexColor(self.cwHandle, 0, mRed, mGreen, mBlue, 0)
		cw_setVertexColor(self.cwHandle, 1, mRed, mGreen, mBlue, self.alpha)
		cw_setVertexColor(self.cwHandle, 2, mRed, mGreen, mBlue, self.alpha)
		cw_setVertexColor(self.cwHandle, 3, mRed, mGreen, mBlue, 0)
	else --pulse
		mRed = self.blue
		mGreen = self.blue
		mBlue = self.blue
		cw_setVertexColor(self.cwHandle, 0, mRed, mGreen, mBlue, 0)
		cw_setVertexColor(self.cwHandle, 1, mRed, mGreen, mBlue, self.alpha)
		cw_setVertexColor(self.cwHandle, 2, mRed, mGreen, mBlue, self.alpha)
		cw_setVertexColor(self.cwHandle, 3, mRed, mGreen, mBlue, 0)
	end --open hexagon: *has a nameless feature*
end		--devs: ah pulse, here we go again

function bgWall:recolor(mMode, mValue)
	mRed,mGreen,mBlue = s_getCapColorResult()
	mRed = mRed/self.alpha
	mGreen = mGreen/self.alpha
	mBlue = mBlue/self.alpha
	cw_setVertexColor(self.cwHandle, 0, mRed, mGreen, mBlue, 255)
	cw_setVertexColor(self.cwHandle, 1, mRed, mGreen, mBlue, 255)
	cw_setVertexColor(self.cwHandle, 2, mRed, mGreen, mBlue, 255)
	cw_setVertexColor(self.cwHandle, 3, mRed, mGreen, mBlue, 255)
end

function bgWall:fade(mRate)
	self.alpha = self.alpha - mRate
	if self.alpha <= 0 then self.dead = true end
	mRed = self.red
	mGreen = self.green
	mBlue = self.blue
	cw_setVertexColor(self.cwHandle, 0, mRed, mGreen, mBlue, self.alpha)
	cw_setVertexColor(self.cwHandle, 1, mRed, mGreen, mBlue, self.alpha)
	cw_setVertexColor(self.cwHandle, 2, mRed, mGreen, mBlue, self.alpha)
	cw_setVertexColor(self.cwHandle, 3, mRed, mGreen, mBlue, self.alpha)
end

function bgWall:bedroomEase(mRate)
	if self.x0 < self.dir then spd = -((self.dir-self.x0)/10)
	elseif self.x0 > self.dir then spd = ((self.x0-self.dir)/10)
	else spd = 0 end
	self.x0 = self.x0-spd
	self.x1 = self.x1-spd
	self.x2 = self.x2-spd
	self.x3 = self.x3-spd
	
	cw_setVertexPos(self.cwHandle, 0, self.x0, self.y0)
	cw_setVertexPos(self.cwHandle, 1, self.x1, self.y1)
	cw_setVertexPos(self.cwHandle, 2, self.x2, self.y2)
	cw_setVertexPos(self.cwHandle, 3, self.x3, self.y3)
end

function bgWall:boxesPulse(mMode)
	self.dir = mMode
end

function bgWall:accelerate(mSpeed)
	self.speed = sign(self.speed) * ((math.sqrt(math.abs(self.speed)) + mSpeed)^2)
end

-- when da walls are sus
function wImpWall(mSide, mThickness, mOffset, mRed, mGreen, mBlue, mAlpha, mSpeed, mType, mPNum)
	cwHandle = cw_create()
	
	if mAlpha < 255 and mType ~= 31 then
		cw_setCollision(cwHandle, false)
	elseif mType == 5 then
		cw_setDeadly(cwHandle, true)
	end
	
	if mType == 10 or mType == 11 or mType == 12 or mType == 13 then mRed,mGreen,mBlue = s_getCapColorResult() end
	
	if mType == 51 then
		cw_setVertexColor(cwHandle, 0, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 1, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 2, mRed, mGreen, mBlue, 0)
		cw_setVertexColor(cwHandle, 3, mRed, mGreen, mBlue, 0)
	else
		cw_setVertexColor(cwHandle, 0, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 1, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 2, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 3, mRed, mGreen, mBlue, mAlpha)
	end
	cw_setVertexPos(cwHandle, 0, 0, 0)
	cw_setVertexPos(cwHandle, 1, 0, 0)
	cw_setVertexPos(cwHandle, 2, 0, 0)
	cw_setVertexPos(cwHandle, 3, 0, 0)
	
	iw = imposterWall:new(cwHandle)
	-- set up The Sh†t™
	iw.type = mType
	if (mType == 14 or mType == 51) then iw.distance = 1
	else iw.distance = l_getWallSpawnDistance()
	end
	iw.speed = u_getSpeedMultDM() * 5.05 * mSpeed
	iw.side = mSide
	if mType == 20 then iw.shape = 3
	elseif mType == 21 then iw.shape = 6
	elseif mType == 22 then iw.shape = 4
	else iw.shape = l_getSides()
	end
	iw.thickness = mThickness
	iw.red = mRed
	iw.blue = mBlue
	iw.green = mGreen
	iw.alpha = mAlpha
	iw.offset = mOffset
	iw.pflag = false --use as a genericish flag
	if mType == 6 or mType == 7 or mType == 8 then iw.pnum = mPNum
	else iw.pnum = 0.0 end --use as a generic number
	table.insert(imposterWalls, iw)
end

function wNewDeco(mx0, my0, mx1, my1, mx2, my2, mx3, my3, mRed, mGreen, mBlue, mAlpha, mSpeed, mType, mxPos, myPos)
	cwHandle = cw_create()
	if mType == 50 then 
		cw_setCollision(cwHandle, true)
		cw_setDeadly(cwHandle, true)
	else cw_setCollision(cwHandle, false) end
	
	if mType == 1 then
		cw_setVertexColor(cwHandle, 0, mRed, mGreen, mBlue, 0)
		cw_setVertexColor(cwHandle, 1, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 2, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 3, mRed, mGreen, mBlue, 0)
	else
		cw_setVertexColor(cwHandle, 0, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 1, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 2, mRed, mGreen, mBlue, mAlpha)
		cw_setVertexColor(cwHandle, 3, mRed, mGreen, mBlue, mAlpha)
	end
	mRotation = math.pi*(l_getRotation()/180)
	
	iw = bgWall:new(cwHandle)
	iw.cwHandle = cwHandle --not gonna take any risks w this
	iw.type = mType
	iw.speed = 10.1 * mSpeed
	iw.red = mRed
	iw.blue = mBlue
	iw.green = mGreen
	iw.alpha = mAlpha
	if mType == 3 then 
		iw.dir = myPos
		myPos = 0
	elseif mType == 50 then 
		iw.dir = mxPos
		if my2 < 0 then mxPos = mxPos - 600
		else mxPos = mxPos + 600 end
	else
		iw.dir = 0
	end
	t0 = math.atan2(mx0, my0)
	r0 = math.sqrt(mx0^2+my0^2)
	t1 = math.atan2(mx1, my1)
	r1 = math.sqrt(mx1^2+my1^2)
	t2 = math.atan2(mx2, my2)
	r2 = math.sqrt(mx2^2+my2^2)
	t3 = math.atan2(mx3, my3)
	r3 = math.sqrt(mx3^2+my3^2)
	iw.x0 = (r0 * math.cos(t0)) + mxPos
	iw.y0 = (r0 * math.sin(t0)) + myPos
	iw.x1 = (r1 * math.cos(t1)) + mxPos
	iw.y1 = (r1 * math.sin(t1)) + myPos
	iw.x2 = (r2 * math.cos(t2)) + mxPos
	iw.y2 = (r2 * math.sin(t2)) + myPos
	iw.x3 = (r3 * math.cos(t3)) + mxPos
	iw.y3 = (r3 * math.sin(t3)) + myPos
	cw_setVertexPos(cwHandle, 0, iw.x0, iw.y0)
	cw_setVertexPos(cwHandle, 1, iw.x1, iw.y1)
	cw_setVertexPos(cwHandle, 2, iw.x2, iw.y2)
	cw_setVertexPos(cwHandle, 3, iw.x3, iw.y3)
	iw:unrotate(0)
	
	table.insert(bgWalls, iw)
end

function wPulse(mMode, mValue)
	for _, iw in ipairs(bgWalls) do
		if iw.type == 1 then iw:pulse(mMode, mValue) end
	end
end

function wUpdateSpeed(mSpeed, mType)
	for _, iw in ipairs(imposterWalls) do
		if iw.type == mType and iw.pflag == true then iw:updateSpeed(mSpeed) end
	end
end

function wUpdateThickness(mSide, mThickness)
	for _, iw in ipairs(imposterWalls) do
		if (iw.side == mSide) then iw:updateThickness(mThickness) end
	end
end

function wUpdatePFlag(mSide, mPFlag)
	for _, iw in ipairs(imposterWalls) do
		if (iw.side == mSide) then iw:updatePFlag(mPFlag) end
	end
end

function wUpdatePNum(mSide, mPNum)
	for _, iw in ipairs(imposterWalls) do
		if (iw.side == mSide) then iw:updatePNum(mPNum) end
	end
end