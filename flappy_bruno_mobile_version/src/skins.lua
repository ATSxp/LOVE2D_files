skins = {}
skins.cursor_i = 1 -- index of cursor
skins.isDown = false
skins.items = {}

local color = {1, 1, 1}
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

local buttonBox = {
    {x = 0, y = SCREEN_H - 57, w = 8 * 6, h = 8 * 6},
    {x = SCREEN_W - (8 * 6), y = SCREEN_H - 57, w = 8 * 6, h = 8 * 6},
}

skins.items = require("assets/all_skins")

function skins:update(dt)
    for i = 1, #self.items do
        
        self.items[i][3] = function()
            if self.items[i][1] == "Back" then
                self.cursor_i = 1
                mode = "options"
                print("==============================\nOPTIONS")
            else
                player.img = self.items[i][2]
                print("==============================\nSKIN CHANGED TO: "..string.upper(self.items[i][1]))
            end
            
        end

    end

    if self.cursor_i > #self.items then
        self.cursor_i = 1
    elseif self.cursor_i < 1 then
        self.cursor_i = #self.items
    end

end

function skins:draw()
    love.graphics.setColor(0, 0.4, 1)
    love.graphics.rectangle("fill", 0, 0, SCREEN_W, SCREEN_H)
    love.graphics.setColor(1, 1, 1)
    
    for i = 1, #self.items do
        local v = self.items -- shorcut

        -- if cursor is over item
        if self.cursor_i == i then
            
            -- if image exists
            if v[i][2] then
                
                -- calculation to scale the image to the proposed widths and heights
                scaleCenterX = centerW / v[i][2]:getWidth()
                scaleCenterY = centerH / v[i][2]:getHeight()

                if v[i + 1] and v[i + 1][2] then
                    scaleOtherX1 = otherW / v[i + 1][2]:getWidth()
                    scaleOtherY1 = otherH / v[i + 1][2]:getHeight()
                end
            
                if v[i - 1] and v[i - 1][2] and v[i - 1][2] then
                    scaleOtherX2 = otherW / v[i - 1][2]:getWidth()
                    scaleOtherY2 = otherH / v[i - 1][2]:getHeight()
                end
                
                -- calculation to scale the image to the proposed widths and heights
                printScaleCenterX = printCenterW / Font:getWidth(v[i][1])
                printScaleCenterY = printCenterH / Font:getHeight(v[i][1])

                if v[i + 1] and v[i + 1][1] then
                    printScaleOtherX1 = printOtherW / Font:getWidth(v[i + 1][1])
                    printScaleOtherY1 = printOtherH / Font:getHeight(v[i + 1][1])
                end

                if v[i - 1] and v[i - 1][1] then
                    printScaleOtherX2 = printOtherW / Font:getWidth(v[i - 1][1])
                    printScaleOtherY2 = printOtherH / Font:getHeight(v[i - 1][1])
                end
                
                local w = Font:getWidth(v[i][1]) * 4
                -- print the center letters
                printb(
                    v[i][1],
                    (SCREEN_W - w) / 2, 300, nil,
                    4, 4, 4, color
                )

                -- analyzes whether images or letters will appear in the corner of the screen
                if self.cursor_i >= 2 and v[i - 1][2]then
                    if v[i - 1][2] == nil then
                        printb(
                            v[i - 1][1], 
                            8, 30, nil, 
                            printScaleOtherX2 - 1, printScaleOtherY2, 4
                        )
                    else
                        love.graphics.draw(
                            v[i - 1][2], 
                            0, 30, nil, 
                            scaleOtherX2, scaleOtherY2
                        )

                        love.graphics.rectangle(
                            "line",
                            0, 30, 
                            128, 128
                        )
                    end
                    
                end
                
                if v[i + 1] and v[i + 1][2]then
                    if v[i + 1][2] == nil then
                        printb(
                            v[i + 1][1], 
                            (SCREEN_W - printOtherW) + 16, 30, nil, 
                            printScaleOtherX1 - 1, printScaleOtherY1, 4
                        )
                    else
                        love.graphics.draw(
                            v[i + 1][2], 
                            SCREEN_W - otherW, 30, nil, 
                            scaleOtherX1, scaleOtherY1
                        )

                        love.graphics.rectangle(
                            "line",
                            SCREEN_W - otherW, 30, 
                            128, 128
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
                if v[i][2] then
                    love.graphics.draw(
                        v[i][2], 
                        (SCREEN_W - centerW) / 2, 30, nil, 
                        scaleCenterX, scaleCenterY
                    )
                end

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
                    color = {0.9, 0.9, 0}
                else
                    color = {1, 1, 1}
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
                
                if v[i + 1] and v[i + 1][2] then
                    scaleOtherX1 = otherW / v[i + 1][2]:getWidth()
                    scaleOtherY1 = otherH / v[i + 1][2]:getHeight()
                end
            
                if v[i - 1] and v[i - 1][2] then
                    scaleOtherX2 = otherW / v[i - 1][2]:getWidth()
                    scaleOtherY2 = otherH / v[i - 1][2]:getHeight()
                end
                
                -- analyzes whether images will appear in the corner of the screen
                if v[i - 1] and v[i - 1][2] then
                    love.graphics.draw(
                        v[i - 1][2], 
                        0, 30, nil, 
                        scaleOtherX2, scaleOtherY2
                    )
                    
                    love.graphics.rectangle(
                        "line",
                        0, 30, 
                        128, 128
                    )
                end

                if v[i + 1] and v[i + 1][2] then
                    love.graphics.draw(
                        v[i + 1][2], 
                        SCREEN_W - otherW, 30, nil, 
                        scaleOtherX1, scaleOtherY1
                    )

                    love.graphics.rectangle(
                        "line",
                        SCREEN_W - otherW, 30, 
                        128, 128
                    )
                end

            end

        end

    end

    printb("~", 32, SCREEN_H - 64, nil, - 6, 6)
    printb("~", SCREEN_W - 32, SCREEN_H - 64, nil, 6, 6)

    if debugIsOn then
        for i = 1, 2 do
            love.graphics.rectangle(
                "line",
                buttonBox[i].x, buttonBox[i].y, 
                buttonBox[i].w, buttonBox[i].h
            )
        end
    end

end

function skins:mousepressed( x, y, button, istouch, presses )
    local mx, my = rs.toGame(love.mouse.getPosition())
    local b = buttonBox

    if AABB(mx, my, 8, 8, b[1].x, b[1].y, b[1].w, b[1].h) and not self.isDown then
        self.isDown = true
        self.cursor_i = self.cursor_i - 1
    elseif AABB(mx, my, 8, 8, b[2].x, b[2].y, b[2].w, b[2].h) and not self.isDown then
        self.isDown = true
        self.cursor_i = self.cursor_i + 1
    end

    for i = 1, #self.items do
        local v = self.items

        if AABB(mx, my, 8, 8, (SCREEN_W - centerW) / 2, 30, centerW, centerH) 
        and self.cursor_i == i then
            self.isDown = true
            if v[i][3] then
                v[i][3]()
            end

        end

    end

end

function skins:mousereleased( x, y, button, istouch, presses )
    self.isDown = false
end
return skins