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
        love.graphics.draw(gImages[cur], gFrames[cur][1][anims.cur_frame], 
        e.x - e.w / 2, e.y - e.h / 2, 0,
        e.w / gFrames[cur][2].w, e.h / gFrames[cur][2].h)
    end
    return s
end
return Sprite