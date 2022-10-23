function getCommonDelayMult() return l_getDelayMult() * 10 end

function getRandomSide() return math.random(1, l_getSides()) end

function getHalfSides(i) return math.floor(l_getSides() / 2) + (i % 2) * (l_getSides() % 2) end -- half the number of sides (i even - the smaller half, odd - the larger half; if the number of sides is odd)

function getRandomDir() local firstNumber = math.random(1, 2) return firstNumber - 2 / firstNumber end

function getSign(value) return value / math.abs(value) end

function oneSideMinDelay() -- multiplier for one side (minimum delay limit)
local mult = 1
	if l_getSides() == 3 then mult = 12.54
	elseif l_getSides() == 4 then mult = 9.54
	elseif l_getSides() == 5 then mult = 7.56
	elseif l_getSides() == 6 then mult = 6.06
	elseif l_getSides() == 7 then mult = 5.10
	elseif l_getSides() == 8 then mult = 4.56
	elseif l_getSides() == 9 then mult = 4.02
	elseif l_getSides() == 10 then mult = 3.6
	elseif l_getSides() >= 11 then mult = 3.06
	end
return mult -- for speed = 3, thickness = 40
end

function halfSidesMinDelay() -- не хочу искать формулу, не хочу аппроксимировать. multiplier for half sides (minimum delay limit)
local mult = 1
	if l_getSides() == 3 then mult = 12.6
	elseif l_getSides() >= 4 and l_getSides() <= 10 then mult = 19.1
	elseif l_getSides() >= 13 and l_getSides() <= 20 then mult = 19.6
	elseif l_getSides() >= 21 and l_getSides() <= 30 then mult = 20.6
	elseif l_getSides() >= 31 and l_getSides() <= 60 then mult = 21.6 -- invert spiral doesn't work on 60 sides more than 20s, excessive delay (also, too much delay for 100sides)
	end
return mult -- for speed = 3, thickness = 40
end

function shuffle(x)
	for i = #x, 2, -1 do
		local j = u_rndIntUpper(i)
		x[i], x[j] = x[j], x[i]
	end
end

function shuffle2D(x)
	for k = 1, #x do
		for i = #x[k], 2, -1 do
			local j = u_rndIntUpper(i)
			x[k][i], x[k][j] = x[k][j], x[k][i]
		end
	end
end

function whyCantIJustGoToTheMenu()
	e_kill() -- that sucks less
end

function setPulse(value) s_setPulseMin(value) s_setPulseMax(value) end

function setPulse3D(value) s_set3dPulseMin(value) s_set3dPulseMax(value) end

function setPulseDiff(value, diff) 
	if diff >= 0 then s_setPulseMin(value) s_setPulseMax(value+diff)
	else s_setPulseMin(value+diff) s_setPulseMax(value) end
end

function setHue(value) s_setHueMin(value) s_setHueMax(value) end

function setRotation(value) l_setRotationSpeed(value) end

function setSkew(value) s_set3dPulseMin(value) s_set3dPulseMax(value) end

function message(text, time) e_messageAddImportantSilent(text, time) end

function messageDifficulty(text, time) if u_getDifficultyMult() >= 1 then e_messageAddImportantSilent(text, time) end end

function getRoundedDifficulty() return math.ceil(u_getDifficultyMult() * 10000) / 10000 end

function getRoundedDifficulty3() return math.ceil(math.floor(u_getDifficultyMult() * 10000) / 10) / 1000 end -- ...

function getBpmPulses(diff, bpm, ratio)
    x = (ratio + 1) * diff * bpm / 3600.0 / ratio
    return x, x * ratio
end

function getStylePulse(diff, bpm)
	-- * 2 for left & right for each timing
	return bpm / 60 / 60 * 2 * diff
end

function coreLevelSettings()
	l_setSwapEnabled(false)
	l_set3dRequired(true)
	a_syncMusicToDM(false)
end

function time() return l_getLevelTime() end

function track(x) l_addTracked(x, x) end

function message(text, time) e_messageAddImportantSilent(text, time) end

function getBpmPulses(diff, bpm, ratio)
    x = (ratio + 1) * diff * bpm / 3600.0 / ratio
    return x, x * ratio
end
