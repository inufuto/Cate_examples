ext InitVram
ext InitSound, SoundHandler
ext Main_


dseg
PrevSync:
    defb 0
TimerCount:
    defb 0

cseg
	ld hl, Param_Width
    call 843h
    ld hl,Param_Console
    call 884h

    ld a,8 | out (03h),a ; PCG On
    call InitSound
    call InitVram
jp Main_
Param_Width:
	defb '40,25',0
Param_Console:
	defb '0,25,0,1',0


PollVSync_: public PollVSync_
	push af
		in a,(40h)
		and 20h
        if nz
            ld a,(PrevSync)
            or a
            call z,Handler
            ld a,20h
        endif
        ld (PrevSync),a
    pop af
ret


Handler: public Handler
    call SoundHandler
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
ret


WaitTimer_:
    public WaitTimer_
    push af | push de
        ld e,a
        do
            call PollVSync_
            ld a,(TimerCount)
            cp e
        while c | wend
        ; di
            xor a
            ld (TimerCount),a
        ; ei
    pop de | pop af
ret
