
local themes = {
  "no-wibar",
  "holo",
  "theme8",
  "doom-one"
}

local settings = {
        modkey = "Mod1",
        superkey = "Mod4",
        ctrlkey = "Control",

        -- personal variables
        --change these variables if you want
        browser = "firefox-devedition",
        editorgui = "codium",
        filemanager = "thunar",
        mailclient = "thunderbird",
        imageeditor = "gimp",
        terminal = "alacritty",
        virtualmachine = "virtualbox",
        screenshotutility = "flameshot gui",
        desktopenvironment = "XFCE",
        volume_step = 5,
        brightness_step = 10,
        bar = "wibar",
        rofi_config = string.format("%s/.config/rofi", os.getenv("HOME")),
        theme = themes[3],
}

return settings
