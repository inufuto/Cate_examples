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
    push xhl
        ld xhl,Numbers
        ld a,(RndIndex_)
        ld l,(xhl+a)
        
        ld a,(RndIndex_)
        inc 1,a
        and a,RndCount-1
        ld (RndIndex_),a
        
        ld a,l
    pop xhl
ret


; byte Abs(byte a, byte b);
Abs_: public Abs_
    sub	a,c
    ret z
    if c
        neg a
    endif
ret


; sbyte Sign(byte from, byte to);
cseg
Sign_: public Sign_
    sub	a,c
    ret z
    if nc
        ld a,-1
    else
        ld a,1
    endif
ret
