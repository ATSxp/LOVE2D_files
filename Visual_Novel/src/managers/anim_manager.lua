local Anim = {}
function Anim:new(name, texture, frames, speed, loop)
    local s = {}
    s.name = name
    s.frames = frames or {}
    s.texture = texture
    s.speed = speed or 8
    s.loop = loop or true
    s.cur_frame = frames[1]
    s.indx = 0
    s.tick = 0

    function s:update(dt)
        if tick >= self.tick and #self.frames > 0 then
            if self.loop then
                self.indx = (self.indx + 1) % #self.frames
                self.cur_frame = self.frames[self.indx]
            else
                self.indx = self.indx < #self.frames and self.indx + 1 or #self.frames
                self.cur_frame = self.frames[self.indx]
            end
            self.tick = tick + self.speed
        end
    end

    function s:reset()
        self.indx = 0
    end
    return s
end
return Anim