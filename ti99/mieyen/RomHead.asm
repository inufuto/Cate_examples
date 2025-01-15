RamEntry equ >fec0

cseg
    defb >aa,1,1,0
    defw 0,List,0,0
List:
    defw 0,Entry
    defb 6,'MIEYEN   '
    defs 16
Entry: public Entry
    li r1,RamHead
    li r2,RamEntry
    do
        mov *r1+,r0
        mov r0,*r2+
        ci r1,RamHead+64
    while ne | wend
    b @RamEntry
RamHead:
