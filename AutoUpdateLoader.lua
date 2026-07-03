--// LavoraHub Auto-Update Loader
local REPO = "liltaz6x/LavoraHub"
local BRANCH = "main"

local function fetch(path)
    local url = "https://raw.githubusercontent.com/"..REPO.."/"..BRANCH.."/"..path
    return game:HttpGet(url)
end

local function safeLoad(path)
    local ok, result = pcall(function()
        return fetch(path)
    end)

    if not ok then
        warn("[LavoraHub] Failed to fetch "..path..": "..tostring(result))
        return nil
    end

    return result
end

local versionData = safeLoad("version.txt")
local localVersion = _G.LavoraHubVersion or "0.0.0"
local remoteVersion = versionData or localVersion

local function isNewer(remote, local)
    local r1,r2,r3 = remote:match("(%d+)%.(%d+)%.(%d+)")
    local l1,l2,l3 = local:match("(%d+)%.(%d+)%.(%d+)")

    r1,r2,r3 = tonumber(r1), tonumber(r2), tonumber(r3)
    l1,l2,l3 = tonumber(l1), tonumber(l2), tonumber(l3)

    if r1 > l1 then return true end
    if r1 < l1 then return false end
    if r2 > l2 then return true end
    if r2 < l2 then return false end
    if r3 > l3 then return true end
    return false
end

if isNewer(remoteVersion, localVersion) then
    print("[LavoraHub] Updating from "..localVersion.." to "..remoteVersion)
    _G.LavoraHubVersion = remoteVersion
else
    print("[LavoraHub] Already up to date (v"..localVersion..")")
end

local main = safeLoad("MainLoader.lua")
if not main then
    warn("[LavoraHub] MainLoader failed to load. Retrying...")
    main = safeLoad("MainLoader.lua")
end

if main then
    loadstring(main)()
else
    warn("[LavoraHub] CRITICAL ERROR: Could not load LavoraHub.")
end
