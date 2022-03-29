local Game = {}
function Game:load()
    -- local scenes = Events:load()
    -- Sq:new(scenes.intro)
    World = wf.newWorld(0, 0)
    loadEntities()
    dummy = Dummy:new(0, 0)
    dummy:load()
end

function Game:update(dt)
    World:update(dt)
    updateEntities(dt)
    dummy:update(dt)
end

function Game:draw()
    drawEntities()
    World:draw()
    dummy:draw()
end
return Game