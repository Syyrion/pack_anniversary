--[[
=== C O M M O N S ===
--]]

function fwcWall(mSide, mDistanceAdd, mThickness, mShape)
    wImpWall(mSide, 1 - mDistanceAdd, nil, mThickness, mShape, 0, 255, 255, 255, 50, 125, false)
end

function fwrWall(mSide, mDistanceAdd, mThickness, mShape)
    fwcWall(mSide, mDistanceAdd, mThickness, mShape)
    fwcWall(mSide + math.floor(mShape / 2), mDistanceAdd, mThickness, mShape)
end

function fwcBarrage(mSide, mDistanceAdd, mThickness, mShape)
    for i = 1, mShape - 1 do
        fwcWall(mSide + i, mDistanceAdd, mThickness, mShape)
    end
end

function fwcDoubleBarrage(mSide, mDistanceAdd, mThickness, mShape, mLevel)
    if mLevel == 1 then
        for i = 3, mShape - 3 do
            fwcWall(mSide + i, mDistanceAdd, mThickness, mShape)
        end
        fwcWall(mSide - 1, mDistanceAdd, mThickness, mShape)
        fwcWall(mSide + 1, mDistanceAdd, mThickness, mShape)
    else
        for i = 2, mShape - 2 do
            fwcWall(mSide + i, mDistanceAdd, mThickness, mShape)
        end
        fwcWall(mSide, mDistanceAdd, mThickness, mShape)
    end
end

function fwcWallExM(mSide, mDistanceAdd, mThickness, mAdd, mMult, mShape)
    for i = 1, 1 + mAdd do
        fwcWall(mSide + i * mMult, mDistanceAdd, mThickness, mShape)
    end
end

function fwcMirror(mSide, mDistanceAdd, mThickness, mStep, mShape)
    for i = 1, mStep do
        fwcWall(mSide + math.floor(i * (mShape / mStep)), mDistanceAdd, mThickness, mShape)
    end
end

function fwcVorta(mSide, mDistanceAdd, mThickness, mShape)
    for i = 1, math.floor(mShape / 2) - 1 do
        fwcWall(mSide + i, mDistanceAdd, mThickness, mShape)
    end
    for i = 1, math.ceil(mShape / 2) - 1 do
        fwcWall(mSide + i + math.floor(mShape / 2), mDistanceAdd, mThickness, mShape)
    end
end

function thilvue(mThickness)
    return mThickness * 40 * (u_getSpeedMultDM() / 2)
end

function scthilvue(mSeconds)
    return (u_getSpeedMultDM() * 5) * mSeconds * 60
end

--[[
=== P A T T E R N S ===
--]]

function fwpBarrageSpiral(mShape, mTempo, mFreq)
local t, d = u_rndIntUpper(mShape) - 1, getRandomDir()

    for a = 0, mFreq - 1 do
        fwcBarrage(t + (a * d), scthilvue(getBPM(mTempo) * a), 40, mShape)
    end
end

function fwpAltBarrage(mShape, mTempo, mFreq)
local t, m, d = u_rndIntUpper(mShape) - 1, 0, getRandomDir()

    for a = 0, mFreq - 1 do
        fwcWallExM(t + m, scthilvue(getBPM(mTempo) * a), 40, math.floor(mShape / 2) + (d * 0.5 - 0.5), 2, mShape)
        m = m + d
        d = d * -1
    end
end

function fWhirlwind(mShape, mTempo, mFreq)
local t, d = u_rndIntUpper(mShape) - 1, getRandomDir()

    for a = 0, mFreq - 1 do
        fwcMirror(t + (a * d), scthilvue(getBPM(mTempo) * a), -scthilvue(getBPM(mTempo)), math.floor(mShape / 3), mShape)
    end
end

function fwpBarrageInverts(mShape, mTempo, mFreq)
local t, d = u_rndIntUpper(mShape) - 1, u_rndInt(0, 1)

    for a = 0, mFreq - 1 do
        fwcBarrage((a % 2) * math.floor(mShape / 2), scthilvue(getBPM(mTempo) * a), 40, mShape)
    end
end

function fwpVortaRev(mShape, mTempo, mFreq)
local t, m, d = u_rndIntUpper(mShape) - 1, 0, u_rndInt(0, 1)

    for a = 0, mFreq - 1 do
        fwcVorta(m, scthilvue(getBPM(mTempo) * a), 40, mShape)
        m = m + 1
        if a == math.floor(mShape / 2) - 1 then d = d * -1 end
    end
end

function fwpMirrorWallStrip(mShape, mTempo)
local t, d = u_rndIntUpper(mShape) - 1, getRandomDir()

    for a = 0, 1 do
        fwrWall(t, scthilvue(getBPM(mTempo, 2, 6) + getBPM(mTempo, 4, a)), 40, mShape)
    end
end

function fwpTunnel(mShape, mTempo, mFreq)
local t, d = u_rndIntUpper(mShape) - 1, getRandomDir()

    fwcWall(t, 0, -scthilvue(getBPM(mTempo) * (mFreq - 1)), mShape)

    for a = 0, mFreq - 1 do
        fwcBarrage(t + d, scthilvue(getBPM(mTempo) * a), 70, mShape)
        d = d * -1
    end
end

--[[
=== P A R T I C L E S ===
--]]

function bgFireflies(mSpeed)
    wNewDeco(0, 0, 10, 0, 10, 10, 0, 10, 255, 255, 255, 118, mSpeed / 2, 3, 0, u_rndInt(0, 360), true)
end