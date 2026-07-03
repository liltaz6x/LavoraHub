local Utils = {}

function Utils.safeSpawn(fn)
    task.spawn(function()
        local ok, err = pcall(fn)
        if not ok then
            warn("[LavoraHub] Error:", err)
        end
    end)
end

function Utils.fullRefreshFlag()
    if _G.LavoraRunning then
        _G.LavoraRunning = false
        task.wait(0.2)
    end
    _G.LavoraRunning = true
end

return Utils
