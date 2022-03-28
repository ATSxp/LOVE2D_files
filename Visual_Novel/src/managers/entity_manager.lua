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
    s.sp = Sprite:new(sp)
    s.collider = {}

    function s:fixAxis()
        self.x = self.x - self.w / 2
        self.y = self.y - self.h / 2
    end

    function s:setCollision()
        self.x = self.collider:getX()
        self.y = self.collider:getY()
        self.collider:setLinearVelocity(self.dx, self.dy)
    end

    function s:load()end
    
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
    return s
end
return Entity