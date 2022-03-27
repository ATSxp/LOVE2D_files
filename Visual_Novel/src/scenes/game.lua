local Game = {}
function Game:load()
    -- local scenes = Events:load()
    -- Sq:new(scenes.intro)
    
    Player:load()
end

function Game:update(dt)
    Player:update(dt)
end

function Game:draw()
    Player:draw()
end
return Game