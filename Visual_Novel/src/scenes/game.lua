local Game = {}
function Game:load()
    -- local scenes = Events:load()
    -- Sq:new(scenes.intro)
    Debug:load()
    
    cam = Camera()
    
    Map = sti("maps/room1.lua")
    World = wf.newWorld(0, 0)
    
    spawnEntities()
    loadEntities()

    self:solid()

    table.sort(entities, layerEntities)

    load = Loading(5)
end

function Game:update(dt)
    if global_pause > 0 then
        global_pause = global_pause - 1
    else
        Debug:update(dt)
        cam:lookAt(Player.x * 4, Player.y * 4)
        World:update(dt)
        Map:update(dt)
        updateEntities(dt)
    end
    cameraHideOffSet()
end

function Game:draw()
    cam:attach()
        love.graphics.scale(64 / 16, 64 / 16)
        Map:drawLayer(Map.layers.floor)
        Map:drawLayer(Map.layers.walls)
        drawEntities()
    cam:detach()
    Debug:draw()
    load:draw()
end

function Game:solid()
    solids = {}
    if Map.layers.solids then
        Map.layers.solids.visible = false
        for i,v in pairs(Map.layers.solids.objects)do
            local solid = World:newRectangleCollider(v.x, v.y, v.width, v.height)
            solid:setType("static")
            table.insert(solids, solid)
        end
    end
end
return Game