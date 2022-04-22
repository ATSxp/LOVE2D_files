function love.load()
    debugIsOn = false -- Debug mode ON/OFF
    isPause = false -- Pause mode ON/OFF

    love.graphics.setDefaultFilter("nearest") -- does not make the pixels blurry
    Font = love.graphics.newFont("assets/Early GameBoy.ttf", 8)
    love.graphics.setFont(Font)
    
    SCREEN_W, SCREEN_H = love.graphics.getDimensions() -- screen width and height

    require("src/requires") -- all requires

    mode = "menu" -- mode = menu/game/options...
    difficulty = "easy"
    maxScore = 0 -- score record

    -- variables for background and background floor
    bkgX1, bkgX2 = 0, 500
    floorX1, floorX2 = 0, 500

    debug = Debug() -- here is returning drawing and updating variables and functions to debug mode
end

function love.update(dt)
    -- shortcut to enable debug mode
    if love.keyboard.isDown("left") and love.keyboard.isDown("up") then
        debugIsOn = true
    end

    debug:update(dt)

    if mode == "menu" then
        menu:update(dt)
    elseif mode == "game" then
        if not isPause then
            walls:new()
            walls:update(dt)
            player:update(dt)
            moveBkg(dt)
            
            -- instruction for when player breaks a record
            if player.points > maxScore then
                maxScore = player.points
            end
        end
    elseif mode == "options" then
        options:update(dt)
    elseif mode == "skins" then
        skins:update(dt)
    end

    if player.die and mode ~= "menu" then
        game_over:update(dt)
    end
end

function love.draw()
    if mode == "menu" then
        menu:draw()
    elseif mode == "game" then

        -- background
        love.graphics.draw(gImages["bkg"], bkgX1, 0, nil, 4, 4)
        love.graphics.draw(gImages["bkg"], bkgX2, 0, nil, 4, 4)

        -- floor
        love.graphics.draw(gImages["floor"], floorX1, 400 - 32, nil, 4, 4)
        love.graphics.draw(gImages["floor"], floorX2, 400 - 32, nil, 4, 4)
        
        walls:draw()
        player:draw()
        
        if not player.die then
        
            local font = love.graphics.getFont()
            local w = font:getWidth(player.points)
        
            -- draw current points
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
    elseif mode == "skins" then
        skins:draw()
    end

    if player.die and mode ~= "menu" then
        game_over:draw()
    end

    debug:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if mode == "menu" then
        menu:keypressed(key, scancode, isrepeat)
    elseif mode == "game" then
        player:keypressed(key, scancode, isrepeat)
        if player.die then
            game_over:keypressed(key, scancode, isrepeat)
        end

        if key == "p" and not player.die then
            isPause = not isPause
        end
    elseif mode == "options" then
        options:keypressed(key, scancode, isrepeat)
    elseif mode == "skins" then
        skins:keypressed(key, scancode, isrepeat)
    end

    -- exit
    if key == "escape" then
        love.event.quit()
    end
end

function love.keyreleased(key, scancode)
end

-- check collision
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

-- move background
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

-- print letters with borders
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

-- the debug
function Debug()
    local s = {}
    s.items = {}

    function s:update(dt)
        self.items = {
            {"Player Y", math.floor(player.y)},
            {"Points", player.points},
            {"Die", tostring(player.die)},
            {"Img", tostring(player.img)},
            {"Max Score", maxScore},
        }
    end

    function s:draw()
        if not debugIsOn then return end

        local x = 0
        local y = 0

        for i,v in ipairs(self.items)do
            local scale = 2
            local str = v[1]..": "..v[2]
            
            local w = Font:getWidth(str) * scale
            local h = Font:getHeight(str) * scale

            if w > 216 then
                str = "Muito longo"
                w = Font:getWidth(str) * scale
            end
            
            love.graphics.setColor(0, 0, 0, 0.7)
            love.graphics.rectangle("fill", x, y, w, h)
            
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(str, x, y, nil, scale, scale)

            y = y + h

            if y + h > SCREEN_H then
                y = 0
                x = 232
            end

        end
    end
    return s
end