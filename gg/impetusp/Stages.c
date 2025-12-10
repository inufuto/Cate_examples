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
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
		},
	},
	{ // 2
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 4, 
		},
	},
	{ // 3
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 4
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 5
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
		},
	},
	{ // 6
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
		},
	},
	{ // 7
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
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
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 10
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 11
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
		},
	},
	{ // 12
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
		},
	},
	{ // 13
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 14
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 15
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 16
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 0, 
		},
	},
	{ // 17
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 18
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 19
		{ // chars
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 0, 
		},
	},
	{ // 20
		{ // chars
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
		},
	},
	{ // 21
		{ // chars
			Char_Terrain + 7, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 13, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 17, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 18, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 15, 
		},
	},
	{ // 22
		{ // chars
			Char_Terrain + 7, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 13, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 17, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 23
		{ // chars
			Char_Terrain + 7, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 18, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 24
		{ // chars
			Char_Terrain + 7, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 25
		{ // chars
			Char_Terrain + 7, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 18, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 26
		{ // chars
			Char_Terrain + 7, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 27
		{ // chars
			Char_Terrain + 4, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, 
			Char_Terrain + 22, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 28
		{ // chars
			Char_Terrain + 4, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 22, 
			Char_Terrain + 22, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 29
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 13, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 17, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 15, 
		},
	},
	{ // 30
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 13, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 17, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 31
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 32
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 16, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 33
		{ // chars
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 3, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 23, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 34
		{ // chars
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 35
		{ // chars
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 22, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 36
		{ // chars
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 22, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 19, 
		},
	},
	{ // 37
		{ // chars
			Char_Terrain + 24, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 24, 
			Char_Terrain + 19, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 19, 
		},
	},
	{ // 38
		{ // chars
			Char_Terrain + 17, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 16, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 39
		{ // chars
			Char_Terrain + 23, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 3, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 23, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 40
		{ // chars
			Char_Terrain + 23, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 41
		{ // chars
			Char_Terrain + 23, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 22, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 42
		{ // chars
			Char_Terrain + 8, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 43
		{ // chars
			Char_Terrain + 8, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 44
		{ // chars
			Char_Terrain + 8, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 45
		{ // chars
			Char_Terrain + 8, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 46
		{ // chars
			Char_Terrain + 8, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 47
		{ // chars
			Char_Terrain + 8, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 48
		{ // chars
			Char_Terrain + 8, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 18, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 49
		{ // chars
			Char_Terrain + 2, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 50
		{ // chars
			Char_Terrain + 2, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 51
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 52
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 53
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 54
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 55
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 18, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 56
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 18, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
		},
	},
	{ // 57
		{ // chars
			Char_Terrain + 15, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 58
		{ // chars
			Char_Terrain + 15, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 18, 
			Char_Terrain + 5, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 13, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
		},
	},
	{ // 59
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 18, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 15, 
		},
	},
	{ // 60
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 18, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 61
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 15, 
		},
	},
	{ // 62
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 63
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 64
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 65
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 66
		{ // chars
			Char_Terrain + 6, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 67
		{ // chars
			Char_Terrain + 1, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 68
		{ // chars
			Char_Terrain + 1, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 69
		{ // chars
			Char_Terrain + 1, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 9, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 70
		{ // chars
			Char_Terrain + 1, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 9, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 4, 
		},
	},
	{ // 71
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 9, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 72
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 1, 
		},
	},
	{ // 73
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
		},
	},
	{ // 74
		{ // chars
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 20, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 20, 
			Char_Terrain + 25, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 25, 
			Char_Terrain + 21, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 21, 
		},
	},
	{ // 75
		{ // chars
			Char_Terrain + 30, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
		},
	},
	{ // 76
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 0, 
		},
	},
	{ // 77
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 26, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 25, 
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 27, 
		},
	},
	{ // 78
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
		},
	},
};

static const byte[] mapBytes0 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	23, 12, 12, 11, 0, 45, 78, 78, 
	77, 9, 9, 0, 0, 0, 1, 24, 
	31, 30, 0, 25, 62, 62, 61, 0, 
	45, 53, 53, 51, 0, 5, 0, 34, 
	33, 0, 19, 0, 73, 73, 3, 0, 
	0, 73, 73, 40, 33, 0, 73, 73, 
	73, 73, 3, 73, 73, 73, 73, 40, 
	73, 73, 70, 73, 73, 73, 73, 41, 
	73, 73, 73, 73, 73, 72, 68, 73, 
	72, 68, 63, 0, 64, 63, 0, 0, 
	0, 9, 9, 9, 9, 9, 0, 1, 
	22, 0, 0, 0, 25, 61, 4, 9, 
	0, 45, 51, 13, 0, 9, 9, 9, 
	17, 0, 0, 0, 0, 13, 0, 0, 
	0, 0, 13, 0, 9, 9, 9, 17, 
	0, 0, 0, 0, 13, 0, 0, 23, 
	29, 14, 9, 0, 45, 51, 0, 0, 

};
static const byte[] mapBytes1 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 9, 9, 9, 9, 8, 0, 0, 
	24, 30, 13, 0, 0, 60, 61, 13, 
	9, 9, 47, 52, 16, 0, 0, 0, 
	0, 0, 0, 2, 27, 34, 34, 2, 
	28, 73, 73, 73, 35, 73, 73, 73, 
	73, 73, 73, 73, 73, 73, 73, 73, 
	70, 73, 68, 73, 73, 41, 73, 3, 
	73, 73, 73, 73, 40, 73, 73, 73, 
	73, 73, 64, 65, 71, 73, 73, 0, 
	0, 50, 73, 73, 0, 0, 0, 73, 
	68, 4, 9, 9, 74, 9, 13, 24, 
	30, 73, 24, 13, 60, 62, 73, 62, 
	13, 45, 53, 73, 60, 15, 9, 9, 
	74, 47, 13, 0, 2, 73, 0, 37, 
	34, 36, 73, 23, 66, 64, 66, 64, 
	45, 13, 0, 13, 0, 0, 14, 9, 
	18, 9, 9, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes2 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 4, 9, 9, 9, 0, 13, 
	0, 23, 31, 0, 13, 0, 45, 53, 
	9, 18, 9, 9, 9, 30, 0, 0, 
	0, 0, 61, 0, 2, 27, 34, 51, 
	2, 28, 73, 73, 0, 28, 73, 73, 
	73, 0, 73, 73, 73, 73, 0, 73, 
	73, 73, 73, 0, 73, 73, 73, 73, 
	0, 71, 73, 73, 73, 0, 50, 71, 
	73, 73, 0, 0, 50, 73, 73, 9, 
	8, 0, 73, 73, 0, 13, 0, 73, 
	68, 30, 15, 9, 74, 9, 62, 13, 
	0, 73, 0, 62, 13, 0, 73, 0, 
	61, 15, 9, 74, 9, 51, 13, 2, 
	73, 0, 34, 37, 35, 72, 0, 64, 
	66, 64, 63, 0, 9, 17, 24, 31, 
	31, 0, 13, 60, 62, 62, 29, 14, 
	47, 54, 54, 51, 0, 0, 0, 0, 

};
static const byte[] mapBytes3 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 23, 
	31, 0, 0, 0, 48, 60, 9, 9, 
	9, 8, 45, 1, 24, 30, 13, 0, 
	32, 62, 62, 15, 9, 62, 58, 62, 
	13, 0, 62, 38, 62, 15, 9, 62, 
	62, 61, 13, 0, 53, 53, 51, 13, 
	0, 0, 23, 30, 15, 9, 0, 48, 
	59, 13, 0, 34, 33, 43, 13, 0, 
	73, 73, 40, 37, 34, 73, 72, 68, 
	66, 64, 72, 67, 0, 15, 9, 63, 
	0, 0, 13, 0, 0, 0, 0, 15, 
	9, 9, 9, 9, 17, 23, 0, 0, 
	0, 13, 45, 30, 4, 9, 17, 23, 
	61, 13, 0, 13, 45, 52, 17, 0, 
	13, 24, 0, 15, 9, 17, 60, 29, 
	13, 0, 13, 45, 52, 17, 0, 13, 
	0, 0, 13, 0, 13, 0, 0, 14, 
	9, 18, 9, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes4 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 9, 9, 9, 10, 9, 31, 30, 
	0, 13, 0, 62, 61, 0, 13, 24, 
	54, 52, 9, 16, 60, 0, 0, 0, 
	0, 45, 2, 27, 34, 33, 3, 35, 
	73, 73, 73, 40, 73, 73, 73, 73, 
	73, 73, 73, 73, 73, 73, 73, 73, 
	73, 73, 73, 73, 73, 70, 73, 73, 
	73, 73, 41, 73, 73, 73, 73, 73, 
	73, 73, 73, 73, 73, 73, 73, 65, 
	73, 72, 69, 71, 0, 73, 67, 0, 
	49, 9, 74, 9, 9, 9, 30, 73, 
	24, 30, 0, 53, 73, 60, 61, 0, 
	9, 74, 47, 52, 9, 2, 73, 0, 
	0, 0, 36, 72, 0, 5, 0, 66, 
	63, 0, 19, 0, 13, 22, 0, 0, 
	0, 13, 59, 0, 4, 9, 14, 44, 
	9, 16, 0, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes5 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 22, 
	0, 12, 11, 0, 59, 0, 78, 77, 
	9, 44, 9, 0, 0, 1, 24, 31, 
	30, 0, 26, 62, 62, 61, 0, 60, 
	62, 62, 51, 0, 45, 55, 60, 33, 
	0, 7, 11, 45, 73, 3, 20, 76, 
	0, 73, 39, 3, 0, 0, 73, 73, 
	39, 3, 23, 73, 73, 73, 39, 46, 
	73, 70, 73, 73, 40, 73, 41, 73, 
	72, 68, 73, 73, 72, 67, 0, 72, 
	68, 63, 0, 0, 63, 0, 0, 0, 
	0, 9, 9, 9, 9, 9, 0, 0, 
	0, 0, 0, 0, 0, 0, 4, 9, 
	9, 9, 9, 17, 24, 0, 0, 0, 
	13, 60, 12, 11, 0, 15, 47, 78, 
	76, 0, 13, 0, 0, 0, 0, 13, 
	0, 9, 9, 9, 17, 0, 31, 29, 
	0, 14, 9, 53, 51, 0, 0, 0, 

};
static const byte[] mapBytes6 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 24, 29, 0, 
	0, 0, 59, 57, 4, 9, 0, 42, 
	0, 13, 0, 0, 0, 0, 13, 0, 
	9, 10, 9, 18, 9, 0, 13, 21, 
	0, 0, 0, 13, 42, 0, 27, 0, 
	13, 0, 2, 73, 9, 17, 0, 28, 
	73, 0, 13, 0, 73, 73, 0, 13, 
	0, 73, 73, 9, 17, 0, 73, 73, 
	0, 13, 0, 73, 73, 0, 13, 0, 
	71, 73, 0, 13, 0, 49, 64, 9, 
	18, 9, 8, 0, 31, 30, 0, 13, 
	0, 62, 62, 0, 15, 9, 62, 62, 
	0, 13, 0, 62, 62, 0, 13, 0, 
	62, 61, 0, 15, 9, 53, 51, 0, 
	13, 0, 34, 34, 34, 37, 34, 64, 
	64, 64, 66, 64, 9, 9, 9, 17, 
	24, 0, 22, 0, 13, 60, 0, 59, 
	0, 14, 47, 0, 42, 0, 0, 0, 

};
static const byte[] mapBytes7 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 30, 0, 0, 6, 
	12, 61, 0, 0, 0, 75, 52, 9, 
	9, 8, 0, 31, 30, 0, 13, 0, 
	62, 62, 0, 15, 9, 56, 62, 0, 
	13, 0, 32, 62, 0, 15, 9, 62, 
	62, 0, 13, 0, 62, 61, 0, 13, 
	0, 62, 57, 0, 14, 9, 61, 0, 
	0, 0, 0, 51, 0, 0, 0, 0, 
	34, 34, 34, 34, 34, 64, 64, 64, 
	64, 64, 0, 4, 9, 9, 9, 0, 
	13, 0, 0, 0, 0, 15, 9, 9, 
	9, 9, 17, 0, 0, 0, 0, 13, 
	0, 24, 31, 9, 17, 0, 62, 62, 
	0, 13, 0, 62, 62, 0, 13, 0, 
	62, 62, 9, 17, 1, 62, 62, 0, 
	13, 26, 62, 62, 0, 13, 62, 58, 
	62, 0, 13, 60, 38, 62, 9, 18, 
	47, 54, 54, 0, 0, 0, 0, 0, 

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
