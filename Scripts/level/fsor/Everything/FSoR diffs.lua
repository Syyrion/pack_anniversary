-- I know it's very stupid, but I don't know lua syntactic sugar and etc

function setManyParams(params)
    INTRO_SPEED = params[1]
    INTRO_DELAY = params[2]
    INTRO_ROTATION = params[3]

    SPEED_DROP_INCR = params[4]
    DELAY_DROP = params[5]
    ROTATION_DROP = params[6]

    SPEED_INCR = params[7]
    DELAY_INCR = params[8]
    ROTATION_INCR_WHILE_SWITCH = params[9]

    ROTATION_END = params[10]
    ROTATION_SWITCH_ADDITIONAL_ANGLE_FLICK = params[11]
    ROTATION_FLICK_MULT = params[12]
    DIFF_NAME = params[13]
end

function setDiffParams(diff)
    if diff == 0.99 then setManyParams({
            0.5, 6, 0.035,
            0.15, 4.9, 0.35,
            -0.15, 0, 0.001,
            0.3, 0, 0.9, "Basement"
        })

    elseif diff == 0.991 then setManyParams({
            0.5, 6, 0.07,
            0.15, 4.9, 1,
            -0.15, 0.1, 0.003,
            0.5, 30, 1, "91"
        })

    elseif diff == 0.992 then setManyParams({
            0.5, 6, 0.09,
            0.15, 4.9, 1.45,
            -0.15, 0.1, 0.0045,
            0.65, 50, 1.075, "92"
        })

    elseif diff == 0.995 then setManyParams({
            2, 1.85, 0.055,
            0.15, 1.75, 0.5,
            0.15, 0.1, 0.0015,
            0.35, 20, 0.9, "95"
        })

    elseif diff == 0.998 then setManyParams({
            2.3, 1.55, 0.065,
            0.2, 1.45, 0.7,
            0.25, 0.1, 0.002,
            0.4, 25, 0.9, "98"
        })

    elseif diff == 0.999 then setManyParams({
            2.65, 1.45, 0.07,
            0.25, 1.35, 0.85,
            0.25, 0.075, 0.0025,
            0.45, 30, 0.95, "99"
        })

    elseif diff == 1 then setManyParams({
            3, 1.35, 0.075,
            0.3, 1.25, 1,
            0.25, 0.05, 0.003,
            0.5, 35, 1, " "
        })

    elseif diff == 1.001 then setManyParams({
            3.35, 1.25, 0.08,
            0.3, 1.15, 1.15,
            0.25, 0.05, 0.0035,
            0.55, 40, 1.05, "01"
        })

    elseif diff == 1.002 then setManyParams({
            3.7, 1.15, 0.085,
            0.3, 1.075, 1.3,
            0.25, 0.025, 0.004,
            0.6, 45, 1.075, "02"
        })

    elseif diff == 1.005 then setManyParams({
            4.05, 1.05, 0.09,
            0.3, 1.025, 1.45,
            0.25, 0.010, 0.0045,
            0.65, 50, 1.075, "Universe"
        })
    end
end
