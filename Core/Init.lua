local Theme = _G.LavoraRequire("Core/Theme.lua")
local Utils = _G.LavoraRequire("Core/Utils.lua")
local UI    = _G.LavoraRequire("Core/UI.lua")
local Tabs  = _G.LavoraRequire("Core/Tabs.lua")

local config = Utils.loadConfig(Theme.Default)
local uiState = UI.create(config)

Tabs.init(uiState, config)

return {
    UI = uiState,
    Config = config,
}
