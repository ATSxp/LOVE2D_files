local Dummy = {}
function Dummy:new(x, y)
    local s = Entity:new(x, y, Anim:new("idle_down", "dummy", {1}))
    function s:load()
        self.collider = {}
        self.collider = World:newBSGRectangleCollider(self.x, self.y, self.w, self.h, 10)
        if self.collider ~= nil then
            self.collider:setFixedRotation(true)
            self.collider:setType("static")
        end
    end
    return s
end
return Dummy