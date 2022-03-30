local Debug = {}

function Debug:load()
    self.on = false
    self.text = false
end

function Debug:update(dt)
    if not self.on then return end
    self.items = {
        {name = "PlayerX", val = math.floor(Player.x)},
        {name = "PlayerY", val = math.floor(Player.y)},
        {name = "Player Dir", val = Player.dir},
        {name = "Player Speed", val = Player.speed},
        {name = "Current Animation", val = Player.sp.cur_anim},
    }
end

function Debug:draw()
    if not self.on then return end
    if World then
        World:draw()
    end

    if not self.text then return end
    local x, y = 0, 0
    local font = love.graphics.newFont()
    for i,v in ipairs(self.items)do
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", x, y, font:getWidth(v.name..": "..v.val), font:getHeight(v.name..": "..v.val))
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(v.name..": "..v.val, x, y)
        y = y + font:getHeight(v.name..": "..v.val)
        if  y + font:getHeight(v.name..": "..v.val) > 500 then
            x = x + 40
            y = 0
        end
    end
end

function Debug:keypressed(key, scancode, isrepeat)
    if key == "f1" then
        self.on = not self.on
    end
    if self.on and key == "f2" then
        self.text = not self.text
    elseif not self.on then
        self.text = false
    end
end
return Debug