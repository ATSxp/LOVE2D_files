-- Functions only used for cutscenes
function evtPrint(text, x, y, duration,complete)
   local s = Evt()
   s.timer = Timer:new(duration)
   function s:preUpdate(dt)
      if s.timer:complete()then
         s:done()
         complete()
      else
         global_pause = 1
      end
   end

   function s:draw()
      love.graphics.setColor(0, 0, 0, 0.5)
      love.graphics.rectangle("fill", 0, 0, SCREEN_W, SCREEN_H)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.print(text, x, y)
   end
   return s
end

function evtShowImage(img, x, y, r, sx, sy, duration, complete)
   local s = Evt()
   s.timer = Timer:new(duration)
   function s:preUpdate(dt)
      if s.timer:complete()then
         s:done()
         complete()
      else
         global_pause = 1
      end
   end

   function s:draw()
      love.graphics.setColor(0, 0, 0, 0.5)
      love.graphics.rectangle("fill", 0, 0, SCREEN_W, SCREEN_H)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.draw(gImages[img], x, y, r, sx / gImages[img]:getWidth(), sy / gImages[img]:getHeight())
   end
   return s
end