include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramFront_
ext CharPattern, BulletPattern

Char_PCG equ 80h
CharHeight equ 8
VramTop equ Vram+VramRowSize*0

dseg
CharColors: public CharColors
    defs Char_End
Backup:
    defs VVramWidth*VVramHeight


cseg
ColorTable:
defb 16, 60h ; Logo
defb 3, 60h ; Ground
defb 12, 70h ; MyFighter
defb 4, 20h ; EnemyFighter_Left
defb 4, 30h ; EnemyFighter_Right
defb 4, 40h ; Track
defb 4, 70h ; Rocket
defb 4, 20h ; SmallBang
defb 16, 20h ; LargeBang
defb 4, 40h ; Item
defb 28, 50h ; Fort
defb 4, 70h ; MyBullet
defb 4, 60h ; EnemyBullet
defb 0
SetColors:
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
ret
SetPatterns:
    do
        ld a,(hl) | inc hl
        ld (0E010h),a
        ld a,e | ld (0E011h),a
        ld a,d | ld (0E012h),a
        or 10h | ld (0E012h),a
        and not 10h | ld (0E012h),a
        inc de
        dec bc
        ld a,c | or b
    while nz | wend
ret
InitVram: public InitVram
    ld de,CharColors
	ld a,70h
	ld b,Char_End
	do
		ld (de),a | inc de
	dwnz

    ld hl,ColorTable
    ld de,CharColors+Char_PCG
    call SetColors

    ld hl,CharPattern
    ld de,000h
    ld bc,CharHeight*(Char_End-Char_PCG)
    call SetPatterns

    ld hl,BulletPattern
    ld de,000h+CharHeight*(Char_MyBullet-Char_PCG)
    ld bc,CharHeight*4
    call SetPatterns

    ld hl,BulletPattern
    ld de,000h+CharHeight*(Char_EnemyBullet-Char_PCG)
    ld bc,CharHeight*4
    call SetPatterns
ret

; void ClearScreen();
cseg
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

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put: ;hl,a
    ld e,a
    ld (hl),a
    ld a,e | add a,low CharColors | ld e,a
    ld a,high CharColors | adc a,0 | ld d,a
    ld a,(de)
    set 3,h
    ld (hl),a
    res 3,h
ret
Put_: public Put_
    push af | push de
        ld a,e
        call Put
        inc hl
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
        inc hl
    pop de | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,VramTop
        exx
        ld c, VVramHeight ; vertical count    
        do
            ld b,VVramWidth
            do 
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call Put
                    exx
                endif
                exx
                    inc hl
                exx
                inc hl
            dwnz
            exx
                ld de,VramRowSize-VVramWidth
                add hl,de
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
