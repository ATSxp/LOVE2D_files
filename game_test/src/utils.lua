-- Utils --
require "src/sprite_sheet"

function spr(indx, id, x, y, r, sx, sy, ox, oy)
    love.graphics.draw(sheet[indx], sprites[id][1], x, y, r, sx, sy, ox, oy) 
end

function sprc(indx, id, x, y, r, sx, sy, ox, oy)
    love.graphics.draw(sheet[indx], sprites[id][1], x - mx, y - my, r, sx, sy, ox, oy) 
end