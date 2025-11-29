ext TimerCount

BeepPort equ 35h
BeepBit equ 08h

Tempo equ 180*3/5

dseg
Time:
    defw 0
pMelody:
    defw 0
CurrentCycle:
    defw 0
CurrentLen:
    defb 0


cseg
InitSound: public InitSound
    xor ax,ax
    mov [Time],ax
    mov [pMelody],ax
    mov [CurrentCycle],ax
ret

SoundHandler: public SoundHandler
    push ax
        mov ax,[time]
        sub ax,tempo
        if b
            push ax | push bx
                mov bx,[pMelody]
                or bx,bx
                if nz
										_deb: public _deb
                    mov al,[CurrentLen]
                    dec al
                    mov [CurrentLen],al
                    if z
                        mov al,[bx]
                        or al,al
                        if z
                            ; end
                            xor ax,ax
                            mov [pMelody],ax
                            mov [CurrentCycle],ax
                            jmp next
                        endif
                        ; dec al
                        mov [CurrentLen],al
                        inc bx
                        mov al,[bx]
                        inc bx
                        mov [pMelody],bx
                        or al,al
                        if nz
                            dec al
                            shl al,1
                            xor ah,ah
                            add ax,Cycles
                            mov bx,ax
                            mov ax,[bx]
                            mov [CurrentCycle],ax
                        else
                            mov word ptr[CurrentCycle],0
                        endif
                    endif
                endif
                next:
            pop bx | pop ax
            add ax,600/2
        endif
        mov [time],ax
    pop ax
ret

WaitTimer_: public WaitTimer_
    push ax | push bx
        mov ah,al
        do
            mov bx,[CurrentCycle]
            or bx,bx
            if nz
                push ax | push cx
                    in al,BeepPort
                    and al,not BeepBit
                    out BeepPort,al
                    mov cx,bx
                    do | wloop

                    in al,BeepPort
                    or al,BeepBit
                    out BeepPort,al
                    mov cx,bx
                    do | wloop
                pop cx | pop ax
            endif
            mov al,[TimerCount]
            cmp al,ah
        while b | wend
        cli
            mov byte ptr [TimerCount],0
        sti
    pop bx | pop ax
ret


Melody: public Melody
;   ax
    mov [pMelody],ax
    mov byte ptr[CurrentLen],1
ret

MelodyWait:
    call Melody
    do
        mov ax,1
        call WaitTimer_
        cmp word ptr [pMelody],0
    while nz | wend
ret 


Sound_Fire_: public Sound_Fire_
    push ax
        in al,BeepPort
        and al,not BeepBit
        out BeepPort,al

        mov al,3
        call WaitTimer_

        in al,BeepPort
        or al,BeepBit
        out BeepPort,al

        mov al,2
        call WaitTimer_
    pop ax
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push ax
        mov ax,hit_notes
        call Melody
    pop ax
ret


loose_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Loose_: public Sound_Loose_
    push ax
        mov ax,loose_notes
        call Melody
    pop ax
ret


up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_:  public Sound_Up_
    push ax
        mov ax,up_notes
        call Melody
    pop ax
ret


start_notes: 
	defb 2,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 5,C5,1,0, 2,A4,1,0, 5,D5,1,0
	defb 5,D5,1,0, 2,C5,1,0, 8,D5,1,0
	defb 17,E5,1,0
	defb 6,0
    defb 0
Sound_Start_: public Sound_Start_
    push ax
        mov ax,start_notes
        call MelodyWait
    pop ax
ret


over_notes: 
	defb 5,A4,1,0, 2,E4,1,0, 2,A4,1,0
	defb 2,G4,1,0, 2,F4,1,0, 2,E4,1,0, 2,D4,1,0
	defb 17,E4,1,0
	defb 6,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push ax
        mov ax,over_notes
        call MelodyWait
    pop ax
ret


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

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

Cycles:
defw 1272 ; C4
defw 1200 ; C#4
defw 1133 ; D4
defw 1069 ; D#4
defw 1009 ; E4
defw 952 ; F4
defw 898 ; F#4
defw 848 ; G4
defw 800 ; G#4
defw 755 ; A4
defw 713 ; A#4
defw 673 ; B4
defw 635 ; C5
defw 599 ; C#5
defw 565 ; D5
defw 533 ; D#5
defw 503 ; E5
defw 475 ; F5
