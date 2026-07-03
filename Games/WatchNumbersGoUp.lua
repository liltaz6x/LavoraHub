local WatchNumbersGoUp = {}

local Utils = require(script.Parent.Parent.Core.Utils)

function WatchNumbersGoUp.build(tab, ui, config)
    Utils.fullRefreshFlag()

    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local SAFE_KEYWORDS = {
        "upgrade","buy","roll","rune","gem","merge","combine","equip",
        "prestige","challenge","currency","rebirth","collect","farm",
        "forge","craft","multiplier","luck","stats"
    }

    local CATEGORY_MAP = {
        upgrades = "Upgrade",
        runes = "Runes",
        gems = "Gems",
        prestige = "Prestige",
        challenges = "Challenges",
        currency = "Currency",
        rebirth = "Rebirth",
        items = "Items",
        farm = "Farm",
        collect = "Collect",
        crafting = "Crafting",
        forging = "Forging",
        multiplier = "Multiplier",
        luck = "Luck",
        stats = "Stats"
    }

    local function scanForRemotes(root)
        local found = {}
        local function scan(obj)
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                    table.insert(found, child)
                end
                scan(child)
            end
        end
        scan(root)
        return found
    end

    local AllRemotes = scanForRemotes(game)

    local function detectCategory(remote)
        local name = remote.Name:lower()
        local folder = remote.Parent and remote.Parent.Name:lower() or ""

        for folderKey, categoryName in pairs(CATEGORY_MAP) do
            if folder:find(folderKey) then
                return categoryName
            end
        end

        for _, keyword in ipairs(SAFE_KEYWORDS) do
            if name:find(keyword) then
                return CATEGORY_MAP[keyword] or keyword
            end
        end

        return nil
    end

    local Categories = {}
    for _, remote in ipairs(AllRemotes) do
        local category = detectCategory(remote)
        if category then
            Categories[category] = Categories[category] or {}
            table.insert(Categories[category], remote)
        end
    end

    ui.Label(tab, "Watch Numbers Go Up — Automation")

    local autoEverything = false
    ui.Toggle(tab, "Auto Everything", false, function(v)
        autoEverything = v
    end)

    local CategoryStates = {}
    for categoryName, remotes in pairs(Categories) do
        CategoryStates[categoryName] = false
        ui.Toggle(tab, "Auto " .. categoryName, false, function(v)
            CategoryStates[categoryName] = v
        end)
    end

    Utils.safeSpawn(function()
        while _G.LavoraRunning do
            for categoryName, remotes in pairs(Categories) do
                if autoEverything or CategoryStates[categoryName] then
                    for _, remote in ipairs(remotes) do
                        if remote:IsA("RemoteEvent") then
                            remote:FireServer()
                        elseif remote:IsA("RemoteFunction") then
                            pcall(function()
                                remote:InvokeServer()
                            end)
                        end
                    end
                end
            end
            task.wait(0.05)
        end
    end)
end

return WatchNumbersGoUp
