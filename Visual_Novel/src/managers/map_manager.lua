mapdata = {}
mapdata.transitions = {}
mapdata.walls = {}

function loadMap()
    maps = {
        ["room1"] = sti("maps/room1.lua"),
        ["room2"] = sti("maps/room2.lua"),
    }

end

function changeMap(new_map, transition)
    mapdata.map = maps[new_map]

    if transition then

        if transition.spawn_x ~= 0 then
            if transition.spawn_x > 0 then
                Player.collider:setX(transition.spawn_x)
            end
        end

        if transition.spawn_y ~= 0 then
            if transition.spawn_y > 0 then
                Player.collider:setY(transition.spawn_y)
            end
        end

        local curx, cury = Player.collider:getPosition()
        local newx, newy = curx + transition.relative_x, cury + transition.relative_y
        Player.collider:setPosition(newx, newy)
    end

    destroyAll()

    if mapdata.map.layers.solids then
        mapdata.map.layers.solids.visible = false
        for i,v in pairs(mapdata.map.layers.solids.objects)do
            local solid = World:newRectangleCollider(v.x, v.y, v.width, v.height)
            solid:setCollisionClass("walls")
            solid:setType("static")
            table.insert(mapdata.walls, solid)
        end
    end

    if mapdata.map.layers.transition then
        for i,v in ipairs(mapdata.map.layers.transition.objects)do
            local newTransition = World:newRectangleCollider(v.x, v.y, v.width, v.height)
            newTransition:setCollisionClass("transition")
            newTransition:setType("static")

            newTransition.to_map = v.name
            newTransition.spawn_x = v.properties.spawn_x
            newTransition.spawn_y = v.properties.spawn_y
            newTransition.relative_x = v.properties.relative_x
            newTransition.relative_y = v.properties.relative_y

            table.insert(mapdata.transitions, newTransition)
        end
    end

    spawnEntities()

    cam:update(0)
end

function toMap()
    for i,v in ipairs(mapdata.transitions)do
        if Player.collider:enter("transition")then
            changeMap(v.to_map, {spawn_x = v.spawn_x, spawn_y = v.spawn_y, relative_x = v.relative_x, relative_y = v.relative_y})
            loadEntities()
        end
    end
end