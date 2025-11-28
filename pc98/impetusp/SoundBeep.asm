ext WaitTimer_

tempo equ 180

BeepPort equ 35h
BeepBit equ 08h
TimerControlPort equ 3fdfh
Timer1CyclePort equ 3fdbh

dseg
SoundProc:
    defw 0,0
pCycle:
    defw 0
time:
    defw 0
pMelody:
    defw 0
lenCount:
    defb 0

cseg
InitSoundBeep: public InitSoundBeep
    in al,(42h)
    test al,20h
    if z
        mov bx,cycles10
    else
        mov bx,cycles10
    endif
    mov [pCycle],bx

    mov ax,0
    mov [time],ax
    mov [pMelody],ax
    mov [SoundProc],ax
ret

CallSoundBeep: public CallSoundBeep
    push bx
        mov bx,[SoundProc]
        cmp bx,0
        if ne
            call bx
            mov word ptr [SoundProc],0
        endif
    pop bx
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


Sound_FireBeep: public Sound_FireBeep
    push cx
        mov cx,5500
        call ToneOn
        mov al,2
        call WaitTimer_
        call ToneOff
    pop cx
ret

Sound_Hit:
    push cx
        mov cx,5500
        do
            call ToneOn
            mov al,1
            call WaitTimer_
            sub cx,100
            cmp cx,3000
        while nb | wend
        call ToneOff
    pop cx
ret
Sound_HitBeep: public Sound_HitBeep
    push bx
        mov bx,Sound_Hit
        mov [SoundProc],bx
    pop bx
ret

Sound_Loose:
    push cx
        mov cx,3000
        do
            call ToneOn
            mov al,1
            call WaitTimer_
            add cx,100
            cmp cx,5500
        while b | wend
        call ToneOff
    pop cx
ret
Sound_LooseBeep: public Sound_LooseBeep
    push bx
        mov bx,Sound_Loose
        mov [SoundProc],bx
    pop bx
ret


SoundHandlerBeep: public SoundHandlerBeep
    push ax
        mov ax,[time]
        sub ax,tempo
        if b
            push ax | push bx | push cx
                mov bx,[pMelody]
                or bx,bx
                if nz
                    dec byte ptr [lenCount]
                    if z
                        mov al,[bx] | inc bx
                        or al,al
                        if z
                            ; end
                            mov word ptr [pMelody],0
                            call ToneOff
                            jmp exit
                        endif
                        mov [lenCount],al
                        mov al,[bx] | inc bx
                        mov [pMelody],bx
                        or al,al
                        if nz
                            dec al
                            shl al,1
                            xor ah,ah
                            add ax,[pCycle]
                            mov bx,ax
                            mov cx,[bx]
                            call ToneOn
                        else
                            call ToneOff
                        endif
                    endif
                endif
                exit:
            pop cx | pop bx | pop ax
            add ax,600
        endif
        mov [time],ax
    pop ax
ret

Melody:
    cli
        mov [pMelody],bx
        mov byte ptr [lenCount],1
    sti
ret 

MelodyWait:
    cli
        mov [pMelody],bx
        mov byte ptr [lenCount],1
    sti
    do
        cmp word ptr [pMelody],0
    while nz | wend
ret 

up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_UpBeep:  public Sound_UpBeep
    push bx
        mov bx,up_notes
        call Melody
    pop bx
ret


start_notes:
	defb 2,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 5,C5,1,0, 2,A4,1,0, 5,D5,1,0
	defb 5,D5,1,0, 2,C5,1,0, 8,D5,1,0
	defb 17,E5,1,0
	defb 6,0
    defb 0
Sound_StartBeep: public Sound_StartBeep
    mov bx,start_notes
jmp MelodyWait

; clear_notes: 
;     defb 5,A4,1,0, 6,0, 5,A4,1,0, 5,G4,1,0
; 	defb 5,A4,1,0, 11,C5,1,0, 5,D5,1,0
; 	defb 6,0, 5,C5,1,0, 6,0, 17,A4,1,0
; 	defb 24,0
;     defb 0
; Sound_ClearBeep: public Sound_ClearBeep
;     mov bx,clear_notes
; jmp MelodyWait

over_notes:
	defb 5,A4,1,0, 2,E4,1,0, 2,A4,1,0
	defb 2,G4,1,0, 2,F4,1,0, 2,E4,1,0, 2,D4,1,0
	defb 17,E4,1,0
	defb 6,0
    defb 0
Sound_GameOverBeep: public Sound_GameOverBeep
    mov bx,over_notes
jmp MelodyWait


C4 equ 1
C4S equ 2
D4 equ 3
D4S equ 4
E4 equ 5
F4 equ 6
F4S equ 7
G4 equ 8
G4S equ 9
A4 equ 10
A4S equ 11
B4 equ 12
C5 equ 13
C5S equ 14
D5 equ 15
D5S equ 16
E5 equ 17
F5 equ 18

cycles10:
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

cycles8:
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
