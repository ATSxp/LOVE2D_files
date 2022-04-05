-- All requires --
require("src/constants")
require("src/utils")

love.graphics.setDefaultFilter("nearest", "nearest")
Font = love.graphics.newFont("assets/PublicPixel.ttf")
love.graphics.setFont(Font)
local newImg = love.graphics.newImage
gImages = {
    ["neko_icon"] = newImg("assets/icons/icon_discord.png"),
    ["char_icon"] = newImg("assets/icons/judgment.png"),
    ["luffy_barrigudo_icon"] = newImg("assets/icons/luffy_barrigudo.png"),
    ["joao_icon"] = newImg("assets/icons/joao.png"),
    ["joao_spritesheet"] = newImg("assets/sprites/joao_spritesheet.png"),
    ["dummy"] = newImg("assets/sprites/dummy.png"),
    ["button_menu"] = newImg("assets/sprites/button.png"),
    ["negao_teste"] = newImg("assets/sprites/negao.png"),
}

gFrames = {
    ["joao_spritesheet"] = createQuads(gImages.joao_spritesheet, 16, 16),
    ["dummy"] = createQuads(gImages.dummy, 16, 16),
}

Debug = require("debug_mode")
Camera = require("libs/camera")
sti = require("libs/sti")
wf = require("libs/windfield")
Anim = require("src/managers/anim_manager")
Sprite = require("src/managers/sprite_manager")
Scene = require("src/managers/scene_manager")
Timer = require("src/managers/timer_manager")
Textbox = require("src/managers/textbox_manager")
Button = require("src/managers/button_manager")
Entity = require("src/managers/entity_manager")
Npc = require("src/managers/npc_manager")
Sq = require("src/managers/cutscene_manager")

require("src/fade")
require("src/events_functions")
require("src/events")
loadEvents()
require("src/collision_class")
require("src/destroy_all_map")
require("src/managers/map_manager")
loadMap()

Scene:add("src/scenes/menu", "menu")
Scene:add("src/scenes/game", "game")

Negao = require("src/entities/negao")
Dummy = require("src/entities/dummy")
Player = require("src/entities/player")
require("src/managers/camera_manager")
