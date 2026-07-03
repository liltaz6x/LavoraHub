local UI = {}

function UI.Toggle(tab, name, default, callback)
    return tab:CreateToggle({
        Name = name,
        CurrentValue = default or false,
        Callback = function(value)
            if callback then
                callback(value)
            end
        end
    })
end

function UI.Button(tab, name, callback)
    return tab:CreateButton({
        Name = name,
        Callback = function()
            if callback then
                callback()
            end
        end
    })
end

function UI.Label(tab, text)
    return tab:CreateSection(text)
end

return UI
