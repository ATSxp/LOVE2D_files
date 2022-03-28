local Game = {}
function Game:load()
    -- local scenes = Events:load()
    -- Sq:new(scenes.intro)
    World = wf.newWorld(0, 0)
    Player:load()
    -- wall = World:newRectangleCollider(0, 300, 64, 64)
    -- wall:setType("static")
end

function Game:update(dt)
    World:update(dt)
    Player:update(dt)
end

function Game:draw()
    Player:draw()
    World:draw()
end
return Game