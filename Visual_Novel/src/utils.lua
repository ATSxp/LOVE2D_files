
function createQuadsd(img, sprite_w, sprite_h)
    local W, H = img:getWidth() / sprite_w, img:getHeight() / sprite_h
    local spritesheet = {}
    local sprite_counter = 0

    for y = 0, H - 1 do
        for x = 0 , W - 1 do
            spritesheet[sprite_counter] = love.graphics.newQuad(
                x * sprite_w, y * sprite_h,
                sprite_w, sprite_h,
                img:getDimensions()
            )
            sprite_counter = sprite_counter + 1
        end
    end
    
    return spritesheet
end

-- for entities
function AABB(v, e)
    if v ~= e and 
    v.x + v.w >= e.x and 
    e.x + e.w >= v.x and
    v.y + v.h >= e.y and
    e.y + e.h >= v.y then
        return true
    end
end

-- for NOT entities
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 + w1 >= x2 and
    x2 + w2 >= x1 and
    y1 + h1 >= y2 and
    y2 + h2 >= y1
end

-- for NOT entities
function checkCollision2(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 + w1 > x2 and
    x2 + w2 > x1 and
    y1 + h1 > y2 and
    y2 + h2 > y1
end

function Evt()
    local s = {}
    function s:load()end
    function s:launch()Scene:push(self)end
    function s:done()Scene:pop()end
    function s:preUpdate(dt)end
    function s:posUpdate(dt)end
    function s:update(dt)self:preUpdate(dt) self:posUpdate(dt)end
    function s:draw()end
    return s
end