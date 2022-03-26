local Events = {}
function Events:load()
    local scenes = {
        ["intro"] = {
            {
                "dialogue", 
                {"Ola, bem vindo ao meu jogo", "Ass: Criador"},
                {img = gImages.neko_icon,}

            }, 
            {
                "dialogue", 
                {"Bom dia", "cumpadi", "parceiro"},
                {img = gImages.char_icon,}

            }
        },
        
    }
    return scenes
end
return Events