local BallGame = {}

BallGame.GameId = 0 -- put the actual PlaceId here

function BallGame.build(tab, ui, Rayfield)
    ui.Label(tab, "Ball Game Automation")

    ui.Toggle(tab, "Auto Touch Ball", false, function(enabled)
        if not enabled then return end

        task.spawn(function()
            while enabled and _G.LavoraRunning do
                pcall(function()
                    local player = game:GetService("Players").LocalPlayer
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local ball = workspace:FindFirstChild("Ball")

                    if hrp and ball then
                        firetouchinterest(hrp, ball, 0)
                        firetouchinterest(hrp, ball, 1)
                    end
                end)
                task.wait(0.05)
            end
        end)
    end)
end

return BallGame
