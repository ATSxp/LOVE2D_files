-- All requires --

local newImg = love.graphics.newImage
gImages = {
    ["neko_icon"] = newImg("assets/characters/icon_discord.jpg"),
    ["char_icon"] = newImg("assets/characters/judgment.png"),
    ["luffy_barrigudo"] = newImg("assets/characters/luffy_barrigudo.png")
}

gFrames = {

}

require("src/constants")
require("src/utils")
Events = require("src/events")

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