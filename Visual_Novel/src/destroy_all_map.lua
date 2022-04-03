function destroyAll()
    for i,v in ipairs(mapdata.walls)do
        v:destroy()
        mapdata.walls[i] = nil
    end

    for i,v in ipairs(entities)do
        v.collider:destroy()
        entities[i] = nil
    end

    for i,v in ipairs(mapdata.transitions)do
        v:destroy()
        mapdata.transitions[i] = nil
    end
end