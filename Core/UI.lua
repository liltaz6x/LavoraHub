local UI = {}

function UI.create(config)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LavoraHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    ---------------------------------------------------------------------
    -- MAIN FRAME
    ---------------------------------------------------------------------
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

    ---------------------------------------------------------------------
    -- SIDEBAR
    ---------------------------------------------------------------------
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 150, 1, 0)
    Sidebar.BackgroundColor3 = config.SidebarColor
    Sidebar.BackgroundTransparency = 0.3
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 14)

    ---------------------------------------------------------------------
    -- CONTENT FRAME (THIS MUST EXIST)
    ---------------------------------------------------------------------
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -150, 1, -20)
    ContentFrame.Position = UDim2.new(0, 150, 0, 10)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = Main

    ---------------------------------------------------------------------
    -- TABS FOLDER (MUST BE INSIDE CONTENTFRAME)
    ---------------------------------------------------------------------
    local TabsFolder = Instance.new("Folder")
    TabsFolder.Name = "LavoraTabs"
    TabsFolder.Parent = ContentFrame

    ---------------------------------------------------------------------
    -- CLOSE + MINIMIZE
    ---------------------------------------------------------------------
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(1, -34, 0, 6)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
    CloseBtn.Parent = Main

    CloseBtn.MouseButton1Click:Connect(function()
        Main.Visible = false
    end)

    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 28, 0, 28)
    MinBtn.Position = UDim2.new(1, -68, 0, 6)
    MinBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 60)
    MinBtn.Text = "-"
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 18
    MinBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)
    MinBtn.Parent = Main

    MinBtn.MouseButton1Click:Connect(function()
        Main.Visible = false
    end)

    ---------------------------------------------------------------------
    -- KEYBIND
    ---------------------------------------------------------------------
    local UIS = game:GetService("UserInputService")
    local currentKey = config.OpenKey or Enum.KeyCode.K

    UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == currentKey then
            Main.Visible = not Main.Visible
        end
    end)

    return {
        Gui = ScreenGui,
        Main = Main,
        Sidebar = Sidebar,
        ContentFrame = ContentFrame,
        TabsFolder = TabsFolder,
        Stroke = Stroke,
        Config = config,
        SetKeybind = function(newKey)
            currentKey = newKey
            config.OpenKey = newKey
        end,
    }
end

return UI
