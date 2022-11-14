u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execScript("/level/colorfulchaos/evolutionpatterns.lua")

--Created by Kaylaxie--

function cWallThick(mSide, THICKNESS)
    for x = 2, l_getSides() do
        w_wall(x + mSide, THICKNESS)
    end
end

function pKay10y_CRepeat()
    random = getRandomSide()

    cBarrage(1 + random)
    t_wait(9.0)
    cBarrage(1 + random)
    t_wait(24.0)
end

function pKay10y_HexagonAlt()
    random = getRandomSide()

    for i = 1, 2, 1 do
        cWall(2 + random)
        cWall(4 + random)
        cWall(6 + random)
        t_wait(22.0)
        cWall(1 + random)
        cWall(3 + random)
        cWall(5 + random)
        t_wait(22.0)
    end
    cWall(2 + random)
    cWall(4 + random)
    cWall(5 + random)
    cWall(6 + random)
    t_wait(36.0)
end

function pKay10y_HexagonSpiral()
    oldThickness = THICKNESS
    myThickness = getPerfectThickness(THICKNESS)
    random = getRandomSide()
    times = 0

    if math.random(1, 2) == 1 then
        repeat
            for x = 1, 6, 1 do
                w_wall(x + random, myThickness * 1.04)
                t_wait(6.76)
            end
            times = times + 1
        until times == 2
    elseif math.random(1, 2) == 2 then
        repeat
            for x = 6, 1, -1 do
                w_wall(x + random, myThickness * 1.04)
                t_wait(6.76)
            end
            times = times + 1
        until times == 2
    end
    t_wait(24)
end

function pKay10y_CurveSpiral()
    oldThickness = THICKNESS
    myThickness = getPerfectThickness(THICKNESS)
    random = getRandomSide()
    times = 0
    dir = getRandomDir()
    wallCurvSpd = 4

    if math.random(1, 2) == 1 then
        repeat
            for x = 1, 6, 1 do
                wallHMStop(x + random, wallCurvSpd * dir, myThickness * 1.04)
                t_wait(6.76)
            end
            times = times + 1
        until times == 2
    elseif math.random(1, 2) == 2 then
        repeat
            for x = 6, 1, -1 do
                wallHMStop(x + random, wallCurvSpd * dir, myThickness * 1.04)
                t_wait(6.76)
            end
            times = times + 1
        until times == 2
    end
    t_wait(24)
end

function pKay10y_BarrageSpiral()
    random = getRandomSide()

    if math.random(1, 2) == 1 then
        for x = 1, math.random(2, 4), 1 do
            cBarrage(x + random)
            t_wait(16.0)
        end
    elseif math.random(1, 2) == 2 then
        for x = math.random(2, 4), 1, -1 do
            cBarrage(x + random)
            t_wait(16.0)
        end
    end
    t_wait(16.0)
end

function pKay10y_HexagonTunnel()
    oldThickness = THICKNESS
    myThickness = getPerfectThickness(THICKNESS)
    random = getRandomSide()

    w_wall(1 + random, myThickness * 12.0)
    cWallThick(1 + random, myThickness / 1.1)
    t_wait(32.0)
    cWallThick(5 + random, myThickness / 1.1)
    t_wait(32.0)
    cWallThick(2 + random, myThickness / 1.1)
    t_wait(32.0)
    cWallThick(4 + random, myThickness / 1.1)
    t_wait(38.0)
end

function pKay10y_HexagonBat()
    oldThickness = THICKNESS
    myThickness = getPerfectThickness(THICKNESS)
    random = getRandomSide()

    w_wall(3 + random, myThickness * 7)
    for a = 1, 5 do
        w_wall(a + random, myThickness * 1.05)
    end
    t_wait(8.0)
    for b = 2, 4 do
        w_wall(b + random, myThickness * 1.05)
    end
    t_wait(18.0)
    for c = 5, 6 do
        w_wall(c + random, myThickness * 1.05)
    end
    w_wall(1 + random, myThickness * 1.05)
    t_wait(8.0)
    w_wall(6 + random, myThickness * 1.05)
    t_wait(12.0)
    for b = 2, 4 do
        w_wall(b + random, myThickness * 1.05)
    end
    t_wait(8.0)
    for a = 1, 5 do
        w_wall(a + random, myThickness * 1.05)
    end
    t_wait(36.0)
end

function pKay10y_HexagonWrapper()
    random = getRandomSide()

    cWall(1 + random)
    cWall(2 + random)
    t_wait(16.0)
    cWall(6 + random)
    cWall(3 + random)
    t_wait(16.0)
    cWall(5 + random)
    cWall(4 + random)
    t_wait(16.0)
    cWall(6 + random)
    cWall(3 + random)
    t_wait(16.0)
    cWall(1 + random)
    cWall(2 + random)
    t_wait(30.0)
end

function pKay10y_HexagonLadder()
    oldThickness = THICKNESS
    myThickness = getPerfectThickness(THICKNESS)
    random = getRandomSide()

    w_wall(1 + random, myThickness * 7)
    w_wall(4 + random, myThickness * 7)
    cBarrage(2 + random)
    t_wait(18.0)
    cBarrage(3 + random)
    t_wait(18.0)
    cBarrage(2 + random)
    t_wait(18.0)
    cBarrage(3 + random)
    t_wait(34.0)
end

function pKay10y_HexagonSwap()
    oldThickness = THICKNESS
    myThickness = getPerfectThickness(THICKNESS)
    random = getRandomSide()

    cBarrage(1 + random)
    w_wall(2 + random, myThickness * 2)
    w_wall(6 + random, myThickness * 2)
    t_wait(15.0)
    for x = 1, 2 do
        w_wall(x + random, 40)
    end
    w_wall(6 + random, 40)
    t_wait(30.0)
end
