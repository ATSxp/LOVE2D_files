local Game = {}
function Game:load()
    -- local scenes = Events:load()
    -- Sq:new(scenes.intro)
    Debug:load()
    
    cam = Camera()
    World = wf.newWorld(0, 0)
    changeMap("room1")

    loadEntities()

    table.sort(entities, layerEntities)

end

function Game:update(dt)
    Debug:update(dt)
    if global_pause > 0 then
        global_pause = global_pause - 1
    else
        World:update(dt)
        mapdata.map:update(dt)
        updateEntities(dt)
    end

    cam:lookAt(Player.x * 4, Player.y * 4)
    cameraHideOffSet()
    
    if love.keyboard.isDown("g")then
        changeMap("room2")
    end
end

function Game:draw()
    cam:attach()
        love.graphics.scale(64 / 16, 64 / 16)
        mapdata.map:drawLayer(mapdata.map.layers.floor)
        mapdata.map:drawLayer(mapdata.map.layers.walls)
        drawEntities()
    cam:detach()
    Debug:draw()
end
return Game