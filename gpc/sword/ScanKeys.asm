Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

cseg
ScanKeys_: public ScanKeys_
    xra a,a
    ani pa,not $40
    oni pc,$01 | ori a,Keys_Up
    oni pc,$02 | ori a,Keys_Left
    oni pc,$04 | ori a,Keys_Button1
    oni pc,$08 | ori a,Keys_Button0
    oni pc,$10 | ori a,Keys_Button1
    ori pa,$40

    ani pa,not $80
    oni pc,$01 | ori a,Keys_Down
    oni pc,$02 | ori a,Keys_Right
    oni pc,$04 | ori a,Keys_Button0
    oni pc,$08 | ori a,Keys_Button1
    oni pc,$10 | ori a,Keys_Button0
    ori pa,$80
ret
