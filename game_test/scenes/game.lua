-- Scene 2: Game --
Game = {}
require "src/utils"
function Game:on_active()
    print("STATE = GAME")
end

function Game:load()
    player:load()

    self.show_sprite_sheet = false
end

function Game:update(dt)
    player:update(dt)

end

function Game:draw()
    player:draw()
    if not self.show_sprite_sheet then return end
    getSpriteSheet()
end

function Game:keypressed( key, scancode, isrepeat )
    if key == "f1" then
       self.show_sprite_sheet = not self.show_sprite_sheet 
    end
end
return Game