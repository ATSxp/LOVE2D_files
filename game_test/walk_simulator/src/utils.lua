-- Utils --
require "src/sprite_sheet"
updateSpriteSheet()
drawSpriteSheet()

function spr(indx, id, x, y, r, sx, sy, ox, oy)
    love.graphics.draw(sheet[indx], sprites[id], x, y, r, sx, sy, ox, oy) 
end

function sprc(indx, id, x, y, r, sx, sy, ox, oy)
    love.graphics.draw(sheet[indx], sprites[id], x - mx, y - my, r, sx, sy, ox, oy) 
end