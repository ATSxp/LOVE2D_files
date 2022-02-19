require "assets"
require "sprite_manager"

function love.load()
	t = 0
	love.window.setMode(1280,720,{fullscreen = true})
	p = {}
	p.w,p.h = 16*8,16*8
	p.x,p.y = (1280-p.w)/2,(720-p.h)/2
	p.sp = Anm(
	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31},
	8,true)
end

function love.update(dt)
	p.sp:update(dt)
	t = t + 1
end

function love.draw()
	spr(p.sp.frame,p.x,p.y,0,8,8)
	--love.graphics.print(p.sp.frame,0,100,0,2,2)
end