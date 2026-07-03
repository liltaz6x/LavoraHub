local WatchNumbersGoUp = {}

function WatchNumbersGoUp.build(tab, ui, config)
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local player = Players.LocalPlayer

    ---------------------------------------------------------------------
    -- REMOTES
    ---------------------------------------------------------------------
    local BuyUpgrade = ReplicatedStorage.Objects.Remotes.Upgrades.BuyUpgrade

    ---------------------------------------------------------------------
    -- UI
    ---------------------------------------------------------------------
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 32)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = config.TextColor
    Title.Text = "Watch Numbers Go Up"
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = tab

    local Info = Instance.new("TextLabel")
    Info.Size = UDim2.new(1, -20, 0, 24)
    Info.Position = UDim2.new(0, 10, 0, 50)
    Info.BackgroundTransparency = 1
    Info.Font = Enum.Font.Gotham
    Info.TextSize = 16
    Info.TextColor3 = config.TextColor
    Info.TextWrapped = true
    Info.TextXAlignment = Enum.TextXAlignment.Left
    Info.Text = "Auto-upgrades NumMulti platforms by firing BuyUpgrade until CostLabel shows [MAX]."
    Info.Parent = tab

    local AutoBtn = Instance.new("TextButton")
    AutoBtn.Size = UDim2.new(0, 260, 0, 40)
    AutoBtn.Position = UDim2.new(0, 10, 0, 90)
    AutoBtn.BackgroundColor3 = config.AccentColor
    AutoBtn.Text = "Auto Upgrade: OFF"
    AutoBtn.Font = Enum.Font.GothamBold
    AutoBtn.TextSize = 14
    AutoBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
    AutoBtn.TextWrapped = true
    AutoBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0, 8)
    AutoBtn.Parent = tab

    local autoUpgrade = false

    AutoBtn.MouseButton1Click:Connect(function()
        autoUpgrade = not autoUpgrade
        AutoBtn.Text = autoUpgrade and "Auto Upgrade: ON" or "Auto Upgrade: OFF"
    end)

    ---------------------------------------------------------------------
    -- Upgrade model scanning (supports millions of upgrades)
    ---------------------------------------------------------------------
    local function getUpgradeModels()
        local folder = Workspace:FindFirstChild("UpgradeModels")
        if not folder then return {} end

        local list = {}
        for _, m in ipairs(folder:GetChildren()) do
            if m:IsA("Model") and m.Name:match("^NumMulti_%d+$") then
                table.insert(list, m)
            end
        end

        table.sort(list, function(a, b)
            local na = tonumber(a.Name:match("NumMulti_(%d+)")) or 0
            local nb = tonumber(b.Name:match("NumMulti_(%d+)")) or 0
            return na < nb
        end)

        return list
    end

    ---------------------------------------------------------------------
    -- CostLabel finder
    ---------------------------------------------------------------------
    local function getCostLabel(model)
        local display = model:FindFirstChild("Display")
        if not display then return nil end

        local sg = display:FindFirstChildOfClass("SurfaceGui")
        if not sg then sg = display:FindFirstChild("SurfaceGui") end
        if not sg then return nil end

        local frame = sg:FindFirstChild("Frame")
        if not frame then return nil end

        local inner = frame:FindFirstChild("Frame")
        if not inner then return nil end

        local label = inner:FindFirstChild("CostLabel")
        if label and label:IsA("TextLabel") then
            return label
        end

        return nil
    end

    ---------------------------------------------------------------------
    -- Main automation loop (trigger version)
    ---------------------------------------------------------------------
    task.spawn(function()
        while true do
            if autoUpgrade then
                local upgrades = getUpgradeModels()

                for _, model in ipairs(upgrades) do
                    local costLabel = getCostLabel(model)
                    local upgradeId = model.Name

                    if costLabel and costLabel.Text ~= "[MAX]" then
                        -- spam BuyUpgrade until maxed
                        while autoUpgrade and costLabel and costLabel.Text ~= "[MAX]" do
                            BuyUpgrade:FireServer(upgradeId)
                            task.wait(0.15)
                        end
                    end
                end
            end

            task.wait(0.2)
        end
    end)
end

return WatchNumbersGoUp
