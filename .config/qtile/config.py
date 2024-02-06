# -*- coding: utf-8 -*-
import os
import subprocess
import socket
from typing import List  # noqa: F401

# from libqtile.log_utils import logger
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen, ScratchPad, DropDown, Rule
from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration

import colors

mod = "mod4"                         # Sets mod key to SUPER/WINDOWS
alt = "mod1"
myTerm = os.getenv('MYTERM')         # My terminal emulator of choice
myBrowser = "qutebrowser"            # My browser of choice
myEmacs = os.getenv('MYEMACS') + ' ' # The space at the end is IMPORTANT!

keys = [
        Key([mod], "x",
            lazy.spawncmd(),
            desc="Spawn a command using a prompt widget"
            ),
        Key([mod, "shift"], "r",
            lazy.reload_config(),
            desc='Reload qtile config'
            ),
        Key([mod, "shift"], "q",
            lazy.shutdown(),
            desc='Shutdown Qtile'
            ),
        Key([mod, "shift"], "c",
            lazy.window.kill(),
            desc='Kill active window'
            ),
        Key([mod, "shift"], "Tab",
            lazy.prev_layout(),
            desc='Toggle through layouts'
            ),
        Key([mod], "Tab",
            lazy.next_layout(),
            desc='Toggle through layouts'
            ),
        Key([mod, "shift"], "h",
            lazy.layout.move_left(),
            desc='Move up a section in treetab'
            ),
        Key([mod, "shift"], "l",
            lazy.layout.move_right(),
            desc='Move down a section in treetab'
            ),
        ### Window controls
        Key([mod], "j",
            lazy.layout.down(),
            desc='Move focus down in current stack pane'
            ),
        Key([mod], "k",
            lazy.layout.up(),
            desc='Move focus up in current stack pane'
            ),
        Key([mod, "shift"], "j",
            lazy.layout.shuffle_down(),
            lazy.layout.section_down(),
            desc='Move windows down in current stack'
            ),
        Key([mod, "shift"], "k",
            lazy.layout.shuffle_up(),
            lazy.layout.section_up(),
            desc='Move windows up in current stack'
            ),
        Key([mod], "h",
            lazy.layout.grow_right().when(layout=["bsp", "columns"]),
            lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
            desc="Grow window to the left"
            ),
        Key([mod], "l",
            lazy.layout.grow_left().when(layout=["bsp", "columns"]),
            lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
            desc="Grow window to the left"
            ),
        Key([mod], "BackSpace",
            lazy.layout.swap_main(),
            desc='Promote focussed window to master'
            ),
        Key([mod], "m",
            lazy.layout.maximize(),
            desc='toggle window between minimum and maximum sizes'
            ),
        Key([mod], "f",
            lazy.window.toggle_floating(),
            desc='toggle floating'
            ),
        Key([mod], "space",
            lazy.window.toggle_fullscreen(),
            desc='toggle fullscreen'
            ),
        Key([mod, "shift"], "h",
            lazy.screen.prev_group(),
            desc='Move to the previous group'
            ),
        Key([mod, "shift"], "l",
            lazy.screen.next_group(),
            desc='Move to the next group'
            ),
        Key([mod], "s",
            lazy.screen.toggle_group(),
            desc='Move to last visited group'
            ),
        Key([mod, "shift"], "space",
            lazy.group.setlayout("monadtall"),
            desc='Set layout back to monadtall'
            ),
        ### Scratchpads
        Key ([mod], "a",
            lazy.group["scr"].dropdown_toggle("Countdown"),
            desc='Toggle hiding of the Countdown terminal.'
            ),
        Key (["control", "shift"], "t",
            lazy.group["scr"].dropdown_toggle("Quake"),
            desc='Toggle hiding of the Scratchpad terminal.'
            ),
        ### Stack controls
        Key([mod, "shift"], "i",
            lazy.layout.rotate(),
            lazy.layout.flip(),
            desc='Switch which side main pane occupies (XmonadTall)'
            ),
        Key([alt, "shift"], "space",
            lazy.layout.toggle_split(),
            desc='Toggle between split and unsplit sides of stack'
            )
]

groups = []
group_names = ["DEV", "WWW", "SYS","DOC","PROG","CHAT","MUS","VID","GFX"]

group_labels = [ "一", "二", "三", "四", "五", "六", "七", "八", "九" ]
# group_labels = ["", "", "", "", "", "", "", "", ""]
#group_labels = ["", "", "", "龎", "", "", "", "", ""]
#group_labels = [" ", "爵 ", " ", "ﴬ", "", "", "", "", ""]

group_layouts = ['monadtall'] * 10
group_matches = [None,
            [Match(wm_class=["qutebrowser", "Links", "firefox"])],
            [Match(title=["Updater", "GParted", "BleachBit"])],
            [Match(wm_class=["obsidian", "Com.github.johnfactotum.Foliate", "libreoffice", "libreoffice-writer", "Zathura"])],
            [Match(wm_class=["subl"])],
            [Match(wm_class=["TelegramDesktop"]), Match(title=["irc", "Mail"])],
            None,
            [Match(title=["Picture-in-Picture"]), Match(wm_class=["gl"])],
            [Match(wm_class=["imv", "Gimp", "Sxiv"])],]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            label=group_labels[i],
            layout=group_layouts[i],
            matches=group_matches[i],
        ))

groups.append(ScratchPad("scr", [
    DropDown("Quake", f"{myTerm} -t Scratchpad",
            x=0.35, y=0.05, width=0.60, height=0.60, opacity=0.95,
            on_focus_lost_hide=False),
    DropDown("Countdown", f"{myTerm} -t Timer",
            x=0.68, y=0.03, width=0.30, height=0.27, opacity=0.90,
            on_focus_lost_hide=False),
    ]))

colors = colors.DoomOne

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

# layout_theme = {"border_width": 0,
#                 "margin": 8,
#                 "border_focus": "#e1acff",
#                 "border_normal": "#1D2330",
#                 }

layout_theme = {"border_width": 2,
                "margin": 12,
                "border_focus": colors[7],
                "border_normal": colors[0],
                "single_margin": 0,
                "single_border_width": 0,
                "new_client_position": 'bottom',
                "ratio": 0.57
                }

layouts = [
    # layout.MonadTall(border_width=0, margin=12, border_focus="#e1acff", border_normal="#5e4451", ratio=0.57, new_client_position='bottom', single_border_width=0, single_margin=0),
    layout.MonadTall(**layout_theme),
    # layout.VerticalTile(border_width=0, margin=4, border_focus="#e1acff", border_normal="#5e4451"),
    layout.VerticalTile(**layout_theme),
    #layout.MonadWide(**layout_theme),
    layout.Tile(
         shift_windows=True,
         border_width = 3,
         border_on_single = False,
         border_focus = colors[7],
         border_normal = colors[0],
         margin = 0,
         ratio = 0.35,
         ),
    layout.Max(
         border_width = 0,
         margin = 0,
         ),
    # layout.TreeTab(
         # font = "Ubuntu",
         # fontsize = 10,
         # sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
         # section_fontsize = 10,
         # border_width = 2,
         # bg_color = "1c1f24",
         # active_bg = "c678dd",
         # active_fg = "000000",
         # inactive_bg = "a9a1e1",
         # inactive_fg = "1c1f24",
         # padding_left = 0,
         # padding_x = 0,
         # padding_y = 5,
         # section_top = 10,
         # section_bottom = 20,
         # level_shift = 8,
         # vspace = 3,
         # panel_width = 200
         # ),
]

widget_defaults = dict(
    font="Ubuntu Bold",
    fontsize = 12,
    padding = 0,
    background=colors[0]
)

extension_defaults = widget_defaults.copy()
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Ubuntu Bold",
    fontsize = 12,
    padding = 2,
    background=colors[0]
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    arrow_padding = -1
    arrow_size = 50
    sep_color = '808080'

    widgets_list = [
        widget.Image(
                 filename = "~/.config/qtile/icons/python.png",
                 scale = "False",
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm)}
                 ),
        widget.Prompt(
                 font = "JetBrains Mono Bold",
                 fontsize = 15,
                 foreground = colors[1]
                 ),
        widget.GroupBox(
                 # font = "Font Awesome 6 Free Solid",
                 fontsize = 16,
                 margin_y = 3,
                 margin_x = 0,
                 padding_y = 3,
                 padding_x = 3,
                 borderwidth = 3,
                 active = colors[7],
                 inactive = "#5F6F66",
                 # inactive = colors[1],
                 rounded = False,
                 highlight_color = colors[0],
                 highlight_method = "line",
                 this_current_screen_border = colors[7],
                 this_screen_border = colors [4],
                 other_current_screen_border = colors[7],
                 other_screen_border = colors[4],
                 ),
        widget.TextBox(
                 text = ' | ',
                 font = "Ubuntu Mono",
                 foreground = sep_color,
                 padding = -1,
                 fontsize = 14
                 ),
        widget.CurrentLayoutIcon(
                 custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                 foreground = colors[1],
                 padding = 4,
                 scale = 0.6
                 ),
        widget.CurrentLayout(
                 foreground = colors[1],
                 padding = 5
                 ),
        widget.TextBox(
                 text = '|',
                 font = "Ubuntu Mono",
                 foreground = sep_color,
                 padding = 2,
                 fontsize = 14
                 ),
        widget.Systray(
                 background = colors[0],
                 padding = 0
                 ),
        widget.TextBox(
                 text = '|',
                 font = "Ubuntu Mono",
                 foreground = sep_color,
                 padding = 2,
                 fontsize = 14
                 ),
        widget.WindowName(
                 font = "JetBrains Mono Bold",
                 fontsize = 15,
                 foreground = colors[6],
                 max_chars = 40
                 ),
        widget.Spacer(length = 8),
        widget.TextBox(
                 text = '',
                 font = "Ubuntu Mono",
                 foreground = colors[3],
                 padding = arrow_padding,
                 fontsize = arrow_size
                 ),
        widget.TextBox(
                 text = '',
                 font = "Font Awesome 6 Free Solid",
                 foreground = colors[0],
                 background = colors[3],
                 padding = 0,
                 fontsize = 16
                 ),
        widget.CPU(
                 font = "JetBrains Mono Bold",
                 fontsize = 14,
                 format = '{load_percent}%',
                 foreground = colors[0],
                 background = colors[3],
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
                 update_interval = 2,
                 padding = 5,
                 ),
        widget.TextBox(
                 text = '',
                 font = "Ubuntu Mono",
                 background = colors[3],
                 foreground = colors[8],
                 padding = arrow_padding,
                 fontsize = arrow_size
                 ),
        widget.TextBox(
                 text = '',
                 font = "Font Awesome 6 Free Solid",
                 foreground = colors[0],
                 background = colors[8],
                 padding = 0,
                 fontsize = 16
                 ),
        widget.Memory(
                 font = "JetBrains Mono Bold",
                 fontsize = 14,
                 foreground = colors[0],
                 background = colors[8],
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
                 format = '{MemUsed: .0f}{mm} ',
                 ),
        widget.TextBox(
                 text='',
                 font = "Ubuntu Mono",
                 background = colors[8],
                 foreground = colors[7],
                 padding = arrow_padding,
                 fontsize = arrow_size
                 ),
        widget.TextBox(
                 text = '',
                 font = "Font Awesome 6 Free Solid",
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -t Updater -e update')},
                 background = colors[7],
                 foreground = colors[0],
                 padding = 2,
                 fontsize = 16
                 ),
        widget.CheckUpdates(
                 font = "JetBrains Mono Bold",
                 fontsize = 14,
                 update_interval = 1800,
                 distro = "Arch_checkupdates",
                 display_format = " {updates} ",
                 foreground = colors[0],
                 colour_have_updates = colors[0],
                 colour_no_updates = colors[0],
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -t Updater -e update')},
                 padding = 3,
                 no_update_string = "None ",
                 background = colors[7]
                 ),
        widget.TextBox(
                 text = '',
                 font = "Ubuntu Mono",
                 background = colors[7],
                 foreground = colors[4],
                 padding = arrow_padding,
                 fontsize = arrow_size
                 ),
        widget.Battery(
                 font = "Font Awesome 6 Free Solid",
                 foreground = colors[0],
                 background = colors[4],
                 charge_char = '',
                 discharge_char = '',
                 full_char = '',
                 empty_char = '',
                 low_percentage = 0.20,
                 format = '{char}',
                 update_interval = 10,
                 fontsize = 16,
                 padding = 0
                 ),
        widget.Battery(
                 font = "JetBrains Mono Bold",
                 fontsize = 14,
                 foreground = colors[0],
                 background = colors[4],
                 format = '{percent:2.1%}',
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e batinfo')},
                 update_interval = 60,
                 notify_below = 15,
                 padding = 5
                 ),
        widget.TextBox(
                 text = '',
                 font = "Ubuntu Mono",
                 background = colors[4],
                 foreground = colors[5],
                 padding = arrow_padding,
                 fontsize = arrow_size
                 ),
        widget.TextBox(
                 font = "Font Awesome 6 Free Solid",
                 text = '',
                 background = colors[5],
                 foreground = colors[0],
                 padding = 0,
                 fontsize = 16
                 ),
        widget.Backlight(
                 font = "JetBrains Mono Bold",
                 fontsize = 14,
                 foreground = colors[0],
                 background = colors[5],
                 backlight_name = "intel_backlight",
                 brightness_file = "brightness",
                 max_brightness_file = "max_brightness",
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('bash -c "killall redshift || redshift &"')},
                 update_interval = 2,
                 padding = 5
                 ),
        widget.TextBox(
                 text = '',
                 font = "Ubuntu Mono",
                 background = colors[5],
                 foreground = colors[6],
                 padding = arrow_padding,
                 fontsize = arrow_size
                 ),
        widget.TextBox(
                 text = ' ',
                 font = "Font Awesome 6 Free Solid",
                 background = colors[6],
                 foreground = colors[0],
                 padding = 0,
                 fontsize = 16
                 ),
        widget.Clock(
                 font = "JetBrains Mono Bold",
                 fontsize = 14,
                 foreground = colors[0],
                 background = colors[6],
                 format = "%H:%M ",
                 ),
        ]
    return widgets_list

def init_widgets_screen():
    widgets_screen = init_widgets_list()
    return widgets_screen

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen(), size=28)),]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(wm_class='dialog'),  # Dialogs stuff
    Match(title='Commands'),
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Qalculate!'),        # qalculate-gtk
    Match(wm_class='kdenlive'),       # kdenlive
    Match(title="pinentry"),          # GPG key password entry
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
    Match(wm_class='file_progress'),
    Match(wm_class='Conky'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='Gimp'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='Yad'),
    Match(wm_class='confirm'),
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

@hook.subscribe.startup
def start():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart/start.sh'])

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart/start_once.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.

# wmname = "LG3D"
wmname = "qtile"
