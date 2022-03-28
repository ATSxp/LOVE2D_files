-- All requires --

require("src/constants")
require("src/utils")
Events = require("src/events")

love.graphics.setDefaultFilter("nearest", "nearest")
local newImg = love.graphics.newImage
gImages = {
    ["neko_icon"] = newImg("assets/icons/icon_discord.png"),
    ["char_icon"] = newImg("assets/icons/judgment.png"),
    ["luffy_barrigudo_icon"] = newImg("assets/icons/luffy_barrigudo.png"),
    ["joao_icon"] = newImg("assets/icons/joao.png"),
    ["joao_sprite"] = newImg("assets/sprites/joao_asanhado.png"),
}

gFrames = {
    ["joao_sprite"] = createQuads(gImages.joao_sprite, 828 / 2, 828 / 2),
}

wf = require("libs/windfield")
Anim = require("src/managers/anim_manager")
Sprite = require("src/managers/sprite_manager")
Scene = require("src/managers/scene_manager")
Timer = require("src/managers/timer_manager")
Textbox = require("src/managers/textbox_manager")
Button = require("src/managers/button_manager")
Entity = require("src/managers/entity_manager")
require("src/events_functions")
Sq = require("src/managers/cutscene_manager")

Scene:add("src/scenes/menu", "menu")
Scene:add("src/scenes/game", "game")

Player = require("src/entities/player")