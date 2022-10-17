local bit = require("bit")

CPL = bit.bnot
AND, OR, XOR = bit.band, bit.bor, bit.bxor
SL, SR = bit.lshift, bit.rshift
RL, RR = bit.rol, bit.ror

function BIT(a, b)		-- Tests bit b of a
	return AND(SR(a, b), 1)
end

function SET(a, b)		-- Sets bit b of a
	return OR(a, SL(1, b))
end

function RES(a, b)		-- Resets bit b of a
	return AND(a, CPL(SL(1, b)))
end