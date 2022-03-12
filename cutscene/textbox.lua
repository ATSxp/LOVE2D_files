local Textbox = {}

function Textbox:add(text)
    self.texts = text
    self.text_i = 1
    self.dialog_i = 1
end

function Textbox:on_complete()
end

function Textbox:update(dt)
    if self.texts ~= nil and self.texts[self.dialog_i] ~= nil then

        if self.text_i < string.len(self.texts[self.dialog_i]) and t % 2 == 0 then 
            self.text_i = self.text_i + 1
        end
    else
        self.on_complete()
    end 
end

function Textbox:draw()
    if self.texts ~= nil and self.texts[self.dialog_i] ~= nil then
        if self.dialog_i <= #self.texts then
            love.graphics.rectangle("line", 1, 400, 799, 400)
            love.graphics.print(string.sub(self.texts[self.dialog_i], 1, self.text_i), 10, 410, 0, 2, 2)
        end
    end
end

function Textbox:keypressed(key)
    if self.texts ~= nil and self.texts[self.dialog_i] ~= nil then
        if key == "z" and self.text_i >= 2 then
            if self.text_i < string.len(self.texts[self.dialog_i]) then
                self.text_i = string.len(self.texts[self.dialog_i])
            else
                self.dialog_i = self.dialog_i + 1
                self.text_i = 1
            end
        end
    end
end
return Textbox