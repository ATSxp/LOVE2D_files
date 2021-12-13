-- Controls --

pad = {}

pad.debug = true
pad.touches = {}

local sw = 1280
local sh = 720

pad.dpad = {}

pad.buttonw = 32 * 3
pad.buttonh = 32 * 3

pad.dpad.buttons = 
{
	{name = "up", x = pad.buttonw, y = pad.buttonh * 5},
	{name = "down", x = pad.buttonw, y = pad.buttonh * 7},
	{name = "left", x = 0, y = pad.buttonh * 6},
	{name = "right", x = pad.buttonw * 2, y = pad.buttonh * 6}
}

pad.button = {}

pad.button.buttons = 
{
	{name = "A", x = 1280 - pad.buttonw * 3, y = pad.buttonh * 6},
}

pad.widgets = {pad.dpad,pad.button}

function pad.draw()
	for _,wid in ipairs(pad.widgets)do
		for _,button in ipairs(wid.buttons)do
			
			if button.isDown then
				love.graphics.setColor(1,1,1,1)
				love.graphics.rectangle(
				"fill",
				button.x,
				button.y,
				pad.buttonw,
				pad.buttonh
				)
			else
				love.graphics.setColor(1,1,1,0.6)
				love.graphics.rectangle(
				"fill",
				button.x,
				button.y,
				pad.buttonw,
				pad.buttonh
				)
			end
			
			if pad.debug then
				love.graphics.setColor(0,0,0,1)
				love.graphics.print(button.name,button.x,button.y)
			end
			
		end
	end
	love.graphics.setColor(1,1,1,1)
end

function pad.isDown(key)
	for _,wid in ipairs(pad.widgets)do
		for _,b in ipairs(wid.buttons)do
			if b.isDown and b.name == key then 
				return true
			end
		end
	end
end

function pad.update()
	pad.touches = love.touch.getTouches()
	for _,wid in ipairs(pad.widgets)do
		for _,button in ipairs(wid.buttons)do
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
end