
-- This function has the objective of taking an image and dividing 
-- it into several numbered quads in a table, making life MUCH easier 
-- for the developer who doesn't want to do it one by one
function createQuads(img, sprite_w, sprite_h)
    local W, H = img:getWidth() / sprite_w, img:getHeight() / sprite_h
    local spritesheet = {}
    local sprite_counter = 0

    for y = 0, H - 1 do
        for x = 0 , W - 1 do
            spritesheet[sprite_counter] = love.graphics.newQuad(
                x * sprite_w, y * sprite_h,
                sprite_w, sprite_h,
                img:getDimensions()
            )
            sprite_counter = sprite_counter + 1
        end
    end
    return {spritesheet,{w = sprite_w, h = sprite_h}}
end

-- check collision for entities
function AABB(v, e)
    if v ~= e and 
    v.x + v.w >= e.x and 
    e.x + e.w >= v.x and
    v.y + v.h >= e.y and
    e.y + e.h >= v.y then
        return true
    end
end

-- check collision for NOT entities
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 + w1 >= x2 and
    x2 + w2 >= x1 and
    y1 + h1 >= y2 and
    y2 + h2 >= y1
end

-- check collision for NOT entities, but without "="  \_('_')_/
function checkCollision2(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 + w1 > x2 and
    x2 + w2 > x1 and
    y1 + h1 > y2 and
    y2 + h2 > y1
end

function Evt()
    local s = {}
    function s:load()end
    function s:launch()Scene:push(self)end
    function s:done()Scene:pop()end
    function s:preUpdate(dt)end
    function s:posUpdate(dt)end
    function s:update(dt)self:preUpdate(dt) self:posUpdate(dt)end
    function s:draw()end
    return s
end

function loadEntities()
    if entities then
        for i,v in pairs(entities)do
            v:load()
        end
    end
end

function updateEntities(dt)
    if entities then
        for i,v in pairs(entities)do
            v:update(dt)
        end
    end
end

function drawEntities()
    if entities then
        for i,v in pairs(entities)do
            v:draw()
        end
    end
end

function spawnEntities()
    if mapdata.map.layers.entities and entities then
        spawnents = require("src/entities/entities_data")
        local ent
        for i,v in ipairs(mapdata.map.layers.entities.objects)do
            local spawn = spawnents[v.name]
            if spawn ~= nil then
                ent = spawn:new(v.x, v.y)
                ent.name = v.name
                ent.type = v.type
                table.insert(entities, ent)
            else
                return false
            end
        end
    end
end

function layerEntities(a, b)
    if a.y == b.y then
        return a.x > b.x
    end
    return a.y > b.y
end

function interactEntities(e)
    for i,v in ipairs(entities)do
        local hit = checkCollision(e.x, e.y, e.w, e.h, v.x, v.y, v.w + 4, v.h)
        if hit and v.onInteract ~= nil then
            v:onInteract()
        end
    end
end

function cameraHideOffSet()
    local mapW = mapdata.map.width * mapdata.map.tilewidth
    local mapH = mapdata.map.height * mapdata.map.tileheight

    if cam.y < SCREEN_H / 2 then
        cam.y = SCREEN_H / 2
    end
    if cam.x < SCREEN_W / 2 then
        cam.x = SCREEN_W / 2
    end

    if cam.y > ((mapH * 4) - SCREEN_H / 2) then
        cam.y = ((mapH * 4) - SCREEN_H / 2)
    end
    if cam.x > ((mapW * 4) - SCREEN_W / 2) then
        cam.x = ((mapW * 4) - SCREEN_W / 2)
    end
end

function Loading(duration)
    local s = {}
    local timer = Timer:new(duration)
    
    function s:draw()
        if not timer:complete()then
            global_pause = 1
            love.graphics.clear()
            love.graphics.print("Loading...", 0, 500 - Font:getHeight("Loading..."))
        end
    end
    return s
end