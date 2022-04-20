menu = {}
menu.title = love.window.getTitle()
menu.cursor_i = 1
menu.items = {
    {"Play", function()mode = "game" end},
    {"Exit", function()love.event.quit()end},
}

function menu:update(dt)
end

function menu:draw()
    love.graphics.setBackgroundColor(0, 0.1, 1)
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
    if key == "down" and self.cursor_i < # self.items then
        self.cursor_i = self.cursor_i + 1
    elseif key == "up" and self.cursor_i > 1 then
        self.cursor_i = self.cursor_i - 1
    end
    for i,v in ipairs(self.items)do
        if key == "z" and self.cursor_i == i then
            v[2]()
        end
    end
end
return menu