function singleOneOpenSide(side, thick)
    for i = 0, l_getSides() - 2 do
        w_wall(side + i, thick)
    end
end

function singleAltBarrage(side, thick)
    for i = 0, math.floor(l_getSides() / 2) do
        w_wall(side + i * 2, thick)
    end
end

function singleHalfBarrage(side, m, thick) -- used for two open sides (l-l-r-r like)
    for i = 0, getHalfSides(m) - 2 do
        w_wall(side + i - m, thick)
    end
end
