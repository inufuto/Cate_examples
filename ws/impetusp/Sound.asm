include "ws.inc"

ext WaitTimer_

Tempo equ 180
MaxVol equ 1fh

ChannelCount equ 4
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*ChannelCount
time:
    defw 0


cseg
InitSound: public InitSound
    push ax | push bx | push cx | push dx
        xor al,al | out REG_SND_CTRL,al
        in al,REG_SND_OUTPUT
        test al,80h
        if nz
            mov al,08h
        else
            mov al,01h
        endif
        out REG_SND_OUTPUT,al

        mov dx,REG_SND_CH1_PITCH
        mov ax,1830
        mov bx,Channels
        mov cx,ChannelCount*unitSize
        do
            mov [bx],ch | inc bx
            out dx,ax
            dec cl
        while nz | wend
        xor ax,ax
        mov [time],ax
    pop dx | pop cx | pop bx | pop ax
ret


cseg
NoteOff:
    mov ah,ch | not ah
    in al,REG_SND_CTRL
    and al,ah
    out REG_SND_CTRL,al
ret
NoteOn:
    in al,REG_SND_CTRL
    or al,ch
    out REG_SND_CTRL,al
ret
SoundHandler: public SoundHandler
    push ax
        mov ax,[time]
        sub ax,Tempo
        if b
            push ax | push bx | push cx | push dx | push si
                xor dh,dh
                mov si,Channels
                mov cx,0100h
                do
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr [si+Channel_Len]
                        if z
                            continue:
                            mov al,[cs:bx]
                            or al,al
                            if z
                                ; end
                                mov word ptr [si+Channel_Ptr],0
                                call NoteOff
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
                            mov al,[cs:bx]
                            inc bx
                            mov [si+Channel_Ptr],bx
                            or al,al
                            if nz
                                dec al
                                shl al,1
                                xor ah,ah
                                add ax,cycles
                                mov bx,ax

                                mov dl,cl
                                shl dl,1
                                add dl,REG_SND_CH1_PITCH

                                mov ax,[cs:bx]
                                out dx,ax
                                mov byte ptr [si+Channel_Vol],MaxVol
                                call NoteOn
                            else
                                mov byte ptr [si+Channel_Vol],0
                                call NoteOff
                            endif
                        endif
                        mov dl,cl
                        add dl,REG_SND_CH1_VOL
                        mov al,[si+Channel_Vol]
                        mov ah,al
                        shr al,1 | shr al,1
                        shl ah,1 | shl ah,1
                        and ah,0f0h
                        or al,ah
                        out dx,al

                        mov al,[si+Channel_Vol]
                        or al,al
                        if nz
                            dec al
                            mov [si+Channel_Vol],al
                        endif
                    endif
                    next:
                    add si,unitSize
                    inc cl
                    shl ch,1
                    cmp cl,ChannelCount
                while nz | wend
            pop si | pop dx | pop cx | pop bx | pop ax
            add ax,600/2
        endif
        mov [time],ax
    pop ax
ret


Melody0:
    cli
        mov [Channels+unitSize*0+Channel_Ptr],bx
        mov byte ptr [Channels+unitSize*0+Channel_Len],1
        push ax
            xor al,al | out REG_SND_CH1_VOL,al
        pop ax
    sti
ret

MelodyWait0:
    call Melody0
    do
        cmp word ptr [Channels+unitSize*0+Channel_Ptr],0
    while nz | wend
ret 


Melody2:
    cli
        mov [Channels+unitSize*2+Channel_Ptr],bx
        mov byte ptr [Channels+unitSize*2+Channel_Len],1
        push ax
            xor al,al | out REG_SND_CH3_VOL,al
        pop ax
    sti
ret

MelodyWait2:
    call Melody2
    do
        cmp word ptr [Channels+unitSize*2+Channel_Ptr],0
    while nz | wend
ret 


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push ax | push bx
        mov bx,fire_notes
        call Melody2
    pop bx | pop ax
ret


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push ax | push bx
        mov bx,hit_notes
        call Melody2
    pop bx | pop ax
ret


; void Sound_Loose();
cseg
loose_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Loose_: public Sound_Loose_
    push ax | push bx
        mov bx,loose_notes
        call Melody2
    pop bx | pop ax
ret


; void Sound_Up();
up_notes:
    defb 1,C4, 1,C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push ax | push bx
        mov bx,up_notes
        call Melody2
    pop bx | pop ax
ret


; void Sound_Start();
cseg
start_notes: 
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push ax | push bx
        mov bx,start_notes
        call MelodyWait0
    pop bx | pop ax
ret


; ; void Sound_Clear();
; cseg
; clear_notes: 
;     defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
;     defb 0
; Sound_Clear_: public Sound_Clear_
;     push ax | push bx
;         mov bx,clear_notes
;         call MelodyWait0
;     pop bx | pop ax
; ret


; void Sound_GameOver();
cseg
over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push ax | push bx
        mov bx,over_notes
        call MelodyWait0
    pop bx | pop ax
ret


BGM_B: 
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,B4, N4P,G4, N2P,G4, N2,0
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,G5, N4P,D5, N2P,D5, N2,0
    defb N4P,F5, N4P,E5, N2,F5, N4,F5, N4,E5, N4,F5
    defb N4P,E5, N4P,C5, N2P,C5, N2,0
    
    defb N8,A4, N8,A4, N8,B4, N4,C5, N4,C5, N8,C5
    defb N8,B4, N8,B4, N8,C5, N4,D5, N4,D5, N8,D5
    defb N8,C5, N8,C5, N8,D5, N4,E5, N4,E5, N8,E5
    defb N8,F5, N4,F5, N4P,E5, N4,0

    defb 0ffh

BGM_C:
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,F3, N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,F3
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3

    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,D3, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,F3, N8,F3, N8,0, N4P,E3, N4,0

    defb 0ffh


; void StartBGM();
cseg
StartBGM_: public StartBGM_
    push ax | push bx
        cli
            mov al,1
            mov bx,BGM_B
            mov [Channels+unitSize*0+Channel_Start],bx
            mov [Channels+unitSize*0+Channel_Ptr],bx
            mov [Channels+unitSize*0+Channel_Len],al
            mov bx,BGM_C
            mov [Channels+unitSize*1+Channel_Start],bx
            mov [Channels+unitSize*1+Channel_Ptr],bx
            mov [Channels+unitSize*1+Channel_Len],al
        sti
    pop bx | pop ax
ret


; void StopBGM();
cseg
StopBGM_: public StopBGM_
    push ax | push bx | push cx
        cli
            mov bx,0
            mov [Channels+unitSize*0+Channel_Ptr],bx
            mov [Channels+unitSize*1+Channel_Ptr],bx
            mov [Channels+unitSize*2+Channel_Ptr],bx
        sti
        in al,REG_SND_CTRL
        and al,0f0h
        out REG_SND_CTRL,al
    pop cx | pop bx | pop ax
ret



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
N16 equ N8/2

cycles:
defw 1175 ; A2
defw 1224 ; A#2
defw 1270 ; B2
defw 1314 ; C3
defw 1355 ; C#3
defw 1394 ; D3
defw 1431 ; D#3
defw 1466 ; E3
defw 1498 ; F3
defw 1529 ; F#3
defw 1558 ; G3
defw 1586 ; G#3
defw 1612 ; A3
defw 1636 ; A#3
defw 1659 ; B3
defw 1681 ; C4
defw 1702 ; C#4
defw 1721 ; D4
defw 1739 ; D#4
defw 1757 ; E4
defw 1773 ; F4
defw 1789 ; F#4
defw 1803 ; G4
defw 1817 ; G#4
defw 1830 ; A4
defw 1842 ; A#4
defw 1854 ; B4
defw 1865 ; C5
defw 1875 ; C#5
defw 1885 ; D5
defw 1894 ; D#5
defw 1902 ; E5
defw 1911 ; F5
defw 1918 ; F#5
defw 1926 ; G5
