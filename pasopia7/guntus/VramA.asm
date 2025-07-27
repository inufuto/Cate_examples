include "FixedCode.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext AsciiPatternSource_, MonoPatternSource_, ColorPatternSource_
ext VVramFront_, RowFlags_

dseg
Backup:
    defs VVramWidth*VVramHeight


cseg
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


; void InitAsciiPattern();
cseg
InitAsciiPattern_: public InitAsciiPattern_
    push af | push hl | push de | push bc
        di
            in a,(22h)
            push af
                and 2
                out (3ch),a

                ld hl,AsciiPatternRam
                ld de,AsciiPatternSource_
                ld c,AsciiCount
                do
                    ld b,CharHeight
                    do
                        push bc
                            ld a,(de) | inc de
                            call MakeDouble
                            ld (hl),c
                            push bc
                                ld bc,CharHeight
                                add hl,bc
                            pop bc
                            call MakeDouble
                            ld (hl),c
                            push bc
                                ld bc,-CharHeight
                                add hl,bc
                            pop bc
                            inc hl
                        pop bc
                    dwnz
                    push bc
                        ld bc,CharHeight
                        add hl,bc
                    pop bc
                    dec c
                while nz | wend
            pop af
            out (3ch),a
        ei
    pop bc | pop de | pop hl | pop af
ret


; void InitMonoPattern();
cseg
Colors:
    defb 4,05h
    defb 3,07h
    defb 1,06h
    defb 0
InitMonoPattern_: public InitMonoPattern_
    push af | push hl | push de | push bc
        di
            in a,(22h)
            push af
                and 2
                out (3ch),a

                ld hl,PatternRam
                ld de,MonoPatternSource_
                ld bc,Colors
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
            pop af
            out (3ch),a
        ei
    pop bc | pop de | pop hl | pop af
ret


; void InitColorPattern();
cseg
InitColorPattern_: public InitColorPattern_
    push af | push hl | push de | push bc
        di
            in a,(22h)
            push af
                and 2
                out (3ch),a

                ld hl,PatternRam+CharHeight*3*Char_Enemy
                ld de,ColorPatternSource_
                ld bc,(Char_End-Char_Enemy)*CharHeight*3
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
            pop af
            out (3ch),a
        ei
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


cseg
PatternAddressDE:
    ex de,hl
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
    ex de,hl
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call PatternAddressDE
        call TPut
    pop bc | pop de | pop af
ret


VVramToVramRow: public VVramToVramRow
    exx
        push de | push bc
    exx

    ld b,VVramWidth/2
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
                            call TClear8
                        exx
                    else
                        exx
                            call PatternAddressDE
                        exx
                        ld a,b
                        exx
                            or a
                            if z
                                call TPut8
                                jr rowputend
                            endif
                            dec a
                            if z
                                call TClearPut
                                jr rowputend
                            endif
                            dec a
                            if z
                                call TPutPut
                            else
                                                _deb: public _deb
                                call TPutClear
                            endif
                            rowputend:
                        exx
                    endif
                else
                    inc hl
                    exx
                        push bc
                            ld bc,CharHeight
                            add hl,bc
                        pop bc
                    exx
                endif
            endif
        pop bc
    dwnz
    exx
        ld bc,VramRowSize-VVramWidth/2*CharHeight
        add hl,bc
        pop bc | pop de
    exx
ret


; void VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram
        exx
        ld c,VVramHeight
        do
            call VVramToVramRow
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void VVramToVramChanged();
VVramToVramChanged_: public VVramToVramChanged_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram
            ld de,RowFlags_
            ex de,hl
                ld c,1
                ld b,(hl)
                inc hl
            ex de,hl
        exx
        ld c,VVramHeight ; vertical count    
        do
            exx
                ld a,b
                and c
            exx
            if nz
                call VVramToVramRow            
            else
                push bc
                    ld bc,VVramWidth
                    add hl,bc
                    ex de,hl
                        add hl,bc
                    ex de,hl
                pop bc
                exx
                    push bc
                        ld bc,VramRowSize
                        add hl,bc
                    pop bc
                exx
            endif
            exx
                sla c
                if z
                    ex de,hl
                        ld c,1
                        ld b,(hl)
                        inc hl
                    ex de,hl
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


; word PrintC(word vram, byte c);
PrintC_: public PrintC_
    push af | push de | push bc
        ld a,e
        sub ' '
        add a,a ;*2
        add a,a ;*4
        ex de,hl
            ld l,a
            ld h,0
            add hl,hl ;*8
            add hl,hl ;*16
            ld bc,AsciiPatternRam
            add hl,bc
        ex de,hl
        call TPrintC
    pop bc | pop de | pop af
ret