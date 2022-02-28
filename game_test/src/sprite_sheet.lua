-- Assets --
local q = love.graphics.newQuad
love.graphics.setDefaultFilter("nearest","nearest")
local font = love.graphics.newFont("Mario-Kart-DS.ttf")
love.graphics.setFont(font)

sheet = {
    love.graphics.newImage("assets/03-soldier.png"), -- 1
}

sprites = {
    {q(0,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 1
    {q(16,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 2
    {q(32,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 3
    {q(48,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 4
    {q(64,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 5
    {q(80,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 6
    {q(96,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 7
    {q(112,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 8
    {q(128,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 9
    {q(144,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 10
    {q(160,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 11
    {q(176,0,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 12

    {q(0,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 13
    {q(16,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 14
    {q(32,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 15
    {q(48,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 16
    {q(64,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 17
    {q(80,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 18
    {q(96,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 19
    {q(112,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 20
    {q(128,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 21
    {q(144,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 22
    {q(160,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 23
    {q(176,16,16,16,sheet[1]:getWidth(),sheet[1]:getHeight()),sheet[1]}, -- 24
}

function getSpriteSheet()
    local x, y = 0, 0
    for i = 1, #sprites do
        local v = sprites
        love.graphics.draw(v[i][2], v[i][1], x, y, 0, 4, 4)
        love.graphics.setColor(0.9, 0.9, 0.2)
        love.graphics.print(i, x, y + 32, 0, 2, 2)
        love.graphics.setColor(1, 1, 1)
        x = x + 64
        if x > 16 * 48 - 64 then
            x = 0
            y = y + 64
        end
    end
end