-- Lavora Hub Loader

local function requireFromGit(path)
    local url = "https://raw.githubusercontent.com/liltaz6x/LavoraHub/main/" .. path
    return loadstring(game:HttpGet(url))()
end

return requireFromGit("Core/Init.lua")
