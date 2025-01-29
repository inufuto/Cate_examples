include "e500.inc"
include "Vram.inc"

ext InitSound
ext Main_

dseg
ImrSave:
    defb 0
IntSave:
    defp 0
TimerCount:
    defb 0

cseg
    mvw cx,0
    mv i,40h
    mv a,0
    callf FCS

    mv [ImrSave],imr
    pushu imr
        mv x,[0bfcc6h]
        mv [IntSave],x
        mv x,Handler
        mv [0bfcc6h],x
    popu imr
    
    call InitSound
    call Main_
    
    pushu imr
        mv x,[IntSave]
        mv [0bfcc6h],x
    popu imr
    mv imr,[ImrSave]
retf

Handler:
    pushs a
        mv a,[TimerCount]
        inc a
        mv [TimerCount],a
    pops a
retf


; void WaitTimer(byte t);
cseg
WaitTimer_: public WaitTimer_
    pushs a | pushs dl
        do
            mv dl,[TimerCount]
            cmp dl,a
        while c | wend
        pushu imr
            mv a,0 | mv [TimerCount],a
        popu imr
    pops dl | pops a
ret
