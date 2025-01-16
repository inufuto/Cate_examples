ext WaitTimer_

Tempo equ 180

BeepPort equ 35h
BeepBit equ 08h
TimerControlPort equ 3fdfh
Timer1CyclePort equ 3fdbh

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
pCycle:
    defw 0
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
InitSoundBeep: public InitSoundBeep
    in al,(42h)
    test al,20h
    if z
        mov bx,cycles10
    else
        mov bx,cycles10
    endif
    mov [pCycle],bx

    call OffAll
ret


ToneOn:
;   cx : cycle
    push ax | push dx
        mov dx,TimerControlPort
        mov al,76h
        out dx,al

        mov dx,Timer1CyclePort
        mov al,cl | out dx,al
        xchg ax,ax
        mov al,ch | out dx,al

        in al,BeepPort
        and al,not BeepBit
        out BeepPort,al
    pop dx| pop ax
ret


ToneOff:
    push ax
        in al,BeepPort
        or al,BeepBit
        out BeepPort,al
    pop ax
ret


SoundHandlerBeep: public SoundHandlerBeep
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
                                                    _deb: public _deb
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
                            add ax,[pCycle]
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
        mov [Channel0+Channel_Ptr],bx
        mov byte ptr [Channel0+Channel_Len],1
    sti
ret

MelodyWait:
    call Melody
    do
        cmp word ptr [Channel0+Channel_Ptr],0
    while nz | wend
ret 


loose_notes:
    defb 1,A3, 0
Sound_LooseBeep: public Sound_LooseBeep
    push bx
        mov bx,loose_notes
        call MelodyWait
    pop bx
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_HitBeep: public Sound_HitBeep
    push bx
        mov bx,hit_notes
        call Melody
    pop bx
ret


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_StoleBeep: public Sound_StoleBeep
    push bx
        mov bx,stole_notes
        call Melody
    pop bx
ret


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_FireBeep: public Sound_FireBeep
    push bx
        mov bx,fire_notes
        call Melody
    pop bx
ret


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_BonusBeep: public Sound_BonusBeep
    push bx
        mov bx,bonus_notes
        call MelodyWait
    pop bx
ret


start_notes: 
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_StartBeep: public Sound_StartBeep
    mov bx,start_notes
jmp MelodyWait


clear_notes:
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_ClearBeep: public Sound_ClearBeep
    mov bx,clear_notes
jmp MelodyWait


over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOverBeep: public Sound_GameOverBeep
    mov bx,over_notes
jmp MelodyWait


cseg
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
    defb 0ffh

StartBGMBeep: public StartBGMBeep
    push ax
        cli
            mov ax,BGM_B
            mov [Channel1+Channel_Start],ax
            mov [Channel1+Channel_Ptr],ax
            mov byte ptr [Channel1+Channel_Len],1
        sti
    pop ax
ret

StopBGMBeep: public StopBGMBeep
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

cycles10:
defw 11171 ;A3
defw 10544 ;A#3
defw 9952 ;B3
defw 9394 ;C4
defw 8866 ;C#4
defw 8369 ;D4
defw 7899 ;D#4
defw 7456 ;E4
defw 7037 ;F4
defw 6642 ;F#4
defw 6269 ;G4
defw 5918 ;G#4
defw 5585 ;A4
defw 5272 ;A#4
defw 4976 ;B4
defw 4697 ;C5
defw 4433 ;C#5
defw 4184 ;D5
defw 3950 ;D#5
defw 3728 ;E5
defw 3519 ;F5
defw 3321 ;F#5
defw 3135 ;G5

cycles8:
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
