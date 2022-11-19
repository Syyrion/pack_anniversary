
-- our wall
impostorWall = {}
impostorWall.__index = impostorWall
impostorWalls = {}
-- fractal wall
impostorWallFract = {}
impostorWallFract.__index = impostorWallFract
impostorWallFracts = {}
-- background wall
bgWall = {}
bgWall.__index = bgWall
bgWalls = {}

-- "borrowed" from babadrake.
-- imposter walls look like normal walls but can be manipulated

function impostorWall:new(handle)
    local obj = {}
    setmetatable(obj, impostorWall)
    -- Our handle, our name, our identifier
    obj.cwImpWall = handle
    -- There are only 2 things certain in life: death and something else
    obj.dead = false
    return obj
end

function impostorWall:move(mFrameTime)
    local range = 2 * math.pi / self.shape
    local distLimit = l_getWallSpawnDistance()

    if self.type == 125 then
        if math.floor(self.thickness) > distLimit then self.dead = true end
        if math.floor(self.distance) > distLimit then self.thickness = math.min(self.thickness + (mFrameTime * self.speed), distLimit + 1)
        else                                          self.distance = math.min(self.distance + (mFrameTime * self.speed), distLimit + 1)
        end
    else
        if math.floor(self.thickness) < 1 then self.dead = true end
        if math.floor(self.distance) < 1 then self.thickness = math.max(self.thickness - (mFrameTime * self.speed), 0)
        else                                  self.distance = math.max(self.distance - (mFrameTime * self.speed), 0)
        end
    end

    if (self.type == 14 or self.type == 51 or self.type == 100) and math.floor(self.distance) > l_getWallSpawnDistance() then self.dead = true end

    mBlue = self.blue
    mGreen = self.green
    mRed = self.red

    if self.type == 5 then
        r1 = self.distance - self.thickness + self.offset
        r2 = self.distance + self.offset
    elseif self.type == 125 then
        r1 = closeValue(self.distance + self.offset, 0, l_getWallSpawnDistance())
        r2 = closeValue(self.distance + self.thickness + self.offset, 0, l_getWallSpawnDistance())
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
        cw_setVertexPos(self.cwImpWall, 0, r1 * acc1, r1 * acy1)
        cw_setVertexPos(self.cwImpWall, 1, r1 * math.cos(a2), r1 * math.sin(a2))
        cw_setVertexPos(self.cwImpWall, 2, r2 * math.cos(a2), r2 * math.sin(a2))
        cw_setVertexPos(self.cwImpWall, 3, r2 * acc1, r2 * acy1)
    elseif self.type == 7 then
        a1 = (self.side + 0.5) * range
        a2 = (self.side - 0.5) * range
        acc1 = (math.cos(a1)*(1-0.33))+(math.cos(a2)*(0.33))
        acy1 = (math.sin(a1)*(1-0.33))+(math.sin(a2)*(0.33))
        cw_setVertexPos(self.cwImpWall, 0, r1 * math.cos(a1), r1 * math.sin(a1))
        cw_setVertexPos(self.cwImpWall, 1, r1 * acc1, r1 * acy1)
        cw_setVertexPos(self.cwImpWall, 2, r2 * acc1, r2 * acy1)
        cw_setVertexPos(self.cwImpWall, 3, r2 * math.cos(a1), r2 * math.sin(a1))
    else
        a1 = (self.side + 0.5) * range
        a2 = (self.side - 0.5) * range
        cw_setVertexPos(self.cwImpWall, 0, r1 * math.cos(a1), r1 * math.sin(a1))
        cw_setVertexPos(self.cwImpWall, 1, r1 * math.cos(a2), r1 * math.sin(a2))
        cw_setVertexPos(self.cwImpWall, 2, r2 * math.cos(a2), r2 * math.sin(a2))
        cw_setVertexPos(self.cwImpWall, 3, r2 * math.cos(a1), r2 * math.sin(a1))
    end

    if self.type == 51 then
        cw_setVertexColor(self.cwImpWall, 0, 0, 0, 0, self.alpha)
        cw_setVertexColor(self.cwImpWall, 1, 0, 0, 0, self.alpha)
        cw_setVertexColor(self.cwImpWall, 2, 0, 0, 0, 0)
        cw_setVertexColor(self.cwImpWall, 3, 0, 0, 0, 0)
    elseif self.type == 100 then
        cw_setVertexColor(self.cwImpWall, 0, 0, 0, 0, self.alpha)
        cw_setVertexColor(self.cwImpWall, 1, 0, 0, 0, self.alpha)
        cw_setVertexColor(self.cwImpWall, 2, 0, 0, 0, self.alpha)
        cw_setVertexColor(self.cwImpWall, 3, 0, 0, 0, self.alpha)
    elseif self.type == 101 then
        cw_setVertexColor(self.cwImpWall, 0, mRed, mGreen, mBlue, 0)
        cw_setVertexColor(self.cwImpWall, 1, mRed, mGreen, mBlue, 0)
        cw_setVertexColor(self.cwImpWall, 2, mRed, mGreen, mBlue, self.alpha)
        cw_setVertexColor(self.cwImpWall, 3, mRed, mGreen, mBlue, self.alpha)
    else
        cw_setVertexColor(self.cwImpWall, 0, mRed, mGreen, mBlue, self.alpha)
        cw_setVertexColor(self.cwImpWall, 1, mRed, mGreen, mBlue, self.alpha)
        cw_setVertexColor(self.cwImpWall, 2, mRed, mGreen, mBlue, self.alpha)
        cw_setVertexColor(self.cwImpWall, 3, mRed, mGreen, mBlue, self.alpha)
    end
end

function impostorWall:updateSpeed(mSpeed)
    self.speed = mSpeed
end

function impostorWall:updateThickness(mThickness)
    if self.type == 5 then self.thickness = mThickness or THICKNESS end
    if self.thickness < 1 then self.thickness = 1 end
end

function impostorWall:updatePFlag(mPFlag)
    self.pflag = mPFlag --stands for pride flag
end

function impostorWall:updatePNum(mPNum)
    self.pnum = mPNum
end

function impostorWall:recolor(mRed, mGreen, mBlue, mAlpha)
    cw_setVertexColor(self.cwImpWall, 0, mRed, mGreen, mBlue, mAlpha)
    cw_setVertexColor(self.cwImpWall, 1, mRed, mGreen, mBlue, mAlpha)
    cw_setVertexColor(self.cwImpWall, 2, mRed, mGreen, mBlue, mAlpha)
    cw_setVertexColor(self.cwImpWall, 3, mRed, mGreen, mBlue, mAlpha)
end

function bgWall:new(handle)
    local obj = {}
    setmetatable(obj, bgWall)
    -- Our handle, our name, our identifier, our deadly sins
    obj.cwDeco = handle
    -- There are only 2 things certain in life: guilt and innocence
    obj.dead = false
    return obj
end

function bgWall:update(mFrameTime)
    if (not self.isRotate) then mRotation = math.pi*(l_getRotation()/180)
    else mRotation = 0
    end

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

    cw_setVertexPos(self.cwDeco, 0, r0 * math.cos(t0+mRotation), r0 * math.sin(t0+mRotation))
    cw_setVertexPos(self.cwDeco, 1, r1 * math.cos(t1+mRotation), r1 * math.sin(t1+mRotation))
    cw_setVertexPos(self.cwDeco, 2, r2 * math.cos(t2+mRotation), r2 * math.sin(t2+mRotation))
    cw_setVertexPos(self.cwDeco, 3, r3 * math.cos(t3+mRotation), r3 * math.sin(t3+mRotation))
end

function bgWall:fallHoriz(mDir, mFrameTime)
    if self.type == 8 then
        if self.x2 > 1100 then self.dead = true
        elseif self.x2 < -1100 then self.dead = true
        end
    else
        if self.x2 > 800 then self.dead = true
        elseif self.x2 < -800 then self.dead = true
        end
    end

    self.x0 = self.x0+self.speed*mDir
    self.x1 = self.x1+self.speed*mDir
    self.x2 = self.x2+self.speed*mDir
    self.x3 = self.x3+self.speed*mDir

    cw_setVertexPos(self.cwDeco, 0, self.x0, self.y0)
    cw_setVertexPos(self.cwDeco, 1, self.x1, self.y1)
    cw_setVertexPos(self.cwDeco, 2, self.x2, self.y2)
    cw_setVertexPos(self.cwDeco, 3, self.x3, self.y3)
end

function bgWall:fallVert(mDir, mFrameTime)
    if self.type == 50 then
        if self.y2 > 1100 then self.dead = true
        elseif self.y2 < -1100 then self.dead = true
        end
    else
        if self.y2 > 800 then self.dead = true
        elseif self.y2 < -800 then self.dead = true
        end
    end

    self.y0 = self.y0+self.speed*mDir
    self.y1 = self.y1+self.speed*mDir
    self.y2 = self.y2+self.speed*mDir
    self.y3 = self.y3+self.speed*mDir

    cw_setVertexPos(self.cwDeco, 0, self.x0, self.y0)
    cw_setVertexPos(self.cwDeco, 1, self.x1, self.y1)
    cw_setVertexPos(self.cwDeco, 2, self.x2, self.y2)
    cw_setVertexPos(self.cwDeco, 3, self.x3, self.y3)
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

    cw_setVertexPos(self.cwDeco, 0, x0, y0)
    cw_setVertexPos(self.cwDeco, 1, x1, y1)
    cw_setVertexPos(self.cwDeco, 2, x2, y2)
    cw_setVertexPos(self.cwDeco, 3, x3, y3)
end

function bgWall:pulse(mMode, mValue)
    if mMode == 0 then --fade out
        mRed = self.blue-(mValue*(self.blue/64))
        mGreen = self.blue-(mValue*(self.blue/64))
        mBlue = self.blue
        cw_setVertexColor(self.cwDeco, 0, mRed, mGreen, mBlue, 0)
        cw_setVertexColor(self.cwDeco, 1, mRed, mGreen, mBlue, self.alpha)
        cw_setVertexColor(self.cwDeco, 2, mRed, mGreen, mBlue, self.alpha)
        cw_setVertexColor(self.cwDeco, 3, mRed, mGreen, mBlue, 0)
    else --pulse
        mRed = self.blue
        mGreen = self.blue
        mBlue = self.blue
        cw_setVertexColor(self.cwDeco, 0, mRed, mGreen, mBlue, 0)
        cw_setVertexColor(self.cwDeco, 1, mRed, mGreen, mBlue, self.alpha)
        cw_setVertexColor(self.cwDeco, 2, mRed, mGreen, mBlue, self.alpha)
        cw_setVertexColor(self.cwDeco, 3, mRed, mGreen, mBlue, 0)
    end --open hexagon: *has a nameless feature*
end     --devs: ah pulse, here we go again

function bgWall:recolor(mRed, mGreen, mBlue, mAlpha)
    cw_setVertexColor(self.cwDeco, 0, mRed, mGreen, mBlue, mAlpha)
    cw_setVertexColor(self.cwDeco, 1, mRed, mGreen, mBlue, mAlpha)
    cw_setVertexColor(self.cwDeco, 2, mRed, mGreen, mBlue, mAlpha)
    cw_setVertexColor(self.cwDeco, 3, mRed, mGreen, mBlue, mAlpha)
end

function bgWall:recolorExpectAlpha(mRed, mGreen, mBlue)
    mRed = mRed/self.alpha
    mGreen = mGreen/self.alpha
    mBlue = mBlue/self.alpha
    cw_setVertexColor(self.cwDeco, 0, mRed, mGreen, mBlue, 255)
    cw_setVertexColor(self.cwDeco, 1, mRed, mGreen, mBlue, 255)
    cw_setVertexColor(self.cwDeco, 2, mRed, mGreen, mBlue, 255)
    cw_setVertexColor(self.cwDeco, 3, mRed, mGreen, mBlue, 255)
end

function bgWall:fadeout(mRate)
    self.alpha = self.alpha - mRate
    if self.alpha <= 0 then self.dead = true end
    mRed = self.red
    mGreen = self.green
    mBlue = self.blue
    cw_setVertexColor(self.cwDeco, 0, mRed, mGreen, mBlue, self.alpha)
    cw_setVertexColor(self.cwDeco, 1, mRed, mGreen, mBlue, self.alpha)
    cw_setVertexColor(self.cwDeco, 2, mRed, mGreen, mBlue, self.alpha)
    cw_setVertexColor(self.cwDeco, 3, mRed, mGreen, mBlue, self.alpha)
end

function bgWall:bedroomEase(mRate)
    if self.x0 < self.dir then spd = -((self.dir-self.x0)/10)
    elseif self.x0 > self.dir then spd = ((self.x0-self.dir)/10)
    else spd = 0 end
    self.x0 = self.x0-spd
    self.x1 = self.x1-spd
    self.x2 = self.x2-spd
    self.x3 = self.x3-spd

    cw_setVertexPos(self.cwDeco, 0, self.x0, self.y0)
    cw_setVertexPos(self.cwDeco, 1, self.x1, self.y1)
    cw_setVertexPos(self.cwDeco, 2, self.x2, self.y2)
    cw_setVertexPos(self.cwDeco, 3, self.x3, self.y3)
end

function bgWall:boxesPulse(mMode)
    self.dir = mMode
end

function bgWall:accelerate(mSpeed)
    self.speed = getNeg(self.speed) * ((math.sqrt(math.abs(self.speed)) + mSpeed)^2)
end

function impostorWallFract:new(handle)
    local obj = {}
    setmetatable(obj, impostorWallFract)
    -- Our handle, our name, our identifier
    obj.cwFract = handle
    -- There are only 2 things certain in life, death and taxes
    obj.fractDeleted = false
    return obj
end

function impostorWallFract:move()
    local range = 2 * math.pi / self.shapeFrac

    -- move it move it
    if (self.boolIsAnimatedFrac == 1) then
        self.distanceBeginAnimaFrac = lerp(self.distanceBeginAnimaFrac, self.distanceFrac, 0.05)
    end
    -- time to countdown
    self.timerBeforeDELETEFrac = self.timerBeforeDELETEFrac - (l_getLevelTime() - self.delTimerBeforeDELETEFrac)
    -- babe request times out, time to die
    if self.timerBeforeDELETEFrac <= 0 then self.fractDeleted = true end

    trueSideFrac = self.sideFrac + math.sin(l_getLevelTime() * self.curveSpeedFrac + self.curveStartFrac + self.curveStartIncFrac) * self.curveFrac
    trueDistFrac = self.distanceFrac + math.sin(l_getLevelTime() * self.distanceSpeedCurve + self.distanceStartCurve + self.distanceStartIncCurve) * self.distanceCurve

    r1 = trueDistFrac + self.distanceBeginAnimaFrac
    r2 = trueDistFrac + self.distanceBeginAnimaFrac + self.thicknessFrac
    a1 = (trueSideFrac + 0.5 * self.widthFrac) * range
    a2 = (trueSideFrac - 0.5 * self.widthFrac) * range
    a3 = (trueSideFrac - 0.5 * self.widthThickFrac) * range
    a4 = (trueSideFrac + 0.5 * self.widthThickFrac) * range

    cw_setVertexPos(self.cwFract, 0, r1 * math.cos(a1), r1 * math.sin(a1))
    cw_setVertexPos(self.cwFract, 1, r1 * math.cos(a2), r1 * math.sin(a2))
    cw_setVertexPos(self.cwFract, 2, r2 * math.cos(a3), r2 * math.sin(a3))
    cw_setVertexPos(self.cwFract, 3, r2 * math.cos(a4), r2 * math.sin(a4))

    if self.boolIsMainColor == 1 and self.boolIsColoring == 0 then
        cw_setVertexColor(self.cwFract, 0, s_getMainColor())
        cw_setVertexColor(self.cwFract, 1, s_getMainColor())
        cw_setVertexColor(self.cwFract, 2, s_getMainColor())
        cw_setVertexColor(self.cwFract, 3, s_getMainColor())
    end
end

function impostorWallFract:recolor(mRed, mGreen, mBlue, mAlpha, vColor)
    if vColor ~= nil then
        mRed, mGreen, mBlue, mAlpha = mRed or vColor[1], mGreen or vColor[2], mBlue or vColor[3], mAlpha or vColor[4]
    end
    if self.boolIsMainColor == 1 and self.boolIsColoring == 0 then
        cw_setVertexColor(self.cwFract, 0, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(self.cwFract, 1, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(self.cwFract, 2, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(self.cwFract, 3, mRed, mGreen, mBlue, mAlpha)
    end
end

function impostorWallFract:recolorVertexes(r1, g1, b1, a1,
                                           r2, g2, b2, a2,
                                           r3, g3, b3, a3,
                                           r4, g4, b4, a4)
    if self.boolIsMainColor == 0 and self.boolIsColoring == 1 then
        cw_setVertexColor(self.cwFract, 0, r1, g1, b1, a1)
        cw_setVertexColor(self.cwFract, 1, r2, g2, b2, a2)
        cw_setVertexColor(self.cwFract, 2, r3, g3, b3, a3)
        cw_setVertexColor(self.cwFract, 3, r4, g4, b4, a4)
    end
end

-- when da walls are sus
function wImpWall(mSide, mDistance, mSpeed, mThickness, mShape, mOffset, mRed, mGreen, mBlue, mAlpha, mType, mPNum)
    local cwImpWall = cw_create()

    if mAlpha < 255 or mType ~= 31 then
        cw_setCollision(cwImpWall, false)
    elseif mType == 5 then
        cw_setDeadly(cwImpWall, true)
    end

    if mType == 10 or mType == 11 or mType == 12 or mType == 13 then mRed,mGreen,mBlue = s_getMainColor()
    else mRed, mGreen, mBlue, mAlpha = mRed or 255, mGreen or 255, mBlue or 255, mAlpha or 255
    end

    if mType == 51 or mType >= 100 and mType < 150 then
        cw_setVertexColor(cwImpWall, 0, mRed, mGreen, mBlue, 0)
        cw_setVertexColor(cwImpWall, 1, mRed, mGreen, mBlue, 0)
        cw_setVertexColor(cwImpWall, 2, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(cwImpWall, 3, mRed, mGreen, mBlue, mAlpha)
    else
        cw_setVertexColor(cwImpWall, 0, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(cwImpWall, 1, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(cwImpWall, 2, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(cwImpWall, 3, mRed, mGreen, mBlue, mAlpha)
    end

    cw_setVertexPos(cwImpWall, 0, 0, 0)
    cw_setVertexPos(cwImpWall, 1, 0, 0)
    cw_setVertexPos(cwImpWall, 2, 0, 0)
    cw_setVertexPos(cwImpWall, 3, 0, 0)

    iw = impostorWall:new(cwImpWall)
    -- set up The Shiet™
    iw.type = mType
    if (mType == 14 or mType == 51 or mType >= 100) then iw.distance = mDistance or 1
    else iw.distance = mDistance or l_getWallSpawnDistance()
    end
    iw.speed = mSpeed or (u_getSpeedMultDM() * 5)
    iw.side = mSide
    if mType == 20 then iw.shape = 3
    elseif mType == 21 then iw.shape = 6
    elseif mType == 22 then iw.shape = 4
    else iw.shape = mShape or getProtocolSides()
    end
    iw.thickness = mThickness or THICKNESS
    iw.red = mRed
    iw.blue = mBlue
    iw.green = mGreen
    iw.alpha = mAlpha
    iw.offset = mOffset
    iw.pflag = false --use as a genericish flag
    if mType == 6 or mType == 7 or mType == 8 then iw.pnum = mPNum
    else iw.pnum = 0.0 end --use as a generic number
    table.insert(impostorWalls, iw)
end

function wNewDeco(mx0, my0, mx1, my1, mx2, my2, mx3, my3, mRed, mGreen, mBlue, mAlpha, mSpeed, mType, mxPos, myPos, bIsRotate)
    local cwDeco = cw_create()
    if mType == 50 then 
        cw_setCollision(cwDeco, true)
        cw_setDeadly(cwDeco, true)
    else
        cw_setCollision(cwDeco, false)
    end

    mRed, mGreen, mBlue, mAlpha = mRed or 255, mGreen or 255, mBlue or 255, mAlpha or 255

    if mType == 1 then
        cw_setVertexColor(cwDeco, 0, mRed, mGreen, mBlue, 0)
        cw_setVertexColor(cwDeco, 1, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(cwDeco, 2, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(cwDeco, 3, mRed, mGreen, mBlue, 0)
    else
        cw_setVertexColor(cwDeco, 0, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(cwDeco, 1, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(cwDeco, 2, mRed, mGreen, mBlue, mAlpha)
        cw_setVertexColor(cwDeco, 3, mRed, mGreen, mBlue, mAlpha)
    end
    mRotation = math.pi*(l_getRotation()/180)

    iw = bgWall:new(cwDeco)
    iw.cwDeco = cwDeco --not gonna take any risks w this
    iw.type = mType
    iw.speed = 10.1 * mSpeed
    iw.red = mRed
    iw.blue = mBlue
    iw.green = mGreen
    iw.alpha = mAlpha
    iw.isRotate = bIsRotate
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
    cw_setVertexPos(cwDeco, 0, iw.x0, iw.y0)
    cw_setVertexPos(cwDeco, 1, iw.x1, iw.y1)
    cw_setVertexPos(cwDeco, 2, iw.x2, iw.y2)
    cw_setVertexPos(cwDeco, 3, iw.x3, iw.y3)
    iw:update(0)

    table.insert(bgWalls, iw)
end

function wImpWallFrac(mSide, mSideWidth, mSideWidthBase, mSideWidthThickness,
                      mDistance, mDistCurve, mDistStartCurve, mDistStartIncCurve, mDistSpeedCurve,
                      mDistanceBeginAnima, bIsAnimated,
                      mSpeed, mThickness, mShape,
                      mCurve, mCurveStart, mCurveStartInc, mCurveSpeed,
                      bIsMainColor, mColoring,
                      mRedA, mGreenA, mBlueA, mAlphaA,
                      mRedB, mGreenB, mBlueB, mAlphaB,
                      mRedC, mGreenC, mBlueC, mAlphaC,
                      mRedD, mGreenD, mBlueD, mAlphaD,
                      mTimerBeforeDELETE)

    local cwFract = cw_create();
    cw_setCollision(cwFract, false);

    if mColoring == 0 then
        cw_setVertexColor(cwFract, 0, mRedA or 255, mGreenA or 255, mBlueA or 255, mAlphaA or 255)
        cw_setVertexColor(cwFract, 1, mRedA or 255, mGreenA or 255, mBlueA or 255, mAlphaA or 255)
        cw_setVertexColor(cwFract, 2, mRedA or 255, mGreenA or 255, mBlueA or 255, mAlphaA or 255)
        cw_setVertexColor(cwFract, 3, mRedA or 255, mGreenA or 255, mBlueA or 255, mAlphaA or 255)
    else
        cw_setVertexColor(cwFract, 0, mRedA or 255, mGreenA or 255, mBlueA or 255, mAlphaA or 255)
        cw_setVertexColor(cwFract, 1, mRedB or 255, mGreenB or 255, mBlueB or 255, mAlphaB or 255)
        cw_setVertexColor(cwFract, 2, mRedC or 255, mGreenC or 255, mBlueC or 255, mAlphaC or 255)
        cw_setVertexColor(cwFract, 3, mRedD or 255, mGreenD or 255, mBlueD or 255, mAlphaD or 255)
    end

    cw_setVertexPos(cwFract, 0, 0, 0)
    cw_setVertexPos(cwFract, 1, 0, 0)
    cw_setVertexPos(cwFract, 2, 0, 0)
    cw_setVertexPos(cwFract, 3, 0, 0)

    iwfr = impostorWallFract:new(cwFract)
    -- set up The Shit™
    iwfr.distanceFrac = mDistance
    iwfr.boolIsAnimatedFrac = bIsAnimated or 0
    iwfr.distanceBeginAnimaFrac = mDistanceBeginAnima or 1605
    iwfr.speedFrac = mSpeed
    iwfr.sideFrac = mSide
    iwfr.shapeFrac = mShape
    iwfr.thicknessFrac = mThickness or THICKNESS
    iwfr.widthFrac = mSideWidth + mSideWidthBase
    iwfr.widthThickFrac = mSideWidth + mSideWidthThickness

    iwfr.curveFrac = mCurve
    iwfr.curveStartFrac = mCurveStart
    iwfr.curveStartIncFrac = mCurveStartInc
    iwfr.curveSpeedFrac = mCurveSpeed

    iwfr.distanceCurve = mDistCurve
    iwfr.distanceStartCurve = mDistStartCurve
    iwfr.distanceStartIncCurve = mDistStartIncCurve
    iwfr.distanceSpeedCurve = mDistSpeedCurve

    iwfr.timerBeforeDELETEFrac = mTimerBeforeDELETE or math.huge
    iwfr.delTimerBeforeDELETEFrac = l_getLevelTime()
    iwfr.boolIsMainColor = bIsMainColor
    iwfr.boolIsColoring = mColoring
    table.insert(impostorWallFracts, iwfr)
end

function wPulse(mMode, mValue)
    for _, iw in ipairs(bgWalls) do
        if iw.type == 1 then iw:pulse(mMode, mValue) end
    end
end

function wUpdateSpeed(mSpeed, mType)
    for _, iw in ipairs(impostorWalls) do
        if iw.type == mType and iw.pflag == true then iw:updateSpeed(mSpeed) end
    end
end

function wUpdateThickness(mSide, mThickness)
    for _, iw in ipairs(impostorWalls) do
        if (iw.side == mSide) then iw:updateThickness(mThickness) end
    end
end

function wUpdatePFlag(mSide, mPFlag)
    for _, iw in ipairs(impostorWalls) do
        if (iw.side == mSide) then iw:updatePFlag(mPFlag) end
    end
end

function wUpdatePNum(mSide, mPNum)
    for _, iw in ipairs(impostorWalls) do
        if (iw.side == mSide) then iw:updatePNum(mPNum) end
    end
end

function runAllCWs(mFrameTime, bIs1stDraw, bIs2ndDraw, bIs3rdDraw)
    ArrayRemoveIf(impostorWallFracts, function(t, i, j)
        local v = t[i]
        if v.fractDeleted then cw_destroy(v.cwFract) return true
        else                                         return false
        end
    end);

    ArrayRemoveIf(impostorWalls, function(t, i, j)
        local v = t[i]
        if v.dead then cw_destroy(v.cwImpWall) return true
        else                                   return false
        end
    end);

    ArrayRemoveIf(bgWalls, function(t, i, j)
        local v = t[i]
        if v.dead then cw_destroy(v.cwDeco) return true
        else                                return false
        end
    end);

    if bIs1stDraw then
        for _, iwfr in ipairs(impostorWallFracts) do
            iwfr:move(mFrameTime)
        end
    end

    if bIs2ndDraw then
        for _, iw in ipairs(impostorWalls) do
            iw:move(mFrameTime)
        end
    end

    if bIs3rdDraw then
        for _, iw in ipairs(bgWalls) do
            iw:move(mFrameTime)
        end
    end
end

function forceDeleteCWs(b1stDel, b2ndDel, b3rdDel)
    if b1stDel then
        for _, iwfr in ipairs(impostorWallFracts) do
            iwfr.fractDeleted = true
        end
    end

    if b2ndDel then
        for _, iw in ipairs(impostorWalls) do
            iw.dead = true
        end
    end

    if b3rdDel then
        for _, iw in ipairs(bgWalls) do
            iw.dead = true
        end
    end
end

function clearAllCWs()
    cw_clear()
    impostorWallFracts = {}
    impostorWalls = {}
    bgWalls = {}
end