-- all images used in this game
gImages = {
    ["cano_up"] = love.graphics.newImage("assets/cano_up.png"),
    ["cano_down"] = love.graphics.newImage("assets/cano_down.png"),
    ["josue"] = love.graphics.newImage("assets/josue_no_bitches.png"),
    ["bkg"] = love.graphics.newImage("assets/bkg.png"),
    ["floor"] = love.graphics.newImage("assets/floor.png"),
    ["due"] = love.graphics.newImage("assets/due.png"),
}

require("libs/PBScreen")
require("libs/show")
require("src/menu")
require("src/options")
require("src/skins")
require("src/player")
require("src/walls")
require("src/game_over")