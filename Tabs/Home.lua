local Home = {}

function Home.build(tab, ui, config)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 32)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = config.TextColor
    Title.Text = "Lavora Hub"
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = tab

    local Sub = Instance.new("TextLabel")
    Sub.Size = UDim2.new(1, -20, 0, 24)
    Sub.Position = UDim2.new(0, 10, 0, 45)
    Sub.BackgroundTransparency = 1
    Sub.Font = Enum.Font.Gotham
    Sub.TextSize = 14
    Sub.TextColor3 = Color3.fromRGB(180, 180, 190)
    Sub.Text = "Modular, manual UI, built by Taz."
    Sub.TextXAlignment = Enum.TextXAlignment.Left
    Sub.Parent = tab
end

return Home
