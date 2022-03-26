function evtPrint(text, x, y, duration,complete)
   local s = Evt()
   s.timer = Timer:new(duration)
   function s:preUpdate(dt)
      if s.timer:complete()then
         s:done()
         complete()
      end
   end

   function s:draw()
      love.graphics.print(text, x, y)
   end
   return s
end