TimerPort equ 40h
BPort equ 61h
OnValue equ 03h

Tempo equ 180

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
Time:
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
    push ax | push bx | push cx
        xor ax,ax
        mov [Time],ax
        
        call OffAll
    pop cx | pop bx | pop ax
ret


ToneOn:
;   ax : cycle
    out TimerPort+2,al
    mov al,ah
    out TimerPort+2,al
    in al,BPort
    or al,OnValue
    out BPort,al
ret

ToneOff:
    in al,BPort
    and al,not OnValue
    out BPort,al
ret


SoundHandler: public SoundHandler
    push ax
        mov ax,[Time]
        sub ax,Tempo
        if c
            push ax | push bx | push cx | push si
                mov si,Channels
                mov cl,Count
                do
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr[si+Channel_Len]
                        if z
                            continue:
                            mov al,[bx]
                            or al,al
                            if z
                                ; end
                                mov word ptr [si+Channel_Ptr],0
                                offch:
                                mov word ptr [si+Channel_Tone],0
                                cmp cl,2
                                if z
                                    ; Channel0 end
                                    mov ax,[Channel1+Channel_Tone]
                                    or ax,ax
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
                            mov al,[bx]
                            inc bx
                            mov [si+Channel_Ptr],bx
                            or al,al
                            jz offch
                            mov bl,al
                            dec bl
                            xor bh,bh
                            add bx,bx
                            add bx,cycles
                            mov ax,[bx]
                            mov [si+Channel_Tone],ax
                            cmp cl,1
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
                    dec cl
                while nz | wend
            pop si | pop cx | pop bx | pop ax
            add ax,600/2
        endif
        mov [Time],ax
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
Sound_Loose_: public Sound_Loose_
    push bx
        mov bx,loose_notes
        call MelodyWait
    pop bx
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push bx
        mov bx,hit_notes
        call Melody
    pop bx
ret


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole_: public Sound_Stole_
    push bx
        mov bx,stole_notes
        call Melody
    pop bx
ret


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push bx
        mov bx,fire_notes
        call Melody
    pop bx
ret


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
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
Sound_Start_: public Sound_Start_
    mov bx,start_notes
jmp MelodyWait


clear_notes:
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    mov bx,clear_notes
jmp MelodyWait


over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
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

cycles:
defw 6084 ; G3
defw 5742 ; G#3
defw 5420 ; A3
defw 5116 ; A#3
defw 4829 ; B3
defw 4558 ; C4
defw 4302 ; C#4
defw 4060 ; D4
defw 3832 ; D#4
defw 3617 ; E4
defw 3414 ; F4
defw 3223 ; F#4
defw 3042 ; G4
defw 2871 ; G#4
defw 2710 ; A4
defw 2558 ; A#4
defw 2414 ; B4
defw 2279 ; C5
defw 2151 ; C#5
defw 2030 ; D5
defw 1916 ; D#5
defw 1808 ; E5
defw 1707 ; F5
defw 1611 ; F#5
defw 1521 ; G5
