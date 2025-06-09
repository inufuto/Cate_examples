include "ngp.inc"

ext InitVram
ext InitSprites, UpdateSprites
ext InitSound
ext Main_

DataSegmentSize equ 0b00h

dseg
TimerCount: public TimerCount
    defb 0


cseg
    defb 20h,4Ch,49h,43h,45h,4Eh,53h,45h,44h,20h,42h,59h,20h,53h,4Eh,4Bh
    defb 20h,43h,4Fh,52h,50h,4Fh,52h,41h,54h,49h,4Fh,4Eh
    defd Startup
    defb 55h,00h,80h
    defb 10h ; Monochrome=00/Color=10
    defb '            '
    defs 16
Startup: public Startup
    ei
    ld xhl,210000h
    ld xde,6000h
    ld bc,DataSegmentSize
    ldir

    call InitVram
    call InitSound
    call InitSprites

    di
        ld xwa,Handler
        ld (VerticalBlankingInterrupt),xwa
    ei

    ld qwa,0
    ld qbc,0
    ld qde,0
    ld qhl,0
    ld qix,0
    ld qiy,0
    ld qix,0
jp Main_


ClearWatchDogTimer_: public ClearWatchDogTimer_
    push a
        ld a,4eh | ld (6fh),a
    pop a
ret


Handler: public Handler
    inc 1,(TimerCount)
    ld (Z80_Nmi),0
    call UpdateSprites
reti


WaitTimer_: public WaitTimer_
    push w
        do
            call ClearWatchDogTimer_
            ld w,(TimerCount)
            cp w,a
        while c | wend
        ld (TimerCount),0
    pop w
ret
