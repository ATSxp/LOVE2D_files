mgr = require "managers/state"
player = require "src/player"
Menu = require "scenes/menu"
Game = require "scenes/game"

function love.load()
    mgr:add(Menu,"menu")
    mgr:add(Game,"game")
    
    mgr:set("game")
    mgr:load()
    tick = 0
end

function love.update(dt)
    mgr:update(dt)
    
    tick = tick + 1

    if love.keyboard.isDown("escape")then
        love.event.quit()
    end
end

function love.draw()
    mgr:draw()
end

function love.keypressed( key, scancode, isrepeat )
    Game:keypressed(key, scancode, isrepeat)
end