name=mazy

filename=$(name)

all: $(filename)

cseg=8000
dseg=b400

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Knife.asm: Knife.c Knife.h Map.h Math.h VVram.h Chars.h \
	Man.h Status.h Sound.h Monster.h Main.h 
Main.asm: Main.c Main.h ScanKeys.h Man.h Knife.h Monster.h \
	Status.h Vram.h Sound.h VVram.h Map.h 
Man.asm: Man.c Man.h Map.h ScanKeys.h Chars.h Vram.h \
	VVram.h Main.h Knife.h Sound.h 
Map.asm: Map.c Map.h CopyMemory.h Main.h Stages.h Man.h \
	Knife.h Monster.h VVram.h Chars.h 
Monster.asm: Monster.c Monster.h Map.h Chars.h VVram.h Man.h \
	Main.h Sound.h 
Status.asm: Status.c Status.h Vram.h Main.h Chars.h Print.h \
	Knife.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Vram.h Chars.h Map.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm 
SoundOpll.obj: SoundOpll.asm BIOS.inc 
SoundPsg.obj: SoundPsg.asm BIOS.inc 
stages.obj: stages.asm 
Startup.obj: Startup.asm BIOS.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Map.obj Monster.obj Status.obj \
	Vram.obj VVram.obj Chars.obj CopyMemory.obj Math.obj Print.obj \
	ScanKeys.obj Sound.obj SoundOpll.obj SoundPsg.obj stages.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate80.lib

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex $(cseg) $(dseg) $(objects)

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)
