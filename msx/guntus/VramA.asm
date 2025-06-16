include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, SpritePattern
ext BackgroundChanged_
ext CharOffset_

dseg
GeneratorFlag: public GeneratorFlag
    defb 0
NameFlag: public NameFlag
    defb 0

cseg
ColorSource:
    defb 8,0f0h
    defb 2,70h
    defb 2,0f0h
    defb 1,90h
    defb 1,0d0h
    defb 1,0b0h
    defb 0

; void InitVram();
cseg
InitVram_: public InitVram_
    push af | push hl | push de | push bc
        ld hl,MonoPattern
        ld de,Vram_PatternGenerator
        ld bc,Char_Star*CharHeight
        call LDIRVM
        
        ld hl,MonoPattern
        ld de,Vram_PatternGenerator2
        ld bc,Char_Star*CharHeight
        call LDIRVM
        
        xor a
        ld (GeneratorFlag),a
        ld (NameFlag),a
        ld (CharOffset_),a

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

        ld e,2
        ld hl,Vram_PatternGenerator+Char_Star*CharHeight
        do
            push hl
                ld c,8
                do
                    ld a,10h
                    call WRTVRM
                    inc hl
                    ld b,8
                    do
                        xor a
                        call WRTVRM
                        inc hl
                    dwnz
                    dec c
                while nz | wend
            pop hl
            ld bc,Vram_PatternGenerator2-Vram_PatternGenerator
            add hl,bc
            
            dec e
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram_PatternName
        ld bc,VramHeight*VramWidth
        xor a
        call FILVRM

        ld hl,Vram_PatternName2
        ld bc,VramHeight*VramWidth
        xor a
        call FILVRM

        xor a
        ld (BackgroundChanged_),a
    pop bc | pop hl | pop af
ret


; word VramOffset(byte x, byte y);
VramOffset_: public VramOffset_
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
    pop de
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    ex af,af'
        ld a,e
        call WRTVRM
        inc h | inc h | inc h | inc h
        call WRTVRM
        dec h | dec h | dec h | dec h
        inc hl
    ex af,af'
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    ex af,af'
        ld a,e
        sub " "
        call WRTVRM
        inc h | inc h | inc h | inc h
        call WRTVRM
        dec h | dec h | dec h | dec h
        inc hl
    ex af,af'
ret
