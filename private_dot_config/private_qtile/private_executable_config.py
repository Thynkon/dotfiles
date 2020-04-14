##### IMPORTS #####

import os
import re
import socket
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer

##### DEFINING SOME WINDOW FUNCTIONS #####

@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

##### LAUNCH APPS IN SPECIFIED GROUPS #####

def app_or_group(group, app):
    def f(qtile):
        if qtile.groupMap[group].windows:
            qtile.groupMap[group].cmd_toscreen()
        else:
            qtile.groupMap[group].cmd_toscreen()
            qtile.cmd_spawn(app)
    return f

##### KEYBINDINGS #####

def init_keys():
    keys = [
        Key(
            [mod], "Return",
            lazy.spawn(terminal)                      # Open terminal
        ),
        Key(
            [mod], "Tab",
            lazy.next_layout()                      # Toggle through layouts
        ),
        Key(
            [mod], "c",
            lazy.window.kill()                      # Kill active window
        ),
        Key(
            [mod, "shift"], "r",
            lazy.restart()                          # Restart Qtile
        ),
        Key(
            [mod, "shift"], "q",
            lazy.shutdown()                         # Shutdown Qtile
        ),
        Key(
            [mod], "w",
            lazy.to_screen(2)                       # Keyboard focus screen(0)
        ),
        Key(
            [mod, "control"], "k",
            lazy.layout.section_up()                # Move up a section in treetab
        ),
        Key(
            [mod, "control"], "j",
            lazy.layout.section_down()              # Move down a section in treetab
        ),
        # Window controls
        Key(
            [mod], "j",
            lazy.layout.down()                      # Switch between windows in current stack pane
        ),
        Key(
            [mod], "l",
            lazy.layout.up()                        # Switch between windows in current stack pane
        ),
        Key(
            [mod, "shift"], "k",
            lazy.layout.shuffle_down()              # Move windows down in current stack
        ),
        Key(
            [mod, "shift"], "j",
            lazy.layout.shuffle_up()                # Move windows up in current stack
        ),
        Key(
            [mod, "shift"], "l",
            lazy.layout.grow(),                     # Grow size of current window (XmonadTall)
            lazy.layout.increase_nmaster(),         # Increase number in master pane (Tile)
        ),
        Key(
            [mod, "shift"], "h",
            lazy.layout.shrink(),                   # Shrink size of current window (XmonadTall)
            lazy.layout.decrease_nmaster(),         # Decrease number in master pane (Tile)
        ),
        Key(
            [mod, "shift"], "Left",                 # Move window to workspace to the left
            window_to_prev_group
        ),
        Key(
            [mod, "shift"], "Right",                # Move window to workspace to the right
            window_to_next_group
        ),
        Key(
            [mod], "n",
            lazy.layout.normalize()                 # Restore all windows to default size ratios 
        ),
        Key(
            [mod], "m",
            lazy.layout.maximize()                  # Toggle a window between minimum and maximum sizes
        ),
        Key(
            [mod, "shift"], "KP_Enter",
            lazy.window.toggle_floating()           # Toggle floating
        ),
        Key(
            [mod, "shift"], "space",
            lazy.layout.rotate(),                   # Swap panes of split stack (Stack)
            lazy.layout.flip()                      # Switch which side main pane occupies (XmonadTall)
        ),

        # Focus screen
        Key(
            [mod], "q",
            lazy.to_screen(0)
        ),
        Key(
            [mod], "p",
            lazy.to_screen(1)
        ),

        # Groups
        # Can't use keys like . , à é etc... Fixed in version 0.14.2

        #Key(
        #    [mod], "y",
        #    lazy.prev_group()
        #),
        #Key(
        #    [mod], ".",
        #    lazy.next_group()
        #),

        # Stack controls
        Key(
            [mod], "space",
            lazy.layout.next()                      # Switch window focus to other pane(s) of stack
        ),
        Key(
            [mod, "control"], "Return",
            lazy.layout.toggle_split()              # Toggle between split and unsplit sides of stack
        ),
        # Sound control
        # Reference: https://www.commandlinefu.com/commands/view/24363/pulseaudio-set-the-volume-via-command-line
        Key(
            [], "XF86AudioMute",
            lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        ),
        Key(
            [], "XF86AudioLowerVolume",
            lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
        ),
        Key(
            [], "XF86AudioRaiseVolume",
            lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
        ),

        # GUI Apps
        Key(
            [mod], "b",
            lazy.function(app_or_group("browser", "firefox"))
        ),
        Key(
            [mod, "shift"], "d",
            lazy.function(app_or_group("chat", "Discord"))
        ),
        Key(
            [mod, "shift"], "t",
            lazy.function(app_or_group("chat", "telegram-desktop"))
        ),
        # Network manager
        Key(
            [mod, "shift"], "n",
            lazy.spawn("rwm")
        ),
            
        # Dmenu Run Launcher
        Key(
            [mod], "d",
            lazy.spawn("dmenu_run")
        )]

    return keys

##### BAR COLORS #####

def init_colors():
    return [
        ["#292D3E", "#292D3E"], # panel background
        ["#434758", "#434758"], # background for current screen tab
        ["#ffffff", "#ffffff"], # font color for group names
        ["#f03841", "#f03841"], # layout
        ["#000000", "#000000"], # background for other screen tabs
        ["#AD69AF", "#AD69AF"], # dark green gradiant for other screen tabs
    ]

##### GROUPS #####

def init_group_names():
    return [
        (
            'dev',
            {
                'layout':'monadtall',
                'label': ''
            }
        ),
        (
            'browser',
            {
                'layout':'monadtall',
                'label': ''
            }
        ),
        (
            'file-manager',
            {
                'layout':'monadtall',
                'label': ''
            }
        ),
        (
            'chat',
            {
                'layout':'monadtall',
                'label': ''
            }
        ),
        (
            'docs',
            {
                'layout':'monadtall',
                'label': ''
            }
        )]

def init_groups():
    return [Group(name, **kwargs) for name, kwargs in group_names]

##### LAYOUTS #####

def init_floating_layout():
    return layout.Floating(border_focus="#3B4022")

def init_layout_theme():
    return {
        "border_width": 2,
        "margin": 10,
        "border_focus": "3778f0",
        "border_normal": "1D2330"
    }

def init_border_args():
    return {
        "border_width": 2
    }

def init_layouts():
    return [
        layout.Max(**layout_theme),
        layout.MonadTall(**layout_theme),
        layout.MonadWide(**layout_theme),
        layout.Bsp(**layout_theme),
        layout.TreeTab(
            font = "Ubuntu",
            fontsize = 10,
            sections = ["FIRST", "SECOND"],
            section_fontsize = 11,
            bg_color = "141414",
            active_bg = "90C435",
            active_fg = "000000",
            inactive_bg = "384323",
            inactive_fg = "a0a0a0",
            padding_y = 5,
            section_top = 10,
            panel_width = 320,
            **layout_theme
        ),
        layout.Slice(
            side="left",
            width=192,
            name="gimp",
            role="gimp-toolbox",
            fallback=layout.Slice(
                side="right",
                width=256,
                role="gimp-dock",
                fallback=layout.Stack(
                    num_stacks=1,
                    **border_args
                )
            )
        ),
        #layout.Stack(stacks=2, **layout_theme),
        #layout.Columns(**layout_theme),
        #layout.RatioTile(**layout_theme),
        #layout.VerticalTile(**layout_theme),
        #layout.Tile(shift_windows=True, **layout_theme),
        #layout.Matrix(**layout_theme),
        #layout.Zoomy(**layout_theme),
        layout.Floating(**layout_theme)]

##### WIDGETS #####

def init_widgets_defaults():
    return dict(
        font = "Ubuntu Mono",
        fontsize = 11,
        padding = 2,
        background = colors[2])

def init_widgets_list():
    widgets_list = [
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.WindowName(
            background = colors[0]
        ),
        widget.Volume(
            background = colors[0],
            emoji = True
        ),
        widget.Volume(
            background = colors[0]
        ),
       #widget.Wlan(
       #    interface = subprocess.cal("~/.config/qtile/get-nic.sh")
       #),
        widget.TextBox(
            font = "Ubuntu Bold",
            text = "☵",
            padding = 5,
            foreground = colors[2],
            background = colors[0],
            fontsize = 14
        ),
        widget.CurrentLayout(
            foreground = colors[2],
            background = colors[0],
            padding = 5
        ),
        widget.TextBox(
            font = "FuraMono Nerd",
            text = "",
            foreground = colors[2],
            background = colors[0],
            padding = 5,
            fontsize = 14
        ),
        widget.Sep(
            linewidth = 0,
            padding = 5,
            foreground = colors[0],
            background = colors[0]
        ),
        widget.Clock(
            foreground = colors[2],
            background = colors[0],
            format = "%d %B"
        ),
        widget.TextBox(
            font = "FuraMono Nerd",
            text = "",
            foreground = colors[2],
            background = colors[0],
            padding = 5,
            fontsize = 14
        ),
        widget.Sep(
            linewidth = 0,
            padding = 5,
            foreground = colors[0],
            background = colors[0]
        ),
        widget.Clock(
            foreground = colors[2],
            background = colors[0],
            format = "%H:%M"
        ),
        widget.Sep(
            linewidth = 0,
            padding = 5,
            foreground = colors[0],
            background = colors[0]
        ),
        widget.GroupBox(
            font = "FuraMono Nerd",
            fontsize = 16,
            margin_y = 0,
            margin_x = 0,
            padding_y = 5,
            padding_x = 5,
            borderwidth = 1,
            spacing = 4,
            active = colors[2],
            inactive = colors[2],
            rounded = False,
            highlight_method = "block",
            this_current_screen_border = colors[1],
            this_screen_border = colors [4],
            other_current_screen_border = colors[0],
            other_screen_border = colors[0],
            foreground = colors[2],
            background = colors[0]
        ),
        widget.Spacer(
        ),
        widget.Net(
            interface = "enp4s0",
            foreground = colors[2],
            background = colors[0],
            padding = 5,
            update_interval = 1
        ),
        widget.TextBox(
            font = "FuraMono Nerd",
            text = "",
            padding = 5,
            background = colors[0],
            fontsize = 14
        ),
        widget.Memory(
            fmt = '{MemUsed}M',
            update_interval = 1,
            background = colors[0]
        ),
        widget.TextBox(
            font = "FuraMono Nerd",
            text = "",
            foreground = colors[2],
            background = colors[0],
            padding = 5,
            fontsize = 14
        ),
        widget.ThermalSensor(
            foreground = colors[2],
            background = colors[0],
        ),
        widget.Sep(
            linewidth = 0,
            padding = 5,
            foreground = colors[0],
            background = colors[0]
        )]

    return widgets_list

##### SCREENS #####

def init_widgets_top():
    widgets_top = [
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.WindowName(
            background = colors[0]
        ),
        widget.Volume(
            background = colors[0],
            emoji = True
        ),
        widget.Volume(
            background = colors[0]
        ),
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors[2],
            background = colors[0]
        ),
        #widget.Wlan(
        #    interface = subprocess.cal("~/.config/qtile/get-nic.sh")
        #),
        widget.TextBox(
            font = "Ubuntu Bold",
            text = "☵",
            padding = 5,
            foreground = colors[2],
            background = colors[0],
            fontsize = 14
        ),
        widget.CurrentLayout(
            foreground = colors[2],
            background = colors[0],
            padding = 5
        ),
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.TextBox(
            font = "FuraMono Nerd",
            text = "",
            foreground = colors[2],
            background = colors[0],
            padding = 5,
            fontsize = 14
        ),
        widget.Clock(
            foreground = colors[2],
            background = colors[0],
            format = "%d %B"
        ),
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.TextBox(
            font = "FuraMono Nerd",
            text = "",
            foreground = colors[2],
            background = colors[0],
            padding = 5,
            fontsize = 14
        ),
        widget.Clock(
            foreground = colors[2],
            background = colors[0],
            format = "%H:%M"
        ),
        widget.Sep(
            linewidth = 0,
            padding = 5,
            foreground = colors[0],
            background = colors[0]
        )]
    return widgets_top                       # Slicing removes unwanted widgets on Monitors 1,3

def init_widgets_bottom():
    widgets_bottom = [
        widget.GroupBox(
            font="FuraMono Nerd",
            fontsize = 16,
            margin_y = 0,
            margin_x = 0,
            padding_y = 5,
            padding_x = 5,
            borderwidth = 1,
            spacing = 4,
            active = colors[2],
            inactive = colors[2],
            rounded = False,
            highlight_method = "block",
            this_current_screen_border = colors[1],
            this_screen_border = colors [4],
            other_current_screen_border = colors[0],
            other_screen_border = colors[0],
            foreground = colors[2],
            background = colors[0]
        ),
        widget.Spacer(
        ),
        widget.TextBox(
            font = "FuraMono Nerd",
            text = "",
            padding = 5,
            background = colors[0],
            fontsize = 14
        ),
        widget.Memory(
            fmt = '{MemUsed}M',
            update_interval = 1,
            background = colors[0]
        ),
        widget.TextBox(
            font = "FuraMono Nerd",
            text = "",
            foreground = colors[2],
            background = colors[0],
            padding = 5,
            fontsize = 14
        ),
        widget.ThermalSensor(
            foreground = colors[2],
            background = colors[0],
        ),
        widget.Sep(
            linewidth = 0,
            padding = 5,
            foreground = colors[0],
            background = colors[0]
        )]
    return widgets_bottom

### SCREENS ###

def init_screens():
    return [
            Screen(
                top = bar.Bar(
                        widgets = init_widgets_top(),
                        opacity = 0.95,
                        size    = 20
                    ),
                bottom = bar.Bar(
                        widgets = init_widgets_bottom(),
                        opacity = 0.95,
                        size    = 30,
                        background = colors[0]
                    )
                ),
            Screen(
                top = bar.Bar(
                        widgets = init_widgets_top(),
                        opacity = 0.95,
                        size    = 20
                    ),
                bottom = bar.Bar(
                        widgets = init_widgets_bottom(),
                        opacity = 0.95,
                        size    = 30,
                        background = colors[0]
                    )
                )
            ]

##### FLOATING WINDOWS #####

@hook.subscribe.client_new
def floating(window):
    floating_types = ['notification', 'toolbar', 'splash', 'dialog']
    transient = window.window.get_wm_transient_for()
    if window.window.get_wm_type() in floating_types or transient:
        window.floating = True

def init_mouse():
    return [
            Drag(
                [mod],
                "Button1",
                lazy.window.set_position_floating(),      # Move floating windows
                start = lazy.window.get_position()
            ),
            Drag(
                [mod],
                "Button3",
                lazy.window.set_size_floating(),          # Resize floating windows
                start=lazy.window.get_size()
            ),
            Click(
                [mod, "shift"],
                "Button1",
                lazy.window.bring_to_front()
            )]  # Bring floating window to front

##### DEFINING A FEW THINGS #####

if __name__ in ["config", "__main__"]:
    mod                     = "mod1"                                            # Sets mod key to ALT
    terminal                = "konsole"                                      # My terminal of choice
    home                    = os.path.expanduser('~')
    config                  = home + ".config/qtile/config.py"    # Qtile config file location 

    colors                  = init_colors()
    keys                    = init_keys()
    mouse                   = init_mouse()
    group_names             = init_group_names()
    groups                  = init_groups()
    floating_layout         = init_floating_layout()
    layout_theme            = init_layout_theme()
    border_args             = init_border_args()
    layouts                 = init_layouts()
    screens                 = init_screens()
    widget_defaults         = init_widgets_defaults()
    widgets_list            = init_widgets_list()
    widgets_top             = init_widgets_top()
    widgets_bottom          = init_widgets_bottom()

##### SETS GROUPS KEYBINDINGS #####

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))          # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))   # Send current window to another group

##### STARTUP APPLICATIONS #####

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

##### NEEDED FOR SOME JAVA APPS #####

#wmname = "LG3D"
wmname = "qtile"
