#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 1
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 15, 
		},
	},
	{ // 2
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 16, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 3
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 16, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 15, 
		},
	},
	{ // 4
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 5
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
		},
	},
	{ // 6
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 16, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
	},
	{ // 7
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 16, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 8
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 9
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
		},
	},
	{ // 10
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
		},
	},
	{ // 11
		{ // chars
			Char_Terrain + 15, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 4, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 2, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 12
		{ // chars
			Char_Terrain + 15, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 16, 
			Char_Terrain + 4, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 2, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
	},
	{ // 13
		{ // chars
			Char_Terrain + 15, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 14
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 12, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 15
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 16
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 13, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 17
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 13, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 15, 
		},
	},
	{ // 18
		{ // chars
			Char_Terrain + 20, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 22, 
			Char_Terrain + 22, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 21, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 19
		{ // chars
			Char_Terrain + 20, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 22, 
			Char_Terrain + 22, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 20
		{ // chars
			Char_Terrain + 20, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 22, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 21
		{ // chars
			Char_Terrain + 1, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 22
		{ // chars
			Char_Terrain + 1, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 12, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 23
		{ // chars
			Char_Terrain + 1, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 2, 
			Char_Terrain + 12, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 13, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 24
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
	},
	{ // 25
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
	},
	{ // 26
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 27
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 5, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 28
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 2, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 29
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
		},
	},
	{ // 30
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
		},
	},
	{ // 31
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 32
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
		},
	},
	{ // 33
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
		},
	},
	{ // 34
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
		},
	},
	{ // 35
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
		},
	},
	{ // 36
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 37
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
		},
	},
	{ // 38
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
		},
	},
	{ // 39
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 0, 
		},
	},
	{ // 40
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 41
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
		},
	},
	{ // 42
		{ // chars
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 43
		{ // chars
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
		},
	},
	{ // 44
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 22, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 45
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 5, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 23, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 46
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 47
		{ // chars
			Char_Terrain + 19, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 19, 
			Char_Terrain + 17, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 17, 
		},
	},
	{ // 48
		{ // chars
			Char_Terrain + 23, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 5, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 23, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 49
		{ // chars
			Char_Terrain + 23, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 50
		{ // chars
			Char_Terrain + 13, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 12, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 51
		{ // chars
			Char_Terrain + 13, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 52
		{ // chars
			Char_Terrain + 13, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 13, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 53
		{ // chars
			Char_Terrain + 13, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 13, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 15, 
		},
	},
	{ // 54
		{ // chars
			Char_Terrain + 7, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 55
		{ // chars
			Char_Terrain + 7, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 56
		{ // chars
			Char_Terrain + 7, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
	},
	{ // 57
		{ // chars
			Char_Terrain + 7, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 58
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 59
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 5, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 60
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
		},
	},
	{ // 61
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 16, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 62
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 63
		{ // chars
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 64
		{ // chars
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 65
		{ // chars
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
	},
	{ // 66
		{ // chars
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 67
		{ // chars
			Char_Terrain + 9, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 68
		{ // chars
			Char_Terrain + 6, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 69
		{ // chars
			Char_Terrain + 6, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 70
		{ // chars
			Char_Terrain + 6, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 5, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 71
		{ // chars
			Char_Terrain + 6, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 21, 
			Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 72
		{ // chars
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 21, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 6, 
		},
	},
	{ // 73
		{ // chars
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 21, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 74
		{ // chars
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 6, 
		},
	},
	{ // 75
		{ // chars
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
		},
	},
	{ // 76
		{ // chars
			Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 17, 
			Char_Terrain + 18, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 18, 
			Char_Terrain + 25, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 25, 
			Char_Terrain + 24, Char_Terrain + 17, Char_Terrain + 17, Char_Terrain + 24, 
		},
	},
	{ // 77
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 0, 
		},
	},
	{ // 78
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
		},
	},
	{ // 79
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 27, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 25, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 26, 
		},
	},
	{ // 80
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 81
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
		},
	},
};

static const byte[] mapBytes0 = {
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 22, 
	35, 35, 35, 34, 26, 26, 26, 2, 
	81, 81, 81, 78, 26, 26, 26, 58, 
	80, 80, 80, 79, 32, 32, 32, 32, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	15, 15, 16, 26, 26, 26, 25, 22, 
	0, 0, 0, 26, 26, 22, 14, 0, 
	0, 0, 1, 26, 26, 0, 0, 11, 
	4, 4, 8, 26, 26, 0, 0, 51, 
	46, 45, 26, 26, 26, 2, 0, 0, 
	75, 75, 27, 26, 26, 61, 2, 0, 
	75, 75, 48, 26, 30, 34, 61, 2, 
	75, 75, 75, 27, 42, 77, 26, 58, 
	75, 75, 75, 48, 27, 26, 26, 26, 
	75, 75, 75, 75, 48, 27, 26, 22, 
	75, 75, 75, 75, 75, 48, 27, 2, 
	75, 75, 75, 75, 75, 75, 48, 59, 
	75, 75, 75, 75, 75, 75, 75, 49, 
	75, 75, 75, 70, 65, 75, 75, 75, 
	75, 75, 75, 49, 44, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 69, 
	75, 75, 75, 75, 75, 75, 74, 26, 
	75, 75, 74, 69, 64, 64, 63, 30, 
	66, 72, 68, 26, 22, 16, 26, 43, 
	26, 54, 26, 26, 2, 1, 26, 42, 
	26, 26, 26, 26, 58, 8, 26, 26, 
	32, 32, 32, 32, 32, 32, 32, 32, 
	26, 26, 25, 22, 16, 26, 26, 26, 
	26, 26, 21, 0, 1, 26, 29, 32, 
	26, 26, 2, 1, 13, 26, 36, 26, 
	26, 26, 58, 8, 26, 26, 36, 26, 
	32, 32, 32, 32, 32, 32, 40, 26, 
	26, 26, 26, 26, 26, 26, 36, 26, 
	26, 26, 30, 34, 26, 26, 36, 26, 
	26, 26, 43, 78, 26, 23, 36, 26, 
	26, 26, 42, 77, 26, 3, 36, 26, 
	26, 26, 26, 26, 26, 62, 36, 26, 
	32, 32, 32, 32, 32, 32, 40, 26, 
	26, 26, 22, 15, 16, 26, 36, 26, 
	26, 26, 0, 0, 0, 26, 37, 32, 
	26, 26, 2, 0, 1, 26, 26, 26, 
	26, 26, 58, 4, 8, 26, 26, 26, 

};
static const byte[] mapBytes1 = {
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	32, 32, 32, 32, 32, 32, 32, 31, 
	26, 26, 26, 26, 26, 26, 26, 36, 
	26, 26, 26, 22, 15, 16, 26, 36, 
	26, 26, 26, 2, 0, 1, 26, 36, 
	26, 26, 26, 58, 4, 8, 26, 36, 
	32, 32, 32, 32, 32, 32, 32, 39, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 24, 20, 46, 46, 46, 
	26, 20, 46, 44, 75, 75, 75, 75, 
	26, 75, 75, 75, 75, 75, 75, 75, 
	24, 75, 75, 75, 75, 75, 75, 75, 
	44, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 69, 66, 75, 75, 75, 75, 
	75, 75, 27, 24, 75, 75, 74, 69, 
	75, 75, 49, 44, 75, 75, 68, 26, 
	75, 75, 75, 75, 75, 75, 27, 26, 
	75, 75, 75, 75, 75, 75, 49, 46, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	64, 66, 73, 75, 75, 75, 75, 75, 
	26, 26, 57, 73, 75, 75, 75, 75, 
	26, 26, 26, 57, 73, 75, 75, 75, 
	26, 26, 22, 16, 57, 75, 74, 69, 
	26, 26, 2, 1, 26, 75, 68, 26, 
	26, 26, 58, 8, 26, 75, 26, 26, 
	29, 32, 32, 32, 32, 76, 32, 32, 
	36, 26, 22, 16, 26, 75, 22, 15, 
	36, 26, 2, 1, 26, 75, 0, 0, 
	36, 26, 58, 8, 26, 75, 0, 0, 
	36, 26, 26, 26, 26, 75, 2, 0, 
	36, 26, 26, 26, 26, 75, 58, 4, 
	38, 32, 32, 33, 32, 76, 32, 32, 
	36, 26, 26, 36, 24, 75, 26, 26, 
	47, 46, 46, 47, 44, 74, 26, 22, 
	67, 64, 64, 67, 64, 63, 26, 2, 
	36, 22, 16, 36, 22, 16, 26, 58, 
	36, 2, 1, 36, 2, 1, 26, 26, 
	36, 58, 8, 36, 58, 8, 26, 26, 
	37, 32, 32, 41, 32, 32, 32, 32, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 

};
static const byte[] mapBytes2 = {
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	15, 16, 26, 26, 26, 26, 26, 26, 
	0, 1, 26, 26, 26, 26, 26, 26, 
	4, 9, 32, 32, 32, 32, 32, 32, 
	26, 36, 26, 26, 26, 26, 26, 26, 
	26, 36, 26, 26, 26, 22, 15, 15, 
	26, 36, 26, 26, 26, 2, 0, 0, 
	26, 36, 26, 26, 26, 58, 4, 4, 
	32, 41, 32, 32, 32, 32, 32, 32, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	15, 16, 26, 26, 26, 24, 20, 46, 
	0, 1, 26, 20, 46, 44, 75, 75, 
	4, 8, 26, 75, 75, 75, 75, 75, 
	16, 26, 24, 75, 75, 75, 75, 75, 
	1, 26, 19, 75, 75, 75, 75, 75, 
	8, 24, 75, 75, 75, 75, 75, 75, 
	26, 18, 75, 75, 75, 75, 75, 75, 
	26, 56, 75, 75, 75, 75, 75, 75, 
	26, 19, 75, 75, 75, 75, 75, 75, 
	26, 75, 75, 75, 75, 75, 75, 75, 
	26, 73, 75, 75, 75, 75, 75, 75, 
	26, 57, 73, 75, 75, 75, 75, 75, 
	15, 16, 55, 66, 73, 75, 75, 75, 
	0, 1, 26, 26, 57, 73, 75, 75, 
	5, 10, 31, 26, 26, 57, 75, 75, 
	26, 26, 36, 26, 22, 16, 75, 69, 
	26, 26, 36, 26, 2, 0, 75, 26, 
	16, 26, 36, 26, 58, 4, 75, 26, 
	0, 26, 38, 32, 32, 32, 76, 32, 
	0, 26, 36, 26, 22, 16, 75, 26, 
	0, 26, 36, 26, 2, 0, 75, 26, 
	0, 26, 36, 26, 58, 4, 75, 26, 
	1, 26, 36, 26, 26, 26, 75, 26, 
	8, 26, 38, 32, 33, 32, 76, 32, 
	26, 26, 36, 26, 36, 24, 75, 26, 
	46, 46, 47, 46, 47, 44, 74, 26, 
	64, 64, 67, 64, 67, 64, 63, 26, 
	26, 26, 36, 23, 36, 23, 28, 26, 
	32, 32, 40, 0, 36, 0, 51, 15, 
	26, 26, 36, 3, 36, 2, 0, 0, 
	26, 26, 36, 62, 36, 58, 4, 4, 
	15, 16, 37, 32, 41, 32, 32, 32, 
	0, 1, 26, 26, 26, 26, 26, 26, 
	4, 8, 26, 26, 26, 26, 26, 26, 

};
static const byte[] mapBytes3 = {
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 22, 16, 26, 22, 15, 15, 15, 
	26, 2, 1, 26, 2, 0, 0, 0, 
	26, 58, 8, 26, 58, 4, 4, 4, 
	32, 32, 32, 32, 32, 32, 31, 26, 
	26, 26, 26, 26, 26, 26, 36, 26, 
	25, 22, 15, 16, 28, 26, 36, 26, 
	14, 0, 0, 0, 52, 26, 38, 32, 
	0, 11, 6, 0, 0, 26, 36, 26, 
	0, 51, 14, 0, 0, 26, 36, 26, 
	0, 0, 0, 0, 1, 26, 38, 32, 
	0, 0, 0, 0, 13, 26, 36, 26, 
	7, 2, 0, 1, 26, 26, 36, 26, 
	26, 58, 4, 8, 26, 26, 36, 26, 
	26, 26, 26, 26, 26, 26, 36, 26, 
	26, 26, 22, 16, 28, 26, 38, 32, 
	26, 26, 2, 0, 52, 26, 36, 26, 
	45, 27, 61, 2, 1, 26, 36, 26, 
	75, 48, 27, 58, 8, 26, 36, 26, 
	75, 75, 49, 46, 46, 46, 47, 46, 
	75, 74, 69, 64, 64, 64, 67, 64, 
	75, 68, 26, 26, 29, 32, 41, 32, 
	74, 26, 26, 26, 36, 26, 26, 26, 
	63, 30, 34, 26, 36, 26, 26, 26, 
	26, 43, 78, 26, 38, 32, 32, 32, 
	26, 42, 77, 26, 36, 26, 26, 26, 
	26, 26, 26, 26, 36, 26, 22, 15, 
	32, 32, 32, 32, 40, 26, 2, 0, 
	26, 26, 26, 26, 36, 26, 58, 4, 
	26, 29, 32, 32, 40, 26, 25, 22, 
	16, 36, 26, 26, 36, 25, 21, 0, 
	1, 36, 22, 16, 36, 21, 0, 0, 
	8, 36, 2, 1, 36, 0, 0, 11, 
	32, 40, 58, 8, 36, 2, 0, 51, 
	26, 38, 32, 32, 40, 61, 2, 0, 
	16, 36, 26, 26, 36, 26, 61, 2, 
	1, 36, 26, 26, 36, 26, 26, 58, 
	10, 40, 26, 26, 36, 22, 16, 26, 
	26, 36, 26, 26, 36, 2, 1, 26, 
	26, 36, 26, 26, 36, 58, 8, 26, 
	26, 37, 32, 32, 41, 32, 32, 32, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 

};
static const byte[] mapBytes4 = {
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	32, 32, 32, 32, 33, 32, 32, 32, 
	26, 26, 26, 26, 36, 26, 26, 26, 
	15, 15, 16, 26, 36, 26, 26, 26, 
	0, 0, 1, 26, 36, 26, 26, 26, 
	4, 4, 8, 26, 36, 26, 26, 22, 
	32, 32, 32, 32, 39, 26, 26, 0, 
	26, 26, 26, 26, 26, 26, 26, 2, 
	24, 20, 46, 46, 46, 45, 27, 58, 
	44, 75, 75, 75, 75, 75, 49, 46, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 74, 71, 73, 75, 75, 
	75, 75, 75, 68, 26, 57, 75, 75, 
	75, 75, 75, 27, 26, 24, 75, 75, 
	75, 75, 75, 49, 46, 44, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	66, 73, 75, 75, 74, 69, 66, 73, 
	26, 57, 75, 74, 68, 26, 26, 55, 
	26, 26, 75, 68, 26, 26, 26, 26, 
	26, 26, 75, 26, 26, 26, 26, 26, 
	32, 32, 76, 32, 32, 32, 32, 32, 
	16, 26, 75, 22, 15, 15, 16, 26, 
	1, 26, 75, 0, 0, 0, 0, 26, 
	8, 26, 75, 0, 0, 0, 0, 26, 
	26, 26, 75, 2, 0, 0, 1, 26, 
	29, 32, 76, 60, 5, 5, 10, 32, 
	36, 24, 75, 26, 26, 26, 26, 26, 
	47, 44, 74, 26, 26, 30, 34, 26, 
	67, 64, 63, 23, 26, 43, 78, 26, 
	36, 26, 26, 3, 26, 42, 77, 26, 
	36, 23, 28, 62, 26, 26, 26, 26, 
	36, 2, 53, 26, 26, 29, 32, 32, 
	36, 58, 8, 26, 26, 36, 26, 26, 
	37, 32, 32, 32, 32, 39, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 

};
static const byte[] mapBytes5 = {
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 22, 16, 26, 
	35, 34, 26, 26, 26, 2, 1, 26, 
	81, 78, 26, 26, 26, 58, 8, 26, 
	80, 79, 32, 32, 32, 32, 32, 32, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	16, 26, 26, 26, 25, 22, 15, 15, 
	0, 26, 26, 22, 14, 0, 0, 0, 
	1, 26, 26, 0, 0, 11, 6, 0, 
	8, 26, 26, 0, 0, 51, 14, 0, 
	26, 26, 26, 2, 0, 0, 0, 0, 
	26, 26, 26, 61, 2, 0, 0, 0, 
	45, 26, 30, 34, 61, 2, 0, 0, 
	75, 27, 42, 77, 26, 58, 4, 4, 
	75, 48, 27, 26, 26, 26, 26, 26, 
	75, 75, 48, 27, 26, 26, 22, 15, 
	75, 75, 75, 48, 27, 26, 2, 0, 
	75, 75, 75, 75, 48, 27, 61, 2, 
	75, 75, 75, 75, 75, 48, 27, 58, 
	75, 70, 65, 75, 75, 75, 49, 46, 
	75, 49, 44, 75, 75, 74, 69, 64, 
	75, 75, 75, 75, 75, 68, 26, 26, 
	75, 75, 75, 75, 74, 26, 26, 26, 
	74, 69, 64, 64, 63, 30, 34, 26, 
	63, 26, 22, 16, 26, 43, 78, 26, 
	26, 26, 2, 1, 26, 42, 77, 26, 
	26, 26, 58, 8, 26, 26, 26, 26, 
	32, 32, 32, 32, 32, 32, 32, 32, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 29, 32, 32, 
	26, 26, 26, 22, 16, 36, 26, 26, 
	26, 26, 26, 2, 1, 36, 22, 15, 
	32, 32, 32, 60, 10, 40, 2, 0, 
	26, 26, 26, 26, 26, 36, 58, 4, 
	35, 34, 26, 26, 26, 38, 32, 32, 
	81, 78, 26, 22, 16, 36, 26, 26, 
	80, 77, 26, 2, 1, 36, 26, 26, 
	26, 26, 26, 58, 8, 36, 26, 26, 
	32, 32, 32, 32, 32, 40, 26, 26, 
	15, 15, 16, 26, 26, 36, 26, 26, 
	0, 0, 0, 26, 26, 37, 32, 32, 
	0, 0, 1, 26, 26, 26, 26, 26, 
	4, 4, 8, 26, 26, 26, 26, 26, 

};
static const byte[] mapBytes6 = {
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 25, 22, 16, 26, 26, 26, 26, 
	26, 21, 0, 0, 26, 26, 26, 26, 
	26, 0, 0, 0, 26, 29, 32, 32, 
	26, 2, 0, 1, 26, 36, 26, 26, 
	26, 58, 4, 8, 26, 36, 26, 26, 
	26, 26, 26, 26, 26, 36, 26, 26, 
	26, 26, 26, 26, 26, 36, 26, 26, 
	32, 32, 33, 32, 32, 41, 32, 32, 
	26, 26, 36, 26, 26, 26, 26, 26, 
	26, 26, 36, 26, 22, 16, 26, 26, 
	26, 26, 36, 26, 2, 1, 26, 20, 
	26, 26, 36, 26, 58, 8, 26, 75, 
	26, 26, 36, 22, 16, 26, 24, 75, 
	32, 32, 40, 2, 1, 26, 19, 75, 
	26, 26, 36, 58, 8, 24, 75, 75, 
	26, 26, 36, 26, 26, 18, 75, 75, 
	26, 26, 36, 26, 26, 56, 75, 75, 
	26, 26, 36, 26, 26, 19, 75, 75, 
	32, 32, 40, 26, 26, 75, 75, 75, 
	26, 26, 36, 26, 26, 73, 75, 75, 
	26, 26, 36, 26, 26, 57, 73, 75, 
	26, 26, 36, 26, 22, 16, 55, 64, 
	26, 26, 36, 26, 2, 1, 26, 26, 
	32, 32, 41, 32, 60, 10, 31, 26, 
	26, 26, 26, 26, 26, 26, 36, 26, 
	15, 16, 26, 26, 22, 16, 36, 26, 
	0, 0, 28, 26, 0, 0, 36, 26, 
	0, 0, 52, 26, 0, 0, 38, 32, 
	0, 0, 0, 26, 2, 1, 36, 26, 
	0, 0, 0, 28, 58, 8, 36, 26, 
	0, 0, 0, 52, 26, 26, 36, 26, 
	0, 0, 0, 1, 26, 26, 36, 26, 
	0, 0, 1, 13, 26, 26, 38, 32, 
	4, 4, 8, 26, 26, 26, 36, 26, 
	46, 46, 46, 46, 46, 46, 47, 46, 
	64, 64, 64, 64, 64, 64, 67, 64, 
	26, 26, 26, 26, 26, 26, 36, 22, 
	32, 32, 32, 32, 32, 32, 40, 0, 
	26, 26, 26, 26, 26, 26, 36, 2, 
	26, 22, 16, 26, 26, 26, 36, 58, 
	26, 2, 1, 26, 22, 16, 37, 32, 
	26, 58, 8, 26, 2, 1, 26, 26, 
	26, 26, 26, 26, 58, 8, 26, 26, 

};
static const byte[] mapBytes7 = {
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	16, 26, 26, 26, 26, 26, 26, 26, 
	1, 26, 26, 26, 26, 30, 34, 26, 
	8, 26, 26, 26, 26, 42, 77, 26, 
	32, 32, 32, 32, 31, 26, 26, 26, 
	16, 28, 26, 26, 38, 32, 32, 32, 
	0, 52, 28, 26, 36, 26, 26, 26, 
	0, 0, 52, 26, 38, 32, 32, 32, 
	6, 0, 0, 26, 36, 26, 26, 26, 
	14, 0, 0, 26, 36, 26, 26, 26, 
	0, 0, 1, 26, 38, 32, 32, 32, 
	0, 0, 13, 26, 36, 26, 26, 26, 
	0, 1, 26, 26, 36, 22, 16, 26, 
	1, 13, 26, 26, 36, 2, 1, 26, 
	8, 26, 26, 26, 36, 58, 8, 26, 
	16, 26, 26, 26, 37, 32, 32, 32, 
	0, 26, 26, 26, 26, 22, 16, 26, 
	1, 26, 26, 26, 26, 2, 1, 26, 
	8, 26, 26, 26, 26, 58, 8, 26, 
	46, 46, 46, 46, 46, 46, 46, 46, 
	64, 64, 64, 64, 64, 64, 64, 64, 
	26, 26, 29, 32, 32, 32, 32, 32, 
	26, 26, 36, 26, 26, 26, 26, 26, 
	34, 26, 36, 26, 26, 26, 26, 26, 
	78, 26, 38, 32, 32, 32, 32, 32, 
	77, 26, 36, 26, 26, 26, 26, 26, 
	26, 26, 36, 26, 22, 17, 26, 26, 
	32, 32, 40, 26, 3, 13, 26, 26, 
	26, 26, 36, 26, 62, 25, 22, 15, 
	32, 32, 40, 26, 25, 21, 0, 0, 
	26, 26, 36, 26, 21, 0, 0, 0, 
	15, 16, 36, 26, 0, 0, 0, 0, 
	0, 1, 36, 26, 0, 0, 12, 0, 
	4, 8, 36, 26, 2, 0, 50, 0, 
	32, 32, 40, 26, 61, 2, 0, 0, 
	26, 26, 36, 26, 26, 61, 0, 0, 
	26, 26, 36, 26, 26, 26, 2, 0, 
	26, 26, 36, 22, 16, 26, 61, 0, 
	26, 26, 36, 2, 1, 26, 26, 2, 
	26, 26, 36, 58, 8, 26, 26, 58, 
	32, 32, 41, 32, 32, 32, 32, 32, 
	26, 26, 26, 26, 26, 26, 26, 26, 
	26, 26, 26, 26, 26, 26, 26, 26, 

};

static const SkyElement[] SkyElements0 = {
	{ 47, 0x01 },
	{ 36, 0x00 },
	{ 35, 0x02 },
	{ 24, 0x00 },
	{ 23, 0x08 },
	{ 17, 0x00 },
	{ 16, 0x04 },
	{ 5, 0x00 },
	{ 4, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements1 = {
	{ 47, 0x01 },
	{ 35, 0x03 },
	{ 32, 0x02 },
	{ 28, 0x0a },
	{ 20, 0x08 },
	{ 13, 0x00 },
	{ 12, 0x04 },
	{ 7, 0x05 },
	{ 5, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements2 = {
	{ 47, 0x01 },
	{ 37, 0x03 },
	{ 29, 0x02 },
	{ 28, 0x0a },
	{ 17, 0x08 },
	{ 16, 0x0c },
	{ 13, 0x04 },
	{ 7, 0x05 },
	{ 5, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements3 = {
	{ 47, 0x01 },
	{ 41, 0x03 },
	{ 26, 0x02 },
	{ 19, 0x06 },
	{ 14, 0x04 },
	{ 7, 0x0c },
	{ 1, 0x08 },
	{ 0, 0x00 },
};

static const SkyElement[] SkyElements4 = {
	{ 47, 0x01 },
	{ 44, 0x03 },
	{ 27, 0x0b },
	{ 23, 0x0a },
	{ 22, 0x0e },
	{ 15, 0x06 },
	{ 11, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements5 = {
	{ 47, 0x01 },
	{ 46, 0x03 },
	{ 27, 0x0b },
	{ 25, 0x0f },
	{ 20, 0x0e },
	{ 17, 0x06 },
	{ 8, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements6 = {
	{ 47, 0x01 },
	{ 46, 0x03 },
	{ 28, 0x07 },
	{ 24, 0x0f },
	{ 17, 0x0e },
	{ 16, 0x06 },
	{ 6, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements7 = {
	{ 47, 0x01 },
	{ 46, 0x03 },
	{ 35, 0x07 },
	{ 14, 0x06 },
	{ 8, 0x0e },
	{ 4, 0x06 },
	{ 3, 0x04 },
	{ 0, 0x00 },
};


static const Route[] Route0B1 = {
	{ 1, 0, 24 },
	{ -1, 0, 26 },
};

static const Route[] Route0B2 = {
	{ -1, 0, 4 },
	{ 0, 1, 40 },
};

static const Route[] Route0B3 = {
	{ -1, 0, 30 },
};

static const Route[] Route0B5 = {
	{ -1, 0, 16 },
	{ 1, 0, 19 },
};

static const Route[] Route0B0 = {
	{ 1, 0, 24 },
	{ 0, 1, 8 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements0 = {
	{ // B0
		1, 43,
		3,
		Route0B0
	},
	{ // A16
		13, 41,
		0,
		nullptr
	},
	{ // A15
		9, 39,
		0,
		nullptr
	},
	{ // B1
		1, 37,
		2,
		Route0B1
	},
	{ // A13
		5, 35,
		0,
		nullptr
	},
	{ // B2
		29, 34,
		2,
		Route0B2
	},
	{ // B3
		29, 32,
		1,
		Route0B3
	},
	{ // A9
		9, 30,
		0,
		nullptr
	},
	{ // A10
		29, 30,
		0,
		nullptr
	},
	{ // A8
		29, 28,
		0,
		nullptr
	},
	{ // A7
		17, 24,
		0,
		nullptr
	},
	{ // A6
		21, 18,
		0,
		nullptr
	},
	{ // A5
		17, 17,
		0,
		nullptr
	},
	{ // A4
		9, 14,
		0,
		nullptr
	},
	{ // A3
		29, 13,
		0,
		nullptr
	},
	{ // B5
		29, 9,
		2,
		Route0B5
	},
	{ // A1
		9, 8,
		0,
		nullptr
	},
	{ // A0
		1, 7,
		0,
		nullptr
	},
};

static const Route[] Route1B1 = {
	{ 0, 1, 12 },
	{ 1, 0, 19 },
};

static const Route[] Route1B4 = {
	{ 1, 0, 28 },
	{ 0, -1, 20 },
	{ -1, 0, 30 },
};

static const Route[] Route1B2 = {
	{ -1, 0, 16 },
	{ 0, -1, 28 },
	{ -1, 0, 2 },
};

static const Route[] Route1B3 = {
	{ -1, 0, 16 },
	{ 0, 1, 28 },
};

static const Route[] Route1B5 = {
	{ 1, 0, 24 },
	{ -1, 0, 26 },
};

static const Route[] Route1B0 = {
	{ 0, 1, 16 },
	{ 1, 0, 31 },
};

static const GroundElement[] GroundElements1 = {
	{ // B1
		13, 42,
		2,
		Route1B1
	},
	{ // A16
		25, 42,
		0,
		nullptr
	},
	{ // B0
		1, 41,
		2,
		Route1B0
	},
	{ // B2
		17, 38,
		3,
		Route1B2
	},
	{ // A13
		13, 35,
		0,
		nullptr
	},
	{ // B3
		17, 32,
		2,
		Route1B3
	},
	{ // A11
		29, 30,
		0,
		nullptr
	},
	{ // A9
		5, 28,
		0,
		nullptr
	},
	{ // A8
		25, 22,
		0,
		nullptr
	},
	{ // A7
		13, 20,
		0,
		nullptr
	},
	{ // A6
		5, 13,
		0,
		nullptr
	},
	{ // B4
		1, 12,
		3,
		Route1B4
	},
	{ // A5
		25, 10,
		0,
		nullptr
	},
	{ // A4
		5, 9,
		0,
		nullptr
	},
	{ // A3
		25, 8,
		0,
		nullptr
	},
	{ // B5
		1, 7,
		2,
		Route1B5
	},
	{ // A0
		5, 6,
		0,
		nullptr
	},
};

static const Route[] Route2B1 = {
	{ 0, 1, 20 },
	{ 1, 0, 15 },
};

static const Route[] Route2B4 = {
	{ 1, 0, 31 },
};

static const Route[] Route2B0 = {
	{ -1, 0, 20 },
	{ 0, -1, 12 },
	{ -1, 0, 10 },
};

static const Route[] Route2B2 = {
	{ -1, 0, 12 },
	{ 0, -1, 36 },
	{ -1, 0, 10 },
};

static const Route[] Route2B3 = {
	{ -1, 0, 12 },
	{ 0, 1, 24 },
};

static const Route[] Route2B5 = {
	{ -1, 0, 24 },
	{ 0, 1, 20 },
	{ 1, 0, 27 },
};

static const GroundElement[] GroundElements2 = {
	{ // A24
		13, 46,
		0,
		nullptr
	},
	{ // B0
		29, 45,
		3,
		Route2B0
	},
	{ // A22
		25, 41,
		0,
		nullptr
	},
	{ // B1
		17, 40,
		2,
		Route2B1
	},
	{ // B2
		21, 37,
		3,
		Route2B2
	},
	{ // A20
		13, 35,
		0,
		nullptr
	},
	{ // A19
		5, 34,
		0,
		nullptr
	},
	{ // B3
		21, 32,
		2,
		Route2B3
	},
	{ // A17
		17, 31,
		0,
		nullptr
	},
	{ // A15
		13, 27,
		0,
		nullptr
	},
	{ // A14
		9, 26,
		0,
		nullptr
	},
	{ // A13
		1, 24,
		0,
		nullptr
	},
	{ // A12
		1, 22,
		0,
		nullptr
	},
	{ // A11
		5, 21,
		0,
		nullptr
	},
	{ // A10
		9, 17,
		0,
		nullptr
	},
	{ // B4
		1, 12,
		1,
		Route2B4
	},
	{ // A8
		13, 10,
		0,
		nullptr
	},
	{ // A7
		13, 9,
		0,
		nullptr
	},
	{ // A6
		17, 8,
		0,
		nullptr
	},
	{ // B5
		29, 7,
		3,
		Route2B5
	},
	{ // A4
		21, 5,
		0,
		nullptr
	},
	{ // A3
		29, 4,
		0,
		nullptr
	},
	{ // A2
		1, 3,
		0,
		nullptr
	},
	{ // A1
		29, 2,
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
	{ 0, -1, 32 },
	{ 1, 0, 12 },
	{ 0, 1, 44 },
};

static const Route[] Route3B4 = {
	{ -1, 0, 4 },
	{ 0, -1, 44 },
	{ -1, 0, 26 },
};

static const Route[] Route3B0 = {
	{ -1, 0, 24 },
	{ 0, -1, 28 },
	{ -1, 0, 6 },
};

static const Route[] Route3B2 = {
	{ 0, -1, 72 },
	{ 1, 0, 15 },
};

static const Route[] Route3B3 = {
	{ 1, 0, 16 },
	{ 0, -1, 12 },
	{ 1, 0, 15 },
};

static const Route[] Route3B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements3 = {
	{ // A27
		5, 47,
		0,
		nullptr
	},
	{ // A26
		29, 46,
		0,
		nullptr
	},
	{ // B0
		29, 45,
		3,
		Route3B0
	},
	{ // B2
		17, 44,
		2,
		Route3B2
	},
	{ // A25
		13, 43,
		0,
		nullptr
	},
	{ // B1
		1, 42,
		4,
		Route3B1
	},
	{ // A24
		9, 41,
		0,
		nullptr
	},
	{ // A23
		9, 38,
		0,
		nullptr
	},
	{ // A21
		29, 37,
		0,
		nullptr
	},
	{ // A19
		25, 33,
		0,
		nullptr
	},
	{ // B3
		1, 32,
		3,
		Route3B3
	},
	{ // A18
		9, 30,
		0,
		nullptr
	},
	{ // A16
		5, 29,
		0,
		nullptr
	},
	{ // A15
		9, 28,
		0,
		nullptr
	},
	{ // A13
		9, 26,
		0,
		nullptr
	},
	{ // A12
		21, 21,
		0,
		nullptr
	},
	{ // B4
		29, 20,
		3,
		Route3B4
	},
	{ // A11
		17, 19,
		0,
		nullptr
	},
	{ // A10
		17, 17,
		0,
		nullptr
	},
	{ // B5
		29, 15,
		3,
		Route3B5
	},
	{ // A9
		21, 14,
		0,
		nullptr
	},
	{ // A8
		9, 13,
		0,
		nullptr
	},
	{ // A6
		17, 11,
		0,
		nullptr
	},
	{ // A5
		29, 9,
		0,
		nullptr
	},
	{ // A3
		13, 8,
		0,
		nullptr
	},
	{ // A2
		17, 5,
		0,
		nullptr
	},
	{ // A1
		1, 4,
		0,
		nullptr
	},
	{ // A0
		29, 3,
		0,
		nullptr
	},
};

static const Route[] Route4B1 = {
	{ 0, -1, 4 },
	{ 1, 0, 31 },
};

static const Route[] Route4B0 = {
	{ -1, 0, 8 },
	{ 0, 1, 8 },
	{ -1, 0, 20 },
	{ 0, -1, 20 },
};

static const Route[] Route4B2 = {
	{ 1, 0, 19 },
};

static const Route[] Route4B3 = {
	{ 1, 0, 16 },
	{ 0, -1, 20 },
	{ -1, 0, 18 },
};

static const GroundElement[] GroundElements4 = {
	{ // A25
		9, 47,
		0,
		nullptr
	},
	{ // A24
		25, 46,
		0,
		nullptr
	},
	{ // A23
		17, 44,
		0,
		nullptr
	},
	{ // B0
		29, 43,
		4,
		Route4B0
	},
	{ // A21
		9, 41,
		0,
		nullptr
	},
	{ // A22
		25, 41,
		0,
		nullptr
	},
	{ // A20
		21, 40,
		0,
		nullptr
	},
	{ // A18
		25, 39,
		0,
		nullptr
	},
	{ // B1
		1, 38,
		2,
		Route4B1
	},
	{ // A16
		29, 34,
		0,
		nullptr
	},
	{ // A15
		5, 33,
		0,
		nullptr
	},
	{ // B2
		13, 32,
		1,
		Route4B2
	},
	{ // A13
		25, 31,
		0,
		nullptr
	},
	{ // A12
		21, 29,
		0,
		nullptr
	},
	{ // A11
		21, 23,
		0,
		nullptr
	},
	{ // A10
		13, 22,
		0,
		nullptr
	},
	{ // A9
		17, 21,
		0,
		nullptr
	},
	{ // B3
		1, 12,
		3,
		Route4B3
	},
	{ // A8
		25, 12,
		0,
		nullptr
	},
	{ // A7
		13, 10,
		0,
		nullptr
	},
	{ // A6
		29, 9,
		0,
		nullptr
	},
	{ // A4
		1, 6,
		0,
		nullptr
	},
	{ // A3
		1, 4,
		0,
		nullptr
	},
	{ // A2
		29, 3,
		0,
		nullptr
	},
	{ // A1
		29, 2,
		0,
		nullptr
	},
	{ // A0
		1, 1,
		0,
		nullptr
	},
};

static const Route[] Route5B1 = {
	{ -1, 0, 8 },
	{ 0, -1, 20 },
	{ 1, 0, 11 },
};

static const Route[] Route5B4 = {
	{ 1, 0, 31 },
};

static const Route[] Route5B0 = {
	{ -1, 0, 8 },
	{ 0, -1, 8 },
	{ -1, 0, 22 },
};

static const Route[] Route5B3 = {
	{ 1, 0, 20 },
	{ 0, 1, 28 },
};

static const Route[] Route5B5 = {
	{ 1, 0, 31 },
};

static const GroundElement[] GroundElements5 = {
	{ // A28
		5, 47,
		0,
		nullptr
	},
	{ // A27
		25, 46,
		0,
		nullptr
	},
	{ // B0
		29, 45,
		3,
		Route5B0
	},
	{ // A25
		1, 41,
		0,
		nullptr
	},
	{ // A24
		5, 40,
		0,
		nullptr
	},
	{ // A23
		1, 39,
		0,
		nullptr
	},
	{ // B1
		29, 39,
		3,
		Route5B1
	},
	{ // A22
		25, 38,
		0,
		nullptr
	},
	{ // B3
		1, 37,
		2,
		Route5B3
	},
	{ // A20
		9, 35,
		0,
		nullptr
	},
	{ // A18
		13, 33,
		0,
		nullptr
	},
	{ // B4
		1, 32,
		1,
		Route5B4
	},
	{ // A16
		21, 30,
		0,
		nullptr
	},
	{ // A15
		25, 29,
		0,
		nullptr
	},
	{ // A14
		21, 28,
		0,
		nullptr
	},
	{ // A13
		9, 24,
		0,
		nullptr
	},
	{ // A12
		25, 22,
		0,
		nullptr
	},
	{ // A11
		9, 18,
		0,
		nullptr
	},
	{ // A10
		13, 17,
		0,
		nullptr
	},
	{ // A9
		5, 14,
		0,
		nullptr
	},
	{ // A8
		25, 13,
		0,
		nullptr
	},
	{ // A7
		9, 10,
		0,
		nullptr
	},
	{ // B5
		1, 9,
		1,
		Route5B5
	},
	{ // A5
		1, 8,
		0,
		nullptr
	},
	{ // A4
		5, 7,
		0,
		nullptr
	},
	{ // A2
		1, 4,
		0,
		nullptr
	},
	{ // A3
		29, 4,
		0,
		nullptr
	},
	{ // A0
		1, 0,
		0,
		nullptr
	},
	{ // A1
		29, 0,
		0,
		nullptr
	},
};

static const Route[] Route6B1 = {
	{ -1, 0, 4 },
	{ 0, -1, 20 },
	{ 1, 0, 7 },
};

static const Route[] Route6B4 = {
	{ 1, 0, 8 },
	{ 0, -1, 24 },
	{ -1, 0, 10 },
};

static const Route[] Route6B0 = {
	{ 1, 0, 24 },
	{ 0, 1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route6B2 = {
	{ -1, 0, 26 },
};

static const Route[] Route6B3 = {
	{ 1, 0, 8 },
	{ 0, -1, 20 },
	{ -1, 0, 10 },
};

static const Route[] Route6B5 = {
	{ -1, 0, 8 },
	{ 0, -1, 20 },
	{ 1, 0, 11 },
};

static const GroundElement[] GroundElements6 = {
	{ // A23
		13, 47,
		0,
		nullptr
	},
	{ // A22
		17, 44,
		0,
		nullptr
	},
	{ // B0
		1, 42,
		3,
		Route6B0
	},
	{ // A20
		9, 41,
		0,
		nullptr
	},
	{ // A19
		29, 40,
		0,
		nullptr
	},
	{ // B1
		29, 37,
		3,
		Route6B1
	},
	{ // A18
		17, 36,
		0,
		nullptr
	},
	{ // A16
		13, 32,
		0,
		nullptr
	},
	{ // A15
		5, 29,
		0,
		nullptr
	},
	{ // B3
		1, 28,
		3,
		Route6B3
	},
	{ // B2
		25, 28,
		1,
		Route6B2
	},
	{ // A13
		1, 26,
		0,
		nullptr
	},
	{ // A11
		17, 21,
		0,
		nullptr
	},
	{ // A10
		1, 20,
		0,
		nullptr
	},
	{ // B4
		1, 18,
		3,
		Route6B4
	},
	{ // A9
		21, 16,
		0,
		nullptr
	},
	{ // A8
		5, 14,
		0,
		nullptr
	},
	{ // B5
		29, 12,
		3,
		Route6B5
	},
	{ // A6
		5, 11,
		0,
		nullptr
	},
	{ // A5
		9, 10,
		0,
		nullptr
	},
	{ // A4
		13, 9,
		0,
		nullptr
	},
	{ // A3
		17, 8,
		0,
		nullptr
	},
	{ // A1
		29, 1,
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
	{ 1, 0, 8 },
	{ 0, -1, 24 },
	{ -1, 0, 10 },
};

static const Route[] Route7B4 = {
	{ -1, 0, 20 },
	{ 0, 1, 52 },
};

static const Route[] Route7B7 = {
	{ -1, 0, 12 },
	{ 0, -1, 8 },
	{ 1, 0, 15 },
};

static const Route[] Route7B0 = {
	{ -1, 0, 30 },
};

static const Route[] Route7B8 = {
	{ 1, 0, 16 },
	{ 0, 1, 40 },
};

static const Route[] Route7B2 = {
	{ 1, 0, 8 },
	{ 0, 1, 40 },
};

static const Route[] Route7B3 = {
	{ 1, 0, 8 },
	{ 0, 1, 44 },
};

static const Route[] Route7B6 = {
	{ -1, 0, 12 },
	{ 0, -1, 20 },
	{ 1, 0, 15 },
};

static const Route[] Route7B5 = {
	{ -1, 0, 20 },
	{ 0, 1, 60 },
};

static const GroundElement[] GroundElements7 = {
	{ // A29
		25, 47,
		0,
		nullptr
	},
	{ // A28
		1, 46,
		0,
		nullptr
	},
	{ // B1
		1, 45,
		3,
		Route7B1
	},
	{ // B0
		29, 45,
		1,
		Route7B0
	},
	{ // A26
		17, 41,
		0,
		nullptr
	},
	{ // A25
		5, 40,
		0,
		nullptr
	},
	{ // A23
		5, 38,
		0,
		nullptr
	},
	{ // A22
		25, 37,
		0,
		nullptr
	},
	{ // B2
		1, 34,
		2,
		Route7B2
	},
	{ // A20
		17, 33,
		0,
		nullptr
	},
	{ // B3
		1, 32,
		2,
		Route7B3
	},
	{ // A17
		1, 30,
		0,
		nullptr
	},
	{ // A18
		25, 30,
		0,
		nullptr
	},
	{ // B4
		29, 29,
		2,
		Route7B4
	},
	{ // A14
		1, 28,
		0,
		nullptr
	},
	{ // A15
		25, 28,
		0,
		nullptr
	},
	{ // A13
		17, 27,
		0,
		nullptr
	},
	{ // B5
		29, 26,
		2,
		Route7B5
	},
	{ // A11
		5, 23,
		0,
		nullptr
	},
	{ // B6
		29, 20,
		3,
		Route7B6
	},
	{ // A10
		29, 16,
		0,
		nullptr
	},
	{ // A8
		13, 14,
		0,
		nullptr
	},
	{ // A7
		1, 13,
		0,
		nullptr
	},
	{ // B7
		29, 12,
		3,
		Route7B7
	},
	{ // A5
		9, 10,
		0,
		nullptr
	},
	{ // B8
		1, 9,
		2,
		Route7B8
	},
	{ // A3
		25, 8,
		0,
		nullptr
	},
	{ // A2
		21, 7,
		0,
		nullptr
	},
	{ // A0
		1, 5,
		0,
		nullptr
	},
	{ // A1
		29, 5,
		0,
		nullptr
	},
};


const Stage[] Stages = {
	{ // 0
		mapBytes0, // pBytes
		10,SkyElements0,
		18,GroundElements0,
	},
	{ // 1
		mapBytes1, // pBytes
		10,SkyElements1,
		17,GroundElements1,
	},
	{ // 2
		mapBytes2, // pBytes
		10,SkyElements2,
		25,GroundElements2,
	},
	{ // 3
		mapBytes3, // pBytes
		8,SkyElements3,
		28,GroundElements3,
	},
	{ // 4
		mapBytes4, // pBytes
		8,SkyElements4,
		26,GroundElements4,
	},
	{ // 5
		mapBytes5, // pBytes
		8,SkyElements5,
		29,GroundElements5,
	},
	{ // 6
		mapBytes6, // pBytes
		8,SkyElements6,
		24,GroundElements6,
	},
	{ // 7
		mapBytes7, // pBytes
		8,SkyElements7,
		30,GroundElements7,
	},
};
