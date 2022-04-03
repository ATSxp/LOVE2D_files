function getCollisionClass()
    World:addCollisionClass("ignore", {ignore = "ignore"})
    World:addCollisionClass("player")
    World:addCollisionClass("walls")
    World:addCollisionClass("transition", {ignore = "ignore"})
end