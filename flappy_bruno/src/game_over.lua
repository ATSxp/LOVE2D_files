game_over = {}
game_over.w = 300 -- width of rectangle
game_over.h = 300 -- height of rectangle
game_over.x = - 300 -- x axis of rectangle
game_over.y = (SCREEN_H - game_over.h) / 2 -- y axis of rectangle
game_over.cursor_i = 1 -- index cursor
game_over.items = {
    {
        "Reset",
        function()
            -- saveGame()
            reset()
            print("==============================\nGAME RESETED")
        end
    },
    {-- back to menu
        "Main Menu",
        function()
            saveGame()
            mode = "menu"
            game_over.cursor_i = 1
            reset()
            print("==============================\nGAME RESETED")
            print("==============================\nMENU")
        end
    },
}

function game_over:update(dt)
    self.x = self.x + 400 * dt
    
    if self.x >= (SCREEN_W - game_over.w) / 2 then
        self.x = (SCREEN_W - game_over.w) / 2
    end

end

function game_over:draw()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    
    for i,v in ipairs(self.items)do
        
        local w, h  = Font:getWidth(v[1]) * 3, Font:getHeight(v[1]) * 3
        local x, y = (SCREEN_W - w) / 2, h * i + 160
        
        if self.x >= (SCREEN_W - game_over.w) / 2 then            
            local w2 = Font:getWidth(player.points)

            printb(player.points, (SCREEN_W - w2) / 2, 120, nil, 3, 3)
            
            printb(v[1], x, y, nil, 3, 3)

            if self.cursor_i == i then
                printb("~", x - 30, y, nil, 3, 3)
            end

        end
        
    end
end

function game_over:keypressed(key, scancode, isrepeat)
    if not (self.x >= (SCREEN_W - game_over.w) / 2) then return end

    -- move the cursor
    if key == "down" and self.cursor_i < #self.items then
        self.cursor_i = self.cursor_i + 1
    elseif key == "up" and self.cursor_i > 1 then
        self.cursor_i = self.cursor_i - 1
    end

    -- active the button
    for i,v in ipairs(self.items)do
        
        if self.cursor_i == i then

            if key == "z" then
                v[2]()
            end

        end

    end

end
return game_over