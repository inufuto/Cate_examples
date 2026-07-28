include "Vram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern

cseg
InitVram: public InitVram
    calt 92h
    call ClearScreen_

    lxi h,SpritePattern
    lxi d,PatternRam
    mvi b,Pattern_Chars-1
    do
        mvi c,SpritePatternSize | block
        dcr b
    repeat
ret 


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push v | push h | push d | push b
        calt 8ch
        calt 8eh
    pop b | pop d | pop h | pop v
ret



Put: ;(hl, a):hl
    mvi c,0
    shal | rcl ;*2
    shal | rcl ;*4
    shal | rcl ;*8
    adi a,low CharPattern | mov e,a
    mov a,c | aci a,high CharPattern | mov d,a
    mvi b,CharHeight/2-1
    do
        mvi c,2-1
        do
            ldax d+
            stax h+
            dcr c
        repeat
        inx h | inx h
        dcr b
    repeat
    mov a,l | sui a,CharHeight*2-2
    sbi h,0
    if oni a,04h
        ani a,0f0h
        adi a,SpritePatternSize
        aci h,0
    endif
    mov l,a
ret

; ptr<byte> Put(ptr<byte> pPattern, byte c);
cseg
Put_: public Put_
    push v | push d | push b
        mov a,e
        call Put
    pop b | pop d | pop v
ret

; ptr<byte> PrintC(ptr<byte> pPattern, byte c);
cseg
ChatTable:
    defb " 0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    push v | push d | push b
        push h
            lxi h,ChatTable
            lxi b,28-1
            do
                ldax h+
                nea a,e | jr PrintC_break
                inr b
                dcr c
            repeat
            mvi b,0
PrintC_break:
        pop h
        mov a,b
        call Put
    pop b | pop d | pop v
ret


; void ClearPattern(byte pattern);
cseg
ClearPattern_: public ClearPattern_
    push v | push h | push b
        mvi c,0
        shal | rcl ;*2
        shal | rcl ;*4
        shal | rcl ;*8
        shal | rcl ;*16
        shal | rcl ;*32
        mov l,a
        mov a,c | adi a,high PatternRam | mov h,a
        xra a,a
        mvi b,SpritePatternSize-1
        do
            stax h+
            dcr b
        repeat
    pop b | pop h | pop v
ret


; void SetWall(byte x, byte y);
cseg
SetWall_: public SetWall_
    push v | push h | push d | push b
        mov d,a
        mov a,e
        add a,a ;*2
        add a,e ;*3
        ani a,0fch
        mvi c,0
        shal | rcl ;*8
        shal | rcl ;*16
        shal | rcl ;*32
        add a,d
        adi a,low (Vram+VramWidth) | mov l,a
        mov a,c | aci a,high (Vram+VramWidth) | mov h,a
        
        mov a,e
        lxi d,0fc00h
        ani a,3
        if sknz
            mov b,a
            mvi a,3 | sub a,b | mov b,a
            mov a,e | mov c,a
            mov a,d
            do
                shar | rcr
                shar | rcr
                dcr b
            repeat
            mov d,a
            mov a,c | mov e,a
        endif
        ldax h | ora a,d | stax h
        adi l,low VramWidth
        aci h,0
        ldax h | ora a,e | stax h
    pop b | pop d | pop h | pop v
ret


; void ClearWalls();
cseg
ClearWalls_: public ClearWalls_
    push v | push h | push b
        xra a,a
        lxi h,Vram+VramWidth
        mvi b,16-1-1
        do
            mvi c,VramWidth-1
            do
                stax h+
                dcr c
            repeat
            dcr b
        repeat
    pop b | pop h | pop v
ret
