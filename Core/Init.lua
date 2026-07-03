local Init = {}

function Init.start(Rayfield)
    local Theme = require(script.Parent.Theme)
    local Tabs = require(script.Parent.Tabs)

    local Window = Rayfield:CreateWindow({
        Title = "Lavora Hub",
        Theme = Theme.getTheme(),
        LoadingTitle = "Lavora Hub",
        LoadingSubtitle = "by Taz",
        DisableRayfieldPrompts = true
    })

    Tabs.build(Rayfield, Window)
end

return Init
