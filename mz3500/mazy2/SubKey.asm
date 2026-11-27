include "Share.inc"
include "Sub.inc"

ext CmdLoop

PaperEmpty equ 08h

dseg
KeyCommand:
    defb 0
KeyFlag:
    defb 0
JoystickAvailable:
    defb 0

cseg
InitKey: public InitKey
    xor a
    ld (SubShareRam+Share_KeyCode),a
    ld (SubShareRam+Share_JoystickValue),a

    xor a | out (PpiPort+0),a
    in a,(Ls244Port) | and PaperEmpty
    if nz
        xor a
    else
        ld a,1
    endif
    ld (JoystickAvailable),a
ret


KeyboardInterrupt: public KeyboardInterrupt
    ld hl,0
    ld e,10
KeyboardNextBit:
    ld b,16
KeyboardWaitHigh:
    in a,(Ls244Port)
    bit 6,a
    jr nz,KeyboardSampleBit
    djnz KeyboardWaitHigh
    jr KeyboardInterruptExit
KeyboardSampleBit:
    add a,a
    add a,a
    add a,a
    rl l
    rl h
    call KeyboardWaitLow
    jr nc,KeyboardInterruptExit
    dec e
    jr nz,KeyboardNextBit

    ; HL contains eight data bits, the command bit, then even parity.
    ld a,h
    xor l
    jp po,KeyboardInterruptExit

KeyboardValidFrame: public KeyboardValidFrame
    ld a,l
    and 2
    rrca
    ld (KeyCommand),a
    srl h | rr l
    srl h | rr l
    ld a,l
    ld (SubShareRam+Share_KeyCode),a
    ld a,1
    ld (KeyFlag),a

    ; ACK only a complete valid frame, so the keyboard can retry errors.
    ; The keyboard expects ACK 60-300us after the last strobe, at least 22.5us wide.
    ld b,26
KeyboardAcknowledgeDelay:
    djnz KeyboardAcknowledgeDelay
    ld a,05h | out (PpiPort+3),a
    ld b,10
KeyboardAcknowledgeHold:
    djnz KeyboardAcknowledgeHold
    ld a,04h | out (PpiPort+3),a

KeyboardInterruptExit:
    pop iy
    pop ix
    exx
    ex af,af'
    ei
    reti

KeyboardWaitLow:
    ld b,16
KeyboardWaitLowLoop:
    in a,(Ls244Port)
    bit 6,a
    jr z,KeyboardLow
    djnz KeyboardWaitLowLoop
    or a
ret
KeyboardLow:
    scf
ret

PrinterTable:
    defb 01h,Keys_Right
    defb 02h,Keys_Left
    defb 04h,Keys_Up
    defb 08h,Keys_Down
    defb 10h,Keys_Button1
    defb 20h,Keys_Button0
    defb 0
ReadJoystick: public ReadJoystick
    push af
        ld a,(JoystickAvailable)
        or a
        if nz
            ld c,0
            ld hl,PrinterTable
            do
                ld a,(hl)
                or a
            while nz
                inc hl
                out (PpiPort+0),a
                in a,(Ls244Port) | and PaperEmpty
                if nz
                    ld a,c
                    or (hl)
                    ld c,a
                endif
                inc hl
            wend
            ld a,c
        endif
        ld (SubShareRam+Share_JoystickValue),a
    pop af
ret