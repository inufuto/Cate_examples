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
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 8, 
		},
	},
	{ // 2
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 5, 
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
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 4, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 5
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 6
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
		},
	},
	{ // 7
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 8
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 9
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 10
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
		},
	},
	{ // 11
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
		},
	},
	{ // 12
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 13
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 14
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 15
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 0, 
		},
	},
	{ // 16
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 27, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 17
		{ // chars
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 18
		{ // chars
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
		},
	},
	{ // 19
		{ // chars
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 0, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
		},
	},
	{ // 20
		{ // chars
			Char_Terrain + 8, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 1, 
			Char_Terrain + 16, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 17, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 21
		{ // chars
			Char_Terrain + 8, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 16, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 22
		{ // chars
			Char_Terrain + 8, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 23
		{ // chars
			Char_Terrain + 5, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 21, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 24
		{ // chars
			Char_Terrain + 5, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 24, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 25
		{ // chars
			Char_Terrain + 5, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 26
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 1, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 17, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 15, 
		},
	},
	{ // 27
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 1, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 17, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 28
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 29
		{ // chars
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 16, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 30
		{ // chars
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 4, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 22, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 31
		{ // chars
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 32
		{ // chars
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 21, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 33
		{ // chars
			Char_Terrain + 23, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 23, 
			Char_Terrain + 18, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 18, 
		},
	},
	{ // 34
		{ // chars
			Char_Terrain + 17, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 1, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 17, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 15, 
		},
	},
	{ // 35
		{ // chars
			Char_Terrain + 17, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 1, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 17, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 36
		{ // chars
			Char_Terrain + 17, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 37
		{ // chars
			Char_Terrain + 17, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 16, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 38
		{ // chars
			Char_Terrain + 22, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 4, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 22, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 39
		{ // chars
			Char_Terrain + 22, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 40
		{ // chars
			Char_Terrain + 9, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 41
		{ // chars
			Char_Terrain + 9, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 42
		{ // chars
			Char_Terrain + 9, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 4, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 43
		{ // chars
			Char_Terrain + 9, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 44
		{ // chars
			Char_Terrain + 9, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 45
		{ // chars
			Char_Terrain + 3, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 46
		{ // chars
			Char_Terrain + 3, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 47
		{ // chars
			Char_Terrain + 3, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 24, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 48
		{ // chars
			Char_Terrain + 3, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 24, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 5, 
		},
	},
	{ // 49
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 50
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 27, 
		},
	},
	{ // 51
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 6, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 52
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 53
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 54
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 55
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 8, 
		},
	},
	{ // 56
		{ // chars
			Char_Terrain + 15, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 57
		{ // chars
			Char_Terrain + 15, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 6, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 58
		{ // chars
			Char_Terrain + 15, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 10, 
			Char_Terrain + 6, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 8, 
		},
	},
	{ // 59
		{ // chars
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 10, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 15, 
		},
	},
	{ // 60
		{ // chars
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 10, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 61
		{ // chars
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 15, 
		},
	},
	{ // 62
		{ // chars
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 63
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 64
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 65
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 24, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 66
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 24, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 5, 
		},
	},
	{ // 67
		{ // chars
			Char_Terrain + 7, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 0, 
		},
	},
	{ // 68
		{ // chars
			Char_Terrain + 2, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 69
		{ // chars
			Char_Terrain + 2, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 11, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 70
		{ // chars
			Char_Terrain + 2, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 11, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 4, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 71
		{ // chars
			Char_Terrain + 2, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 24, 
			Char_Terrain + 11, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 72
		{ // chars
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 24, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 2, 
		},
	},
	{ // 73
		{ // chars
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 24, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 74
		{ // chars
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 2, 
		},
	},
	{ // 75
		{ // chars
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
		},
	},
	{ // 76
		{ // chars
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 20, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 20, 
			Char_Terrain + 25, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 25, 
			Char_Terrain + 19, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 19, 
		},
	},
	{ // 77
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 0, 
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
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 26, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 25, 
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 27, 
		},
	},
	{ // 80
		{ // chars
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, Char_Terrain + 28, 
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
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
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 21, 
	11, 11, 11, 10, 0, 0, 0, 60, 
	81, 81, 81, 78, 0, 0, 0, 41, 
	80, 80, 80, 79, 8, 8, 8, 8, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	28, 28, 27, 0, 0, 0, 1, 21, 
	62, 62, 62, 0, 0, 21, 29, 62, 
	62, 62, 61, 0, 0, 62, 62, 57, 
	52, 52, 49, 0, 0, 62, 62, 36, 
	31, 30, 0, 0, 0, 60, 62, 62, 
	75, 75, 4, 0, 0, 44, 60, 62, 
	75, 75, 38, 0, 6, 10, 44, 60, 
	75, 75, 75, 4, 18, 77, 0, 41, 
	75, 75, 75, 38, 4, 0, 0, 0, 
	75, 75, 75, 75, 38, 4, 0, 21, 
	75, 75, 75, 75, 75, 38, 4, 60, 
	75, 75, 75, 75, 75, 75, 38, 42, 
	75, 75, 75, 75, 75, 75, 75, 39, 
	75, 75, 75, 70, 66, 75, 75, 75, 
	75, 75, 75, 39, 32, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 69, 
	75, 75, 75, 75, 75, 75, 74, 0, 
	75, 75, 74, 69, 64, 64, 63, 6, 
	65, 72, 68, 0, 21, 27, 0, 19, 
	0, 45, 0, 0, 60, 61, 0, 18, 
	0, 0, 0, 0, 41, 49, 0, 0, 
	8, 8, 8, 8, 8, 8, 8, 8, 
	0, 0, 1, 21, 27, 0, 0, 0, 
	0, 0, 22, 62, 61, 0, 5, 8, 
	0, 0, 60, 61, 56, 0, 12, 0, 
	0, 0, 41, 49, 0, 0, 12, 0, 
	8, 8, 8, 8, 8, 8, 16, 0, 
	0, 0, 0, 0, 0, 0, 12, 0, 
	0, 0, 6, 10, 0, 0, 12, 0, 
	0, 0, 19, 78, 0, 20, 12, 0, 
	0, 0, 18, 77, 0, 59, 12, 0, 
	0, 0, 0, 0, 0, 40, 12, 0, 
	8, 8, 8, 8, 8, 8, 16, 0, 
	0, 0, 21, 28, 27, 0, 12, 0, 
	0, 0, 62, 62, 62, 0, 13, 8, 
	0, 0, 60, 62, 61, 0, 0, 0, 
	0, 0, 41, 52, 49, 0, 0, 0, 

};
static const byte[] mapBytes1 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	8, 8, 8, 8, 8, 8, 8, 7, 
	0, 0, 0, 0, 0, 0, 0, 12, 
	0, 0, 0, 21, 28, 27, 0, 12, 
	0, 0, 0, 60, 62, 61, 0, 12, 
	0, 0, 0, 41, 52, 49, 0, 12, 
	8, 8, 8, 8, 8, 8, 8, 15, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 2, 23, 31, 31, 31, 
	0, 23, 31, 32, 75, 75, 75, 75, 
	0, 75, 75, 75, 75, 75, 75, 75, 
	2, 75, 75, 75, 75, 75, 75, 75, 
	32, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 69, 65, 75, 75, 75, 75, 
	75, 75, 4, 2, 75, 75, 74, 69, 
	75, 75, 39, 32, 75, 75, 68, 0, 
	75, 75, 75, 75, 75, 75, 4, 0, 
	75, 75, 75, 75, 75, 75, 39, 31, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	64, 65, 73, 75, 75, 75, 75, 75, 
	0, 0, 47, 73, 75, 75, 75, 75, 
	0, 0, 0, 47, 73, 75, 75, 75, 
	0, 0, 21, 27, 47, 75, 74, 69, 
	0, 0, 60, 61, 0, 75, 68, 0, 
	0, 0, 41, 49, 0, 75, 0, 0, 
	5, 8, 8, 8, 8, 76, 8, 8, 
	12, 0, 21, 27, 0, 75, 21, 28, 
	12, 0, 60, 61, 0, 75, 62, 62, 
	12, 0, 41, 49, 0, 75, 62, 62, 
	12, 0, 0, 0, 0, 75, 60, 62, 
	12, 0, 0, 0, 0, 75, 41, 52, 
	14, 8, 8, 9, 8, 76, 8, 8, 
	12, 0, 0, 12, 2, 75, 0, 0, 
	33, 31, 31, 33, 32, 74, 0, 21, 
	67, 64, 64, 67, 64, 63, 0, 60, 
	12, 21, 27, 12, 21, 27, 0, 41, 
	12, 60, 61, 12, 60, 61, 0, 0, 
	12, 41, 49, 12, 41, 49, 0, 0, 
	13, 8, 8, 17, 8, 8, 8, 8, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes2 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	28, 27, 0, 0, 0, 0, 0, 0, 
	62, 61, 0, 0, 0, 0, 0, 0, 
	52, 50, 8, 8, 8, 8, 8, 8, 
	0, 12, 0, 0, 0, 0, 0, 0, 
	0, 12, 0, 0, 0, 21, 28, 28, 
	0, 12, 0, 0, 0, 60, 62, 62, 
	0, 12, 0, 0, 0, 41, 52, 52, 
	8, 17, 8, 8, 8, 8, 8, 8, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	28, 27, 0, 0, 0, 2, 23, 31, 
	62, 61, 0, 23, 31, 32, 75, 75, 
	52, 49, 0, 75, 75, 75, 75, 75, 
	27, 0, 2, 75, 75, 75, 75, 75, 
	61, 0, 25, 75, 75, 75, 75, 75, 
	49, 2, 75, 75, 75, 75, 75, 75, 
	0, 24, 75, 75, 75, 75, 75, 75, 
	0, 48, 75, 75, 75, 75, 75, 75, 
	0, 25, 75, 75, 75, 75, 75, 75, 
	0, 75, 75, 75, 75, 75, 75, 75, 
	0, 73, 75, 75, 75, 75, 75, 75, 
	0, 47, 73, 75, 75, 75, 75, 75, 
	28, 27, 46, 65, 73, 75, 75, 75, 
	62, 61, 0, 0, 47, 73, 75, 75, 
	53, 51, 7, 0, 0, 47, 75, 75, 
	0, 0, 12, 0, 21, 27, 75, 69, 
	0, 0, 12, 0, 60, 62, 75, 0, 
	27, 0, 12, 0, 41, 52, 75, 0, 
	62, 0, 14, 8, 8, 8, 76, 8, 
	62, 0, 12, 0, 21, 27, 75, 0, 
	62, 0, 12, 0, 60, 62, 75, 0, 
	62, 0, 12, 0, 41, 52, 75, 0, 
	61, 0, 12, 0, 0, 0, 75, 0, 
	49, 0, 14, 8, 9, 8, 76, 8, 
	0, 0, 12, 0, 12, 2, 75, 0, 
	31, 31, 33, 31, 33, 32, 74, 0, 
	64, 64, 67, 64, 67, 64, 63, 0, 
	0, 0, 12, 20, 12, 20, 3, 0, 
	8, 8, 16, 62, 12, 62, 36, 28, 
	0, 0, 12, 59, 12, 60, 62, 62, 
	0, 0, 12, 40, 12, 41, 52, 52, 
	28, 27, 13, 8, 17, 8, 8, 8, 
	62, 61, 0, 0, 0, 0, 0, 0, 
	52, 49, 0, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes3 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 21, 27, 0, 21, 28, 28, 28, 
	0, 60, 61, 0, 60, 62, 62, 62, 
	0, 41, 49, 0, 41, 52, 52, 52, 
	8, 8, 8, 8, 8, 8, 7, 0, 
	0, 0, 0, 0, 0, 0, 12, 0, 
	1, 21, 28, 27, 3, 0, 12, 0, 
	29, 62, 62, 62, 35, 0, 14, 8, 
	62, 57, 55, 62, 62, 0, 12, 0, 
	62, 36, 29, 62, 62, 0, 12, 0, 
	62, 62, 62, 62, 61, 0, 14, 8, 
	62, 62, 62, 62, 56, 0, 12, 0, 
	54, 60, 62, 61, 0, 0, 12, 0, 
	0, 41, 52, 49, 0, 0, 12, 0, 
	0, 0, 0, 0, 0, 0, 12, 0, 
	0, 0, 21, 27, 3, 0, 14, 8, 
	0, 0, 60, 62, 35, 0, 12, 0, 
	30, 4, 44, 60, 61, 0, 12, 0, 
	75, 38, 4, 41, 49, 0, 12, 0, 
	75, 75, 39, 31, 31, 31, 33, 31, 
	75, 74, 69, 64, 64, 64, 67, 64, 
	75, 68, 0, 0, 5, 8, 17, 8, 
	74, 0, 0, 0, 12, 0, 0, 0, 
	63, 6, 10, 0, 12, 0, 0, 0, 
	0, 19, 78, 0, 14, 8, 8, 8, 
	0, 18, 77, 0, 12, 0, 0, 0, 
	0, 0, 0, 0, 12, 0, 21, 28, 
	8, 8, 8, 8, 16, 0, 60, 62, 
	0, 0, 0, 0, 12, 0, 41, 52, 
	0, 5, 8, 8, 16, 0, 1, 21, 
	27, 12, 0, 0, 12, 1, 22, 62, 
	61, 12, 21, 27, 12, 22, 62, 62, 
	49, 12, 60, 61, 12, 62, 62, 57, 
	8, 16, 41, 49, 12, 60, 62, 36, 
	0, 14, 8, 8, 16, 44, 60, 62, 
	27, 12, 0, 0, 12, 0, 44, 60, 
	61, 12, 0, 0, 12, 0, 0, 41, 
	51, 16, 0, 0, 12, 21, 27, 0, 
	0, 12, 0, 0, 12, 60, 61, 0, 
	0, 12, 0, 0, 12, 41, 49, 0, 
	0, 13, 8, 8, 17, 8, 8, 8, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes4 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	8, 8, 8, 8, 9, 8, 8, 8, 
	0, 0, 0, 0, 12, 0, 0, 0, 
	28, 28, 27, 0, 12, 0, 0, 0, 
	62, 62, 61, 0, 12, 0, 0, 0, 
	52, 52, 49, 0, 12, 0, 0, 21, 
	8, 8, 8, 8, 15, 0, 0, 62, 
	0, 0, 0, 0, 0, 0, 0, 60, 
	2, 23, 31, 31, 31, 30, 4, 41, 
	32, 75, 75, 75, 75, 75, 39, 31, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 74, 71, 73, 75, 75, 
	75, 75, 75, 68, 0, 47, 75, 75, 
	75, 75, 75, 4, 0, 2, 75, 75, 
	75, 75, 75, 39, 31, 32, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	75, 75, 75, 75, 75, 75, 75, 75, 
	65, 73, 75, 75, 74, 69, 65, 73, 
	0, 47, 75, 74, 68, 0, 0, 46, 
	0, 0, 75, 68, 0, 0, 0, 0, 
	0, 0, 75, 0, 0, 0, 0, 0, 
	8, 8, 76, 8, 8, 8, 8, 8, 
	27, 0, 75, 21, 28, 28, 27, 0, 
	61, 0, 75, 62, 62, 62, 62, 0, 
	49, 0, 75, 62, 62, 62, 62, 0, 
	0, 0, 75, 60, 62, 62, 61, 0, 
	5, 8, 76, 43, 53, 53, 51, 8, 
	12, 2, 75, 0, 0, 0, 0, 0, 
	33, 32, 74, 0, 0, 6, 10, 0, 
	67, 64, 63, 20, 0, 19, 78, 0, 
	12, 0, 0, 59, 0, 18, 77, 0, 
	12, 20, 3, 40, 0, 0, 0, 0, 
	12, 60, 34, 0, 0, 5, 8, 8, 
	12, 41, 49, 0, 0, 12, 0, 0, 
	13, 8, 8, 8, 8, 15, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes5 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 21, 27, 0, 
	11, 10, 0, 0, 0, 60, 61, 0, 
	81, 78, 0, 0, 0, 41, 49, 0, 
	80, 79, 8, 8, 8, 8, 8, 8, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	27, 0, 0, 0, 1, 21, 28, 28, 
	62, 0, 0, 21, 29, 62, 62, 62, 
	61, 0, 0, 62, 62, 57, 55, 62, 
	49, 0, 0, 62, 62, 36, 29, 62, 
	0, 0, 0, 60, 62, 62, 62, 62, 
	0, 0, 0, 44, 60, 62, 62, 62, 
	30, 0, 6, 10, 44, 60, 62, 62, 
	75, 4, 18, 77, 0, 41, 52, 52, 
	75, 38, 4, 0, 0, 0, 0, 0, 
	75, 75, 38, 4, 0, 0, 21, 28, 
	75, 75, 75, 38, 4, 0, 60, 62, 
	75, 75, 75, 75, 38, 4, 44, 60, 
	75, 75, 75, 75, 75, 38, 4, 41, 
	75, 70, 66, 75, 75, 75, 39, 31, 
	75, 39, 32, 75, 75, 74, 69, 64, 
	75, 75, 75, 75, 75, 68, 0, 0, 
	75, 75, 75, 75, 74, 0, 0, 0, 
	74, 69, 64, 64, 63, 6, 10, 0, 
	63, 0, 21, 27, 0, 19, 78, 0, 
	0, 0, 60, 61, 0, 18, 77, 0, 
	0, 0, 41, 49, 0, 0, 0, 0, 
	8, 8, 8, 8, 8, 8, 8, 8, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 5, 8, 8, 
	0, 0, 0, 21, 27, 12, 0, 0, 
	0, 0, 0, 60, 61, 12, 21, 28, 
	8, 8, 8, 43, 51, 16, 60, 62, 
	0, 0, 0, 0, 0, 12, 41, 52, 
	11, 10, 0, 0, 0, 14, 8, 8, 
	81, 78, 0, 21, 27, 12, 0, 0, 
	80, 77, 0, 60, 61, 12, 0, 0, 
	0, 0, 0, 41, 49, 12, 0, 0, 
	8, 8, 8, 8, 8, 16, 0, 0, 
	28, 28, 27, 0, 0, 12, 0, 0, 
	62, 62, 62, 0, 0, 13, 8, 8, 
	62, 62, 61, 0, 0, 0, 0, 0, 
	52, 52, 49, 0, 0, 0, 0, 0, 

};
static const byte[] mapBytes6 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 21, 27, 0, 0, 0, 0, 
	0, 22, 62, 62, 0, 0, 0, 0, 
	0, 62, 62, 62, 0, 5, 8, 8, 
	0, 60, 62, 61, 0, 12, 0, 0, 
	0, 41, 52, 49, 0, 12, 0, 0, 
	0, 0, 0, 0, 0, 12, 0, 0, 
	0, 0, 0, 0, 0, 12, 0, 0, 
	8, 8, 9, 8, 8, 17, 8, 8, 
	0, 0, 12, 0, 0, 0, 0, 0, 
	0, 0, 12, 0, 21, 27, 0, 0, 
	0, 0, 12, 0, 60, 61, 0, 23, 
	0, 0, 12, 0, 41, 49, 0, 75, 
	0, 0, 12, 21, 27, 0, 2, 75, 
	8, 8, 16, 60, 61, 0, 25, 75, 
	0, 0, 12, 41, 49, 2, 75, 75, 
	0, 0, 12, 0, 0, 24, 75, 75, 
	0, 0, 12, 0, 0, 48, 75, 75, 
	0, 0, 12, 0, 0, 25, 75, 75, 
	8, 8, 16, 0, 0, 75, 75, 75, 
	0, 0, 12, 0, 0, 73, 75, 75, 
	0, 0, 12, 0, 0, 47, 73, 75, 
	0, 0, 12, 0, 21, 27, 46, 64, 
	0, 0, 12, 0, 60, 61, 0, 0, 
	8, 8, 17, 8, 43, 51, 7, 0, 
	0, 0, 0, 0, 0, 0, 12, 0, 
	28, 27, 0, 0, 21, 27, 12, 0, 
	62, 62, 3, 0, 62, 62, 12, 0, 
	62, 62, 35, 0, 62, 62, 14, 8, 
	62, 62, 62, 0, 60, 61, 12, 0, 
	62, 62, 62, 3, 41, 49, 12, 0, 
	62, 62, 62, 35, 0, 0, 12, 0, 
	62, 62, 62, 61, 0, 0, 12, 0, 
	62, 62, 61, 56, 0, 0, 14, 8, 
	52, 52, 49, 0, 0, 0, 12, 0, 
	31, 31, 31, 31, 31, 31, 33, 31, 
	64, 64, 64, 64, 64, 64, 67, 64, 
	0, 0, 0, 0, 0, 0, 12, 21, 
	8, 8, 8, 8, 8, 8, 16, 62, 
	0, 0, 0, 0, 0, 0, 12, 60, 
	0, 21, 27, 0, 0, 0, 12, 41, 
	0, 60, 61, 0, 21, 27, 13, 8, 
	0, 41, 49, 0, 60, 61, 0, 0, 
	0, 0, 0, 0, 41, 49, 0, 0, 

};
static const byte[] mapBytes7 = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	27, 0, 0, 0, 0, 0, 0, 0, 
	61, 0, 0, 0, 0, 6, 10, 0, 
	49, 0, 0, 0, 0, 18, 77, 0, 
	8, 8, 8, 8, 7, 0, 0, 0, 
	27, 3, 0, 0, 14, 8, 8, 8, 
	62, 35, 3, 0, 12, 0, 0, 0, 
	62, 62, 35, 0, 14, 8, 8, 8, 
	55, 62, 62, 0, 12, 0, 0, 0, 
	29, 62, 62, 0, 12, 0, 0, 0, 
	62, 62, 61, 0, 14, 8, 8, 8, 
	62, 62, 56, 0, 12, 0, 0, 0, 
	62, 61, 0, 0, 12, 21, 27, 0, 
	61, 56, 0, 0, 12, 60, 61, 0, 
	49, 0, 0, 0, 12, 41, 49, 0, 
	27, 0, 0, 0, 13, 8, 8, 8, 
	62, 0, 0, 0, 0, 21, 27, 0, 
	61, 0, 0, 0, 0, 60, 61, 0, 
	49, 0, 0, 0, 0, 41, 49, 0, 
	31, 31, 31, 31, 31, 31, 31, 31, 
	64, 64, 64, 64, 64, 64, 64, 64, 
	0, 0, 5, 8, 8, 8, 8, 8, 
	0, 0, 12, 0, 0, 0, 0, 0, 
	10, 0, 12, 0, 0, 0, 0, 0, 
	78, 0, 14, 8, 8, 8, 8, 8, 
	77, 0, 12, 0, 0, 0, 0, 0, 
	0, 0, 12, 0, 21, 26, 0, 0, 
	8, 8, 16, 0, 59, 56, 0, 0, 
	0, 0, 12, 0, 40, 1, 21, 28, 
	8, 8, 16, 0, 1, 22, 62, 62, 
	0, 0, 12, 0, 22, 62, 62, 62, 
	28, 27, 12, 0, 62, 62, 62, 62, 
	62, 61, 12, 0, 62, 62, 58, 62, 
	52, 49, 12, 0, 60, 62, 37, 62, 
	8, 8, 16, 0, 44, 60, 62, 62, 
	0, 0, 12, 0, 0, 44, 62, 62, 
	0, 0, 12, 0, 0, 0, 60, 62, 
	0, 0, 12, 21, 27, 0, 44, 62, 
	0, 0, 12, 60, 61, 0, 0, 60, 
	0, 0, 12, 41, 49, 0, 0, 41, 
	8, 8, 17, 8, 8, 8, 8, 8, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 

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
