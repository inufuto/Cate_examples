include "mz2000.inc"
include "Chars.inc"

ext CharPattern
ext VVram_

Vram equ 0c000h
Text equ 0d000h

VramWidth equ 80
VramHeight equ 25
CharHeight equ 8
VramRowSize equ VramWidth*CharHeight
VramTop equ Vram+VramRowSize

PatternSize equ CharHeight*2
PatternRam equ 8000h

VVramWidth equ 32
VVramHeight equ 22

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
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        di
            ld a,0c0h
            out (PortPIO_A),a

            ld hl,Text
            ld bc,2000
            do
                ld (hl),0
                inc hl
                dec bc
                ld a,c
                or b
            while nz | wend

            ld a,080h
            out (PortPIO_A),a

            ld a,1
            do
                out (0f7h),a
                ld hl,0c000h
                ld de,0c001h
                ld bc,640/8*200-1
                ld (hl),0
                ldir
                inc a
                cp 4
            while nz | wend
            xor a
            out (0f7h),a
        ei

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


; void VPut(word vram, byte c);
cseg
VPut_: public VPut_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            call PatternAddress
        ex de,hl
        di
            ld a,1
            do
                push af
                    out (0f7h),a
                    ld b,CharHeight
                    do
                        ld a,(de)
                        inc de
                        ld (hl),a
                        inc hl
                        ld a,(de)
                        inc de
                        ld (hl),a
                        dec hl
                        ld a,l
                        add a,VramWidth
                        ld l,a
                        ld a,h
                        adc a,0
                        ld h,a
                    dwnz
                    ld bc,-VramWidth*CharHeight
                    add hl,bc
                pop af
                inc a
                cp 4
            while nz | wend
            xor a
            out (0f7h),a
        ei
    pop bc | pop de | pop hl | pop af
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,VramTop
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
                                call VPut_
                            pop de
                        exx
                    endif
                    exx
                        inc hl
                        inc hl
                    exx
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
