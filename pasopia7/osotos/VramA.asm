include "FixedCode.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern


dseg
Backup:
    defs VVramWidth*VVramHeight


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 6 ; Logo
defb 1, 1 ; Floor
defb 2,6 ; Ladder
defb 32,3 ; Monster
defb 16, 7 ; Point
defb 4, 6 ; Item
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
    ld c,Char_End-Char_Man
    call MakePatternColor
ret


MakePatternMono: public MakePatternMono
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
    push hl | exx | pop hl | exx
    ld a,c
    exx
        ld c,a
    exx
    do
        exx
            ld d,c
        exx
        ld c,PlaneCount
        do
            push de
                ld h,CharHeight
                do
                    ld a,(de)
                    exx
                        ld e,0
                        bit 0,d
                        if nz
                            or e
                            ld e,a
                        endif
                    exx
                    ld a,(de)
                    exx
                        bit 4,d
                        if nz
                            cpl
                            or e
                            ld e,a
                        endif
                        ld (hl),e
                        inc hl
                    exx
                    inc de
                    dec h
                while nz | wend
                exx
                    srl d
                exx
            pop de
            dec c
        while nz | wend
        ex de,hl
            ld de,CharHeight
            add hl,de
        ex de,hl
    dwnz
ret


MakePatternColor:
    do
        ld b,CharHeight*PlaneCount
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
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        call ClearVRam

        ld hl,Backup
        ld bc,VVramWidth * VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,e
        ex de,hl
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
        ex de,hl
        call TransPattern
        ld bc,CharHeight
        add hl,bc
    pop bc | pop de | pop af
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*0
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
                                ld bc,CharHeight
                                add hl,bc
                            pop bc
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth*CharHeight
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
