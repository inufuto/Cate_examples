include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
ToRam:
	;64K RAM
    push af
        ld a,(0e6c2h)
        or 2
        out (31h),a
        ld (0e6c2h),a
    pop af
ret

ToRom:
	;N88 ROM
    push af
        ld a,(0e6c2h)
        and not 2
        out (31h),a
        ld (0e6c2h),a
    pop af
ret

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
        add hl,hl ;*48
        ld de,PatternRam
        add hl,de
    pop de
ret


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 16, 1 ; Wall
defb 32,3 ; Monster
defb 4,6 ; Dot
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

    ld hl,PatternRam+PatternSize*Char_Man
    ld de,ColorPattern
    ld c,Char_End-Char_Color
    call MakePatternColor
ret


MakePatternMono: public MakePatternMono
    push de
        ld l,a | ld h,0
        ld e,l | ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        add hl,hl ;*48
        ld de,PatternRam
        add hl,de
    pop de
    di
        push hl | exx | pop hl | exx
        call ToRam
        ld a,c ; color
        do
            push af
                exx
                    ld d,a
                exx
                ld c,3
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
                                ld a,e
                                ld e,2
                                do
                                    ld bc,400h
                                    do
                                        sla c
                                        sla c
                                        rlca
                                        if c
                                            set 0,c
                                            set 1,c
                                        endif
                                    dwnz
                                    ld (hl),c
                                    inc hl
                                    dec e
                                while nz | wend
                            exx
                            inc de
                            dec h
                        while nz | wend
                        exx
                            srl d
                        exx
                    pop de
                    dec c
                while nz | wend
                ex de,hl
                    ld de,8
                    add hl,de
                ex de,hl
            pop af
        dwnz    
        call ToRom
    ei
ret


MakePatternColor: public MakePatternColor
    di
        push hl | exx | pop hl | exx
        call ToRam
        do
            ld b,24
            do
                ld a,(de)
                inc de
                exx
                    ld e,2
                    do
                        ld bc,400h
                        do
                            sla c
                            sla c
                            rlca
                            if c
                                set 0,c
                                set 1,c
                            endif
                        dwnz
                        ld (hl),c
                        inc hl
                        dec e
                    while nz | wend
                exx
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
