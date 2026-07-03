local Home = {}

function Home.build(tab, ui, Rayfield)
    ui.Label(tab, "Welcome to Lavora Hub")
    ui.Button(tab, "Discord / Info", function()
        setclipboard("https://discord.gg/yourserver")
    end)
end

return Home
