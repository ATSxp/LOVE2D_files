local Choose = {}
local screenw = love.graphics.getWidth()
function Choose:on_active()
end

function Choose:load()
    self.items = {
        {name = "menu"},
        {name = "game"},
        {name = "sheet"},
    }
    self.item_i = 1
end

function Choose:update(dt)
end

function Choose:draw()
    local y = 20
    local font = love.graphics.newFont(30)
    for i,v in ipairs(self.items)do
        local w = font:getWidth(v.name) - 10
        love.graphics.print(v.name, 0, y, 0, 2, 2)
        if self.item_i == i then
            love.graphics.print("<", w, y, 0, 2, 2)
        end
        y = y + 30 
    end
    local w = font:getWidth("============= State Mode =============")
    love.graphics.print("============= State Mode =============", screenw - w / 1.3, 0, 0, 2, 2)
end

function Choose:keypressed(key, scancode, isrepeat)
    if key == "up" and self.item_i > 1 then
        print("[ UP ] Pressed")
        self.item_i = self.item_i - 1
    elseif key == "down" and self.item_i < #self.items then
        print("[ DOWN ] Pressed")
        self.item_i = self.item_i + 1
    end
    
    for i,v in ipairs(self.items)do
        if self.item_i == i  and key == "z" then
        print("[ Z ] Pressed")
        mgr:set(v.name)
        end
    end
end
return Choose