local UI = {}

function UI.create(config)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LavoraHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 650, 0, 400)
    Main.Position = UDim2.new(0.5, -325, 0.5, -200)
    Main.BackgroundColor3 = config.BackgroundColor
    Main.BackgroundTransparency = 0.25
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Thickness = 1
    Stroke.Color = config.AccentColor

    local Blur = Instance.new("BlurEffect")
    Blur.Size = 12
    Blur.Parent = game:GetService("Lighting")

    local UIScale = Instance.new("UIScale")
    UIScale.Scale = config.Scale or 1
    UIScale.Parent = Main

    -- Draggable
    local dragging, dragStart, startPos

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)

    Main.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    Main.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 150, 1, 0)
    Sidebar.BackgroundColor3 = config.SidebarColor
    Sidebar.BackgroundTransparency = 0.3
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 14)

    local TabsFolder = Instance.new("Folder")
    TabsFolder.Name = "LavoraTabs"
    TabsFolder.Parent = ScreenGui

    return {
        Gui = ScreenGui,
        Main = Main,
        Sidebar = Sidebar,
        TabsFolder = TabsFolder,
        Stroke = Stroke,
        UIScale = UIScale,
        Config = config,
    }
end

return UI
