u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

u_execScript("/level/colorfulchaos/patterns.lua")
u_execScript("/level/colorfulchaos/customwall.lua")

function addPattern(mKey)
    if mKey == 0 then pKay10y_HexagonAlt()
		elseif mKey == 1 then pKay10y_HexagonSpiral()
		elseif mKey == 2 then pKay10y_BarrageSpiral()
		elseif mKey == 3 then pKay10y_HexagonLadder()
		elseif mKey == 4 then pKay10y_HexagonTunnel()
		elseif mKey == 5 then pKay10y_CRepeat()
		elseif mKey == 6 then pKay10y_HexagonWrapper()
		elseif mKey == 7 then pKay10y_HexagonBat()
		elseif mKey == 8 then pKay10y_CurveSpiral()
		elseif mKey == 9 then pKay10y_HexagonSwap()
    end
end

keys = { 0, 0, 1, 8, 2, 2, 3, 4, 5, 5, 6, 6, 7, 9, 9 }
shuffle(keys)
index = 0

difftxt = "Normal"

function onInit()
	--l_setSpeedMult(2.45)
	l_setSpeedInc(0.175)
	--l_setRotationSpeed(0.40)
	l_setRotationSpeedMax(10.0)
	l_setRotationSpeedInc(0.07)
	l_setDelayMult(1.0)
	l_setDelayInc(-0.01)
	l_setFastSpin(60.0)
	l_setSides(6)
	l_setSidesMin(6)
	l_setSidesMax(6)
	l_setIncTime(15)
	
	l_setPulseMin(58)
	l_setPulseMax(74)
	l_setPulseSpeed(2.5) --2.5
	l_setPulseSpeedR(1.8) --1.8
	l_setPulseDelayMax(6.65)

	l_setBeatPulseMax(17)
	l_setBeatPulseDelayMax(3600/165)
	l_setBeatPulseSpeedMult(0.75)
	--s_setMaxSwapTime(21.81*4) --87.21
	
	l_setSwapEnabled(true)
	l_setSwapCooldownMult(0.65)
	
	l_addTracked("difftxt", "Difficulty")
end

diff = simplifyFloat(u_getDifficultyMult(), 4)

if diff == 1.0000 then
	l_setSpeedMult(2.45)
    l_setRotationSpeed(0.45)
	difftxt = "Normal"
elseif diff == 1.0001 then
	l_setSpeedMult(3.05)
    l_setRotationSpeed(0.60)
	difftxt = "Hard"
elseif diff == 1.0002 then
	l_setSpeedMult(3.45)
    l_setRotationSpeed(0.80)
	difftxt = "Insane"
end

function onLoad()
	Ring:create() --Thank you Baum and Vipre for helping me make this!!! :D
	Ring:calculateVertices(1)
end

function onStep()
	addPattern(keys[index])
	index = index + 1
	
	if index - 1 == #keys then
		index = 1
	end
end

function onIncrement()
end

function onUnload()
end

pos = 0
time = 0

function onUpdate(mFrameTime)
	time = time + mFrameTime
	if time >= 1 then
		pos = pos + mFrameTime/30
	else
		pos = 0
	end
	
	if time >= 43.62 then
		time = 0
	end

	pos = math.min(pos, 1)
	Ring:updatePosition(lerp(0, 1500, pos))
end