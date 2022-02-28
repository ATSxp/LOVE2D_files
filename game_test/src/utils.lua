-- Utils --
require "src/sprite_sheet"

function spr(id, x, y, r, sx, sy, ox, oy)
    love.graphics.draw(sprites[id][2], sprites[id][1], x, y, r, sx, sy, ox, oy) 
end