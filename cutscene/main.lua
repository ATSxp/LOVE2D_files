-- references: Everdawn, game made on the TIC-80
--  link: https://tic80.com/play?cart=615
require("state")
require("timer")
Textbox = require("textbox")
require("cutscener")
mgr = stateManager()

function love.load()
    love.graphics.setDefaultFilter("nearest")
    mgr.add(Game(), "game")
    mgr.active("game")
    
    t = 0
end

function love.update(dt)
	mgr.update(dt)

    t = t + 1
end

function love.draw()
	mgr.draw()
end

function love.keypressed(key, scancode, isrepeat)
    Textbox:keypressed(key)
end

function Game()
    local s = {}
    function s.on_active()
        Sq(require("scene1"))
    end

    function s:update(dt)
        Textbox:update(dt)
    end
    
    function s:draw()
        Textbox:draw()
    end
    return s
end