function randomWeighted(min, max, exponent)
	min = min or 0
	max = max or 1
	exponent = exponent or 0.5
	return min + (max - min) * (math.random()^exponent)
end



