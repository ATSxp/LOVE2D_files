skins = {}
skins.cursor_i = 1 -- index of cursor
skins.items = {}

function skins:update(dt)
    self.items = {
        {-- back to options
            "Back",
            nil,
            function()
                self.cursor_i = 1
                mode = "options"
                print("==============================\nOPTIONS")
            end,
        },
        {-- skin beta
            "Beta",
            "josue",
            function()
                player.img = "josue"
                print("==============================\nSKIN CHANGED TO: "..string.upper(player.img))
            end,
        },
        {-- skin default
            "Default",
            "due",
            function()
                player.img = "due"
                print("==============================\nSKIN CHANGED TO: "..string.upper(player.img))
            end,
        },
        {-- back to options
            "Back",
            nil,
            function()
                self.cursor_i = 1
                mode = "options"
                print("==============================\nOPTIONS")
            end,
        },
    }
end

function skins:draw()
    for i = 1, #self.items do
        local v = self.items -- shorcut
        local img = gImages -- shorcut

        -- width and height of the images that will be in the center of the screen
        local centerW = 256
        local centerH = 256

        -- width and height of the images that will be in the corner of the screen
        local otherW = 128
        local otherH = 128

        local scaleCenterX, scaleCenterY
        local scaleOtherX, scaleOtherY

        -- width and height of the letters that will be in the center of the screen
        local printCenterW = 256 / 3
        local printCenterH = 256 / 3
        
        -- width and height of the letters that will be in the corner of the screen
        local printOtherW = 128
        local printOtherH = 128

        local printScaleCenterX, printScaleCenterY
        local printScaleOtherX, printScaleOtherY

        -- if cursor is over item
        if self.cursor_i == i then
            
            -- if image exists
            if v[i][2] then
                
                -- calculation to scale the image to the proposed widths and heights
                scaleCenterX = centerW / img[v[i][2]]:getWidth()
                scaleCenterY = centerH / img[v[i][2]]:getHeight()

                scaleOtherX = otherW / img[v[i][2]]:getWidth()
                scaleOtherY = otherH / img[v[i][2]]:getHeight()
            
                
                -- calculation to scale the image to the proposed widths and heights
                printScaleCenterX = printCenterW / Font:getWidth(v[i][1])
                printScaleCenterY = printCenterH / Font:getHeight(v[i][1])

                printScaleOtherX = printOtherW / Font:getWidth(v[i][1])
                printScaleOtherY = printOtherH / Font:getHeight(v[i][1])
                
                local w = Font:getWidth(v[i][1]) * 4
                -- print the center letters
                printb(
                    v[i][1],
                    (SCREEN_W - w) / 2, 300, nil,
                    4, 4, 4
                )

                -- analyzes whether images or letters will appear in the corner of the screen
                if self.cursor_i >= 2 then
                    if v[i - 1][2] == nil then
                        printb(
                            v[i - 1][1], 
                            8, 30, nil, 
                            printScaleOtherX - 0.5, printScaleOtherY, 4
                        )
                    else
                        love.graphics.draw(
                            img[v[i - 1][2]], 
                            0, 30, nil, 
                            scaleOtherX, scaleOtherY
                        )
                    end
                    
                end
                
                if v[i + 1] then
                    if v[i + 1][2] == nil then
                        printb(
                            v[i + 1][1], 
                            (SCREEN_W - printOtherW) + 16, 30, nil, 
                            printScaleOtherX + 1, printScaleOtherY, 4
                        )
                    else
                        love.graphics.draw(
                            img[v[i + 1][2]], 
                            SCREEN_W - otherW, 30, nil, 
                            scaleOtherX, scaleOtherY
                        )
                    end
                end

                love.graphics.setColor(0, 0, 0, 0.7)
                love.graphics.rectangle(
                    "fill", 
                    (SCREEN_W - centerW) / 2, 30, 
                    256, 256
                )
                
                love.graphics.setColor(1, 1, 1)
                -- draw the center image
                love.graphics.draw(
                    img[v[i][2]], 
                    (SCREEN_W - centerW) / 2, 30, nil, 
                    scaleCenterX, scaleCenterY
                )

                love.graphics.rectangle(
                    "line",
                    (SCREEN_W - centerW) / 2, 30, 
                    256, 256
                )

                if player.img == v[i][2] then
                    love.graphics.setColor(0, 0, 0, 0.7)
                    love.graphics.rectangle(
                        "fill", 
                        (SCREEN_W - centerW) / 2, 30, 
                        256, 256
                    )
                    love.graphics.setColor(1, 1, 1)
                end


                -- if letters exist
            elseif v[i][2] == nil then
                local w = Font:getWidth(v[i][1]) * 4
                -- print the center letters
                printb(
                    v[i][1], 
                    (SCREEN_W - printCenterW) / 2, 300, nil, 
                    4, 4, 4
                )
                
                -- analyzes whether images will appear in the corner of the screen
                if self.cursor_i >= 2 then
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.draw(
                        img[v[i - 1][2]], 
                        0, 30, nil, 
                        scaleOtherX, scaleOtherY
                    )
                end

                if v[i + 1] and v[i + 1][2] then
                    love.graphics.draw(
                        img[v[i + 1][2]], 
                        SCREEN_W - otherW, 30, nil, 
                        scaleOtherX, scaleOtherY
                    )
                end

            end

        end

    end

end

function skins:keypressed(key, scancode, isrepeat)
    -- move the cursor
    if key == "right" and self.cursor_i < #self.items then
        self.cursor_i = self.cursor_i + 1
    elseif key == "left" and self.cursor_i > 1 then
        self.cursor_i = self.cursor_i - 1
    end
    
    -- activate the button
    for i,v in ipairs(self.items)do
        if key == "z" and self.cursor_i == i then
            v[3]()
        end
    end
end
return skins