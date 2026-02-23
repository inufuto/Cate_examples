include 'Vram.inc'

WindowWidth equ 24
WindowHeight equ 24

ext WindowFront_, WindowBack_, RowFlags_
ext ClearWindowFront_
ext CallSound_

dseg
Backup:
    defs WindowWidth*WindowHeight*2

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


; void SetPcgMono(byte code, ptr<byte> pPattern, byte count, byte color);
dseg
    SetPcgMono_@Param3: public SetPcgMono_@Param3
        defb 0
    tempPattern:
        defs 24
cseg
SetPcgMono_: public SetPcgMono_
    push af | push hl | push de | push bc
        do
            push bc
                push af
                    ld a,(SetPcgMono_@Param3)
                    ld c,a
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
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void SetPcgColor(byte code, ptr<byte> pPattern, byte count);
cseg
SetPcgColor_: public SetPcgColor_
    push af | push hl | push de | push bc
        ex de,hl
        ld de,PatternSize
        do
            call SetPcg
            add hl,de
            inc a
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void ClearSpriteRam();
ClearSpriteRam_: public ClearSpriteRam_
    push af | push hl | push de | push bc
        ld hl,SpriteRam
        ld e,0
        ld bc,PatternSize*256*3
        do
            ld (hl),e
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


CharToAddress:
; in
;   hl code
; out
;   hl pDestination
    push de
        ld e,l
        ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld de,SPriteRam
        add hl,de
    pop de
ret

WidthToOffset:
; in
;   c width
; out
;   bc offset
    push af
        ld a,c
        add a,a ;*2
        add a,c ;*3
        add a,a ;*6
        add a,a ;*12
        add a,a ;*24
        sub 8
        ld c,a
        ld b,0
    pop af
ret


; void WritePattern(word c, ptr<byte> pSource);
WritePattern_: public WritePattern_
    push hl | push de | push bc
        call CharToAddress
        ex de,hl
        ld bc,PatternSize
        ldir
    pop bc | pop de | pop hl
ret


; void WritePatternH(word c, ptr<byte> pSource);
WritePatternH_: public WritePatternH_
    push af | push hl | push de | push bc
        call CharToAddress
        ld b,3
        do
            push bc
                push hl 
                    ld c,CharHeight
                    do
                        ld a,(de)
                        inc de
                        push de
                            exx
                                ld h,a
                                ld l,0
                                srl h | rr l 
                                srl h | rr l 
                                srl h | rr l 
                                srl h | rr l 
                                ld a,h
                            exx
                            or (hl)
                            ld (hl),a
                            ld de,PatternSize
                            add hl,de
                            exx
                                ld a,l
                            exx
                            or (hl)
                            ld (hl),a
                            ld de,-PatternSize+1
                            add hl,de
                        pop de
                        dec c
                    while nz | wend
                pop hl
                ld bc,CharHeight
                add hl,bc
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void WritePatternV(word c, ptr<byte> pSource, byte width);
WritePatternV_: public WritePatternV_
    push af | push hl | push de | push bc
        call CharToAddress
        call WidthToOffset
        inc hl
        inc hl
        inc hl
        inc hl

        ld a,3
        do
            push af | push hl
                ld a,2
                do
                    push bc
                        ex de,hl
                        ld bc,CharHeight/2
                        ldir
                        ex de,hl
                    pop bc
                    add hl,bc
                    dec a
                while nz | wend
            pop hl | pop af
            push bc
                ld bc,CharHeight
                add hl,bc
            pop bc
            dec a
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void WritePatternHV(word c, ptr<byte> pSource, byte width);
WritePatternHV_: public WritePatternHV_
    push af | push hl | push de | push bc
        call CharToAddress
        call WidthToOffset
        inc hl
        inc hl
        inc hl
        inc hl

        ld a,3
        do
            push af | push hl
                ld a,2
                do
                    push af | push bc
                        ld b,CharHeight/2
                        do
                            ld a,(de)
                            inc de
                            push de
                                exx
                                    ld h,a
                                    ld l,0
                                    srl h | rr l 
                                    srl h | rr l 
                                    srl h | rr l 
                                    srl h | rr l 
                                    ld a,h
                                exx
                                or (hl)
                                ld (hl),a
                                ld de,PatternSize
                                add hl,de
                                exx
                                    ld a,l
                                exx
                                or (hl)
                                ld (hl),a
                                ld de,-PatternSize+1
                                add hl,de
                            pop de
                        dwnz
                    pop bc | pop af
                    add hl,bc
                    dec a
                while nz | wend
            pop hl | pop af
            push bc
                ld bc,CharHeight
                add hl,bc
            pop bc
            dec a
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void ClearScreen();
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

        call ClearWindowFront_

        ld hl,Backup
        ld bc,WindowWidth*WindowHeight*2
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop hl | pop af
ret


; WindowBackToVram();
WindowBackToVram_: public WindowBackToVram_
    push af | push hl | push de | push bc
        ld hl,WindowBack_
        ld bc,VramLeftTop
        ld d,WindowHeight
        do
            call CallSound_
            ld e,WindowWidth
            do
                ld a,(hl)
                inc hl
                out (c),a
                inc bc
                dec e
            while nz | wend
            ld a,c
            add a,VramWidth-WindowWidth
            ld c,a
            ld a,b
            adc a,0
            ld b,a
            dec d
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret

; void GPut1(word gram, word code);
GPut1_: public GPut1_
    push af | push hl | push de | push bc
        ld c,l
        ld b,h
        ld l,e
        ld h,d
        call CharToAddress
        ld d,3
        do
            ld e,CharHeight
            do
                ld a,(hl)
                inc hl
                out (c),a
                ld a,b
                add a,8
                ld b,a
                dec e
            while nz | wend
            ;ld a,b
            ;add a,-8*CharHeight+40h
            ;ld b,a
            dec d
        while nz | wend
        call CallSound_
    pop bc | pop de | pop hl | pop af
ret


; WindowFrontToVram();
WindowFrontToVram_: public WindowFrontToVram_
    push af | push hl | push de | push bc
        ld ix,WindowFront_
        ld iy,Backup
        ld hl,GVramLeftTop
        exx
            ld hl,RowFlags_
            ld e,1
            ld d,(hl)
            inc hl
        exx
        ld c,WindowHeight ; vertical count    
        do
            exx
                ld a,d
                and e
            exx
            if nz
                ld b,WindowWidth
                do 
                    ld e,(ix)
                    ld d,(ix+1)
                    ld a,e
                    cp (iy)
                    jr nz,WindowFrontToVram_ne
                    ld a,d
                    cp (iy+1)
                    if nz
                        WindowFrontToVram_ne:
                        ld (iy),e
                        ld (iy+1),d
                        call GPut1_
                    endif
                    inc hl
                    inc ix
                    inc ix
                    inc iy
                    inc iy
                dwnz
                push bc
                    ld bc,VramWidth-WindowWidth
                    add hl,bc
                pop bc
            else
                ld de,WindowWidth*2
                add ix,de
                add iy,de
                ld de,VramWidth
                add hl,de
            endif
            exx
                rlc e
                if c
                    ld d,(hl)
                    inc hl
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


; void VPut1(word vram, word c);
VPut1_: public VPut1_
    push bc
        ld c,l
        ld b,h
        out (c),e
    pop bc
ret


; void VPut2(word vram, word c);
cseg
VPut2_: public VPut2_
    push hl | push de | push bc
        ld b,2
        do
            push bc
                call VPut1_
                inc hl
                inc e
                call VPut1_
                inc e
                ld bc,VramWidth - 1
                add hl,bc
            pop bc
        dwnz
    pop bc | pop de | pop hl
ret


; void VErase2(word vram);
cseg
VErase2_: public VErase2_
    push hl | push de | push bc
        ld b,2
        do
            ld de,0
            call VPut1_
            inc hl
            call VPut1_
            ld de,VramWidth - 1
            add hl,de
        dwnz
    pop bc | pop de | pop hl
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    push af | push bc
        ld a,e
        sub ' '
        ld c,l
        ld b,h
        out (c),a
        inc hl
    pop bc | pop af
ret


; void PlotMarker(word gram, word bytes);
PlotMarker_: public PlotMarker_
    push af | push hl | push bc
        ld c,l
        ld b,h
        ld h,2
        do
            push bc
                ld l,3
                do
                    in a,(c)
                    xor d
                    out (c),a
                    inc bc
                    in a,(c)
                    xor e
                    out (c),a
                    dec bc
                    ld a,b
                    add a,40h
                    ld b,a
                    dec l
                while nz | wend
            pop bc
            ld a,b
            add a,8
            ld b,a
            cp 80h
            if nc
                push hl
                    ld hl,-800h*8+VramWidth
                    add hl,bc
                    ld c,l
                    ld b,h
                pop hl
            endif
            dec h
        while nz | wend
    pop bc | pop hl | pop af
ret
