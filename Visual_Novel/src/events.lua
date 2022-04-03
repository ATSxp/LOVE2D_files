-- This is where all the game's cutscenes or events will be
function loadEvents()
    scenes = {
        ["intro"] = {
            {
                "dialogue", 
                {"Eae fela da puta, como ce ta?"},
                {
                    img = gImages.char_icon,
                    name = "Roger"
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
end