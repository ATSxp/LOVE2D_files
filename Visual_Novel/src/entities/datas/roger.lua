return Npc:new(
    {
        name = "Roger",
        img = "joao_icon",
    },
    {"Ola amigo"},
    Anim:new("left", "dummy", {4}),
    function(self)
        self.sp:add(Anim:new("down", "dummy", {1}))
        self.sp:add(Anim:new("up", "dummy", {10}))
        self.sp:add(Anim:new("right", "dummy", {7}))
    end
)