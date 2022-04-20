player = {}
player.x = 40
player.y = 0
player.w = 40
player.h = 40
player.dy = 0
player.img = gImages["josue"]
player.gravity = 400
player.points = 0
player.die = false

function player:update(dt)
    self.dy = self.dy + self.gravity * dt
    if self.y > SCREEN_H or self.y + self.h < 0 then
        self.die = true
        print("you dead")
    end
    self.y = self.y + self.dy * dt
end

function player:draw()
    love.graphics.draw(
        self.img, 
        self.x, self.y, nil, 
        self.w / self.img:getWidth(), self.h / self.img:getHeight())
end

function player:keypressed(key, scancode, isrepeat)
    if self.die then return end
    if key == "space" then
        self.dy = - 200
    end
end
return player