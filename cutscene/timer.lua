function Timer(duration)
	local s = {}
	s.time = love.timer.getTime()
	s.duration = duration

	s.complete = function()
		return love.timer.getTime() - s.time > s.duration
	end
	
	s.fraction=function()
		return math.min((love.timer.getTime() - s.time) / s.duration, 1.0)
	end
	
	s.reset=function()
		s.time = love.timer.getTime()
	end
	return s
end