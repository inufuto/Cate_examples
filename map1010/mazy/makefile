name=mazy

all: $(name).wav loader.txt

cseg=8800
dseg=a800
loader=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Knife.asm: Knife.c Knife.h Map.h Math.h VVram.h Chars.h \
	Man.h Status.h Sound.h Monster.h Main.h 
Main.asm: Main.c Main.h ScanKeys.h Man.h Knife.h Monster.h \
	Status.h Vram.h Sound.h Init.h VVram.h Map.h 
Man.asm: Man.c Man.h Map.h ScanKeys.h Chars.h Vram.h \
	VVram.h Main.h Knife.h Sound.h 
Map.asm: Map.c Map.h CopyMemory.h Main.h Stages.h Man.h \
	Knife.h Monster.h VVram.h Chars.h 
Monster.asm: Monster.c Monster.h Map.h Chars.h VVram.h Man.h \
	Main.h Sound.h 
Status.asm: Status.c Status.h Vram.h Main.h Chars.h Print.h \
	Knife.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Map.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Init.obj: Init.asm 
loader.obj: loader.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
stages.obj: stages.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = \
	Main.obj \
	Knife.obj Man.obj Map.obj Monster.obj Print.obj \
	Status.obj Vram.obj VVram.obj Chars.obj Init.obj \
	ScanKeys.obj Sound.obj Stages.obj VramA.obj VVramA.obj \
	Math.obj CopyMemory.obj \
	..\..\cate\cate80.lib

$(name).cmt: $(objects) makefile
	LinkLE.exe $(name).cmt $(cseg) $(dseg) $(objects)

$(name).wav: $(name).cmt CmtWav.csx 
	dotnet script CmtWav.csx $(name)

loader.obj: loader.asm

loader.bin: loader.obj makefile
	linkLE loader.bin $(loader) $(dseg) loader.obj

loader.txt: loader.bin loader.csx
	dotnet script loader.csx $(loader)
