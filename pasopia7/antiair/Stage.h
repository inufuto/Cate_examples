constexpr byte RowCount = 6;
constexpr byte ColumnCount = 6;
constexpr byte SourceByteCount = (ColumnCount + 3) / 4 * RowCount;

struct Stage {
    byte[SourceByteCount] bytes;
};

extern ptr<Stage> pStage;

extern void InitPlaying();
extern void InitStage();
