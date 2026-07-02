local GamesTab = {}

function GamesTab.build(tab, ui, config)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 32)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = config.TextColor
    Title.Text = "Game Modules"
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = tab

    local BallBtn = Instance.new("TextButton")
    BallBtn.Size = UDim2.new(0, 200, 0, 32)
    BallBtn.Position = UDim2.new(0, 10, 0, 50)
    BallBtn.BackgroundColor3 = config.AccentColor
    BallBtn.Text = "Ball Game"
    BallBtn.Font = Enum.Font.GothamBold
    BallBtn.TextSize = 14
    BallBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
    Instance.new("UICorner", BallBtn).CornerRadius = UDim.new(0, 8)
    BallBtn.Parent = tab

    BallBtn.MouseButton1Click:Connect(function()
        _G.LavoraRequire("Games/BallGame.lua")
    end)

    local PaintBtn = Instance.new("TextButton")
    PaintBtn.Size = UDim2.new(0, 200, 0, 32)
    PaintBtn.Position = UDim2.new(0, 10, 0, 90)
    PaintBtn.BackgroundColor3 = config.AccentColor
    PaintBtn.Text = "Paint My Keyboard"
    PaintBtn.Font = Enum.Font.GothamBold
    PaintBtn.TextSize = 14
    PaintBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
    Instance.new("UICorner", PaintBtn).CornerRadius = UDim.new(0, 8)
    PaintBtn.Parent = tab

    PaintBtn.MouseButton1Click:Connect(function()
        _G.LavoraRequire("Games/PaintMyKeyboard.lua")
    end)
end

return GamesTab
