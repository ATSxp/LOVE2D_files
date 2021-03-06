-- Player Class --
local Sprite = require "managers/sprite"
local Anim = require "managers/anim"
local screenw, screenh = love.graphics.getDimensions()
local Player = require "managers/entity":new((screenw - 32)/2, (screenh - 32)/2, Sprite:new(Anim:new("idle-down", 1, {2}, 8, true)))
function Player:load()
    self.speed = 150

    -- animations
    -- idle
    self.sp:add(Anim:new("idle-up", 1, {20}, 8, true))
    self.sp:add(Anim:new("idle-left", 1, {8}, 8, true))
    self.sp:add(Anim:new("idle-right", 1, {14}, 8, true))

    -- walk
    self.sp:add(Anim:new("walk-down", 1, {1, 3}, 8, true))
    self.sp:add(Anim:new("walk-up", 1, {19, 21}, 8, true))
    self.sp:add(Anim:new("walk-left", 1, {7, 9}, 8, true))
    self.sp:add(Anim:new("walk-right", 1, {13, 15}, 8, true))

    self.dir = 2
end

function Player:camera()
    if 
    math.floor(self.pos.x / 1366)* 1366 ~= mx or 
    math.floor(self.pos.y / 768)* 768 ~= my then
        mx = math.floor(self.pos.x / 1366)* 1366
        my = math.floor(self.pos.y / 768)* 768
    end
end

function Player:update(dt)
    local key = love.keyboard.isDown
    self.sp:update(dt)
    self:camera()

    local anim_walk = {
        "walk-up",
        "walk-down",
        "walk-left",
        "walk-right",
    }
    
    local anim_idle = {
        "idle-up",
        "idle-down",
        "idle-left",
        "idle-right",
    }

    if key("up")then
        self.vel.y = - self.speed
        self.dir = 1
    elseif key("down")then
        self.vel.y = self.speed
        self.dir = 2
    else
        self.vel.y = 0
        self.sp:set(anim_idle[self.dir])
    end

    if key("left")then
        self.vel.x = - self.speed
        self.dir = 3
    elseif key("right")then
        self.vel.x = self.speed
        self.dir = 4
    else
        self.vel.x = 0
    end

    if self.vel.x ~= 0 or self.vel.y ~= 0 then
        self.sp:set(anim_walk[self.dir])
    end
    
    self.pos.x = self.pos.x + self.vel.x * dt
    self.pos.y = self.pos.y + self.vel.y * dt
end

function Player:draw()
    self.sp:draw(self.pos)
end
return Player