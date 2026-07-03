local BallGame = {}

function BallGame.build(tab, ui, config)
    ui.Label(tab, "Ball Game Automation")

    ui.Toggle(tab, "Auto Click Ball", false, function(enabled)
        if enabled then
            task.spawn(function()
                while enabled and _G.LavoraRunning do
                    pcall(function()
                        local ball = workspace:FindFirstChild("Ball")
                        if ball then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, ball, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, ball, 1)
                        end
                    end)
                    task.wait(0.05)
                end
            end)
        end
    end)
end

return BallGame
