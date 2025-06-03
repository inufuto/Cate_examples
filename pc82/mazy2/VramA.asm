include "pc82.inc"
include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramBack_, VVramFront_

dseg
Vram_: public Vram_
    defs CharWidth*VramWidth*VramHeight/2
Backup:
    defs WindowWidth*WindowHeight


cseg
WaitLCD:
    push psw
        do
            in LCDSTAT
            rlc
        while c | wend
    pop psw
ret


; void ClearScreen();
cseg
Clear:
    do
        mvi m,0 | inx h
        dcx b
        mov a,c
        ora b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push psw | push h | push b
        di
            mvi a,$ff | out PORTA
            ; mvi a,$23 | out PORTB
            in PORTB | ori $03  | out PORTB

            xra a
            do
                push psw
                    call WaitLCD
                    out LCDCOM ; address counter
                        
                    call WaitLCD
                    mvi a,$32 | out LCDCOM ; counter mode

                    mvi b,50
                    do
                        call WaitLCD
                        xra a | out LCDIO
                        dcr b
                    while nz | wend
                pop psw
                adi $40
            while nz | wend
            call WaitLCD
        ei

        lxi h,Vram_
        lxi b,CharWidth*VramWidth*VramHeight/2
        call Clear

        lxi h,Backup
        lxi b,VramWidth*VramHeight
        call Clear

        lxi h,VVramBack_
        lxi b,VramWidth*VramHeight*2
        call Clear
    pop b | pop h | pop psw
ret


; void PresentVram();
cseg
PresentVram_: public PresentVram_
    push psw | push h | push d | push b
        lxi h,Vram_
        ; mvi e,$01
        ; in PORTB | ani not $03 | mov d,a
        lxi d,$0001

        mvi c,2 ; vertical block count
        do
            push d | push b
                di
                    mov a,e | out PORTA
                    in PORTB | ani not $03
                    ora d | out PORTB

                    lxi d,CharWidth*VramWidth-50
                    xra a
                    do
                        push psw
                            call WaitLCD
                            out LCDCOM ; address counter

                            call WaitLCD
                            mvi a,$32 | out LCDCOM ; counter mode

                            mvi b,50
                            do
                                mov a,m | inx h
                                call WaitLCD
                                out LCDIO
                                dcr b
                            while nz | wend
                            dad d
                        pop psw
                        adi $40
                    while nz | wend
                ei

                lxi d,50-CharWidth*VramWidth*4
                dad d
            pop b | pop d
            xchg
                dad h
            xchg

            push d | push b
                di
                    mov a,e | out PORTA
                    in PORTB | ani not $03
                    ora d | out PORTB

                    lxi d,CharWidth*VramWidth-46
                    xra a
                    do
                        push psw
                            call WaitLCD
                            out LCDCOM ; address counter

                            call WaitLCD
                            mvi a,$32 | out LCDCOM ; counter mode

                            mvi b,46
                            do
                                mov a,m | inx h
                                call WaitLCD
                                out LCDIO
                                dcr b
                            while nz | wend
                            dad d
                        pop psw
                        adi $40
                    while nz | wend
                ei
                lxi d,46-CharWidth*VramWidth*4
                dad d
            pop b | pop d

            lxi d,CharWidth*VramWidth*4-96
            dad d

            lxi d,$020
            dcr c
        while nz | wend
        call WaitLCD
    pop b | pop d | pop h | pop psw
ret


CharPatternEDE:
    xchg
        mvi h,0
        dad h
        lxi b,CharPattern
        dad b
    xchg
ret

; ptr<byte> PutU(ptr<byte> pVram, byte c);
cseg
PutU_: public PutU_
    push psw | push d | push b
        call CharPatternEDE
        mvi b,2
        do
            mov a,m | ani $f0 | mov c,a
            ldax d | inx d
            push psw
                ani $0f
                ora c
                mov m,a | inx h

                mov a,m | ani $f0 | mov c,a
            pop psw
            rrc | rrc | rrc | rrc
            ani $0f
            ora c
            mov m,a | inx h

            dcr b
        while nz | wend
    pop b | pop d | pop psw
ret

cseg
PutL_: public PutL_
    push psw | push d | push b
        call CharPatternEDE
        mvi b,2
        do
            mov a,m | ani $0f | mov c,a
            ldax d | inx d
            push psw
                rrc | rrc | rrc | rrc
                ani $f0
                ora c
                mov m,a | inx h

                mov a,m | ani $0f | mov c,a
            pop psw
            ani $f0
            ora c
            mov m,a | inx h

            dcr b
        while nz | wend
    pop b | pop d | pop psw
ret


; void VVramToVram();
dseg
xCount:
    defb 0
yCount:
    defb 0
cseg
VVramToVram_: public VVramToVram_
    push psw | push h | push d | push b
        lxi b,VVramFront_+VVramWidth+1
        lxi d,Vram_+VramRowSize
        lxi h,Backup
        mvi a,WindowHeight/2 | sta yCount
        do
            mvi a,WindowWidth | sta xCount
            do
                ldax b | inx b
                cmp m
                if nz
                    mov m,a
                    xchg
                        push d
                            mov e,a
                            call PutU_
                        pop d
                    xchg
                else
                    inx d | inx d | inx d | inx d
                endif
                inx h
                lda xCount | dcr a | sta xCount    
            while nz | wend
            inx b | inx b
            inx d | inx d | inx d | inx d

            xchg
                push d
                    lxi d,-VramRowSize
                    dad d
                pop d
            xchg

            mvi a,WindowWidth | sta xCount
            do
                ldax b | inx b
                cmp m
                if nz
                    mov m,a
                    xchg
                        push d
                            mov e,a
                            call PutL_
                        pop d
                    xchg
                else
                    inx d | inx d | inx d | inx d
                endif
                inx h
                lda xCount | dcr a | sta xCount    
            while nz | wend
            inx b | inx b
            inx d | inx d | inx d | inx d
            lda yCount | dcr a | sta yCount
        while nz | wend
    pop b | pop d | pop h | pop psw
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    push psw | push d | push b
        mov a,e
        cpi ' '
        if z
            xra a
        else
            cpi '-'
            if z
                mvi a,$01
            else
                cpi 'A'
                if nc
                    adi $0c-'A'
                else
                    adi $02-'0'
                endif
            endif
        endif
        add a ;*2
        add a ;*4
        push h
            mov l,a
            mvi h,0
            lxi d,AsciiPattern
            dad d
            xchg
        pop h
        mvi b,4
        do
            ldax d | inx d
            mov m,a | inx h
            dcr b
        while nz | wend
    pop b | pop d | pop psw
ret
