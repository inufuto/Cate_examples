include "FixedCode.inc"

ext InitChars
ext FixedCode, InitSound
ext Main_

Port31Save equ 0e6c6h

dseg
old31: defb 0
PrevSync: defb 0
TimerCount: defb 0 public TimerCount

cseg
    ld hl,FixedCode
    ld de,FixedCode_start
    ld bc,FixedCode_size
    ldir

	xor a
	out (68h),a
	out (0e6h),a

    ld a,(Port31Save)
	ld (old31),a
	or 0fch
	and not 04h
    out (31h),a
	ld (Port31Save),a

	call InitChars
    call InitSound
    call Main_

    ld a,(old31)
    out (31h),a
	ld (Port31Save),a

	ld hl, ParamWidth
    call 00843h
ret	
ParamWidth:
	defb '40,25',0


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
