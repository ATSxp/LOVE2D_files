Debug = require "debugger"
mgr = require "managers/state"
player = require "src/player"
Menu = require "scenes/menu"
Game = require "scenes/game"
STI = require "libs/sti"

function love.load()
    global_pause = false
    love.window.setMode(800, 600, {fullscreen = false})
    screenw, screenh = love.graphics.getDimensions()
    mgr:add(Menu,"menu")
    mgr:add(Game,"game")

    mgr:set("menu")
    mgr:load()
    tick = 0
end

function love.update(dt)
    Debug:update(dt)
    if global_pause then
        
    else

    mgr:update(dt)
    
    tick = tick + 1
    end

    spriteSheetUpdate()

    if love.keyboard.isDown("escape")then
        love.event.quit()
    end
end

function love.draw()
    mgr:draw()
    Debug:draw()
end

function love.keypressed( key, scancode, isrepeat )
    Game:keypressed(key, scancode, isrepeat)
    spriteKeypressed(key, scancode, isrepeat)
    Debug:keypressed(key, scancode, isrepeat)
    Menu:keypressed(key, scancode, isrepeat)
end