Status = {
	bpm = 0,
	sliderVel = 0,
	radius = 0
}

function Status:updateTPs(time)
	-- set the current slider velocity and BPM based on the timing points
	for pointTime, values in pairs(TIMING_POINTS) do
		if time >= pointTime then
			self.bpm = values.BPM or self.bpm
			self.sliderVel = values.SV or self.sliderVel
		end
	end
end


function Status:updateRadius()
	self.radius = l_getRadiusMin() * (l_getPulse() / l_getPulseMin()) + l_getBeatPulse()
end
