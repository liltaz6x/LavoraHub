local Tabs = {}

function Tabs.build(Rayfield, Window, SelectedGame)
    local UI = require(script.Parent.UI)

    local HomeTab     = Window:CreateTab("Home")
    local GameTab     = Window:CreateTab("Game")
    local ToolsTab    = Window:CreateTab("Tools")
    local SettingsTab = Window:CreateTab("Settings")

    local Home     = require(script.Parent.Parent.Tabs.Home)
    local GameUI   = require(script.Parent.Parent.Tabs.Games)
    local Tools    = require(script.Parent.Parent.Tabs.Tools)
    local Settings = require(script.Parent.Parent.Tabs.Settings)

    Home.build(HomeTab, UI, Rayfield)
    Tools.build(ToolsTab, UI, Rayfield)
    Settings.build(SettingsTab, UI, Rayfield)
    GameUI.build(GameTab, UI, Rayfield, SelectedGame)
end

return Tabs
