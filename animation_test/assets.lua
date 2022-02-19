local q = love.graphics.newQuad
love.graphics.setDefaultFilter("nearest","nearest")

tilesets = {
	[1] = love.graphics.newImage("loose_sprites.png")
}

local t = tilesets
sprites = {
	[1] = {t[1],q(0,0,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[2] = {t[1],q(16,0,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[3] = {t[1],q(32,0,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[4] = {t[1],q(48,0,16,16,t[1]:getWidth(),t[1]:getHeight())}, -- 1
	
	[5] = {t[1],q(0,16,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[6] = {t[1],q(16,16,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[7] = {t[1],q(32,16,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[8] = {t[1],q(48,16,16,16,t[1]:getWidth(),t[1]:getHeight())}, -- 2
	
	[9] = {t[1],q(0,32,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[10] = {t[1],q(16,32,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[11] = {t[1],q(32,32,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[12] = {t[1],q(48,32,16,16,t[1]:getWidth(),t[1]:getHeight())}, -- 3
	
	[11] = {t[1],q(0,48,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[13] = {t[1],q(16,48,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[14] = {t[1],q(32,48,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[15] = {t[1],q(48,48,16,16,t[1]:getWidth(),t[1]:getHeight())}, -- 4
	
	[16] = {t[1],q(0,64,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[17] = {t[1],q(16,64,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[18] = {t[1],q(32,64,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[19] = {t[1],q(48,64,16,16,t[1]:getWidth(),t[1]:getHeight())}, -- 5
	
	[20] = {t[1],q(0,80,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[21] = {t[1],q(16,80,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[22] = {t[1],q(32,80,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[23] = {t[1],q(48,80,16,16,t[1]:getWidth(),t[1]:getHeight())}, -- 6
	
	[24] = {t[1],q(0,96,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[25] = {t[1],q(16,96,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[26] = {t[1],q(32,96,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[27] = {t[1],q(48,96,16,16,t[1]:getWidth(),t[1]:getHeight())}, -- 7
	
	[28] = {t[1],q(0,112,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[29] = {t[1],q(16,112,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[30] = {t[1],q(32,112,16,16,t[1]:getWidth(),t[1]:getHeight())},
	[31] = {t[1],q(48,112,16,16,t[1]:getWidth(),t[1]:getHeight())},
}