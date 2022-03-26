local Timer = {}

function Timer:new(duration)
    local s = {}
    s.timer = love.timer.getTime()
    s.duration = duration

    function s:complete()
        return love.timer.getTime() - s.timer > s.duration
    end

    function s:fraction()
		return math.min((love.timer.getTime() - s.time) / s.duration, 1.0)
    end

    function s:reset()
        s.time = love.timer.getTime()
    end
    return s
end
return Timer