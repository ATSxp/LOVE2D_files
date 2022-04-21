function love.load()
    debugIsOn = false
    isPause = false
    love.graphics.setDefaultFilter("nearest")
    Font = love.graphics.newFont("assets/Early GameBoy.ttf", 8)
    love.graphics.setFont(Font)
    
    SCREEN_W, SCREEN_H = love.graphics.getDimensions()

    require("src/requires")

    mode = "menu"
    difficulty = "easy"

    bkgX1, bkgX2 = 0, 500
    floorX1, floorX2 = 0, 500
end

function love.update(dt)
    if mode == "menu" then
        menu:update(dt)
    elseif mode == "game" then
        if not isPause then
            walls:new()
            walls:update(dt)
            player:update(dt)
            moveBkg(dt)
        end
    elseif mode == "options" then
        options:update(dt)
    end

    if player.die and mode ~= "menu" then
        game_over:update(dt)
    end
end

function love.draw()
    if mode == "menu" then
        menu:draw()
    elseif mode == "game" then

        love.graphics.draw(gImages["bkg"], bkgX1, 0, nil, 4, 4)
        love.graphics.draw(gImages["bkg"], bkgX2, 0, nil, 4, 4)

        love.graphics.draw(gImages["floor"], floorX1, 400 - 32, nil, 4, 4)
        love.graphics.draw(gImages["floor"], floorX2, 400 - 32, nil, 4, 4)
        
        walls:draw()
        player:draw()
        
        if not player.die then
        
            local font = love.graphics.getFont()
            local w = font:getWidth(player.points)
        
            printb(player.points, (SCREEN_W - w) / 2, 10, nil, 4, 4)
        
        end

        if isPause then
            local scale = 4
            local w = Font:getWidth("PAUSED") * scale
            local h = Font:getHeight("PAUSED") * scale

            printb(
                "PAUSED", 
                (SCREEN_W - w) / 2, (SCREEN_H - h) / 2, nil, 
                scale, scale, 4
            )
        end
    elseif mode == "options" then
        options:draw()
    end

    if player.die and mode ~= "menu" then
        game_over:draw()
    end
end

function love.keypressed(key, scancode, isrepeat)
    if mode == "menu" then
        menu:keypressed(key, scancode, isrepeat)
    elseif mode == "game" then
        player:keypressed(key, scancode, isrepeat)
        if player.die then
            game_over:keypressed(key, scancode, isrepeat)
        end

        if key == "p" then
            isPause = not isPause
        end
    elseif mode == "options" then
        options:keypressed(key, scancode, isrepeat)
    end

    if key == "f1" then
        debugIsOn = not debugIsOn
    end

    if key == "escape" then
        love.event.quit()
    end
end

function love.keyreleased(key, scancode)
end

function AABB(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 + w1 >= x2 and
    x2 + w2 >= x1 and
    y1 + h1 >= y2 and
    y2 + h2 >= y1
end

function reset()
    bkgX1 = 0
    bkgX2 = bkgX1 + 500
    floorX1 = 0
    floorX2 = floorX1 + 500
    walls.spawn_timer = walls.max_spawn_timer
    walls.blocks = {}
    player.die = false
    player.points = 0
    player.y = 0
    player.dy = 0
    player.rotation = 0
    game_over.x = - 300
    game_over.y = (SCREEN_H - game_over.h) / 2
end

function moveBkg(dt)
    local bkgSpeed = 100
    local floorSpeed = 100

    if bkgX1 + 500 < 0 then
        bkgX1 = bkgX2 + 500
    elseif bkgX2 + 500 < 0 then
        bkgX2 = bkgX1 + 500
    end

    if floorX1 + 500 < 0 then
        floorX1 = floorX2 + 500
    elseif floorX2 + 500 < 0 then
        floorX2 = floorX1 + 500
    end
    
    bkgX1 = bkgX1 - bkgSpeed * dt
    bkgX2 = bkgX2 - bkgSpeed * dt

    floorX1 = floorX1 - floorSpeed * dt
    floorX2 = floorX2 - floorSpeed * dt
end

function printb(text, x, y, r, sx, sy, number, ox, oy)
    local number = number or 4
    local dir = {
        {0, number}, {number, 0},
        {0, - number}, {- number, 0},
    }

    for i = 1, #dir do
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(text, x + dir[i][1], y + dir[i][2], r, sx, sy, ox, oy)
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.print(text, x, y, r, sx, sy, ox, oy)
end