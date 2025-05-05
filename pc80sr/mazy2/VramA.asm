include "FixedCode.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

public WriteVram

Port31Save equ 0e658h
Port33Save equ 0e669h

ext VVramFront_, VVramBack_
ext ClearVVramFront_
ext MonoPattern, ColorPattern

dseg
BackupBack:
    defs VVramWidth*VVramHeight
BackupFront:
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


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 8,7 ; Stair
defb 4,6 ; Goal
defb 16,7 ; Point
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

    di
        call ToRam
            call InitOffscreen
        call ToRom
    ei
ret

MakePatternMono:
    push de
        ld l,a | ld h,0
        ld e,l | ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld de,PatternRam
        add hl,de
    pop de
    di
        call ToRam
        do
            push bc
                ld a,c ; color
                exx
                    ld d,a
                exx
                ld c,3
                do
                    push de
                        ld b,8
                        do
                            exx
                                bit 0,d
                            exx
                            if nz
                                ld a,(de)
                            else
                                xor a
                            endif
                            inc de
                            ld (hl),a
                            inc hl
                        dwnz
                    pop de
                    exx
                        srl d
                    exx
                    dec c
                while nz | wend
                ex de,hl
                    ld bc,8
                    add hl,bc
                ex de,hl
            pop bc
        dwnz
        call ToRom
    ei
ret

MakePatternColor:
    di
        call ToRam
        do
            ld b,24
            do
                ld a,(de)
                inc de
                ld (hl),a
                inc hl
            dwnz
            dec c
        while nz | wend
        call ToRom
    ei
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
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        call ClearVram

        ld hl,BackupBack
        ld bc,VVramWidth*VVramHeight*2
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        or a
        if z
            ld de,Offscreen
            jr Put_offscreen
        endif
        cp Char_Wall
        if z
            ld de,Offscreen+CharHeight
            Put_offscreen:
            di
                call FromOffscreen
            ei
            jr Put_exit
        endif
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
        di
            call ToRam
            call WriteVram
            call ToRom
        ei
        Put_exit:
    pop bc | pop de | pop hl | pop af
    inc hl
ret


VVramToVram:
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
                    exx
                endif
                inc hl
            pop bc
        dwnz
        exx
            push bc
                ld bc,VramRowSize-VVramWidth
                add hl,bc
            pop bc
        exx
        dec c
    while nz | wend
ret

; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramBack_
        ld hl,BackupBack
        exx
            ld hl,VramBack+VramRowSize
        exx
        call VVramToVram

        ld de,VVramFront_
        ld hl,BackupFront
        exx
            ld hl,VramFront+VramRowSize
        exx
        call VVramToVram
    pop bc | pop de | pop hl | pop af
ret
