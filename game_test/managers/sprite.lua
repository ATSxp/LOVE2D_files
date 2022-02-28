-- Sprite Manager --
Sprite = {}
require "src/utils"
function Sprite:new(anim)
    local s = {}
    s.anims = {}
    s.name = anim.name

    function s:set(name)
        self.name = name
        self.anims[self.name]:reset()
    end

    function s:add(anim)
        self.anims[self.name] = anim
    end
    s:add(anim)

    function s:update(dt)
        self.anims[self.name]:update(dt)
    end

    function s:draw(p)
        spr(self.anims[self.name].curFrame, p.x, p.y, 0, 2, 2)
    end
    return s
end

return Sprite