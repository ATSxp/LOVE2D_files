-- Assets --
local q = love.graphics.newQuad
local newImg = love.graphics.newImage
love.graphics.setDefaultFilter("nearest", "nearest")
local font = love.graphics.newFont("Perfect DOS VGA 437 Win.ttf")
love.graphics.setFont(font)

sheet = {
    newImg("assets/00-guide.png"),
    newImg("assets/01-generic.png"),
}

sprites = {}

sprite_item = 1
sprite_w, sprite_h = 16, 16
function updateSpriteSheet()
    local x, y, id = 0, 0, 0
    for i = 1, (sheet[sprite_item]:getWidth() / sprite_w) * (sheet[sprite_item]:getHeight() / sprite_h) do
        sprites[i] = q(x, y, sprite_w, sprite_h, sheet[sprite_item]:getWidth(), sheet[sprite_item]:getHeight())
        x = x + sprite_w
        if x > sheet[sprite_item]:getWidth() - sprite_w then
            x = 0
            y = y + sprite_h
        end
    end
end

function drawSpriteSheet()
    local x, y = 0, 0
    local scale = 2
    for i = 1, (sheet[sprite_item]:getWidth() / sprite_w) * (sheet[sprite_item]:getHeight() / sprite_h)do
        love.graphics.draw(sheet[sprite_item], sprites[i], x, y, 0, scale, scale)
        love.graphics.print(i, x, y + (sprite_w * 2))
        x = x + ((sprite_w + 5) * scale)
        if x > ((sprite_w + 5) * scale) * (sheet[sprite_item]:getWidth() / (sprite_w - 1 + scale)) then
            y = y + ((sprite_h + 5) * scale)
            x = 0
        end
    end

    local screenh = love.graphics.getHeight()
    love.graphics.print(sprite_item.."  of  "..#sheet, 0, screenh - 30)
end