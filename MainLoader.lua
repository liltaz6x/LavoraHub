local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local CoreInit = require(script.Core.Init)
local GamesFolder = script.Games

local GAME_ID = game.PlaceId

local function detectGame()
    for _, module in ipairs(GamesFolder:GetChildren()) do
        if module:IsA("ModuleScript") then
            local gameModule = require(module)
            if gameModule.GameId == GAME_ID then
                return gameModule
            end
        end
    end
    return nil
end

local SelectedGame = detectGame()

CoreInit.start(Rayfield, SelectedGame)
