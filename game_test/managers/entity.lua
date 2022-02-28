-- Entity Manager --
Entity = {}

function Entity:new(x, y, sp)
    local s = {}
    s.type = ""
    s.name = ""
    s.sp = sp
    s.pos = require "managers/vector":new(x, y)
    s.size = require "managers/vector":new(16, 16)
    s.vel = require "managers/vector":new(0, 0)

    function s:update(dt)
        s.sp:update(dt)
    end

    function s:draw()
        s.sp:draw(s)
    end
    return s
end

return Entity