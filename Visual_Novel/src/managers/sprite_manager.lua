local Sprite = {}
function Sprite:new(anim)
    if anim == nil then return end
    local s = {}
    s.cur_anim = anim.name
    s.anims = {}

    function s:add(anim)
        self.anims[self.cur_anim] = anim
    end
    s:add(anim)

    function s:set(name)
        self.cur_anim = name
    end

    function s:update(dt)
        self.anim[self.cur_anim]:update(dt)
    end

    function s:draw(e)
        local anim = self.anims[self.cur_anim]
        love.graphics.draw(anim.texture, anim.cur_frame, e.x, e.y)
    end
    return s
end
return Sprite