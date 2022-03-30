local Npc = {}
function Npc:new(data, dialogue, type, sp)
    local fn = {}
    function fn:new(x, y)
        local s = Entity:new(x, y, sp)
        s.dialogue_i = 1
        s.over = false
        function s:load()
            self.collider = World:newBSGRectangleCollider(self.x, self.y, self.w, 32, 10)
            self.collider:setFixedRotation(true)
            self.collider:setType("static")
        end

        function s:onInteract()
            self.dialogue_i = (self.dialogue_i % #dialogue) + 1
            if self.dialogue_i == #dialogue then
                self.over = true
            end
            Textbox:addDialogue(dialogue[self.dialogue_i], data)
        end

        local supUpdate = s.update
        function s:update(dt)
            supUpdate(self)
        end

        function s:draw()
            self.sp:draw(self)

            if not self.over then
                love.graphics.rectangle("fill", self.x, self.y - self.h, 8, 8)
            end
        end
        return s
    end
    return fn
end
return Npc