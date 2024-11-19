include "InternalRam.inc"

RndCount equ 32

dseg
RndIndex_: public RndIndex_
    defb 0

cseg
Numbers:
    defb 26,30,1,16,9,13,12,5
    defb 14,15,27,7,4,3,24,20
    defb 8,18,22,10,19,21,23,6
    defb 2,29,28,11,31,0,17,25

; byte Rnd();
cseg
Rnd_: public Rnd_
    exab|push
    lp RegisterX+1|ldm|push
    lp RegisterX|ldm|push
        lia low(Numbers-1) | lp RegisterX | exam
        lia high(Numbers-1) | lp RegisterX+1 | exam
        lidp RndIndex_|ldd
        push
            inca
            std
        pop
        lib 0
        adb
        ixl
    lp RegisterX|exam|pop|exam
    lp RegisterX+1|exam|pop|exam
    exab|pop|exab
rtn


; ; byte Abs(byte a, byte b);
; cseg
; Abs_: public Abs_
;     exab|push|exab
;         lp RegisterB | sbm | exab
;         if nz
;             tsia 80h
;             if nz
;                 lib 0
;                 sbm
;                 exab
;             endif
;         endif
;     exab|pop|exab
; rtn
