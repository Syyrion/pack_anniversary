-- 2020 stuff

-- mode: 0 for l-l-l-l (direction +1), 1 for l-l-r-r, 2 for inverse, 3 for l-l-l-l (direction +2), 4 for l-l-r-r (direction +2), 5 for l-r-l-r
function oneOpenSide(delay, delayPre, timesDo, mode)
	local side = getRandomSide()
	local direction = getRandomDir()
	local loopMax = math.random(timesDo[1], timesDo[2])

	if mode == 1 or mode == 4 then loopMax = loopMax * 2 end
	
	t_wait(delayPre)
	for i = 0, loopMax do
		if i > 0 then t_wait(delay) end
		singleOneOpenSide(side, thickness)
		
		-- 0 => standart direction without changes
		if mode == 1 then side = side + direction
		elseif mode == 2 and i == math.ceil(loopMax / 2) then direction = direction * -1
		elseif mode == 3 then
			if i == math.ceil(loopMax / 2) then direction = direction * -1 end
			side = side + direction
		elseif mode == 4 then direction = getHalfSides(i)
		elseif mode == 5 then direction = direction * -1
		end
		
		side = side + direction
	end
end

-- mode: 0 for l-l-l-l, 1 for l-l-r-r, 2 for l-r-l-r
function twoOpenSides(delay, delayPre, timesDo, mode)
	local side = getRandomSide()
	local direction = getRandomDir()
	local loopMax = math.random(timesDo[1], timesDo[2])
	
	if mode == 1 then loopMax = loopMax * 2 end
	
	t_wait(delayPre)
	for i = 0, loopMax do
		if i > 0 then t_wait(delay) end
		singleHalfBarrage(side, l_getSides() % 2, thickness)
		singleHalfBarrage(side + math.floor(l_getSides() / 2), 0, thickness)
		
		if mode == 1 and i == loopMax / 2 then direction = direction * -1
		elseif mode == 2 then direction = direction * -1 end
		side = side + direction
	end
end

-- mode: 0 for two inverted closed sides, 1 for two open sides, 2 for single alt barrage, 3 for single one open side
function separateWalls(delayPre, timesDo, mode)
	local side = getRandomSide()
	local direction = getRandomDir()
	local loopMax = math.random(timesDo[1], timesDo[2])
	
	t_wait(delayPre)
	for i = 0, loopMax do
		if i > 0 then t_wait(3.03) end
		if mode == 0 then
			w_wall(side, thickness * 0.66)
			w_wall(side + getHalfSides(i), thickness * 0.66)
		elseif mode == 1 then
			singleHalfBarrage(side, 0, thickness * 0.66)
			singleHalfBarrage(side + math.floor(l_getSides() / 2), 0, thickness * 0.66)
		elseif mode == 2 then
			singleAltBarrage(side, thickness * 0.66)
		elseif mode == 3 then
			singleOneOpenSide(side, thickness * 0.66)
		end
	end
end

-- mode: 0 for always right, 1 for left or right
function doubleSpiral(delayPre, timesDo, mode)
	local side = getRandomSide()
	local thicknessSpiral = 38 * l_getSpeedMult()
	local loopMax = math.random(timesDo[1], timesDo[2])
	local direction = 1
	
	if mode == 1 then direction = getRandomDir() end
	
	t_wait(delayPre)
	for i = 0, loopMax do
		if i > 0 then t_wait(oneSideMinDelay()) end
		w_wall(side + i * direction, thicknessSpiral)
		w_wall(side + i * direction + math.floor(l_getSides() / 2), thicknessSpiral)
	end
	t_wait(l_getSpeedMult() / 1.35)
end

-- mode: 0 for always right, 1 for left or right
function veryThinSpiral(delayPre, timesDo, mode)
	local side = getRandomSide()
	local thicknessSpiral = 40 * math.min(l_getSpeedMult(), 3) / 3
	local loopMax = math.random(timesDo[1], timesDo[2])
	local direction = 1
	
	if mode == 1 then direction = getRandomDir() end
	
	t_wait(delayPre)
	for i = 0, loopMax do
		if i > 0 then t_wait(oneSideMinDelay()) end
		singleOneOpenSide(side + i * direction, thicknessSpiral)
	end
end

-- mode: 0 patterns can have same position (new - old = 0), 1 can't
function randomOneOpenSide(delay, timesDo, mode)

	local function newDelayCalc(oldSide, side)
		local sideDiff = math.abs(side - oldSide) -- the difference between the new and old positions
		if sideDiff > math.floor(l_getSides() / 2) then sideDiff = l_getSides() - sideDiff end -- the delay is reduced if the difference is more than half, as the new pattern approaches the old position on the other side
		return sideDiff
	end

	local side = getRandomSide()
	local direction = getRandomDir()
	local loopCount = math.random(timesDo[1], timesDo[2])
	
	local oldSide = side
	local newDelay = delay
	
	for i = 0, loopCount do
		t_wait(newDelay)
		
		singleOneOpenSide(side, thickness)
		
		side = getRandomSide()
		if mode == 1 then while (side - oldSide) == 0 do side = getRandomSide() end end
		
		newDelay = getCommonDelayMult() / 10 * (halfSidesMinDelay() / 2 + halfSidesMinDelay() / l_getSides() * newDelayCalc(oldSide, side)) -- half of the delay is constant for any position, the other half is relative
		oldSide = side
	end
end

function altBarrage(delay, firstDelay, timesDo)
	local side = getRandomSide()
	local loopMax = math.random(timesDo[1], timesDo[2])
	
	t_wait(firstDelay)
	for i = 0, loopMax do
		if i > 0 then t_wait(delay) end
		singleAltBarrage(side + i, thickness)
	end
end