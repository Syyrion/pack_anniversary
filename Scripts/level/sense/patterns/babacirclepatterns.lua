-- baba's patterns, use them if you want i dont care
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("babacommon.lua")

t = getRandomSide()
m = 0
d = getRandomDir()

function cirWall(mSide, mThickness)
	for i = 1, 10 do
		w_wall(mSide * 10 + i, mThickness)
	end
end

function cirBarrage(mSide, mThickness)
	for i = 1, math.floor(l_getSides() / 10) - 1 do
		cirWall(mSide + i, mThickness)
	end
end

function cirDoubleBarrage(mSide, mThickness)
	for i = 2, math.floor(l_getSides() / 10) - 2 do
		cirWall(mSide + i, mThickness)
	end
	cirWall(mSide, mThickness)
end

function cirBarrageSpiral(mTimes)
t = getRandomSide()
d = getRandomDir()
m = 0

	for a = 1, mTimes do
		cirBarrage(t + m, 40)
		m = m + d
		t_wait(custWait(4.4))
	end
	
t_wait(custWait(8.5))
end

function cirAltBarrage(mTimes)
t = getRandomSide()
d = math.random(0, 1)

	for a = 1, mTimes do
		for i = 1, math.floor(l_getSides() / 10) do
			if (a + i + d) % 2 == 1 then
				cirWall(t + i, 40)
			end
		end
		
		t_wait(custWait(4.4))
	end
	
t_wait(custWait(8.5))
end

function cirBarrageLRs(mTimes, mDistance)
t = getRandomSide()
d = getRandomDir() * mDistance
m = 0

	for a = 1, mTimes do
		cirBarrage(t + m, 40)
		m = m + d
		d = d * -1
		t_wait(custWait(4.4 * (mDistance * 0.333 + 0.667)))
	end
	
t_wait(custWait(8.5))
end

function cirDoubleBarrageSpiral(mTimes)
t = getRandomSide()
d = getRandomDir()
m = 0

	for a = 1, mTimes do
		cirDoubleBarrage(t + m, 40)
		m = m + d
		t_wait(custWait(4.4))
	end
	
t_wait(custWait(8.5))
end

function cirDoubleBarrageLRs(mTimes)
t = getRandomSide()
d = getRandomDir()
m = 0

	for a = 1, mTimes do
		cirDoubleBarrage(t + m, 40)
		m = m + d
		d = d * -1
		t_wait(custWait(4.4))
	end
	
t_wait(custWait(8.5))
end

function cirDoubleBarrageInverts(mTimes)
t = getRandomSide()
d = getRandomDir() * math.floor(l_getSides() / 20)
m = 0

	for a = 1, mTimes do
		cirDoubleBarrage(t + m, 40)
		m = m + d
		d = d * -1
		t_wait(custWait(4.4))
	end
	
t_wait(custWait(8.5))
end

function cirMirrorSpiral(mTimes)
t = getRandomSide()
d = getRandomDir()
m = 0

	for a = 1, mTimes do
		cirWall(t + m, custThickness(2.4))
		cirWall(t + m + math.floor(l_getSides() / 20), custThickness(2.4))
		m = m + d
		t_wait(custWait(2.4))
	end
	
t_wait(custWait(8.5))
end

function cirMirrorSpiralRev(mTimes)
t = getRandomSide()
d = getRandomDir()
m = 0

	for a = 1, math.ceil(mTimes / 2) do
		cirWall(t + m, custThickness(2.4))
		cirWall(t + m + math.floor(l_getSides() / 20), custThickness(2.4))
		m = m + d
		t_wait(custWait(2.4))
	end
	
	d = d * -1
	
	for a = 1, math.ceil(mTimes / 2) + 1 do
		cirWall(t + m, custThickness(2.4))
		cirWall(t + m + math.floor(l_getSides() / 20), custThickness(2.4))
		m = m + d
		t_wait(custWait(2.4))
	end
	
t_wait(custWait(8.5))
end

function cirTunnel(mTimes, mDistance)
t = getRandomSide()
d = math.random(0, 1) * mDistance

	for i = 1, mDistance - 1 do
		cirWall(t + i, custThickness(mTimes * 8.4 / (mDistance * 0.4 + 0.175)) + 40)
	end
		
	for a = 1, mTimes + 1 do
		cirBarrage(t + d, custThickness(1.33))
		d = d * -1 + mDistance
		t_wait(custWait(8.4 / (mDistance * 0.4 + 0.175)))
	end
	
t_wait(custWait(8.5))
end

function cirAltTunnel(mTimes)
t = getRandomSide()
d = math.random(0, 1)

	for i = 1, 3 do
		cirWall(t + i, custThickness(mTimes * 4.4) + 40)
	end
		
	for a = 1, mTimes + 1 do
		for i = 1, math.floor(l_getSides() / 10) do
			if (a + i + d) % 2 == 1 then
				cirWall(t + i, 40)
			end
		end
		
		t_wait(custWait(4.4))
	end
	
t_wait(custWait(8.5))
end
