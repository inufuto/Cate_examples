include "mz2000.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CharPattern

Text equ 0d000h

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
        ld a,0c0h | out (PortPIO_A),a
        ld hl,Text
        ld bc,2000
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
        ld a,080h | out (PortPIO_A),a

        ld hl,Vram
        ld de,Vram+1
        ld bc,640/8*200-1
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
Put:
    ex de,hl
        call PatternAddress
    ex de,hl
    ld a,CharHeight
    ld bc,VramWidth-1
    do
        ld i,a
        ; ld (Put_count+1),a
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
        ld a,0c0h | out (PortPIO_A),a

        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,Vram
            ld de,Text
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do 
                push bc 
                    ld a,(de) | inc de
                    ld c,a
                    or a
                    jr z,VVramToVram_G
                    inc a
                    if z
                        ld c,0
                        ld a,1fh
                    else
                        xor a
                    endif
                    VVramToVram_G:
                    exx
                        ld (de),a | inc de
                    exx
                    ld a,c
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            push de
                                ld e,a
                                ld a,080h | out (PortPIO_A),a
                                call Put_
                                ld a,0c0h | out (PortPIO_A),a
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
                    ex de,hl
                        ld bc,40-VVramWidth
                        add hl,bc
                    ex de,hl
                pop bc
            exx
            dec c
        while nz | wend
        
        ld a,080h | out (PortPIO_A),a
    pop bc | pop de | pop hl | pop af
ret
