options = {}
options.items = {}
options.cursor_i = 1 -- index cursor

local indx = 1 -- local index for a function
local scale = 3
function options:update(dt)
    self.items = {
        {-- change the game difficulty
            "Difficulty", 
            difficulty, 
            function()
                indx = indx + 1

                local difs = {"easy", "normal", "hard"}
                
                if indx > 3 then
                    indx = 1
                end
                
                difficulty = difs[indx]
                print("==============================\nDIFFICULTY: "..string.upper(difficulty))
            end
        },
        {-- the high score
            "Score Record",
            maxScore,
        },
        {-- change player skins
            "Skins",
            nil,
            function()
               mode = "skins" 
            end
        },
        {-- back to menu
            "Back", 
            nil, 
            function()
                self.cursor_i = 1
                mode = "menu"
                print("==============================\nMENU")
            end
        },
    }

    local bw, bh = 450, 350
    local bx, by = (SCREEN_W - bw) / 2, (SCREEN_H - bh) / 2
    
    for i,v in ipairs(self.items)do
        local w = Font:getWidth(v[1]) * scale
        local h = Font:getHeight(v[1]) * scale + 5
        local x = bx + 8
        local y = h * i + (by - 16)

        v[4] = {
            x = x,
            y = y,
            w = w,
            h = h
        }

    end
end

function options:draw()
    love.graphics.setColor(0, 0.4, 1)
    love.graphics.rectangle("fill", 0, 0, SCREEN_W, SCREEN_H)
    love.graphics.setColor(1, 1, 1)

    local bw, bh = 450, 350
    local bx, by = (SCREEN_W - bw) / 2, (SCREEN_H - bh) / 2

    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", bx, by, bw, bh)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", bx, by, bw, bh)

    for i,v in ipairs(self.items)do
        local w = Font:getWidth(v[1]) * scale
        local h = Font:getHeight(v[1]) * scale + 5
        local x = bx + 8
        local y = h * i + (by - 16)

        printb(v[1]..(v[2] ~= nil and ": "..v[2] or ""), x, y, nil, scale, scale, scale)

        if debugIsOn then
            love.graphics.rectangle(
                "line", 
                x, y, 
                w, h
            )
        end

    end
    
end

function options:mousepressed( x, y, button, istouch, presses )
    for i,v in ipairs(self.items)do

        local mx, my = rs.toGame(love.mouse.getPosition())

        if AABB(mx, my, 8, 8, v[4].x, v[4].y, v[4].w, v[4].h) then
            -- check if the function exists
            if v[3] and button == 1 then
                v[3]()
            end
        end

    end
end
return options