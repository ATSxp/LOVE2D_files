-- all images used in this game
gImages = {
    ["cano_up"] = love.graphics.newImage("assets/cano_up.png"),
    ["cano_down"] = love.graphics.newImage("assets/cano_down.png"),
    ["bkg"] = love.graphics.newImage("assets/bkg.png"),
    ["floor"] = love.graphics.newImage("assets/floor.png"),
}

gSounds = {
    ["bkg_music"] = love.audio.newSource("assets/dia_azul.mp3", "stream"),
}

require("libs/PBScreen")
rs = require("libs/resolution_solution")
require("libs/show")
require("src/menu")
require("src/options")
require("src/skins")
require("src/player")
require("src/walls")
require("src/game_over")