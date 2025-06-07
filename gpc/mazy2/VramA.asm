include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVram_

WriteLcd equ $82

dseg
Backup:
    defs VVramWidth*VVramHeight

; void ClearScreen();
cseg
Clear:
    do
        xra a,a
        stax h+
        dcx b
        mov a,c
        ora a,b
        sknz | eqa a,a
    repeat
ret
ClearScreen_: public ClearScreen_
    push v | push h | push d | push b
        lxi h,Vram_
        lxi b,VramRowSize*VramHeight
        call Clear

        lxi h,Backup
        lxi b,VVramWidth*VVramHeight
        call Clear

        calt WriteLcd

        lxi h,VVram_
        lxi b,VVramWidth*VVramHeight
        call Clear
    pop b | pop d | pop h | pop v
ret


; void PresentVram();
cseg
PresentVram_: public PresentVram_
    push v | push h | push d | push b
        calt WriteLcd
    pop b | pop d | pop h | pop v
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    push v | push d | push b
        mov a,e
        if eqi a,' '
            xra a,a
        else
            if eqi a,'-'
                mvi a,$01
            else
                if lti a,'A'
                    adi a,$02-'0'
                else
                    adi a,$0c-'A'
                endif
            endif
        endif
        add a,a ;*2
        add a,a ;*4
        adi a,low AsciiPattern | mov e,a
        mvi a,0 | aci a,high AsciiPattern | mov d,a

        mvi b,4-1
        do
            ldax d+
            stax h+
            dcr b
        repeat
    pop b | pop d | pop v
ret


; ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
zseg
mask:
    defw 0
cseg
Put_: public Put_
    push v | push d | push b
        mvi a,$f8 | staw mask
        mvi a,$ff | staw mask+1
        mov a,c | mov b,a ; shift
        if dcr b
        else
            do
                ldaw mask | stc|ral | staw mask
                ldaw mask+1 | ral | staw mask+1
                dcr b
            repeat
        endif
        mov a,e | add a,a | mov e,a
        mvi a,0 | ral | mov d,a
        mov a,e | adi a,low CharPattern | mov e,a
        mov a,d | aci a,high CharPattern | mov d,a

        ldax d | inx d
        push v
            call WriteByte
        pop v
        rar | rar | rar | rar
        call WriteByte
        ldax d | inx d
        call WriteByte
    pop b | pop d | pop v
ret
WriteByte:
    push d
        ani a,7
        mov e,a | mvi d,0
        mov a,c
        mov b,a
        if dcr b
        else
            do
                mov a,e | clc|ral | mov e,a
                mov a,d | ral | mov d,a
                dcr b
            repeat
        endif
        
        ldax h | mov b,a
        ldaw mask
        ana a,b
        ora a,e
        stax h

        mov a,l | adi a,low VramRowSize | mov l,a
        mov a,h | aci a,high VramRowSize | mov h,a

        ldax h | mov b,a
        ldaw mask+1
        ana a,b
        ora a,d
        stax h

        mov a,l | adi a,low(1-VramRowSize) | mov l,a
        mov a,h | aci a,high(1-VramRowSize) | mov h,a
    pop d
ret


CharPatternEDE:
    push v
        mov a,e | add a,a | mov e,a
        mvi a,0 | ral | mov d,a

        mov a,e | adi a,low CharPattern | mov e,a
        mov a,d | aci a,high CharPattern | mov d,a
    pop v
ret


; ptr<byte> PutU(ptr<byte> pVram, byte c);
cseg
PutU_: public PutU_
    push v | push d | push b
        call CharPatternEDE

        ldax h | ani a,$f0 | mov c,a
        ldax d+
        push v
            ani a,$0f
            ora a,c
            stax h+

            ldax h | ani a,$f0 | mov c,a
        pop v
        rar | rar | rar | rar
        ani a,$0f
        ora a,c
        stax h+

        ldax h | ani a,$f0 | mov c,a
        ldax d+
        ani a,$0f
        ora a,c
        stax h+
    pop b | pop d | pop v
ret


; ptr<byte> PutL(ptr<byte> pVram, byte c);
PutL_: public PutL_
    push v | push d | push b
        call CharPatternEDE

        ldax h | ani a,$0f | mov c,a
        ldax d+
        push v
            ral | ral | ral | ral
            ani a,$f0
            ora a,c
            stax h+

            ldax h | ani a,$0f | mov c,a
        pop v
        ani a,$f0
        ora a,c
        stax h+

        ldax h | ani a,$0f | mov c,a
        ldax d+
        ral | ral | ral | ral
        ani a,$f0
        ora a,c
        stax h+
    pop b | pop d | pop v
ret


; void VVramToVram();
zseg
xCount: public xCount
    defb 0
yCount: public yCount
    defb 0
shift:
    defb 0
cseg
VVramToVram_: public VVramToVram_
    push v | push h | push d | push b
        lxi d,Vram_+VramRowSize*2
        lxi b,VVram_
        lxi h,Backup
        xra a,a | staw shift
        mvi a,VVramHeight-1 | staw yCount
        do
            mvi a,VVramWidth-1 | staw xCount
            do
                ldax b | inx b
                if neax h
                    stax h
                    push h | push b
                        push v
                            mov a,e | mov l,a
                            mov a,d | mov h,a
                        pop v
                        mov e,a
                        ldaw shift | mov c,a
                        call Put_
                        mov a,l | mov e,a
                        mov a,h | mov d,a
                    pop b | pop h
                else
                    inx d | inx d | inx d
                endif
                inx h
                dcrw xCount
            repeat
            mov a,e | adi a,low(-VVramWidth*CharWidth) | mov e,a
            mov a,d | aci a,high (-VVramWidth*CharWidth) | mov d,a

            ldaw shift
            adi a,3
            staw shift
            if gti a,8-1
                sbi a,8
                staw shift
                mov a,e | adi a,low VramRowSize | mov e,a
                mov a,d | aci a,high VramRowSize | mov d,a
            endif

            dcrw yCount
        repeat
    pop b | pop d | pop h | pop v
ret
