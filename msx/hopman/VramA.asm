include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern
ext CellMap_,LeftX_,DotOffset_

ColumnCount equ 16*8
FloorCount equ 5
FloorHeight equ 4
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte

dseg
VramSwitch:
    defb 0

cseg
ColorSource:
    defb 8, 0f0h ; Ascii
    defb 2, 0a0h ; Logo
    defb 1, 0f0h ; Remain
    defb 1, 0b0h ; Floor
    defb 1, 0e0h ; Needle
    defb 1, 50h ; Item
    defb 0

; void InitVram();
cseg
InitVram_: public InitVram_
    push af | push hl | push de | push bc | push ix
        ld hl,MonoPattern
        ld de,Vram_PatternGenerator
        ld bc,CharHeight*(Char_Remain_Gap)
        call LDIRVM

        ld hl,MonoPattern
        ld de,Vram_PatternGenerator2
        ld bc,CharHeight*(Char_Remain_Gap)
        call LDIRVM

        ld hl,Vram_Color
        ld de,ColorSource
        do
            ld a,(de)
            or a
        while nz
            ld c,a
            inc de
            ld a,(de)
            inc de
            do
                push af
                    call WRTVRM
                pop af
                inc hl
                dec c
            while nz | wend
        wend
    pop ix | pop bc | pop de | pop hl | pop af
ret


; void ClearScreen();
cseg
ClearScreen_:
    public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram_PatternName
        ld bc,VramHeight*VramWidth
        xor a
        call FILVRM

        ld hl,Vram_PatternName2
        ld bc,VramHeight*VramWidth
        xor a
        call FILVRM

        xor a | ld (VramSwitch),a
        ld bc,0602h | call WRTVDP
        ld bc,0004h | call WRTVDP
    pop bc | pop hl | pop af
ret


; word VramAddress(byte x, byte y);
VramAddress_: public VramAddress_
    push de
        ld l,e
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,a
        ld d,0
        add hl,de
        ld de,Vram
        add hl,de
    pop de
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    ex af,af'
        ld a,e
        call WRTVRM
        set 2,h
        call WRTVRM
        res 2,h
        inc hl
    ex af,af'
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    ex af,af'
        ld a,e
        sub ' '
        call WRTVRM
        set 2,h
        call WRTVRM
        res 2,h
    ex af,af'
    inc hl
ret


cseg
CellChars:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor,Char_Floor_Space
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight,Char_Item_TopRight_Space
	defb Char_Item_BottomLeft_Item_BottomRight,Char_Space
	defb Char_Floor_Floor,Char_Floor_Space
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle,Char_Needle_Space
	defb Char_Floor_Floor,Char_Floor_Space
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor,Char_Floor_Floor
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight,Char_Item_TopRight_Space
	defb Char_Item_BottomLeft_Item_BottomRight,Char_Space
	defb Char_Floor_Floor,Char_Floor_Floor
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle,Char_Needle_Space
	defb Char_Floor_Floor,Char_Floor_Floor
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_TopLeft
	defb Char_Space,Char_Space_Item_BottomLeft
	defb Char_Space,Char_Space_Floor
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_TopLeft
	defb Char_Space,Char_Space_Item_BottomLeft
	defb Char_Floor_Floor,Char_Floor_Floor
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight,Char_Item_TopRight_Item_TopLeft
	defb Char_Item_BottomLeft_Item_BottomRight,Char_Item_BottomRight_Item_BottomLeft
	defb Char_Floor_Floor,Char_Floor_Floor
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_TopLeft
	defb Char_Needle_Needle,Char_Needle_Item_BottomLeft
	defb Char_Floor_Floor,Char_Floor_Floor
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle
	defb Char_Space,Char_Space_Floor
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle
	defb Char_Floor_Floor,Char_Floor_Floor
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight,Char_Item_TopRight_Space
	defb Char_Item_BottomLeft_Item_BottomRight,Char_Item_BottomRight_Needle
	defb Char_Floor_Floor,Char_Floor_Floor
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle,Char_Needle_Needle
	defb Char_Floor_Floor,Char_Floor_Floor


; void MapToVram();
dseg
FloorBuff:
    defs VramWidth*FloorHeight
cseg
MapToVram_: public MapToVram_
    push af | push hl | push de | push bc
        ld a,(VramSwitch)
        xor 1
        ld (VramSwitch),a
        exx
            if z
                ld hl,4000h or (Vram_PatternName+VramRowSize*(VramHeight-FloorHeight*FloorCount))
            else
                ld hl,4000h or (Vram_PatternName2+VramRowSize*(VramHeight-FloorHeight*FloorCount))
            endif
        exx
        call UpdateChars_

        ld a,(LeftX_)
        exx
            ld e,a
        exx
        srl a
        ld c,a
            srl a
            srl a
            ld e,a | ld d,0
            ld hl,CellMap_
            add hl,de
        ld a,c
        and 3
        ld c,a
        exx
            ld a,e
            ld d,0
            and 1
            if nz
                dec d
            endif
            ld a,(VdpOutPort) | ld c,a
        exx
        ld b,FloorCount
        do
            exx
                push hl
                ld hl,FloorBuff
                ld a,d
                or a
                if nz
                    dec hl
                endif
            exx
                ld e,(hl) | inc hl
                ld d,(hl) | inc hl
                push bc
                    ld a,c
                    ld c,4 ; shift count
                    or a
                    do | while nz
                        srl d | rr e
                        srl d | rr e
                        dec c
                        dec a
                    wend
                    exx
                        ld e,d ; xpos
                    exx

                    ld b,VramWidth/2+1
                    do
                        ld a,e
                        push hl | push bc
                            and 0fh
                            ld l,a | ld h,0
                            add hl,hl ;*2
                            add hl,hl ;*4
                            add hl,hl ;*8
                            ld bc,CellChars
                            add hl,bc
                            ld c,FloorHeight
                            do
                                ld b,2
                                do
                                    ld a,(hl) | inc hl
                                    exx
                                        ld b,a
                                        ld a,e ; xpos
                                        cp VramWidth
                                        if c
                                            ld (hl),b
                                        endif
                                        inc hl
                                        inc e
                                    exx
                                dwnz
                                exx
                                    dec e | dec e
                                    push de
                                        ld de,VramWidth-2
                                        add hl,de
                                    pop de
                                exx
                                dec c
                            while nz | wend
                            exx
                                inc e | inc e
                                push de
                                    ld de,-VramWidth*FloorHeight+2
                                    add hl,de
                                pop de
                            exx
                        pop bc | pop hl
                        srl d | rr e
                        srl d | rr e
                        dec c
                        if z
                            ld d,(hl) | inc hl
                            ld c,4 ; shift count
                        endif
                    dwnz
                    exx
                        push de
                            ld de,-VramWidth-2+VramWidth*FloorHeight
                            add hl,de
                        pop de
                    exx
                    ld a,c
                    cp 4
                    if z
                        dec hl
                    endif
                    ld de,MapWidth-(VramWidth/2+1)/ColumnsPerByte-2
                    add hl,de
                pop bc
            exx | 
                pop hl
                push de
                    di
                        inc c
                            out (c),l
                            out (c),h
                        dec c
                        ld de,FloorBuff
                        ld b,VramWidth*FloorHeight
                        do
                            ld a,(de) | inc de
                            out (c),a
                        dwnz
                    ei
                    ld de,VramWidth*FloorHeight
                    add hl,de
                pop de
            exx
        dwnz

        ld a,(VramSwitch)
        or a
        if z
            ld bc,0602h | call WRTVDP
            ld bc,0004h | call WRTVDP
        else
            ld bc,0702h | call WRTVDP
            ld bc,0104h | call WRTVDP
        endif
    pop bc | pop de | pop hl | pop af
ret


; void UpdateChars();
cseg
UpdateChars:
    push hl
        di
            inc c
                out (c),l
                out (c),h
            dec c
            do
                ld a,CharHeight
                do
                    ex af,af'
                        ld a,(de) | inc de
                        out (c),a
                    ex af,af'
                    inc hl
                    dec a
                while nz | wend
            dwnz
        ei
    pop hl
ret
UpdateChars_: public UpdateChars_
    push af | push hl | push de | push bc
        ld a,(DotOffset_) | and 7
        ld l,a
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        add a,a ;*16
        sub l ;*15
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        ld de,ShiftedPattern0
        add hl,de
        ex de,hl

        ld a,(VramSwitch)
        or a
        if z
            ld hl,4000h or (Vram_PatternGenerator+CharHeight*Char_Floor)
        else
            ld hl,4000h or (Vram_PatternGenerator2+CharHeight*Char_Floor)
        endif

        ld a,(VdpOutPort) | ld c,a

        ld b,3
        call UpdateChars
        push de
            ld de,CharHeight*(Char_Needle-Char_Floor)
            add hl,de
        pop de
        ld b,4
        call UpdateChars
        push de
            ld de,CharHeight*(Char_Item-Char_Needle)
            add hl,de
        pop de
        ld b,8
        call UpdateChars
    pop bc | pop de | pop hl | pop af
ret

ShiftedPattern0:
	; Floor0:Char_Floor_Floor
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	; Floor1:Char_Floor_Space
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	; Floor2:Char_Space_Floor
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Needle0:Char_Needle_Item_BottomLeft
	defb 10h,10h,38h,38h,7ch,7ch,0feh,0feh
	; Needle1:Char_Needle_Needle
	defb 10h,10h,38h,38h,7ch,7ch,0feh,0feh
	; Needle2:Char_Needle_Space
	defb 10h,10h,38h,38h,7ch,7ch,0feh,0feh
	; Needle3:Char_Space_Needle
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item0:Char_Item_BottomLeft_Item_BottomRight
	defb 04h,04h,04h,04h,04h,04h,0eh,1fh
	; Item1:Char_Item_BottomRight_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item2:Char_Item_BottomRight_Needle
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item3:Char_Item_TopLeft_Item_TopRight
	defb 00h,07h,07h,07h,07h,07h,07h,07h
	; Item4:Char_Item_TopRight_Item_TopLeft
	defb 00h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h
	; Item5:Char_Item_TopRight_Space
	defb 00h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h
	; Item6:Char_Space_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item7:Char_Space_Item_TopLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
ShiftedPattern1:
	; Floor0:Char_Floor_Floor
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	; Floor1:Char_Floor_Space
	defb 0feh,0feh,0feh,0feh,00h,00h,00h,00h
	; Floor2:Char_Space_Floor
	defb 01h,01h,01h,01h,00h,00h,00h,00h
	; Needle0:Char_Needle_Item_BottomLeft
	defb 20h,20h,70h,70h,0f8h,0f8h,0fch,0fch
	; Needle1:Char_Needle_Needle
	defb 20h,20h,70h,70h,0f8h,0f8h,0fdh,0fdh
	; Needle2:Char_Needle_Space
	defb 20h,20h,70h,70h,0f8h,0f8h,0fch,0fch
	; Needle3:Char_Space_Needle
	defb 00h,00h,00h,00h,00h,00h,01h,01h
	; Item0:Char_Item_BottomLeft_Item_BottomRight
	defb 08h,08h,08h,08h,08h,08h,1ch,3eh
	; Item1:Char_Item_BottomRight_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item2:Char_Item_BottomRight_Needle
	defb 00h,00h,00h,00h,00h,00h,01h,01h
	; Item3:Char_Item_TopLeft_Item_TopRight
	defb 00h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
	; Item4:Char_Item_TopRight_Item_TopLeft
	defb 00h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	; Item5:Char_Item_TopRight_Space
	defb 00h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	; Item6:Char_Space_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item7:Char_Space_Item_TopLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
ShiftedPattern2:
	; Floor0:Char_Floor_Floor
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	; Floor1:Char_Floor_Space
	defb 0fch,0fch,0fch,0fch,00h,00h,00h,00h
	; Floor2:Char_Space_Floor
	defb 03h,03h,03h,03h,00h,00h,00h,00h
	; Needle0:Char_Needle_Item_BottomLeft
	defb 40h,40h,0e0h,0e0h,0f0h,0f0h,0f8h,0f8h
	; Needle1:Char_Needle_Needle
	defb 40h,40h,0e0h,0e0h,0f1h,0f1h,0fbh,0fbh
	; Needle2:Char_Needle_Space
	defb 40h,40h,0e0h,0e0h,0f0h,0f0h,0f8h,0f8h
	; Needle3:Char_Space_Needle
	defb 00h,00h,00h,00h,01h,01h,03h,03h
	; Item0:Char_Item_BottomLeft_Item_BottomRight
	defb 10h,10h,10h,10h,10h,10h,38h,7ch
	; Item1:Char_Item_BottomRight_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item2:Char_Item_BottomRight_Needle
	defb 00h,00h,00h,00h,01h,01h,03h,03h
	; Item3:Char_Item_TopLeft_Item_TopRight
	defb 00h,1fh,1fh,1fh,1fh,1fh,1fh,1fh
	; Item4:Char_Item_TopRight_Item_TopLeft
	defb 00h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h
	; Item5:Char_Item_TopRight_Space
	defb 00h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h
	; Item6:Char_Space_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item7:Char_Space_Item_TopLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
ShiftedPattern3:
	; Floor0:Char_Floor_Floor
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	; Floor1:Char_Floor_Space
	defb 0f8h,0f8h,0f8h,0f8h,00h,00h,00h,00h
	; Floor2:Char_Space_Floor
	defb 07h,07h,07h,07h,00h,00h,00h,00h
	; Needle0:Char_Needle_Item_BottomLeft
	defb 80h,80h,0c0h,0c0h,0e0h,0e0h,0f0h,0f0h
	; Needle1:Char_Needle_Needle
	defb 80h,80h,0c1h,0c1h,0e3h,0e3h,0f7h,0f7h
	; Needle2:Char_Needle_Space
	defb 80h,80h,0c0h,0c0h,0e0h,0e0h,0f0h,0f0h
	; Needle3:Char_Space_Needle
	defb 00h,00h,01h,01h,03h,03h,07h,07h
	; Item0:Char_Item_BottomLeft_Item_BottomRight
	defb 20h,20h,20h,20h,20h,20h,70h,0f8h
	; Item1:Char_Item_BottomRight_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item2:Char_Item_BottomRight_Needle
	defb 00h,00h,01h,01h,03h,03h,07h,07h
	; Item3:Char_Item_TopLeft_Item_TopRight
	defb 00h,3fh,3fh,3fh,3fh,3fh,3fh,3fh
	; Item4:Char_Item_TopRight_Item_TopLeft
	defb 00h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	; Item5:Char_Item_TopRight_Space
	defb 00h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	; Item6:Char_Space_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item7:Char_Space_Item_TopLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
ShiftedPattern4:
	; Floor0:Char_Floor_Floor
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	; Floor1:Char_Floor_Space
	defb 0f0h,0f0h,0f0h,0f0h,00h,00h,00h,00h
	; Floor2:Char_Space_Floor
	defb 0fh,0fh,0fh,0fh,00h,00h,00h,00h
	; Needle0:Char_Needle_Item_BottomLeft
	defb 00h,00h,80h,80h,0c0h,0c0h,0e0h,0e1h
	; Needle1:Char_Needle_Needle
	defb 01h,01h,83h,83h,0c7h,0c7h,0efh,0efh
	; Needle2:Char_Needle_Space
	defb 00h,00h,80h,80h,0c0h,0c0h,0e0h,0e0h
	; Needle3:Char_Space_Needle
	defb 01h,01h,03h,03h,07h,07h,0fh,0fh
	; Item0:Char_Item_BottomLeft_Item_BottomRight
	defb 40h,40h,40h,40h,40h,40h,0e0h,0f0h
	; Item1:Char_Item_BottomRight_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,01h
	; Item2:Char_Item_BottomRight_Needle
	defb 01h,01h,03h,03h,07h,07h,0fh,0fh
	; Item3:Char_Item_TopLeft_Item_TopRight
	defb 00h,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	; Item4:Char_Item_TopRight_Item_TopLeft
	defb 00h,80h,80h,80h,80h,80h,80h,80h
	; Item5:Char_Item_TopRight_Space
	defb 00h,80h,80h,80h,80h,80h,80h,80h
	; Item6:Char_Space_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,00h,01h
	; Item7:Char_Space_Item_TopLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
ShiftedPattern5:
	; Floor0:Char_Floor_Floor
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	; Floor1:Char_Floor_Space
	defb 0e0h,0e0h,0e0h,0e0h,00h,00h,00h,00h
	; Floor2:Char_Space_Floor
	defb 1fh,1fh,1fh,1fh,00h,00h,00h,00h
	; Needle0:Char_Needle_Item_BottomLeft
	defb 00h,00h,00h,00h,80h,80h,0c1h,0c3h
	; Needle1:Char_Needle_Needle
	defb 02h,02h,07h,07h,8fh,8fh,0dfh,0dfh
	; Needle2:Char_Needle_Space
	defb 00h,00h,00h,00h,80h,80h,0c0h,0c0h
	; Needle3:Char_Space_Needle
	defb 02h,02h,07h,07h,0fh,0fh,1fh,1fh
	; Item0:Char_Item_BottomLeft_Item_BottomRight
	defb 80h,80h,80h,80h,80h,80h,0c0h,0e0h
	; Item1:Char_Item_BottomRight_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,01h,03h
	; Item2:Char_Item_BottomRight_Needle
	defb 02h,02h,07h,07h,0fh,0fh,1fh,1fh
	; Item3:Char_Item_TopLeft_Item_TopRight
	defb 00h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	; Item4:Char_Item_TopRight_Item_TopLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item5:Char_Item_TopRight_Space
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item6:Char_Space_Item_BottomLeft
	defb 00h,00h,00h,00h,00h,00h,01h,03h
	; Item7:Char_Space_Item_TopLeft
	defb 00h,00h,00h,00h,00h,00h,00h,00h
ShiftedPattern6:
	; Floor0:Char_Floor_Floor
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	; Floor1:Char_Floor_Space
	defb 0c0h,0c0h,0c0h,0c0h,00h,00h,00h,00h
	; Floor2:Char_Space_Floor
	defb 3fh,3fh,3fh,3fh,00h,00h,00h,00h
	; Needle0:Char_Needle_Item_BottomLeft
	defb 01h,01h,01h,01h,01h,01h,83h,87h
	; Needle1:Char_Needle_Needle
	defb 04h,04h,0eh,0eh,1fh,1fh,0bfh,0bfh
	; Needle2:Char_Needle_Space
	defb 00h,00h,00h,00h,00h,00h,80h,80h
	; Needle3:Char_Space_Needle
	defb 04h,04h,0eh,0eh,1fh,1fh,3fh,3fh
	; Item0:Char_Item_BottomLeft_Item_BottomRight
	defb 00h,00h,00h,00h,00h,00h,80h,0c0h
	; Item1:Char_Item_BottomRight_Item_BottomLeft
	defb 01h,01h,01h,01h,01h,01h,03h,07h
	; Item2:Char_Item_BottomRight_Needle
	defb 04h,04h,0eh,0eh,1fh,1fh,3fh,3fh
	; Item3:Char_Item_TopLeft_Item_TopRight
	defb 00h,0feh,0feh,0feh,0feh,0feh,0feh,0feh
	; Item4:Char_Item_TopRight_Item_TopLeft
	defb 00h,01h,01h,01h,01h,01h,01h,01h
	; Item5:Char_Item_TopRight_Space
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item6:Char_Space_Item_BottomLeft
	defb 01h,01h,01h,01h,01h,01h,03h,07h
	; Item7:Char_Space_Item_TopLeft
	defb 00h,01h,01h,01h,01h,01h,01h,01h
ShiftedPattern7:
	; Floor0:Char_Floor_Floor
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	; Floor1:Char_Floor_Space
	defb 80h,80h,80h,80h,00h,00h,00h,00h
	; Floor2:Char_Space_Floor
	defb 7fh,7fh,7fh,7fh,00h,00h,00h,00h
	; Needle0:Char_Needle_Item_BottomLeft
	defb 02h,02h,02h,02h,02h,02h,07h,0fh
	; Needle1:Char_Needle_Needle
	defb 08h,08h,1ch,1ch,3eh,3eh,7fh,7fh
	; Needle2:Char_Needle_Space
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Needle3:Char_Space_Needle
	defb 08h,08h,1ch,1ch,3eh,3eh,7fh,7fh
	; Item0:Char_Item_BottomLeft_Item_BottomRight
	defb 00h,00h,00h,00h,00h,00h,00h,80h
	; Item1:Char_Item_BottomRight_Item_BottomLeft
	defb 02h,02h,02h,02h,02h,02h,07h,0fh
	; Item2:Char_Item_BottomRight_Needle
	defb 08h,08h,1ch,1ch,3eh,3eh,7fh,7fh
	; Item3:Char_Item_TopLeft_Item_TopRight
	defb 00h,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	; Item4:Char_Item_TopRight_Item_TopLeft
	defb 00h,03h,03h,03h,03h,03h,03h,03h
	; Item5:Char_Item_TopRight_Space
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; Item6:Char_Space_Item_BottomLeft
	defb 02h,02h,02h,02h,02h,02h,07h,0fh
	; Item7:Char_Space_Item_TopLeft
	defb 00h,03h,03h,03h,03h,03h,03h,03h
