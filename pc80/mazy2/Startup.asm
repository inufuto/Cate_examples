ext Main_
ext InitSound_

ROM_Width  equ 00843h
ROM_Console    equ 00884h
ROM_Cls equ 45ah

dseg
PrevSync: defb 0
TimerCount:
    defb 0

cseg
	ld hl, Param_Width
    call ROM_Width
	ld hl,Param_Console
	call ROM_Console
    call ROM_Cls

    ld a,30h | out (0e6h),a

	xor a
	ld (PrevSync),a
	ld (TimerCount),a

    call InitSound_
    call Main_
ret
Param_Width:
	defb '80,25',0
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
