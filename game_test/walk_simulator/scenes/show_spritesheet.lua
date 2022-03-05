local Sprite = {}
require "src/sprite_sheet"
function Sprite:on_active()

end

function Sprite:load()
    
end

function Sprite:update(dt)
    updateSpriteSheet()
end

function Sprite:draw()
    drawSpriteSheet()    
end

function Sprite:keypressed(key, scancode, isrepeat)
    if key == "left" and sprite_item > 1 then
        sprite_item = sprite_item - 1
    elseif key == "right" and sprite_item < #sheet then
        sprite_item = sprite_item + 1
    end
end
return Sprite