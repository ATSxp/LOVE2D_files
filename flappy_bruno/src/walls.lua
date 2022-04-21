walls = {}
walls.blocks = {}
walls.speed = 100
walls.max_spawn_timer = 200
walls.spawn_timer = walls.max_spawn_timer
walls.distance = math.random(64, 130)

function walls:new()
    if self.spawn_timer <= 0 then
        self.spawn_timer = self.max_spawn_timer
        
        table.insert(self.blocks, {
            x1 = 500, 
            y1 = math.random(- 400 + 64, 0), 
            w1 = 32, 
            h1 = 400 - 64,
            box = {
                x = 0,
                y = 0,
                w = 64,
                h = 120,
                delete = false,
            }
        })
    end
end

function walls:destroy()
    for i,v in ipairs(self.blocks)do
        table.remove(self.blocks, i)
    end
end

function walls:update(dt)
    if difficulty == "easy" then
        self.max_spawn_timer = 250
    elseif difficulty == "normal" then
        self.max_spawn_timer = 200
    elseif difficulty == "hard" then
        self.max_spawn_timer = 150
    end

    self.spawn_timer = self.spawn_timer - 1
    for i,v in ipairs(self.blocks)do
        v.x2 = v.x1
        v.y2 = v.y1 + (v.h1 + self.distance)
        v.w2 = v.w1
        v.h2 = 400 - 64

        v.box.x = v.x1
        v.box.y = v.y2 - ((v.h2 / 2) - 50)

        if AABB(player.x, player.y, player.w, player.h, 
        v.x1 + (64 - 32) / 2, v.y1, v.w1, v.h1) or 
        AABB(player.x, player.y, player.w, player.h, 
        v.x2 + (64 - 32) / 2, v.y2, v.w2, v.h2)then
            player.rotation = player.rotation + 10 * dt
            if not player.die then
                player.die = true
                print("==============================\nPLAYER DEAD")
            end
        end

        if player.x > v.box.x + v.box.w then
            if not v.box.delete and not player.die then
                v.box.delete = true
                player.points = player.points + 1
                print("==============================\nPOINTS <-- 1 | CURRENT VALUE: "..player.points)
            end
        end

        if (v.x1 + v.w1 + (64 - 32) * 2 < 0 or 
        v.x2 + v.w2 + (64 - 32) * 2 < 0)then
            table.remove(self.blocks, i)
        end

        v.x1 = v.x1 - self.speed * dt
        v.x2 = v.x2 - self.speed * dt
    end
    
end

function walls:draw()
    for i,v in ipairs(self.blocks)do
        love.graphics.draw(
            gImages["cano_up"], 
            v.x1, v.y1 - 64, nil, 
            4, 4
        )
        
        love.graphics.draw(
            gImages["cano_down"], 
            v.x2, v.y2, nil, 
            4, 4
        )

        if debugIsOn then
            love.graphics.rectangle("line", v.x1 + (64 - 32) / 2, v.y1, v.w1, v.h1)
            love.graphics.rectangle("line", v.x2 + (64 - 32) / 2, v.y2, v.w2, v.h2)
            love.graphics.rectangle("line", v.box.x, v.box.y, v.box.w, v.box.h)
        end
    end
end
return walls