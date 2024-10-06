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
    ldx RndIndex_
    lda Numbers,x
    tay
    inx
    txa
    and #RndCount-1
    sta RndIndex_
rts


; sbyte Sign(byte from, byte to);
dseg
Sign_@Param1: public Sign_@Param1
    defb 0
cseg
Sign_: public Sign_
    pha
        tya
        sec|sbc Sign_@Param1
        if ne
            and #$80
            if ne
                lda #-1
            else
                lda #1
            endif
        endif
        tay
    pla
rts
