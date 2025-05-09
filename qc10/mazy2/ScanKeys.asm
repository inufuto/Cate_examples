Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

Keys_Bit_Left equ 0
Keys_Bit_Right equ 1
Keys_Bit_Up equ 2
Keys_Bit_Down equ 3
Keys_Bit_Button0 equ 4
Keys_Bit_Button1 equ 5

PortA equ 14h
PortB equ 15h
PaperEmpty equ 10h

dseg
Wfc16:
    defb 0
Wfc17:
    defb 0
Wfc19:
    defb 0
KeyCode: public KeyCode
    defb 0
ShiftOn:
    defb 0
CtrlOn:
    defb 0
PrinterValue:
    defb 0
JoystickAvailable_:  public JoystickAvailable_
    defb 0

cseg
InitKey: public InitKey
    xor a
    ld (ShiftOn),a
    ld (CtrlOn),a
    ld (JoystickAvailable_),a

    ld a,0ffh | out (PortA),a
    in a,(PortB)
    and PaperEmpty
    ld (PrinterValue),a
ret


KeyHandler: public KeyHandler
    push af | push de
        in a,(12h) | ld (Wfc16),a
        bit 0,a
        if nz
            ld a,01h | out (12h),a
            in a,(12h) | ld (Wfc17),a
            in a,(10h) 
            bit 7,a
            if z
                ld (KeyCode),a
                jr KeyHandler_else
            endif
            ld e,a
            and 1eh
            cp 06h ; Left Shift
            if z
                KeyHandler_Shift:
                ld a,e
                and 1
                ld (ShiftOn),a
                jr KeyHandler_else
            endif
            cp 07h
            jr z,KeyHandler_Shift
            cp 0ah ; Ctrl
            if z
                ld a,e
                and 1
                ld (CtrlOn),a
            endif
        endif
        KeyHandler_else:
        ld a,(Wfc16)
        bit 2,a
        if z
            ld a,28h | out (12h),a
            xor a | ld (Wfc19),a
            ld (KeyCode),a
        endif
        ld a,30h | out (12h),a
        ld a,38h | out (12h),a
        
        ld a,61h | out (08h),a
    pop de | pop af
ei | reti

cseg
KeyTable:
    defb 19h,Keys_Right ; 6
    defb 1bh,Keys_Left ; 4
    defb 25h,Keys_Right or Keys_Down ; 3
    defb 26h,Keys_Down ; 2
    defb 27h,Keys_Left or Keys_Down ; 1
    defb 29h,Keys_Right or Keys_Up ; 9
    defb 2ah,Keys_Up ; 8
    defb 2bh,Keys_Left or Keys_Up ; 7
    defb 3ch,Keys_Up ; Up
    defb 3dh,Keys_Left ; Left
    defb 3eh,Keys_Right ; Right
    defb 3fh,Keys_Down ; Down
    defb 0
PrinterTable:
    defb $fe,Keys_Right
    defb $fd,Keys_Left
    defb $fb,Keys_Up
    defb $f7,Keys_Down
    defb $ef,Keys_Button1
    defb $df,Keys_Button0
    defb 0
ScanKeys_: public ScanKeys_
    push hl | push de
        ld a,(PrinterValue)
        or a
        if nz
            ld e,0
            ld hl,PrinterTable
            do
                ld a,(hl) | inc hl
                or a
            while nz
                out (PortA),a
                in a,(PortB)
                and PaperEmpty
                if z
                    ld a,e
                    or (hl)
                    ld e,a
                endif
                inc hl
            wend
            ld a,e
            or a
            if nz
                ld a,1 | ld (JoystickAvailable_),a
            endif
            ld a,(JoystickAvailable_)
            or a
            if nz
                ld a,e
                jr ScanKeys_joy
            endif
        endif
        
        ld a,(KeyCode) | ld e,a
        ld hl,KeyTable
        do
            ld a,(hl) | inc hl
            or a
        while nz
            cp e
            if z
                ld a,(hl)
                jp ScanKeys_break
            endif
            inc hl
        wend
        xor a
        ScanKeys_break:
        ld hl,(ShiftOn)
        bit 0,l
        if nz
            set Keys_Bit_Button0,a
        endif
        bit 0,h
        if nz
            set Keys_Bit_Button1,a
        endif
        ScanKeys_joy:
    pop de | pop hl 
ret
