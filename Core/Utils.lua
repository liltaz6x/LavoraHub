local HttpService = game:GetService("HttpService")

local Utils = {}

local CONFIG_FILE = "LavoraConfig.json"

function Utils.loadConfig(defaults)
    local ok, data = pcall(function()
        return readfile(CONFIG_FILE)
    end)

    if ok and data then
        local decoded = HttpService:JSONDecode(data)
        for k, v in pairs(defaults) do
            if decoded[k] == nil then
                decoded[k] = v
            end
        end
        return decoded
    end

    return table.clone(defaults)
end

function Utils.saveConfig(cfg)
    local ok, json = pcall(function()
        return HttpService:JSONEncode(cfg)
    end)
    if ok then
        pcall(function()
            writefile(CONFIG_FILE, json)
        end)
    end
end

return Utils
