local TabsCore = {}

-- Only one supported game
local SupportedGames = {
    ["72016039587124"] = "BallGame",
}

local function createTabFrame(ui, id)
    local frame = Instance.new("Frame")
    frame.Name = id
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = ui.ContentFrame
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

    btn.MouseEnter:Connect(function()
        btn.TextColor3 = ui.Config.AccentColor
    end)
    btn.MouseLeave:Connect(function()
        btn.TextColor3 = ui.Config.TextColor
    end)

    btn.MouseButton1Click:Connect(callback)

    return btn
end

function TabsCore.init(ui, config)
    -- Load normal tabs
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

    -- Sidebar buttons
    createSidebarButton(ui, "Home", 1, function() showTab(ui, "Home") end)
    createSidebarButton(ui, "Tools", 2, function() showTab(ui, "Tools") end)
    createSidebarButton(ui, "Settings", 3, function() showTab(ui, "Settings") end)

    ---------------------------------------------------------------------
    -- GAME AUTO-DETECTION
    ---------------------------------------------------------------------
    local placeId = tostring(game.PlaceId)
    local gameModuleName = SupportedGames[placeId]

    if gameModuleName then
        -- Load game module
        local modulePath = "Games/" .. gameModuleName .. ".lua"
        local GameModule = _G.LavoraRequire(modulePath)

        -- Get real game name
        local MarketplaceService = game:GetService("MarketplaceService")
        local ok, info = pcall(function()
            return MarketplaceService:GetProductInfo(game.PlaceId)
        end)

        local realName = ok and info.Name or "Ball Game"

        -- Sidebar button becomes the game name
        createSidebarButton(ui, realName, 4, function()
            showTab(ui, "Game")
        end)

        -- Build game UI
        GameModule.build(GameTab, ui, config)

    else
        -- No supported game detected
        createSidebarButton(ui, "Game", 4, function()
            showTab(ui, "Game")
        end)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -20, 0, 32)
        Label.Position = UDim2.new(0, 10, 0, 10)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.GothamBold
        Label.TextSize = 20
        Label.TextColor3 = ui.Config.TextColor
        Label.Text = "No supported game detected"
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = GameTab
    end

    showTab(ui, "Home")
end

return TabsCore
