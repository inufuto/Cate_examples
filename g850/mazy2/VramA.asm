include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramBack_, VVramFront_

LCDSTAT equ 40h
LCDDATA equ 41h


dseg
Vram_: public Vram_
    defs VramRowSize*VramHeight
Backup:
    defs VVramWidth*VVramHeight


cseg
WaitLCD:
    push af
        do
        in a,(LCDSTAT)
            rlca
        while c | wend
    pop af
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld c,0
        do
            call WaitLCD
            xor a | out (LCDSTAT),a
            call WaitLCD
            ld a,10h | out (LCDSTAT),a
            call WaitLCD
            ld a,c
            or 0b0h | out (LCDSTAT),a
            xor a
            ld b,VramRowSize
            do
                call WaitLCD
                out (LCDDATA),a
            dwnz
            inc c
            ld a,c
            cp VramHeight
        while nz | wend

        ld hl,Vram_
        ld bc,VramRowSize*VramHeight
        call Clear

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


; void PresentVram();
cseg
PresentVram_: public PresentVram_
    push af | push hl | push bc
        ld hl,Vram_
        ld c,0
        do
            call WaitLCD
            xor a | out (LCDSTAT),a
            call WaitLCD
            ld a,10h | out (LCDSTAT),a
            call WaitLCD
            ld a,c
            or 0b0h | out (LCDSTAT),a
            xor a
            ld b,VramRowSize
            do
                call WaitLCD
                ld a,(hl) | inc hl
                out (LCDDATA),a
            dwnz
            inc c
            ld a,c
            cp VramHeight
        while nz | wend
    pop bc | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    push af | push de | push bc
        ld a,e
        cp ' '
        if z
            xor a
        else
            cp '-'
            if z
                ld a,$01
            else
                cp 'A'
                if nc
                    add a, $0c-'A'
                else
                    add a, $02-'0'
                endif
            endif
        endif
        add a,a ;*2
        add a,a ;*4
        push hl
            ld l,a
            ld h,0
            ld de,AsciiPattern
            add hl,de
            ex de,hl
        pop hl
        ld b,4
        do
            ld a,(de) | inc de
            ld (hl),a | inc hl
            dec b
        while nz | wend
    pop bc | pop de | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
cseg
WriteByte:
    push de
        and 07h
        ld e,a | ld d,0
        ld a,c
        or a
        do | while nz
            sla e | rl d
            dec a
        wend
        ld a,(hl)
        exx
            and e
        exx
        or e
        ld (hl),a
        push de
            ld de,VramRowSize
            add hl,de
        pop de
        ld a,(hl)
        exx
            and d
        exx
        or d
        ld (hl),a
        ld de,1-VramRowSize
        add hl,de
    pop de
ret
Put_: public Put_
    push af | push de | push bc
        ld a,c
        exx
            ld de,0fff8h
            or a
            do | while nz
                scf | rl e | rl d
                dec a
            wend
        exx
        ex de,hl
            ld h,0
            add hl,hl
            push bc
                ld bc,CharPattern
                add hl,bc
            pop bc
        ex de,hl

        ld a,(de) | inc de
        push af
            call WriteByte
        pop af
        rrca | rrca | rrca | rrca
        call WriteByte
        ld a,(de) | inc de
        call WriteByte
    pop bc | pop de | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram_
            ld c,0
        exx
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    push hl | push de | push bc
                        exx
                            ld e,a
                            call Put_
                        exx
                    pop bc | pop de | pop hl
                else
                    exx
                        inc hl | inc hl | inc hl
                    exx
                endif
                inc hl
            dwnz
            exx
                ld de,-VVramWidth*CharWidth
                add hl,de
                
                ld a,c
                add a,3
                cp 8
                if nc
                    sub 8
                    ld de,VramRowSize
                    add hl,de
                endif
                ld c,a
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
