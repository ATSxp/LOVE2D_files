local Npc = {}
function Npc:new(data, dialogue, sp, other_anims)
    local fn = {}
    function fn:new(x, y)
        local s = Entity:new(x, y, sp)
        s.dialogue_i = 2
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
        
        ballon_anim = Anim:new("ballon", "ballon_over_npc", {0, 1, 2, 3}, 16)

        function s:load()
            self:other_anims()
            self.extraX = - 4.5
            self.extraY = 4
            self.w = 8
            self.collider = World:newRectangleCollider(self.x + 4, self.y, self.w, self.h / 3)
            self.collider:setFixedRotation(true)
            self.collider:setType("static")
        end

        function s:onInteract()
            self:checkDir()
            self.dialogue_i = (self.dialogue_i % #dialogue) + 1
            if self.dialogue_i == #dialogue then
                self.over = true
            end
            Textbox:addDialogue(dialogue[self.dialogue_i], data)
        end

        local supUpdate = s.update
        function s:update(dt)
            supUpdate(self)
            ballon_anim:update(dt)
        end

        function s:draw()
            self.sp:draw(self)

            if not self.over then
                love.graphics.draw(
                    gImages[ballon_anim.texture], 
                    gFrames[ballon_anim.texture][1][ballon_anim.cur_frame], 
                    self.x + 4, self.y - self.h - 2)
            end
        end
        return s
    end
    return fn
end
return Npc