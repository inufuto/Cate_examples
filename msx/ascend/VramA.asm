include 'BIOS.inc'
include 'Vram.inc'
include 'Chars.inc'

ext Chars, SpritePattern
ext yMod_
ext dotOffset_, Background_
ext BackgroundPattern_
ext DrawBlocks_

dseg
GeneratorFlag:
    defb 0
NameFlag:
    defb 0

cseg
ColorSource:
	defb 8, 0f0h
	defb 2, 0a0h
	defb 1, 0f0h
	defb 2, 0a0h
	defb 1, 070h
    defb 0

; void InitVram();
cseg
InitVram_: public InitVram_
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

        ld a,(VdpOutPort)
        ld c,a

        di
            inc c
                out (c),l
                out (c),h
            dec c
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
                        out (c),a
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


; void BackgroundToVram();
cseg
BackgroundToVram_: public BackgroundToVram_
    push af | push hl | push de | push bc
        ld a,(yMod_)
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ex de,hl
        
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

        ld a,(VdpOutPort) | ld c,a
        di
            inc c
            out (c),l
            out (c),h
            dec c
            ld hl,Background_
            add hl,de
            ld de,VramRowSize*WindowHeight
            do
                ld a,(hl) | inc hl
                out (c),a
                dec de
                ld a,e
                or d
            while nz | wend
        ei
        call DrawBlocks_
        ld a,(NameFlag)
        ld b,a
        ld c,2
        call WRTVDP
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
