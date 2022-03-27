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
        self.anims[self.cur_anim]:update(dt)
    end

    function s:draw(e)
        local cur = self.cur_anim
        local anims = self.anims[cur]
        love.graphics.draw(gImages[cur], gFrames[cur][anims.cur_frame], 
        e.x, e.y, 0,
        e.w / gImages[cur]:getWidth(), e.h / gImages[cur]:getHeight())
    end
    return s
end
return Sprite