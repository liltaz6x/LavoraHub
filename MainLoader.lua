-- Lavora Hub Loader (single loadstring entry point)

local BASE_URL = "https://raw.githubusercontent.com/liltaz6x/LavoraHub/main/"

_G.LavoraRequire = function(path)
    local url = BASE_URL .. path
    local src = game:HttpGet(url)
    return loadstring(src)()
end

return _G.LavoraRequire("Core/Init.lua")
