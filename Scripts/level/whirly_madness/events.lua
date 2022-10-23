u_execScript("level/whirly_madness/timings.lua")


Events = {
	passed = 0,
	scheduled = {},
	call_until = {}
}

function Events:updateTime(time)
	local currentTP = TIMINGS[self.passed + 1]
	if currentTP == nil then
		return true  -- done
	end
	local isSlider = false
	if type(currentTP) == "table" then
		currentTP = currentTP[1]
		isSlider = true
	end
	if time >= currentTP then
		self.passed = self.passed + 1
		if self.scheduled[self.passed] ~= nil then
			for _, func in pairs(self.scheduled[self.passed]) do
				if isSlider then
					table.insert(self.call_until, {
						startTime=TIMINGS[self.passed][1],
						duration=TIMINGS[self.passed][2],
						slides=TIMINGS[self.passed][3],
						length=TIMINGS[self.passed][4],
						finished_slides = 0,
						func=func
					})
				else
					func()
				end
			end
			self.scheduled[self.passed] = nil
		end
	end
	local del_queue = {}
	for i=1, #self.call_until do
		local data = self.call_until[i]
		if time >= data.startTime + data.duration then
			data.finished_slides = data.finished_slides + 1
			local done = data.slides == data.finished_slides
			if done then
				table.insert(del_queue, 1, i)
			end
			data.func(1, done, data.length, data.finished_slides)
		else
			data.func((time - data.startTime - data.finished_slides * data.duration) / data.duration, false, data.length * (1.2 ^ difficultyAdjust), data.finished_slides)
		end
	end
	for _, v in pairs(del_queue) do
		table.remove(self.call_until, v)
	end
end

function Events:scheduleNext(timeType, func)
	for i=self.passed + 1, #TIMINGS do
		if type(TIMINGS[i]) == timeType then
			if self.scheduled[i] == nil then
				self.scheduled[i] = {func}
			else
				table.insert(self.scheduled[i], func)
			end
			return true
		end
	end
end

function Events:atNextP(func)
	-- execute a function at the next circle
	self:scheduleNext("number", func)
end

function Events:atNextS(func)
	-- execute a function while the next slider is sliding
	self:scheduleNext("table", func)
end
