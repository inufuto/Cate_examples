include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern

dseg
Backup:
    defs VVramWidth*VVramHeight
PatternRam:
    defs PatternSize*Char_End

cseg
ColorTable:
    defb 64,3 ; Ascii
    defb 16,2 ; Logo
    defb 1,3 ; Needle
    defb 44,3 ; Man
    defb 16,1 ; Monster
    defb 16,2 ; Lift
    defb 0
    defb 1+4+16; color chars
InitVram: public InitVram
    exx
        ld hl,PatternRam
    exx
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld a,(hl) | inc hl
        or a
    while nz
        ld c,a ; count
        ld a,(hl) | inc hl
        exx
            ld d,a
            rlca | rlca | rlca | rlca
            ld b,a
            ld a,d
            rrca
            or b
            and 11h
            ld d,a
        exx
        push hl
            do
                ld l,8 ; y count
                do
                    ld a,(de) | inc de
                    exx
                        ld c,a ; source
                    exx
                    ld h,2 ; x count
                    do
                        exx
                            ld e,0 ; destination
                        exx
                        ld b,4 ; dot count
                        do
                            exx
                                sla e
                                sla c
                                if c
                                    ld a,e
                                    or d
                                    ld e,a
                                endif
                            exx
                        dwnz
                        exx
                            ld (hl),e | inc hl
                        exx
                        dec h
                    while nz | wend
                    dec l
                while nz | wend
                dec c
            while nz | wend
        pop hl
    wend
    ld c,(hl)
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
ret


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,0c000h
        ld de,0c001h
        ld bc,4000h-1
        ld (hl),0
        ldir

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
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
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
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
        ex de,hl
        ld b,8
        do
            ld a,(de) | inc de
            ld (hl),a | inc hl
            ld a,(de) | inc de
            ld (hl),a
            push bc
                ld bc,800h-1
                add hl,bc
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,Vram
        exx
        ld c,VVramHeight
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
                            inc hl
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth*2
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
