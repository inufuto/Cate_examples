include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext AsciiPatternSource_, MonoPatternSource_, ColorPatternSource_
ext VVramFront_, RowFlags_

dseg
Backup:
    defs VVramWidth*VVramHeight
AsciiPatternRam:
    defs CharHeight*2*AsciiCount
PatternRam: public PatternRam
    defs CharHeight*Char_End

cseg
MakeDouble:
    push af
        and 0f0h
        ld b,a
        rrca | rrca | rrca | rrca
        or b
        ld b,a
    pop af
    and 0fh
    ld c,a
    rlca | rlca | rlca | rlca
    or c
    ld c,a
ret


; void InitAsciiPattern();
cseg
InitAsciiPattern_: public InitAsciiPattern_
    push af | push hl | push de | push bc
        di
            ld hl,AsciiPatternRam
            ld de,AsciiPatternSource_
            ld bc,CharHeight*AsciiCount
            do
                push bc
                    ld a,(de) | inc de
                    call MakeDouble
                    ld (hl),b | inc hl
                    ld (hl),c | inc hl
                pop bc
                dec bc
                ld a,c
                or b
            while nz | wend
        ei
    pop bc | pop de | pop hl | pop af
ret


; void InitMonoPattern();
cseg
Colors:
    defb 4,02h
    defb 4,03h
    defb 0
InitMonoPattern_: public InitMonoPattern_
    push af | push hl | push de | push bc
        di
            ld hl,PatternRam
            ld de,MonoPatternSource_
            ld bc,Colors
            do
                ld a,(bc) | inc bc
                or a
            while nz
                exx
                    ld e,a ; count
                exx
                ld a,(bc) | inc bc ; color
                push bc
                    exx
                        ld b,a ; color
                        ld a,e ; count
                    exx
                    ld b,a ; count
                    do
                        exx
                            ld a,b
                            rrca | rrca
                            and 080h
                            ld d,a ; fore color
                            ld a,b
                            rlca | rlca | rlca
                            and 08h
                            or d
                            ld d,a ; fore color
                            
                            ld a,b
                            rlca | rlca
                            and 080h
                            ld e,a ; back color
                            ld a,b
                            rrca
                            and 08h
                            or e
                            ld e,a ; back color
                        exx
                        push bc
                            ld c,4
                            do
                                ld a,(de) | inc de ; source byte
                                ld b,2
                                do
                                    push bc
                                        exx
                                            ld c,0
                                            ld l,e
                                            ld h,d
                                        exx
                                        ld b,4
                                        do
                                            exx
                                                rlca
                                                push af
                                                    if c
                                                        ld a,c
                                                        or h
                                                        ld c,a
                                                    else
                                                        ld a,c
                                                        or l
                                                        ld c,a
                                                    endif
                                                    srl h
                                                    srl l
                                                pop af
                                            exx
                                        dwnz
                                        push af
                                            exx
                                                ld a,c
                                            exx
                                            ld (hl),a | inc hl
                                        pop af
                                    pop bc
                                dwnz
                                dec c
                            while nz | wend
                        pop bc
                    dwnz
                pop bc
            wend
        ei
    pop bc | pop de | pop hl | pop af
ret


; void InitColorPattern();
cseg
InitColorPattern_: public InitColorPattern_
    push hl | push de | push bc
        di
            ld hl,ColorPatternSource_
            ld de,PatternRam+CharHeight*Char_Enemy
            ld bc,(Char_End-Char_Enemy)*CharHeight
            ldir
        ei
    pop bc | pop de | pop hl
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


PatternAddressDE:
    ex de,hl
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        ld bc,PatternRam
        add hl,bc
    ex de,hl
ret


Put8:
    ld b,CharHeight
    do
        ld a,(de)
        inc de
        ld (hl),a
        ld a,h
        add a,8
        ld h,a
    dwnz
ret


Put4:
    ld b,CharHeight/2
    do
        ld a,(de)
        inc de
        ld (hl),a
        ld a,h
        add a,8
        ld h,a
    dwnz
ret


Clear8:
    ld b,CharHeight
    do
        ld (hl),0
        ld a,h
        add a,8
        ld h,a
    dwnz
ret


Clear4:
    ld b,CharHeight/2
    do
        ld (hl),0
        ld a,h
        add a,8
        ld h,a
    dwnz
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call PatternAddressDE
        call Put8
        inc hl
        ld a,h
        sub 8*CharHeight
        ld h,a
    pop bc | pop de | pop af
ret


VVramToVramRow:
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
                            call Clear8
                        exx
                    else
                        exx
                            call PatternAddressDE
                        exx
                        ld a,b
                        exx
                            or a
                            if z
                                call Put8
                                            _deb: public _deb
                                jr rowputend
                            endif
                            dec a
                            if z
                                call Clear4
                                call Put4
                                jr rowputend
                            endif
                            dec a
                            if z
                                push de
                                    inc de | inc de | inc de | inc de
                                    call Put4
                                pop de
                                ex de,hl
                                    ld bc,CharHeight*4
                                    add hl,bc
                                ex de,hl
                                call Put4
                            else
                                inc de | inc de | inc de | inc de
                                call Put4
                                call Clear4
                            endif
                            rowputend:
                        exx
                    endif
                    exx
                        ld a,h
                        sub 8*CharHeight
                        ld h,a
                    exx
                else
                    inc hl
                endif
                exx
                    inc hl
                exx
            endif
        pop bc
    dwnz
    exx
        ld bc,VramRowSize-VVramWidth/2
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
    push af | push hl | push de | push bc
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
        ld b,CharHeight
        do
            ld a,(de) | inc de
            ld (hl),a | inc hl
            ld a,(de) | inc de
            ld (hl),a | dec hl
            ld a,h
            add a,8
            ld h,a
        dwnz
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret
