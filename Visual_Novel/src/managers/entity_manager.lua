local Entity = {}
function Entity:new(x, y, sp)
    local s = {}
    s.type = ""
    s.name = ""
    s.x = x or 0
    s.y = y or 0
    s.w = 32
    s.h = 32
    s.dx = 0
    s.dy = 0
    s.sp = Sprite:new(sp)
    
    function s:load()end
    
    function s:update(dt)
        if self.sp ~= nil then
            self.sp:update(dt)
        end
    end

    function s:draw()
        if self.sp ~= nil then
            self.sp:draw(self)
        else
            love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        end
    end
    return s
end
return Entity