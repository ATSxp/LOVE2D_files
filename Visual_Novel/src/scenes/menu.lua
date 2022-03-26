local Menu = {}
local main_buttons_w = 128
local main_buttons_h = 32
local menu_item = {
    Button:newMouse("Start", nil, 
    20, 100, 
    main_buttons_w, main_buttons_h, 
    function() 
        Scene:set("game")
    end),
    
    Button:newMouse("Exit", nil, 
    20, 100 + main_buttons_h * 1.5, 
    main_buttons_w, main_buttons_h, 
    function() 
        love.event.quit()
    end),
}

function Menu:load()
    local scenes = Events:load()
    Sq:new(scenes.intro)
end

function Menu:update(dt)
    for i,v in ipairs(menu_item)do
        v:update(dt)
    end
end

function Menu:draw()
    love.graphics.print("Visual Novel The Game", 20, 20, 0, 4, 4)
    for i,v in ipairs(menu_item)do
        v:draw()
    end
end
return Menu