-- Player Class --
local Sprite = require "managers/sprite"
local Anim = require "managers/anim"
Player = require "managers/entity":new(0, 0, Sprite:new(Anim:new("idle", {1,2,3}, 8, true)))
function Player:load()
    self.speed = 200
end

function Player:update(dt)
    local key = love.keyboard.isDown
    self.sp:update(dt)

    if key("w")then
        self.vel.y = - self.speed
    elseif key("s")then
        self.vel.y = self.speed
    else
        self.vel.y = 0
    end

    if key("a")then
        self.vel.x = - self.speed
    elseif key("d")then
        self.vel.x = self.speed
    else
        self.vel.x = 0
    end

    self.pos.x = self.pos.x + self.vel.x * dt
    self.pos.y = self.pos.y + self.vel.y * dt
end

function Player:draw()
    self.sp:draw(self.pos)
end
return Player