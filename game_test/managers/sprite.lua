-- Sprite Manager --
Sprite = {}
require "src/utils"
function Sprite:new(anim)
    local s = {}
    s.anims = {}
    s.name = anim.name

    function s:set(name)
        --self.anims[self.name]:reset()
        self.name = name
    end

    function s:add(anim)
        self.anims[anim.name] = anim
    end
    s:add(anim)

    function s:update(dt)
        self.anims[self.name]:update(dt)
    end

    function s:draw(p)
        sprc(self.anims[self.name].sheet, self.anims[self.name].curFrame, p.x, p.y, 0, 4, 4)
    end
    return s
end

return Sprite