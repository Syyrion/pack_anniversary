function createBlackSquare(r1, r2, f1, f2)
    s = cw_create()
    cw_setVertexPos(s, 0, r1 * math.cos(f2 / 180 * math.pi), r1 * math.sin(f2 / 180 * math.pi))
    cw_setVertexPos(s, 1, r1 * math.cos(f1 / 180 * math.pi), r1 * math.sin(f1 / 180 * math.pi))
    cw_setVertexPos(s, 2, r2 * math.cos(f1 / 180 * math.pi), r2 * math.sin(f1 / 180 * math.pi))
    cw_setVertexPos(s, 3, r2 * math.cos(f2 / 180 * math.pi), r2 * math.sin(f2 / 180 * math.pi))

    cw_setVertexColor(s, 0, 0, 0, 0, 0)
    cw_setVertexColor(s, 1, 0, 0, 0, 0)
    cw_setVertexColor(s, 2, 0, 0, 0, 255)
    cw_setVertexColor(s, 3, 0, 0, 0, 255)

    cw_setCollision(s, false)
    cw_setDeadly(s, false)
end

function createCoverStuff()
    for i = 0, 19 do
        addThick = math.max(0, 15 - i * 3)
        parts = 3
        for k = 1, parts do
            w_wallAcc(i + l_getSides() / parts * k - 1, 60 + addThick - i * 2, 10, -16.1 - i * 0.8, 0, 10)
            w_wallAcc(i + l_getSides() / parts * k + 1, 60 + addThick - i * 2, 10, -16.1 - i * 0.8, 0, 10)
        end
    end
end

function createCoverStuff2()
    for i = 0, 4 do
        w_wallAcc(30 * i, 350, 10, -16.1 - 8, 0, 10)
    end
end
