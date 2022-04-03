local Npc = {}
function Npc:new(data, dialogue, sp, other_anims)
    local fn = {}
    function fn:new(x, y)
        local s = Entity:new(x, y, sp)
        s.over = false
        s.dir = 2
        s.other_anims = other_anims or function()end

        function s:checkDir()
            if Player.y < self.y and Player.dir == 2 then
                self.dir = 1
                self.sp:set("up")
            elseif Player.y > self.y and Player.dir == 1 then
                self.dir = 2
                self.sp:set("down")
            elseif Player.x < self.x and Player.dir == 4 then
                self.dir = 3
                self.sp:set("left")
            elseif Player.x > self.x and Player.dir == 3 then
                self.dir = 4
                self.sp:set("right")
            end
        end
        
        function s:load()
            self:other_anims()
            self.extraX = - 4.5
            self.extraY = 4
            self.w = 8
            if self.collider ~= nil then
                self.collider = World:newRectangleCollider(self.x + 4, self.y, self.w, self.h / 3)
                self.collider:setFixedRotation(true)
                self.collider:setType("static")
            end
        end

        function s:onInteract()
            self:checkDir()
            Textbox:addDialogue(dialogue, data)
        end

        local supUpdate = s.update
        function s:update(dt)
            if self.sp ~= nil then
                self.sp:update(dt)
            end
            self:fixAxis()
    
            self:setCollision()
        end

        function s:draw()
            self.sp:draw(self)
        end
        return s
    end
    return fn
end
return Npc