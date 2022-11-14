function pOddAltBarrageS(mTimes, mDelayMult)
    t = getRandomSide()
    m = 0
    d = -1
    b = getRandomDir()

    for a = 1, mTimes do
        for i = 1, l_getSides() do
            if b > 0 then
                if d == -1 then
                    cWall(t + m)
                    cWall(t + m)
                end
            else
                if d >= 0 then
                    cWall(t + m)
                    cWall(t + m)
                end
            end
            m = m + 1
            d = d + 1

            if d > 1 then
                d = -1
            end

        end
        m = 0
        d = -1
        b = b * -1
        t_wait(getPerfectDelayDM(THICKNESS) * 5.0 * mDelayMult)
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pWallExVortexS(mTimes, mStep, mExtraMult, mDelayMult)
    delay = getPerfectDelay(THICKNESS) * 5.0 * mDelayMult
    startSide = getRandomSide()
    loopDir = getRandomDir()
    currentSide = startSide

    for j = 0, mTimes do
        for i = 0, mStep do
            currentSide = currentSide + loopDir
            rWallEx(currentSide, loopDir * mExtraMult)
            t_wait(delay)
        end

        loopDir = loopDir * -1

        for i = 0, mStep + 1 do
            currentSide = currentSide + loopDir;
            rWallEx(currentSide, loopDir * mExtraMult)
            t_wait(delay)
        end
    end

    t_wait(getPerfectDelay(THICKNESS) * 8)
end

function pAltBarrageS(mTimes, mStep, mDelayMult)
    delay = getPerfectDelay(THICKNESS) * 5.0 * mDelayMult

    for i = 0, mTimes do
        cAltBarrage(i, mStep)
        t_wait(delay)
    end

    t_wait(getPerfectDelay(THICKNESS) * 8)
end

function pDoubleBarrageLeftRightS(mTimes, mDelayMult)
    t = getPlayerSide()
    m = 0
    d = getRandomDir()
    delay = getPerfectDelay(THICKNESS) * 5.0 * mDelayMult

    for a = 1, mTimes do
        cDoubleBarrage(t + m)
        m = m + d
        d = d * -1
        t_wait(delay)
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pSBarrageSpiralLR(mTimes, mDelayMult)
    delay = getPerfectDelay(THICKNESS) * 5.0 * mDelayMult
    startSide = getPlayerSide()

    for i = 0, mTimes do
        cBarrage(startSide)
        t_wait(delay)
        cBarrage(startSide + 1)
        t_wait(delay)
    end

    t_wait(getPerfectDelay(THICKNESS) * 8)

end

function pcBarrageWallLRS(mTimes, mDelayMult)
    delay = getPerfectDelay(THICKNESS) * 5.0 * mDelayMult
    startSide = getPlayerSide()

    for i = 0, mTimes do
        cBarrage(startSide)
        t_wait(delay)
        cWall(startSide)
        t_wait(delay)
    end

    t_wait(getPerfectDelay(THICKNESS) * 8)
end

function pBackAndForth2S(mTimes, mDelayMult)
    oldThickness = THICKNESS
    myThickness = THICKNESS * 2
    delay = getPerfectDelay(myThickness) * 5.0
    startSide = getPlayerSide()

    THICKNESS = myThickness

    for i = 0, mTimes do
        if i < mTimes then
            w_wall(startSide, myThickness + 9 * l_getSpeedMult() * delay)
            w_wall(startSide + (l_getSides() / 2), myThickness + 9 * l_getSpeedMult() * delay)
        end

        rWall(startSide + 1, oldThickness * 2)
        t_wait(delay * 0.5 * mDelayMult)
        rWall(startSide + 2, oldThickness * 2)
        t_wait(delay * 0.5 * mDelayMult)

    end

    THICKNESS = oldThickness
    t_wait(getPerfectDelay(THICKNESS) * 8)
end

function pBarrageSpiralRandomS(mTimes, mDelayMult)
    delay = getPerfectDelay(THICKNESS) * 5.0 * mDelayMult

    side = getPlayerSide()

    for i = 0, mTimes do
        dir = getRandomDir()
        side = side + dir
        cBarrage(side)
        t_wait(delay)
    end

    t_wait(getPerfectDelay(THICKNESS) * 8)
end
