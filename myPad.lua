-- Controls --

pad = {}

pad.debug = false
pad.touches = {}

local sw = 1280
local sh = 720

pad.buttonw = 96
pad.buttonh = 96

pad.dpad = {}
pad.dpad.buttons = {}

function pad:setInitialButton()
	table.insert(pad.dpad.buttons,
	{name = "up", x = pad.buttonw, y = pad.buttonh * 5, image = nil})
	table.insert(pad.dpad.buttons,
	{name = "down", x = pad.buttonw, y = pad.buttonh * 7, image = nil})
	table.insert(pad.dpad.buttons,
	{name = "left", x = 0, y = pad.buttonh * 6, image = nil})
	table.insert(pad.dpad.buttons,
	{name = "right", x = pad.buttonw * 2, y = pad.buttonh * 6, image = nil})
end

function pad:getDimensions()
	return pad.buttonw,pad.buttonh
end

function pad:setDimensions(w,h)
	pad.buttonw,pad.buttonh = w,h
end

function pad:addButtonImage(img,buttonName)	
	for _,button in ipairs(pad.dpad.buttons)do
		if button.name == buttonName then
			button.image = img or error("Waiting for image in parameter 1# in function pad:addButtonImage")
		end
	end
end

function pad:addButton(buttonName,x,y,img)
	table.insert(pad.dpad.buttons,{
		name = buttonName,
		x = x or 0,
		y = y or 0,
		image = img or nil,
	})
end

function pad:deleteButton(buttonName)
	for i,button in ipairs(pad.dpad.buttons)do
		if button.name == buttonName then
			table.remove(pad.dpad.buttons,i)
		end
	end
end

function pad:destroyAllButtons()
	for i,v in ipairs(pad.dpad.buttons)do
		table.remove(pad.dpad.buttons,i)
	end
end

function pad:draw()
	for _,button in ipairs(pad.dpad.buttons)do
		if button.isDown then
			love.graphics.setColor(1,1,1,1)
			if button.image ~= nil then
				love.graphics.draw(
				button.image,
				button.x,
				button.y
				)
			else
				love.graphics.rectangle(
				"fill",
				button.x,
				button.y,
				pad.buttonw,
				pad.buttonh
				)
			end
		else
			love.graphics.setColor(1,1,1,0.6)
			if button.image ~= nil then
				love.graphics.draw(
				button.image,
				button.x,
				button.y
				)
			else
				love.graphics.rectangle(
				"fill",
				button.x,
				button.y,
				pad.buttonw,
				pad.buttonh
				)
			end
		end
			
		if pad.debug then
			love.graphics.setColor(0,0,0,1)
			love.graphics.print(button.name,button.x,button.y)
		end
	end
	love.graphics.setColor(1,1,1,1)
end

function pad:update()
	pad.touches = love.touch.getTouches()
	for _,button in ipairs(pad.dpad.buttons)do
		button.isDown = false
			
		for _,id in ipairs(pad.touches)do
			local tx,ty = love.touch.getPosition(id)
				
			if 
				tx >= button.x and
				tx <= button.x + pad.buttonw and
				ty >= button.y and
				ty <= button.y + pad.buttonh then
						button.isDown = true
			end
		end
	end
end

function pad:isDown(key)
	for _,b in ipairs(pad.dpad.buttons)do
		if b.isDown and b.name == key then 
			return true
		end
	end
end
return pad
