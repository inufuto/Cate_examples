Tempo equ 180/2

CommandPort equ 3600h
Cmd_Reset equ 00h
Cmd_Play equ 02h

Count equ 2
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Length equ Channel_Start+2
Channel_Tone equ Channel_Length+1
UnitSize equ Channel_Tone+1

dseg
Channels: public Channels
Channel0:
    defs UnitSize
Channel1:
    defs UnitSize
Time:
    defb 0

cseg
InitSound: public InitSound
    di
        lxi h,Channels
        xra a,a
        mvi b,Count*UnitSize-1
        do
            stax h+
            dcr b
        repeat
    ei
    xra a,a
    mov CommandPort,a
    mov Time,a
ret

ToneOn: public ToneOn
    push h
        lxi h,CommandPort
        mvix h,Cmd_Play
        do
            skit f1
        repeat
        mvix h,80h
        do
            skit f1
        repeat
        stax h
        do
            skit f1
        repeat
        mvix h,15h
        do
            skit f2
        repeat
    pop h
ret

ToneOff:
    push h
        lxi h,CommandPort
        mvix h,Cmd_Reset
        do
            skit f2
        repeat
    pop h
ret

SoundHandler: public SoundHandler
    push v
        mov a,Time
        sui a,Tempo
        if skc
            push v | push h | push d | push b
                lxi h,Channels
                mvi b,Count-1
                do
                    ldax h+ | mov e,a ; ptr low
                    ldax h- | mov d,a ; ptr high
                    ora a,e
                    if sknz
                        inx h | inx h | inx h |inx h
                        ldax h | dcr a | stax h; length
                        dcx h | dcx h | dcx h | dcx h
                        if skz
                            continue:
                            ldax d ; next length
                            ora a,a
                            if skz
                                ; end
                                stax h+ | stax h- ; ptr low/high
                                offch:
                                inx h | inx h | inx h | inx h | inx h
                                stax h ; tone
                                dcx h | dcx h | dcx h | dcx h | dcx h
                                if eqi b,Count-1
                                    ; Channel0
                                    mov a,Channel1+Channel_Tone
                                    ora a,a
                                    if sknz
                                        call ToneOn
                                        jr next
                                    endif
                                endif
                                call ToneOff
                                jr next
                            endif
                            if eqi a,0ffh
                                ; repeat
                                inx h | inx h
                                ldax h+ | mov e,a; start low
                                ldax h- | mov d,a; start high
                                dcx h | dcx h
                                jr continue
                            endif
                            inx h | inx h | inx h |inx h
                            stax h ; length
                            dcx h | dcx h | dcx h | dcx h

                            inx d
                            ldax d ; tone
                            inx d
                            mov c,a
                                mov a,e | stax h+ ; ptr low
                                mov a,d | stax h- ; ptr high
                            mov a,c
                            ora a,a
                            sknz | jr offch
                            dcr a
                            adi a,low Cycles | mov e,a
                            mvi a,high Cycles | aci a,0 | mov d,a
                            ldax d
                            inx h | inx h | inx h | inx h | inx h
                            stax h ; tone
                            dcx h | dcx h | dcx h | dcx h | dcx h
                            if eqi b,1-1
                                ; Channel1
                                mov c,a
                                    mov a,Channel0+Channel_Tone
                                    ora a,a
                                mov a,c
                                skz | jr next
                            endif
                            call ToneOn
                        endif
                    endif
                    next:
                    adi l,UnitSize | aci h,0
                    dcr b
                repeat
            pop b | pop d | pop h | pop v
            adi a,600/2/2
        endif
        mov Time,a
    pop v
ret

Melody:
    push v
        di
            shld Channel0+Channel_Ptr  
            mvi a,1 | mov Channel0+Channel_Length,a
        ei
    pop v
ret

MelodyWait:
    call Melody
    push v
        do
            lhld Channel0+Channel_Ptr
            mov a,l | ora a,h
        while sknz | wend
    pop v
ret 

loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push h
        lxi h,loose_notes
        call MelodyWait
    pop h
ret

hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_:  public Sound_Hit_
    push h
        lxi h,hit_notes
        call Melody
    pop h
ret

stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole_: public Sound_Stole_
    push h
        lxi h,stole_notes
        call Melody
    pop h
ret

fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push h
        lxi h,fire_notes
        call Melody
    pop h
ret

bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    push h
        lxi h,bonus_notes
        call MelodyWait
    pop h
ret


start_notes:
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    push h
        lxi h,start_notes
        call MelodyWait
    pop h
ret

clear_notes:
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push h
        lxi h,clear_notes
        call MelodyWait
    pop h
ret


over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push h
        lxi h,over_notes
        call MelodyWait
    pop h
ret


BGM_B:
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,D4,1,0
	defb 11,D4,1,0, 5,D4,1,0, 11,E4,1,0
	defb 17,D4,1,0, 36,0
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,F4,1,0
	defb 11,F4,1,0, 5,F4,1,0, 11,A4,1,0
	defb 17,G4,1,0, 36,0
	defb 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 11,E4,1,0
	defb 5,E4,1,0, 11,A4,1,0, 5,D4,1,0
	defb 5,D4,1,0, 5,D4,1,0, 11,D4,1,0
	defb 5,D4,1,0, 11,G4,1,0, 6,0
	defb 5,A4,1,0, 6,0, 5,G4,1,0, 6,0
	defb 5,F4,1,0, 6,0, 5,E4,1,0, 11,D4,1,0
	defb 11,E4,1,0, 23,C4,1,0
    defb $ff

StartBGM_: public StartBGM_
    push v | push h
        di
            mvi a,1 | mov Channel1+Channel_Length,a
            lxi h,BGM_B
            shld Channel1+Channel_Start
            shld Channel1+Channel_Ptr
        ei
    pop h | pop v
ret

StopBGM_: public StopBGM_
    push v | push h
        lxi h,0
        shld Channel1+Channel_Ptr
        xra a,a
        mov Channel1+Channel_Tone,a
        
        lxi h,CommandPort
        mvix h,Cmd_Reset
        do
            skit f2
        repeat
    pop h | pop v
ret



G3 equ 1
G3S equ 2
A3 equ 3
A3S equ 4
B3 equ 5
C4 equ 6
C4S equ 7
D4 equ 8
D4S equ 9
E4 equ 10
F4 equ 11
F4S equ 12
G4 equ 13
G4S equ 14
A4 equ 15
A4S equ 16
B4 equ 17
C5 equ 18
C5S equ 19
D5 equ 20
D5S equ 21
E5 equ 22
F5 equ 23
F5S equ 24
G5 equ 25

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defb 242 ; G3
defb 229 ; G3S
defb 216 ; A3
defb 204 ; A3S
defb 192 ; B3
defb 182 ; C4
defb 171 ; C4S
defb 162 ; D4
defb 153 ; D4S
defb 144 ; E4
defb 136 ; F4
defb 128 ; F4S
defb 121 ; G4
defb 114 ; G4S
defb 108 ; A4
defb 102 ; A4S
defb 96 ; B4
defb 91 ; C5
defb 86 ; C5S
defb 81 ; D5
defb 76 ; D5S
defb 72 ; E5
defb 68 ; F5
defb 64 ; F5S
defb 61 ; G5
