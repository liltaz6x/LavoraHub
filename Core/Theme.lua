local Theme = {}

function Theme.getTheme(Rayfield)
    if Rayfield and Rayfield.Themes then
        return Rayfield.Themes.Dark
    end
    return "Default"
end

return Theme
