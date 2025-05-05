include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext ToRam, ToRom, PatternAddress, InitVram0

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 4 ; Logo
defb 8,7 ; Stair
defb 4,6 ; Goal
defb 16,7 ; Point
defb 0
InitVram: public InitVram
    ld hl,ColorTable
    call InitVram0
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
            ld a,5ch
            do
                ld c,a
                out (c),a
                ld hl,0c000h
                ld de,0c001h
                ld bc,640/8*200-1
                ld (hl),0
                ldir
                inc a
                cp 5fh
            while nz | wend
            out (5fh),a
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
                push bc 
                    ld a,(de)
                    inc de
                    or a
                    if z
                        ld a,(hl)
                        cp Char_Wall
                        if z
_deb: public _deb
                            exx
                                xor a
                                call SetWall
                            exx
                            xor a
                            ld (hl),a
                            jr VVramToVram_next
                        endif
                        xor a
                    endif
                    cp Char_Wall
                    if z
                        ld a,(hl)
                        or a
                        if z
                            exx
                                ld a,0ffh
                                call SetWall
                            exx
                            ld a,Char_Wall
                            ld (hl),a
                            jr VVramToVram_next
                        endif
                        ld a,Char_Wall
                    endif
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
                    VVramToVram_next:
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


SetWall:
    ld de,VramWidth-1
    di
        ld b,CharHeight
        out (5eh),a
        do
            ld (hl),a | inc hl
            ld (hl),a
            add hl,de
        dwnz
        out (5fh),a
    ei
    ld de,2-VramRowSize
    add hl,de
ret
