local Dummy = {}
function Dummy:new(x, y)
    local s = Entity:new(x, y, Anim:new("idle_down", "dummy", {2}))
    function s:load()
        self.collider = World:newBSGRectangleCollider(self.x, self.y, self.w, self.h, 10)
        self.collider:setFixedRotation(true)
        self.collider:setType("static")
    end
    return s
end
return Dummy