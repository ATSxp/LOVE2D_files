mapdata = {}
mapdata.walls = {}

function loadMap()
    maps = {
        ["room1"] = sti("maps/room1.lua"),
        ["room2"] = sti("maps/room2.lua"),
    }
end

function changeMap(new_map)
    mapdata.map = maps[new_map]

    destroyAll()

    if mapdata.map.layers.solids then
        mapdata.map.layers.solids.visible = false
        for i,v in pairs(mapdata.map.layers.solids.objects)do
            local solid = World:newRectangleCollider(v.x, v.y, v.width, v.height)
            solid.x = v.x
            solid.y = v.y
            solid.w = v.w
            solid.h = v.h
            solid:setType("static")
            table.insert(mapdata.walls, solid)
        end
    end

    spawnEntities()
end