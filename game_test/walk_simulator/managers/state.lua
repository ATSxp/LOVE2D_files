-- State Manager --
State = {}
State.states = {}
State.overlay = {}
State.current = ""

function State:set(name)
    self.current = name
    self.states[self.current]:on_active()
    self.states[self.current]:load()
    print("STATE = "..string.upper(name))
end

function State:add(e,name)
    self.mgr = self
    self.states[name] = require("scenes/"..e)
end

function State:pop()
    table.remove(self.overlay,1)
    if #self.overlay > 1 then
        self.states[1]:on_active()
    end
end

function State:push(e)
    self.mgr = self
    table.insert(self.overlay,1,e)
    e:on_active()
end
    
function State:load()
    self.states[self.current]:load()
    for i = #self.overlay, 1, -1 do
        self.overlay[i]:load()
    end
end

function State:update(dt)
    self.states[self.current]:update(dt)
    for i = #self.overlay, 1, -1 do
        self.overlay[i]:update(dt)
    end
end


function State:draw()
    self.states[self.current]:draw()
    for i = #self.overlay, 1, -1 do
        self.overlay[i]:draw()
    end
end
return State