import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Actions.UpdatePointer

baseConfig = desktopConfig

main = do

  xmproc <- spawnPipe "/usr/bin/xautolock -time 15 -locker xflock4"
  xmproc <- spawnPipe "/usr/bin/xsetroot -solid lightblue"
  xmproc <- spawnPipe "/usr/bin/setxkbmap -option ctrl:nocaps -option compose:ralt"
  xmproc <- spawnPipe "/usr/bin/gpg-agent --enable-ssh --daemon"
  xmproc <- spawnPipe "/usr/bin/synclient palmdetect=1 MaxTapTime=0"
  xmproc <- spawnPipe "/usr/bin/numlockx on"
  xmproc <- spawnPipe "/usr/bin/xfsettingsd"
  xmproc <- spawnPipe "/usr/bin/xfce4-volumed"
  xmproc <- spawnPipe "/usr/bin/xfce4-power-manager"
  -- xmproc <- spawnPipe "/usr/bin/nm-applet"
  -- xmproc <- spawnPipe "/usr/bin/xfce4-panel"

  xmonad $ baseConfig
    { modMask = mod4Mask
    , terminal = "/usr/bin/xfce4-terminal"
    , logHook = updatePointer (0.5, 0.5) (0, 0)
    }
    `additionalKeysP`
    [
      ("M-p", spawn "dmenu_run -fn '-xos4-terminus-medium-r-*-*-14-*'")
    , ("M-s", spawn "passmenu")
    ]
