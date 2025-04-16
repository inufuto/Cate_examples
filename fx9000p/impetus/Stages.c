#include "Stage.h"
#include "Stages.h"
#include "Chars.h"


static const Route[] EmptyRoute = {};


const byte[] MapBytes = {
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	1,2,3,0,0,4,1,1,2,0,5,6,6,6,7,8,0,0,9,10,11,11,11,11,
	1,1,1,2,3,12,1,1,1,0,13,0,0,0,13,0,9,10,11,11,11,11,11,11,
	1,1,1,1,2,14,14,14,14,14,15,14,14,14,15,14,10,11,11,11,11,11,11,11,
	1,1,1,1,16,0,0,0,0,0,13,0,0,0,13,0,17,11,11,11,11,11,11,11,
	1,1,16,18,5,6,6,6,6,6,19,6,20,21,22,0,0,0,0,0,0,0,23,21,
	1,16,18,0,13,0,0,24,25,0,13,0,26,27,28,6,6,6,6,6,6,29,30,27,
	0,0,0,0,13,0,0,4,1,0,13,0,0,0,0,0,0,24,25,3,0,13,0,0,
	0,0,0,0,13,0,0,12,31,0,13,4,1,1,2,0,24,32,1,2,3,33,6,6,
	6,6,29,6,34,6,6,6,6,6,35,0,12,36,16,0,32,1,37,1,2,13,4,1,
	0,0,13,4,38,9,10,11,11,11,11,11,39,40,0,0,1,1,1,1,1,13,0,0,
	0,0,13,0,0,10,11,11,11,11,11,11,11,39,40,0,36,1,1,1,16,33,6,6,
	6,6,41,8,0,11,11,11,11,11,11,11,11,11,39,0,12,36,1,16,18,13,0,32,
	0,0,13,0,9,11,11,11,11,11,11,11,11,11,11,40,0,0,0,0,0,13,0,1,
	0,0,13,0,10,11,11,11,11,11,11,11,11,11,11,39,40,0,0,0,0,13,0,36,
	0,0,13,0,11,11,11,11,11,42,43,11,11,11,11,11,11,39,0,32,2,44,6,6,
	6,6,41,0,11,11,11,11,11,39,45,11,11,11,11,11,11,11,0,1,1,0,0,0,
	0,0,13,0,17,11,11,11,11,11,11,11,11,11,11,11,11,11,14,14,14,14,14,14,
	0,0,13,8,0,43,17,11,11,11,11,11,11,11,11,11,11,46,0,0,0,36,16,0,
	6,6,34,6,6,7,43,17,11,11,11,11,11,11,11,46,47,23,48,0,5,6,6,6,
	0,0,24,32,2,13,0,43,11,46,47,0,43,49,47,24,25,26,50,0,13,0,0,0,
	1,1,1,1,1,13,4,38,51,0,0,0,0,0,0,4,16,0,0,0,33,6,6,6,
	1,1,1,1,1,33,6,6,52,6,6,6,6,6,6,6,6,29,6,6,41,32,1,1,
	1,1,1,1,16,13,32,2,51,32,1,2,0,0,32,1,2,13,0,0,13,1,1,1,
	1,1,1,1,18,13,36,16,51,36,1,1,0,0,36,1,16,13,32,2,13,1,1,1,
	1,1,1,16,0,33,6,6,52,6,7,31,0,0,0,0,0,13,36,16,13,1,1,1,
	1,1,18,0,0,13,0,0,51,0,44,6,6,6,6,6,6,34,7,0,13,36,1,1,
	14,14,14,14,14,15,14,14,53,32,2,0,0,0,0,0,32,2,44,6,41,12,36,1,
	0,0,36,16,0,13,0,0,0,36,16,0,0,0,0,0,36,16,0,0,13,0,12,1,
	6,6,6,6,6,41,8,0,0,0,0,5,6,6,6,6,6,7,0,0,13,8,0,36,
	0,4,38,0,0,44,6,6,6,6,6,35,0,4,1,1,38,44,6,6,34,6,6,6,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
};


const Tile[] Tiles = {
	{{ // 0
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 1
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
	}},
	{{ // 2
		Char_Terrain + 0, Char_Terrain + 0, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Space, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
	}},
	{{ // 3
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 4
		Char_Space, Char_Space, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Space, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Space, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Space, Char_Space, Char_Terrain + 0, Char_Terrain + 0, 
	}},
	{{ // 5
		Char_Space, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 9, 
	}},
	{{ // 6
		Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{ // 7
		Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Terrain + 5, 
	}},
	{{ // 8
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Terrain + 0, Char_Terrain + 0, Char_Space, 
		Char_Space, Char_Terrain + 0, Char_Terrain + 0, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 9
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 1, 
	}},
	{{ // 10
		Char_Space, Char_Space, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
	}},
	{{ // 11
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
	}},
	{{ // 12
		Char_Space, Char_Space, Char_Space, Char_Terrain + 0, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 13
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 5, 
	}},
	{{ // 14
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 15
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 5, 
	}},
	{{ // 16
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Space, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Space, Char_Space, 
	}},
	{{ // 17
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Space, Char_Space, Char_Terrain + 1, Char_Terrain + 1, 
	}},
	{{ // 18
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 19
		Char_Terrain + 4, Char_Space, Char_Space, Char_Terrain + 6, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Terrain + 9, 
	}},
	{{ // 20
		Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 21
		Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 22
		Char_Terrain + 4, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
	}},
	{{ // 23
		Char_Space, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 24
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 0, 
	}},
	{{ // 25
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Terrain + 0, Char_Terrain + 0, Char_Space, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
	}},
	{{ // 26
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{ // 27
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{ // 28
		Char_Space, Char_Space, Char_Space, Char_Terrain + 6, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{ // 29
		Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Terrain + 9, 
	}},
	{{ // 30
		Char_Terrain + 4, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{ // 31
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Space, Char_Terrain + 0, Char_Terrain + 0, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 32
		Char_Space, Char_Space, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Space, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
	}},
	{{ // 33
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 6, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 9, 
	}},
	{{ // 34
		Char_Terrain + 4, Char_Space, Char_Space, Char_Terrain + 6, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{ // 35
		Char_Terrain + 4, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Space, 
	}},
	{{ // 36
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Space, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		Char_Space, Char_Space, Char_Terrain + 0, Char_Terrain + 0, 
	}},
	{{ // 37
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 0, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 0, 
	}},
	{{ // 38
		Char_Terrain + 0, Char_Terrain + 0, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Space, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Space, 
		Char_Terrain + 0, Char_Terrain + 0, Char_Space, Char_Space, 
	}},
	{{ // 39
		Char_Terrain + 1, Char_Terrain + 1, Char_Space, Char_Space, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
	}},
	{{ // 40
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 1, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 41
		Char_Terrain + 4, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Terrain + 5, 
	}},
	{{ // 42
		Char_Terrain + 1, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 1, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 43
		Char_Space, Char_Space, Char_Space, Char_Terrain + 1, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 44
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 6, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{ // 45
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 1, Char_Space, Char_Space, Char_Terrain + 1, 
	}},
	{{ // 46
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Space, Char_Space, 
	}},
	{{ // 47
		Char_Terrain + 1, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 48
		Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
	}},
	{{ // 49
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{ // 50
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Space, 
	}},
	{{ // 51
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
	}},
	{{ // 52
		Char_Terrain + 2, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 2, 
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
	}},
	{{ // 53
		Char_Space, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
};

static const SkyElement[] SkyElements0 = {
	{ 124, 0x01 },
	{ 96, 0x03 },
	{ 92, 0x02 },
	{ 64, 0x0a },
	{ 60, 0x08 },
	{ 48, 0x00 },
	{ 44, 0x04 },
	{ 16, 0x00 },
	{ 12, 0x01 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements1 = {
	{ 124, 0x01 },
	{ 96, 0x03 },
	{ 88, 0x02 },
	{ 76, 0x0a },
	{ 56, 0x08 },
	{ 36, 0x0c },
	{ 32, 0x04 },
	{ 20, 0x05 },
	{ 16, 0x01 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements2 = {
	{ 124, 0x01 },
	{ 104, 0x03 },
	{ 80, 0x02 },
	{ 76, 0x0a },
	{ 48, 0x08 },
	{ 44, 0x0c },
	{ 36, 0x04 },
	{ 20, 0x05 },
	{ 8, 0x01 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements3 = {
	{ 124, 0x01 },
	{ 112, 0x03 },
	{ 72, 0x02 },
	{ 52, 0x06 },
	{ 40, 0x04 },
	{ 16, 0x0c },
	{ 4, 0x08 },
	{ 0, 0x00 },
};

static const SkyElement[] SkyElements4 = {
	{ 124, 0x01 },
	{ 120, 0x03 },
	{ 76, 0x0b },
	{ 64, 0x0a },
	{ 60, 0x0e },
	{ 40, 0x06 },
	{ 32, 0x04 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements5 = {
	{ 124, 0x02 },
	{ 120, 0x03 },
	{ 76, 0x0b },
	{ 68, 0x0f },
	{ 56, 0x0e },
	{ 48, 0x06 },
	{ 24, 0x04 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements6 = {
	{ 124, 0x02 },
	{ 120, 0x03 },
	{ 76, 0x07 },
	{ 68, 0x0f },
	{ 48, 0x0e },
	{ 44, 0x06 },
	{ 16, 0x04 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements7 = {
	{ 124, 0x02 },
	{ 120, 0x03 },
	{ 92, 0x07 },
	{ 40, 0x06 },
	{ 24, 0x0e },
	{ 8, 0x0c },
	{ 4, 0x04 },
	{ 0, 0x00 },
};

static const Route[] Route0B1 = {
	{ 1, 0, 20 },
	{ -1, 0, 22 },
};

static const Route[] Route0B2 = {
	{ 0, 1, 28 },
};

static const Route[] Route0B3 = {
	{ -1, 0, 22 },
};

static const Route[] Route0B5 = {
	{ 0, 1, 8 },
	{ 1, 0, 87 },
};

static const Route[] Route0B0 = {
	{ 1, 0, 20 },
};

static const Route[] Route1B4 = {
	{ 1, 0, 20 },
	{ 0, -1, 20 },
};

static const Route[] Route1B3 = {
	{ -1, 0, 8 },
	{ 0, 1, 16 },
};

static const Route[] Route1B5 = {
	{ -1, 0, 22 },
};

static const Route[] Route2B4 = {
	{ 1, 0, 95 },
};

static const Route[] Route2B2 = {
	{ -1, 0, 8 },
	{ 0, -1, 24 },
	{ -1, 0, 10 },
};

static const Route[] Route2B3 = {
	{ -1, 0, 8 },
};

static const Route[] Route2B5 = {
	{ -1, 0, 16 },
	{ 0, 1, 16 },
};

static const Route[] Route2B0 = {
	{ -1, 0, 12 },
	{ 0, -1, 4 },
	{ -1, 0, 10 },
};

static const Route[] Route3B4 = {
	{ -1, 0, 4 },
	{ 1, 0, 4 },
	{ -1, 0, 22 },
};

static const Route[] Route3B2 = {
	{ 0, -1, 48 },
	{ 1, 0, 83 },
};

static const Route[] Route3B3 = {
	{ 1, 0, 12 },
	{ 0, -1, 8 },
	{ 1, 0, 83 },
};

static const Route[] Route3B5 = {
	{ -1, 0, 4 },
	{ 1, 0, 4 },
	{ 1, 0, 75 },
};

static const Route[] Route3B0 = {
	{ -1, 0, 16 },
	{ 0, -1, 16 },
	{ -1, 0, 6 },
};

static const Route[] Route4B1 = {
	{ -1, 0, 4 },
	{ 0, -1, 16 },
	{ 1, 0, 79 },
};

static const Route[] Route4B4 = {
	{ 1, 0, 95 },
};

static const Route[] Route4B3 = {
	{ 1, 0, 16 },
	{ 0, 1, 16 },
};

static const Route[] Route4B5 = {
	{ 1, 0, 95 },
};

static const Route[] Route4B0 = {
	{ -1, 0, 8 },
	{ 1, 0, 4 },
	{ -1, 0, 18 },
};

static const Route[] Route5B1 = {
	{ 0, -1, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 75 },
};

static const Route[] Route5B4 = {
	{ 1, 0, 8 },
	{ 0, -1, 12 },
	{ -1, 0, 10 },
};

static const Route[] Route5B2 = {
	{ -1, 0, 22 },
};

static const Route[] Route5B3 = {
	{ 1, 0, 8 },
	{ 0, -1, 12 },
	{ -1, 0, 10 },
};

static const Route[] Route5B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 16 },
	{ 1, 0, 79 },
};

static const Route[] Route5B0 = {
	{ 1, 0, 20 },
	{ 0, 1, 4 },
	{ 1, 0, 75 },
};

static const Route[] Route6B8 = {
	{ 1, 0, 12 },
	{ 0, 1, 36 },
};

static const Route[] Route6B1 = {
	{ 1, 0, 20 },
};

static const Route[] Route6B2 = {
	{ 0, 1, 40 },
};

static const Route[] Route6B7 = {
	{ -1, 0, 8 },
	{ 0, -1, 12 },
	{ 1, 0, 83 },
};

static const Route[] Route6B3 = {
	{ 1, 0, 8 },
	{ 0, 1, 24 },
};

static const Route[] Route7B1 = {
	{ -1, 0, 8 },
	{ 0, -1, 12 },
	{ 1, 0, 83 },
};

static const Route[] Route7B4 = {
	{ -1, 0, 12 },
	{ 0, 1, 16 },
	{ 1, 0, 87 },
};

static const Route[] Route7B3 = {
	{ -1, 0, 12 },
	{ 0, -1, 40 },
	{ 1, 0, 95 },
};

static const Route[] Route7B0 = {
	{ 1, 0, 12 },
	{ 0, 1, 4 },
	{ 1, 0, 8 },
};

static const GroundElement[] GroundElements0 = {
	{ // B0
		1, 117,
		1,
		Route0B0
	},
	{ // A2
		9, 113,
		0,
		EmptyRoute
	},
	{ // B1
		1, 105,
		2,
		Route0B1
	},
	{ // A4
		5, 97,
		0,
		EmptyRoute
	},
	{ // B2
		21, 93,
		1,
		Route0B2
	},
	{ // B3
		21, 89,
		1,
		Route0B3
	},
	{ // A6
		21, 85,
		0,
		EmptyRoute
	},
	{ // A7
		9, 81,
		0,
		EmptyRoute
	},
	{ // A8
		21, 77,
		0,
		EmptyRoute
	},
	{ // A9
		13, 49,
		0,
		EmptyRoute
	},
	{ // A10
		17, 49,
		0,
		EmptyRoute
	},
	{ // A11
		9, 41,
		0,
		EmptyRoute
	},
	{ // A12
		1, 25,
		0,
		EmptyRoute
	},
	{ // A13
		5, 25,
		0,
		EmptyRoute
	},
	{ // A15
		1, 21,
		0,
		EmptyRoute
	},
	{ // A16
		5, 21,
		0,
		EmptyRoute
	},
	{ // B5
		9, 17,
		2,
		Route0B5
	},
	{ // A17
		1, 9,
		0,
		EmptyRoute
	},
};

static const GroundElement[] GroundElements1 = {
	{ // A0
		21, 113,
		0,
		EmptyRoute
	},
	{ // A2
		9, 97,
		0,
		EmptyRoute
	},
	{ // B3
		9, 89,
		2,
		Route1B3
	},
	{ // A3
		21, 85,
		0,
		EmptyRoute
	},
	{ // A4
		5, 77,
		0,
		EmptyRoute
	},
	{ // A5
		21, 61,
		0,
		EmptyRoute
	},
	{ // B4
		1, 37,
		2,
		Route1B4
	},
	{ // A7
		5, 33,
		0,
		EmptyRoute
	},
	{ // A8
		5, 25,
		0,
		EmptyRoute
	},
	{ // B5
		21, 21,
		1,
		Route1B5
	},
	{ // A10
		13, 17,
		0,
		EmptyRoute
	},
	{ // A11
		21, 9,
		0,
		EmptyRoute
	},
	{ // A12
		1, 5,
		0,
		EmptyRoute
	},
};

static const GroundElement[] GroundElements2 = {
	{ // B0
		21, 121,
		3,
		Route2B0
	},
	{ // A1
		21, 113,
		0,
		EmptyRoute
	},
	{ // B2
		17, 101,
		3,
		Route2B2
	},
	{ // A3
		5, 97,
		0,
		EmptyRoute
	},
	{ // B3
		17, 89,
		1,
		Route2B3
	},
	{ // A5
		17, 85,
		0,
		EmptyRoute
	},
	{ // A6
		9, 73,
		0,
		EmptyRoute
	},
	{ // A7
		1, 69,
		0,
		EmptyRoute
	},
	{ // A8
		1, 61,
		0,
		EmptyRoute
	},
	{ // B4
		1, 37,
		1,
		Route2B4
	},
	{ // A11
		9, 33,
		0,
		EmptyRoute
	},
	{ // A12
		9, 29,
		0,
		EmptyRoute
	},
	{ // A13
		13, 25,
		0,
		EmptyRoute
	},
	{ // B5
		21, 21,
		2,
		Route2B5
	},
	{ // A14
		17, 17,
		0,
		EmptyRoute
	},
	{ // A15
		5, 9,
		0,
		EmptyRoute
	},
	{ // A16
		1, 5,
		0,
		EmptyRoute
	},
};

static const GroundElement[] GroundElements3 = {
	{ // B2
		13, 121,
		2,
		Route3B2
	},
	{ // B0
		21, 121,
		3,
		Route3B0
	},
	{ // A2
		9, 117,
		0,
		EmptyRoute
	},
	{ // A3
		21, 117,
		0,
		EmptyRoute
	},
	{ // A4
		9, 113,
		0,
		EmptyRoute
	},
	{ // B3
		1, 89,
		3,
		Route3B3
	},
	{ // A6
		5, 85,
		0,
		EmptyRoute
	},
	{ // A7
		5, 81,
		0,
		EmptyRoute
	},
	{ // A8
		9, 81,
		0,
		EmptyRoute
	},
	{ // A9
		9, 77,
		0,
		EmptyRoute
	},
	{ // A10
		9, 73,
		0,
		EmptyRoute
	},
	{ // B4
		21, 65,
		3,
		Route3B4
	},
	{ // A12
		13, 57,
		0,
		EmptyRoute
	},
	{ // A14
		9, 53,
		0,
		EmptyRoute
	},
	{ // A15
		13, 49,
		0,
		EmptyRoute
	},
	{ // B5
		21, 45,
		3,
		Route3B5
	},
	{ // A16
		5, 37,
		0,
		EmptyRoute
	},
	{ // A17
		13, 29,
		0,
		EmptyRoute
	},
	{ // A18
		21, 21,
		0,
		EmptyRoute
	},
	{ // A19
		1, 5,
		0,
		EmptyRoute
	},
};

static const GroundElement[] GroundElements4 = {
	{ // A0
		21, 125,
		0,
		EmptyRoute
	},
	{ // B0
		21, 121,
		3,
		Route4B0
	},
	{ // A3
		1, 113,
		0,
		EmptyRoute
	},
	{ // A4
		1, 109,
		0,
		EmptyRoute
	},
	{ // A5
		5, 109,
		0,
		EmptyRoute
	},
	{ // B1
		21, 109,
		3,
		Route4B1
	},
	{ // B3
		1, 105,
		2,
		Route4B3
	},
	{ // B4
		1, 89,
		1,
		Route4B4
	},
	{ // A8
		17, 85,
		0,
		EmptyRoute
	},
	{ // A9
		17, 81,
		0,
		EmptyRoute
	},
	{ // A10
		21, 81,
		0,
		EmptyRoute
	},
	{ // A11
		21, 77,
		0,
		EmptyRoute
	},
	{ // A12
		9, 49,
		0,
		EmptyRoute
	},
	{ // A13
		5, 41,
		0,
		EmptyRoute
	},
	{ // A14
		17, 37,
		0,
		EmptyRoute
	},
	{ // A15
		9, 29,
		0,
		EmptyRoute
	},
	{ // B5
		1, 25,
		1,
		Route4B5
	},
	{ // A17
		5, 21,
		0,
		EmptyRoute
	},
	{ // A18
		1, 9,
		0,
		EmptyRoute
	},
	{ // A19
		9, 9,
		0,
		EmptyRoute
	},
};

static const GroundElement[] GroundElements5 = {
	{ // A0
		13, 121,
		0,
		EmptyRoute
	},
	{ // B0
		1, 117,
		3,
		Route5B0
	},
	{ // A2
		17, 113,
		0,
		EmptyRoute
	},
	{ // A3
		9, 105,
		0,
		EmptyRoute
	},
	{ // B1
		21, 105,
		3,
		Route5B1
	},
	{ // A5
		5, 81,
		0,
		EmptyRoute
	},
	{ // B3
		1, 77,
		3,
		Route5B3
	},
	{ // B2
		21, 77,
		1,
		Route5B2
	},
	{ // A8
		1, 73,
		0,
		EmptyRoute
	},
	{ // A9
		13, 61,
		0,
		EmptyRoute
	},
	{ // A10
		1, 53,
		0,
		EmptyRoute
	},
	{ // B4
		1, 49,
		3,
		Route5B4
	},
	{ // A12
		17, 45,
		0,
		EmptyRoute
	},
	{ // A13
		5, 41,
		0,
		EmptyRoute
	},
	{ // B5
		21, 37,
		3,
		Route5B5
	},
	{ // A15
		5, 33,
		0,
		EmptyRoute
	},
	{ // A16
		9, 29,
		0,
		EmptyRoute
	},
	{ // A17
		13, 25,
		0,
		EmptyRoute
	},
	{ // A18
		17, 9,
		0,
		EmptyRoute
	},
	{ // A19
		21, 9,
		0,
		EmptyRoute
	},
	{ // A20
		9, 5,
		0,
		EmptyRoute
	},
};

static const GroundElement[] GroundElements6 = {
	{ // B1
		1, 121,
		1,
		Route6B1
	},
	{ // A2
		5, 113,
		0,
		EmptyRoute
	},
	{ // A4
		13, 113,
		0,
		EmptyRoute
	},
	{ // B3
		1, 89,
		2,
		Route6B3
	},
	{ // A5
		1, 85,
		0,
		EmptyRoute
	},
	{ // A6
		21, 85,
		0,
		EmptyRoute
	},
	{ // A7
		1, 77,
		0,
		EmptyRoute
	},
	{ // B2
		9, 77,
		1,
		Route6B2
	},
	{ // A8
		13, 77,
		0,
		EmptyRoute
	},
	{ // A9
		21, 77,
		0,
		EmptyRoute
	},
	{ // A11
		5, 53,
		0,
		EmptyRoute
	},
	{ // A12
		9, 53,
		0,
		EmptyRoute
	},
	{ // B7
		21, 45,
		3,
		Route6B7
	},
	{ // A14
		1, 37,
		0,
		EmptyRoute
	},
	{ // A15
		9, 29,
		0,
		EmptyRoute
	},
	{ // B8
		1, 25,
		2,
		Route6B8
	},
	{ // A16
		21, 25,
		0,
		EmptyRoute
	},
	{ // A17
		17, 21,
		0,
		EmptyRoute
	},
	{ // A18
		1, 5,
		0,
		EmptyRoute
	},
};

static const GroundElement[] GroundElements7 = {
	{ // A0
		9, 121,
		0,
		EmptyRoute
	},
	{ // B0
		1, 117,
		3,
		Route7B0
	},
	{ // A2
		9, 113,
		0,
		EmptyRoute
	},
	{ // A3
		21, 113,
		0,
		EmptyRoute
	},
	{ // B1
		21, 101,
		3,
		Route7B1
	},
	{ // B3
		13, 77,
		3,
		Route7B3
	},
	{ // A6
		5, 61,
		0,
		EmptyRoute
	},
	{ // A7
		9, 53,
		0,
		EmptyRoute
	},
	{ // A8
		9, 45,
		0,
		EmptyRoute
	},
	{ // A10
		5, 29,
		0,
		EmptyRoute
	},
	{ // A11
		17, 29,
		0,
		EmptyRoute
	},
	{ // B4
		21, 21,
		3,
		Route7B4
	},
	{ // A12
		1, 5,
		0,
		EmptyRoute
	},
	{ // A13
		5, 5,
		0,
		EmptyRoute
	},
};

const Stage[] Stages = {
	{
		12,
		10,SkyElements0,
		18,GroundElements0,
	},
	{
		5,
		10,SkyElements1,
		13,GroundElements1,
	},
	{
		3,
		10,SkyElements2,
		17,GroundElements2,
	},
	{
		17,
		8,SkyElements3,
		20,GroundElements3,
	},
	{
		14,
		8,SkyElements4,
		20,GroundElements4,
	},
	{
		0,
		8,SkyElements5,
		21,GroundElements5,
	},
	{
		18,
		8,SkyElements6,
		19,GroundElements6,
	},
	{
		2,
		8,SkyElements7,
		14,GroundElements7,
	},
};

