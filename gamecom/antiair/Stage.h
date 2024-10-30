constexpr byte RowCount = 3;
constexpr byte ColumnCount = 4;
constexpr byte SourceByteCount = (ColumnCount + 3) / 4 * RowCount;

struct Stage {
    byte[SourceByteCount] bytes;
};

extern ptr<Stage> pStage;

extern void InitPlaying();
extern void InitStage();
