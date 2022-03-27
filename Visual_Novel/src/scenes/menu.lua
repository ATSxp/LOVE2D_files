local Menu = {}
function Menu:load()
    self.title = "João Adventures"
        
    self.main_buttons_w = 128
    self.main_buttons_h = 32
    self.menu_item = {
        Button:newMouse("Start", nil, 
        20, 100, 
        self.main_buttons_w, self.main_buttons_h, 
        function() 
            Scene:set("game")
        end),
        
        Button:newMouse("Exit", nil, 
        20, 100 + self.main_buttons_h * 1.5, 
        self.main_buttons_w, self.main_buttons_h, 
        function() 
            love.event.quit()
        end),
    }
end

function Menu:update(dt)
    for i,v in ipairs(self.menu_item)do
        v:update(dt)
    end
end

function Menu:draw()
    love.graphics.print(self.title, 20, 20, 0, 4, 4)
    for i,v in ipairs(self.menu_item)do
        v:draw()
    end
end
return Menu