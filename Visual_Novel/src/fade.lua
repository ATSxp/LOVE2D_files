fade = {}
fade.alpha = 0
fade.state = 0
fade.time = 0

function fade:update(dt)
    if self.state ~= 0 then
        self.alpha = self.alpha + (self.state / self.time * dt)
        global_pause = 1
    else
        global_pause = 0
    end

    -- in
    if self.alpha > 1 and self.state > 0 then
        self.alpha = 1
        self.state = 0
    end

    -- out
    if self.alpha < 0 and self.state < 0 then
        self.alpha = 0
        self.state = 0
    end
end

function fade:In(tick)
    self.alpha = 0
    self.time = tick or 1
    self.state = 1    
end

function fade:Out(tick)
    self.alpha = 1
    self.time = tick or 1
    self.state = - 1    
end

function fade:draw()
    love.graphics.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", 0, 0, SCREEN_W, SCREEN_H)
    love.graphics.setColor(1, 1, 1, 1)
end