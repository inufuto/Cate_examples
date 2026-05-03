FirstEntry equ >6080

RamTail equ >3f00

cseg
    li r3,>6000 ; Bank
    li r1,FirstEntry
    li r2,>a000
    do
        mov r3,*r3+
        do
            mov *r1+,r0
            mov r0,*r2+
            ci r1,>8000
        while ne | wend
        li r1,>6000
        ci r3,>6004 ; 8K*2
    while ne | wend

    ; limi >0000
    ; lwpi RamTail
    ; li r10,RamTail
    li r10,>83e0
b @>a000
defs 18+4
