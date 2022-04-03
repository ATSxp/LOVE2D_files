return {
    ["dummy"] = Npc:new(
        {
            name = "dummy", 
            img = "neko_icon"
        }, 
        {
            {"Va te catar, marreco!"}
        },
        Anim:new("down", "dummy", {1}),
        function(self)
            self.sp:add(Anim:new("up", "dummy", {10}))
            self.sp:add(Anim:new("left", "dummy", {4}))
            self.sp:add(Anim:new("right", "dummy", {7}))
        end
    ),

    ["dummy2"] = Npc:new(
        {
            name = "Josh",
            img = "luffy_barrigudo_icon",
        },
        {
            {"Ola!", "Nao ligue para aquele cara, ele e rancoroso"}
        },
        Anim:new("up", "dummy", {10}),
        function(self)
            self.sp:add(Anim:new("down", "dummy", {1}))
            self.sp:add(Anim:new("left", "dummy", {4}))
            self.sp:add(Anim:new("right", "dummy", {7}))
        end
    ),

    ["roger"] = Npc:new(
        {
            name = "Roger",
            img = "joao_icon",
        },
        {
            {"Ola amigo"}
        },
        Anim:new("left", "dummy", {4}),
        function(self)
            self.sp:add(Anim:new("down", "dummy", {1}))
            self.sp:add(Anim:new("up", "dummy", {10}))
            self.sp:add(Anim:new("right", "dummy", {7}))
        end
    ),
}