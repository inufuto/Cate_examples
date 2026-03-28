include "kh1000.inc"
include "Vram.inc"
include "Chars.inc"

ext WRTVRM, RDVRM, LDIRVM, FILVRM, WRTVDP
ext Chars, SpritePattern
ext dotOffset_
ext BackgroundPattern_

ext pStage_, StageMap_, topRow_, yMod_
ext DrawBlocks_

VisibleFloorCount equ (WindowHeight+FloorHeight-1)/FloorHeight+1
FloorHeight equ 4
ColumnCount equ 16
MapWidth equ ColumnCount/4

CellType_Space equ 0
CellType_Ladder equ 1
CellType_Wall equ 2
CellType_Hole equ 3

dseg
GeneratorFlag:
    defb 0
NameFlag: public NameFlag
    defb 0

cseg
ColorSource:
	defb 8, 0f0h
	defb 2, 0a0h
	defb 1, 0f0h
	defb 2, 0a0h
	defb 1, 070h
    defb 0

cseg
InitVram: public InitVram
    push af | push hl | push de | push bc
        ld hl,Chars
        ld de,Vram_PatternGenerator
        ld bc,Char_End*CharHeight
        call LDIRVM
        
        ld hl,Chars
        ld de,Vram_PatternGenerator2
        ld bc,Char_End*CharHeight
        call LDIRVM
        
        xor a
        ld (GeneratorFlag),a
        ld a,06h
        ld (NameFlag),a

        ld hl,Vram_Color
        ld de,ColorSource
        do
            ld a,(de)
            or a
        while nz
            ld b,a
            inc de
            ld a,(de)
            inc de
            do
                push af
                    call WRTVRM
                pop af
                inc hl
            dwnz
        wend

        ld hl,Vram_PatternGenerator+800h
        exx
            ld hl,Vram_PatternGenerator
        exx
        ld c,2
        do
            ld b,2
            do
                ld de,800h
                do
                    exx
                        call RDVRM
                        inc hl
                    exx
                    call WRTVRM
                    inc hl
                    dec de
                    ld a,e
                    or d
                while nz | wend
            dwnz
            ld hl,Vram_Color+800h
            exx
                ld hl,Vram_Color
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
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

        ld hl,Vram_PatternName-0400h
        ld bc,VramHeight*VramWidth
        xor a
        call FILVRM

        ld hl,Vram_SpriteAttribute
        ld bc,4*32
        ld a,0d0h
        call FILVRM
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
        dec h | dec h | dec h | dec h
        call WRTVRM
        inc h | inc h | inc h | inc h
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
        dec h | dec h | dec h | dec h
        call WRTVRM
        inc h | inc h | inc h | inc h
        inc hl
    ex af,af'
ret


; void UpdateBackgroundChars();
cseg
UpdateBackgroundChars_: public UpdateBackgroundChars_
    push af | push hl | push de | push bc
        ld a,(GeneratorFlag)
        or a
        if z
            ld hl,4000h+Vram_PatternGenerator2+Char_Background*CharHeight
        else
            ld hl,4000h+Vram_PatternGenerator+Char_Background*CharHeight
        endif

        ld a,(dotOffset_)
        ld d,a

        di
            ex af,af'
                ld a,l | ld (VdpAddress+2),a
                ld a,h | ld (VdpAddress+2),a
            ex af,af'
            ld hl,BackgroundPattern_
            ld e,Char_Alter-Char_BackGround
            do
                push hl
                    ld a,7
                    sub d
                    add a,l
                    ld l,a
                    ld a,h
                    adc a,0
                    ld h,a
                    ld b,8
                    do
                        ld a,(hl)
                        inc hl
                        ld (VdpAddress),a
                    dwnz
                pop hl
                ld a,l
                add a,15
                ld l,a
                ld a,h
                adc a,0
                ld h,a
                dec e
            while nz | wend
        ei
    pop bc | pop de | pop hl | pop af
ret


; void SwitchChars();
cseg
SwitchChars_: public SwitchChars_
    push af | push bc
        ld a,(GeneratorFlag)
        xor 1
        ld (GeneratorFlag),a
        ld b,a
        ld c,4
        call WRTVDP
    pop bc | pop af
ret


; void MapToVram();
cseg
Repeat: public Repeat
    push af
        do
            exx
                ld a,e
                inc e
            exx
            cp WindowHeight
            if c
                di
                    ld a,l | ld (VdpAddress+2),a
                    ld a,h | or 40h | ld (VdpAddress+2),a
                    ld a,d | ld (VdpAddress),a
                    nop | nop | nop
                    ld a,e | ld (VdpAddress),a
                ei
            endif
            push de
                ld de,WindowWidth
                add hl,de
            pop de
        dwnz
    pop af
ret

MapToVram_: public MapToVram_
    push af | push hl | push de | push bc | push ix | push iy
        ld a,(NameFlag)
        cp 06h
        if z
            ld hl,VramTop+4000h-0400h
            dec a
        else
            ld hl,VramTop+4000h
            inc a
        endif
        ld (NameFlag),a


        ld iy,(pStage_)
        ld a,(topRow_)
        exx
            ld d,a ; row
        exx
        or a
        if p
            ld ix,StageMap_
            add a,a ;*2
            add a,a ;*4
            ld e,a
            ld d,0
            add ix,de ; pMap
        else
            ld ix,StageMap_-MapWidth
        endif
        exx
            ld a,(yMod_)
            or a
            if nz
                neg
            endif
            ld e,a
        exx

        ld de,-WindowWidth
        do
            or a
        while m
            add hl,de
            inc a
        wend
        ld c,VisibleFloorCount
        do
            ld b,MapWidth
            do
                push bc
                    exx
                        ld a,d ; row
                        or a
                        if p
                            if z
                                ld c,0 ; upper
                            else
                                ld c,(ix-MapWidth)
                            endif
                            ld h,(ix) ; middle
                            inc a
                            cp (iy+0)
                            if c
                                ld l,(ix+MapWidth) ; lower
                            else
                                ld l,0
                            endif
                        else
                            ld h,0 ; middle
                            ld l,(ix+MapWidth) ; lower
                            ld c,0ffh ; upper
                        endif
                    exx
                    inc ix
                    ld c,4
                    do
                        exx
                            ld a,h ; middle
                        exx
                        and 3
                        or a
                        if z
                            exx
                                ld a,c ; upper
                            exx
                            and 3
                            cp CellType_Hole
                            if z
                                ld de,(Char_Space shl 8) or Char_Space
                            else
                                ld de,(Char_Floor_Space shl 8) or Char_Floor_Space
                            endif
                            ld b,1
                            call Repeat
                            exx
                                ld a,l ; lower
                            exx
                            and 3
                            cp CellType_Ladder
                            if z
                                ld de,(Char_Space_LeftLadder shl 8) or Char_Space_RightLadder
                                ld b,1
                                call Repeat
                                ld de,(Char_LeftLadder_LeftLadder shl 8) or Char_RightLadder_RightLadder
                                ld b,2
                                call Repeat
                            else
                                cp CellType_Wall
                                if z
                                    ld de,(Char_Space shl 8) or Char_Space
                                    ld b,2
                                    call Repeat
                                    ld de,(Char_Space_Wall shl 8) or Char_Space_Floor
                                    ld b,1
                                    call Repeat
                                else
                                    ld de,(Char_Space shl 8) or Char_Space
                                    ld b,2
                                    call Repeat
                                    cp CellType_Wall
                                    if z
                                        ld de,(Char_Space_Wall shl 8) or Char_Space_Floor
                                    else
                                        ld de,(Char_Space_Floor shl 8) or Char_Space_Floor
                                    endif
                                    ld b,1
                                    call Repeat
                                endif
                            endif
                        else
                            cp CellType_Ladder
                            if z
                                ld de,(Char_LeftLadder_LeftLadder shl 8) or Char_RightLadder_RightLadder
                                ld b,3
                                call Repeat
                                exx
                                    ld a,l ; lower
                                exx
                                and 3
                                cp CellType_Ladder
                                if z
                                    ld de,(Char_LeftLadder_LeftLadder shl 8) or Char_RightLadder_RightLadder
                                else
                                    cp CellType_Wall
                                    if z
                                        ld de,(Char_LeftLadder_Wall shl 8) or Char_RightLadder_Floor
                                    else
                                        ld de,(Char_LeftLadder_Floor shl 8) or Char_RightLadder_Floor
                                    endif
                                endif
                                ld b,1
                                call Repeat
                            else
                                cp CellType_Wall
                                if z
                                    ld de,(Char_Wall_Wall shl 8) or Char_Floor_Space
                                    ld b,1
                                    call Repeat
                                    ld de,(Char_Wall_Wall shl 8) or Char_Space
                                    ld b,2
                                    call Repeat
                                    exx
                                        ld a,l ; lower
                                    exx
                                    and 3
                                    cp CellType_Wall
                                    if z
                                        ld de,(Char_Wall_Wall shl 8) or Char_Space_Floor
                                    else
                                        ld de,(Char_Wall_Floor shl 8) or Char_Space_Floor
                                    endif
                                    ld b,1
                                    call Repeat
                                else
                                    exx
                                        ld a,c ; upper
                                    exx
                                    and 3
                                    cp CellType_Hole
                                    if z
                                        ld de,(Char_Space shl 8) or Char_Space
                                    else
                                        ld de,(Char_Floor_Space shl 8) or Char_Floor_Space
                                    endif
                                    ld b,1
                                    call Repeat
                                    ld de,(Char_Space shl 8) or Char_Space
                                    ld b,3
                                    call Repeat
                                endif
                            endif
                        endif
                        ld de,-WindowWidth*4+2
                        add hl,de
                        exx
                            srl h | srl h
                            srl l | srl l
                            srl c | srl c
                            dec e | dec e | dec e | dec e
                        exx
                        dec c
                    while nz | wend
                pop bc
            dwnz
            ld de,WindowWidth*(4-1)
            add hl,de
            exx
                inc d
                inc e | inc e | inc e | inc e
            exx
            dec c
        while nz | wend

        call DrawBlocks_
        ld a,(NameFlag)
        ld b,a
        ld c,2
        call WRTVDP
    pop iy | pop ix | pop bc | pop de | pop hl | pop af
ret
