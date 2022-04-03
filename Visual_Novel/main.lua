require("requires")

function love.load()
    tick = 0
    Scene:set("menu")
    Scene:load()
end

function love.update(dt)
    Scene:update(dt)
    Textbox:update(dt)
    tick = tick + 1
end

function love.draw()
    Scene:draw()
    Textbox:draw()
end

function love.keypressed(key, scancode, isrepeat)
    Textbox:keypressed(key, scancode,isrepeat)
    Debug:keypressed(key, scancode, isrepeat)
    Scene:keypressed(key, scancode, isrepeat)
    
    if key == "escape" then
        love.event.quit()
    end
end