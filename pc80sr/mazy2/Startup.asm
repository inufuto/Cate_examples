include "FixedCode.inc"

ext FixedCode, InitVram, SoundHandler, InitSound
ext Main_

Port31Save equ 0e658h
Port33Save equ 0e669h

dseg
old31: defb 0
old33: defb 0
JpHandler:
    defs 3
; PrevSync: defb 0
count10:
    defb 0
TimerCount: defb 0 public TimerCount

cseg
    ld hl,FixedCode
    ld de,FixedCode_start
    ld bc,FixedCode_size
    ldir

	xor a
	out (68h),a
    inc a
	out (0e6h),a

    ld a,(Port31Save)
	ld (old31),a
	ld a,01dh
    out (31h),a
	ld (Port31Save),a

    ld a,(Port33Save)
	ld (old33),a
	ld a,84h
    out (33h),a
	ld (Port33Save),a

    di
        ld hl,(0f304h)
        ld (JpHandler+1),hl
        ld a,0c3h
        ld (JpHandler),a
        ld hl,Handler
        ld (0f304h),hl
    ei
    ld a,90h | out (35h),a
    call InitSound
	call InitVram
    call Main_
    di
        ld hl,(JpHandler+1)
        ld (0f304h),hl
    ei

    ld a,(old31)
    out (31h),a
	ld (Port31Save),a

    ld a,(old33)
    out (33h),a
	ld (Port33Save),a
ret	


Handler: public Handler
    push af
        ld a,(656bh)
        out (0e4h),a
        push hl
            ld hl,count10
            dec (hl)
            if z
                ld (hl),10
                push af
                call SoundHandler
                pop af
                ld hl,TimerCount
                inc (hl)
            endif
        pop hl
        ei
    pop af        
ret


WaitTimer_:
    public WaitTimer_
    push af | push de
        ld e,a
        do
            ld a,(TimerCount)
            cp e
        while c | wend
        di
            xor a
            ld (TimerCount),a
        ei
    pop de | pop af
ret
