u_execDependencyScript("library_patternizer", "patternizer", "syyrion", "master.lua")

SIDES = 6

u_execScript("level/tunnel/object.lua")


function onInit()
    l_setSpeedMult(1)
	l_setRotationSpeed(0.02)
	l_setDelayMult(1)
	l_setSides(SIDES)
	l_setIncEnabled(false)

	l_setManualPulseControl(true)
    l_setPulse(50)
	l_setManualBeatPulseControl(true)
	l_setBeatPulse(0)

    l_setShowPlayerTrail(false)

    l_setRadiusMin(50)

    l_setRotation(0)
    l_setPlayerSpeedMult(0.75)

end

local ticker

function onLoad()
    s_setStyle("tunnel")

    Torus:create()
    Player:create()

    local pattern
    do
        local PATTERNS = {
            -- Non repeating random barrage
            [[
                8 12 rnd for
                    r 40 p:_|.
                    dup if
                        1 $sides 1 - rnd rmv
                        spath 100 + thsleep
                    end
                end
                1 rsleep
            ]],
            -- Tunnel
            [[
                a 80 p:.
                1 rmv
                -2
                3 5 rnd for
                    r 1 i p:_|.
                    dup if
                        swap
                        dup rmv
                        -1 *
                        swap
                        a lpath 0.5 i + p:.
                    end
                end
                1 rsleep
            ]],
            -- Spiral
            [[
                8 12 rnd for
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
                4 6 rnd for
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
                3 5 rnd for
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
                2 4 rnd for
                    r 40 p:_|.
                    $hsides 0 1 rnd if floor else ceil end rmv
                    spath 0.75 i + thsleep
                end
            ]],
            -- Barrage Spiral
            [[
                5 8 rnd for
                    r 40 p:_|.
                    1 rmv
                    dup if
                        2 i thsleep
                    end
                end
                1 rsleep
            ]]
        }
        pattern = Patternizer:new(unpack(PATTERNS))
    end


    ticker = TimerRate:new(60, function (mFrameTime)
        TorusAngle:step(mFrameTime)
        pattern:run(mFrameTime)
        BeatPulse.r:step(mFrameTime)
        BeatPulse.delay:step(mFrameTime)
        Player:update()
        Wall:update(mFrameTime)
        Torus:update()
        Quad:sort()
    end)
end

function onUpdate(mFrameTime)
    ticker:step(mFrameTime)
end