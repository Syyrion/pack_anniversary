-- baba's patterns, use them if you want i dont care
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

t = getRandomSide()
m = 0
d = getRandomDir()

function pBarrageLeftRight(mTimes, mDistance)
    t = getRandomSide()
    m = 0
    d = getRandomDir() * mDistance

    for a = 1, mTimes do
        cBarrage(t + m)

        m = m + d
        d = d * -1

        t_wait(custWait(4 * ((mDistance / 4) + 1)))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pAltTunnel(mTimes)
    t = getRandomSide()
    m = 0
    d = getRandomDir()

    for i = 1, math.floor(l_getSides() / 2) do
        w_wall(i + t, (custThickness(3.9 * mTimes)) + 40)
    end

    for a = 1, mTimes + 1 do
        for i = 1, getHalfSides() do
            cWall((i * 2) + t + m)
        end
        m = m + d
        d = d * -1

        if a == mTimes + 1 then
            for i = 1, math.floor(l_getSides() / 2) do
                w_wall(i + t, 40)
            end
        end

        t_wait(custWait(3.9))
    end



    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

-- this one is an old one! from an old 1.92 pack i made, a bit different now though
function pJumble(mTimes, mDelay, mChance)
    t = getRandomSide()

    for a = 1, mTimes do
        for i = 1, mChance do
            cWall(getRandomSide())
        end
        t_wait(custWait(mDelay * 2.75))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

-- this pattern might not work on certain side counts, anything that can be multiplied by 3 will definitally work!
function pOddAltBarrage(mTimes)
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
        t_wait(custWait(4))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

-- unlike the odd alt barrage, this one is 180 based, instead of every 3 sides
function pEvenAltBarrage(mTimes)
    t = getRandomSide()
    m = 0
    d = 0
    b = getRandomDir()

    for a = 1, mTimes do
        for i = 1, l_getSides() do
            if b > 0 then
                if d == 0 then
                    cWall(t + m)
                    cWall(t + m)
                end
            else
                if d > 0 then
                    cWall(t + m)
                    cWall(t + m)
                end
            end
            m = m + 1
            d = d + 1

            if d > getHalfSides() - 1 then
                d = 0
            end

        end
        m = 0
        d = 0
        b = b * -1
        t_wait(custWait(4))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function cDoubleBarrage(mSide)
    for i = 1, l_getSides() - 3 do
        cWall(i + mSide + 1)
        cWall(mSide)
    end
end

function pDoubleBarrageSpiral(mTimes)
    t = getRandomSide()
    m = 0
    d = getRandomDir()

    for a = 1, mTimes do
        cDoubleBarrage(t + m)
        m = m + d
        t_wait(custWait(4))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pDoubleBarrageInverse(mTimes)
    t = getRandomSide()
    m = 0

    for a = 1, mTimes do
        cDoubleBarrage(t + m)
        m = m + getHalfSides()
        t_wait(custWait(4))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pDoubleBarrageLeftRight(mTimes)
    t = getRandomSide()
    m = 0
    d = getRandomDir()

    for a = 1, mTimes do
        cDoubleBarrage(t + m)
        m = m + d
        d = d * -1
        t_wait(custWait(4))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pDoubleTunnel(mTimes)
    t = getRandomSide()
    d = getRandomDir() * math.floor(l_getSides() / 2)
    m = 0


    w_wall(t + ((d + math.floor(l_getSides() / 2)) / 2), custThickness(3.75 * mTimes) + 40)
    w_wall(t + getHalfSides() + ((d + math.floor(l_getSides() / 2)) / 2), custThickness(3.75 * mTimes) + 40)

    for a = 1, mTimes + 1 do
        if l_getSides() > 5 then
            cDoubleBarrage(t + m)
        else
            cWall(t + m)
            cWall(t + m - 4)
            cWall(t + m - 1)
        end

        m = m + d
        d = d * -1
        t_wait(custWait(3.75))
    end



    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pAltHalf(mTimes)
    t = getRandomSide()
    m = 0
    b = getRandomDir()

    for a = 1, mTimes do
        for i = 1, l_getSides() do
            if b > 0 then
                if m < getHalfSides() then
                    w_wall(t + m, THICKNESS)
                end
            else
                if m >= getHalfSides() then
                    w_wall(t + m, THICKNESS)
                end
            end

            m = m + 1
        end

        m = 0
        b = b * -1
        t_wait(custWait(3.7))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

oldM = 0
delay = 0

function pRandomTunnel(mTimes)
    t = getRandomSide()
    oldM = 0
    m = 0
    delay = 0

    for a = 1, mTimes do
        for i = 1, getBarrageSide() do
            cWall(i + t + m + 1)
        end
        oldM = m
        m = math.random(0, l_getSides() - 2)

        delay = oldM - m

        if delay < 0 then
            delay = delay * -1
        end

        w_wall(t, custThickness(3 * (delay / 1.25) + 1.25) + 20)
        t_wait(custWait(3 * (delay / 1.25) + 1.25))
    end

    for i = 1, getBarrageSide() do
        cWall(i + t + m + 1)
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 11)
end

function pJumbleTunnel(mTimes, mChance, mDelay)
    t = getRandomSide()
    d = math.random(1, 5)

    w_wall(t, custThickness(2.75 * mDelay * mTimes) + 40)

    for a = 1, mTimes + 1 do
        for i = 1, mChance do
            w_wall(t + d, 40)
            d = math.random(1, 5)
        end
        t_wait(custWait(2.75 * mDelay))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pAltTrapBarrage(mTimes, mGap)
    t = getRandomSide()
    d = -1
    m = 0

    for a = 1, mTimes do
        for i = 1, l_getSides() do
            if d < 0 then
                if i > mGap then
                    cWall(i + t)
                end
            elseif d > 0 then
                if i <= mGap then
                    cWall(i + t)
                end
            end
            m = m + 1
        end
        m = 0
        d = d * -1
        t_wait(custWait(3.6))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

-- my own versions of existing patterns, why? why not! i like doing things the way i prefer to do it, and if you complain ill probably cry. so you better not

function pBabasAltBarrage(mTimes)
    t = getRandomSide()
    d = getRandomDir()
    m = d

    for a = 1, mTimes do
        for i = 1, l_getSides() do
            if m > 0 then
                cWall(i + t)
            end
            m = m * -1
        end
        d = d * -1
        m = d
        t_wait(custWait(3.6))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pBabasBarrageSpiral(mTimes)
    t = getRandomSide()
    d = getRandomDir()
    m = 0

    for a = 1, mTimes do
        for i = 1, l_getSides() - 1 do
            cWall(i + t + m)
        end
        m = m + d
        t_wait(custWait(4.4))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pBabasMirrorSpiral(mTimes)
    t = getRandomSide()
    d = getRandomDir()
    m = 0

    for a = 1, mTimes do
        w_wall(t + m, custThickness(2))
        w_wall(t + m + getHalfSides(), custThickness(2))
        m = m + d
        t_wait(custWait(2))
    end

    d = d * -1

    for a = 1, mTimes do
        w_wall(t + m, custThickness(2))
        w_wall(t + m + getHalfSides(), custThickness(2))
        m = m + d
        t_wait(custWait(2))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pBabasMirrorSpiralNrev(mTimes)
    t = getRandomSide()
    d = getRandomDir()
    m = 0

    for a = 1, mTimes do
        w_wall(t + m, custThickness(2))
        w_wall(t + m + getHalfSides(), custThickness(2))
        m = m + d
        t_wait(custWait(2))
    end


    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pBabasTunnel(mTimes)
    t = getRandomSide()
    d = getRandomDir()

    w_wall(t, custThickness(9 * mTimes) + 30)

    for a = 1, mTimes + 1 do
        for i = 1, getBarrageSide() do
            w_wall(i + t + d, 70)
        end
        d = d * -1
        t_wait(custWait(9))
    end


    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end

function pBabasSpiral(mTimes, mThickness, mExtra)
    t = getRandomSide()
    d = getRandomDir()
    m = 0

    for a = 1, mTimes do
        for i = 1, 1 + mExtra do
            w_wall(i + t + m, custThickness(2 * mThickness))
        end

        m = m + d
        t_wait(custWait(2 * mThickness))
    end

    t_wait(getPerfectDelayDM(THICKNESS) * 8)
end
