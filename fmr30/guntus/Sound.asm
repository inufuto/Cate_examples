DcsgPort equ 040h

Dcsg_ToneA equ 00h
Dcsg_VolumeA equ 10h
Dcsg_ToneB equ 20h
Dcsg_VolumeB equ 30h
Dcsg_ToneC equ 40h
Dcsg_VolumeC equ 50h
Dcsg_NoiseControl equ 60h
Dcsg_NoiseVolume equ 70h

HighNoise equ 0f0h
LowNoise equ 0f1h

MinVolume equ 63
HighNoiseValue equ 0e4h
LowNoiseValue equ 0e5h

Tempo equ 180

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*count
time:
    defw 0
noiseVolume: 
    defb 0
shootingTone:  public shootingTone
    defw 0


cseg
InitSound: public InitSound
    xor ax,ax
    mov bx,Channels
    mov cl,count*unitSize
    do
        mov [bx],al | inc bx
        dec cl
    while nz | wend
    mov [time],ax
    mov [shootingTone],ax

    mov al,MinVolume
    mov byte ptr[noiseVolume],al
    or al,Dcsg_NoiseVolume or 80h
    call WriteByte

    call StopBGM_
ret

WriteByte:
    push dx
        mov dx,DcsgPort
        out dx,al
    pop dx
ret


SoundHandler: public SoundHandler
    mov ax,[shootingTone]
    or ax,ax
    if nz
        push ax
            and al,0fh
            or al,80h or Dcsg_ToneA
            call WriteByte
        pop ax
        push ax
            add ax,ax
            add ax,ax
            add ax,ax
            add ax,ax
            mov al,ah
            and al,3fh
            call WriteByte
        pop ax
        add ax,15
        cmp ax,260
        if nc
            mov al,Dcsg_VolumeA or 8fh
            call WriteByte
            xor ax,ax
        endif
        mov [shootingTone],ax
    endif
    mov ax,[time]
    sub ax,Tempo
    if c
        push ax | push bx | push dx | push si
            mov si,Channels
            mov dx,(count * 100h) or Dcsg_ToneA   ; dh = count; dl = register
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
                            mov word ptr[si+Channel_Ptr],0
                            mov al,dl
                            or al,9fh
                            call WriteByte
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
                        mov al,[bx] | inc bx
                        mov [si+Channel_Ptr],bx
                        cmp al,HighNoise
                        if z
                            mov al,HighNoiseValue 
                            WriteNoise:
                            call WriteByte
                            mov byte ptr[noiseVolume],0
                            jmp EndWriteCycle
                        endif
                        cmp al,LowNoise
                        if z
                            mov al,LowNoiseValue
                            jmp WriteNoise
                        endif
                        or al,al
                        if nz
                            dec al
                            add al,al
                            xor ah,ah
                            add ax,cycles
                            push bx
                                mov bx,ax
                                mov al,dl
                                or al,80h
                                or al,[bx]
                                call WriteByte
                                inc bx
                                mov al,[bx]
                                call WriteByte
                                cmp dl,Dcsg_ToneC
                                if z
                                    mov al,4
                                else
                                    xor al,al
                                endif
                            pop bx
                            mov [si+Channel_Vol],al
                        else
                            mov byte ptr [si+Channel_Vol],MinVolume
                        endif
                        EndWriteCycle:
                    endif
                    mov al,[si+Channel_Vol]
                    shr al,1 | shr al,1
                    or al,dl
                    or al,90h
                    call WriteByte
                    mov al,[si+Channel_Vol]
                    cmp al,MinVolume
                    if nz
                        inc al
                        mov [si+Channel_Vol],al
                    endif
                endif
                next:
                add dl,20h
                add si,unitSize
                
                dec dh
            while nz | wend
            mov al,[noiseVolume]
            mov ah,al
            shr al,1 | shr al,1
            or al,Dcsg_NoiseVolume or 80h
            call WriteByte
            cmp ah,MinVolume
            if nz
                inc ah
                mov [noiseVolume],ah
            endif
        pop si | pop dx | pop bx | pop ax
        add ax,600/2
    endif
    mov [time],ax
ret


Melody:
    cli
        mov [Channels+unitSize*0+Channel_Ptr],bx
        mov byte ptr [Channels+unitSize*0+Channel_Len],1
    sti
ret

MelodyWait:
    call Melody
    do
        cmp word ptr [Channels+unitSize*0+Channel_Ptr],0
    while nz | wend
ret 


cseg
Sound_Fire_: public Sound_Fire_
    cmp word ptr [Channels+Channel_Ptr],0
    if z
        push ax
            cli
                mov word ptr[Channels+Channel_Ptr],0
                mov word ptr[shootingTone],110
                mov al,Dcsg_VolumeA or 80h
                call WriteByte
            sti
        pop ax
    endif
ret


smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    push ax | push bx
        mov bx,smallExplosion_notes
        call Melody
    pop bx | pop ax
ret


largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    push ax | push bx
        mov bx,largeExplosion_notes
        call Melody
    pop bx | pop ax
ret


up_notes:
    defb 1,C4, 1,C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push bx
        mov bx,up_notes
        call Melody
    pop bx
ret


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
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3

    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N4,F3, N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,F3
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3

    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N8,D3, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N8,F3, N8,F3, N8,0, N4P,E3, N4,0

    defb 0ffh

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

StopBGM_: public StopBGM_

    push ax | push cx
        cli
            xor ax,ax
            mov [Channels+unitSize*1+Channel_Ptr],ax
            mov [Channels+unitSize*2+Channel_Ptr],ax
            mov cl,3
            mov al,Dcsg_VolumeB or 8fh
            do
                call WriteByte
                add al,20h
                dec cl
            while nz | wend
        sti
    pop cx | pop ax
ret


B2 equ 1
C3 equ 2
C3S equ 3
D3 equ 4
D3S equ 5
E3 equ 6
F3 equ 7
F3S equ 8
G3 equ 9
G3S equ 10
A3 equ 11
A3S equ 12
B3 equ 13
C4 equ 14
C4S equ 15
D4 equ 16
D4S equ 17
E4 equ 18
F4 equ 19
F4S equ 20
G4 equ 21
G4S equ 22
A4 equ 23
A4S equ 24
B4 equ 25
C5 equ 26
C5S equ 27
D5 equ 28
D5S equ 29
E5 equ 30
F5 equ 31
F5S equ 32
G5 equ 33

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defb 4,63 ; B2
defb 11,59 ; C3
defb 5,56 ; C3S
defb 3,53 ; D3
defb 3,50 ; D3S
defb 6,47 ; E3
defb 11,44 ; F3
defb 3,42 ; F3S
defb 13,39 ; G3
defb 9,37 ; G3S
defb 8,35 ; A3
defb 8,33 ; A3S
defb 10,31 ; B3
defb 13,29 ; C4
defb 2,28 ; C4S
defb 9,26 ; D4
defb 1,25 ; D4S
defb 11,23 ; E4
defb 5,22 ; F4
defb 1,21 ; F4S
defb 14,19 ; G4
defb 12,18 ; G4S
defb 12,17 ; A4
defb 12,16 ; A4S
defb 13,15 ; B4
defb 14,14 ; C5
defb 1,14 ; C5S
defb 4,13 ; D5
defb 8,12 ; D5S
defb 13,11 ; E5
defb 2,11 ; F5
defb 8,10 ; F5S
defb 15,9 ; G5
