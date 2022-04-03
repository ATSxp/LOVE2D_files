fade = {}
fade.alpha = 1
fade.t = 0

function fade:update(dt)
    self.t = self.t + 0.1
end

function fade:In()
    self.alpha = self.alpha + self.t
    if self.alpha > 1 then
        self.alpha = 1
    end
end

function fade:Out()
    self.alpha = self.alpha - self.t
    if self.alpha < 0  then
        self.alpha = 0
    end
end

function fade:draw()
    love.graphics.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", 0, 0, SCREEN_W, SCREEN_H)
    love.graphics.setColor(1, 1, 1, 1)
end