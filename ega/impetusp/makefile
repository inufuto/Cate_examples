name=impetusp

comname=$(name)

all: $(name)_img.zip $(comname).com

cseg_fd=0500
dseg_fd=6900
cseg_com=0100
dseg_com=6500

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Movable.h VVram.h Math.h \
	Main.h Chars.h Bang.h Movable.h Main.h Fighter.h \
	Movable.h Sound.h 
Enemy.asm: Enemy.c Enemy.h Movable.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Movable.h Sprite.h Movable.h Chars.h \
	VVram.h Math.h Fighter.h Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h VVram.h Sprite.h Movable.h \
	Chars.h Main.h Status.h ScanKeys.h FighterBullet.h Movable.h \
	Bang.h Movable.h Barrier.h Sound.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Movable.h Sprite.h Movable.h Chars.h \
	Fighter.h Movable.h Sound.h VVram.h SkyEnemy.h Enemy.h \
	Movable.h GroundEnemy.h Stage.h Enemy.h Movable.h Barrier.h \
	Fort.h 
Fort.asm: Fort.c Fort.h VVram.h Main.h Chars.h Stage.h \
	Movable.h Bang.h Movable.h EnemyBullet.h Movable.h Math.h \
	Sound.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Stage.h Enemy.h Movable.h Sprite.h \
	Movable.h VVram.h Chars.h Stage.h Math.h Main.h \
	Bang.h Movable.h Sound.h EnemyBullet.h Movable.h 
Item.asm: Item.c Item.h Movable.h VVram.h Sprite.h Movable.h \
	Chars.h Fighter.h Movable.h Status.h Main.h Sound.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Vram.h Stage.h \
	Sound.h Sprite.h Movable.h Fighter.h Movable.h SkyEnemy.h \
	Enemy.h Movable.h GroundEnemy.h Stage.h Enemy.h Movable.h \
	FighterBullet.h Movable.h EnemyBullet.h Movable.h Bang.h Movable.h \
	Barrier.h Fort.h Item.h Movable.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Enemy.h Movable.h Sprite.h Movable.h \
	Chars.h Main.h Math.h Stage.h VVram.h Fighter.h \
	Movable.h Bang.h Movable.h Sound.h EnemyBullet.h Movable.h \
	Barrier.h Item.h Movable.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Main.h VVram.h Math.h CopyMemory.h \
	Movable.h Status.h Sprite.h Movable.h Fighter.h Movable.h \
	SkyEnemy.h Enemy.h Movable.h GroundEnemy.h Stage.h Enemy.h \
	Movable.h FighterBullet.h Movable.h EnemyBullet.h Movable.h Barrier.h \
	Bang.h Movable.h Fort.h Item.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h Sprite.h Movable.h Stage.h \
	Fort.h 
VVram.asm: VVram.c VVram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
FortA.obj: FortA.asm Vram.inc VVram.inc Chars.inc 
Loader2D.obj: Loader2D.asm BinSize.inc 
Loader2DD.obj: Loader2DD.asm BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
SoundBeep.obj: SoundBeep.asm 
SoundOpl.obj: SoundOpl.asm 
SpritePattern.obj: SpritePattern.asm 
StageA.obj: StageA.asm Vram.inc VVram.inc Chars.inc 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj Enemy.obj EnemyBullet.obj Fighter.obj FighterBullet.obj \
	Fort.obj GroundEnemy.obj Item.obj Main.obj SkyEnemy.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	CopyMemory.obj FortA.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	SoundBeep.obj SoundOpl.obj SpritePattern.obj StageA.obj VramA.obj \
	..\..\cate\cate86.lib

$(comname).com.bin: $(objects) makefile
	LinkLE.exe $(comname).com.bin $(cseg_com) $(dseg_com) $(objects)
	copy $(comname).com.symbols.txt $(comname)_com.symbols.txt /y

$(comname).com: $(comname).com.bin $(comname)_com.symbols.txt MakeCom.csx makefile
	dotnet script MakeCom.csx $(comname)

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg_fd) $(dseg_fd) $(objects)
	copy $(name).symbols.txt $(name)_fd.symbols.txt /y

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name)

Loader2D.bin: Loader2D.obj BinSize.inc makefile 
	LinkLE.exe Loader2D.bin 0000 0000 Loader2D.obj
	copy Loader2D.bin debug.bin /y

Loader2DD.bin: Loader2DD.obj BinSize.inc makefile 
	LinkLE.exe Loader2DD.bin 0000 0000 Loader2DD.obj
	copy Loader2DD.bin debug.bin /y

$(name)_2d.d88 $(name)_2d.img: $(name).bin Loader2D.bin Disk2D.csx
	dotnet script Disk2D.csx $(name)

$(name)_2dd.d88 $(name)_2dd.img: $(name).bin Loader2DD.bin Disk2DD.csx
	dotnet script Disk2DD.csx $(name)

$(name)_img.zip: $(name)_2d.d88 $(name)_2d.img $(name)_2dd.d88 $(name)_2dd.img
	7z a $(name)_img.zip $(name)_2d.d88 $(name)_2d.img $(name)_2dd.d88 $(name)_2dd.img
