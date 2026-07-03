local Theme = {}

function Theme.getTheme()
    return Rayfield and Rayfield.Themes.Dark or "Default"
end

return Theme
