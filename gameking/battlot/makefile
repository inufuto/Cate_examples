.SUFFIXES: .c .asm .obj .wav .adp

name=battlot

all: $(name).bin

cseg=8000-8201,4000
dseg=1000
zseg=00cc

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 -v2 $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Stage.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Stage.h Direction.h Stage.h \
	Robo.h Bullet.h Fort.h Chars.h 
Direction.asm: Direction.c Direction.h 
EnemyRobo.asm: EnemyRobo.c Robo.h Bullet.h Sprite.h Main.h Fort.h \
	Stage.h Direction.h Bullet.h Bang.h Sound.h Chars.h 
Fort.asm: Fort.c Fort.h Vram.h Chars.h Stage.h Robo.h \
	Bullet.h Bang.h Sprite.h Sound.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Status.h Sprite.h \
	Vram.h Robo.h Bullet.h Bullet.h Bang.h Fort.h \
	Sound.h 
MyRobo.asm: MyRobo.c Robo.h Bullet.h Sprite.h Direction.h Stage.h \
	ScanKeys.h Fort.h Bang.h Main.h Sound.h Chars.h \
	Vram.h 
Robo.asm: Robo.c Robo.h Bullet.h Direction.h Sprite.h Stage.h \
	Fort.h Bullet.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Vram.h \
	Chars.h Fort.h Robo.h Bullet.h Bullet.h Bang.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Print.h \
	Fort.h 
Vram.asm: Vram.c Vram.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm GameKing.inc 
Sound.obj: Sound.asm GameKing.inc ZeroPage.inc 
Sprite.obj: Sprite.asm GameKing.inc ZeroPage.inc Vram.inc Sprite.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm GameKing.inc 
VramA.obj: VramA.asm GameKing.inc ZeroPage.inc Vram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = RomHead.obj Startup.obj \
	Bang.obj Bullet.obj Direction.obj EnemyRobo.obj Fort.obj Main.obj \
	MyRobo.obj Robo.obj Stage.obj Stages.obj Status.obj Vram.obj \
	Chars.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	VramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

.wav.adp:
	dotnet script EncodeWav.csx $*.wav $*.adp --no-normalize -r 4

fire.adp: fire.wav
beep.adp: beep.wav
highBang.adp: highBang.wav
lowBang.adp: lowBang.wav
start.adp: start.wav
clear.adp: clear.wav
over.adp: over.wav
bgm.adp: bgm.wav

adps = \
	fire.adp \
	beep.adp \
	highBang.adp \
	lowBang.adp \
	start.adp \
	clear.adp \
	over.adp \
	bgm.adp

_raw.bin: $(objects) makefile
	LinkLE.exe _raw.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _raw.symbols.txt $(name).symbols.txt /y

$(name).bin: _raw.bin MakeRom.csx $(adps)
	dotnet script MakeRom.csx _raw2
	dotnet script MakeSoundRom.csx _raw2.bin $(name).bin $(adps) -r 4
