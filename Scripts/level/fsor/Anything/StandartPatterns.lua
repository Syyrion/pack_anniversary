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

function altBarrage(delay, firstDelay, timesDo)
	local side = getRandomSide()
	local loopMax = math.random(timesDo[1], timesDo[2])
	
	t_wait(firstDelay)
	for i = 0, loopMax do
		if i > 0 then t_wait(delay) end
		singleAltBarrage(side + i, thickness)
	end
end