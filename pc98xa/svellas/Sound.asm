ext WaitTimer_

Tempo equ 170

BeepPort equ 37h
BeepOn equ 06h
BeepOff equ 07h

TimerControlPort equ 3fdfh
Timer1CyclePort equ 73h

Count equ 2
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Tone equ Channel_Start+2
Channel_Len equ Channel_Tone+2
UnitSize equ Channel_Len+1

dseg
Channels: public Channels
Channel0:
    defs UnitSize
Channel1:
    defs UnitSize
time:
    defw 0


cseg
OffAll:
    cli
        mov bx,Channels
        xor ax,ax
        mov cl,Count
        do
            mov [bx+Channel_Ptr],ax
            mov [bx+Channel_Tone],ax
            add bx,UnitSize
            dec cl
        while nz | wend
        call ToneOff
    sti
ret
InitSound: public InitSound
    mov al,76h | out TimerControlPort,al
    call OffAll
ret


ToneOn:
;   cx : cycle
    push ax
        mov al,cl | out Timer1CyclePort,al
        mov al,ch | out Timer1CyclePort,al

        mov al,BeepOn | out BeepPort,al
    pop ax
ret


ToneOff:
    push ax
        mov al,BeepOff | out BeepPort,al
    pop ax
ret


SoundHandler: public SoundHandler
    push ax
        mov ax,[time]
        sub ax,Tempo
        if b
            push ax | push bx | push cx | push dx | push si
                mov si,Channels
                mov dl,Count
                do
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr [si+Channel_Len]
                        if z
                            continue:
                            mov al,[bx]
                            or al,al
                            if z
                                ; end
                                mov word ptr [si+Channel_Ptr],0
                                offch:
                                mov word ptr [si+Channel_Tone],0
                                cmp dl,2
                                if z
                                    ; Channel0 end
                                    mov cx,[Channel1++Channel_Tone]
                                    or cx,cx
                                    if nz
                                        call ToneOn
                                        jmp next
                                    endif
                                endif
                                call ToneOff
                                jmp next
                            endif
                            cmp al,0ffh
                            if z 
                                ; repeat
                                mov bx,[si+Channel_Start]
                                jmp continue
                            endif
                            mov [si+Channel_Len],al
                            inc bx
                            mov al,[bx] | inc bx
                            mov [si+Channel_Ptr],bx
                            or al,al
                            jz offch
                            dec al
                            add al,al
                            xor ah,ah
                            add ax,Cycles
                            mov bx,ax
                            mov cx,[bx]
                            mov [si+Channel_Tone],cx
                            cmp dl,1
                            if z
                                ; Channel1
                                cmp word ptr[Channel0+Channel_Tone],0
                                jnz next
                            endif
                            call ToneOn
                        endif
                    endif
                    next:
                    add si,UnitSize
                    dec dl
                while nz | wend
            pop si | pop dx | pop cx | pop bx | pop ax
            add ax,600/2
        endif
        mov [time],ax
    pop ax
ret


Melody:
    cli
        mov [Channel0+Channel_Ptr],ax
        mov byte ptr [Channel0+Channel_Len],1
    sti
ret

MelodyWait:
    call Melody
    do
        cmp word ptr [Channel0+Channel_Ptr],0
    while nz | wend
ret 


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push ax
        mov ax,loose_notes
        call MelodyWait
    pop ax
ret


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push ax
        mov ax,hit_notes
        call Melody
    pop ax
ret


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push ax
        mov ax,beep_notes
        call MelodyWait
    pop ax
ret


; void Sound_Move();
Sound_Move_:  public Sound_Move_
    push ax
        mov ax,beep_notes
        call Melody
    pop ax
ret


; void Sound_Start();
start_notes:
	defb 11,C5,1,0, 11,C5,1,0
	defb 11,G4,1,0, 11,G4,1,0
	defb 7,E5,1,0, 3,D5,1,0, 7,E5,1,0, 15,D5,1,0
	defb 11,D5,1,0, 35-4,C5,1+4,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    push ax
        mov ax,start_notes
        call MelodyWait
    pop ax
ret


; void Sound_Clear();
clear_notes:
	defb 11,C4,1,0, 11,E4,1,0
	defb 19,G4,1,0, 11,A4,1,0
	defb 3,A4,1,0, 7,G4,1,0, 3,F4,1,0, 7,G4,1,0
	defb 3,G4,1,0, 7,A4,1,0, 3,B4,1,0, 35-4,C5,1+4,0
	defb 12,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push ax
        mov ax,clear_notes
        call MelodyWait
    pop ax
ret


; void Sound_GameOver();
over_notes:
	defb 7,C5,1,0, 3,C5,1,0, 7,B4,1,0, 3,B4,1,0
	defb 7,A4,1,0, 3,A4,1,0, 7,G4,1,0, 3,E4,1,0
	defb 7,G4,1,0, 3,G4,1,0, 7,A4,1,0, 3,B4,1,0
	defb 23,C5,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push ax
        mov ax,over_notes
        call MelodyWait
    pop ax
ret


BGM_B:
	defb 11,C5,1,0, 11,C5,1,0
	defb 11,G4,1,0, 11,G4,1,0
	defb 7,E5,1,0, 3,D5,1,0, 7,E5,1,0, 23,D5,1,0
	defb 4,0, 11,E5,1,0, 11,G5,1,0
	defb 7,D5,1,0, 3,C5,1,0, 7,D5,1,0, 47,E5,1,0
	defb 4,0, 11,F5,1,0, 11,F5,1,0
	defb 11,E5,1,0, 11,E5,1,0
	defb 7,D5,1,0, 3,D5,1,0, 7,D5,1,0, 23,E5,1,0
	defb 4,0, 11,F5,1,0, 11,F5,1,0
	defb 11,E5,1,0, 11,E5,1,0
	defb 7,G5,1,0, 3,G5,1,0, 7,G5,1,0, 23,D5,1,0
	defb 4,0, 11,C5,1,0, 11,C5,1,0
	defb 11,G4,1,0, 11,G4,1,0
	defb 7,E5,1,0, 3,D5,1,0, 7,E5,1,0, 23,D5,1,0
	defb 4,0, 11,E5,1,0, 11,G5,1,0
	defb 7,D5,1,0, 3,C5,1,0, 7,D5,1,0, 47,E5,1,0
	defb 4,0, 11,F5,1,0, 11,F5,1,0
	defb 11,E5,1,0, 11,E5,1,0
	defb 7,G5,1,0, 3,G5,1,0, 7,G5,1,0, 15,E5,1,0
	defb 11,D5,1,0, 11,C5,1,0
	defb 11,G4,1,0, 7,C5,1,0, 11,D5,1,0
	defb 47,C5,1,0
	defb 4,0
    defb 0ffh

StartBGM_: public StartBGM_
    push ax
        cli
            mov ax,BGM_B
            mov [Channel1+Channel_Start],ax
            mov [Channel1+Channel_Ptr],ax
            mov byte ptr [Channel1+Channel_Len],1
        sti
    pop ax
ret

StopBGM_: public StopBGM_
    push ax
        do
            cmp word ptr[Channel0+Channel_Ptr],0
        while nz | wend
        call OffAll
    pop ax
ret


A3 equ 1
A3S equ 2
B3 equ 3
C4 equ 4
C4S equ 5
D4 equ 6
D4S equ 7
E4 equ 8
F4 equ 9
F4S equ 10
G4 equ 11
G4S equ 12
A4 equ 13
A4S equ 14
B4 equ 15
C5 equ 16
C5S equ 17
D5 equ 18
D5S equ 19
E5 equ 20
F5 equ 21
F5S equ 22
G5 equ 23

Cycles:
defw 9076 ;A3
defw 8567 ;A#3
defw 8086 ;B3
defw 7632 ;C4
defw 7204 ;C#4
defw 6800 ;D4
defw 6418 ;D#4
defw 6058 ;E4
defw 5718 ;F4
defw 5397 ;F#4
defw 5094 ;G4
defw 4808 ;G#4
defw 4538 ;A4
defw 4283 ;A#4
defw 4043 ;B4
defw 3816 ;C5
defw 3602 ;C#5
defw 3400 ;D5
defw 3209 ;D#5
defw 3029 ;E5
defw 2859 ;F5
defw 2698 ;F#5
defw 2547 ;G5
