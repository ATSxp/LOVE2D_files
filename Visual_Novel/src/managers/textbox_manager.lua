local Textbox = {}
function Textbox:addDialogue(dialogue, data)
    self.dialogues = dialogue
    self.dialogues_i = 1
    self.text_i = 1
    self.data = data or {}
end

function Textbox:onComplete() -- for "Evt" function
end

function Textbox:load()
end

function Textbox:update(dt)
    if self.dialogues ~= nil and self.dialogues[self.dialogues_i] ~= nil then
        local str = self.dialogues[self.dialogues_i]
        local len = string.len(str)

        global_pause = 1
        if self.text_i < len and tick % 2 == 0 then
            self.text_i = self.text_i + 1
        end
    else
        self:onComplete()
    end
end

function Textbox:draw()
    if self.dialogues ~= nil and self.dialogues[self.dialogues_i] ~= nil then
        local str = self.dialogues[self.dialogues_i]
        local len = string.len(str)

        if self.dialogues_i <= #self.dialogues then
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 0, 0, SCREEN_W, SCREEN_H)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.rectangle("fill", 5, SCREEN_H / 2, SCREEN_W - 10, SCREEN_H / 2 - 10)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 5, SCREEN_H / 2, SCREEN_W - 10, SCREEN_H / 2 - 10)
            
            -- icon
            if self.data.img ~= nil then
                love.graphics.draw(
                    self.data.img, 
                    6, 51, 0, 
                    (127 * 1.5) /self.data.img:getWidth(), (127 * 1.5) /self.data.img:getHeight())
                love.graphics.rectangle("line", 5, 50, 128 * 1.5, 128 * 1.5)
            end

            -- name
            if self.data.name ~= nil then
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.rectangle(
                    "fill", 
                    (128 * 1.5) + 12, 51 * 4.3, 
                    Font:getWidth(self.data.name) + 13, 24)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.print(self.data.name, (128 * 1.5) + 19, 51 * 4.4)
                love.graphics.rectangle(
                    "line", 
                    (128 * 1.5) + 12, 51 * 4.3, 
                    Font:getWidth(self.data.name) + 13, 24)
            end

            -- text
            love.graphics.print(string.sub(str, 1, self.text_i), 10, SCREEN_H / 2 + 5)
        end

    end
end

function Textbox:keypressed(key, scancode,isrepeat)
    if self.dialogues ~= nil and self.dialogues[self.dialogues_i] ~= nil then
        local str = self.dialogues[self.dialogues_i]
        local len = string.len(str)

        if key == "z" and self.text_i >= 2 then
            if self.text_i < len then
                self.text_i = len
            else
                self.text_i = 1
                self.dialogues_i = self.dialogues_i + 1
            end
        end
    end
end
return Textbox