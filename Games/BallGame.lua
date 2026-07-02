-- Ball Game module: auto dropper + auto upgrader

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local GetUpgradeTreeFunc = ReplicatedStorage:WaitForChild("GetUpgradeTreeFunc")
local PurchaseUpgradeEvent = ReplicatedStorage:WaitForChild("PurchaseUpgradeEvent")
local UpgradeDefs = require(ReplicatedStorage:WaitForChild("UpgradeDefs"))

local autoDrop = true
local autoUpgrade = true

-- Auto dropper
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

-- Auto upgrader
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
