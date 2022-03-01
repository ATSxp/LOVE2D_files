-- Assets --
local q = love.graphics.newQuad
love.graphics.setDefaultFilter("nearest","nearest")
local font = love.graphics.newFont("Perfect DOS VGA 437 Win.ttf")
love.graphics.setFont(font)

sheet = {
    love.graphics.newImage("assets/03-soldier.png"), -- 1
    love.graphics.newImage("assets/04-scout.png"), -- 2
    love.graphics.newImage("assets/01-generic.png"), -- 3
    love.graphics.newImage("assets/02-bard.png"), -- 4
    love.graphics.newImage("assets/05-devout.png"), -- 5
    love.graphics.newImage("assets/06-conjurer.png"), -- 6

}

sprites = {}

item = 1

function spriteSheetUpdate()
    local x, y,id = 0, 0, 0
    for i = 0, 95, 1 do
        sprites[i+1] = {q(id,y,16,16,sheet[item]:getWidth(),sheet[item]:getHeight()), sheet[item]}
        id = id + 16
        x = x + 64
        if x > 16 * 48 - 64 then
            x = 0
            id = 0
            y = y + 16
        end
    end
end

function getSpriteSheet()
    local x, y = 0, 0
    for i = 1, #sprites do
        local v = sprites
        love.graphics.draw(v[i][2], v[i][1], x, y, 0, 4, 4)
        --love.graphics.setColor(1, 0,8, 0.5)
        love.graphics.print(i, x, y + 32, 0, 2, 2)
        --love.graphics.setColor(1, 1, 1)
        x = x + 64
        if x > 16 * 48 - 64 then
            x = 0
            y = y + 64
        end
    end

    local screenh = love.graphics.getHeight()
    love.graphics.print(item.."  de  "..#sheet, 0, screenh-30, 0, 2, 2)
end

function spriteKeypressed(key, scancode, isrepeat)
    if key == "a" and item > 1 then
        item = item - 1
    elseif key == "d" and item < #sheet then
        item = item + 1
    end
end