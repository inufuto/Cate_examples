include "GameCom.inc"
include "Vram.inc"
include "VVram.inc"

ext pCurrentBackup
ext FortOffset_

PatternY equ 72+1
TopY equ TopMargin+CharHeight*2
Width equ 7
Height equ 4

;void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    pushw rr0 | push r3
        mov r0,r LCC
        and r0,40h
        rl r0 | rl r0 | rl r0
        xor r0,02h
        mov r DMVP,r0
        mov r DMBR,CharBank
        mov r DMPL,0e4h
        mov r DMY1,PatternY
        mov r DMX1,0
        mov r DMDY,Width*CharWidth-1
        mov r DMDX,Height*CharHeight-1
        
        sll r3 | sll r3 | sll r3
        add r3,TopY
        mov r DMX2,r3

        sll r1 | sll r1 | sll r1
        sub r1,@FortOffset_
        cmp r1,1+(VVramWidth-Width)*CharWidth
        if nc
            mov r0,VVramWidth*CharWidth-1
            sub r0,r1
            mov r DMDY,r0
        endif
        mov r DMY2,r1

        ; di
            pushw rr IE0_
                mov IE0,80h
                clr r IE1_
                mov r DMC,82h
                halt | bclr r IR0_,7
            popw rr IE0_
        ; ei
    pop r3 | popw rr0
ret


; void EraseFort(byte x, byte y);
cseg
EraseFort_: public EraseFort_
    pushw rr0 | pushw rr2 | pushw rr4
        movw rr12,@pCurrentBackup

        mult rr2,VVramWidth
        clr r0
        addw rr2,rr0
        movw rr0,@pCurrentBackup
        addw rr2,rr0
        decw rr2

        mov r1,0ffh
        mov r4,Height
        do
            mov r5,Width+1
            do
                mov (rr2)+,r1
                dec r5
            while nz|wend
            addw rr2,VVramWidth-(Width+1)
            
            dec r4
        while nz|wend
    popw rr4 | popw rr2 | popw rr0
ret





