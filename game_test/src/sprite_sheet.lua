-- Assets --
local q = love.graphics.newQuad
local newImg = love.graphics.newImage
love.graphics.setDefaultFilter("nearest", "nearest")
local font = love.graphics.newFont("Perfect DOS VGA 437 Win.ttf")
love.graphics.setFont(font)

sheet = {
    newImg("assets/Chara1.png"),
    newImg("assets/chara2.png"),
    newImg("assets/chara3.png"),
    newImg("assets/chara4.png"),
    newImg("assets/chest.png"),
    newImg("assets/coin.png"),
    newImg("assets/crystal-sheet.png"),
    newImg("assets/spike.png"),
}

sprites = {}

item = 1
local w, h = 16, 16

function spriteSheetUpdate()
    local x, y,id = 0, 0, 0
    for i = 1, sheet[item]:getWidth() do
        sprites[i] = {q(id, y, w, h, sheet[item]:getWidth(), sheet[item]:getHeight()), sheet[item]}
        id = id + w
        x = x + (w * 4)
        if x > (w * 48) - (w * 4) then
            x = 0
            id = 0
            y = y + h
        end
    end
    print(sheet[item]:getWidth())
end

function getSpriteSheet()
    local x, y = 0, 0
    for k = 1, (sheet[item]:getWidth() / w)do
        for i = 1, #sprites[k] do
            local v = sprites
            love.graphics.draw(v[item][2], v[i][1], x, y, 0, 4, 4)
            love.graphics.print(i, x, y + 32, 0, 2, 2)
            x = x + (w * 4)
            if x > (w * 48) - (w * 4) then
                x = 0
                y = y + (h * 4)
            end
        end
    end

    local screenh = love.graphics.getHeight()
    love.graphics.print(item.."  de  "..#sheet, 0, screenh-30, 0, 2, 2)
    -- print(#sprites)
end

function spriteKeypressed(key, scancode, isrepeat)
    if key == "left" and item > 1 then
        item = item - 1
    elseif key == "right" and item < #sheet then
        item = item + 1
    end
end