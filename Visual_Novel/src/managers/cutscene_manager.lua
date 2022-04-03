local Cutscener = {}
local events = {
    {
        t = "print", 
        fn = function(s, e, complete)
            return evtPrint(e[2], e[3], e[4], e[5], complete)
        end,
    },
    {
        t = "dialogue", 
        fn = function(s, e, complete)
            local d = Textbox
            d:addDialogue(e[2], e[3])
            d.onComplete = complete
        end,
    },
    {
        t = "show_image",
        fn = function(s, e, complete)
            return evtShowImage(e[2], e[3], e[4], e[5], e[6], e[7], e[8], complete)
        end,
    },
}

function Cutscener:new(script, nostart)
    local s = {}
    s.script = script

    function s:update(dt)
    end

    function s:onComplete()
    end

    function s:popScript()
        if #s.script == 0 then
            s:onComplete()
            return
        else
            global_pause = 1
        end

        local e = table.remove(s.script, 1)
        local t = e[1]
        local evt

        for i, v in ipairs(events)do
            if t == v.t then
                evt = v:fn(e, s.popScript)
            end
        end

        if evt then
            evt.posUpdate = s.update
            evt:launch()
        end
    end

    function s:launch()
        s.script = script
        s:popScript()
    end

    if not nostart then
        s:launch()
    end
    return s
end
return Cutscener