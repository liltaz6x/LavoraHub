local BallGame = {}

function BallGame.build(tab, ui, config)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 32)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = config.TextColor
    Title.Text = "Ball Game"
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = tab

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")

    local GetUpgradeTreeFunc = ReplicatedStorage:WaitForChild("GetUpgradeTreeFunc")
    local PurchaseUpgradeEvent = ReplicatedStorage:WaitForChild("PurchaseUpgradeEvent")
    local UpgradeDefs = require(ReplicatedStorage:WaitForChild("UpgradeDefs"))

    local autoDrop = false
    local autoUpgrade = false

    local DropBtn = Instance.new("TextButton")
    DropBtn.Size = UDim2.new(0, 200, 0, 32)
    DropBtn.Position = UDim2.new(0, 10, 0, 60)
    DropBtn.BackgroundColor3 = config.AccentColor
    DropBtn.Text = "Auto Dropper: OFF"
    DropBtn.Font = Enum.Font.GothamBold
    DropBtn.TextSize = 14
    DropBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
    Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 8)
    DropBtn.Parent = tab

    DropBtn.MouseButton1Click:Connect(function()
        autoDrop = not autoDrop
        DropBtn.Text = autoDrop and "Auto Dropper: ON" or "Auto Dropper: OFF"
    end)

    local UpgradeBtn = Instance.new("TextButton")
    UpgradeBtn.Size = UDim2.new(0, 200, 0, 32)
    UpgradeBtn.Position = UDim2.new(0, 10, 0, 100)
    UpgradeBtn.BackgroundColor3 = config.AccentColor
    UpgradeBtn.Text = "Auto Upgrade: OFF"
    UpgradeBtn.Font = Enum.Font.GothamBold
    UpgradeBtn.TextSize = 14
    UpgradeBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
    Instance.new("UICorner", UpgradeBtn).CornerRadius = UDim.new(0, 8)
    UpgradeBtn.Parent = tab

    UpgradeBtn.MouseButton1Click:Connect(function()
        autoUpgrade = not autoUpgrade
        UpgradeBtn.Text = autoUpgrade and "Auto Upgrade: ON" or "Auto Upgrade: OFF"
    end)

    task.spawn(function()
        local ballsFolder = Workspace:WaitForChild("LocalBalls")
        local targetCFrame = CFrame.new(25.2, 34.25, -50)

        while true do
            if autoDrop then
                for _, ball in ipairs(ballsFolder:GetChildren()) do
                    if ball:IsA("BasePart") then
                        ball.CFrame = targetCFrame
                    elseif ball:IsA("Model") and ball.PrimaryPart then
                        ball:SetPrimaryPartCFrame(targetCFrame)
                    end
                end
            end
            task.wait(0.1)
        end
    end)

    task.spawn(function()
        while true do
            if autoUpgrade then
                local ok, purchased, _, money = pcall(function()
                    return GetUpgradeTreeFunc:InvokeServer()
                end)

                if ok and purchased then
                    for _, upgrade in ipairs(UpgradeDefs.Upgrades) do
                        local id = upgrade.id
                        local cost = upgrade.cost or 0
                        local requires = upgrade.requires

                        local owned = purchased[id] == true
                        local reqMet = (requires == nil) or (purchased[requires] == true)

                        if not owned and reqMet and money >= cost then
                            pcall(function()
                                PurchaseUpgradeEvent:FireServer(id)
                            end)
                        end
                    end
                end
            end

            task.wait(0.3)
        end
    end)
end

return BallGame
