; Remap hotkeys
CapsLock::Esc
Esc::CapsLock

; Global hotkeys
#i::Run, C:\Program Files\GIMP 3\bin\gimp-3.exe
#n::Run, explorer.exe \\wsl.localhost\archlinux\home\nick
#m::Run, foobar2000.exe
#p::Run, explorer.exe E:\podcasts\podcasts\running-in-production
#t::Run, %UserProfile%\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe
#+t::Run, *RunAs %UserProfile%\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe
#w::Run firefox.exe -new-window
#+w::Run, firefox.exe -private-window
; If you prefer Chrome over Firefox you can use this instead:
;#w::Run chrome.exe
;#+w::Run chrome.exe -incognito
