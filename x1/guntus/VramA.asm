include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext AsciiPatternSource_, MonoPatternSource_, ColorPatternSource_
ext TVVram_, GVVram_, RowFlags_
ext PollVSync_

dseg
Backup: 
    defs GVVramWidth*VVramHeight
PatternRam: public PatternRam
    defs CharHeight*3*GChar_End


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
    ld bc,TVram+VramWidth*VramHeight
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
        ld bc,TVram
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

MakeDouble:
    ld bc,0c000h
    do
        rlca
        if c
            ex af,af'
                ld a,c
                or b
                ld c,a
            ex af,af'
        endif
        srl b | srl b
    while nz | wend
ret


; void InitAsciiPcg();
cseg
InitAsciiPcg_: public InitAsciiPcg_
    push af | push hl | push de | push bc | push ix
        ld de,AsciiPatternSource_
        ld c,0
        do
            ld ix,PatternRam
            ld b,8
            do
                push bc
                    ld a,(de) | inc de
                    call MakeDouble
                    ld (ix),c
                    ld (ix+CharHeight),c
                    ld (ix+CharHeight*2),c
                    call MakeDouble
                    ld (ix+CharHeight*3),c
                    ld (ix+CharHeight*4),c
                    ld (ix+CharHeight*5),c
                    inc ix
                pop bc
            dwnz
            ld a,c
            ld hl,PatternRam
            call SetPcg
            inc c
            
            ld a,c
            ld hl,PatternRam+CharHeight*3
            call SetPcg
            inc c

            ld a,c
            cp Char_Logo
        while nz | wend
    pop ix | pop bc | pop de | pop hl | pop af
ret


; void InitMonoPattern();
cseg
ColorTable:
    defb 4,05h
    defb 3,07h
    defb 1,06h
    defb 0
InitMonoPattern_: public InitMonoPattern_
    push af | push hl | push de | push bc
        ld hl,PatternRam
        ld de,MonoPatternSource_
        ld bc,ColorTable
        do
            ld a,(bc) | inc bc
            or a
        while nz
            exx
                ld e,a
            exx
            ld a,(bc) | inc bc
            push bc
                exx
                    ld b,a
                    ld a,e
                exx
                ld b,a
                do
                    exx
                        ld d,b
                    exx
                    ld c,3
                    do
                        push de | push bc
                            ld b,4
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
                                ld a,(de) | inc de
                                exx
                                    bit 4,d
                                    if nz
                                        cpl
                                        or e
                                        ld e,a
                                    endif
                                    ld a,e
                                exx
                                push bc
                                    call MakeDouble
                                    ld (hl),c | inc hl
                                    call MakeDouble
                                    ld (hl),c | inc hl
                                pop bc
                            dwnz
                        pop bc | pop de
                        exx
                            srl d
                        exx
                        dec c
                    while nz | wend
                    push bc
                        ex de,hl
                            ld bc,CharHeight/2
                            add hl,bc
                        ex de,hl
                    pop bc
                dwnz
            pop bc
        wend
    pop bc | pop de | pop hl | pop af
ret


; void InitColorPattern();
cseg
InitColorPattern_: public InitColorPattern_
    push af | push hl | push de | push bc
        ld hl,PatternRam+CharHeight*3*GChar_Enemy
        ld de,ColorPatternSource_
        ld bc,(GChar_End-GChar_Enemy)*CharHeight*3
        do
            push bc
                ld a,(de) | inc de
                call MakeDouble
                ld (hl),c | inc hl
                call MakeDouble
                ld (hl),c | inc hl
            pop bc
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void InitColorPcg();
CharTable:
    defw PatternRam+CharHeight*3*GChar_Logo, (Char_Logo shl 8) or (GChar_FighterBullet-GChar_Logo)
    defw PatternRam+CharHeight*3*GChar_EnemyA, (Char_EnemyA shl 8) or 8
    defw PatternRam+CharHeight*3*GChar_EnemyB, (Char_EnemyB shl 8) or 8
    defw PatternRam+CharHeight*3*GChar_EnemyC, (Char_EnemyC shl 8) or 8
    defw PatternRam+CharHeight*3*GChar_Fighter, (Char_Fighter shl 8) or 8
cseg
InitColorPcg_: public InitColorPcg_
    push af | push hl | push de | push bc
        ld c,5
        ld de,CharTable
        do
            ld a,(de) | inc de
            ld l,a
            ld a,(de) | inc de
            ld h,a
            ld a,(de) | inc de
            ld b,a
            ld a,(de) | inc de
            do
                call SetPcg
                push de
                    ld de,CharHeight*3
                    add hl,de
                pop de
                inc a
            dwnz
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void ClearScreen();
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld bc,TVram
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

        ld hl,Backup
        ld bc,GVVramWidth*VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
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
    call PollVSync_
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    push af | push bc
        ld a,e
        sub ' '
        add a,a
        ld c,l
        ld b,h
        out (c),a
        inc bc
        inc a
        out (c),a
    pop bc | pop af
    inc hl | inc hl
    call PollVSync_
ret


PutN:
    do
        ld a,(de)
        inc de
        out (c),a
        ld a,b
        add a,8
        ld b,a
        
        dec h
    while nz | wend
ret

Put8:
    ld l,3
    do
        ld h,CharHeight
        call PutN
        dec l
    while nz | wend
    ld a,b
    add a,-192
    ld b,a
ret

Put4:
    ld l,3
    do
        ld h,CharHeight/2
        call PutN
        ld a,b
        add a,8*CharHeight/2
        ld b,a
        inc de | inc de | inc de | inc de
        dec l
    while nz | wend
ret

ClearN:
    do
        xor a
        out (c),a
        ld a,b
        add a,8
        ld b,a
        
        dec h
    while nz | wend
ret

Clear8:
    ld l,3
    do
        ld h,CharHeight
        call ClearN
        dec l
    while nz | wend
    ld a,b
    add a,-192
    ld b,a
ret


Clear4:
    ld l,3
    do
        ld h,CharHeight/2
        call ClearN
        ld a,b
        add a,8*CharHeight/2
        ld b,a

        dec l
    while nz | wend
ret

GVVramToVramRow:
    exx
        push hl | push de
    exx

    ld b,GVVramWidth/2
    do 
        push bc
            ld a,(de) | inc de
            ld c,a
            cp (hl)
            if nz
                ld (hl),a | inc hl
                ld a,(de) | inc de
                ld b,a
                ld (hl),a | inc hl
                jr rowput
            else
                inc hl
                ld a,(de) | inc de
                ld b,a
                cp (hl)
                if nz
                    ld (hl),a | inc hl
                    rowput:
                    ld a,c
                    or a
                    if z
                        exx
                            call Clear8                    
                        exx
                    else
                        exx
                            ex de,hl
                                push bc
                                    ld l,a
                                    ld h,0
                                    ld c,l
                                    ld b,h
                                    add hl,hl ;*2
                                    add hl,bc ;*3
                                    add hl,hl ;*6
                                    add hl,hl ;*12
                                    add hl,hl ;*24
                                    ld bc,PatternRam
                                    add hl,bc
                                pop bc
                            ex de,hl
                        exx
                        ld a,b
                        exx
                            or a
                            if z
                                call Put8
                                jr rowputend
                            endif
                            dec a
                            if z
                                call Clear4
                                ld a,b
                                add a,-192+8*CharHeight/2
                                ld b,a
                                call Put4
                                ld a,b
                                add a,8*CharHeight/2
                                ld b,a
                                jr rowputend
                            endif
                            dec a
                            if z
                                                _deb: public _deb
                                inc de | inc de | inc de | inc de

                                call Put4
                                ld a,b
                                add a,-192+8*CharHeight/2
                                ld b,a
                                
                                ld a,e
                                add a,CharHeight*3*3-CharHeight/2
                                ld e,a
                                ld a,d
                                adc a,0
                                ld d,a
                                
                                call Put4
                                ld a,b
                                add a,8*CharHeight/2
                                ld b,a
                            else
                                inc de | inc de | inc de | inc de
                                call Put4
                                ld a,b
                                add a,-192+8*CharHeight/2
                                ld b,a
                                call Clear4
                                ld a,b
                                add a,8*CharHeight/2
                                ld b,a
                            endif
                            rowputend:
                        exx
                    endif
                else
                    inc hl
                endif
                exx
                    inc bc
                exx
            endif
        pop bc
        ld a,b
        and 0fh
        call z,PollVSync_
    dwnz
    exx
        ld a,c
        add a,VramWidth-GVVramWidth/2
        ld c,a
        ld a,b
        adc a,0
        ld b,a

        pop de | pop hl
    exx
ret


; void GVVramToVramAll();
GVVramToVramAll_: public GVVramToVramAll_
    push af | push hl | push de | push bc
        ld de,GVVram_
        ld hl,Backup
        exx
            ld bc,GVram
        exx
        ld c,VVramHeight
        do
            call GVVramToVramRow
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void GVVramToVramChanged();
GVVramToVramChanged_: public GVVramToVramChanged_
    push af | push hl | push de | push bc
        ld de,GVVram_
        ld hl,Backup
        exx
            ld bc,GVram
            ld de,RowFlags_
            ld a,(de) | inc de
            ld h,a
            ld l,1
        exx
        ld c,VVramHeight ; vertical count    
        do
            exx
                ld a,h
                and l
            exx
            if nz
                call GVVramToVramRow            
            else
                push bc
                    ld bc,GVVramWidth
                    add hl,bc
                    ex de,hl
                        add hl,bc
                    ex de,hl
                pop bc
                exx
                    ld a,c
                    add a,VramWidth
                    ld c,a
                    ld a,b
                    adc a,0
                    ld b,a
                exx
            endif
            exx
                sla l
                if z
                    ld a,(de) | inc de
                    ld h,a
                    ld l,1
                endif
            exx
            dec c
        while nz | wend

        xor a
        ld (RowFlags_),a
        ld (RowFlags_+1),a
        ld (RowFlags_+2),a
    pop bc | pop de | pop hl | pop af
ret


; void TVVramToVram();
TVVramToVram_: public TVVramToVram_
    push af | push hl | push de | push bc
        ld de,TVVram_
        ld bc,TVram
        ld l,VVramHeight
        do
            ld h,TVVramWidth
            do
                ld a,(de) | inc de
                out (c),a | inc bc
                dec h
            while nz | wend
            ld a,c
            add a,VramWidth-TVVramWidth
            ld c,a
            ld a,b
            adc a,0
            ld b,a

            call PollVSync_
            dec l
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
