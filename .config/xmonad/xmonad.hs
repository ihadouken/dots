    -- Base
import XMonad
import System.Directory
import System.IO (hClose, hPutStr, hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1, copyToAll, killAllOtherCopies) 
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S
import XMonad.Actions.GroupNavigation (nextMatch, Direction(..))

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.WindowSwallowing

    -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import qualified XMonad.Layout.Magnifier as Mag
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.NamedActions
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

import Colors.DoomOne
   -- ColorScheme module (SET ONLY ONE!)
      -- Possible choice are:
      -- DoomOne
      -- Dracula
      -- GruvboxDark
      -- MonokaiPro
      -- Nord
      -- OceanicNext
      -- Palenight
      -- SolarizedDark
      -- SolarizedLight
      -- TomorrowNight

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myBrowser :: String
myBrowser = "qutebrowser --qt-flag ignore-gpu-blocklist --qt-flag enable-gpu-rasterization --qt-flag enable-native-gpu-memory-buffers --qt-flag num-raster-threads=4"  -- Sets qutebrowser as browser

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' "  -- Makes emacs keybindings easier to type

myEditor :: String
--myEditor = "emacsclient -c -a 'emacs' "  -- Sets emacs as editor
myEditor = myTerminal ++ " -e vim "    -- Sets vim as editor

--myRunCommand :: String
--myRunCommand = "dmenu_run -i -l 20 -fn Mononoki-nerd-font -g 3 -X 0 -Y 0 -W 680 -p 'Run: '"
myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows

myNormColor :: String
myNormColor   = colorBack   -- Border color of normal windows

myFocusColor :: String
myFocusColor  = color15   -- Border color of focused windows

mySoundPlayer :: String
mySoundPlayer = "ffplay -nodisp -autoexit " -- The program that will play system sounds

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
    spawn ("killall conky && sleep 2 && conky -c $HOME/.config/conky/xmonad/" ++ colorScheme ++ "-01.conkyrc") -- refresh current conky.
    spawn ("killall trayer && sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 " ++ colorTrayer ++ " --height 22") -- refresh current trayer.

    --spawnOnce "lxsession"
    --spawnOnce "picom"
    --spawnOnce "nm-applet"
    --spawnOnce "volumeicon"
    spawn ("killall sxhkd && sleep 2 && sxhkd &")
    --spawnOnce "~/.local/bin/startup.sh"
    --spawnOnce "xargs xwallpaper --stretch < ~/.cache/wall"
    --spawnOnce "~/.fehbg &"  -- set last saved feh wallpaper
    --spawnOnce "feh --randomize --bg-fill ~/wallpapers/*"  -- feh set random wallpaper
    spawnOnce "nitrogen --restore &"   -- if you prefer nitrogen to feh
    --spawnOnce "xss-lock /usr/bin/slock &"
    --spawnOnce "/usr/bin/emacs --daemon &" -- emacs daemon for the emacsclient
    spawnOnce("conky -c $HOME/.config/conky/xmonad/" ++ colorScheme ++ "-01.conkyrc") -- refresh current conky.
    spawnOnce("trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 " ++ colorTrayer ++ " --height 22") -- refresh current trayer.
    setWMName "LG3D"

myNavigation :: TwoD a (Maybe a)
myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navDefaultHandler
 where navKeyMap = M.fromList [
          ((0,xK_Escape), cancel)
         ,((0,xK_Return), select)
         ,((0,xK_slash) , substringSearch myNavigation)
         ,((0,xK_Left)  , move (-1,0)  >> myNavigation)
         ,((0,xK_h)     , move (-1,0)  >> myNavigation)
         ,((0,xK_Right) , move (1,0)   >> myNavigation)
         ,((0,xK_l)     , move (1,0)   >> myNavigation)
         ,((0,xK_Down)  , move (0,1)   >> myNavigation)
         ,((0,xK_j)     , move (0,1)   >> myNavigation)
         ,((0,xK_Up)    , move (0,-1)  >> myNavigation)
         ,((0,xK_k)     , move (0,-1)  >> myNavigation)
         ,((0,xK_y)     , move (-1,-1) >> myNavigation)
         ,((0,xK_i)     , move (1,-1)  >> myNavigation)
         ,((0,xK_n)     , move (-1,1)  >> myNavigation)
         ,((0,xK_m)     , move (1,-1)  >> myNavigation)
         ,((0,xK_space) , setPos (0,0) >> myNavigation)
         ]
       navDefaultHandler = const myNavigation

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x28,0x2c,0x34) -- lowest inactive bg
                  (0x28,0x2c,0x34) -- highest inactive bg
                  (0xc7,0x92,0xea) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0x28,0x2c,0x34) -- active fg

-- gridSelect menu layout
mygridConfig :: p -> GSConfig Window
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 40
    , gs_navigate     = myNavigation
    , gs_cellwidth    = 200
    , gs_cellpadding  = 6
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFont
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                   { gs_cellheight   = 40
                   , gs_cellwidth    = 180
                   , gs_cellpadding  = 6
                   , gs_originFractX = 0.5
                   , gs_originFractY = 0.5
                   , gs_font         = myFont
                   }

runSelectedAction' :: GSConfig (X ()) -> [(String, X ())] -> X ()
runSelectedAction' conf actions = do
    selectedActionM <- gridselect conf actions
    case selectedActionM of
        Just selectedAction -> selectedAction
        Nothing -> return ()


gsCategories =
  [ ("Games",      "xdotool key super+alt+1")
  , ("Education",  "xdotool key super+alt+2")
  , ("Internet",   "xdotool key super+alt+3")
  , ("Multimedia", "xdotool key super+alt+4")
  , ("Office",     "xdotool key super+alt+5")
  , ("Settings",   "xdotool key super+alt+6")
  , ("System",     "xdotool key super+alt+7")
  , ("Utilities",  "xdotool key super+alt+8")
  ]

gsGames =
  [ ("0 A.D.", "0ad")
  , ("Battle For Wesnoth", "wesnoth")
  , ("OpenArena", "openarena")
  , ("Sauerbraten", "sauerbraten")
  , ("Steam", "steam")
  , ("Unvanquished", "unvanquished")
  , ("Xonotic", "xonotic-glx")
  ]

gsEducation =
  [ ("GCompris", "gcompris-qt")
  , ("Kstars", "kstars")
  , ("Minuet", "minuet")
  , ("Scratch", "scratch")
  ]

gsInternet =
  [ ("Brave", "brave")
  , ("Discord", "discord")
  , ("Element", "element-desktop")
  , ("Firefox", "firefox")
  , ("LBRY App", "lbry")
  , ("Mailspring", "mailspring")
  , ("Nextcloud", "nextcloud")
  , ("Qutebrowser", "qutebrowser")
  , ("Transmission", "transmission-gtk")
  , ("Zoom", "zoom")
  ]

gsMultimedia =
  [ ("Audacity", "audacity")
  , ("Blender", "blender")
  , ("Deadbeef", "deadbeef")
  , ("Kdenlive", "kdenlive")
  , ("OBS Studio", "obs")
  , ("VLC", "vlc")
  ]

gsOffice =
  [ ("Document Viewer", "evince")
  , ("LibreOffice", "libreoffice")
  , ("LO Base", "lobase")
  , ("LO Calc", "localc")
  , ("LO Draw", "lodraw")
  , ("LO Impress", "loimpress")
  , ("LO Math", "lomath")
  , ("LO Writer", "lowriter")
  ]

gsSettings =
  [ ("ARandR", "arandr")
  , ("ArchLinux Tweak Tool", "archlinux-tweak-tool")
  , ("Customize Look and Feel", "lxappearance")
  , ("Firewall Configuration", "sudo gufw")
  ]

gsSystem =
  [ ("Alacritty", "alacritty")
  , ("Bash", (myTerminal ++ " -e bash"))
  , ("Htop", (myTerminal ++ " -e htop"))
  , ("Fish", (myTerminal ++ " -e fish"))
  , ("PCManFM", "pcmanfm")
  , ("VirtualBox", "virtualbox")
  , ("Virt-Manager", "virt-manager")
  , ("Zsh", (myTerminal ++ " -e zsh"))
  ]

gsUtilities =
  [ ("Emacs", "emacs")
  , ("Emacsclient", "emacsclient -c -a 'emacs'")
  , ("Nitrogen", "nitrogen")
  , ("Vim", (myTerminal ++ " -e vim"))
  ]


myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "keyboard" spawnKB findKB manageKB
                , NS "calculator" spawnCalc findCalc manageCalc
                , NS "timer" spawnTimer findTimer manageTimer
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.7
                 w = 0.65
                 t = 0.95 -h
                 l = 0.95 -w
    spawnKB  = "florence"
    findKB   = title =? "florence"
    manageKB = customFloating $ W.RationalRect l t w h
               where
                 h = 0.30
                 w = 0.45
                 t = 0.35 -h
                 l = 0.45 -w
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.75
                 w = 0.55
                 t = 0.75 -h
                 l = 0.70 -w
    spawnTimer  = myTerminal ++ " -t Timer"
    findTimer   = title =? "Timer"
    manageTimer = customFloating $ W.RationalRect l t w h
               where
                 h = 0.27
                 w = 0.30
                 t = 0.33 -h
                 l = 0.98 -w

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ limitWindows 6
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ Mag.magnifier
           $ limitWindows 6
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 8
           $ Full
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20
           $ simplestFloat
grid     = renamed [Replace "grid"]
           $ limitWindows 9
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 8
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 8
           $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 4
           $ limitWindows 4
           $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 4
           $ limitWindows 4
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme
tallAccordion  = renamed [Replace "tallAccordion"]
           $ mySpacing' 4
           $ Accordion
wideAccordion  = renamed [Replace "wideAccordion"]
           $ mySpacing' 4
           $ Mirror Accordion

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = color15
                 , inactiveColor       = color08
                 , activeBorderColor   = color15
                 , inactiveBorderColor = colorBack
                 , activeTextColor     = colorBack
                 , inactiveTextColor   = color16
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

-- The layout hook
myLayoutHook = avoidStruts
               $ mouseResize 
               $ windowArrange
               $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
    where
        myDefaultLayout =     withBorder myBorderWidth tall
                        ||| threeRow
                        ||| magnify
                        ||| grid
                        ||| threeCol
                        ||| noBorders tabs
                        ||| noBorders monocle
                        ||| floats
                        ||| spirals
                        ||| tallAccordion
                        ||| wideAccordion

-- myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
myWorkspaces = [" dev ", " www ", " sys ", " doc ", " prog ", " chat ", " mus ", " vid ", " gfx "]
--myWorkspaces = [" \62601 ", " \64158 ", " \62579 ", " \64812 ", " \63080 ", " \61911 ", " \63619 ", " \61764 ", " \61893 "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces and the names would be very long if using clickable workspaces.
     [ className =? "confirm"         --> doFloat
     , title =? "video0 - mpv" --> doShift ( myWorkspaces !! 0 )
     -- , className =? "firefox" --> sendMessage (windows W.focusDown)
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "Gimp"            --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , className =? "Yad"             --> doCenterFloat
     , className =? "imv"             --> doShift ( myWorkspaces !! 8 )
     , className =? "obsidian"        --> doShift ( myWorkspaces !! 3 )
     , className =? "Florence"         --> doFloat
     , title =? "Oracle VM VirtualBox Manager"  --> doFloat
     , title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 )
     , className =? "Brave-browser"   --> doShift ( myWorkspaces !! 1 )
     , className =? "qutebrowser"   --> doShift ( myWorkspaces !! 1 )
     , className =? "Links" --> doShift ( myWorkspaces !! 1 )
     , className =? "Com.github.johnfactotum.Foliate"   --> doShift ( myWorkspaces !! 3 )
     , className =? "mpv"             --> doShift ( myWorkspaces !! 7 )
     , title =? "GParted"   --> doShift ( myWorkspaces !! 2 )
     , className =? "vlc"   --> doShift ( myWorkspaces !! 7 )
     , className =? "Minitube"   --> doShift ( myWorkspaces !! 7 )
     , className =? "subl"   --> doShift ( myWorkspaces !! 4 )
     , className =? "TelegramDesktop"   --> doShift ( myWorkspaces !! 5 )
   --, className =? ""   --> doShift ( myWorkspaces !! 6 )
     , title =? "libreoffice"   --> doShift ( myWorkspaces !! 3 )
     , className =? "libreoffice-writer"   --> doShift ( myWorkspaces !! 3 )
     , className =? "Zathura"   --> doShift ( myWorkspaces !! 3 )
     , className =? "MuPDF"   --> doShift ( myWorkspaces !! 3 )
     , className =? "Gimp"            --> doShift ( myWorkspaces !! 8 )
     , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )
     , className =? "BleachBit" --> doShift ( myWorkspaces !! 2 )
     , className =? "Sxiv" --> doShift ( myWorkspaces !! 8 )
     --, className =? "Qalculate-gtk" --> doShift  ( myWorkspaces !! 4 )
     , title =? "Picture-in-Picture" --> doShift  ( myWorkspaces !! 7 )
     , title =? "Updater" --> doShift ( myWorkspaces !! 2)
     , title =? "irc" --> doShift ( myWorkspaces !! 5) 
     , title =? "Mail" --> doShift ( myWorkspaces !! 5 )
     , title =? "video0 - mpv" --> doFloat
     --, title =? "ranger" --> doFloat
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     , isFullscreen -->  doFullFloat
     ] <+> namedScratchpadManageHook myScratchPads

subtitle' ::  String -> ((KeyMask, KeySym), NamedAction)
subtitle' x = ((0,0), NamedAction $ map toUpper
                      $ sep ++ "\n-- " ++ x ++ " --\n" ++ sep)
  where
    sep = replicate (6 + length x) '-'

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe $ "yad --text-info --fontname=\"SauceCodePro Nerd Font Mono 12\" --fore=#46d9ff back=#282c36 --center --geometry=800x600 --title \"XMonad keybindings\""
  --hPutStr h (unlines $ showKm x) -- showKM adds ">>" before subtitles
  hPutStr h (unlines $ showKmSimple x) -- showKmSimple doesn't add ">>" to subtitles
  hClose h
  return ()

myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
--(subtitle "Custom Keys":) $ mkNamedKeymap c $
    let subKeys str ks = subtitle' str : mkNamedKeymap c ks in
    subKeys "Xmonad Essentials"
    [ ("M-C-r", addName "Recompile XMonad"       $ spawn "xmonad --recompile")
    , ("M-S-r", addName "Restart XMonad"         $ spawn "xmonad --restart")
    , ("M-S-q", addName "Quit XMonad"            $ io exitSuccess)
    --, ("M-S-<Return>", addName "Run prompt"      $ sequence_ [spawn (mySoundPlayer ++ dmenuSound), spawn "~/.local/bin/dm-run"])
    , ("C-S-t", addName "Scratchpad Terminal" $ spawn "alacritty -t scratchpad") ]

    ^++^ subKeys "Switch to workspace"
    [ ("M-1", addName "Switch to workspace 1"    $ (windows $ W.greedyView $ myWorkspaces !! 0))
    , ("M-2", addName "Switch to workspace 2"    $ (windows $ W.greedyView $ myWorkspaces !! 1))
    , ("M-3", addName "Switch to workspace 3"    $ (windows $ W.greedyView $ myWorkspaces !! 2))
    , ("M-4", addName "Switch to workspace 4"    $ (windows $ W.greedyView $ myWorkspaces !! 3))
    , ("M-5", addName "Switch to workspace 5"    $ (windows $ W.greedyView $ myWorkspaces !! 4))
    , ("M-6", addName "Switch to workspace 6"    $ (windows $ W.greedyView $ myWorkspaces !! 5))
    , ("M-7", addName "Switch to workspace 7"    $ (windows $ W.greedyView $ myWorkspaces !! 6))
    , ("M-8", addName "Switch to workspace 8"    $ (windows $ W.greedyView $ myWorkspaces !! 7))
    , ("M-9", addName "Switch to workspace 9"    $ (windows $ W.greedyView $ myWorkspaces !! 8))]

    ^++^ subKeys "Send window to workspace"
    [ ("M-S-1", addName "Send to workspace 1"    $ (windows $ W.shift $ myWorkspaces !! 0))
    , ("M-S-2", addName "Send to workspace 2"    $ (windows $ W.shift $ myWorkspaces !! 1))
    , ("M-S-3", addName "Send to workspace 3"    $ (windows $ W.shift $ myWorkspaces !! 2))
    , ("M-S-4", addName "Send to workspace 4"    $ (windows $ W.shift $ myWorkspaces !! 3))
    , ("M-S-5", addName "Send to workspace 5"    $ (windows $ W.shift $ myWorkspaces !! 4))
    , ("M-S-6", addName "Send to workspace 6"    $ (windows $ W.shift $ myWorkspaces !! 5))
    , ("M-S-7", addName "Send to workspace 7"    $ (windows $ W.shift $ myWorkspaces !! 6))
    , ("M-S-8", addName "Send to workspace 8"    $ (windows $ W.shift $ myWorkspaces !! 7))
    , ("M-S-9", addName "Send to workspace 9"    $ (windows $ W.shift $ myWorkspaces !! 8))]


    ^++^ subKeys "Killing Windows"
    [ ("M-S-c", addName "Kill focused window"    $ kill1)
    , ("M-S-a", addName "Kill all windows on WS" $ killAll)
    , ("M-s r", addName "Kill all copies of a window" $ killAllOtherCopies)]

    ^++^ subKeys "Move window to WS and go there"
    [ ("M-.", addName "Switch focus to next monitor" $ nextScreen)
    , ("M-,", addName "Switch focus to prev monitor" $ prevScreen)
    , ("M-S-<Right>", addName "Shifts focused window to next ws" $ shiftTo Next nonNSP >> moveTo Next nonNSP)       
    , ("M-S-<Left>", addName "Shifts focused window to prev ws" $ shiftTo Prev nonNSP >> moveTo Prev nonNSP)
    , ("M-C-<Right>", addName "Shifts focused window to next ws" $ moveTo Next nonNSP)
    , ("M-C-<Left>", addName "Shifts focused window to prev ws" $ moveTo Prev nonNSP) ]

    ^++^ subKeys "Window navigation"
    [ ("M-j", addName "Move focus to next window"                $ windows W.focusDown)
    , ("M-k", addName "Move focus to prev window"                $ windows W.focusUp)
    , ("M-s s", addName "Copy a window to all ws"                $ windows copyToAll)
    , ("M-M1-r", addName "Refresh xmonad"                        $ refresh)
    , ("M-m", addName "Move focus to master window"              $ windows W.focusMaster)
    , ("M-S-j", addName "Swap focused window with next window"   $ windows W.swapDown)
    , ("M-S-k", addName "Swap focused window with prev window"   $ windows W.swapUp)
    , ("M-S-m", addName "Swap focused window with master window" $ windows W.swapMaster)
    , ("M-<Backspace>", addName "Move focused window to master"  $ promote)
    , ("M-S-[", addName "Rotate all windows except master"       $ rotAllDown)
    , ("M-S-]", addName "Rotate all windows current stack"       $ rotAllDown)
    , ("M1-<Tab>", addName "Classic Alt-Tab cycle"               $ nextMatch Backward (return True))
    , ("M1-S-<Tab>", addName "Classic Alt-Tab cycle (reversed)"  $ nextMatch Forward (return True)) ]

    -- Switch layouts
    ^++^ subKeys "Switch layouts"
    [ ("M-<Tab>", addName "Switch to next layout"   $ sendMessage NextLayout)
    --, ("M-S-<Space>", addName "Resets the layout" $ resetLayout $ myDefaultLayout)
    , ("M-<Space>", addName "Toggle noborders/full" $ sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)]

    -- Window resizing
    ^++^ subKeys "Window resizing"
    [ ("M-h", addName "Shrink window"               $ sendMessage Shrink)
    , ("M-l", addName "Expand window"               $ sendMessage Expand)
    , ("M-M1-j", addName "Shrink window vertically" $ sendMessage MirrorShrink)
    , ("M-M1-k", addName "Expand window vertically" $ sendMessage MirrorExpand)]

    -- Floating windows
    ^++^ subKeys "Floating windows"
    [ ("M-f", addName "Toggle float layout"        $ sendMessage (T.Toggle "floats"))
    , ("M-t", addName "Sink a floating window"     $ withFocused $ windows . W.sink)
    , ("M-S-t", addName "Sink all floated windows" $ sinkAll)]

    -- Increase/decrease spacing (gaps)
    ^++^ subKeys "Window spacing (gaps)"
    [ ("C-M1-j", addName "Decrease window spacing" $ decWindowSpacing 4)
    , ("C-M1-k", addName "Increase window spacing" $ incWindowSpacing 4)
    , ("C-M1-h", addName "Decrease screen spacing" $ decScreenSpacing 4)
    , ("C-M1-l", addName "Increase screen spacing" $ incScreenSpacing 4)]

    -- Increase/decrease windows in the master pane or the stack
    ^++^ subKeys "Increase/decrease windows in master pane or the stack"
    [ ("M-S-<Up>", addName "Increase clients in master pane"   $ sendMessage (IncMasterN 1))
    , ("M-S-<Down>", addName "Decrease clients in master pane" $ sendMessage (IncMasterN (-1)))
    , ("M-=", addName "Increase max # of windows for layout"   $ increaseLimit)
    , ("M--", addName "Decrease max # of windows for layout"   $ decreaseLimit)]

    -- Sublayouts
    -- This is used to push windows to tabbed sublayouts, or pull them out of it.
    ^++^ subKeys "Sublayouts"
    [ ("M-C-h", addName "pullGroup L"           $ sendMessage $ pullGroup L)
    , ("M-C-l", addName "pullGroup R"           $ sendMessage $ pullGroup R)
    , ("M-C-k", addName "pullGroup U"           $ sendMessage $ pullGroup U)
    , ("M-C-j", addName "pullGroup D"           $ sendMessage $ pullGroup D)
    , ("M-C-m", addName "MergeAll"              $ withFocused (sendMessage . MergeAll))
    -- , ("M-C-u", addName "UnMerge"               $ withFocused (sendMessage . UnMerge))
    , ("M-C-/", addName "UnMergeAll"            $  withFocused (sendMessage . UnMergeAll))
    , ("M-C-.", addName "Switch focus next tab" $  onGroup W.focusUp')
    , ("M-C-,", addName "Switch focus prev tab" $  onGroup W.focusDown')]

    -- Scratchpads
    -- Toggle show/hide these programs. They run on a hidden workspace.
    -- When you toggle them to show, it brings them to current workspace.
    -- Toggle them to hide and it sends them back to hidden workspace (NSP).
    ^++^ subKeys "Scratchpads"
    [ ("M-s t", addName "Toggle scratchpad terminal"   $ namedScratchpadAction myScratchPads "terminal")
    , ("M-s k", addName "Toggle onscreen keyboard"   $ namedScratchpadAction myScratchPads "keyboard")
    , ("M-s a", addName "Toggle scratchpad timer"       $ namedScratchpadAction myScratchPads "timer")
    , ("M-s c", addName "Toggle scratchpad calculator" $ namedScratchpadAction myScratchPads "calculator")]

    ^++^ subKeys "GridSelect"
    -- , ("C-g g", addName "Select favorite apps"     $ runSelectedAction' defaultGSConfig gsCategories)
    [ ("M-M1-<Return>", addName "Select favorite apps" $ spawnSelected'
         $ gsGames ++ gsEducation ++ gsInternet ++ gsMultimedia ++ gsOffice ++ gsSettings ++ gsSystem ++ gsUtilities)
    , ("M-M1-c", addName "Select favorite apps"    $ spawnSelected' gsCategories)
    , ("M-M1-t", addName "Goto selected window"    $ goToSelected $ mygridConfig myColorizer)
    , ("M-M1-b", addName "Bring selected window"   $ bringSelected $ mygridConfig myColorizer)
    , ("M-M1-1", addName "Menu of games"           $ spawnSelected' gsGames)
    , ("M-M1-2", addName "Menu of education apps"  $ spawnSelected' gsEducation)
    , ("M-M1-3", addName "Menu of Internet apps"   $ spawnSelected' gsInternet)
    , ("M-M1-4", addName "Menu of multimedia apps" $ spawnSelected' gsMultimedia)
    , ("M-M1-5", addName "Menu of office apps"     $ spawnSelected' gsOffice)
    , ("M-M1-6", addName "Menu of settings apps"   $ spawnSelected' gsSettings)
    , ("M-M1-7", addName "Menu of system apps"     $ spawnSelected' gsSystem)
    , ("M-M1-8", addName "Menu of utilities apps"  $ spawnSelected' gsUtilities)]


    -- The following lines are needed for named scratchpads.
          where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
                nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))
-- END_KEYS

main :: IO ()
main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe ("xmobar -x 0 $HOME/.config/xmobar/" ++ colorScheme ++ "-xmobarrc")

--  xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobarrc"
--  xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/xmobarrc"
--  xmproc2 <- spawnPipe "xmobar -x 2 $HOME/.config/xmobar/xmobarrc"

    -- the xmonad, ya know...what the WM is named after!
    xmonad $ addDescrKeys' ((mod4Mask, xK_F1), showKeybindings) myKeys $ ewmh $ ewmhFullscreen $ docks $ def -- Just remove $ ewmhFullscreen if YouTube fullscreen doesn't work
        { manageHook         = myManageHook <+> manageDocks
        --, handleEventHook    = docksEventHook
                               -- Uncomment this line to enable fullscreen support on things like YouTube/Netflix.
                               -- This works perfect on SINGLE monitor systems. On multi-monitor systems,
                               -- it adds a border around the window if screen does not have focus. So, my solution
                               -- is to use a keybinding to toggle fullscreen noborders instead.  (M-<Space>)
                               -- <+> fullscreenEventHook
        , handleEventHook    = swallowEventHook (className =? "Alacritty" <||> className =? "XTerm" <||> className =? "st") (return True)
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook = dynamicLogWithPP $  filterOutWsPP [scratchpadWorkspaceTag] $ xmobarPP
              { ppOutput = \x -> hPutStrLn xmproc0 x                          -- xmobar on monitor 1
                -- Current workspace
              , ppCurrent = xmobarColor color06 "" . wrap ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>"
                -- Visible but not current workspace
              , ppVisible = xmobarColor color06 "" . clickable 
                -- Hidden workspaces
              , ppHidden = xmobarColor color05 "" . wrap ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>" . clickable
                -- Hidden workspaces (no windows)
              , ppHiddenNoWindows = xmobarColor color05 ""  . clickable
                -- Title of active window
              , ppTitle = xmobarColor color16 "" . shorten 60
                -- Separator character
              , ppSep =  "<fc=" ++ color09 ++ "> <fn=1>|</fn> </fc>"
                -- Urgent workspace
              , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
                -- # of windows current workspace
              , ppExtras  = [windowCount]                                    
                -- order of things in xmobar
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
              }
        }
