function neuroDelay(mMult) -- https://www.desmos.com/calculator/2wguctlrlu
    return mMult * (0.41 ^ (l_getSpeedMult() - 3) + 1.6)
end

-- is equal to getPerfectDelay. use this for vortexes and alt barrages
function neuroDelayPerfect(mMult)
    return 40 * mMult * u_getDelayMultDM() / (5.02 * u_getSpeedMultDM())
end

-- gets a thickness for a wall based on the delay and speed, to keep proportions. (use this for tunnels, spirals, etc)
-- for some reason the best mMult seems to always be 5, but maybe that's a coincidence
-- it seems to occaisonally have slight precision problems, (mDelay + 0.15) is there to compensate
function neuroThickness(mDelay, mMult)
    mMult = mMult or 5
    return (mDelay + 0.15) * u_getSpeedMultDM() * mMult
end

interPatternDelay = 14 -- the delay between patterns in units of neuroDelay, keep it above 12.3

function pAltBarrage(mTimes, mDelayMult)
    for i = 1, mTimes do
        cAltBarrage(i, 2)
        t_wait(neuroDelayPerfect(5.25 * mDelayMult))
    end

    t_wait(neuroDelay(interPatternDelay) - neuroDelayPerfect(5.25 * mDelayMult))
end

function pRandomBarrageNoRepeats(mTimes, mDelayMult)
    delay = (80 / (l_getSides() + 26)) * mDelayMult -- these funny numbers make the pattern work better on different sidecounts
    side = getRandomSide()
    oldSide = 0

    for i = 1, mTimes do
        cBarrage(side)
        oldSide = side
        while oldSide == side do
            side = getRandomSide()
        end
        t_wait(neuroDelay((1 + (getSideDistance(side, oldSide))) * delay))
    end

    t_wait(neuroDelay(interPatternDelay) - neuroDelay(2.1 + (getSideDistance(side, oldSide) * 3.4 * mDelayMult)))
end

function pWallExVortexNew(mTimes, mStep, mExtraMult, mDelayMult)
    delay = neuroDelayPerfect(5.25 * mDelayMult)
    startSide = getRandomSide()
    --mExtraMult = l_getSides()/2 - 2
    wallDir = getRandomDir() -- the common version of this pattern has loopDir used in the cWallEx code LMAO
    currentSide = startSide

    if l_getSides() % 2 > 0 then
        function rWallEx(mSide, mExtra)
            cWallEx(mSide, mExtra)
            oWallEx(mSide, mExtra)
            cWall(mSide + getHalfSides() - 1)
        end
    end

    for j = 1, mTimes do
        for i = 1, mStep do
            rWallEx(currentSide, mExtraMult)
            t_wait(delay)

            currentSide = currentSide + wallDir
        end

        wallDir = wallDir * -1

        for i = 1, mStep + 1 do
            rWallEx(currentSide, mExtraMult)
            t_wait(delay)

            currentSide = currentSide + wallDir
        end
    end

    t_wait(neuroDelay(interPatternDelay) - delay)
end

function pBarrageWall(mTimes, mDelayMult)
    delay = neuroDelayPerfect(5.25 * mDelayMult)
    startSide = getRandomSide()

    for i = 1, mTimes do
        cBarrage(startSide)
        t_wait(delay)
        cWall(startSide)
        t_wait(delay)
    end

    cBarrage(startSide)

    t_wait(neuroDelay(interPatternDelay))
end

-- ALTERNATIVE PATTERNS THAT AREN'T AS GOOD

function pInverseBarrage(mTimes, mDelayMult)
    delay = neuroDelay(11.1 * mDelayMult) -- pretty tight
    startSide = getRandomSide()

    for i = 1, mTimes do
        cBarrage(startSide)
        t_wait(delay)
        cBarrage(startSide - getHalfSides())
        t_wait(delay)
    end

    t_wait(neuroDelay(interPatternDelay) - delay)
end

function pBarrageLR(mTimes, mStep, mDelayMult)
    delay = neuroDelay(5 * mDelayMult) -- this would be neuroDelayPerfect, but this pattern supports >1 side turns, which would be a bad combination
    startSide = getRandomSide()

    for i = 1, mTimes do
        cBarrage(startSide)
        t_wait(delay)
        cBarrage(startSide + mStep)
        t_wait(delay)
    end

    t_wait(neuroDelay(interPatternDelay) - delay)
end

function pBarrageSpiral(mTimes, mStep, mDelayMult)
    delay = neuroDelay(5.25 * mDelayMult)
    startSide = getRandomSide()
    loopDir = mStep * getRandomDir()

    for i = 1, mTimes do
        cBarrage(startSide)
        startSide = startSide + loopDir
        t_wait(delay)
    end

    t_wait(neuroDelay(interPatternDelay) - delay)
end

-- THICKER, EASIER PATTERNS

function pMirrorSpiral(mTimes, mDelayMult)
    delay = neuroDelay(4 * mDelayMult)
    howThick = neuroThickness(delay)
    startSide = getRandomSide()
    loopDir = getRandomDir()
    local function rWall(mSide)
        t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
        w_wall(startSide, howThick)
        w_wall(startSide + getHalfSides(), howThick)
        t_eval("l_setWallAngleLeft(-0.525) l_setWallAngleRight(0.525) l_setWallSkewLeft(20) l_setWallSkewRight(20)")
        w_wall(startSide, howThick)
        w_wall(startSide + getHalfSides(), howThick)
    end

    for i = 1, mTimes do
        rWall(startSide)
        startSide = startSide + loopDir
        t_wait(delay)
    end

    t_wait(neuroDelay(interPatternDelay) - delay)
end

-- simplified tunnel code. the walls are thin because i like it that way
function pTunnel(mTimes, mDelayMult)
    delay = neuroDelay(15 * mDelayMult)
    startSide = getRandomSide()
    loopDir = getRandomDir()

    for i = 1, mTimes do
        t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
        w_wall(startSide, neuroThickness(delay) + 5)

        cBarrage(startSide + loopDir)
        t_wait(delay)

        loopDir = loopDir * -1
    end

    cBarrage(startSide + loopDir)

    t_wait(neuroDelay(interPatternDelay))
end
