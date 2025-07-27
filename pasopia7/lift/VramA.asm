include "FixedCode.inc"

Vram equ 8000h
VramWidth equ 40
CharHeight equ 8
VramRowSize equ VramWidth*CharHeight


PatternRam equ 0D000h
VramTop equ Vram+VramRowSize

VVramWidth equ 32
VVramHeight equ 22

ext VVram_

dseg
Backup:
    defs VVramWidth*VVramHeight


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


; void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
dseg
    MakePatternMono_@Param3: public MakePatternMono_@Param3
    defb 0
cseg
MakePatternMono_: public MakePatternMono_
    push af | push hl | push de | push bc
        exx
            call PatternAddress
        exx
        do
            ld a,(MakePatternMono_@Param3)
            exx
                ld d,a
            exx
            ld b,3
            do
                push de
                    ld h,8
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
            dwnz    
            ex de,hl
                ld de,8
                add hl,de
            ex de,hl
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void MakePatternColor(byte c, ptr<byte> pSource, byte count);
cseg
MakePatternColor_: public MakePatternColor_
    push af | push hl | push de | push bc
        exx
            call PatternAddress
        exx
        do
            ld b,24
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
    pop bc | pop de | pop hl | pop af
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


; void VPut(word vram, byte c);
cseg
VPut_: public VPut_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            call PatternAddress
        ex de,hl
        call TransPattern
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
                        push bc
                            ld bc,CharHeight
                            add hl,bc
                        pop bc
                    exx
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
