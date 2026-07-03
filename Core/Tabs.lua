local Tabs = {}

function Tabs.build(Rayfield, Window)
    local UI = require(script.Parent.UI)

    local HomeTab    = Window:CreateTab("Home")
    local GamesTab   = Window:CreateTab("Games")
    local ToolsTab   = Window:CreateTab("Tools")
    local SettingsTab= Window:CreateTab("Settings")

    local Home    = require(script.Parent.Parent.Tabs.Home)
    local Games   = require(script.Parent.Parent.Tabs.Games)
    local Tools   = require(script.Parent.Parent.Tabs.Tools)
    local Settings= require(script.Parent.Parent.Tabs.Settings)

    Home.build(HomeTab, UI, Rayfield)
    Games.build(GamesTab, UI, Rayfield)
    Tools.build(ToolsTab, UI, Rayfield)
    Settings.build(SettingsTab, UI, Rayfield)
end

return Tabs
