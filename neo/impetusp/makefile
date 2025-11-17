name=impetusp

all: $(name).neo

cseg=0800
dseg=6c00
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 -v2 $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Vram.h Sprite.h \
	Movable.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Movable.h Vram.h Math.h \
	Main.h Chars.h Bang.h Movable.h Main.h Fighter.h \
	Movable.h Sound.h 
Enemy.asm: Enemy.c Enemy.h Movable.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Movable.h Sprite.h Movable.h Chars.h \
	VVram.h Vram.h Math.h Fighter.h Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h VVram.h Vram.h Sprite.h \
	Movable.h Chars.h Main.h Status.h ScanKeys.h FighterBullet.h \
	Movable.h Bang.h Movable.h Barrier.h Sound.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Movable.h Sprite.h Movable.h Chars.h \
	Fighter.h Movable.h Sound.h Vram.h SkyEnemy.h Enemy.h \
	Movable.h GroundEnemy.h Stage.h Enemy.h Movable.h Barrier.h \
	Fort.h 
Fort.asm: Fort.c Fort.h Vram.h Main.h Chars.h Stage.h \
	Movable.h Bang.h Movable.h EnemyBullet.h Movable.h Math.h \
	Sound.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Stage.h Enemy.h Movable.h Sprite.h \
	Movable.h VVram.h Vram.h Chars.h Stage.h Math.h \
	Main.h Bang.h Movable.h Sound.h EnemyBullet.h Movable.h 
Item.asm: Item.c Item.h Movable.h Vram.h Sprite.h Movable.h \
	Chars.h Fighter.h Movable.h Status.h Main.h Sound.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Vram.h Stage.h \
	Sound.h Sprite.h Movable.h Fighter.h Movable.h SkyEnemy.h \
	Enemy.h Movable.h GroundEnemy.h Stage.h Enemy.h Movable.h \
	FighterBullet.h Movable.h EnemyBullet.h Movable.h Bang.h Movable.h \
	Barrier.h Fort.h Item.h Movable.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Enemy.h Movable.h Sprite.h Movable.h \
	Chars.h Main.h Math.h Stage.h VVram.h Vram.h \
	Fighter.h Movable.h Bang.h Movable.h Sound.h EnemyBullet.h \
	Movable.h Barrier.h Item.h Movable.h 
Stage.asm: Stage.c Stage.h Main.h VVram.h Vram.h Math.h \
	CopyMemory.h Movable.h Status.h Sprite.h Movable.h Fighter.h \
	Movable.h SkyEnemy.h Enemy.h Movable.h GroundEnemy.h Stage.h \
	Enemy.h Movable.h FighterBullet.h Movable.h EnemyBullet.h Movable.h \
	Barrier.h Bang.h Movable.h Fort.h Item.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h Fort.h 
Vram.asm: Vram.c Vram.h VVram.h Vram.h Stage.h Fort.h 
VVram.asm: VVram.c VVram.h Vram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
FortA.obj: FortA.asm neo6502.inc Zeropage.inc Vram.inc VVram.inc Chars.inc 
FortPattern.obj: FortPattern.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm neo6502.inc 
Sound.obj: Sound.asm neo6502.inc ZeroPage.inc 
Sprite.obj: Sprite.asm neo6502.inc ZeroPage.inc Vram.inc 
StageA.obj: StageA.asm Zeropage.inc Vram.inc VVram.inc Chars.inc 
Startup.obj: Startup.asm neo6502.inc 
VramA.obj: VramA.asm neo6502.inc ZeroPage.inc Vram.inc VVram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Startup.obj \
	Bang.obj Barrier.obj Enemy.obj EnemyBullet.obj Fighter.obj FighterBullet.obj \
	Fort.obj GroundEnemy.obj Item.obj Main.obj SkyEnemy.obj Stage.obj \
	Stages.obj Status.obj Vram.obj VVram.obj Chars.obj CopyMemory.obj \
	FortA.obj FortPattern.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	Sprite.obj StageA.obj VramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

$(name).neo: $(name).bin $(name).gfx MakeNeo.csx
	dotnet script MakeNeo.csx $(name) $(cseg)
