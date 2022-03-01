-- Scene 2: Game --
Game = {}
require "src/utils"

function Game:on_active()
    print("STATE = GAME")
end

function Game:load()
    player:load()

    mx, my = 0, 0
    Map = STI("maps/map1.lua")
    
    self.show_sprite_sheet = false
end

function Game:update(dt)
    player:update(dt)
end

function Game:draw()
    Map:draw(-mx, -my, 4, 4)
    player:draw()
    if not self.show_sprite_sheet then return end
    getSpriteSheet()
end

function Game:keypressed( key, scancode, isrepeat )
    if key == "f1" then
       self.show_sprite_sheet = not self.show_sprite_sheet
       global_pause = not global_pause 
    end
end
return Game