-- Animation Manager --
Anim = {}

function Anim:new(name, frames, speed, loop)
    local s = {}
    s.name = name
    s.frames = frames or {}
    s.curFrame = frames[1]
    s.speed  = speed or 8
    s.loop = loop
    s.indx = 0
    s.tick = 0

    function s:update(dt)
        if tick >= self.tick and #self.frames > 0 then
            if self.loop then
                self.indx = (self.indx + 1)%#self.frames
                self.curFrame = self.frames[self.indx + 1]
            else
                self.indx = self.indx < #self.frames and self.indx + 1 or #self.frames
                self.curFrame = self.frames[self.indx]
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