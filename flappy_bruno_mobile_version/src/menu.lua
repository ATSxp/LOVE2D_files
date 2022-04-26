menu = {}
menu.title = love.window.getTitle() -- title of the game
menu.cursor_i = 1 -- index cursor
menu.items = {}

local scale = 4
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

    for i,v in ipairs(self.items)do
        local w = Font:getWidth(v[1]) * scale
        local h = Font:getHeight(v[1]) * scale + 10
        local x = (SCREEN_W - w) / 2
        local y = h * i + 70

        v[3] = {
            x = x,
            y = y,
            w = w,
            h = h,
        }

    end

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
        local w = Font:getWidth(v[1]) * scale
        local h = Font:getHeight(v[1]) * scale + 10
        local x = (SCREEN_W - w) / 2
        local y = h * i + 70

        local tw = Font:getWidth(self.title) * scale
        local th =  Font:getHeight(self.title) * scale
        
        printb(self.title, (SCREEN_W - tw) / 2, th, nil, scale, scale)
        
        printb(v[1], x, y, nil, scale, scale)

        if debugIsOn then
            love.graphics.rectangle(
                "line",
                v[3].x, v[3].y, 
                v[3].w, v[3].h - 10
            )
        end
        
    end
end

function menu:mousepressed(x, y, button, istouch, presses)
    for i,v in ipairs(self.items)do
        local mx, my = rs.toGame(love.mouse.getPosition())

        if AABB(mx, my, 8, 8, v[3].x, v[3].y, v[3].w, v[3].h - 10)then
            if button == 1 then
                v[2]()
            end

        end
    end
end
return menu