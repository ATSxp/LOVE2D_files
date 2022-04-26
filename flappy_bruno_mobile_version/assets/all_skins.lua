--[[
    == SKINS ==

    Aqui fica todas as skins do jogador
    se estiver afim de adicionar uma skin,
    basta seguir os seguintes passos:

    1 - primeiro você deve adicionar uma "tabela"
    abrindo e fechando duas chaves( {} ), lembrando,
    sempre adicione um virgula após o fechamento de 
    uma chave.

    2 - dentro destas chaves, você irá ter que escrever dois
    parâmetros, 1# Nome da skin e 2# O caminho da pasta da skin,
    sempre pôndo um virgula após uma linha, no segundo parâmetro 
    você terá que usar uma "função" nomeada de "img".
    Do jeito mostrado abaixo:

    -- detalhe, em aspas(simple ou duplas) -- 
    {
        
        "Nome da skin",
        img("Caminho da skin")

    }, -- não esqueça da virgula --

    3 - Após isso, só compilar e rodar o jogo e ser feliz =)
]]

local img = loadImageFromPath
return {
    -- back to options
    {
        "Back",
    },
    -- !Escreva depois daquui!

    -- skin beta
    {
        "josue",
        img("assets/josue_no_bitches.png"),
    },

    -- skin default
    {
        "due",
        img("assets/due.png"),
    },

    {
        "mag",
        img("assets/mag.png"),
    },

    {
        "joao",
        img("assets/joao_pixel_art.png"),
    },

    {
        "igor",
        img("assets/igor-roger.png"),
    },

    {
        "raiden",
        img("assets/raiden.png"),
    },

    {
        "teste",
        img("C:/Users/ATS/Pictures/icon_darwin_bayonetta.png"),
    },

    {
        "Majorao",
        img("C:/Users/ATS/Pictures/majoras.png"),
    },

    -- !Escreva antes daqui!
    -- back to options
    {
        "Back",
    },
}