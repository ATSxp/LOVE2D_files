local Timer = {}
function Timer:new(duration)
    local s = {}
    s.timer = love.timer.getTime()
    s.duration = duration

    function s:complete()
        return love.timer.getTime() - self.timer > self.duration
    end

    function s:fraction()
		return math.min((love.timer.getTime() - self.time) / self.duration, 1.0)
    end

    function s:reset()
        self.time = love.timer.getTime()
    end
    return s
end
return Timer