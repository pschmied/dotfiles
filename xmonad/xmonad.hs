import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Actions.UpdatePointer

baseConfig = desktopConfig

main = do

  xmproc <- spawnPipe "/usr/bin/xautolock -time 15 -locker slock"
  xmproc <- spawnPipe "/usr/bin/xsetroot -solid lightblue"
  -- xmproc <- spawnPipe "/usr/local/bin/xmobar ~/.xmobarrc"
  xmproc <- spawnPipe "/usr/bin/setxkbmap -option ctrl:nocaps -option compose:ralt"
  xmproc <- spawnPipe "/usr/bin/gpg-agent --enable-ssh --daemon"
  xmproc <- spawnPipe "/usr/bin/emacs --daemon"
  -- xmproc <- spawnPipe "/usr/bin/mixerctl  outputs.master=156"

  xmonad $ baseConfig
    { modMask = mod4Mask
    , terminal = "stterm -f 'Terminus:size=13'"
    , logHook = updatePointer (0.5, 0.5) (0, 0)
    }
    `additionalKeysP`
    [
      ("M-p", spawn "dmenu_run -fn '-xos4-terminus-medium-r-*-*-14-*'")
    , ("M-s", spawn "passmenu")
    ]
