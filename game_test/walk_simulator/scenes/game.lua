-- Scene 2: Game --
local Game = {}
require "src/utils"

function Game:on_active()
end

function Game:load()
    player:load()
    mx, my = 0, 0
    Map = STI("maps/map1.lua")    
end

function Game:update(dt)
    player:update(dt)
end

function Game:draw()
    Map:draw(-mx, -my, 4, 4)
    player:draw()
end

function Game:keypressed(key, scancode, isrepeat)
end
return Game