local GamesTabModule = {}

function GamesTabModule.build(tab, ui, Rayfield)
    local BallGame      = require(script.Parent.Parent.Games.BallGame)
    local WatchNumbers  = require(script.Parent.Parent.Games.WatchNumbersGoUp)

    ui.Label(tab, "Games")

    ui.Button(tab, "Ball Game", function()
        BallGame.build(tab, ui, { Rayfield = Rayfield })
    end)

    ui.Button(tab, "Watch Numbers Go Up", function()
        WatchNumbers.build(tab, ui, { Rayfield = Rayfield })
    end)
end

return GamesTabModule
