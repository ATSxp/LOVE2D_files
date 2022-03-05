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

sprite_item = 1
sprite_w, sprite_h = 16, 16
function updateSpriteSheet()
    local x, y,id = 0, 0, 0
    for i = 1, sheet[sprite_item]:getWidth() do
        sprites[i] = {q(id, y, sprite_w, sprite_h, sheet[sprite_item]:getWidth(), sheet[sprite_item]:getHeight())}
        id = id + sprite_w
        x = x + (sprite_w * 4)
        if x > (sprite_w * 48) - (sprite_w * 4) then
            x = 0
            y = y + sprite_h
            id = 0
        end
    end
end

function drawSpriteSheet()
    local x, y = 0, 0
    for i = 1, (sheet[sprite_item]:getWidth() / sprite_w)do
        for j = 1, (sheet[sprite_item]:getHeight() / sprite_w) do
            local v = sprites
            love.graphics.draw(sheet[sprite_item], v[i][1], x, y, 0, 4, 4)
            love.graphics.print(i, x, y + (sprite_w * 2), 0, 2, 2)
            x = x + (sprite_w * 4)
            if x > (sprite_w * 48) - (sprite_w * 4) then
                x = 0
                y = y + (sprite_h * 4)
            end
        end
    end

    local screenh = love.graphics.getHeight()
    love.graphics.print(sprite_item.."  de  "..#sheet, 0, screenh - 30, 0, 2, 2)
end