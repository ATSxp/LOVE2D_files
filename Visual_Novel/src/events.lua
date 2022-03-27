-- This is where all the game's cutscenes or events will be
local Events = {}
function Events:load()
    local scenes = {
        ["intro"] = {
            {
                "dialogue", 
                {"Neste Momento, irei lhe apresentar um personagem"},
                {img = gImages.neko_icon,
                name = "Creator"}

            }, 
            {
                "dialogue", 
                {"Oi", "eu to com fome.", "Poderia me dar algo para comer?"},
                {img = gImages.joao_icon,
                name = "João Victor"}
            }
        },
        
    }
    return scenes
end
return Events