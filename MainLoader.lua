-- Lavora Hub Loader

local BASE_URL = "https://raw.githubusercontent.com/liltaz6x/LavoraHub/main/"

_G.LavoraRequire = function(path)
    local url = BASE_URL .. path
    return loadstring(game:HttpGet(url))()
end

return _G.LavoraRequire("Core/Init.lua")
