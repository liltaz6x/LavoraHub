local Settings = {}
local Utils = _G.LavoraRequire("Core/Utils.lua")

function Settings.build(tab, ui, config)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 32)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = config.TextColor
    Title.Text = "Settings"
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = tab

    -- Accent color button
    local ColorBtn = Instance.new("TextButton")
    ColorBtn.Size = UDim2.new(0, 200, 0, 32)
    ColorBtn.Position = UDim2.new(0, 10, 0, 50)
    ColorBtn.BackgroundColor3 = config.AccentColor
    ColorBtn.Text = "Randomize Accent Color"
    ColorBtn.Font = Enum.Font.GothamBold
    ColorBtn.TextSize = 14
    ColorBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
    Instance.new("UICorner", ColorBtn).CornerRadius = UDim.new(0, 8)
    ColorBtn.Parent = tab

    ColorBtn.MouseButton1Click:Connect(function()
        local new = Color3.fromRGB(
            math.random(50, 255),
            math.random(50, 255),
            math.random(50, 255)
        )
        config.AccentColor = new
        ui.Stroke.Color = new
        ColorBtn.BackgroundColor3 = new
        Utils.saveConfig(config)
    end)

    -- UI scale slider (simple)
    local ScaleLabel = Instance.new("TextLabel")
    ScaleLabel.Size = UDim2.new(0, 200, 0, 24)
    ScaleLabel.Position = UDim2.new(0, 10, 0, 95)
    ScaleLabel.BackgroundTransparency = 1
    ScaleLabel.Font = Enum.Font.GothamBold
    ScaleLabel.TextSize = 14
    ScaleLabel.TextColor3 = config.TextColor
    ScaleLabel.Text = "UI Scale"
    ScaleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ScaleLabel.Parent = tab

    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(0, 200, 0, 6)
    Slider.Position = UDim2.new(0, 10, 0, 125)
    Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Slider.Parent = tab
    Instance.new("UICorner", Slider).CornerRadius = UDim.new(0, 4)

    local Handle = Instance.new("Frame")
    Handle.Size = UDim2.new(0, 12, 0, 12)
    Handle.Position = UDim2.new((config.Scale - 0.5), -6, 0, -3)
    Handle.BackgroundColor3 = config.AccentColor
    Handle.Parent = Slider
    Instance.new("UICorner", Handle).CornerRadius = UDim.new(0, 6)

    local dragging = false

    Handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    Handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    Slider.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp(
                (input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X,
                0, 1
            )
            local scale = 0.5 + rel
            ui.UIScale.Scale = scale
            Handle.Position = UDim2.new(rel, -6, 0, -3)
            config.Scale = scale
            Utils.saveConfig(config)
        end
    end)
end

return Settings
