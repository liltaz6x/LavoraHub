local GamesTab = {}

function GamesTab.build(tab, ui, Rayfield, SelectedGame)
    if not SelectedGame then
        ui.Label(tab, "Unsupported Game")
        return
    end

    ui.Label(tab, "Loaded Game Module")
    SelectedGame.build(tab, ui, Rayfield)
end

return GamesTab
