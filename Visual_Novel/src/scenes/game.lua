local Game = {}
function Game:load()
    -- loadEvents()
    -- Sq:new(scenes.intro)
    Debug:load()
    
    World = wf.newWorld(0, 0)
    getCollisionClass()
    
    changeMap("room1")
    
    Player:load()
    loadEntities()
end

function Game:update(dt)
    Debug:update(dt)
    if global_pause > 0 then
        global_pause = global_pause - 1
    else
        World:update(dt)
        mapdata.map:update(dt)
        updateEntities(dt)
        Player:update(dt)
    end

    cam:update(dt)
    cameraHideOffSet()
    toMap()
end

function Game:draw()
    cam:attach()
        love.graphics.scale(64 / 16, 64 / 16)
        mapdata.map:drawLayer(mapdata.map.layers.floor)
        mapdata.map:drawLayer(mapdata.map.layers.walls)
        drawEntities()
        Player:draw()
    cam:detach()
    Debug:draw()
end

function Game:keypressed(key, scancode, isrepeat)
    Player:keypressed(key, scancode, isrepeat)
end
return Game