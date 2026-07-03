local Home = {}

function Home.build(tab, ui, Rayfield)
    ui.Label(tab, "Welcome to Lavora Hub")

    ui.Button(tab, "Copy Discord Invite", function()
        setclipboard("https://discord.gg/yourserver")
    end)

    ui.Label(tab, "Hub Version: "..(_G.LavoraHubVersion or "unknown"))
end

return Home
