include "FixedCode.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern

VramTop equ Vram+VramRowSize*1

Port31Save equ 0e6c6h

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
ToRam:
    push af
        ld a,(Port31Save)
        or 02h
        out (31h),a
        ld (Port31Save),a
    pop af
ret

ToRom:
    push af
        ld a,(Port31Save)
        and not 02h
        out (31h),a
        ld (Port31Save),a
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


ColorTable:
defb 64,3 ; Ascii
defb 16,2 ; Logo
defb 4,3 ; Knife
defb 72,3 ; Man
defb 16,3 ; Point
defb 8,3 ; Stair
defb 4,3 ; Goal
defb 0
defb Char_End-Char_Color; color
InitChars: public InitChars
        di
            call ToRam

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
                    ld d,a ; color
                exx
                push hl
                    ld b,a ; count
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
        
        call ToRom
    ei
ret


; void ClearScreen();
Clear:
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        call ClearVram

        ld hl,Backup
        ld bc,VVramWidth * VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth * VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
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
            call WriteVram
            call ToRom
        ei
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
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
