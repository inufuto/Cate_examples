include "VVram.inc"

Vram equ 0c000h

VramWidth equ 80
VramHeight equ 25
CharHeight equ 8
VramRowSize equ VramWidth
VramTop equ Vram+VramRowSize

PatternSize equ CharHeight*2
PatternRam equ 0a000h

ext VVram_

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


; void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
dseg
    MakePatternMono_@Param3: public MakePatternMono_@Param3
    defb 0
cseg
MakePatternMono_: public MakePatternMono_
    di
        push af | push hl | push de | push bc
            exx
                call PatternAddress
            exx
            ld a,(MakePatternMono_@Param3) ; color
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
            do
                ld l,CharHeight
                do
                    ld a,(de) | inc de
                    exx
                        ld c,a
                    exx
                    ld h,2
                    do
                        exx
                            ld e,0
                        exx
                        ld b,4
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
                            ld (hl),e
                            inc hl
                        exx
                        dec h
                    while nz | wend
                    dec l
                while nz | wend
                dec c
            while nz | wend
        pop bc | pop de | pop hl | pop af
    ei
ret


; void MakePatternColor(byte c, ptr<byte> pSource, byte count);
MakePatternColor_: public MakePatternColor_
    di
        push af | push hl | push de | push bc
            call PatternAddress
            ex de,hl
            push hl
                ld l,c
                ld h,0
                add hl,hl ;*2
                add hl,hl ;*4
                add hl,hl ;*8
                add hl,hl ;*16
                ld c,l
                ld b,h
            pop hl
            ldir
        pop bc | pop de | pop hl | pop af
    ei
ret


; void ClearScreen();
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


; void VPut(ptr<byte> pVram, byte c);
VPut_: public VPut_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            call PatternAddress
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
