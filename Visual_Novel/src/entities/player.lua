local player = Entity:new(32, 128, Anim:new("idle_down", "joao_spritesheet", {1}))
function player:load()
    self.type = "hero"
    self.name = "player"
    self.w = 11
    self.extraX = - 3

    self.sp:add(Anim:new("idle_up", "joao_spritesheet", {10}))
    self.sp:add(Anim:new("idle_left", "joao_spritesheet", {4}))
    self.sp:add(Anim:new("idle_right", "joao_spritesheet", {7}))

    self.sp:add(Anim:new("walk_down", "joao_spritesheet", {0, 2}))
    self.sp:add(Anim:new("walk_left", "joao_spritesheet", {3, 5}))
    self.sp:add(Anim:new("walk_up", "joao_spritesheet", {9, 11}))
    self.sp:add(Anim:new("walk_right", "joao_spritesheet", {6, 8}))

    if self.collider ~= nil then
        self.collider = World:newBSGRectangleCollider(
            self.x, self.y,
            self.w, self.h,
            3)
        self.collider:setCollisionClass("player")
        self.collider:setFixedRotation(true)
    end
    self.speed = 16
end

function player:update(dt)
    self.sp:update(dt)
    self.dx, self.dy = 0, 0
    self:fixAxis()

    self:move(dt)

    self:anim()
    self:setCollision()
end

function player:move(dt)
    local key = love.keyboard.isDown
    
    if key("up") and self.dx == 0 then
        self.dy = - self.speed * 4
    elseif key("down") and self.dx == 0 then
        self.dy = self.speed * 4
    end

    if key("left") and self.dy == 0 then
        self.dx = - self.speed * 4
    elseif key("right") and self.dy == 0 then
        self.dx = self.speed * 4
    end
end

function player:keypressed(key, scancode, isrepeat)
    if key == "z" and global_pause <= 0 then        
        interactEntities(self)
    end
end
return player