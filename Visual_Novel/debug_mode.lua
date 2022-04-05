local Debug = {}

function Debug:load()
    self.on = false
    self.text = false
end

function Debug:update(dt)
    if not self.on then return end
    self.items = {
        {n = "Room: ", v = mapdata.room},
        {n = "PlayerX", v = math.floor(Player.x)},
        {n = "PlayerY", v = math.floor(Player.y)},
        {n = "Player Dir", v = Player.dir},
        {n = "Player Speed", v = Player.speed},
        {n = "Current Animation", v = Player.sp.cur_anim},
    }
end

function Debug:draw()
    if not self.on then return end
    cam:attach()
    if World then
        love.graphics.scale(scale_game, scale_game)
        World:draw()
    end
    cam:detach()

    if not self.text then return end
    local x, y = 0, 0
    for i,v in ipairs(self.items)do
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", x, y, Font:getWidth(v.n..": "..v.v), Font:getHeight(v.n..": "..v.v))
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(v.n..": "..v.v, x, y)
        y = y + Font:getHeight(v.n..": "..v.v)
        if  y + Font:getHeight(v.n..": "..v.v) > 500 then
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