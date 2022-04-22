player = {}
player.x = 40 -- x axis
player.y = 0 -- y axis
player.w = 40 -- width
player.h = 40 -- height
player.dy = 0 -- delta y/velocity y
player.img = "due" -- current sprite
player.gravity = 400
player.points = 0
player.die = false
player.rotation = 0

function player:update(dt)
    self.dy = self.dy + self.gravity * dt

    -- if player goes beyond the screen...
    if self.y > SCREEN_H or self.y + self.h < 0 then

        if not self.die then
            -- points passed to variable, so it will be checked whether or not the player has broken the highest record
            maxScore = player.points
            if not self.die then
                -- ...he die =)
                self.die = true
                print("==============================\nPLAYER DEAD")
            end

        end

    end

    self.y = self.y + self.dy * dt
end

function player:draw()
    love.graphics.draw(
        gImages[self.img], 
        self.x, self.y, self.rotation, 
        self.w / gImages[self.img]:getWidth(), 
        self.h / gImages[self.img]:getHeight()
    )
end

function player:keypressed(key, scancode, isrepeat)
    if self.die then return end
    
    -- jump
    if key == "space" then
        self.dy = - 200
    end

end
return player