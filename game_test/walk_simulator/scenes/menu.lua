-- Scene 1: Menu --
local Menu = {}

function Menu:on_active()
end

function Menu:load()
    self.items = {
        {n = "Play", action = function(s)
            mgr:set("game")
        end},
        {n = "Exit", action = function(s)
            love.event.quit()
        end},
    }

    self.indx = 1
end

function Menu:update(dt)
    for i, v in ipairs(self.items)do
        if self.indx == i then
            if love.keyboard.isScancodeDown("z")then
                print("[ Z ] Pressed")
                v:action()
            end
        end
    end
end

function Menu:draw()
    local font = love.graphics.newFont(29)

    local tw = font:getWidth("THE GAME!")
    love.graphics.print("THE GAME!", (screenw - (tw*1.5)) / 2, 100, 0, 4, 4)
    local w, h = 100, 50
    local x, y = (screenw - w) / 2, 200
    for i, v in ipairs(self.items)do
        local tw = font:getWidth(v.n)
        love.graphics.rectangle("fill", x, y, w, h)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(v.n, (screenw - tw) / 2, y + 10, 0, 2, 2)
        love.graphics.setColor(1, 1, 1)
        y = y + 80

        if self.indx == i then
            love.graphics.print("<<<", x + 120, y - 65, 0, 2, 2)
        end
    end

    local th = font:getHeight("Z: Interact")
    love.graphics.print("Z: Interact", 0, screenh - th, 0, 2, 2)
end

function Menu:keypressed(key, scancode, isrepeat)
    if mgr.current ~= "menu" then return end
    if key == "up" and self.indx > 1 then
        print("[ UP ] Pressed")
        self.indx = self.indx - 1
    elseif key == "down" and self.indx < #self.items then
        print("[ DOWN ] Pressed")
        self.indx = self.indx + 1
    end
end
return Menu