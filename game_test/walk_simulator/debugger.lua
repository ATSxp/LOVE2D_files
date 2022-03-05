-- Debugger --
Debug = {}
local Game = require "scenes/game"
Debug.items = {}
Debug.on = true

local floor = math.floor
function Debug:update(dt)
    if not self.on or mgr.current == "choose" or mgr.current == "sheet" then return end
    self.items = {
        {n = "Scene", val = string.upper(mgr.current)},
        {n = "Screen Width", val = screenw},
        {n = "Screen Height", val = screenh},
        {n = "Player X", val = floor(player.pos.x)},
        {n = "Player Y", val = floor(player.pos.y)},
        {n = "Player Vel X", val = floor(player.vel.x)},
        {n = "Player Vel Y", val = floor(player.vel.y)},
        {n = "Current Animation", val = "\" "..player.sp.name.." \""},
        {n = "Sprite Sheet View Mode", val = tostring(Game.show_sprite_sheet)},
    }
end

function Debug:draw()
    if not self.on or mgr.current == "choose" or mgr.current == "sheet" then return end
    local x, y = 0, 0
    for i,v in ipairs(self.items)do
        love.graphics.setColor(1, 0, 0.1)
        love.graphics.print(v.n..": "..v.val, x, y)
        love.graphics.setColor(1, 1, 1)
        y = y + 10
        if y > screenh - 10 then
            y = 0
            x = x + 200
        end
    end
end

function Debug:keypressed(key, scancode, isrepeat)
    if key == "f2" then
        self.on = not self.on
    end
end
return Debug