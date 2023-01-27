# -*- coding: utf-8 -*-
import os
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen, ScratchPad, DropDown
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List  # noqa: F401

mod = "mod4"              # Sets mod key to SUPER/WINDOWS
alt = "mod1"
myTerm = "alacritty"      # My terminal of choice
myBrowser = "qutebrowser" # My browser of choice

# @lazy.function
# def tileall(qtile):
    # for window in qtile.currentGroup.windows:
        # window.disable_floating()

# @lazy.function
# def killall(qtile):
    # for window in qtile.currentGroup.windows:
        # window.kill()

keys = [
#         ### The essentials
#         Key([mod], "Return",
#             lazy.spawn(myTerm),
#             desc='Launches My Terminal'
#             ),
#         Key([mod, "shift"], "Return",
#             lazy.spawn("dmenu_run -i -fn Mononoki-nerd-font -p 'Run: '"),
#             desc='Run Launcher'
#             ),
#         Key([mod], "b",
#             lazy.spawn(myBrowser),
#             desc='Qutebrowser'
#             ),
         Key([mod, "shift"], "r",
             lazy.restart(),
             desc='Restart Qtile'
             ),
         Key([mod, "shift"], "q",
             lazy.shutdown(),
             desc='Shutdown Qtile'
             ),
         Key([mod, "shift"], "c",
             lazy.window.kill(),
             desc='Kill active window'
             ),
         # Key([mod, "shift"], "a",
             # killall,
             # desc='Kill active window'
             # ),
         Key([mod, "shift"], "Tab",
             lazy.prev_layout(),
             desc='Toggle through layouts'
             ),
         Key([mod], "Tab",
             lazy.next_layout(),
             desc='Toggle through layouts'
             ),
#         Key(["control", "shift"], "e",
#             lazy.spawn("emacsclient -c -a emacs"),
#             desc='Doom Emacs'
#             ),
#         ### Switch focus to specific monitor (out of three)
#        #Key([mod], "w",
#        #    lazy.to_screen(0),
#        #    desc='Keyboard focus to monitor 1'
#        #    ),
#        #Key([mod], "e",
#        #    lazy.to_screen(1),
#        #    desc='Keyboard focus to monitor 2'
#        #    ),
#        #Key([mod], "r",
#        #    lazy.to_screen(2),
#        #    desc='Keyboard focus to monitor 3'
#        #    ),
#         ### Switch focus of monitors
#         Key([mod], "period",
#             lazy.next_screen(),
#             desc='Move focus to next monitor'
#             ),
#         Key([mod], "comma",
#             lazy.prev_screen(),
#             desc='Move focus to prev monitor'
#             ),
         ### Treetab controls
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
             lazy.layout.shrink(),
             lazy.layout.decrease_nmaster(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
         Key([mod], "l",
             lazy.layout.grow(),
             lazy.layout.increase_nmaster(),
             desc='Expand window (MonadTall), increase number in master pane (Tile)'
             ),
         Key([mod], "BackSpace",
             lazy.layout.swap_main(),
             desc='Promote focussed window to master'
             ),
         Key([mod, "shift"], "t",
             lazy.layout.reset(),
             desc='Send all windows back to tiling.'
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
         Key([mod, "control"], "Left",
             lazy.screen.prev_group(),
             desc='Move focused window to previous group'
             ),
         Key([mod, "control"], "Right",
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
         Key([alt], "Tab",
             lazy.layout.next(),
             desc='Switch window focus to other pane(s) of stack'
             ),
         Key([alt, "shift"], "space",
             lazy.layout.toggle_split(),
             desc='Toggle between split and unsplit sides of stack'
             ),

#        # hadouken
#         Key([mod], "i",
#             lazy.spawn("invert-color-rs"),
#             desc='Invert colors of the active window.'
#             ),
#         Key([mod], "e",
#             lazy.spawn(myTerm+" -t ranger -e ranger"),
#             desc='Ranger bound to File Manager KB'
#             ),
#         Key(["control"], "space",
#             lazy.spawn("rofi -show run -display-run \"RUN: \""),
#             desc='Launch rofi as App Launcher'
#             ),
#         Key([mod, "shift"], "w",
#             lazy.spawn("rfkill toggle wifi"),
#             desc='Toggle my wifi card'
#             ),
#         Key([mod, "shift"], "b",
#             lazy.spawn("rfkill toggle bluetooth"),
#             desc='Toggle my bluetooth controller'
#             ),
#         Key([mod, "shift"], "l",
#             lazy.spawn("slock"),
#             desc='Lock Screen'
#             ),
#         Key([mod, "shift"], "s",
#             lazy.spawn("narrator $(xsel)"),
#             desc='Speak what\'s selected'
#             ),
#         Key([alt], "Tab",
#             lazy.spawn("rofi -show window"),
#             desc='rofi shows open windows'
#             ),
#         Key([alt, "control"], "s",
#             lazy.spawn("shutdown now"),
#             desc='Simple shutdown KB'
#             ),
#         Key([mod, "shift"], "x",
#             lazy.spawn("echo 'cycle pause' | socat - ~/.cache/dmsounds-ipc"),
#             desc='Toggle pause for dm-music and yt-music'
#             ),
#         Key([mod, "shift"], "comma",
#             lazy.spawn("echo '{ \"command\": [ \"seek\", \"-10\" ] }' | socat - ~/.cache/dmsounds-ipc > /dev/null 2>&1"),
#             desc='Seek backwards 10 seconds in dm-music and yt-music'
#             ),
#         Key([mod, "shift"], "period",
#             lazy.spawn("echo '{ \"command\": [ \"seek\", \"+10\" ] }' | socat - ~/.cache/dmsounds-ipc > /dev/null 2>&1"),
#             desc='Seek forwards 10 seconds in dm-music and yt-music'
#             ),
#         Key([mod], "r",
#             lazy.spawn("killall redshift || redshift &"),
#             desc='Toggle redshift color'
#             ),
#         Key([mod], "n",
#             lazy.spawn(myTerm+" -t neomutt -e neomutt"),
#             desc='Launch neomutt mail client'
#             ),
#         Key([mod], "x",
#             lazy.spawn(myTerm+" -t irc -e cp442.5 BichtX"),
#             desc='Launch BitchX irc client'
#             ),
#         Key([mod], "d",
#             lazy.spawn(myTerm+"/bin/bash -c \"xdotool keyup d super && xdotool key Down && xdotool keyup super\""),
#             desc='Using xdotool hack for Down key'
#             ),
#         Key(["control"], "m",
#             lazy.spawn("mictoggle"),
#             desc='Toggle my mic Mute/Unmute state'
#             ),
#         Key([mod], "Escape",
#             lazy.spawn("xkill"),
#             desc='Spawn the xkill cursor to kill a window'
#             ),
#
#
#         # Emacs programs launched using the key chord CTRL+e followed by 'key'
#         KeyChord(["control"],"e", [
#             Key([], "e",
#                 lazy.spawn("emacsclient -c -a 'emacs'"),
#                 desc='Launch Emacs'
#                 ),
#             Key([], "b",
#                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(ibuffer)'"),
#                 desc='Launch ibuffer inside Emacs'
#                 ),
#             Key([], "d",
#                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(dired nil)'"),
#                 desc='Launch dired inside Emacs'
#                 ),
#             Key([], "i",
#                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(erc)'"),
#                 desc='Launch erc inside Emacs'
#                 ),
#             Key([], "m",
#                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(mu4e)'"),
#                 desc='Launch mu4e inside Emacs'
#                 ),
#             Key([], "n",
#                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(elfeed)'"),
#                 desc='Launch elfeed inside Emacs'
#                 ),
#             Key([], "s",
#                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(eshell)'"),
#                 desc='Launch the eshell inside Emacs'
#                 ),
#             Key([], "v",
#                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'"),
#                 desc='Launch vterm inside Emacs'
#                 )
#         ]),
#         # Dmenu scripts launched using the key chord SUPER+p followed by 'key'
#         KeyChord([mod], "p", [
#             Key([], "e",
#                 lazy.spawn("/usr/bin/dm-emoji"),
#                 desc='Choose a config file to edit'
#                 ),
#             Key([], "i",
#                 lazy.spawn("/usr/bin/dm-ip"),
#                 desc='Take screenshots via dmenu'
#                 ),
#             Key([], "k",
#                 lazy.spawn("/usr/bin/dm-kill"),
#                 desc='Kill processes via dmenu'
#                 ),
#             Key([], "l",
#                 lazy.spawn("/usr/bin/dm-logout"),
#                 desc='A logout menu'
#                 ),
#             Key([], "m",
#                 lazy.spawn("/usr/bin/dm-music"),
#                 desc='Search manpages in dmenu'
#                 ),
#             Key([], "o",
#                 lazy.spawn("/usr/bin/dm-bookman"),
#                 desc='Search your qutebrowser bookmarks and quickmarks'
#                 ),
#             Key([], "r",
#                 lazy.spawn("/usr/bin/dm-reddit"),
#                 desc='Search reddit via dmenu'
#                 ),
#             Key([], "s",
#                 lazy.spawn("/usr/bin/dm-websearch"),
#                 desc='Search various search engines via dmenu'
#                 ),
#             Key([], "t",
#                 lazy.spawn("/usr/bin/dm-translate"),
#                 desc='Search various search engines via dmenu'
#                 ),
#             Key([], "p",
#                 lazy.spawn("passmenu -fn Mononoki-nerd-font"),
#                 desc='Retrieve passwords with dmenu'
#                 )
#         ])
]

groups = []
group_names = ["DEV", "WWW", "SYS","DOC","PROG","CHAT","MUS","VID","GFX"]

group_labels = ["", "", "", "", "", "", "", "", ""]
#group_labels = ["", "", "", "龎", "", "", "", "", ""]
#group_labels = [" ", "爵 ", " ", "ﴬ", "", "", "", "", ""]

group_layouts = ['monadtall','monadtall','monadtall','monadtall','monadtall','monadtall','monadtall','monadtall','monadtall']
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
    groups.append(Group(name=group_names[i], label=group_labels[i], layout=group_layouts[i], matches=group_matches[i]))

groups.append(ScratchPad("scr", [
    DropDown("Quake", "alacritty -t Scratchpad",
            x=0.35, y=0.05, width=0.60, height=0.60, opacity=0.9,
            on_focus_lost_hide=False),
    DropDown("Countdown", "alacritty -t Timer",
            x=0.68, y=0.03, width=0.30, height=0.27, opacity=0.8,
            on_focus_lost_hide=False),
    ]))

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "#e1acff",
                "border_normal": "#1D2330"
                }

layouts = [
    #layout.Stack(stacks=2, **layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    layout.MonadTall(border_width=2, margin=12, border_focus="#e1acff", border_normal="#5e4451"),
    layout.VerticalTile(border_width=2, margin=4, border_focus="#e1acff", border_normal="#5e4451"),
    #layout.MonadWide(**layout_theme),
    layout.Zoomy(**layout_theme, columnwidth=450),
    layout.Bsp(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.Stack(num_stacks=2),
    #layout.RatioTile(**layout_theme),
    # layout.Columns(**layout_theme),
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
    layout.Max(**layout_theme),
]

colors = [["#282c34", "#282c34"],
          ["#1c1f24", "#1c1f24"],
          ["#dfdfdf", "#dfdfdf"],
          ["#ff6c6b", "#ff6c6b"],
          ["#98be65", "#98be65"],
          ["#da8548", "#da8548"],
          ["#51afef", "#51afef"],
          ["#c678dd", "#c678dd"],
          ["#46d9ff", "#46d9ff"],
          ["#a9a1e1", "#a9a1e1"],
          ["#ebf85b", "#ebf85b"]]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Ubuntu Bold",
    fontsize = 12,
    padding = 2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    arrow_padding = -6
    arrow_size = 47

    widgets_list = [
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.Image(
                       filename = "~/.config/qtile/icons/python.png",
                       scale = "False",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm)}
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.GroupBox(
                       font = "Font Awesome 6 Free Solid",
                       fontsize = 16,
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 3,
                       padding_x = 3,
                       borderwidth = 3,
                       # active = "#6cffff",
                       inactive = "#5F6F66",
                       active = colors[7],
                       rounded = False,
                       highlight_color = colors[1],
                       highlight_method = "line",
                       this_current_screen_border = colors[6],
                       this_screen_border = colors[4],
                       other_current_screen_border = colors[6],
                       other_screen_border = colors[4],
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.TextBox(
                       text = ' | ',
                       font = "Ubuntu Mono",
                       background = colors[0],
                       foreground = '808080',
                       padding = -1,
                       fontsize = 14
                       ),
              widget.CurrentLayoutIcon(
                       custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                       foreground = colors[2],
                       background = colors[0],
                       padding = 0,
                       scale = 0.7
                       ),
              widget.CurrentLayout(
                       foreground = colors[2],
                       background = colors[0],
                       padding = 5
                       ),
              widget.TextBox(
                       text = '|',
                       font = "Ubuntu Mono",
                       background = colors[0],
                       foreground = '808080',
                       padding = 2,
                       fontsize = 14
                       ),
              widget.WindowCount(
                       font = "Ubuntu Mono",
                       background = colors[0],
                       foreground = '808080',
                       fontsize = 14,
                       fmt = "{} |"
                       ),
              widget.Systray(
                       background = colors[0],
                       padding = 0
                       ),
              widget.TextBox(
                       text = '|',
                       font = "Ubuntu Mono",
                       background = colors[0],
                       foreground = '808080',
                       padding = 2,
                       fontsize = 14
                       ),
              widget.WindowName(
                       foreground = colors[6],
                       background = colors[0],
                       padding = 0
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 3,
                       foreground = colors[0],
                       background = colors[0]
                       ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[0],
                       foreground = colors[3],
                       padding = arrow_padding,
                       fontsize = arrow_size
                       ),
              widget.TextBox(
                       text = '',
                       font = "Font Awesome 5 Free Solid",
                       background = colors[3],
                       foreground = colors[1],
                       padding = 0,
                       fontsize = 24
                       ),
              widget.Net(
                       interface = "wlp3s0",
                       format = '{down}',
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e speedtest-cli')},
                       foreground = colors[1],
                       background = colors[3],
                       update_interval = 3,
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[3],
                       foreground = colors[10],
                       padding = arrow_padding,
                       fontsize = arrow_size
                       ),
              widget.TextBox(
                       text = '',
                       font = "Font Awesome 6 Free Solid",
                       background = colors[10],
                       foreground = colors[1],
                       padding = 0,
                       fontsize = 16
                       ),
              widget.CPU(
                       foreground = colors[1],
                       background = colors[10],
                       format = '{load_percent}%',
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
                       update_interval = 2,
                       padding = 5
                       ),
              widget.TextBox(
                       text='',
                       font = "Ubuntu Mono",
                       background = colors[10],
                       foreground = colors[4],
                       padding = arrow_padding,
                       fontsize = arrow_size
                       ),
              widget.TextBox(
                       text = '',
                       font = "Font Awesome 6 Free Solid",
                       background = colors[4],
                       foreground = colors[1],
                       padding = 0,
                       fontsize = 16
                       ),
              widget.ThermalSensor(
                       foreground = colors[1],
                       background = colors[4],
                       threshold = 90,
                       update_interval = 5,
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[4],
                       foreground = colors[6],
                       padding = arrow_padding,
                       fontsize = arrow_size
                       ),
              widget.TextBox(
                       text = '',
                       font = "Font Awesome 6 Free Solid",
                       background = colors[6],
                       foreground = colors[1],
                       padding = 0,
                       fontsize = 16
                       ),
              widget.Memory(
                       foreground = colors[1],
                       background = colors[6],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
                       format = '{MemUsed: .0f}{mm}',
                       update_interval = 3,
                       padding = 5
                       ),
              widget.TextBox(
                       text='',
                       font = "Ubuntu Mono",
                       background = colors[6],
                       foreground = colors[5],
                       padding = arrow_padding,
                       fontsize = arrow_size
                       ),
              widget.TextBox(
                       text = '',
                       font = "Font Awesome 6 Free Solid",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -t Updater -e update')},
                       background = colors[5],
                       foreground = colors[1],
                       padding = 0,
                       fontsize = 16
                       ),
              widget.CheckUpdates(
                       update_interval = 1800,
                       distro = "Arch_checkupdates",
                       display_format = " {updates} ",
                       foreground = colors[1],
                       colour_have_updates = colors[1],
                       colour_no_updates = colors[1],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -t Updater -e update')},
                       padding = 3,
                       no_update_string = "None ",
                       background = colors[5]
                       ),
              # widget.TextBox(
                       # text = '',
                       # font = "Source Code Pro",
                       # background = colors[5],
                       # foreground = colors[10],
                       # padding = arrow_padding,
                       # fontsize = arrow_size
                       # ),
              # widget.TextBox(
                       # text = '',
                       # font = "Font Awesome 6 Free Solid",
                       # background = colors[7],
                       # foreground = colors[1],
                       # padding = 0,
                       # fontsize = 16
                       # ),
              # widget.Maildir(
                       # foreground = colors[1],
                       # background = colors[7],
                       # maildir_path='~/.local/share/mail/sharmarahul41928@gmail.com/INBOX/new',
                       # mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -t Mail -e neomutt')},
                       # update_interval = 600,
                       # padding = 5
                       # ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[5],
                       foreground = colors[10],
                       padding = arrow_padding,
                       fontsize = arrow_size
                       ),
              widget.Battery(
                       font = "Font Awesome 6 Free Solid",
                       foreground = colors[1],
                       background = colors[10],
                       charge_char = '',
                       discharge_char = '',
                       full_char = '',
                       empty_char = '',
                       low_percentage = 0.20,
                       format = '{char}',
                       update_interval = 10,
                       fontsize = 16,
                       padding = 5
                       ),
              widget.Battery(
                       foreground = colors[1],
                       background = colors[10],
                       format = '{percent:2.1%}',
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e batinfo')},
                       update_interval = 60,
                       notify_below = 15,
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[10],
                       foreground = colors[8],
                       padding = arrow_padding,
                       fontsize = arrow_size
                       ),
              widget.TextBox(
                       font = "Font Awesome 6 Free Solid",
                       text = '',
                       background = colors[8],
                       foreground = colors[1],
                       padding = 0,
                       fontsize = 16
                       ),
              widget.Backlight(
                       foreground = colors[1],
                       background = colors[8],
                       backlight_name = "intel_backlight",
                       brightness_file = "brightness",
                       max_brightness_file = "max_brightness",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('bash -c "killall redshift || redshift &"')},
                       update_interval = 2,
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       font = "Source Code Pro",
                       background = colors[8],
                       foreground = colors[7],
                       padding = arrow_padding,
                       fontsize = arrow_size
                       ),
              widget.TextBox(
                       text = '',
                       font = "Font Awesome 6 Free Solid",
                       background = colors[7],
                       foreground = colors[1],
                       padding = 0,
                       fontsize = 16
                       ),
              widget.Volume(
                       foreground = colors[1],
                       background = colors[7],
                       update_interval = 1,
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[7],
                       foreground = colors[9],
                       padding = arrow_padding,
                       fontsize = arrow_size
                       ),
              widget.TextBox(
                       text = ' ',
                       font = "Font Awesome 6 Free Solid",
                       background = colors[9],
                       foreground = colors[1],
                       padding = 0,
                       fontsize = 16
                       ),
              widget.Clock(
                       foreground = colors[1],
                       background = colors[9],
                       format = "%H:%M ",
                       ),
              ]
    return widgets_list

# def init_widgets_screen():
    # widgets_screen = init_widgets_list()
    # return widgets_screen

# def init_screen():
    # return [Screen(top=bar.Bar(widgets=init_widgets_screen(), opacity=0.9, size=30)),]

# if __name__ in ["config", "__main__"]:
    # screens = init_screens()
    # widgets_list = init_widgets_list()

def init_widgets_screen():
    widgets_screen = init_widgets_list()
    return widgets_screen

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen(), opacity=0.85, size=24)),]

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

@hook.subscribe.startup
def start():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart/start.sh'])

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart/start_once.sh'])


# @hook.subscribe.client_new
# def grouper(window):
    # try:
        # print('NEW WINDOW! Class: ' + str(window.window.get_wm_class()))
        # if(window.window.get_wm_class()[1] == 'Terminator'):
            # window.togroup('console')
        # elif(window.window.get_wm_class()[1] == 'WikidPad.py'):
            # window.togroup('b')
        # elif(window.window.get_wm_class()[1] == 'Firefox'):
            # window.togroup('www')
        # elif(window.window.get_wm_class()[1] == 'Thunderbird'):
            # window.togroup('mail')
        # elif(window.window.get_wm_class()[1] == 'Vlc'):
            # window.togroup('vlc')
        # elif(window.window.get_wm_class()[1] == 'xfreerdp'):
            # window.togroup('rdp')
    # except:
        # pass # TODO: handle errors. LibreOffice makes qtile crash here

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
