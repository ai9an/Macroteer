#Persistent
#SingleInstance Force
SetBatchLines, -1
SetTitleMatchMode, 2

wart := false
toggleKey := "F8"

Hotkey, %toggleKey%, ToggleWart

return

ToggleWart:
    wart := !wart
    if wart
    {
        ToolTip Script ON
        SetTimer, WartLoop, 0
    }
    else
    {
        ToolTip Script OFF
        SetTimer, WartLoop, Off
        Send, {D up}{W up}{A up}{LButton up}
    }
    SetTimer, RemoveToolTip, -1000
return

WartLoop:
    if !wart
        return

    if !GetKeyState("LButton", "P")
        Send, {LButton down}

    Send, {D down}
    Sleep, 36000
    Send, {D up}

    Send, {W down}
    Sleep, 3000
    Send, {W up}

    Send, {A down}
    Sleep, 36000
    Send, {A up}

    Send, {W down}
    Sleep, 3000
    Send, {W up}

return

RemoveToolTip:
    ToolTip
return 