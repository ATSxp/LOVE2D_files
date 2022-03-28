local Player = Entity:new(100, 0, Anim:new("joao_sprite", {1}))
function Player:load()
    self.sp:set("joao_sprite")
    self.collider = World:newBSGRectangleCollider(self.x, self.y, self.w, self.h, 10)
    self.collider:setFixedRotation(true)
end

function Player:update(dt)
    self.sp:update(dt)
    local key = love.keyboard.isDown
    self.dx, self.dy = 0, 0
    self:fixAxis()

    if key("up")then
        self.dy = - self.speed
    elseif key("down")then
        self.dy = self.speed
    end

    if key("left")then
        self.dx = - self.speed
    elseif key("right")then
        self.dx = self.speed
    end

    self:setCollision()
end
return Player