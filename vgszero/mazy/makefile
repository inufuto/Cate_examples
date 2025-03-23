name=mazy

all: game.pkg

cseg=0000
dseg=C000

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
Status.asm: Status.c Status.h Vram.h VVram.h Main.h Chars.h \
	Print.h Knife.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Map.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
stages.obj: stages.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Map.obj Monster.obj Status.obj \
	Vram.obj VVram.obj  CopyMemory.obj Math.obj Print.obj \
	ScanKeys.obj Sound.obj stages.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

patterns = pattern.bin
 
$(name).rom: $(name).bin $(patterns)
	makerom $(name).rom $(name).bin $(patterns)

bgm.bgm: bgm.mml
	vgsmml bgm.mml bgm.bgm

start.bgm: start.mml
	vgsmml start.mml start.bgm

clear.bgm: clear.mml
	vgsmml clear.mml clear.bgm

over.bgm: over.mml
	vgsmml over.mml over.bgm

loose.bgm: loose.mml
	vgsmml loose.mml loose.bgm

beep.bgm: beep.mml
	vgsmml beep.mml beep.bgm

bgm_r.bgm: bgm.bgm Repeat.csx
	dotnet script Repeat.csx

bgms = bgm_r.bgm start.bgm clear.bgm over.bgm beep.bgm loose.bgm

bgm: $(bgms) makefile
	makebgm bgm $(bgms)

ses = get.wav hit.wav

se: $(ses) makefile
	makese se $(ses)

game.pkg: $(name).rom bgm se
	makepkg -o game.pkg -r $(name).rom -b bgm -s se
