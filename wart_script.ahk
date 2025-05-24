#Persistent
#SingleInstance Force
SetBatchLines, -1
SetTitleMatchMode, 2

wart := false
paused := false
resumeAction := 0
elapsed := 0
startTick := 0
currentKey := ""

toggleKey := "F8"
pauseKey := "F9"
reloadKey := "F10"

Hotkey, F8, ToggleWart
Hotkey, F9, PauseScript
Hotkey, F10, ReloadScript
return

ToggleWart:
wart := !wart
if (wart) {
    ToolTip Script ON
    paused := false
    resumeAction := 0
    elapsed := 0
    currentKey := ""
    SetTimer, WartLoop, 0
} else {
    ToolTip Script OFF
    SetTimer, WartLoop, Off
    Send, {D up}{W up}{A up}{LButton up}
}
SetTimer, RemoveToolTip, -1000
return

PauseScript:
if (!wart)
    return

paused := !paused
if (paused) {
    ToolTip Paused
    SetTimer, WartLoop, Off
    elapsed += A_TickCount - startTick
    Send, {D up}{W up}{A up}
} else {
    ToolTip Resumed
    ; Resend the key that was active when paused
    if (resumeAction = 1)
        Send, {D down}
    else if (resumeAction = 2 or resumeAction = 4)
        Send, {W down}
    else if (resumeAction = 3)
        Send, {A down}
    SetTimer, WartLoop, 0
}
SetTimer, RemoveToolTip, -1000
return

WartLoop:
if (!wart || paused)
    return

if (resumeAction <= 0) {
    if (!GetKeyState("LButton", "P")) {
        Send, {LButton down}
    }
    resumeAction := 1
}

if (resumeAction = 1) {
    currentKey := "D"
    Send, {D down}
    timeToHold := 88800 - elapsed
    startTick := A_TickCount
    Sleep, %timeToHold%
    if (paused)
        return
    Send, {D up}
    resumeAction := 2
    elapsed := 0
}

if (resumeAction = 2) {
    currentKey := "W"
    Send, {W down}
    timeToHold := 1200 - elapsed
    startTick := A_TickCount
    Sleep, %timeToHold%
    if (paused)
        return
    Send, {W up}
    resumeAction := 3
    elapsed := 0
}

if (resumeAction = 3) {
    currentKey := "A"
    Send, {A down}
    timeToHold := 88720 - elapsed
    startTick := A_TickCount
    Sleep, %timeToHold%
    if (paused)
        return
    Send, {A up}
    resumeAction := 4
    elapsed := 0
}

if (resumeAction = 4) {
    currentKey := "W"
    Send, {W down}
    timeToHold := 1220 - elapsed
    startTick := A_TickCount
    Sleep, %timeToHold%
    if (paused)
        return
    Send, {W up}
    resumeAction := 1
    elapsed := 0
}
return

RemoveToolTip:
ToolTip
return

ReloadScript:
ToolTip Reloading Script...
SetTimer, DoReload, -500  ; Delay reload by 500ms
return

DoReload:
ToolTip
Reload
return
