-----------------------------------------------
------ FLAPPY BRUNO 1.0 - Mobile Version ------
-----------------------------------------------

function love.load()
    math.randomseed(os.time())
    
    debugIsOn = false -- Debug mode ON/OFF
    isPause = false -- Pause mode ON/OFF

    love.graphics.setDefaultFilter("nearest", "nearest", 1) -- does not make the pixels blurry
    Font = love.graphics.newFont("assets/Early GameBoy.ttf", 8)
    love.graphics.setFont(Font)

    SCREEN_W, SCREEN_H = 500, 400 -- screen width and height

    require("src/requires") -- all requires

    rs.setGame(SCREEN_W, SCREEN_H)

    mode = "menu" -- mode = menu/game/options...
    difficulty = "easy"
    maxScore = 0 -- score record
    currentPoints = 0

    -- variables for background and background floor
    bkgX1, bkgX2 = 0, 500
    floorX1, floorX2 = 0, 500

    isBreaked = false

    debug = Debug() -- here is returning drawing and updating variables and functions to debug mode

    data = {}
    data.countSaves = 0

    loadGame()

    gSounds["bkg_music"]:setVolume(0.3)
end

function love.update(dt)
    rs.update(dt)
    
    -- shortcut to enable debug mode
    if love.keyboard.isDown("left") and love.keyboard.isDown("up") then
        debugIsOn = true
    end

    debug:update(dt)
    
    if mode == "menu" then
        menu:update(dt)
    elseif mode == "game" then
        if not isPause then
            gSounds["bkg_music"]:play()
            walls:new()
            walls:update(dt)
            player:update(dt)
            moveBkg(dt)
        else
            gSounds["bkg_music"]:pause()
        end
        
        -- instruction for when player breaks a record
        if player.points > currentPoints then
            currentPoints = player.points
            isBreaked = true
            print("==============================\nBREAK RECORD!!")
        end

        if currentPoints > maxScore then
            maxScore = currentPoints
            print("==============================\nCURRENT HIGH RECORD: "..maxScore)
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
    rs.start()
    
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
        
        local centralPointsColor = {1, 1, 1}
        
        if isBreaked then
            centralPointsColor = {1, 0, 0}
        else
            centralPointsColor = {1, 1, 1}
        end
        
        if not player.die then
            
            local w = Font:getWidth(player.points) * 4
            
            -- draw current points
            printb(player.points, (SCREEN_W - w) / 2, 10, nil, 4, 4, 4, centralPointsColor)
            
            local w1 = Font:getWidth("new record!") * 2

            if isBreaked then
                printb("new record!", (SCREEN_W - w1) / 2, 60, nil, 2, 2, 2, centralPointsColor)
            end
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

    rs.stop()
end

function love.mousepressed( x, y, button, istouch, presses )
    if mode == "menu" then
        menu:mousepressed( x, y, button, istouch, presses )
    elseif mode == "game" then
        player:mousepressed( x, y, button, istouch, presses )
        if player.die then
            game_over:mousepressed( x, y, button, istouch, presses )
        end
    elseif mode == "options" then
        options:mousepressed( x, y, button, istouch, presses )
    elseif mode == "skins" then
        skins:mousepressed( x, y, button, istouch, presses )
    end
end

function love.mousereleased( x, y, button, istouch, presses )
    if mode == "menu" then
        -- menu:mousepressed( x, y, button, istouch, presses )
    elseif mode == "game" then
        player:mousereleased( x, y, button, istouch, presses )
    elseif mode == "options" then
        -- options:mousepressed( x, y, button, istouch, presses )
    elseif mode == "skins" then
        skins:mousereleased( x, y, button, istouch, presses )
    end
end

function love.touchpressed( id, x, y, dx, dy, pressure )
    if mode == "menu" then
        -- menu:mousepressed( x, y, button, istouch, presses )
    elseif mode == "options" then
        -- options:mousepressed( x, y, button, istouch, presses )
    elseif mode == "skins" then
        skins:touchpressed( id, x, y, dx, dy, pressure )
    end
end

function love.keypressed(key, scancode, isrepeat)
    -- exit
    if key == "escape" then
        love.event.quit()
    end
end

-- check collision
function AABB(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 + w1 >= x2 and
    x2 + w2 >= x1 and
    y1 + h1 >= y2 and
    y2 + h2 >= y1
end

function reset()
    gSounds["bkg_music"]:stop()
    isBreaked = false
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
function printb(text, x, y, r, sx, sy, number, color)
    local color = color or {1, 1, 1}
    local number = number or 4
    local dir = {
        {0, number}, {number, 0},
        {0, - number}, {- number, 0},
    }

    for i = 1, #dir do
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(text, x + dir[i][1], y + dir[i][2], r, sx, sy, ox, oy)
        love.graphics.setColor(color)
    end
    love.graphics.print(text, x, y, r, sx, sy, ox, oy)
    love.graphics.setColor(1, 1, 1)
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

function saveGame()
    data.countSaves = data.countSaves + 1
    data.maxScore = maxScore
    data.currentPoints = currentPoints
    data.currentSkin = player.img

    love.filesystem.write("save.lua", table.show(data, "data"))
    print("==============================\nSAVED GAME\nSAVED TIMES: "..data.countSaves)
end

function loadGame()
    if love.filesystem.getInfo("save.lua") ~= nil then
        print("==============================\nEXISTING SAVE, LOADING...")
        local load = love.filesystem.load("save.lua")
        load()
        maxScore = data.maxScore
        currentPoints = data.currentPoints
        -- player.img = data.currentSkin
    else
        print("==============================\nSAVE DOESN'T EXIST, LOADING GAME FROM ZERO...")
    end
end

function loadImageFromPath( filePath )
    local f = io.open( filePath, "rb" )
    if f then
        local data = f:read( "*all" )
        f:close()
        if data then
            data = love.filesystem.newFileData( data, "tempname" )
            data = love.image.newImageData( data )
            local image = love.graphics.newImage( data )
            return image
        end
    end
end