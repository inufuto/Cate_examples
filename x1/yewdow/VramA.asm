include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext ClearVVramFront_
ext PollVSync_
ext VVramFront_, VVramBack_
ext MonoPattern, ColorPattern, SpritePattern


dseg
BackupBack:
    defs VVramWidth*VVramHeight
BackupFront:
    defs VVramWidth*VVramHeight
tempPattern:
    defs PatternSize


cseg
WaitVSync_: public WaitVSync_
    push af | push bc
        ld bc,1a01h
        do
            in a,(c)
            and 80h
        while z | wend
        do
            in a,(c)
            and 80h
        while nz | wend
    pop bc | pop af
ret

FillVramExtra:
    ld bc,VRAM+VramWidth*VramHeight
    ld d,20h
    do
        out (c),e
        res 4,b
        out (c),d
        set 4,b
        inc bc
        ld a,c
        or a
    while nz | wend
ret

WriteCG:
    ld d,8
    di
        call WaitVSync_
        WriteCG0:
            ld a,(hl)
            out (c),a
            inc hl
            inc bc
            nop
            inc hl
            dec hl
            ld a,13
            WriteCG1:
                dec a
            jp nz,WriteCG1
            dec d
        jp nz,WriteCG0
    ei
ret

SetPcg: public SetPcg
; a: char code
; hl: pPattern
    push af | push hl | push de | push bc
        ld e,a
        ld bc,Attributes
        ld a,Attribute_PCG or 7
        out (c),a
        ld bc,VRAM
        out (c),e

        call FillVramExtra
        ld bc,1500h
        do 
            call WriteCG
            inc b
            ld a,b
            cp 18h
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


cseg
ColorTable:
defb 64, 7h ; Ascii
defb 16, 5h ; Logo
defb 6, 1h ; Fence
defb 0
InitVram: public InitVram
    call ClearScreen_
    
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
    ld de,ColorPattern
    push af
        neg
        add a,Char_End
        ld c,a
    pop af
    call MakePatternColor
ret

MakePatternMono:
    do
        push bc
            push af
                exx
                    ld hl,tempPattern
                exx
                ld b,3
                do 
                    push de
                        ld h,8
                        do
                            ld l,0
                            ld a,(de)
                            bit 0,c
                            if nz
                                or l
                                ld l,a
                            endif
                            bit 4,c
                            if nz
                                cpl
                                or l
                                ld l,a
                            endif
                            ld a,l
                            exx
                                ld (hl),a
                                inc hl
                            exx
                            inc de
                            dec h
                        while nz | wend
                    pop de
                    srl c
                dwnz
            pop af
            ld hl,tempPattern
            call SetPcg
            ex de,hl
                ld de,8
                add hl,de
            ex de,hl
        pop bc
        inc a
    dwnz
ret

MakePatternColor:
    ex de,hl
    ld de,PatternSize
    do
        call SetPcg
        add hl,de
        inc a
        dec c
    while nz | wend
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld bc,Vram
        ld hl,VramWidth*VramHeight
        do
            xor a
            out (c),a
            inc bc
            dec hl
            ld a,l
            or h
        while nz | wend

        ld bc,Attributes
        ld hl,VramWidth*VramHeight
        do
            ld a,Attribute_PCG or 7
            out (c),a
            inc bc
            dec hl
            ld a,l
            or h
        while nz | wend

        ld bc,GVram
        ld hl,0c000h
        do
            xor a
            out (c),a
            inc bc
            dec hl
            ld a,l
            or h
        while nz | wend

        ld hl,BackupBack
        ld de,BackupBack+1
        ld bc,VVramWidth*VVramHeight*2-1
        ld (hl),0
        ldir

        call ClearVVramFront_
    pop bc | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push bc
        ld a,e
        ld c,l
        ld b,h
        out (c),a
        inc hl
    pop bc | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,BackupFront
        ld de,VVramFront_
        exx
            ld bc,GVram+VramWidth
        exx
        ld c,VVramHeight ; vertical count    
        do
            ld b,VVramWidth
            do
                call PollVSync_
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    push hl | push de
                        ld l,a
                        ld h,0
                        ld e,a
                        ld d,0
                        add hl,hl ;*2
                        add hl,de ;*3
                        add hl,hl ;*6
                        add hl,hl ;*12
                        add hl,hl ;*24
                        ld de,SpritePattern
                        add hl,de

                        ld d,3
                        do
                            ld e,CharHeight
                            do
                                ld a,(hl) | inc hl
                                exx
                                    out (c),a
                                    ld a,b | add a,8 | ld b,a
                                exx
                                dec e
                            while nz | wend
                            dec d
                        while nz | wend
                        exx
                            ld a,b | add a,-8*CharHeight*3 | ld b,a
                        exx
                    pop de | pop hl
                endif
                inc hl
                exx
                    inc bc
                exx
            dwnz
            exx
                ld a,c | add a,VramWidth-VVramWidth | ld c,a
                ld a,b | adc a,0 | ld b,a
            exx
            dec c
        while nz | wend

        ld hl,BackupBack
        ld de,VVramBack_
        exx
            ld bc,Vram+VramWidth
        exx
        ld c,VVramHeight ; vertical count    
        do
            ld b,VVramWidth
            do
                call PollVSync_
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        out (c),a
                    exx
                endif
                inc hl
                exx
                    inc bc
                exx
            dwnz
            exx
                ld a,c | add a,VramWidth-VVramWidth | ld c,a
                ld a,b | adc a,0 | ld b,a
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
