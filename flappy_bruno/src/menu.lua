menu = {}
menu.title = love.window.getTitle() -- title of the game
menu.cursor_i = 1 -- index cursor
menu.items = {}

function menu:update(dt)
    self.items = {
        {
            "Play",
            function()
                mode = "game"
                print("==============================\nGAME")
            end
        },
        {
            "Options",
            function()
                mode = "options"
                print("==============================\nOPTIONS")
            end
        },
        {
            "Exit", 
            function()
                love.event.quit()
                print("==============================\nEXIT")
            end
        },
    }
end

function menu:draw()
    love.graphics.setColor(0, 0.1, 1)
    love.graphics.rectangle("fill", 0, 0, SCREEN_W, SCREEN_H)
    love.graphics.setColor(1, 1, 1)

    local bw, bh = 450, 350
    local bx, by = (SCREEN_W - bw) / 2, (SCREEN_H - bh) / 2

    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", bx, by, bw, bh)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", bx, by, bw, bh)

    
    for i,v in ipairs(self.items)do
        local w = Font:getWidth(v[1]) * 4
        local h = Font:getHeight(v[1]) * 4
        local x = (SCREEN_W - w) / 2
        local y = h * i + 100

        local tw = Font:getWidth(self.title) * 4
        local th =  Font:getHeight(self.title) * 4
        
        printb(self.title, (SCREEN_W - tw) / 2, th, nil, 4, 4)
        
        printb(v[1], x, y, nil, 4, 4)
        
        if self.cursor_i == i then
            printb("~", x - 40, y, nil, 4, 4)
        end

    end
end

function menu:keypressed(key, scancode, isrepeat)
    -- move cursor
    if key == "down" and self.cursor_i < #self.items then
        self.cursor_i = self.cursor_i + 1
    elseif key == "up" and self.cursor_i > 1 then
        self.cursor_i = self.cursor_i - 1
    end
    
    -- active the button
    for i,v in ipairs(self.items)do

        if key == "z" and self.cursor_i == i then
            v[2]()
        end
        
    end
end
return menu