function Evt()
	local s = {}
	function s.on_active()end
	function s.done()mgr.pop()end
	function s.launch()mgr.push(s)end
	function s.preUpdate(dt)end
	function s.posUpdate(dt)end
	function s.update(dt)s.preUpdate(dt)s.posUpdate(dt)end
	function s.draw()end
	return s
end

function drawBoxEvt(x, y, w, h, complete)
	local s = Evt()
    s.time = Timer(1.5)
	function s.preUpdate(dt)
        if s.time.complete() then
            s.done()
            complete()
        end
	end

	function s.draw()
		love.graphics.rectangle("fill", x, y, w, h)
	end
	return s
end

function printEvt(text, x, y, complete)
	local s = Evt()
    s.time = Timer(1.5)
    s.letter = 1
    function s.preUpdate(dt)
        if s.time.complete() then
            s.done()
            complete()
        end
        local len = string.len(text)
        if s.letter < len and t % 2 == 0 then
            s.letter = s.letter + 1
        end
    end
	
	function s.draw()
		love.graphics.print(string.sub(text, 1, s.letter), x, y, 0 , 4, 4)
	end
	return s
end

function showImageEvt(duration, img, x, y, r, sx, sy, ox, oy, complete)
	local s = Evt()
	s.time = Timer(duration)
	s.img = love.graphics.newImage(img)
	function s.preUpdate(dt)
		if s.time.complete()then
			s.done()
			complete()
		end
	end

	function s.draw()
		love.graphics.draw(s.img, x, y, r, sx, sy, ox, oy)
	end
	return s
end

-- function dialogueEvt(text, complete)
-- 	local s = Evt()
--     s.time = Timer(1.5)
-- 	local d = require("textbox")
-- 	d:add(text)
-- 	d.on_complete = complete
--     function s.preUpdate(dt)
-- 		if s.time.complete() then
--             s.done()
--             complete()
--         end
--     end
-- 	return s
-- end

function Sq(script,nostart)
    local s = {}
	s.script = script
	s.update = function()
	end
	s.on_complete = function()end
    s.pop_script = function()
        if #s.script == 0 then
            s.on_complete()
            return
        end
        local e = table.remove(s.script, 1)
        local t = e[1]
        local evt
        if t == "print" then
            evt = printEvt(e[2], e[3], e[4], s.pop_script)
		elseif t == "dialogue" then
			-- evt = dialogueEvt(e[2], s.pop_script)
			local d = require("textbox")
			d:add(e[2], false)
			d.on_complete = s.pop_script
		elseif t == "show_image" then
			evt = showImageEvt(e[2], e[3], e[4], e[5], e[6], e[7], e[8], e[9], e[10], s.pop_script)
		elseif t == "draw_box" then
			evt = drawBoxEvt(e[2], e[3], e[4], e[5], s.pop_script)
		end

        if evt then
            evt.posUpdate = s.update
            evt.launch()
        end
	end
	s.launch = function()
	    s.script = script
	    s.pop_script()
	end
	if not nostart then s.launch()end
	return s
end