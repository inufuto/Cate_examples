#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 1
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 3, 
		},
	},
	{ // 2
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 3, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 3
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 3, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 3, 
		},
	},
	{ // 4
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 5
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 6
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 7
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 11, 
		},
	},
	{ // 8
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 9
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 10
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 11
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 3, 
		},
	},
	{ // 12
		{ // chars
			Char_Terrain + 0, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 13
		{ // chars
			Char_Terrain + 0, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 14
		{ // chars
			Char_Terrain + 0, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 15
		{ // chars
			Char_Terrain + 0, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 16
		{ // chars
			Char_Terrain + 0, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 0, 
			Char_Terrain + 2, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 17
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 18
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 11, 
		},
	},
	{ // 19
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 20
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 0, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 11, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
		},
	},
	{ // 21
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 22
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 11, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 11, 
		},
	},
	{ // 23
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 0, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
		},
	},
	{ // 24
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 25
		{ // chars
			Char_Terrain + 0, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
		},
	},
	{ // 26
		{ // chars
			Char_Terrain + 0, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
		},
	},
	{ // 27
		{ // chars
			Char_Terrain + 0, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 28
		{ // chars
			Char_Terrain + 0, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 29
		{ // chars
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
		},
	},
	{ // 30
		{ // chars
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 31
		{ // chars
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 11, 
		},
	},
	{ // 32
		{ // chars
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 0, 
		},
	},
	{ // 33
		{ // chars
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 11, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
		},
	},
	{ // 34
		{ // chars
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 10, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 35
		{ // chars
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
		},
	},
	{ // 36
		{ // chars
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 37
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 0, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 8, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
		},
	},
	{ // 38
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
		},
	},
	{ // 39
		{ // chars
			Char_Terrain + 8, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 8, 
			Char_Terrain + 4, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 4, 
		},
	},
	{ // 40
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 41
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 42
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 0, 
		},
	},
	{ // 43
		{ // chars
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 5, 
		},
	},
	{ // 44
		{ // chars
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
		},
	},
	{ // 45
		{ // chars
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 5, 
		},
	},
	{ // 46
		{ // chars
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
		},
	},
	{ // 47
		{ // chars
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 7, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 7, 
			Char_Terrain + 9, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 9, 
			Char_Terrain + 6, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 6, 
		},
	},
	{ // 48
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 0, 
		},
	},
	{ // 49
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
		},
	},
	{ // 50
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 10, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 9, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 11, 
		},
	},
	{ // 51
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
		},
	},
	{ // 52
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
};

static const byte[] mapBytes0 = {
	128 + 55, 17, 15, 128 + 3, 24, 23, 128 + 3, 17, 
	2, 128 + 3, 52, 49, 128 + 3, 17, 12, 128 + 3, 
	51, 50, 128 + 4, 21, 128 + 8, 17, 9, 9, 
	10, 128 + 4, 17, 15, 128 + 3, 0, 17, 17, 
	15, 9, 128 + 3, 0, 1, 17, 17, 0, 
	0, 128 + 3, 4, 6, 17, 17, 0, 0, 
	9, 38, 37, 128 + 3, 17, 2, 0, 0, 
	46, 46, 128 + 3, 17, 12, 2, 0, 46, 
	46, 37, 17, 19, 23, 12, 2, 128 + 3, 
	46, 17, 35, 48, 17, 12, 128 + 3, 46, 
	37, 128 + 4, 17, 128 + 4, 46, 37, 17, 17, 
	15, 128 + 5, 46, 37, 17, 2, 128 + 6, 46, 
	37, 12, 128 + 7, 46, 38, 128 + 3, 46, 41, 
	41, 128 + 6, 46, 38, 38, 128 + 10, 46, 41, 
	128 + 6, 46, 45, 17, 46, 46, 45, 128 + 3, 
	41, 40, 19, 41, 43, 40, 17, 15, 
	10, 17, 36, 17, 27, 17, 17, 2, 
	1, 17, 35, 128 + 4, 17, 12, 6, 17, 
	17, 128 + 8, 21, 128 + 3, 17, 15, 10, 128 + 5, 
	17, 15, 0, 1, 17, 18, 21, 17, 
	17, 2, 1, 6, 17, 29, 128 + 3, 17, 
	12, 6, 17, 17, 29, 17, 128 + 6, 21, 
	33, 128 + 7, 17, 29, 128 + 3, 17, 19, 23, 
	17, 17, 29, 128 + 3, 17, 36, 49, 17, 
	16, 29, 128 + 3, 17, 35, 48, 17, 3, 
	29, 128 + 6, 17, 14, 29, 17, 128 + 6, 21, 
	33, 128 + 3, 17, 15, 9, 10, 17, 29, 
	128 + 3, 17, 128 + 3, 0, 17, 30, 21, 17, 
	17, 2, 0, 1, 128 + 5, 17, 12, 4, 
	6, 17, 17, 17, 
};
static const byte[] mapBytes1 = {
	128 + 56, 17, 128 + 7, 21, 20, 128 + 7, 17, 29, 
	128 + 3, 17, 15, 9, 10, 17, 29, 128 + 3, 
	17, 2, 0, 1, 17, 29, 128 + 3, 17, 
	12, 4, 6, 17, 29, 128 + 7, 21, 32, 
	128 + 12, 17, 26, 128 + 3, 38, 17, 26, 38, 
	38, 128 + 4, 46, 17, 128 + 7, 46, 17, 128 + 7, 
	46, 38, 128 + 17, 46, 41, 41, 128 + 6, 46, 
	17, 17, 46, 46, 45, 41, 46, 46, 
	38, 38, 46, 46, 40, 17, 128 + 6, 46, 
	17, 17, 128 + 6, 46, 38, 38, 128 + 8, 46, 
	41, 41, 44, 128 + 5, 46, 17, 17, 28, 
	44, 128 + 4, 46, 128 + 3, 17, 28, 44, 128 + 3, 
	46, 17, 17, 15, 10, 28, 46, 45, 
	41, 17, 17, 2, 1, 17, 46, 40, 
	128 + 3, 17, 12, 6, 17, 46, 17, 17, 
	18, 128 + 4, 21, 47, 21, 21, 29, 17, 
	15, 10, 17, 46, 15, 9, 29, 17, 
	2, 1, 17, 46, 0, 0, 29, 17, 
	12, 6, 17, 46, 0, 0, 29, 128 + 4, 
	17, 46, 2, 0, 29, 128 + 4, 17, 46, 
	12, 4, 31, 21, 21, 22, 21, 47, 
	21, 21, 29, 17, 17, 29, 17, 46, 
	17, 17, 39, 38, 38, 39, 38, 45, 
	17, 15, 42, 41, 41, 42, 41, 40, 
	17, 2, 29, 15, 10, 29, 15, 10, 
	17, 12, 29, 2, 1, 29, 2, 1, 
	17, 17, 29, 12, 6, 29, 12, 6, 
	17, 17, 30, 21, 21, 34, 128 + 4, 21, 
	128 + 15, 17, 17, 
};
static const byte[] mapBytes2 = {
	128 + 40, 17, 9, 10, 128 + 6, 17, 0, 1, 
	128 + 6, 17, 4, 7, 128 + 6, 21, 17, 29, 
	128 + 7, 17, 29, 128 + 3, 17, 15, 9, 9, 
	17, 29, 128 + 3, 17, 2, 0, 0, 17, 
	29, 128 + 3, 17, 12, 4, 4, 21, 34, 
	128 + 6, 21, 128 + 8, 17, 9, 10, 128 + 4, 17, 
	26, 38, 0, 1, 17, 26, 38, 38, 
	46, 46, 4, 6, 17, 128 + 5, 46, 10, 
	17, 17, 128 + 5, 46, 1, 17, 26, 128 + 5, 
	46, 6, 17, 128 + 6, 46, 17, 25, 128 + 6, 
	46, 17, 28, 128 + 6, 46, 17, 26, 128 + 6, 
	46, 17, 128 + 7, 46, 17, 44, 128 + 6, 46, 
	17, 28, 44, 128 + 5, 46, 9, 10, 28, 
	41, 44, 128 + 3, 46, 0, 1, 17, 17, 
	28, 44, 46, 46, 5, 8, 20, 17, 
	17, 28, 46, 46, 17, 17, 29, 17, 
	15, 10, 46, 41, 17, 17, 29, 17, 
	2, 0, 46, 17, 10, 17, 29, 17, 
	12, 4, 46, 17, 0, 17, 31, 128 + 3, 
	21, 47, 21, 0, 17, 29, 17, 15, 
	10, 46, 17, 0, 17, 29, 17, 2, 
	0, 46, 17, 0, 17, 29, 17, 12, 
	4, 46, 17, 1, 17, 29, 128 + 3, 17, 
	46, 17, 6, 17, 31, 21, 22, 21, 
	47, 21, 17, 17, 29, 17, 29, 17, 
	46, 17, 38, 38, 39, 38, 39, 38, 
	45, 17, 41, 41, 42, 41, 42, 41, 
	40, 128 + 3, 17, 29, 16, 29, 16, 17, 
	17, 21, 21, 33, 0, 29, 0, 9, 
	9, 17, 17, 29, 3, 29, 2, 0, 
	0, 17, 17, 29, 14, 29, 12, 4, 
	4, 9, 10, 30, 21, 34, 128 + 3, 21, 
	0, 1, 128 + 6, 17, 4, 6, 128 + 5, 17, 
	17, 
};
static const byte[] mapBytes3 = {
	128 + 49, 17, 15, 10, 17, 15, 128 + 3, 9, 
	17, 2, 1, 17, 2, 128 + 3, 0, 17, 
	12, 6, 17, 12, 128 + 3, 4, 128 + 6, 21, 
	20, 128 + 7, 17, 29, 17, 17, 15, 9, 
	10, 17, 17, 29, 17, 9, 128 + 3, 0, 
	10, 17, 31, 21, 0, 4, 4, 0, 
	0, 17, 29, 17, 0, 9, 9, 0, 
	0, 17, 29, 17, 128 + 4, 0, 1, 17, 
	31, 21, 128 + 4, 0, 6, 17, 29, 17, 
	4, 2, 0, 1, 17, 17, 29, 17, 
	17, 12, 4, 6, 17, 17, 29, 128 + 7, 
	17, 29, 128 + 3, 17, 15, 10, 17, 17, 
	31, 21, 17, 17, 2, 0, 10, 17, 
	29, 17, 37, 17, 12, 2, 1, 17, 
	29, 17, 46, 37, 17, 12, 6, 17, 
	29, 17, 46, 46, 128 + 4, 38, 39, 38, 
	46, 45, 128 + 4, 41, 42, 41, 46, 40, 
	17, 17, 18, 21, 34, 21, 45, 128 + 3, 
	17, 29, 128 + 3, 17, 40, 19, 23, 17, 
	29, 128 + 4, 17, 36, 49, 17, 31, 128 + 3, 
	21, 17, 35, 48, 17, 29, 128 + 7, 17, 
	29, 17, 15, 9, 128 + 4, 21, 33, 17, 
	2, 0, 128 + 4, 17, 29, 17, 12, 4, 
	17, 18, 21, 21, 33, 17, 17, 15, 
	10, 29, 17, 17, 29, 17, 15, 0, 
	1, 29, 15, 10, 29, 15, 0, 0, 
	6, 29, 2, 1, 29, 0, 0, 4, 
	21, 33, 12, 6, 29, 2, 0, 9, 
	17, 31, 21, 21, 33, 12, 2, 0, 
	10, 29, 17, 17, 29, 17, 12, 2, 
	1, 29, 17, 17, 29, 17, 17, 12, 
	8, 33, 17, 17, 29, 15, 10, 17, 
	17, 29, 17, 17, 29, 2, 1, 17, 
	17, 29, 17, 17, 29, 12, 6, 17, 
	17, 30, 21, 21, 34, 128 + 3, 21, 128 + 15, 
	17, 17, 
};
static const byte[] mapBytes4 = {
	128 + 56, 17, 128 + 4, 21, 22, 128 + 3, 21, 128 + 4, 
	17, 29, 128 + 3, 17, 9, 9, 10, 17, 
	29, 128 + 3, 17, 0, 0, 1, 17, 29, 
	128 + 3, 17, 4, 4, 6, 17, 29, 17, 
	17, 15, 128 + 4, 21, 32, 17, 17, 0, 
	128 + 7, 17, 2, 17, 26, 128 + 3, 38, 37, 
	17, 12, 38, 128 + 5, 46, 38, 38, 128 + 43, 
	46, 45, 41, 44, 128 + 5, 46, 40, 17, 
	28, 128 + 5, 46, 128 + 3, 17, 128 + 5, 46, 128 + 3, 
	38, 128 + 26, 46, 41, 44, 46, 46, 45, 
	41, 41, 44, 17, 28, 46, 45, 40, 
	17, 17, 28, 17, 17, 46, 40, 128 + 6, 
	17, 46, 128 + 5, 17, 21, 21, 47, 128 + 5, 
	21, 10, 17, 46, 15, 9, 9, 10, 
	17, 1, 17, 46, 128 + 4, 0, 17, 6, 
	17, 46, 128 + 4, 0, 128 + 3, 17, 46, 2, 
	0, 0, 1, 17, 18, 21, 47, 13, 
	5, 5, 8, 21, 29, 17, 46, 128 + 5, 
	17, 39, 38, 45, 17, 17, 19, 23, 
	17, 42, 41, 40, 16, 17, 36, 49, 
	17, 29, 17, 17, 3, 17, 35, 48, 
	17, 29, 16, 17, 14, 128 + 4, 17, 29, 
	2, 11, 17, 17, 18, 21, 21, 29, 
	12, 6, 17, 17, 29, 17, 17, 30, 
	128 + 4, 21, 32, 128 + 17, 17, 17, 
};
static const byte[] mapBytes5 = {
	128 + 53, 17, 15, 10, 17, 24, 23, 128 + 3, 
	17, 2, 1, 17, 52, 49, 128 + 3, 17, 
	12, 6, 17, 51, 50, 128 + 6, 21, 128 + 8, 
	17, 10, 128 + 4, 17, 15, 9, 9, 0, 
	17, 17, 15, 9, 128 + 3, 0, 1, 17, 
	17, 0, 0, 4, 4, 0, 6, 17, 
	17, 0, 0, 9, 9, 0, 128 + 3, 17, 
	2, 128 + 4, 0, 128 + 3, 17, 12, 2, 128 + 3, 
	0, 37, 17, 19, 23, 12, 2, 0, 
	0, 46, 17, 35, 48, 17, 12, 4, 
	4, 46, 37, 128 + 6, 17, 46, 46, 37, 
	128 + 3, 17, 15, 9, 128 + 3, 46, 37, 17, 
	17, 2, 0, 128 + 4, 46, 37, 17, 12, 
	2, 128 + 5, 46, 37, 17, 12, 46, 41, 
	41, 128 + 3, 46, 38, 38, 46, 38, 38, 
	46, 46, 45, 41, 41, 128 + 5, 46, 40, 
	17, 17, 128 + 4, 46, 45, 128 + 3, 17, 45, 
	128 + 3, 41, 40, 19, 23, 17, 40, 17, 
	15, 10, 17, 36, 49, 128 + 3, 17, 2, 
	1, 17, 35, 48, 128 + 3, 17, 12, 6, 
	128 + 4, 17, 128 + 8, 21, 128 + 13, 17, 18, 21, 
	21, 128 + 3, 17, 15, 10, 29, 128 + 5, 17, 
	2, 1, 29, 15, 9, 128 + 3, 21, 13, 
	8, 33, 2, 0, 128 + 5, 17, 29, 12, 
	4, 24, 23, 128 + 3, 17, 31, 21, 21, 
	52, 49, 17, 15, 10, 29, 17, 17, 
	51, 48, 17, 2, 1, 29, 128 + 5, 17, 
	12, 6, 29, 17, 17, 128 + 5, 21, 33, 
	17, 17, 9, 9, 10, 17, 17, 29, 
	17, 17, 128 + 3, 0, 17, 17, 30, 21, 
	21, 0, 0, 1, 128 + 5, 17, 4, 4, 
	6, 128 + 4, 17, 17, 
};
static const byte[] mapBytes6 = {
	128 + 42, 17, 15, 10, 128 + 5, 17, 15, 0, 
	0, 128 + 5, 17, 128 + 3, 0, 17, 18, 21, 
	21, 17, 2, 0, 1, 17, 29, 128 + 3, 
	17, 12, 4, 6, 17, 29, 128 + 7, 17, 
	29, 128 + 7, 17, 29, 17, 17, 21, 21, 
	22, 21, 21, 34, 21, 21, 17, 17, 
	29, 128 + 7, 17, 29, 17, 15, 10, 128 + 4, 
	17, 29, 17, 2, 1, 17, 26, 17, 
	17, 29, 17, 12, 6, 17, 46, 17, 
	17, 29, 15, 10, 17, 17, 46, 21, 
	21, 33, 2, 1, 17, 26, 46, 17, 
	17, 29, 12, 6, 17, 46, 46, 17, 
	17, 29, 17, 17, 25, 46, 46, 17, 
	17, 29, 17, 17, 28, 46, 46, 17, 
	17, 29, 17, 17, 26, 46, 46, 21, 
	21, 33, 17, 17, 128 + 3, 46, 17, 17, 
	29, 17, 17, 44, 46, 46, 17, 17, 
	29, 17, 17, 28, 44, 46, 17, 17, 
	29, 17, 15, 10, 28, 41, 17, 17, 
	29, 17, 2, 1, 17, 17, 21, 21, 
	34, 21, 13, 8, 20, 128 + 7, 17, 29, 
	17, 9, 10, 17, 17, 15, 10, 29, 
	17, 0, 0, 17, 17, 0, 0, 29, 
	17, 0, 0, 10, 17, 0, 0, 31, 
	21, 128 + 3, 0, 17, 2, 1, 29, 17, 
	128 + 3, 0, 17, 12, 6, 29, 17, 128 + 3, 
	0, 10, 17, 17, 29, 17, 128 + 3, 0, 
	1, 17, 17, 29, 17, 0, 0, 1, 
	6, 17, 17, 31, 21, 4, 4, 6, 
	128 + 3, 17, 29, 17, 128 + 6, 38, 39, 38, 
	128 + 6, 41, 42, 41, 128 + 6, 17, 29, 15, 
	128 + 6, 21, 33, 0, 128 + 6, 17, 29, 2, 
	17, 15, 10, 128 + 3, 17, 29, 12, 17, 
	2, 1, 17, 15, 10, 30, 21, 17, 
	12, 6, 17, 2, 1, 128 + 6, 17, 12, 
	6, 17, 17, 
};
static const byte[] mapBytes7 = {
	128 + 48, 17, 10, 128 + 7, 17, 1, 128 + 4, 17, 
	19, 23, 17, 6, 128 + 4, 17, 35, 48, 
	17, 128 + 4, 21, 20, 128 + 3, 17, 10, 128 + 3, 
	17, 31, 128 + 3, 21, 0, 10, 17, 17, 
	29, 128 + 3, 17, 0, 0, 10, 17, 31, 
	128 + 3, 21, 4, 0, 0, 17, 29, 128 + 3, 
	17, 9, 0, 0, 17, 29, 128 + 3, 17, 
	0, 0, 1, 17, 31, 128 + 3, 21, 0, 
	0, 6, 17, 29, 128 + 3, 17, 0, 1, 
	17, 17, 29, 15, 10, 17, 1, 6, 
	17, 17, 29, 2, 1, 17, 6, 128 + 3, 
	17, 29, 12, 6, 17, 10, 128 + 3, 17, 
	30, 128 + 3, 21, 0, 128 + 4, 17, 15, 10, 
	17, 1, 128 + 4, 17, 2, 1, 17, 6, 
	128 + 4, 17, 12, 6, 17, 128 + 8, 38, 128 + 8, 
	41, 17, 17, 18, 128 + 5, 21, 17, 17, 
	29, 128 + 5, 17, 23, 17, 29, 128 + 5, 17, 
	49, 17, 31, 128 + 5, 21, 48, 17, 29, 
	128 + 7, 17, 29, 17, 15, 11, 17, 17, 
	21, 21, 33, 17, 3, 6, 128 + 4, 17, 
	29, 17, 14, 17, 15, 9, 21, 21, 
	33, 17, 17, 15, 0, 0, 17, 17, 
	29, 17, 15, 128 + 3, 0, 9, 10, 29, 
	17, 128 + 5, 0, 1, 29, 17, 0, 0, 
	4, 0, 4, 6, 29, 17, 2, 0, 
	9, 0, 21, 21, 33, 17, 12, 2, 
	0, 0, 17, 17, 29, 17, 17, 12, 
	0, 0, 17, 17, 29, 128 + 3, 17, 2, 
	0, 17, 17, 29, 15, 10, 17, 12, 
	0, 17, 17, 29, 2, 1, 17, 17, 
	2, 17, 17, 29, 12, 6, 17, 17, 
	12, 21, 21, 34, 128 + 5, 21, 128 + 15, 17, 
	17, 
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
