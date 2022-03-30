local Game = {}
function Game:solid()
    solids = {}
    if Map.layers.solids then
        Map.layers.solids.visible = false
        for i,v in pairs(Map.layers.solids.objects)do
            local solid = World:newRectangleCollider(v.x * 4, v.y * 4, v.width * 4, v.height * 4)
            solid:setType("static")
            table.insert(solids, solid)
        end
    end
end

function Game:load()
    -- local scenes = Events:load()
    -- Sq:new(scenes.intro)
    Debug:load()
    Map = sti("maps/room1.lua")
    World = wf.newWorld(0, 0)
    spawnEntities()
    loadEntities()
    self:solid()
    table.sort(entities, layerEntities)
end

function Game:update(dt)
    if global_pause > 0 then
        global_pause = global_pause - 1
    else
        Debug:update(dt)
        World:update(dt)
        Map:update(dt)
        updateEntities(dt)
    end
end

function Game:draw()
    love.graphics.push()
        love.graphics.scale(64 / 16, 64 / 16)
        Map:drawLayer(Map.layers.floor)
        Map:drawLayer(Map.layers.walls)
    love.graphics.pop()
    drawEntities()
    Debug:draw()
end
return Game