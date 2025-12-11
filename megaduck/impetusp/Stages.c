#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 1
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 4, 
		},
	},
	{ // 2
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
		},
	},
	{ // 3
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 4
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 5
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 6
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 7
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 8
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 9
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 10
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 11
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 12
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 13
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 0, 
		},
	},
	{ // 14
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 15
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 16
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 17
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 0, 
		},
	},
	{ // 18
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 19
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 20
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 21
		{ // chars
			Char_Terrain + 4, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 20, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 22
		{ // chars
			Char_Terrain + 4, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 23
		{ // chars
			Char_Terrain + 2, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 18, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 14, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 13, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 15, 
		},
	},
	{ // 24
		{ // chars
			Char_Terrain + 2, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 18, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 14, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 25
		{ // chars
			Char_Terrain + 2, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 13, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 26
		{ // chars
			Char_Terrain + 2, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 27
		{ // chars
			Char_Terrain + 2, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 13, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 28
		{ // chars
			Char_Terrain + 2, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 29
		{ // chars
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 18, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 14, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 15, 
		},
	},
	{ // 30
		{ // chars
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 18, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 14, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 31
		{ // chars
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 32
		{ // chars
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 16, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 33
		{ // chars
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 1, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 21, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 34
		{ // chars
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 35
		{ // chars
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 20, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 19, 
		},
	},
	{ // 36
		{ // chars
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 20, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 37
		{ // chars
			Char_Terrain + 23, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 23, 
			Char_Terrain + 19, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 19, 
		},
	},
	{ // 38
		{ // chars
			Char_Terrain + 14, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 16, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 39
		{ // chars
			Char_Terrain + 21, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 1, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 21, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 40
		{ // chars
			Char_Terrain + 21, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 41
		{ // chars
			Char_Terrain + 21, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 20, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 42
		{ // chars
			Char_Terrain + 7, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 43
		{ // chars
			Char_Terrain + 7, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 44
		{ // chars
			Char_Terrain + 7, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 45
		{ // chars
			Char_Terrain + 7, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 46
		{ // chars
			Char_Terrain + 7, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 47
		{ // chars
			Char_Terrain + 7, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 48
		{ // chars
			Char_Terrain + 7, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 13, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 49
		{ // chars
			Char_Terrain + 11, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 50
		{ // chars
			Char_Terrain + 11, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 51
		{ // chars
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 52
		{ // chars
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 0, 
		},
	},
	{ // 53
		{ // chars
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 54
		{ // chars
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 55
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 56
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 57
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 58
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 59
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 13, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 60
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 13, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
		},
	},
	{ // 61
		{ // chars
			Char_Terrain + 15, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 62
		{ // chars
			Char_Terrain + 15, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 13, 
			Char_Terrain + 5, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 18, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
		},
	},
	{ // 63
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 13, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 15, 
		},
	},
	{ // 64
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 13, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 65
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 15, 
		},
	},
	{ // 66
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 67
		{ // chars
			Char_Terrain + 6, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 68
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 69
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 70
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 71
		{ // chars
			Char_Terrain + 9, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 72
		{ // chars
			Char_Terrain + 9, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 73
		{ // chars
			Char_Terrain + 9, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 8, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 74
		{ // chars
			Char_Terrain + 9, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 8, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 4, 
		},
	},
	{ // 75
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 24, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 24, 
			Char_Terrain + 25, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 25, 
			Char_Terrain + 22, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 22, 
		},
	},
	{ // 76
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 8, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 77
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 9, 
		},
	},
	{ // 78
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
};

static const byte[] mapBytes0 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	25, 12, 12, 9, 0, 45, 54, 54, 
	53, 10, 10, 0, 0, 0, 2, 26, 
	31, 30, 0, 27, 66, 66, 65, 0, 
	45, 57, 57, 55, 0, 4, 0, 34, 
	33, 0, 13, 0, 78, 78, 3, 0, 
	0, 78, 78, 40, 33, 0, 78, 78, 
	78, 78, 3, 78, 78, 78, 78, 40, 
	78, 78, 74, 78, 78, 78, 78, 41, 
	78, 78, 78, 78, 78, 77, 72, 78, 
	77, 72, 68, 0, 69, 68, 0, 0, 
	0, 10, 10, 10, 10, 10, 0, 2, 
	24, 0, 0, 0, 27, 65, 6, 10, 
	0, 45, 55, 14, 0, 10, 10, 10, 
	18, 0, 0, 0, 0, 14, 0, 0, 
	0, 0, 14, 0, 10, 10, 10, 18, 
	0, 0, 0, 0, 14, 0, 0, 25, 
	29, 15, 10, 0, 45, 55, 0, 0, 

};
static const byte[] mapBytes1 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 10, 10, 10, 10, 8, 0, 0, 
	26, 30, 14, 0, 0, 64, 65, 14, 
	10, 10, 47, 56, 17, 0, 0, 0, 
	0, 0, 0, 1, 21, 34, 34, 1, 
	22, 78, 78, 78, 36, 78, 78, 78, 
	78, 78, 78, 78, 78, 78, 78, 78, 
	74, 78, 72, 78, 78, 41, 78, 3, 
	78, 78, 78, 78, 40, 78, 78, 78, 
	78, 78, 69, 70, 76, 78, 78, 0, 
	0, 50, 78, 78, 0, 0, 0, 78, 
	72, 6, 10, 10, 75, 10, 14, 26, 
	30, 78, 26, 14, 64, 65, 78, 66, 
	14, 45, 55, 78, 64, 16, 10, 10, 
	75, 47, 14, 0, 1, 78, 0, 37, 
	34, 35, 78, 25, 67, 69, 67, 69, 
	45, 14, 0, 14, 0, 0, 15, 10, 
	19, 10, 10, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes2 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 6, 10, 10, 10, 0, 14, 
	0, 25, 31, 0, 14, 0, 45, 57, 
	10, 19, 10, 10, 10, 30, 0, 0, 
	0, 0, 65, 0, 1, 21, 34, 55, 
	1, 22, 78, 78, 0, 22, 78, 78, 
	78, 0, 78, 78, 78, 78, 0, 78, 
	78, 78, 78, 0, 78, 78, 78, 78, 
	0, 76, 78, 78, 78, 0, 50, 76, 
	78, 78, 0, 0, 50, 78, 78, 10, 
	8, 0, 78, 78, 0, 14, 0, 78, 
	72, 30, 16, 10, 75, 10, 66, 14, 
	0, 78, 0, 66, 14, 0, 78, 0, 
	65, 16, 10, 75, 10, 55, 14, 1, 
	78, 0, 34, 37, 36, 77, 0, 69, 
	67, 69, 68, 0, 10, 18, 26, 31, 
	31, 0, 14, 64, 66, 66, 29, 15, 
	47, 58, 58, 55, 0, 0, 0, 0, 

};
static const byte[] mapBytes3 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 25, 
	31, 0, 0, 0, 48, 64, 10, 10, 
	10, 8, 45, 2, 26, 30, 14, 0, 
	32, 66, 66, 16, 10, 66, 62, 66, 
	14, 0, 66, 38, 66, 16, 10, 66, 
	66, 65, 14, 0, 57, 57, 55, 14, 
	0, 0, 25, 30, 16, 10, 0, 48, 
	63, 14, 0, 34, 33, 43, 14, 0, 
	78, 78, 40, 37, 34, 78, 77, 72, 
	67, 69, 77, 71, 0, 16, 10, 68, 
	0, 0, 14, 0, 0, 0, 0, 16, 
	10, 10, 10, 10, 18, 25, 0, 0, 
	0, 14, 45, 30, 6, 10, 18, 25, 
	65, 14, 0, 14, 45, 56, 18, 0, 
	14, 26, 0, 16, 10, 18, 64, 29, 
	14, 0, 14, 45, 56, 18, 0, 14, 
	0, 0, 14, 0, 14, 0, 0, 15, 
	10, 19, 10, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes4 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 10, 10, 10, 11, 10, 31, 30, 
	0, 14, 0, 66, 65, 0, 14, 26, 
	58, 56, 10, 17, 64, 0, 0, 0, 
	0, 45, 1, 21, 34, 33, 3, 36, 
	78, 78, 78, 40, 78, 78, 78, 78, 
	78, 78, 78, 78, 78, 78, 78, 78, 
	78, 78, 78, 78, 78, 74, 78, 78, 
	78, 78, 41, 78, 78, 78, 78, 78, 
	78, 78, 78, 78, 78, 78, 78, 70, 
	78, 77, 73, 76, 0, 78, 71, 0, 
	49, 10, 75, 10, 10, 10, 29, 78, 
	26, 30, 0, 55, 78, 64, 65, 0, 
	10, 75, 47, 56, 10, 1, 78, 0, 
	0, 0, 35, 77, 0, 4, 0, 67, 
	68, 0, 13, 0, 14, 24, 0, 0, 
	0, 14, 63, 0, 6, 10, 15, 44, 
	10, 17, 0, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes5 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 24, 
	0, 12, 9, 0, 63, 0, 54, 53, 
	10, 44, 10, 0, 0, 2, 26, 31, 
	30, 0, 28, 66, 66, 65, 0, 64, 
	66, 66, 55, 0, 45, 59, 64, 33, 
	0, 7, 9, 45, 78, 3, 20, 52, 
	0, 78, 39, 3, 0, 0, 78, 78, 
	39, 3, 25, 78, 78, 78, 39, 46, 
	78, 74, 78, 78, 40, 78, 41, 78, 
	77, 72, 78, 78, 77, 71, 0, 77, 
	72, 68, 0, 0, 68, 0, 0, 0, 
	0, 10, 10, 10, 10, 10, 0, 0, 
	0, 0, 0, 0, 0, 0, 6, 10, 
	10, 10, 10, 18, 26, 0, 0, 0, 
	14, 64, 12, 9, 0, 16, 47, 54, 
	52, 0, 14, 0, 0, 0, 0, 14, 
	0, 10, 10, 10, 18, 0, 31, 29, 
	0, 15, 10, 57, 55, 0, 0, 0, 

};
static const byte[] mapBytes6 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 26, 29, 0, 
	0, 0, 63, 61, 6, 10, 0, 42, 
	0, 14, 0, 0, 0, 0, 14, 0, 
	10, 11, 10, 19, 10, 0, 14, 23, 
	0, 0, 0, 14, 42, 0, 21, 0, 
	14, 0, 1, 78, 10, 18, 0, 22, 
	78, 0, 14, 0, 78, 78, 0, 14, 
	0, 78, 78, 10, 18, 0, 78, 78, 
	0, 14, 0, 78, 78, 0, 14, 0, 
	76, 78, 0, 14, 0, 49, 69, 10, 
	19, 10, 8, 0, 31, 30, 0, 14, 
	0, 66, 66, 0, 16, 10, 66, 66, 
	0, 14, 0, 66, 66, 0, 14, 0, 
	66, 65, 0, 16, 10, 57, 55, 0, 
	14, 0, 34, 34, 34, 37, 34, 69, 
	69, 69, 67, 69, 10, 10, 10, 18, 
	26, 0, 24, 0, 14, 64, 0, 63, 
	0, 15, 47, 0, 42, 0, 0, 0, 

};
static const byte[] mapBytes7 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 30, 0, 0, 5, 
	12, 65, 0, 0, 0, 51, 56, 10, 
	10, 8, 0, 31, 30, 0, 14, 0, 
	66, 66, 0, 16, 10, 60, 66, 0, 
	14, 0, 32, 66, 0, 16, 10, 66, 
	66, 0, 14, 0, 66, 65, 0, 14, 
	0, 66, 61, 0, 15, 10, 65, 0, 
	0, 0, 0, 55, 0, 0, 0, 0, 
	34, 34, 34, 34, 34, 69, 69, 69, 
	69, 69, 0, 6, 10, 10, 10, 0, 
	14, 0, 0, 0, 0, 16, 10, 10, 
	10, 10, 18, 0, 0, 0, 0, 14, 
	0, 26, 31, 10, 18, 0, 66, 66, 
	0, 14, 0, 66, 66, 0, 14, 0, 
	66, 66, 10, 18, 2, 66, 66, 0, 
	14, 28, 66, 66, 0, 14, 66, 62, 
	66, 0, 14, 64, 38, 66, 10, 19, 
	47, 58, 58, 0, 0, 0, 0, 0, 

};

static const SkyElement[] SkyElements0 = {
	{ 31, 0x01 },
	{ 25, 0x00 },
	{ 24, 0x02 },
	{ 16, 0x00 },
	{ 15, 0x08 },
	{ 9, 0x00 },
	{ 8, 0x04 },
	{ 4, 0x00 },
	{ 3, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements1 = {
	{ 31, 0x01 },
	{ 23, 0x03 },
	{ 21, 0x02 },
	{ 19, 0x0a },
	{ 13, 0x08 },
	{ 9, 0x00 },
	{ 8, 0x04 },
	{ 5, 0x05 },
	{ 4, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements2 = {
	{ 31, 0x01 },
	{ 24, 0x03 },
	{ 20, 0x02 },
	{ 19, 0x0a },
	{ 12, 0x08 },
	{ 11, 0x0c },
	{ 9, 0x04 },
	{ 5, 0x05 },
	{ 4, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements3 = {
	{ 31, 0x01 },
	{ 27, 0x03 },
	{ 18, 0x02 },
	{ 12, 0x06 },
	{ 9, 0x04 },
	{ 5, 0x0c },
	{ 1, 0x08 },
	{ 0, 0x00 },
};

static const SkyElement[] SkyElements4 = {
	{ 31, 0x01 },
	{ 29, 0x03 },
	{ 18, 0x0b },
	{ 15, 0x0a },
	{ 14, 0x0e },
	{ 11, 0x06 },
	{ 7, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements5 = {
	{ 31, 0x01 },
	{ 30, 0x03 },
	{ 18, 0x0b },
	{ 17, 0x0f },
	{ 13, 0x0e },
	{ 11, 0x06 },
	{ 5, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements6 = {
	{ 31, 0x01 },
	{ 30, 0x03 },
	{ 19, 0x07 },
	{ 16, 0x0f },
	{ 12, 0x0e },
	{ 11, 0x06 },
	{ 4, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements7 = {
};


static const Route[] Route0B1 = {
	{ 1, 0, 12 },
	{ -1, 0, 14 },
};

static const Route[] Route0B2 = {
	{ -1, 0, 4 },
	{ 0, 1, 24 },
};

static const Route[] Route0B5 = {
	{ -1, 0, 8 },
	{ 1, 0, 11 },
};

static const Route[] Route0B0 = {
	{ 1, 0, 12 },
	{ 0, 1, 8 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements0 = {
	{ // B0
		1, 28,
		3,
		Route0B0
	},
	{ // A14
		9, 27,
		0,
		nullptr
	},
	{ // A13
		5, 26,
		0,
		nullptr
	},
	{ // B1
		1, 25,
		2,
		Route0B1
	},
	{ // A10
		1, 23,
		0,
		nullptr
	},
	{ // B2
		17, 23,
		2,
		Route0B2
	},
	{ // A9
		17, 20,
		0,
		nullptr
	},
	{ // A8
		9, 19,
		0,
		nullptr
	},
	{ // A7
		17, 18,
		0,
		nullptr
	},
	{ // A6
		9, 16,
		0,
		nullptr
	},
	{ // A5
		13, 11,
		0,
		nullptr
	},
	{ // A3
		5, 10,
		0,
		nullptr
	},
	{ // A4
		13, 10,
		0,
		nullptr
	},
	{ // A1
		5, 6,
		0,
		nullptr
	},
	{ // B5
		17, 6,
		2,
		Route0B5
	},
	{ // A0
		1, 5,
		0,
		nullptr
	},
};

static const Route[] Route1B1 = {
	{ 0, 1, 8 },
	{ 1, 0, 11 },
};

static const Route[] Route1B4 = {
	{ 1, 0, 16 },
	{ 0, -1, 12 },
	{ -1, 0, 18 },
};

static const Route[] Route1B2 = {
	{ -1, 0, 8 },
	{ 0, -1, 20 },
	{ -1, 0, 2 },
};

static const Route[] Route1B3 = {
	{ -1, 0, 8 },
	{ 0, 1, 20 },
};

static const Route[] Route1B5 = {
	{ 1, 0, 12 },
	{ -1, 0, 14 },
};

static const Route[] Route1B0 = {
	{ 0, 1, 8 },
	{ 1, 0, 19 },
};

static const GroundElement[] GroundElements1 = {
	{ // B0
		1, 28,
		2,
		Route1B0
	},
	{ // B1
		9, 28,
		2,
		Route1B1
	},
	{ // A14
		13, 28,
		0,
		nullptr
	},
	{ // B2
		9, 25,
		3,
		Route1B2
	},
	{ // A11
		9, 24,
		0,
		nullptr
	},
	{ // B3
		9, 21,
		2,
		Route1B3
	},
	{ // A9
		17, 20,
		0,
		nullptr
	},
	{ // A7
		5, 19,
		0,
		nullptr
	},
	{ // A6
		17, 15,
		0,
		nullptr
	},
	{ // A5
		9, 14,
		0,
		nullptr
	},
	{ // A4
		5, 9,
		0,
		nullptr
	},
	{ // B4
		1, 8,
		3,
		Route1B4
	},
	{ // A3
		5, 6,
		0,
		nullptr
	},
	{ // B5
		1, 5,
		2,
		Route1B5
	},
	{ // A0
		1, 4,
		0,
		nullptr
	},
};

static const Route[] Route2B4 = {
	{ 1, 0, 19 },
};

static const Route[] Route2B2 = {
	{ -1, 0, 4 },
	{ 0, -1, 20 },
	{ -1, 0, 6 },
};

static const Route[] Route2B5 = {
	{ -1, 0, 12 },
	{ 0, 1, 12 },
	{ 1, 0, 15 },
};

static const Route[] Route2B0 = {
	{ -1, 0, 12 },
	{ 0, -1, 8 },
	{ -1, 0, 6 },
};

static const GroundElement[] GroundElements2 = {
	{ // B0
		17, 30,
		3,
		Route2B0
	},
	{ // A17
		13, 27,
		0,
		nullptr
	},
	{ // B2
		9, 24,
		3,
		Route2B2
	},
	{ // A16
		9, 23,
		0,
		nullptr
	},
	{ // A14
		9, 18,
		0,
		nullptr
	},
	{ // A13
		5, 17,
		0,
		nullptr
	},
	{ // A12
		1, 16,
		0,
		nullptr
	},
	{ // A11
		1, 15,
		0,
		nullptr
	},
	{ // A10
		1, 14,
		0,
		nullptr
	},
	{ // A9
		5, 11,
		0,
		nullptr
	},
	{ // B4
		1, 8,
		1,
		Route2B4
	},
	{ // A7
		9, 7,
		0,
		nullptr
	},
	{ // A6
		9, 6,
		0,
		nullptr
	},
	{ // B5
		17, 5,
		3,
		Route2B5
	},
	{ // A3
		9, 3,
		0,
		nullptr
	},
	{ // A4
		17, 3,
		0,
		nullptr
	},
	{ // A1
		1, 2,
		0,
		nullptr
	},
	{ // A2
		17, 2,
		0,
		nullptr
	},
	{ // A0
		1, 1,
		0,
		nullptr
	},
};

static const Route[] Route3B1 = {
	{ 1, 0, 4 },
	{ 0, -1, 20 },
	{ 1, 0, 8 },
	{ 0, 1, 28 },
	{ 1, 0, 7 },
};

static const Route[] Route3B4 = {
	{ -1, 0, 4 },
	{ 0, -1, 28 },
	{ -1, 0, 14 },
};

static const Route[] Route3B2 = {
	{ 0, -1, 44 },
	{ 1, 0, 7 },
};

static const Route[] Route3B3 = {
	{ 1, 0, 12 },
	{ 0, -1, 4 },
	{ 1, 0, 7 },
};

static const Route[] Route3B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 8 },
	{ 1, 0, 7 },
};

static const Route[] Route3B0 = {
	{ -1, 0, 12 },
	{ 0, -1, 20 },
	{ -1, 0, 6 },
};

static const GroundElement[] GroundElements3 = {
	{ // A21
		5, 31,
		0,
		nullptr
	},
	{ // A22
		17, 31,
		0,
		nullptr
	},
	{ // B0
		17, 30,
		3,
		Route3B0
	},
	{ // B2
		13, 29,
		2,
		Route3B2
	},
	{ // B1
		1, 28,
		5,
		Route3B1
	},
	{ // A20
		9, 28,
		0,
		nullptr
	},
	{ // A19
		9, 25,
		0,
		nullptr
	},
	{ // A17
		17, 24,
		0,
		nullptr
	},
	{ // A15
		17, 22,
		0,
		nullptr
	},
	{ // B3
		1, 21,
		3,
		Route3B3
	},
	{ // A13
		9, 20,
		0,
		nullptr
	},
	{ // A12
		1, 19,
		0,
		nullptr
	},
	{ // A10
		5, 18,
		0,
		nullptr
	},
	{ // B4
		17, 13,
		3,
		Route3B4
	},
	{ // A8
		5, 12,
		0,
		nullptr
	},
	{ // A9
		9, 12,
		0,
		nullptr
	},
	{ // B5
		17, 10,
		3,
		Route3B5
	},
	{ // A7
		5, 9,
		0,
		nullptr
	},
	{ // A5
		17, 7,
		0,
		nullptr
	},
	{ // A3
		9, 5,
		0,
		nullptr
	},
	{ // A2
		13, 3,
		0,
		nullptr
	},
	{ // A0
		1, 2,
		0,
		nullptr
	},
	{ // A1
		17, 2,
		0,
		nullptr
	},
};

static const Route[] Route4B1 = {
	{ 0, -1, 4 },
	{ 1, 0, 19 },
};

static const Route[] Route4B2 = {
	{ 1, 0, 11 },
};

static const Route[] Route4B3 = {
	{ 1, 0, 12 },
	{ 0, -1, 12 },
	{ -1, 0, 14 },
};

static const Route[] Route4B0 = {
	{ -1, 0, 4 },
	{ 0, 1, 4 },
	{ -1, 0, 12 },
	{ 0, -1, 12 },
};

static const GroundElement[] GroundElements4 = {
	{ // A19
		5, 31,
		0,
		nullptr
	},
	{ // A20
		13, 31,
		0,
		nullptr
	},
	{ // A18
		9, 29,
		0,
		nullptr
	},
	{ // B0
		17, 29,
		4,
		Route4B0
	},
	{ // A17
		13, 27,
		0,
		nullptr
	},
	{ // A15
		13, 26,
		0,
		nullptr
	},
	{ // B1
		1, 25,
		2,
		Route4B1
	},
	{ // A13
		17, 22,
		0,
		nullptr
	},
	{ // B2
		9, 21,
		1,
		Route4B2
	},
	{ // A10
		1, 20,
		0,
		nullptr
	},
	{ // A11
		13, 20,
		0,
		nullptr
	},
	{ // A9
		13, 19,
		0,
		nullptr
	},
	{ // A8
		9, 15,
		0,
		nullptr
	},
	{ // A7
		17, 9,
		0,
		nullptr
	},
	{ // B3
		1, 8,
		3,
		Route4B3
	},
	{ // A6
		9, 7,
		0,
		nullptr
	},
	{ // A5
		17, 6,
		0,
		nullptr
	},
	{ // A3
		1, 4,
		0,
		nullptr
	},
	{ // A2
		17, 3,
		0,
		nullptr
	},
	{ // A1
		1, 2,
		0,
		nullptr
	},
	{ // A0
		17, 1,
		0,
		nullptr
	},
};

static const Route[] Route5B1 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route5B4 = {
	{ 1, 0, 19 },
};

static const Route[] Route5B0 = {
	{ -1, 0, 4 },
	{ 0, -1, 4 },
	{ -1, 0, 14 },
};

static const Route[] Route5B3 = {
	{ 1, 0, 12 },
	{ 0, 1, 28 },
};

static const Route[] Route5B5 = {
	{ 1, 0, 15 },
};

static const GroundElement[] GroundElements5 = {
	{ // A24
		9, 31,
		0,
		nullptr
	},
	{ // A25
		17, 31,
		0,
		nullptr
	},
	{ // B0
		17, 30,
		3,
		Route5B0
	},
	{ // A21
		1, 27,
		0,
		nullptr
	},
	{ // A22
		17, 27,
		0,
		nullptr
	},
	{ // A20
		5, 26,
		0,
		nullptr
	},
	{ // B1
		17, 26,
		3,
		Route5B1
	},
	{ // B3
		1, 24,
		2,
		Route5B3
	},
	{ // A17
		5, 23,
		0,
		nullptr
	},
	{ // A16
		9, 22,
		0,
		nullptr
	},
	{ // B4
		1, 21,
		1,
		Route5B4
	},
	{ // A14
		13, 20,
		0,
		nullptr
	},
	{ // A13
		17, 19,
		0,
		nullptr
	},
	{ // A12
		13, 18,
		0,
		nullptr
	},
	{ // A11
		5, 16,
		0,
		nullptr
	},
	{ // A10
		17, 15,
		0,
		nullptr
	},
	{ // A9
		9, 12,
		0,
		nullptr
	},
	{ // A8
		13, 11,
		0,
		nullptr
	},
	{ // A7
		5, 9,
		0,
		nullptr
	},
	{ // A6
		17, 8,
		0,
		nullptr
	},
	{ // A5
		9, 7,
		0,
		nullptr
	},
	{ // B5
		5, 6,
		1,
		Route5B5
	},
	{ // A2
		1, 3,
		0,
		nullptr
	},
	{ // A3
		17, 3,
		0,
		nullptr
	},
	{ // A0
		1, 0,
		0,
		nullptr
	},
	{ // A1
		17, 0,
		0,
		nullptr
	},
};

static const Route[] Route6B1 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route6B4 = {
	{ 1, 0, 4 },
	{ 0, -1, 16 },
	{ -1, 0, 6 },
};

static const Route[] Route6B2 = {
	{ -1, 0, 14 },
};

static const Route[] Route6B3 = {
	{ 1, 0, 4 },
	{ 0, -1, 16 },
	{ -1, 0, 6 },
};

static const Route[] Route6B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route6B0 = {
	{ 1, 0, 12 },
	{ 0, 1, 8 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements6 = {
	{ // A22
		9, 31,
		0,
		nullptr
	},
	{ // A21
		9, 29,
		0,
		nullptr
	},
	{ // B0
		1, 28,
		3,
		Route6B0
	},
	{ // A18
		5, 27,
		0,
		nullptr
	},
	{ // A19
		17, 27,
		0,
		nullptr
	},
	{ // A17
		9, 24,
		0,
		nullptr
	},
	{ // B1
		17, 24,
		3,
		Route6B1
	},
	{ // A15
		9, 21,
		0,
		nullptr
	},
	{ // B3
		1, 19,
		3,
		Route6B3
	},
	{ // B2
		13, 19,
		1,
		Route6B2
	},
	{ // A13
		1, 18,
		0,
		nullptr
	},
	{ // A11
		9, 14,
		0,
		nullptr
	},
	{ // A10
		1, 13,
		0,
		nullptr
	},
	{ // B4
		1, 12,
		3,
		Route6B4
	},
	{ // A9
		9, 11,
		0,
		nullptr
	},
	{ // A8
		1, 10,
		0,
		nullptr
	},
	{ // B5
		17, 8,
		3,
		Route6B5
	},
	{ // A6
		1, 7,
		0,
		nullptr
	},
	{ // A5
		5, 6,
		0,
		nullptr
	},
	{ // A3
		9, 5,
		0,
		nullptr
	},
	{ // A2
		13, 4,
		0,
		nullptr
	},
	{ // A1
		17, 1,
		0,
		nullptr
	},
	{ // A0
		1, 0,
		0,
		nullptr
	},
};

static const Route[] Route7B1 = {
	{ 1, 0, 4 },
	{ 0, -1, 16 },
	{ -1, 0, 6 },
};

static const Route[] Route7B4 = {
	{ -1, 0, 12 },
	{ 0, 1, 28 },
};

static const Route[] Route7B7 = {
	{ -1, 0, 4 },
	{ 0, 1, 40 },
	{ 1, 0, 7 },
};

static const Route[] Route7B0 = {
	{ -1, 0, 18 },
};

static const Route[] Route7B8 = {
	{ 1, 0, 12 },
	{ 0, 1, 32 },
};

static const Route[] Route7B2 = {
	{ 1, 0, 4 },
	{ 0, 1, 24 },
};

static const Route[] Route7B3 = {
	{ 1, 0, 4 },
	{ 0, 1, 28 },
};

static const Route[] Route7B6 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route7B5 = {
	{ -1, 0, 12 },
};

static const GroundElement[] GroundElements7 = {
	{ // A28
		1, 31,
		0,
		nullptr
	},
	{ // A29
		13, 31,
		0,
		nullptr
	},
	{ // B1
		1, 30,
		3,
		Route7B1
	},
	{ // B0
		17, 30,
		1,
		Route7B0
	},
	{ // A26
		13, 28,
		0,
		nullptr
	},
	{ // A25
		1, 27,
		0,
		nullptr
	},
	{ // A22
		1, 25,
		0,
		nullptr
	},
	{ // A23
		17, 25,
		0,
		nullptr
	},
	{ // B2
		1, 23,
		2,
		Route7B2
	},
	{ // A20
		13, 22,
		0,
		nullptr
	},
	{ // B3
		1, 21,
		2,
		Route7B3
	},
	{ // A19
		17, 21,
		0,
		nullptr
	},
	{ // B4
		17, 20,
		2,
		Route7B4
	},
	{ // A14
		1, 19,
		0,
		nullptr
	},
	{ // A15
		9, 19,
		0,
		nullptr
	},
	{ // A16
		17, 19,
		0,
		nullptr
	},
	{ // A12
		1, 18,
		0,
		nullptr
	},
	{ // B5
		17, 18,
		1,
		Route7B5
	},
	{ // A11
		5, 15,
		0,
		nullptr
	},
	{ // B6
		17, 13,
		3,
		Route7B6
	},
	{ // A10
		17, 11,
		0,
		nullptr
	},
	{ // A8
		9, 10,
		0,
		nullptr
	},
	{ // A7
		1, 9,
		0,
		nullptr
	},
	{ // B7
		17, 8,
		3,
		Route7B7
	},
	{ // A5
		9, 7,
		0,
		nullptr
	},
	{ // B8
		1, 6,
		2,
		Route7B8
	},
	{ // A3
		17, 5,
		0,
		nullptr
	},
	{ // A2
		13, 4,
		0,
		nullptr
	},
	{ // A0
		1, 3,
		0,
		nullptr
	},
	{ // A1
		17, 3,
		0,
		nullptr
	},
};


const Stage[] Stages = {
	{ // 0
		mapBytes0, // pBytes
		10,SkyElements0,
		16,GroundElements0,
	},
	{ // 1
		mapBytes1, // pBytes
		10,SkyElements1,
		15,GroundElements1,
	},
	{ // 2
		mapBytes2, // pBytes
		10,SkyElements2,
		19,GroundElements2,
	},
	{ // 3
		mapBytes3, // pBytes
		8,SkyElements3,
		23,GroundElements3,
	},
	{ // 4
		mapBytes4, // pBytes
		8,SkyElements4,
		21,GroundElements4,
	},
	{ // 5
		mapBytes5, // pBytes
		8,SkyElements5,
		26,GroundElements5,
	},
	{ // 6
		mapBytes6, // pBytes
		8,SkyElements6,
		23,GroundElements6,
	},
	{ // 7
		mapBytes7, // pBytes
		0,SkyElements7,
		30,GroundElements7,
	},
};
