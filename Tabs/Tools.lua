local Tools = {}

function Tools.build(tab, ui, config)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 32)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = config.TextColor
    Title.Text = "Tools"
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = tab

    local DexBtn = Instance.new("TextButton")
    DexBtn.Size = UDim2.new(0, 260, 0, 40)
    DexBtn.Position = UDim2.new(0, 10, 0, 60)
    DexBtn.BackgroundColor3 = config.AccentColor
    DexBtn.Text = "Load Dex Explorer"
    DexBtn.Font = Enum.Font.GothamBold
    DexBtn.TextSize = 14
    DexBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
    DexBtn.TextWrapped = true
    DexBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", DexBtn).CornerRadius = UDim.new(0, 8)
    DexBtn.Parent = tab

    DexBtn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end)

    local CobaltBtn = Instance.new("TextButton")
    CobaltBtn.Size = UDim2.new(0, 260, 0, 40)
    CobaltBtn.Position = UDim2.new(0, 10, 0, 110)
    CobaltBtn.BackgroundColor3 = config.AccentColor
    CobaltBtn.Text = "Load Cobalt"
    CobaltBtn.Font = Enum.Font.GothamBold
    CobaltBtn.TextSize = 14
    CobaltBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
    CobaltBtn.TextWrapped = true
    CobaltBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", CobaltBtn).CornerRadius = UDim.new(0, 8)
    CobaltBtn.Parent = tab

    CobaltBtn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()
    end)
end

return Tools
