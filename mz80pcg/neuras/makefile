name=neuras

all: $(name).wav

cseg=1200
dseg=3200 

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h Vram.h Sprite.h Status.h Sound.h \
	VVram.h 
Main.asm: Main.c Stage.h ScanKeys.h Solver.h Card.h Stage.h \
	Monster.h Stage.h Status.h Sprite.h Vram.h Sound.h \
	VVram.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h \
	Sound.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h VVram.h Monster.h Stage.h 
Sprite.asm: Sprite.c Sprite.h Vram.h Stage.h Chars.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h VVram.h Vram.h Solver.h \
	Card.h Stage.h Monster.h Stage.h Sprite.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Card.h Stage.h Chars.h Print.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Vram.h Sprite.h Chars.h Stage.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Card.obj Main.obj Monster.obj Solver.obj Sprite.obj Stage.obj \
	Stages.obj Status.obj Vram.obj VVram.obj Chars.obj CopyMemory.obj \
	Print.obj ScanKeys.obj Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).mzt: $(objects) makefile
	LinkLE.exe $(name).mzt $(cseg) $(dseg) $(objects)

$(name).wav: $(name).mzt
	mzt2wav $(name).mzt $(name).wav
	mztwav2pcm $(name).wav
