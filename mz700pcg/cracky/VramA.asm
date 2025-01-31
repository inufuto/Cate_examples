include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramFront_, RowFlags_
ext CharPattern

Char_PCG equ 80h
CharHeight equ 8
VramTop equ Vram+VramRowSize*0

dseg
CharColors: public CharColors
    defs Char_End


cseg
ColorTable:
defb 16, 50h ; Logo
defb 9, 50h ; CrackedFloor
defb 2, 60h ; Ladder
defb 52, 70h ; Man
defb 32, 30h ; Monster
defb 4, 60h ; Item
defb 0
InitVram: public InitVram
    ld de,CharColors
	ld a,70h
	ld b,Char_PCG
	do
		ld (de),a | inc de
	dwnz
    ld hl,ColorTable
    do
        ld b,(hl)
        inc b | dec b
    while nz
        inc hl
        ld a,(hl) | inc hl
        do
            ld (de),a | inc de
        dwnz
    wend

    ld hl,CharPattern
    ld de,0
    ld bc,CharHeight*(Char_End-Char_PCG)
    do
        ld a,(hl) | inc hl
        ld (0E010h),a
        ld a,e | ld (0E011h),a
        ld a,d | or 10h | ld (0E012h),a
        and not 10h | ld (0E012h),a
        inc de
        dec bc
        ld a,c | or b
    while nz | wend
ret


; void ClearScreen();
cseg
ClearRowFlags:
    xor a
    ld hl,RowFlags_
    ld b,4
    do
        ld (hl),a
        inc hl
    dwnz
ret
Clear:
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramWidth*VramHeight
        call Clear

        ld hl,Atributes
        ld bc,VramWidth*VramHeight
        call Clear

        call ClearRowFlags
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put: ;hl,a
    ld (hl),a
    add a,low CharColors | ld e,a
    ld a,high CharColors | adc a,0 | ld d,a
    ld a,(de)
    set 3,h
    ld (hl),a
    res 3,h
    inc hl
ret
Put_: public Put_
    push af | push de
        ld a,e
        call Put
    pop de | pop af
ret


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
CharTable:
    defb 0,61h,62h,63h,64h,65h,66h,67h,68h,69h,6bh,6ah,2fh,2ah,2eh,2dh
    defb 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,4fh,2ch,51h,2bh,57h,49h
    defb 55h,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
    defb 16,17,18,19,20,21,22,23,24,25,26,52h,59h,54h,46h,3ch
PrintC_: public PrintC_
    push af | push de
        ld a,e
        exx
            ld l,a
            ld h,0
            ld de,CharTable - ' '
            add hl,de
            ld a,(hl)
        exx
        call Put
    pop de | pop af
ret


cseg
VVramToVramRow:
    ld b,VVramWidth
    do 
        ld a,(de) | inc de
        push de
            call Put
        pop de        
    dwnz
    ld bc,VramWidth-VVramWidth
    add hl,bc
ret


; void VVramToVramAll();
cseg
VVramToVramAll_: public VVramToVramAll_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Vram
        ld c,VVramHeight ; vertical count    
        do
            push bc
                call VVramToVramRow
            pop bc
            dec c
        while nz | wend
        call ClearRowFlags
    pop bc | pop de | pop hl | pop af
ret


; void VVramToVramChanged();
cseg
VVramToVramChanged_: public VVramToVramChanged_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Vram
        exx
            ld hl,RowFlags_
            ld c,1
            ld b,(hl) | inc hl
        exx
        ld c,VVramHeight ; vertical count    
        do
            push bc
                exx
                    ld a,b
                    and c
                exx
                if nz
                    call VVramToVramRow         
                else
                    ex de,hl
                        ld bc,VVramWidth
                        add hl,bc
                    ex de,hl
                    ld bc,VramWidth
                    add hl,bc
                endif
                exx
                    rlc c
                    if c
                        ld b,(hl) | inc hl
                    endif
                exx
            pop bc
            dec c
        while nz | wend
        call ClearRowFlags
    pop bc | pop de | pop hl | pop af
ret
