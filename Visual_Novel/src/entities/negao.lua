local negao = {}
function negao:new(x, y)
    local s = Entity:new(x, y)

    function s:load()

        if self.collider ~= nil then
            self.collider = World:newBSGRectangleCollider(
                self.x, self.y,
                self.w, self.h,
                3)
            self.collider:setCollisionClass("negao")
            -- self.collider:setType("dynamic")
            self.collider:setFixedRotation(true)
        end
    end

    local supUpdate = s.update
    function s:update(dt)
        supUpdate(self)
        self.dx = 1
    end

    function s:draw()
        love.graphics.draw(
            gImages["negao_teste"], 
            self.x - self.w / 2, self.y - self.h / 2, nil, 
            16 / gImages["negao_teste"]:getWidth(), 16 / gImages["negao_teste"]:getHeight())
    end
    return s
end
return negao