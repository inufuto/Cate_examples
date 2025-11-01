include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVramFront_

dseg
PatternRam: public PatternRam
    defs PatternSize*Char_End
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
pBackup:
	defw 0
Page: public Page
	defb 0

cseg
ColorTable:
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
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
ret

PatternPtr:
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
ret
MakePatternMono: public MakePatternMono
    call PatternPtr
    ld a,c ; color
    exx
        ld c,a
    exx
    do
        ld c,CharHeight
        do
            push bc
                ld a,(de) | inc de
                push de
                    ld e,a
                    exx
                        ld a,c ; color
                    exx
                    ld c,a ; color
                    ld b,PlaneCount
                    do
                        ld d,0 ; byteValue
                        bit 0,c
                        if nz
                            ld a,d | or e | ld d,a
                        endif
                        bit 4,c
                        if nz
                            ld a,e
                            cpl
                            or d
                            ld d,a
                        endif
                        ld a,d
                        ld (hl),d | inc hl
                        srl c
                    dwnz
                pop de
            pop bc
            dec c
        while nz | wend
    dwnz    
ret


MakePatternColor:
    do
        ld b,CharHeight*PlaneCount
        do
            ld a,(de)
            inc de
            ld (hl),a
            inc hl
        dwnz
        dec c
    while nz | wend
ret


OnVram:
    di
    in a,(22h)
    and 03h
    or 04h
    out (3ch),a
ret

OffVram:
    in a,(22h)
    and not 04h
    out (3ch),a
    ei
ret

; void ClearScreen();
cseg
Clear:
    ld (hl),0
    ld e,l | ld d,h
    inc de
    dec bc
    ldir
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        call OnVram
            ld a,77h | out (0ch),a
            ld hl,Vram0
            ld bc,4000h
            call Clear
            xor a | out (0ch),a
        call OffVram

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight*2
        call Clear

        ld hl,Backup1 | ld (pBackup),hl
        ld a,high Vram1 | ld (Page),a
        ld a,12 | out (10h),a
        ld a,0 | out (11h),a
    pop bc | pop de | pop hl | pop af
ret


cseg
Put:
    ex de,hl
        call PatternPtr
    ex de,hl
    call OnVram
        ld c,CharHeight
        do
            ld a,11h
            ld b,PlaneCount
            do
                out (0ch),a
                ex af,af'
                    ld a,(de) | inc de
                    ld (hl),a
                    set 5,h
                    ld (hl),a
                    res 5,h
                ex af,af'
                add a,a
            dwnz
            xor a | out (0ch),a
            inc hl
            dec c
        while nz | wend
    call OffVram
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call Put
    pop bc | pop de | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push de | push bc
        push hl
            ld a,e
            ld bc,30*256
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
        pop hl
        ld a,c
        call Put
    pop bc | pop de | pop af
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,(pBackup)
        exx
            ld a,(Page)
            ld h,a | ld l,0
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
                                ex de,hl
                                    call PatternPtr
                                ex de,hl
                                call OnVram
                                    ld c,CharHeight
                                    do
                                        ld a,11h
                                        ld b,PlaneCount
                                        do
                                            out (0ch),a
                                            ex af,af'
                                                ld a,(de) | inc de
                                                ld (hl),a
                                            ex af,af'
                                            add a,a
                                        dwnz
                                        xor a | out (0ch),a
                                        inc hl
                                        dec c
                                    while nz | wend
                                call OffVram                            
                            pop de
                        exx
                    else
                        exx
                            ld a,l | add a,CharHeight | ld l,a
                            ld a,h | adc a,0 | ld h,a
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            exx
                ld a,l | add a,low(VramRowSize-VVramWidth*CharHeight) | ld l,a
                ld a,h | adc a,high(VramRowSize-VVramWidth*CharHeight) | ld h,a
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    push af | push hl | push bc
        ld a,(Page)
        cp high Vram0
        if nz
            ld a,high Vram0
            ld hl,Backup0
            ld c,4
        else
            ld a,high Vram1
            ld hl,Backup1
            ld c,0
        endif
        ld (Page),a
        ld (pBackup),hl
        ld a,12 | out (10h),a
        ld a,c | out (11h),a
    pop bc | pop hl | pop af
ret


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
    push af | push hl | push de | push bc
        ld l,e | ld h,0
        ld e,a
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld d,0 | add hl,de
        ld de,(pBackup) | add hl,de

        ld de,VVramWidth-2
        ld c,2
        do
            ld a,0ffh
            ld b,2
            do
                ld (hl),a | inc hl
            dwnz
            add hl,de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


SpritePatternHlDash:
    ex af,af'
        ld a,c
        exx
            ld h,a | ld l,0
            srl h | rr l
            ld bc,SpritePattern | add hl,bc
        exx
    ex af,af'
ret
VramAddress:
    ld d,0
    ld l,e | ld h,d
    add hl,hl ;*2
    add hl,hl ;*4
    add hl,de ;*5
    add hl,hl ;*10
    add hl,hl ;*20
    add hl,hl ;*40
    ld c,a | ld b,0
    add hl,bc
    add hl,hl ;*2
    add hl,hl ;*4
    add hl,hl ;*8
    ld a,(Page)
    add a,h | ld h,a
ret

; void DrawSprite1(byte x, byte y, byte pattern);
cseg
DrawSprite1_: public DrawSprite1_
    push af | push hl | push de | push bc
                    _deb: public _deb
        call SpritePatternHlDash
        call VramAddress
        call OnVram
            call CopyStraight
        call OffVram
    pop bc | pop de | pop hl | pop af
ret

; void DrawSprite2(byte x, byte y, byte pattern);
cseg
DrawSprite2_: public DrawSprite2_
    push af | push hl | push de | push bc
        call SpritePatternHlDash
        call VramAddress
        call OnVram
            ld e,2
            do
                ld d,2
                do
                    ld c,CharHeight
                    call CopyStraight
                    dec d
                while nz | wend
                ld a,l | add a,low(VramRowSize-CharHeight*2) | ld l,a
                ld a,h | adc a,high(VramRowSize-CharHeight*2) | ld h,a
                dec e
            while nz | wend
        call OffVram
    pop bc | pop de | pop hl | pop af
ret

CopyStraight:
    ld c,CharHeight
    do
        exx
            ld a,(hl) | inc hl ; mask
            cpl
            ld b,a
        exx
        ld a,11h
        ld b,PlaneCount
        do
            out (0ch),a
            ex af,af'
                ld a,(hl)
                exx
                    and b
                    or (hl) | inc hl
                exx
                ld (hl),a
            ex af,af'
            add a,a
        dwnz
        xor a | out (0ch),a
        inc hl
        dec c
    while nz | wend
ret
