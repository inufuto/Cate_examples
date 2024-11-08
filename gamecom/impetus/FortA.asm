include "GameCom.inc"
include "Vram.inc"
include "VVram.inc"

ext FortY_, oldFortY0_, oldFortY1_
ext pCurrentBackup

Width equ 6*CharWidth
Height equ 6*CharHeight
FortX equ (VVramWidth*CharWidth-Width)/2

; void DrawFort()
cseg
DrawFort_: public DrawFort_
    pushw rr0
        mov r1,@FortY_
        mov @oldFortY0_,r1
        or r1,r1
        if nz
            mov r0,r LCC
            and r0,40h
            rl r0 | rl r0 | rl r0
            xor r0,02h
            mov r DMVP,r0
            mov r DMBR,FortBank
            mov r DMPL,0d0h
            mov r DMY1,128
            mov r DMX1,0
            mov r DMDY,Width-1
            mov r0,Height-1
            mov r DMY2,LeftMargin+FortX
            sub r1,Height
            if c
                add r0,r1
                neg r1
                mov r DMX1,r1
                clr r1
            endif
            mov r DMDX,r0
            add r1,TopMargin+CharHeight*2
            mov r DMX2,r1

            pushw rr IE0_
                mov IE0,80h
                clr r IE1_
                mov r DMC,82h
                halt | bclr r IR0_,7
            popw rr IE0_
        endif
    popw rr0
ret


; void EraseFort();
cseg
EraseFort_: public EraseFort_
    pushw rr0 | pushw rr8
        mov r1,@oldFortY1_
        or r1,r1
        if nz
            mov r2,Height
            sub r1,Height
            if c
                add r2,r1
                clr r1
            endif
                                    _deb: public _deb
            srl r1 | srl r1 | srl r1
            mult rr0,VVramWidth
            movw rr8,@pCurrentBackup
            addw rr8,rr0
            addw rr8,FortX/CharWidth
            mov r1,0ffh
            add r2,CharHeight-1
            srl r2 | srl r2 | srl r2
            do
                mov r3,Width/CharWidth
                do
                    mov (rr8)+,r1
                    dec r3
                while nz|wend
                addw rr8,VVramWidth-Width/CharWidth

                dec r2
            while nz|wend
        endif
        mov r1,@oldFortY0_
        mov @oldFortY1_,r1
    popw rr8 | popw rr0
ret