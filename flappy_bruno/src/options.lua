options = {}
options.items = {}
options.cursor_i = 1 -- index cursor

local indx = 1 -- local index for a function
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
end

function options:draw()
    love.graphics.setBackgroundColor(0, 0.4, 1)

    local bw, bh = 450, 350
    local bx, by = (SCREEN_W - bw) / 2, (SCREEN_H - bh) / 2

    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", bx, by, bw, bh)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", bx, by, bw, bh)

    for i,v in ipairs(self.items)do
        local w = Font:getWidth(v[1]) * 2
        local h = Font:getHeight(v[1]) * 2
        local x = bx + 8
        local y = h * i + (by - 16)

        printb(v[1]..(v[2] ~= nil and ": "..v[2] or ""), x, y, nil, 2, 2, 2)

        if self.cursor_i == i then
            printb("~", x - 16, y, nil, 2, 2, 2)
        end
    end
    
end

function options:keypressed(key, scancode, isrepeat)
    -- move cursor
    if key == "down" and self.cursor_i < #self.items then
        self.cursor_i = self.cursor_i + 1
    elseif key == "up" and self.cursor_i > 1 then
        self.cursor_i = self.cursor_i - 1
    end

    -- active the button
    for i,v in ipairs(self.items)do

        if self.cursor_i == i and key == "z" then
            -- check if the function exists
            if v[3] then
                v[3]()
            end

        end

    end
end
return options