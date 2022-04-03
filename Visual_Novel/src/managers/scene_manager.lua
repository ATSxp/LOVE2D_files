-- Scenes Managers --
Scene = {}
Scene.states = {}
Scene.curState = ""
Scene.overlayer = {}

function Scene:add(obj,name)
    if name == nil or type(name) ~= "string" then
        error("You forgot to add a name in parameter #2 of Scene:add function")
    end
    self.states[name] = require(obj)
end

function Scene:set(name)
    self.curState = name
    self:load()
end

function Scene:pop()
    table.remove(self.overlayer, 1)
    if #self.overlayer > 1 then
        self.states[1]:load()
    end
end

function Scene:push(obj)
    table.insert(self.overlayer, 1, obj)
    obj:load()
end

function Scene:load()
    print("Current State: "..string.upper(self.curState))
    self.states[self.curState]:load(dt)
    for i, v in  ipairs(self.overlayer)do
        v:load(dt)
    end
end

function Scene:update(dt)
    self.states[self.curState]:update(dt)
    for i, v in  ipairs(self.overlayer)do
        v:update(dt)
    end
end

function Scene:draw()
    self.states[self.curState]:draw(dt)
    for i, v in  ipairs(self.overlayer)do
        v:draw(dt)
    end
end

function Scene:keypressed(key, scancode, isrepeat)
    if self.states[self.curState].keypressed then
        self.states[self.curState]:keypressed(key, scancode, isrepeat)
    end
    for i, v in  ipairs(self.overlayer)do
        if v.keypressed then
            v:keypressed(key, scancode, isrepeat)
        end
    end
end
return Scene