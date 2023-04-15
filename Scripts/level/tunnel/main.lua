u_execDependencyScript("library_patternizer", "patternizer", "syyrion", "master.lua")

SIDES = 6

local speedInc

function onInit()
    function getWallSpeedInUnitsPerFrame()
        return l_getSpeedMult() * 5
    end

    a_syncMusicToDM(false)
    local diff = u_getDifficultyMult()
    speedInc = Incrementer:new(diff, 2, 14 - diff * 8)
    l_setSpeedMult(speedInc:get())
    l_setSpeedMax(math.huge)

    l_setRotationSpeed(0.1)

    l_setDelayMult(1)
    l_setSides(SIDES)
    l_setIncTime(15)

    l_setManualPulseControl(true)
    l_setPulse(50)
    l_setManualBeatPulseControl(true)
    l_setBeatPulse(0)

    l_setShowPlayerTrail(false)

    l_setRadiusMin(50)
    l_setPlayerSpeedMult(0.75)

    u_execScript("level/tunnel/object.lua")
end

local ticker
local isIncrementing = false
local rotationSpeed = SliderPerlin:new(5, 0.1)
local pattern

function onLoad()
    s_setStyle("tunnel")

    Torus:create()
    Player:create()

    local PATTERNS = {
        -- Tunnel
        [[
            a 80 p:.
            1 rmv
            -2 dup rmv
            4 for
                r 1 i p:_|.
                dup if
                    swap
                    -1 *
                    dup rmv
                    swap
                    a lpath 1 i + p:.
                end
            end
            1 rsleep
        ]],
        -- Spiral
        [[
            12 for
                r 1 i p:..
                1 rmv
            end
            1 rsleep
        ]],
        -- Alt-barrage
        [[
            6 for
                r 40 p:|._
                1 rmv
                125 thsleep
            end
            0.75 rsleep
        ]],
        -- Ex-barrage
        [[
            3 for
                r 40 p:_|.-_|.
                1 rmv
                125 thsleep
            end
            4 for
                r 40 p:_|.-_|.
                -1 rmv
                125 thsleep
            end
            0.5 rsleep
        ]],
        -- Alt-Half
        [[
            1
            6 for
                swap
                dup if
                    a 40 p:|_-|.
                else
                    a 40 p:|.-|_
                end
                not
                swap
                125 thsleep
            end
            0.5 rsleep
        ]],
        -- Alt-tunnel
        [[
            a 80 p:.
            1 rmv
            0 1 rnd
            5 for
                swap
                dup if
                    a 40 p:.|._
                else
                    a 40 p:.|_.
                end
                not
                swap
                dup if
                    a 125 p:.
                end
            end
            1 rsleep
        ]],
        -- Inverse
        [[
            7 for
                r 40 p:_|.
                $hsides 0 1 rnd if floor else ceil end rmv
                spath 1 i + thsleep
            end
        ]],
        -- Barrage Spiral
        [[
            7 for
                r 40 p:_|.
                1 rmv
                dup if
                    2 i thsleep
                end
            end
            1.5 rsleep
        ]],
        -- Barrage Spiral
        [[
            7 for
                r 40 p:_|.
                2 rmv
                dup if
                    3 i thsleep
                end
            end
            1.5 rsleep
        ]],
        -- Cave
        [[
            r 1 i p:_|.
            -1 rmv

            2.25 i thsleep

            r 1 i p:|.-_
            -2 rmv
            r 1 i p:_|.

            a 2 i p:.

            r 1 i p:.-.
            1 rmv
            r 1 i p:~|.-|_. 

            a 2 i p:.-.

            1 rmv
            r 1 i p:|.-|_.

            1.5 rsleep
        ]],
        -- Double Tunnel
        [[
            a 80 p:r
            1 rmv
            -2
            7 for
                r 1 i p:_rr
                dup if
                    a 125 p:r
                end
                swap dup rmv
                -1 *
                swap
            end
            1.5 rsleep
        ]]
    }
    pattern = Patternizer:new(unpack(PATTERNS))


    ticker = TimerRate:new(60, function(mFrameTime)
        TorusAngle:step(mFrameTime)
        MINOR_RADIUS:step(mFrameTime)

        pattern:run(mFrameTime)
        Wall:update(mFrameTime)
        Player:update()
        Torus:update()
        Quad:sort()

        rotationSpeed:step(mFrameTime)
        l_setRotationSpeed(rotationSpeed:getValue())

        if isIncrementing then
            if not Wall.pw:hasWalls(1) then
                Wall.pw.speed:freeze()
                pattern:resume()
                isIncrementing = false
            end
        end
    end)
end

function onIncrement()
    TorusAngle:increment()
    l_setSpeedMult(speedInc:increment())
    isIncrementing = true
    pattern:pause()
end

function onUpdate(mFrameTime)
    ticker:step(mFrameTime)
end
