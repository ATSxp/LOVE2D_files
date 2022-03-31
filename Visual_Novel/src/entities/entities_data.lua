return {
    ["dummy"] = Npc:new(
        {
            name = "dummy", 
            img = gImages.neko_icon
        }, 
        {
            {"Va te catar, marreco!"}
        },
        "npc", Anim:new("down", "dummy", {1}),
        {
            ["up"] = {texture = "dummy", frames = {10}},
            ["left"] = {texture = "dummy", frames = {4}},
            ["right"] = {texture = "dummy", frames = {7}},
        }
    ),
}