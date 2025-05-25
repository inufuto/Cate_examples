ext PollVSync_, WaitTimer_

Port_Dcsg equ >8400

Dcsg_ToneA equ >00
Dcsg_VolumeA equ >10
Dcsg_ToneB equ >20
Dcsg_VolumeB equ >30
Dcsg_ToneC equ >40
Dcsg_VolumeC equ >50

MinVolume equ 63
Tempo equ 220
TempoDenom equ 600/2

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1


dseg
Channels defs unitSize*count
time: defw 0


cseg
InitSound: public InitSound
    li r9,Channels
    li r2,count
    do
        clr @Channel_Ptr(r9)
        clr @Channel_Start(r9)
        ai r9,unitSize
        dec r2
    while ne | wend
    clr @time
rt


cseg
ToneOn:
;   r1 : cycle
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
        mov r1,r2
        sla r2,8
        andi r2,>0f00
        ori r2,(>80 or Dcsg_ToneA) shl 8
        movb r2,@Port_Dcsg
        sla r1,4
        andi r1,>3f00
        movb r1,@Port_Dcsg
        li r1,(>80 or Dcsg_VolumeA) shl 8
        movb r1,@Port_Dcsg
    mov *r10+,r2
    mov *r10+,r1
rt


cseg
ToneOff:
    li r0,(8fh or Dcsg_VolumeA) shl 8
    movb r0,@Port_Dcsg
rt

cseg
SoundHandler: public SoundHandler
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
    dect r10 | mov r3,*r10
    dect r10 | mov r4,*r10
        mov @time,r0
        ai r0,-Tempo
        mov r0,@time
        if nc
            li r1,Channels
            li r2,count
            li r3,Dcsg_ToneA shl 8
            do
                mov @Channel_Ptr(r1),r4
                if ne
                    movb @Channel_Len(r1),r0
                    ai r0,->100
                    movb r0,@Channel_Len(r1)
                    srl r0,8
                    if eq
                        continue:
                        movb *r4+,r0 | srl r0,8
                        if eq
                            ; end
                            clr @Channel_Ptr(r1)
                            mov r3,r0 | ori r0,>9f00
                            movb r0,@Port_Dcsg
                            jmp next
                        endif
                        ci r0,>ff
                        if eq
                            mov @Channel_Start(r1),r4
                            jmp continue
                        endif
                        swpb r0 | movb r0,@Channel_Len(r1)
                        movb *r4+,r0
                        mov r4,@Channel_Ptr(r1)
                        srl r0,8
                        if ne
                            dec r0
                            sla r0,1
                            ai r0,cycles
                            movb *r0+,r4
                            soc r3,r4
                            ori r4,>8000
                            movb r4,@Port_Dcsg
                            movb *r0+,r4
                            movb r4,@Port_Dcsg
                            clr r0
                        else
                            li r0,MinVolume shl 8
                        endif
                        movb r0,@Channel_Vol(r1)
                    endif
                    movb @Channel_Vol(r1),r0
                    srl r0,2
                    andi r0,>ff00
                    mov r0,r4
                    soc r3,r4
                    ori r4,>9000
                    movb r4,@Port_Dcsg
                    movb @Channel_Vol(r1),r0
                    ci r0,MinVolume shl 8
                    if ne
                        ai r0,>0100
                        movb r0,@Channel_Vol(r1)
                    endif
                endif
                next:
                ai r3,>2000
                ai r1,unitSize
                dec r2
            while ne | wend
            mov @time,r0
            ai r0,TempoDenom
            mov r0,@time
        endif
    mov *r10+,r4
    mov *r10+,r3
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r0
    mov *r10+,r11
rt


Melody:
    dect r10 | mov r11,*r10
        mov r0,@Channels+Channel_Ptr
        li r0,>0100 | movb r0,@Channels+Channel_Len
    mov *r10+,r11
rt 

MelodyWait:
    dect r10 | mov r11,*r10
        bl @Melody
        do
            bl @PollVSync_
            mov @Channels+Channel_Ptr,r0
        while ne | wend
    mov *r10+,r11
rt


beep_notes:
    defb 1,A4, 0,0
Sound_Beep_: public Sound_Beep_
    dect r10 | mov r11,*r10
        li r0,beep_notes
        bl @MelodyWait
    mov *r10+,r11
rt


Sound_Get_: public Sound_Get_
    dect r10 | mov r11,*r10
        li r0,beep_notes
        bl @Melody
    mov *r10+,r11
rt


loose_notes:
    defb 1,A3, 0,0
Sound_Loose_: public Sound_Loose_
    dect r10 | mov r11,*r10
        li r0,loose_notes
        bl @MelodyWait
    mov *r10+,r11
rt


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0,0
Sound_Hit_: public Sound_Hit_
    dect r10 | mov r11,*r10
        li r0,hit_notes
        bl @Melody
    mov *r10+,r11
rt


cseg
start_notes: 
    defb N8,C4, N8,G4, N8,E4, N8,G4, N2,C5
    defb 0,0
Sound_Start_: public Sound_Start_
    dect r10 | mov r11,*r10
        li r0,start_notes
        bl @MelodyWait
    mov *r10+,r11
rt

clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5
    defb 0,0
Sound_Clear_: public Sound_Clear_
    dect r10 | mov r11,*r10
        li r0,clear_notes
        bl @MelodyWait
    mov *r10+,r11
rt

over_notes: 
    defb N8,C5, N8,G4, N8,E4, N8,C5,  N8,B4, N8,G4, N8,E4, N8,B4,  N4,A4, N4,B4,  N2,C5
    defb 0,0
Sound_GameOver_: public Sound_GameOver_
    dect r10 | mov r11,*r10
        li r0,over_notes
        bl @MelodyWait
    mov *r10+,r11
rt


BGM_B:
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,A4
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,F4
    defb >ff,0

BGM_C:
    defb N4P,0
    defb N4P,F3, N4P,F3, N4,F3
    defb N4P,C3, N4P,C3, N4,C3
    defb N2,F3, N2,G3, N2+N8,A2, N4P,0
    defb N4P,A2, N4P,A2, N4,A2
    defb N4P,G3, N4P,G3, N4,G3
    defb N2,F3, N2,C3, N2+N8,F3
    defb >ff,0

StartBGM_: public StartBGM_
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
        li r0,>100
        li r1,BGM_B
        mov r1,@Channels+unitSize*1+Channel_Start
        mov r1,@Channels+unitSize*1+Channel_Ptr
        movb r0,@Channels+unitSize*1+Channel_Len
        li r1,BGM_C
        mov r1,@Channels+unitSize*2+Channel_Start
        mov r1,@Channels+unitSize*2+Channel_Ptr
        movb r0,@Channels+unitSize*2+Channel_Len
    mov *r10+,r1
    mov *r10+,r0
rt


StopBGM_: public StopBGM_
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
        clr r0
        mov r0,@Channels+unitSize*1+Channel_Ptr
        mov r0,@Channels+unitSize*2+Channel_Ptr
        li r0,3
        li r1,(Dcsg_VolumeB or 8fh) shl 8
        do
            movb r1,@Port_Dcsg
            ai r1,>2000
            dec r0
        while ne | wend
    mov *r10+,r1
    mov *r10+,r0
rt


A2 equ 1
A2S equ 2
B2 equ 3
C3 equ 4
C3S equ 5
D3 equ 6
D3S equ 7
E3 equ 8
F3 equ 9
F3S equ 10
G3 equ 11
G3S equ 12
A3 equ 13
A3S equ 14
B3 equ 15
C4 equ 16
C4S equ 17
D4 equ 18
D4S equ 19
E4 equ 20
F4 equ 21
F4S equ 22
G4 equ 23
G4S equ 24
A4 equ 25
A4S equ 26
B4 equ 27
C5 equ 28
C5S equ 29
D5 equ 30
D5S equ 31
E5 equ 32
F5 equ 33
F5S equ 34
G5 equ 35

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defb 8,63 ; A2
defb 15,59 ; A#2
defb 9,56 ; B2
defb 7,53 ; C3
defb 7,50 ; C#3
defb 9,47 ; D3
defb 15,44 ; D#3
defb 6,42 ; E3
defb 0,40 ; F3
defb 12,37 ; F#3
defb 10,35 ; G3
defb 10,33 ; G#3
defb 12,31 ; A3
defb 15,29 ; A#3
defb 4,28 ; B3
defb 11,26 ; C4
defb 3,25 ; C#4
defb 12,23 ; D4
defb 7,22 ; D#4
defb 3,21 ; E4
defb 0,20 ; F4
defb 14,18 ; F#4
defb 13,17 ; G4
defb 13,16 ; G#4
defb 14,15 ; A4
defb 15,14 ; A#4
defb 2,14 ; B4
defb 5,13 ; C5
defb 9,12 ; C#5
defb 14,11 ; D5
defb 3,11 ; D#5
defb 9,10 ; E5
defb 0,10 ; F5
defb 7,9 ; F#5
defb 14,8 ; G5
