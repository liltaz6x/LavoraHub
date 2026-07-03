local Tools = {}

function Tools.build(tab, ui, Rayfield)
    ui.Label(tab, "Tools")

    ui.Button(tab, "Dex Explorer", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex"))()
    end)
end

return Tools
