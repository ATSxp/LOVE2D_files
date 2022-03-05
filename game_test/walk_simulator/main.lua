Debug = require "debugger"
mgr = require "managers/state"
player = require "src/player"
STI = require "libs/sti"

function love.load()
    global_pause = false
    love.window.setMode(800, 600, {fullscreen = false})
    screenw, screenh = love.graphics.getDimensions()
    mgr:add("menu","menu")
    mgr:add("game","game")
    mgr:add("show_spritesheet","sheet")
    mgr:add("choose_scene","choose")

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

    buttonEvents()
end

function love.draw()
    mgr:draw()
    Debug:draw()
end

function love.keypressed( key, scancode, isrepeat ) 
    Debug:keypressed(key, scancode, isrepeat)
    mgr.states[mgr.current]:keypressed(key, scancode, isrepeat)
end

function buttonEvents()
    if love.keyboard.isDown("escape")then
        love.event.quit()
    end

    if love.keyboard.isDown("f3")then
        mgr:set("choose")
    end
end