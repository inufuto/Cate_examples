include "Share.inc"

dseg
Playing: public Playing
    defb 0
KeyCode: public KeyCode
    defb 0
JoyStickValue:  public JoyStickValue
    defb 0
TimerCount: public TimerCount
    defb 0

cseg
HaltSub: public HaltSub
    push af
        do
            in a,(0ffh)
            and 10h
        while z | wend
        ld a,02h | out (0fch),a
        do
            in a,(0ffh)
            and 08h
        while nz | wend

        ld a,(MainShareRam+Share_KeyCode) | ld (KeyCode),a
        ld a,(MainShareRam+Share_JoystickValue) | ld (JoyStickValue),a
        ld a,(MainShareRam+Share_TimerCount) | ld (TimerCount),a
        ld a,(MainShareRam+Share_Playing) | ld (Playing),a
    pop af
ret

ResumeSub: public ResumeSub
    push af
        xor a | out (0fch),a
        do
            in a,(0ffh)
            and 10h
        while nz | wend
    pop af
ret