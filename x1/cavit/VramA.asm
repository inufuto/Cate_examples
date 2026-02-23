include 'Vram.inc'

VVramWidth    equ 32
VVramHeight    equ 22

GVramTop equ GVram+VramWidth

ext VVram_, RowFlags_
ext ClearVVram_
ext PollVSync_
ext SpriteChars


dseg
Backup: defs VVramWidth*VVramHeight


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


; void SetPcgMono(byte code, ptr<byte> pPattern, byte color, byte count);
dseg
    SetPcgMono_@Param3: public SetPcgMono_@Param3
        defb 0
    tempPattern:
        defs 24
cseg
SetPcgMono_: public SetPcgMono_
    push af | push hl | push de | push bc
        ex af,af'
            ld a,(SetPcgMono_@Param3)
            ld b,a
        ex af,af'
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

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop hl | pop af
ret


VVramToVramRow:
; hl: pVVram
; bc: pVram
        ld e,VVramWidth
        do
            call PollVSync_
            ld a,(hl)
            inc hl
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
                ld de,SpriteChars
                add hl,de
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
            pop de | pop hl
            ld a,b
            add a,-8*CharHeight*3
            ld b,a
            inc bc
            dec e
        while nz | wend
        ld a,c
        add a,VramWidth-VVramWidth
        ld c,a
        ld a,b
        adc a,0
        ld b,a
ret

; VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld bc,GVramTop
        ld d,VVramHeight
        do
            call PollVSync_
            call VVramToVramRow
            dec d
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret



; void VVramToVramChanged();
cseg
VVramToVramChanged_: public VVramToVramChanged_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld bc,GVramTop
        exx
            ld hl,RowFlags_
            ld c,1
            ld b,(hl)
            inc hl
        exx
        ld d,VVramHeight ; vertical count    
        do
            call PollVSync_
            push de
                exx
                    ld a,b
                    and c
                exx
                if nz
                    call VVramToVramRow         
                else
                    ld a,c
                    add a,VramWidth
                    ld c,a
                    ld a,b
                    adc a,0
                    ld b,a
                    ld de,VVramWidth
                    add hl,de
                endif
                exx
                    rlc c
                    if c
                        ld b,(hl)
                        inc hl
                    endif
                exx
            pop de
            dec d
        while nz | wend

        xor a
        ld (RowFlags_),a
        ld (RowFlags_+1),a
        ld (RowFlags_+2),a
    pop bc | pop de | pop hl | pop af
ret


; void VPut(word vram, byte c);
cseg
VPut_: public VPut_
    push af | push bc
        ld a,e
        ld c,l
        ld b,h
        out (c),a
    pop bc | pop af
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


; word VramAddress(byte x, byte y);
VramAddress_: public VramAddress_
    push af | push de
        ld d,a
        ld a,e
        add a,a ; *2
        add a,a ; *4
        add a,e ; *5
        ld l,a
        ld h,0
        add hl,hl; *10
        add hl,hl; *20
        add hl,hl; *40
        ld e,d
        ld d,0
        add hl,de
        ld de,Vram
        add hl,de
    pop de | pop af
ret
