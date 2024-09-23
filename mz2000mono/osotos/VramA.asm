include "mz2000.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CharPattern

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
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
InitVram: public InitVram
    ld hl,CharPattern
    exx
        ld hl,PatternRam
    exx
    ld c,Char_End
    do
        ld b,CharHeight
        do
            ld a,(hl) | inc hl
            exx
                ld de,0
                ld b,8
                do
                    srl d | rr e
                    srl d | rr e
                    rlca
                    if c
                        set 7,d | set 6,d
                    endif
                dwnz
                ld (hl),e | inc hl
                ld (hl),d | inc hl
            exx
        dwnz
        dec c
    while nz | wend
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,Vram
        ld de,Vram+1
        ld bc,640/8*200-1
        ld (hl),0
        ldir

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
Put:
    ex de,hl
        call PatternAddress
    ex de,hl
    ld a,CharHeight
    ld bc,VramWidth-1
    do
        ld i,a
        ld a,(de) | inc de
        ld (hl),a | inc hl
        ld a,(de) | inc de
        ld (hl),a | add hl,bc
        ld a,i
        dec a
    while nz | wend
    ld bc,-VramWidth*CharHeight
    add hl,bc
ret

Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        call Put
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
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
