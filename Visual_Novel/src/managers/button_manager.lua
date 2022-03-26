local Button = {}
function Button:newMouse(name, img, x, y, w, h, press)
    local s = {}
    s.name = name or nil
    s.x, s.y = x or 0, y or 0
    s.w, s.h = w or 32, h or 32
    s.img = img or nil
    s.alpha = 0.5
    function s:update(dt)
        local mx, my = love.mouse.getPosition()
        if checkCollision(mx, my, 8, 8, s.x, s.y, s.w, s.h) and mx >= 0 and mx <= SCREEN_W and my >= 0 and my <= SCREEN_H then
            s.alpha = 1
            if love.mouse.isDown(1)then
                press()
            end
        else
            s.alpha = 0.5
        end
    end
    
    function s:draw()
        if s.img ~= nil then
            love.graphics.setColor(1, 1, 1, s.alpha)
            love.graphics.draw(s.img, s.x, s.y)
            love.graphics.setColor(1, 1, 1, 1)
        else
            love.graphics.setColor(1, 1, 1, s.alpha)
            love.graphics.rectangle("fill", s.x, s.y, s.w, s.h)
            love.graphics.setColor(1, 1, 1, 1)
        end
        if s.name ~= nil then
            local font = love.graphics.newFont(10)
            local tw, th = font:getWidth(s.name), font:getHeight(s.name)
            love.graphics.print(s.name, ((s.w - tw) / 2) + s.x, (s.y + (th / 2)))
        end
    end
    return s
end
return Button