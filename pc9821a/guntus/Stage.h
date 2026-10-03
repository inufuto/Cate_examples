struct Formation {
    byte elementCount;
    byte courseIndex;
    byte[8] targets;
    byte[2] types;
};

struct Stage {
    byte min, max;
    byte rowCount;
    byte formationCount;
    ptr<Formation> pFormation;
};

extern ptr<Stage> pStage;

extern void InitPlaying();
extern void InitStage();
