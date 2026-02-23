include 'Vram.inc'

WindowWidth equ 24
WindowHeight equ 24

ext WindowBack_, WindowFront_, RowFlags_

cseg

; void ClearWindowBack();
ClearWindowBack_: public ClearWindowBack_
    push af | push hl | push de | push bc
        ld (ClearWindowBack_.sp+1),sp
        ld hl,WindowBack_+WindowWidth*WindowHeight
        ld de,WindowWidth*WindowHeight/2
        ld bc,0000h
        di
            ld sp,hl
            do
                push bc
                dec de
                ld a,e
                or d
            while nz | wend
            ClearWindowBack_.sp:
            ld hl,0
            ld sp,hl
        ei
    pop bc | pop de | pop hl | pop af
ret

; void ClearWindowFront();
ClearWindowFront_: public ClearWindowFront_
    push af | push hl | push de | push bc
        ld (ClearWindowFront_.sp+1),sp
        ld hl,WindowFront_+WindowWidth*WindowHeight*2
        ld de,WindowWidth*WindowHeight/2*2
        ld bc,0
        di
            ld sp,hl
            do
                push bc
                dec de
                ld a,e
                or d
            while nz | wend
            ClearWindowFront_.sp:
            ld hl,0
            ld sp,hl
        ei
    pop bc | pop de | pop hl | pop af
ret


; word WindowOffset(byte x, byte y)
WindowOffset_: public WindowOffset_
    push af | push de | push bc
        ld c,a  ; x
        ld a,e
        add a,a ; *2
        add a,e ; *3
        ld l,a
        ld h,0
        add hl,hl ; *6
        add hl,hl ; *12
        add hl,hl ; *24
        ld e,c  ; x
        ld d,0
        add hl,de
    pop bc | pop de | pop af
ret
