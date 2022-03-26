local Textbox = {}
function Textbox:addDialogue(dialogue, data)
    self.dialogues = dialogue
    self.dialogues_i = 1
    self.text_i = 1
    self.data = data or {}
end

function Textbox:onComplete() -- function for "Evt" function
end

function Textbox:load()
end

function Textbox:update(dt)
    if self.dialogues ~= nil and self.dialogues[self.dialogues_i] ~= nil then
        local str = self.dialogues[self.dialogues_i]
        local len = string.len(str)

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
            love.graphics.rectangle("line", 5, SCREEN_H / 2, SCREEN_W - 10, SCREEN_H / 2 - 10)
            
            -- icon
            if self.data.img ~= nil then
                love.graphics.draw(
                    self.data.img, 
                    6, 111, 0, 
                    127 /self.data.img:getWidth(), 127 /self.data.img:getHeight())
                love.graphics.rectangle("line", 5, 110, 128, 128)
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

        if key == "z" and self.text_i >= 6 then
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