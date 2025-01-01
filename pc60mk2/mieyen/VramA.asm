include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern

MonoSize equ CharHeight/2

dseg
Backup:
    defs VVramWidth*VVramHeight
PatternRam:
    defs PatternSize*Char_End
PortF0Save:
    defb 0

cseg
ToRam:
    push af
        in a,(0f0h)
        ld (PortF0Save),a
        ld a,0ddh
        out (0f0h),a
    pop af
ret

ToRom:
    push af
        ld a,(PortF0Save)
        out (0f0h),a
    pop af
ret


PatternAddress:
    push de
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        ld de,PatternRam
        add hl,de
    pop de
ret


cseg
ColorTable:
defb 64, 0fh ; Ascii
defb 16, 0dh ; Logo
defb 16, 09h ; Wall
defb 32,03h ; Monster
defb 4, 0eh ; Dot
defb 0
InitVram: public InitVram
    xor a
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld b,(hl)
        inc b | dec b
    while nz
        inc hl
        ld c,(hl)
        inc hl
        push af | push hl | push bc
            call MakePatternMono
        pop bc | pop hl | pop af
        add a,b
    wend

    ld hl,PatternRam+PatternSize*Char_Man
    ld de,ColorPattern
    ld c,Char_End-Char_Color
    call MakePatternColor
ret

MakePatternMono:
    call PatternAddress
    di
        call ToRam
        push hl | exx | pop ix | exx
        ld a,c ; color
        exx
            ld h,a
            and 03h
            ld l,a
            ld a,h
            rrca
            rrca
            and 03h
            ld h,a
        exx
        do
            ld l,4
            do
                ld a,(de)
                inc de
                exx
                    ld c,a
                exx
                ld h,2
                do
                    ld (ix),0
                    ld (ix+1),0
                    ld c,4
                    do
                        sla (ix) | sla (ix)
                        sla (ix+1) | sla (ix+1)
                        exx
                            sla c
                            if c
                                ld a,(ix)
                                or l
                                ld (ix),a
                                ld a,(ix+1)
                                or h
                                ld (ix+1),a
                            endif
                        exx
                        dec c
                    while nz | wend
                    inc ix | inc ix
                    dec h
                while nz | wend
                dec l
            while nz | wend
                                _deb: public _deb
        dwnz
        call ToRom
    ei
ret

MakePatternColor:
    di
        call ToRam
        push hl | exx | pop hl | exx
        do
            ld b,16
            do
                ld a,(de)
                inc de
                exx
                    ld (hl),a
                    inc hl
                exx
            dwnz
            dec c
        while nz | wend
        call ToRom
    ei
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,4000h
        di
            call ToRam
            do
                ld (hl),0
                inc hl
                dec bc
                ld a,c
                or b
            while nz | wend
            call ToRom
        ei

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop hl | pop af
ret


; word Put(word vram, byte c);
Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            call PatternAddress
        ex de,hl
        di
            call ToRam
            ld b,8
            do
                ld a,(de)
                inc de
                ld (hl),a
                ld a,(de)
                inc de
                set 5,h
                ld (hl),a
                res 5,h
                push bc
                    ld bc,40
                    add hl,bc
                pop bc
            dwnz
            call ToRom
        ei
    pop bc | pop de | pop hl | pop af
    inc hl
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*1
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do 
                push bc 
                    ld a,(de)
                    inc de
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            push de
                                ld e,a
                                call Put_
                            pop de
                        exx
                    else
                        exx
                            inc hl
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
