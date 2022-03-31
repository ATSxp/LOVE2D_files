local Npc = {}
function Npc:new(data, dialogue, type, sp, other_anims)
    local fn = {}
    function fn:new(x, y)
        local s = Entity:new(x, y, sp)
        s.dialogue_i = 2
        s.over = false
        s.dir = 2
        s.other_anims = other_anims or {}
        s.sp:add(Anim:new("up", s.other_anims["up"].texture, s.other_anims["up"].frames, s.other_anims["up"].speed, s.other_anims["up"].loop))
        s.sp:add(Anim:new("left", s.other_anims["left"].texture, s.other_anims["left"].frames, s.other_anims["left"].speed, s.other_anims["left"].loop))
        s.sp:add(Anim:new("right", s.other_anims["right"].texture, s.other_anims["right"].frames, s.other_anims["right"].speed, s.other_anims["right"].loop))

        function s:checkDir()
            if Player.y < self.y and Player.dir == 2 then
                self.dir = 1
            elseif Player.y > self.y and Player.dir == 1 then
                self.dir = 2
            elseif Player.x < self.x and Player.dir == 4 then
                self.dir = 3
            elseif Player.x > self.x and Player.dir == 3 then
                self.dir = 4
            end
        end

        function s:load()
            ballon_anim = Anim:new("ballon", "ballon_over_npc", {0, 1, 2, 3}, 16)
            self.extraX = - 4.5
            self.extraY = 4
            self.w = 8
            self.collider = World:newRectangleCollider(self.x, self.y, self.w, self.h / 3)
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
            
            local dirs = {"up", "down", "left", "right"}
            self.sp:set(dirs[self.dir])
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