include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern


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
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld de,PatternRam
        add hl,de
    pop de
ret

cseg
ColorTable:
defb 64, 0fh ; Ascii
defb 16, 05h ; Logo
defb 8,07h ; Stair
defb 4,02h ; Goal
defb 16,0fh ; Point
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

MakePatternMono:
    call PatternAddress
    ld a,c ; color
    exx
        ld h,a
        and 0f0h | ld b,a ; background
        ld a,h
        rrca | rrca | rrca | rrca
        and 0f0h | ld c,a ; foreground
    exx
    do
        ld c,4 ; yCount1
        do
            push bc
                ld c,2 ; yCount2 
                do
                    ld a,(de) | inc de
                    exx
                        ld d,a
                    exx
                    ld b,2 ; xCount1
                    do
                        push bc
                            ld c,2 ; xCount2
                            do
                                exx
                                    ld e,0
                                exx
                                ld b,2 ; xCount3
                                do
                                    exx
                                        srl e | srl e | srl e | srl e
                                        ld a,e
                                        sla d
                                        if c
                                            or c
                                        else
                                            or b
                                        endif
                                        ld e,a
                                    exx
                                dwnz
                                exx
                                    ld a,e
                                exx
                                ld (hl),a
                                inc hl
                                dec c
                            while nz | wend
                            inc hl | inc hl
                        pop bc
                    dwnz
                    push de
                        ld de,2-8
                        add hl,de
                    pop de
                    dec c
                while nz | wend
                inc hl | inc hl | inc hl | inc hl
            pop bc
            dec c
        while nz | wend
    dwnz
ret

MakePatternColor:
    do
        ld b,PatternSize
        do
            ld a,(de)
            inc de
            ld (hl),a
            inc hl
        dwnz
        dec c
    while nz | wend
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
        di
            ld a,(0ed1dh)
            or 8
            out	(0c8h),a

            ld hl,0
            do
                ld (hl),0
                inc hl
                ld a,h
                cp 80h
            while nz | wend
            ld a,(0ed1dh)
            out	(0c8h),a
        ei

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop hl | pop af
ret


; word Put(word yx, byte c);
cseg
Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        exx
            call PatternAddress
        exx

        di
            ld a,(0ed1dh)
            and not 8
            out	(0c8h),a

            ld d,h ; y
            ld h,0
            add hl,hl
            ld c,4 ; yCount1
            do
                ld b,2 ; yCount2
                do
                    push hl | push bc
                        ld a,d | out (0ceh),a ; y
                        ld c,2; xCount1
                        do
                            ld b,2 ; xCount2
                            do
                                push bc
                                    exx
                                        ld a,(hl) | inc hl
                                    exx
                                    ld b,2 ; xCount3
                                    ld c,a
                                    do
                                        ld a,c | and 0fh
                                        srl c | srl c | srl c | srl c
                                                            ; xor 55h
                                        ld (hl),a
                                        inc hl
                                    dwnz
                                pop bc
                            dwnz
                            exx
                                inc hl | inc hl
                            exx
                            dec c
                        while nz | wend
                        inc d
                        exx
                            ld de,2-8
                            add hl,de
                        exx
                    pop bc | pop hl
                dwnz
                exx
                    inc hl | inc hl | inc hl | inc hl
                exx
                dec c
            while nz | wend

            ld a,(0ed1dh)
            out	(0c8h),a
        ei
    pop bc | pop de | pop hl | pop af
    inc l | inc l | inc l | inc l
ret


; void VVramToVram();
cseg
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
                        di
                            ex af,af'
                                ld a,(0ed1dh)
                                or 8
                                out	(0c8h),a
                            ex af,af'
                            exx
                                push de | push bc
                                    ex de,hl
                                        call PatternAddress
                                    ex de,hl
                                    push hl
                                        ld c,4
                                        do
                                            ld b,8
                                            do
                                                ld a,(de) | inc de
                                                ld (hl),a | inc hl
                                            dwnz
                                            push de
                                                ld de,100h-8
                                                add hl,de
                                            pop de
                                            dec c
                                        while nz | wend
                                    pop hl
                                pop bc | pop de
                            exx
                            ex af,af'
                                ld a,(0ed1dh)
                                out	(0c8h),a
                            ex af,af'
                        ei
                    endif
                    exx
                        push de
                            ld de,8
                            add hl,de
                        pop de
                    exx
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
