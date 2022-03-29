local Entity = {}
function Entity:new(x, y, sp)
    local s = {}
    s.type = ""
    s.name = ""
    s.x = x or 0
    s.y = y or 0
    s.w = 64
    s.h = 64
    s.dx = 0
    s.dy = 0
    s.speed = 100
    s.dir = 2
    s.sp = Sprite:new(sp)
    s.collider = {}

    function s:anim()
        if self.dy < 0 then -- up
            self.dir = 1
        elseif self.dy > 0 then -- up
            self.dir = 2
        elseif self.dx < 0 then -- up
            self.dir = 3
        elseif self.dx > 0 then -- up
            self.dir = 4
        end
    
        local idle = {"idle_up", "idle_down", "idle_left", "idle_right"}
        local walk = {"walk_up", "walk_down", "walk_left", "walk_right"}
    
        if self.dx ~= 0 or self.dy ~= 0 then
            self.sp:set(walk[self.dir])
        elseif self.dx == 0 or self.dy == 0 then
            self.sp:set(idle[self.dir])
        end
    end

    function s:fixAxis()
        self.x = self.x - self.w / 2
        self.y = self.y - self.h / 2
    end

    function s:setCollision()
        self.x = self.collider:getX()
        self.y = self.collider:getY()
        self.collider:setLinearVelocity(self.dx, self.dy)
    end

    function s:load()
        self.collider = World:newBSGRectangleCollider(
            self.x, self.y, 
            self.w, self.h, 
            10)
    end
    
    function s:update(dt)
        if self.sp ~= nil then
            self.sp:update(dt)
        end
        self:fixAxis()

        self:setCollision()
    end

    function s:draw()
        if self.sp ~= nil then
            self.sp:draw(self)
        else
            love.graphics.rectangle("fill", self.x - self.w / 2, self.y - self.h / 2, self.w, self.h)
        end
        self:UI()
    end

    function s:UI()end
    table.insert(entities, s)
    return s
end
return Entity