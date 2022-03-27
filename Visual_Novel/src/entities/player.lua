local Player = Entity:new(0, 0, Anim:new("joao_sprite", {1}))
function Player:load()
    self.w, self.h = 64, 64
    self.sp:set("joao_sprite")
end

function Player:update(dt)
    self.sp:update(dt)
    local key = love.keyboard.isDown
    self.vx, self.vy = 0, 0
    if key("up")then
        self.vy = - 100
    elseif key("down")then
        self.vy = 100
    end

    if key("left")then
        self.vx = - 100
    elseif key("right")then
        self.vx = 100
    end

    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

-- function Player:draw()
--     local img = gImages.joao_sprite
--     love.graphics.draw(img, self.x, self.y, 0, self.w / img:getWidth(), self.h / img:getHeight())
-- end
return Player