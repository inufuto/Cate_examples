include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext ToRam, ToRom, PatternAddress, InitVram0

Offscreen equ Vram+16000

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 8,7 ; Stair
defb 4,6 ; Goal
defb 16,7 ; Point
defb 0
InitVram: public InitVram
    ld hl,ColorTable
    call InitVram0
    call InitOffscreen
ret

; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        di
            in a,(32h) | or 40h | out (32h),a
            xor a | out (34h),a
            ld a,80h | out (35h),a

            ld hl,Vram
            ld de,Vram+1
            ld bc,16000-1
            ld (hl),0ffh
            ldir

            ld a,90h | out (35h),a
            in a,(32h) | and not 40h | out (32h),a
        ei

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
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
            ld de,Offscreen+CharHeight*2
            Put_offscreen:
            di
                call FromOffscreen
            ei
            jr Put_exit
        endif
        ex de,hl
            call PatternAddress
        ex de,hl
        di
            call ToRam

            ld a,5ch
            do
                ld (Put_Port+1),a
                Put_Port:
                out (0),a
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
                ld a,(Put_Port+1)
                inc a
                cp 5fh
            while nz | wend
            out (5fh),a

            call ToRom
        ei
        Put_exit:
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret


; void VVramToVram();
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
                ; push bc 
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
                ; pop bc
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


InitChar:
    ld c,5ch
    do
        ld (InitChar_hl+1),hl
            out (c),a
            ld b,CharHeight*2
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
        InitChar_hl:
        ld hl,0
        inc c
        ld a,c
        cp 5fh
    while nz | wend
    out (5fh),a
ret

InitOffscreen:
    di
        call ToRam
            ld hl,Offscreen
            ld de,PatternRam+Char_Space*CharHeight*2*3
            call InitChar

            ld hl,Offscreen+CharHeight*2
            ld de,PatternRam+Char_Wall*CharHeight*2*3
            call InitChar
        call ToRom
    ei
ret


FromOffscreen:
    di
        in a,(32h) | or 40h | out (32h),a
    	ld a,90h | out (35h),a

        ld b,CharHeight
        do
            ld a,(de) | inc de
            ld (hl),a | inc hl
            ld a,(de) | inc de
            ld (hl),a
            ld a,l | add a,VramWidth-1 | ld l,a
            ld a,h | adc a,0 | ld h,a
        dwnz
    	xor a | out (35h),a
        in a,(32h) | and not 40h | out (32h),a
    ei
ret
