walls = {}
walls.blocks = {} -- here is the data of all the pipes
walls.speed = 100
walls.max_spawn_timer = 200
walls.spawn_timer = walls.max_spawn_timer -- time to spawn
walls.distance = math.random(90, 130) -- a small distance between the pipes

-- Make new pipes
function walls:new()
    -- if time runs out, create new pipe and reset time
    if self.spawn_timer <= 0 then
        self.spawn_timer = self.max_spawn_timer
        
        -- inserting a new table with data to create a new pipe
        table.insert(self.blocks, {
            x1 = 500, -- x axis for the top pipe
            y1 = math.random(- 400 + 64, - 64), -- y axis for the top pipe
            w1 = 32, -- width of the top pipe
            h1 = 400 - 64, -- height of the top pipe
            box = { -- hitbox which tells us that the player went through the pipes and scored 1 point
                x = 0, -- x axis
                y = 0, -- y axis
                w = 64, -- width
                h = 120, -- height
                delete = false, -- this was created for when the player goes through the hitbox and he doesn't keep gaining points infinitely
            }
        })
    end
end

-- Destroy all pipes
function walls:destroy()
    for i,v in ipairs(self.blocks)do
        table.remove(self.blocks, i)
    end
end

function walls:update(dt)
    -- depending on the difficulty, the time to spawn the pipes is shorter
    if difficulty == "easy" then
        self.max_spawn_timer = 250
    elseif difficulty == "normal" then
        self.max_spawn_timer = 200
    elseif difficulty == "hard" then
        self.max_spawn_timer = 150
    end

    self.spawn_timer = self.spawn_timer - 1

    for i,v in ipairs(self.blocks)do
        -- all data from the top pipe is being passed to the down pipe
        v.x2 = v.x1
        v.y2 = v.y1 + (v.h1 + self.distance) -- so they don't get stuck
        v.w2 = v.w1
        v.h2 = v.h1

        -- calculate so that the hitbox is between the two pipes
        v.box.x = v.x1
        v.box.y = v.y2 - ((v.h2 / 2) - 50)

        -- if the player touches one of the pipes...
        if AABB(player.x, player.y, player.w, player.h, 
        v.x1 + (64 - 32) / 2, v.y1, v.w1, v.h1) or 
        AABB(player.x, player.y, player.w, player.h, 
        v.x2 + (64 - 32) / 2, v.y2, v.w2, v.h2)then

            -- ...it starts to spin...
            player.rotation = player.rotation + 10 * dt
            
            -- ...and die =)
            if not player.die then
                player.die = true
                print("==============================\nPLAYER DEAD")
            end

        end

        -- if the player passes between the pipes he gets a point
        if player.x > v.box.x + v.box.w then
            
            if not v.box.delete and not player.die then
                v.box.delete = true
                player.points = player.points + 1
                print("==============================\nPOINTS <-- 1 | CURRENT VALUE: "..player.points)
            end
        
        end

        -- if the pipes go too far off the screen they are deleted
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
        -- pipe up
        love.graphics.draw(
            gImages["cano_up"], 
            v.x1, v.y1 - 64, nil, 
            4, 4
        )
        
        -- pipe down
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