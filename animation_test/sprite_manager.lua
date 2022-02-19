-- Sprite Manager --

function Anm(frames,fps,loop)
	local self = {}
	self.frames = frames
	self.speed = fps or 8
	self.loop = loop or false
	self.indx = 0
	self.t = 0
	
	function self:update(dt)
		if t >= self.t and #self.frames > 0 then
			if self.loop then
				self.indx = (self.indx+1)%#self.frames
				self.frame = self.frames[self.indx+1]
			else
				self.indx = self.indx < #self.frames and self.indx + 1 or #self.frames
				self.frame = self.frames[self.indx]
			end
			self.t = t + self.speed
		end
	end
	
	function self:reset()
		self.indx = 0
	end
	return self
end

function spr(id,x,y,r,sx,sy,ox,oy,kx,ky)
	return love.graphics.draw(sprites[id][1],sprites[id][2],x,y,r,sx,sy,ox,oy,kx,ky)
end