include "Vram.inc"
include "VVram.inc"
include "Chars.inc"
include "SubMain_.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern
ext SendSub

VramTop equ Vram+VramRowSize*0
PatternSize equ 24

dseg
Backup:
    defs VVramWidth*VVramHeight
PatternRam:
    defs PatternSize*Char_End


cseg
PatternAddress:
    push de
        ld l,a
        ld h,0
        ld e,l
        ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld de,PatternRam
        add hl,de
    pop de
ret


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 16, 1 ; Wall
defb 32,3 ; Monster
defb 4,6 ; Dot
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

    ld hl,PatternRam+PatternSize*Char_Color
    ld de,ColorPattern
    ld c,Char_End-Char_Color
    call MakePatternColor
ret


Invert:
    push bc
        ld b,8
        do
            sla c
            rra
            if nc
                set 0,c
            endif
        dwnz
        ld a,c
    pop bc
ret

MakePatternMono:
    push af | push hl | push bc
        call PatternAddress
        ld a,b ; count
        exx
            ld d,a
        exx
        ld a,c
        do
            push af
                exx
                    ld e,a ; color
                exx
                ld c,3
                do
                    ld b,8
                    exx
                        bit 0,e
                    exx
                    if nz
                        push de
                            do
                                ld a,(de)
                                inc de
                                call Invert
                                ld (hl),a
                                inc hl
                            dwnz
                        pop de
                    else
                        do
                            ld (hl),0ffh
                            inc hl
                        dwnz
                    endif
                    exx
                        srl e
                    exx
                    dec c
                while nz | wend
                ex de,hl
                    ld bc,8
                    add hl,bc
                ex de,hl
            pop af
            exx
                dec d
            exx
        while nz | wend
    pop bc | pop hl | pop af
ret


MakePatternColor:
    do
        ld b,24
        do
            ld a,(de) | inc de
            call Invert
            ld (hl),a | inc hl
        dwnz
        dec c
    while nz | wend
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl), 0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        ld a,low Sub.ClearScreen
        call SendSub

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
Put_: public Put_
    push af | push de | push bc
        push hl
            ld a,e
            ex de,hl
                call PatternAddress
            ex de,hl
            ld c,3
            do  
                ld a,low Sub.Address
                call SendSub
                ld a,l
                call SendSub
                ld a,h
                call SendSub

                ld a,low Sub.Pattern
                call SendSub
                ld b,8
                do
                    ld a,(de)
                    inc de
                    call SendSub
                dwnz
                ld a,h
                add a,40h
                ld h,a
                dec c
            while nz | wend
        pop hl
        ld bc,8
        add hl,bc
    pop bc | pop de | pop af
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,VramTop+VramRowSize*1
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
                            push bc
                                ld bc,8
                                add hl,bc
                            pop bc
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth*8
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
