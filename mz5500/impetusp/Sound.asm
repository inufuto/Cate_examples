ext WaitTimer_

tempo equ 200

Port_Register equ 231h
Port_Out equ 230h

Psg_Tone_A equ 0
Psg_Tone_B equ 2
Psg_Tone_C equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_Volume_A equ 8
Psg_Volume_B equ 9
Psg_Volume_C equ 10

HighNoise equ 0f0h
LowNoise equ 0f1h

MaxVol equ 63
HighNoiseValue equ 11*12/6
LowNoiseValue equ 27*12/6
MixerFlags equ 0c0h

ChannelCount equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
UnitSize equ Channel_Vol+1

dseg
Channels:
    defs UnitSize*ChannelCount
time:
    defw 0
mixerValue: 
    defb 0
shootingTone: 
    defw 0


cseg
WriteRegister:
; al:register, ah:value
    push dx
        mov dx,Port_Register | out dx,al
        mov al,ah
        mov dx,Port_Out | out dx,al
    pop dx
ret


AllOff:
    mov cx,3*256 or Psg_Volume_A
    do
        mov al,cl
        mov dx,Port_Register | out dx,al
        xor al,al
        mov dx,Port_Out | out dx,al
        inc cl
        dec ch
    while nz | wend
ret


InitSound: public InitSound
    call AllOff
    
    mov ax,Psg_Mixer or ((38h or MixerFlags) shl 8)
    mov [mixerValue],ah
    call WriteRegister

    mov bx,Channels
    xor al,al
    mov ch,ChannelCount*UnitSize
    do
        mov [bx],al | inc bx
        dec ch
    while nz | wend
    xor ax,ax
    mov [time],ax
    mov [shootingTone],ax
ret


SoundHandler: public SoundHandler
    push ax | push dx | push bx
        mov bx,[shootingTone]
        or bx,bx
        if nz
            mov al,Psg_Tone_A
            mov ah,bl
            call WriteRegister
            mov al,Psg_Tone_A+1
            mov ah,bh
            call WriteRegister
            add bx,15
            cmp bx,300
            if nb
                mov ax,Psg_Volume_A
                call WriteRegister
                xor bx,bx
            endif
            mov [shootingTone],bx
        endif

        mov ax,[time]
        sub ax,Tempo
        if b
            push ax | push cx | push si
                mov si,Channels
                mov cx,ChannelCount*100h ; ch=count; cl=register
                mov dl,[mixerValue]
                mov dh,1
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
                                mov al,cl
                                add al,Psg_Volume_A
                                xor ah,ah
                                call WriteRegister
                                jmp next
                            endif
                            inc al
                            if z 
                                ; repeat
                                mov bx,[si+Channel_Start]
                                jmp continue
                            endif
                            dec al
                            mov [si+Channel_Len],al
                            inc bx
                            mov al,[bx]
                            inc bx
                            mov [si+Channel_Ptr],bx
                            cmp al,HighNoise
                            if e
                                mov bl,HighNoiseValue
                                WriteNoise:
                                mov al,Psg_Noise
                                mov ah,bl
                                call WriteRegister
                               
                                or dl,dh
                                mov al,dh
                                shl al,1 | shl al,1 | shl al,1
                                not al
                                and dl,al
                                mov ah,dl
                                mov al,Psg_Mixer
                                call WriteRegister
                                mov byte ptr [si+Channel_Vol],MaxVol
                                jmp EndWriteCycle
                            endif
                            cmp al,LowNoise
                            if z
                                mov bl,LowNoiseValue
                                jmp WriteNoise
                            endif                            
                            or al,al
                            if nz
                                dec al
                                shl al,1
                                xor ah,ah
                                add ax,cycles
                                mov bx,ax
                                mov al,cl
                                shl al,1
                                push ax
                                    mov ah,[bx]
                                    call WriteRegister
                                pop ax
                                inc bx
                                inc al
                                mov ah,[bx]
                                call WriteRegister

                                mov byte ptr [si+Channel_Vol],MaxVol
                            
                                mov al,dh
                                shl al,1 | shl al,1 | shl al,1
                                or dl,al
                                mov al,dh
                                not al
                                and dl,al
                                mov ah,dl
                                mov al,Psg_Mixer
                                call WriteRegister
                            else
                                mov byte ptr [si+Channel_Vol],0
                            endif
                            EndWriteCycle:
                        endif
                        mov al,cl
                        add al,Psg_Volume_A
                        mov ah,[si+Channel_Vol]
                        shr ah,1 | shr ah,1
                        call WriteRegister

                        mov al,[si+Channel_Vol]
                        or al,al
                        if nz
                            dec al
                            mov [si+Channel_Vol],al
                        endif
                    endif
                    next:
                    inc cl
                    add si,UnitSize
                    shl dh
                    dec ch
                while nz | wend
            mov [mixerValue],dl
            pop si | pop cx | pop ax
            add ax,600/2
        endif
        mov [time],ax
    pop bx | pop dx | pop ax
ret


Melody:
    cli
        mov [Channels+UnitSize*0+Channel_Ptr],bx
        mov byte ptr [Channels+UnitSize*0+Channel_Len],1
        push ax
            mov ax,Psg_Volume_A
            call WriteRegister
        pop ax
    sti
ret

MelodyWait:
    call Melody
    do
        cmp word ptr [Channels+UnitSize*0+Channel_Ptr],0
    while nz | wend
ret 


; void Sound_Fire();
Sound_Fire_: public Sound_Fire_
    push ax| push bx | push dx
        cli
            cmp word ptr [Channels++Channel_Ptr],0
            if z
                mov word ptr [Channels++Channel_Ptr],0

                mov word ptr [shootingTone],150
                mov ax,Psg_Volume_A or (15 shl 8)
                call WriteRegister
                mov al,[mixerValue]
                and al,0feh
                or al,08h
                mov [mixerValue],al
                mov ah,al
                mov al,Psg_Mixer
                call WriteRegister
            endif
        sti
    pop dx | pop bx | pop ax
ret


; void Sound_Up();
up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push ax | push bx
        mov bx,up_notes
        call Melody
    pop bx | pop ax
ret


; void Sound_SmallBang();
smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    push ax | push bx
        mov bx,smallExplosion_notes
        call Melody
    pop bx | pop ax
ret


; void Sound_LargeBang();
largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    push ax | push bx
        mov bx,largeExplosion_notes
        call Melody
    pop bx | pop ax
ret


; void Sound_Start();
start_notes: 
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push ax | push bx
        mov bx,start_notes
        call MelodyWait
    pop bx | pop ax
ret


; ; void Sound_Clear();
; clear_notes: 
;     defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
;     defb 0
; Sound_Clear_: public Sound_Clear_
;     push ax | push bx
;         mov bx,clear_notes
;         call MelodyWait
;     pop bx | pop ax
; ret


; void Sound_GameOver();
over_notes:
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push ax | push bx
        mov bx,over_notes
        call MelodyWait
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
    defb N4,E2, N8,0, N8,E2, N8,0, N8,E2, N8,0, N8,E2
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,G2, N8,0, N8,G2, N8,0, N8,G2, N8,0, N8,G2
    defb N4,E2, N8,0, N8,E2, N8,0, N8,E2, N8,0, N8,E2

    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,G2, N8,0, N8,G2, N8,0, N8,G2, N8,0, N8,G2
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,D3, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,F2, N8,F2, N8,0, N4P,E2, N4,0

    defb 0ffh

; void StartBGM();
StartBGM_: public StartBGM_
    push ax | push bx
        cli
            mov al,1
            mov bx,BGM_B
            mov [Channels+unitSize*1+Channel_Start],bx
            mov [Channels+unitSize*1+Channel_Ptr],bx
            mov [Channels+unitSize*1+Channel_Len],al
            mov bx,BGM_C
            mov [Channels+unitSize*2+Channel_Start],bx
            mov [Channels+unitSize*2+Channel_Ptr],bx
            mov [Channels+unitSize*2+Channel_Len],al
        sti
    pop bx | pop ax
ret


; void StopBGM();
StopBGM_: public StopBGM_
    push ax | push bx | push cx | push dx
        cli
            mov bx,0
            mov [Channels+unitSize*1+Channel_Ptr],bx
            mov [Channels+unitSize*2+Channel_Ptr],bx

            call AllOff
        sti
    pop dx | pop cx | pop bx | pop ax
ret


E2 equ 1
F2 equ 2
F2S equ 3
G2 equ 4
G2S equ 5
A2 equ 6
A2S equ 7
B2 equ 8
C3 equ 9
C3S equ 10
D3 equ 11
D3S equ 12
E3 equ 13
F3 equ 14
F3S equ 15
G3 equ 16
G3S equ 17
A3 equ 18
A3S equ 19
B3 equ 20
C4 equ 21
C4S equ 22
D4 equ 23
D4S equ 24
E4 equ 25
F4 equ 26
F4S equ 27
G4 equ 28
G4S equ 29
A4 equ 30
A4S equ 31
B4 equ 32
C5 equ 33
C5S equ 34
D5 equ 35
D5S equ 36
E5 equ 37
F5 equ 38
F5S equ 39
G5 equ 40

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2
N16 equ N8/2

cycles:
defw 1516 ; E2
defw 1431 ; F2
defw 1351 ; F2S
defw 1275 ; G2
defw 1203 ; G2S
defw 1136 ; A2
defw 1072 ; A2S
defw 1012 ; B2
defw 955 ; C3
defw 901 ; C3S
defw 851 ; D3
defw 803 ; D3S
defw 758 ; E3
defw 715 ; F3
defw 675 ; F3S
defw 637 ; G3
defw 601 ; G3S
defw 568 ; A3
defw 536 ; A3S
defw 506 ; B3
defw 477 ; C4
defw 450 ; C4S
defw 425 ; D4
defw 401 ; D4S
defw 379 ; E4
defw 357 ; F4
defw 337 ; F4S
defw 318 ; G4
defw 300 ; G4S
defw 284 ; A4
defw 268 ; A4S
defw 253 ; B4
defw 238 ; C5
defw 225 ; C5S
defw 212 ; D5
defw 200 ; D5S
defw 189 ; E5
defw 178 ; F5
defw 168 ; F5S
defw 159 ; G5
