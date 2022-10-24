Particles = {particles = {}}

function Particles:spawn(logic)
	local particle = {
		lifetime = 0,
		kill = false,
		logic = logic or function(self)
			-- set size, pos and if it should be killed depending on a particles lifetime
			if self.lifetime == 0 then
				-- set initial values
				self.pos = 1600 * s_get3dPulseMax() ^ 2
				self.angle = math.random() * math.pi * 2
				self.size = 0.25
				self.maxSize = 25 + (75 - 25) * (math.random() ^ 1.5)
				self.popAnim = true
				cw_setVertexColor4Same(self.cw, 100, 100, 255, 100)
			end

			-- cancel out rotation
			local rot = math.rad(l_getRotation())
			local angle = self.angle + rot
			local center = Fake:getOrbit(angle, self.pos, {0, 0})

			-- have it rotate around its own axis
			local selfAngle = self.angle * 2
			local pos0 = Fake:getOrbit(selfAngle, self.size, center)
			local pos1 = Fake:getOrbit(selfAngle + 0.5 * math.pi, self.size, center)
			local pos2 = Fake:getOrbit(selfAngle + math.pi, self.size, center)
			local pos3 = Fake:getOrbit(selfAngle + 1.5 * math.pi, self.size, center)
			cw_setVertexPos4(self.cw, pos0[1], pos0[2], pos1[1], pos1[2], pos2[1], pos2[2], pos3[1], pos3[2])

			-- update position
			self.pos = 1600 - self.lifetime * 7
			self.angle = self.angle + self.lifetime * 0.0001

			-- pop it out of nothing as creation animation to make it look more clean
			if self.popAnim and self.lifetime ~= 0 then
				self.size = self.lifetime * 5
				if self.size > self.maxSize then
					self.size = self.maxSize
					self.popAnim = false
				end
			else
				self.size = self.maxSize - self.lifetime * 0.4
			end

			-- remove particle if it isn't visible anymore
			self.kill = self.size <= 0
		end,
		cw = cw_createNoCollision()
	}
	table.insert(self.particles, particle)
	cw_setVertexPos4(particle.cw, 0, 0, 0, 0, 0, 0, 0, 0)
end


function Particles:update(frametime)
	local del_queue = {}
	for i=1,#self.particles do
		local particle = self.particles[i]
		particle:logic()
		particle.lifetime = particle.lifetime + frametime
		if particle.kill then
			cw_destroy(particle.cw)
			table.insert(del_queue, 1, i)
		end
	end
	for _, i in pairs(del_queue) do
		table.remove(self.particles, i)
	end
end
