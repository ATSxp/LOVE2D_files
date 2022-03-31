-- This is where all the game's cutscenes or events will be
local Events = {}
function Events:load()
    local scenes = {
        ["intro"] = {
            {
                "dialogue", 
                {"*Comendo hotdog*"},
                {
                    img = gImages.neko_icon,
                    name = "Creator"
                }

            }, 
            {
                "dialogue", 
                {"O-oi...", "eu to com um tiquinho de fome.", "Poderia me dar algo?"},
                {
                    img = gImages.joao_icon,
                    name = "João Victor"
                }
            }
        },
        
    }
    return scenes
end
return Events