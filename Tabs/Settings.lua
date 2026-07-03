local Settings = {}

function Settings.build(tab, ui, Rayfield)
    ui.Label(tab, "Settings")

    ui.Toggle(tab, "Anti AFK", false, function(v)
        if v then
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end)
end

return Settings
