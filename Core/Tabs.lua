local TabsCore = {}

local SupportedGames = {
    ["72016039587124"] = "BallGame",
}

local function createTabFrame(ui, id)
    local frame = Instance.new("Frame")
    frame.Name = id
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = ui.TabsFolder
    return frame
end

local function showTab(ui, id)
    for _, tab in ipairs(ui.TabsFolder:GetChildren()) do
        tab.Visible = (tab.Name == id)
    end
end

local function createSidebarButton(ui, name, order, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 32)
    btn.Position = UDim2.new(0, 10, 0, 20 + (order - 1) * 38)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = ui.Config.TextColor
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = ui.Sidebar

    btn.MouseButton1Click:Connect(callback)

    return btn
end

function TabsCore.init(ui, config)
    local HomeModule     = _G.LavoraRequire("Tabs/Home.lua")
    local ToolsModule    = _G.LavoraRequire("Tabs/Tools.lua")
    local SettingsModule = _G.LavoraRequire("Tabs/Settings.lua")

    local HomeTab     = createTabFrame(ui, "Home")
    local ToolsTab    = createTabFrame(ui, "Tools")
    local SettingsTab = createTabFrame(ui, "Settings")
    local GameTab     = createTabFrame(ui, "Game")

    HomeModule.build(HomeTab, ui, config)
    ToolsModule.build(ToolsTab, ui, config)
    SettingsModule.build(SettingsTab, ui, config)

    createSidebarButton(ui, "Home", 1, function() showTab(ui, "Home") end)
    createSidebarButton(ui, "Tools", 2, function() showTab(ui, "Tools") end)
    createSidebarButton(ui, "Settings", 3, function() showTab(ui, "Settings") end)

    local placeId = tostring(game.PlaceId)
    local gameModuleName = SupportedGames[placeId]

    if gameModuleName then
        local GameModule = _G.LavoraRequire("Games/" .. gameModuleName .. ".lua")

        createSidebarButton(ui, "Ball Game", 4, function()
            showTab(ui, "Game")
        end)

        GameModule.build(GameTab, ui, config)
    else
        createSidebarButton(ui, "Game", 4, function()
            showTab(ui, "Game")
        end)
    end

    showTab(ui, "Home")
end

return TabsCore
