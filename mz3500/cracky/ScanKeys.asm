include "Share.inc"

ext HaltSub, ResumeSub
ext KeyCode, JoyStickValue

dseg
JoystickAvailable_:  public JoystickAvailable_
    defb 0

cseg
keyTable:
    defb '1', Keys_Left or Keys_Down
    defb '2', Keys_Down
    defb '3', Keys_Right or Keys_Down
    defb '4', Keys_Left
    defb '6', Keys_Right
    defb '7', Keys_Left or Keys_Up
    defb '8', Keys_Up
    defb '9', Keys_Right or Keys_Up
    defb 31, Keys_Left
    defb 30, Keys_Right
    defb 29, Keys_Down
    defb 28, Keys_Up
    defb 32, Keys_Button0
    defb 13, Keys_Button1
ScanKeys_: public ScanKeys_
; out
;   a
    call HaltSub
    ld a,SubCommand_Nop | ld (MainShareRam+Share_Command),a
    call ResumeSub
    
    ld a,(JoyStickValue)
    or a
    if nz
        ex af,af'
            ld a,1 | ld (JoystickAvailable_),a
        ex af,af'
        ret
    endif

    ld a,(JoystickAvailable_)
    or a
    if nz
        xor a
        ret
    endif

    ld a,(KeyCode)
    push hl | push de | push hl
        ld c,0
        ld hl,keyTable
        ld b,14
        do
            cp (hl)
            if z
                inc hl
                ld c,(hl)
                jr break
            endif
            inc hl
            inc hl
        dwnz
        break:
        ld a,c
    pop hl | pop de | pop bc
ret 
