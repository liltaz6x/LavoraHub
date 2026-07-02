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

    local KeyBtn = Instance.new("TextButton")
    KeyBtn.Size = UDim2.new(0, 260, 0, 40)
    KeyBtn.Position = UDim2.new(0, 10, 0, 60)
    KeyBtn.BackgroundColor3 = config.AccentColor
    KeyBtn.Text = "Change Open Keybind (Current: " .. (config.OpenKey and config.OpenKey.Name or "K") .. ")"
    KeyBtn.Font = Enum.Font.GothamBold
    KeyBtn.TextSize = 14
    KeyBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
    KeyBtn.TextWrapped = true
    KeyBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 8)
    KeyBtn.Parent = tab

    KeyBtn.MouseButton1Click:Connect(function()
        KeyBtn.Text = "Press a key..."
        local UIS = game:GetService("UserInputService")
        local conn
        conn = UIS.InputBegan:Connect(function(input)
            if input.KeyCode ~= Enum.KeyCode.Unknown then
                ui.SetKeybind(input.KeyCode)
                KeyBtn.Text = "Change Open Keybind (Current: " .. input.KeyCode.Name .. ")"
                Utils.saveConfig(config)
                conn:Disconnect()
            end
        end)
    end)

    local PickerFrame = Instance.new("Frame")
    PickerFrame.Size = UDim2.new(0, 260, 0, 180)
    PickerFrame.Position = UDim2.new(0, 10, 0, 110)
    PickerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    PickerFrame.BorderSizePixel = 0
    Instance.new("UICorner", PickerFrame).CornerRadius = UDim.new(0, 8)
    PickerFrame.Parent = tab

    local Hue = Instance.new("ImageLabel")
    Hue.Size = UDim2.new(0, 240, 0, 20)
    Hue.Position = UDim2.new(0, 10, 0, 10)
    Hue.Image = "rbxassetid://10767576624"
    Hue.BorderSizePixel = 0
    Hue.Parent = PickerFrame

    local SatVal = Instance.new("ImageLabel")
    SatVal.Size = UDim2.new(0, 240, 0, 100)
    SatVal.Position = UDim2.new(0, 10, 0, 40)
    SatVal.Image = "rbxassetid://10767581204"
    SatVal.BorderSizePixel = 0
    SatVal.Parent = PickerFrame

    local Preview = Instance.new("Frame")
    Preview.Size = UDim2.new(0, 240, 0, 20)
    Preview.Position = UDim2.new(0, 10, 0, 150)
    Preview.BackgroundColor3 = config.AccentColor
    Preview.BorderSizePixel = 0
    Instance.new("UICorner", Preview).CornerRadius = UDim.new(0, 6)
    Preview.Parent = PickerFrame

    local UIS = game:GetService("UserInputService")
    local hue = 0
    local sat = 1
    local val = 1

    local function updateColor()
        local color = Color3.fromHSV(hue, sat, val)
        config.AccentColor = color
        ui.Stroke.Color = color
        Preview.BackgroundColor3 = color
        Utils.saveConfig(config)
    end

    Hue.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local moveConn
            moveConn = UIS.InputChanged:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseMovement then
                    local rel = math.clamp((i.Position.X - Hue.AbsolutePosition.X) / Hue.AbsoluteSize.X, 0, 1)
                    hue = rel
                    updateColor()
                end
            end)
            UIS.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    moveConn:Disconnect()
                end
            end)
        end
    end)

    SatVal.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local moveConn
            moveConn = UIS.InputChanged:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseMovement then
                    local relX = math.clamp((i.Position.X - SatVal.AbsolutePosition.X) / SatVal.AbsoluteSize.X, 0, 1)
                    local relY = math.clamp((i.Position.Y - SatVal.AbsolutePosition.Y) / SatVal.AbsoluteSize.Y, 0, 1)
                    sat = relX
                    val = 1 - relY
                    updateColor()
                end
            end)
            UIS.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    moveConn:Disconnect()
                end
            end)
        end
    end)
end

return Settings
