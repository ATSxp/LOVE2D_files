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
            x1 = 500, y1 = math.random(- 400 + 64, 0), w1 = 32, h1 = 400 - 64,
        })
    end
end

function walls:destroy()
    for i,v in ipairs(self.blocks)do
        table.remove(self.blocks, i)
    end
end

function walls:update(dt)
    self.spawn_timer = self.spawn_timer - 1
    for i,v in ipairs(self.blocks)do
        v.x2 = v.x1
        v.y2 = v. y1 + (v.h1 + self.distance)
        v.w2 = v.w1
        v.h2 = 640

        if AABB(player.x, player.y, player.w, player.h, 
        v.x1 + (64 - 32) / 2, v.y1, v.w1, v.h1) or 
        AABB(player.x, player.y, player.w, player.h, 
        v.x2 + (64 - 32) / 2, v.y2, v.w2, v.h2)then
            player.die = true
            print("you dead")
        end

        if (v.x1 + v.w1 + (64 - 32) * 2 < 0 or 
        v.x2 + v.w2 + (64 - 32) * 2 < 0) and 
        not player.die then
            self:destroy()
            player.points = player.points + 1
            print("points + 1: "..player.points)
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
        end
    end
end
return walls