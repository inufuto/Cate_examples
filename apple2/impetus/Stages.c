#include "Stage.h"
#include "Stages.h"
#include "Chars.h"


const byte[] MapBytes = {
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	1,2,0,0,0,0,3,4,5,1,2,0,0,6,7,7,7,7,7,8,0,4,1,0,0,0,0,9,10,11,11,11,
	5,1,2,0,0,0,4,5,5,5,1,0,0,12,0,0,0,0,0,12,0,13,14,0,9,10,11,11,11,11,11,11,
	5,5,1,2,0,0,13,5,5,5,14,0,0,12,0,15,16,0,0,12,0,0,9,10,11,11,11,11,11,11,11,11,
	5,5,5,5,1,2,17,13,5,14,18,0,0,12,0,19,20,0,0,12,0,9,10,11,11,11,11,11,11,11,11,11,
	5,5,5,5,5,1,0,0,0,0,0,0,0,12,0,0,0,0,0,12,0,10,11,11,11,11,11,11,11,11,11,11,
	5,5,5,5,5,5,21,21,21,21,21,21,21,22,21,21,21,21,21,22,21,11,11,11,11,11,11,11,11,11,11,11,
	5,5,5,5,5,14,0,0,0,0,0,0,0,12,0,0,0,0,0,12,0,23,11,11,11,11,11,11,11,11,11,11,
	5,5,5,5,14,18,0,0,0,0,0,0,0,12,0,0,0,0,0,12,0,0,0,0,0,24,23,11,11,11,11,11,
	5,5,5,14,18,0,0,0,0,0,0,0,0,12,0,0,0,0,0,12,0,0,0,4,1,0,0,0,0,0,0,0,
	5,5,14,18,0,6,7,7,7,7,7,7,7,25,7,7,26,27,27,28,0,0,0,13,14,0,0,0,0,15,16,0,
	5,14,18,0,0,12,0,0,0,0,0,0,0,12,0,0,29,0,0,30,0,0,0,0,0,0,0,0,0,19,20,0,
	14,18,0,0,0,12,0,0,0,3,31,2,0,12,0,0,19,32,32,33,7,7,7,7,7,7,7,7,8,0,0,0,
	0,0,0,0,0,12,0,0,0,4,5,1,0,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,
	0,0,0,0,0,12,0,0,0,13,5,14,0,12,0,0,0,0,0,0,0,0,0,3,31,2,0,0,12,0,0,0,
	0,0,0,0,0,12,0,0,0,17,34,18,0,12,0,3,4,5,1,2,0,0,3,4,5,1,0,0,12,0,0,0,
	0,0,0,0,0,12,0,0,0,0,0,0,0,12,0,4,5,5,5,1,0,3,4,5,5,5,2,0,35,7,7,7,
	7,7,36,7,7,37,7,7,7,7,7,7,7,38,0,13,5,5,5,14,0,4,5,18,17,5,1,0,12,4,1,0,
	0,0,12,0,0,0,0,0,0,0,0,0,0,0,0,17,13,5,14,18,0,5,5,2,3,5,5,0,12,13,14,0,
	0,0,12,0,4,1,0,0,0,9,10,11,11,11,39,40,0,0,0,0,0,5,5,5,5,5,5,0,12,0,0,0,
	0,0,12,0,13,14,0,9,10,11,11,11,11,11,11,11,39,40,0,0,0,5,5,5,5,5,5,0,12,0,0,0,
	0,0,12,0,0,0,0,10,11,11,11,11,11,11,11,11,11,39,0,0,0,13,5,5,41,5,14,0,35,7,7,7,
	0,0,12,0,0,0,0,11,11,11,11,11,11,11,11,11,11,11,40,0,0,17,13,5,5,5,18,0,12,0,0,0,
	0,0,12,4,1,0,9,11,11,11,11,11,11,11,11,11,11,11,39,0,15,16,17,13,5,14,0,0,12,0,0,0,
	7,7,42,13,14,0,10,11,11,11,11,11,11,11,11,11,11,11,11,0,19,20,0,17,34,18,0,0,12,0,4,5,
	0,0,12,0,0,0,11,11,11,11,11,11,11,11,11,11,11,11,11,40,0,0,0,0,0,0,0,0,12,0,13,5,
	0,0,12,0,0,9,11,11,11,11,11,11,11,11,11,11,11,11,11,39,40,0,0,0,0,0,0,0,12,0,0,0,
	0,0,12,0,0,43,11,11,11,11,11,11,11,11,11,11,11,11,11,11,39,0,0,4,1,0,0,0,35,7,7,7,
	0,0,12,0,0,24,23,11,11,11,11,11,44,45,23,11,11,11,11,11,11,40,0,13,14,0,0,0,12,4,1,0,
	0,0,12,0,0,0,0,46,11,11,11,11,47,0,24,11,11,11,11,11,11,39,40,0,0,0,0,0,12,13,14,0,
	0,0,12,0,0,10,11,11,11,11,11,11,0,0,0,11,11,11,11,11,11,11,39,40,0,4,1,0,12,0,0,0,
	7,7,42,0,0,11,11,11,11,11,11,11,40,0,9,11,11,11,11,11,11,11,11,39,0,13,14,0,48,7,7,7,
	0,0,12,0,0,11,11,11,11,11,11,11,39,49,10,11,11,11,11,47,24,11,11,11,0,0,0,0,0,0,0,0,
	0,0,12,0,0,23,11,11,11,11,11,11,11,11,11,11,11,11,11,40,9,11,11,11,21,21,21,21,21,21,21,21,
	0,0,12,0,0,24,23,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,44,0,0,0,0,0,0,0,0,
	0,0,12,0,4,1,0,24,23,11,11,11,11,11,11,11,11,11,11,11,11,11,11,47,0,0,6,7,7,7,7,7,
	0,0,12,0,13,14,0,0,24,11,11,11,11,11,11,11,11,11,11,11,11,11,44,0,0,0,12,0,0,0,0,0,
	0,0,12,0,0,0,0,0,0,23,11,11,11,11,11,11,11,11,11,11,44,47,0,0,0,0,12,0,0,0,0,0,
	7,7,37,7,7,7,8,0,0,24,23,11,11,44,47,24,23,11,44,47,0,0,0,15,16,0,12,0,0,0,0,0,
	0,0,0,0,0,0,12,0,0,0,24,11,44,47,0,0,24,50,47,0,0,0,0,29,30,0,35,7,7,7,7,7,
	0,0,0,0,4,1,12,0,4,1,0,51,0,0,0,0,0,0,0,0,4,1,0,29,30,0,12,0,0,0,0,0,
	5,1,0,0,13,14,12,0,13,14,0,51,0,0,0,0,0,0,0,0,13,14,0,19,20,0,12,0,0,0,0,0,
	5,5,2,0,0,0,12,0,0,0,0,51,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,4,1,0,0,
	5,5,1,0,0,0,35,7,7,7,7,52,7,7,7,7,7,7,7,7,7,7,7,7,7,7,42,0,13,14,0,0,
	5,5,5,0,4,1,12,0,0,0,0,51,3,4,1,2,0,0,0,4,1,0,0,0,0,0,12,0,0,0,3,4,
	5,5,5,0,13,14,12,0,4,1,0,51,4,5,5,1,0,0,0,13,14,0,0,0,0,0,12,0,0,3,4,5,
	5,5,5,2,0,0,12,0,13,14,0,51,5,5,5,5,0,0,0,0,0,0,0,6,7,7,42,0,3,4,5,5,
	5,5,5,1,0,0,12,0,0,0,0,51,5,5,5,5,0,0,0,0,0,4,1,12,0,0,12,0,4,5,5,5,
	5,5,5,14,0,0,12,0,0,4,1,51,13,5,5,14,0,0,4,1,0,13,14,12,53,0,12,0,5,5,41,5,
	5,5,5,18,0,0,12,0,0,13,14,51,17,13,14,18,0,0,13,14,0,0,0,12,0,0,12,0,5,5,5,5,
	5,5,14,0,4,1,12,0,0,0,0,51,0,0,0,0,0,0,0,0,0,0,0,12,0,53,12,0,5,41,5,5,
	5,14,18,0,13,14,35,7,7,36,7,52,7,7,7,7,7,7,7,7,7,7,7,42,0,0,12,0,13,5,5,5,
	0,0,0,0,0,0,12,0,0,12,0,51,0,0,0,0,0,0,0,0,0,0,0,12,0,0,12,0,17,5,5,5,
	21,21,21,21,21,21,22,21,21,22,21,54,0,0,15,16,0,0,15,16,0,0,0,35,7,7,42,0,0,13,5,5,
	0,0,0,5,5,0,12,5,5,12,0,0,4,1,29,55,7,7,56,30,0,4,1,12,0,0,12,0,0,17,5,5,
	0,0,0,13,14,0,12,13,14,12,0,0,13,14,19,20,0,0,19,20,0,13,14,12,0,0,12,0,0,0,13,5,
	0,0,0,0,0,0,12,0,0,12,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,12,0,0,0,17,5,
	7,7,7,7,7,7,42,4,1,12,4,1,0,0,6,7,7,7,7,7,7,7,7,42,0,0,12,4,1,0,0,5,
	0,0,0,0,0,0,12,13,14,12,13,14,0,0,12,0,0,0,0,0,0,0,0,12,0,0,12,13,14,0,0,13,
	0,4,1,0,0,0,12,0,0,12,0,0,0,0,12,0,0,3,4,5,1,2,0,12,0,0,12,0,0,0,0,0,
	0,13,14,0,0,0,48,7,7,37,7,7,7,7,38,0,0,4,5,5,5,1,0,48,7,7,37,7,7,7,7,7,
	0,0,0,0,4,1,0,0,0,0,0,0,4,1,0,0,0,13,5,5,5,14,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,13,14,0,0,0,0,0,0,13,14,0,0,0,17,13,5,14,18,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
};


const Tile[] Tiles = {
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 3, Char_Terrain + 3, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Space, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 3, 
	}},
	{{
		Char_Space, Char_Space, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Space, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
	}},
	{{
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
	}},
	{{
		Char_Space, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 1, 
	}},
	{{
		Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{
		Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Terrain + 4, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
	}},
	{{
		Char_Space, Char_Space, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
	}},
	{{
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
	}},
	{{
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 4, 
	}},
	{{
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Space, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Space, Char_Space, Char_Terrain + 3, Char_Terrain + 3, 
	}},
	{{
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Space, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Space, Char_Space, 
	}},
	{{
		Char_Space, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Terrain + 3, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 3, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Space, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 4, 
	}},
	{{
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Terrain + 5, Char_Terrain + 5, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 9, Char_Space, Char_Space, Char_Terrain + 2, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Terrain + 1, 
	}},
	{{
		Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 9, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
	}},
	{{
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Terrain + 3, Char_Terrain + 3, Char_Space, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Terrain + 2, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		Char_Space, Char_Terrain + 3, Char_Terrain + 3, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 2, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 1, 
	}},
	{{
		Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Terrain + 1, 
	}},
	{{
		Char_Terrain + 9, Char_Space, Char_Space, Char_Terrain + 2, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{
		Char_Terrain + 9, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Space, 
	}},
	{{
		Char_Terrain + 5, Char_Terrain + 5, Char_Space, Char_Space, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 5, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 3, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 3, Char_Space, Char_Space, Char_Terrain + 3, 
	}},
	{{
		Char_Terrain + 9, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 4, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Terrain + 4, 
	}},
	{{
		Char_Space, Char_Space, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Terrain + 5, Char_Terrain + 5, 
	}},
	{{
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 5, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 5, 
	}},
	{{
		Char_Terrain + 5, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Terrain + 0, Char_Space, Char_Space, Char_Terrain + 2, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 0, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 5, Char_Space, Char_Space, Char_Terrain + 5, 
	}},
	{{
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
	}},
	{{
		Char_Terrain + 6, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 6, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Terrain + 7, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 7, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Terrain + 3, Char_Terrain + 3, Char_Space, 
		Char_Space, Char_Terrain + 3, Char_Terrain + 3, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Space, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
	}},
	{{
		Char_Space, Char_Space, Char_Space, Char_Terrain + 2, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Terrain + 1, 
	}},
	{{
		Char_Terrain + 9, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Space, Char_Space, Char_Space, Char_Space, 
		Char_Terrain + 8, Char_Space, Char_Space, Char_Space, 
	}},
};

static const SkyElement[] SkyElements0 = {
	{ 252, 0x01 },
	{ 192, 0x00 },
	{ 188, 0x02 },
	{ 128, 0x00 },
	{ 124, 0x08 },
	{ 92, 0x00 },
	{ 88, 0x04 },
	{ 28, 0x00 },
	{ 24, 0x01 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements1 = {
	{ 252, 0x01 },
	{ 188, 0x03 },
	{ 172, 0x02 },
	{ 152, 0x0a },
	{ 108, 0x08 },
	{ 72, 0x00 },
	{ 68, 0x04 },
	{ 40, 0x05 },
	{ 32, 0x01 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements2 = {
	{ 252, 0x01 },
	{ 204, 0x03 },
	{ 156, 0x02 },
	{ 152, 0x0a },
	{ 92, 0x08 },
	{ 88, 0x0c },
	{ 72, 0x04 },
	{ 40, 0x05 },
	{ 16, 0x01 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements3 = {
	{ 252, 0x01 },
	{ 220, 0x03 },
	{ 140, 0x02 },
	{ 104, 0x06 },
	{ 76, 0x04 },
	{ 32, 0x0c },
	{ 4, 0x08 },
	{ 0, 0x00 },
};

static const SkyElement[] SkyElements4 = {
	{ 252, 0x01 },
	{ 236, 0x03 },
	{ 148, 0x0b },
	{ 124, 0x0a },
	{ 120, 0x0e },
	{ 80, 0x06 },
	{ 60, 0x04 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements5 = {
	{ 252, 0x01 },
	{ 248, 0x03 },
	{ 148, 0x0b },
	{ 136, 0x0f },
	{ 108, 0x0e },
	{ 92, 0x06 },
	{ 44, 0x04 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements6 = {
	{ 252, 0x01 },
	{ 248, 0x03 },
	{ 152, 0x07 },
	{ 132, 0x0f },
	{ 92, 0x0e },
	{ 88, 0x06 },
	{ 28, 0x04 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements7 = {
	{ 252, 0x01 },
	{ 248, 0x03 },
	{ 184, 0x07 },
	{ 76, 0x06 },
	{ 44, 0x0e },
	{ 16, 0x06 },
	{ 12, 0x04 },
	{ 0, 0x00 },
};

static const SkyElement[] SkyElements8 = {
	{ 252, 0x01 },
	{ 248, 0x03 },
	{ 200, 0x07 },
	{ 148, 0x0f },
	{ 80, 0x07 },
	{ 60, 0x06 },
	{ 4, 0x04 },
	{ 0, 0x00 },
};

static const SkyElement[] SkyElements9 = {
	{ 252, 0x01 },
	{ 248, 0x03 },
	{ 244, 0x07 },
	{ 148, 0x0f },
	{ 80, 0x07 },
	{ 8, 0x06 },
	{ 4, 0x04 },
	{ 0, 0x00 },
};

static const Route[] Route0B1 = {
	{ 1, 0, 28 },
	{ -1, 0, 30 },
};

static const Route[] Route0A3 = {
};

static const Route[] Route0B4 = {
	{ 1, 0, 12 },
	{ -1, 0, 14 },
};

static const Route[] Route0A18 = {
};

static const Route[] Route0A24 = {
};

static const Route[] Route0A17 = {
};

static const Route[] Route0A19 = {
};

static const Route[] Route0A23 = {
};

static const Route[] Route0A5 = {
};

static const Route[] Route0A16 = {
};

static const Route[] Route0A10 = {
};

static const Route[] Route0A11 = {
};

static const Route[] Route0B0 = {
	{ 1, 0, 28 },
	{ 0, 1, 12 },
	{ 1, 0, 99 },
};

static const Route[] Route0A25 = {
};

static const Route[] Route0A7 = {
};

static const Route[] Route0A0 = {
};

static const Route[] Route0A14 = {
};

static const Route[] Route0A8 = {
};

static const Route[] Route0B2 = {
	{ 0, 1, 52 },
};

static const Route[] Route0A13 = {
};

static const Route[] Route0B3 = {
	{ -1, 0, 30 },
};

static const Route[] Route0A20 = {
};

static const Route[] Route0A12 = {
};

static const Route[] Route0A26 = {
};

static const Route[] Route0A21 = {
};

static const Route[] Route0A15 = {
};

static const Route[] Route0B5 = {
	{ 0, 1, 20 },
	{ 1, 0, 115 },
};

static const Route[] Route1A7 = {
};

static const Route[] Route1A14 = {
};

static const Route[] Route1B1 = {
	{ 0, 1, 24 },
	{ 1, 0, 115 },
};

static const Route[] Route1B4 = {
	{ 1, 0, 28 },
	{ 0, -1, 40 },
};

static const Route[] Route1A8 = {
};

static const Route[] Route1B2 = {
	{ -1, 0, 16 },
	{ 0, -1, 52 },
	{ -1, 0, 2 },
};

static const Route[] Route1A6 = {
};

static const Route[] Route1A2 = {
};

static const Route[] Route1B3 = {
	{ -1, 0, 16 },
	{ 0, 1, 36 },
};

static const Route[] Route1A17 = {
};

static const Route[] Route1A16 = {
};

static const Route[] Route1A5 = {
};

static const Route[] Route1A12 = {
};

static const Route[] Route1A15 = {
};

static const Route[] Route1A10 = {
};

static const Route[] Route1B5 = {
	{ -1, 0, 30 },
};

static const Route[] Route1B0 = {
	{ 0, 1, 24 },
	{ 1, 0, 127 },
};

static const Route[] Route1A9 = {
};

static const Route[] Route2A3 = {
};

static const Route[] Route2B1 = {
	{ 0, 1, 24 },
	{ 1, 0, 107 },
};

static const Route[] Route2B4 = {
	{ 1, 0, 127 },
};

static const Route[] Route2A18 = {
};

static const Route[] Route2A24 = {
};

static const Route[] Route2A17 = {
};

static const Route[] Route2A19 = {
};

static const Route[] Route2A23 = {
};

static const Route[] Route2A10 = {
};

static const Route[] Route2A11 = {
};

static const Route[] Route2B0 = {
	{ -1, 0, 20 },
	{ 0, -1, 12 },
	{ -1, 0, 10 },
};

static const Route[] Route2A22 = {
};

static const Route[] Route2A7 = {
};

static const Route[] Route2A0 = {
};

static const Route[] Route2A14 = {
};

static const Route[] Route2A8 = {
};

static const Route[] Route2B2 = {
	{ -1, 0, 16 },
	{ 0, -1, 52 },
	{ -1, 0, 10 },
};

static const Route[] Route2A6 = {
};

static const Route[] Route2A13 = {
};

static const Route[] Route2B3 = {
	{ -1, 0, 16 },
	{ 0, 1, 36 },
};

static const Route[] Route2A20 = {
};

static const Route[] Route2A12 = {
};

static const Route[] Route2A21 = {
};

static const Route[] Route2B5 = {
	{ -1, 0, 24 },
	{ 0, 1, 28 },
};

static const Route[] Route2A9 = {
};

static const Route[] Route3B1 = {
	{ 1, 0, 4 },
	{ 0, -1, 44 },
	{ 1, 0, 12 },
	{ 0, 1, 56 },
};

static const Route[] Route3B4 = {
	{ -1, 0, 4 },
	{ 0, -1, 76 },
	{ -1, 0, 26 },
};

static const Route[] Route3A18 = {
};

static const Route[] Route3A29 = {
};

static const Route[] Route3A24 = {
};

static const Route[] Route3A30 = {
};

static const Route[] Route3A2 = {
};

static const Route[] Route3A23 = {
};

static const Route[] Route3A16 = {
};

static const Route[] Route3A32 = {
};

static const Route[] Route3A10 = {
};

static const Route[] Route3B0 = {
	{ -1, 0, 24 },
	{ 0, -1, 36 },
	{ -1, 0, 6 },
};

static const Route[] Route3A22 = {
};

static const Route[] Route3A25 = {
};

static const Route[] Route3A7 = {
};

static const Route[] Route3A0 = {
};

static const Route[] Route3A14 = {
};

static const Route[] Route3A8 = {
};

static const Route[] Route3B2 = {
	{ 0, -1, 96 },
	{ 1, 0, 111 },
};

static const Route[] Route3A6 = {
};

static const Route[] Route3A1 = {
};

static const Route[] Route3A13 = {
};

static const Route[] Route3B3 = {
	{ 1, 0, 16 },
	{ 0, -1, 16 },
	{ 1, 0, 111 },
};

static const Route[] Route3A28 = {
};

static const Route[] Route3A20 = {
};

static const Route[] Route3A31 = {
};

static const Route[] Route3A27 = {
};

static const Route[] Route3A12 = {
};

static const Route[] Route3A26 = {
};

static const Route[] Route3A21 = {
};

static const Route[] Route3A15 = {
};

static const Route[] Route3B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 44 },
	{ 1, 0, 103 },
};

static const Route[] Route3A9 = {
};

static const Route[] Route4B1 = {
	{ 0, -1, 4 },
	{ 1, 0, 127 },
};

static const Route[] Route4A3 = {
};

static const Route[] Route4A18 = {
};

static const Route[] Route4A24 = {
};

static const Route[] Route4A17 = {
};

static const Route[] Route4A23 = {
};

static const Route[] Route4A5 = {
};

static const Route[] Route4A16 = {
};

static const Route[] Route4A10 = {
};

static const Route[] Route4B0 = {
	{ -1, 0, 8 },
	{ 0, 1, 12 },
	{ -1, 0, 20 },
	{ 0, -1, 24 },
};

static const Route[] Route4A22 = {
};

static const Route[] Route4A25 = {
};

static const Route[] Route4A7 = {
};

static const Route[] Route4A0 = {
};

static const Route[] Route4A14 = {
};

static const Route[] Route4B2 = {
	{ 1, 0, 115 },
};

static const Route[] Route4A6 = {
};

static const Route[] Route4A1 = {
};

static const Route[] Route4A13 = {
};

static const Route[] Route4B3 = {
	{ -1, 0, 30 },
	{ 1, 0, 18 },
	{ -1, 0, 18 },
};

static const Route[] Route4A20 = {
};

static const Route[] Route4A27 = {
};

static const Route[] Route4A12 = {
};

static const Route[] Route4A26 = {
};

static const Route[] Route4A21 = {
};

static const Route[] Route4A15 = {
};

static const Route[] Route4A4 = {
};

static const Route[] Route4A9 = {
};

static const Route[] Route5B1 = {
	{ -1, 0, 8 },
	{ 0, -1, 28 },
	{ 1, 0, 107 },
};

static const Route[] Route5B4 = {
	{ 1, 0, 127 },
};

static const Route[] Route5A18 = {
};

static const Route[] Route5A29 = {
};

static const Route[] Route5A24 = {
};

static const Route[] Route5A30 = {
};

static const Route[] Route5A17 = {
};

static const Route[] Route5A19 = {
};

static const Route[] Route5A23 = {
};

static const Route[] Route5A5 = {
};

static const Route[] Route5A16 = {
};

static const Route[] Route5A32 = {
};

static const Route[] Route5A10 = {
};

static const Route[] Route5B0 = {
	{ -1, 0, 8 },
	{ 0, -1, 12 },
	{ -1, 0, 22 },
};

static const Route[] Route5A22 = {
};

static const Route[] Route5A25 = {
};

static const Route[] Route5A0 = {
};

static const Route[] Route5A14 = {
};

static const Route[] Route5A8 = {
};

static const Route[] Route5A6 = {
};

static const Route[] Route5A1 = {
};

static const Route[] Route5A13 = {
};

static const Route[] Route5B3 = {
	{ 1, 0, 20 },
	{ 0, 1, 32 },
};

static const Route[] Route5A28 = {
};

static const Route[] Route5A20 = {
};

static const Route[] Route5A31 = {
};

static const Route[] Route5A27 = {
};

static const Route[] Route5A12 = {
};

static const Route[] Route5A21 = {
};

static const Route[] Route5A15 = {
};

static const Route[] Route5A4 = {
};

static const Route[] Route5B5 = {
	{ 1, 0, 127 },
};

static const Route[] Route5A9 = {
};

static const Route[] Route6B1 = {
	{ -1, 0, 4 },
	{ 0, -1, 32 },
	{ 1, 0, 103 },
};

static const Route[] Route6A3 = {
};

static const Route[] Route6B4 = {
	{ 1, 0, 8 },
	{ 0, -1, 28 },
	{ -1, 0, 10 },
};

static const Route[] Route6A18 = {
};

static const Route[] Route6A24 = {
};

static const Route[] Route6A19 = {
};

static const Route[] Route6A23 = {
};

static const Route[] Route6A16 = {
};

static const Route[] Route6A11 = {
};

static const Route[] Route6B0 = {
	{ 1, 0, 24 },
	{ 0, 1, 12 },
	{ 1, 0, 103 },
};

static const Route[] Route6A22 = {
};

static const Route[] Route6A25 = {
};

static const Route[] Route6A7 = {
};

static const Route[] Route6A0 = {
};

static const Route[] Route6A8 = {
};

static const Route[] Route6B2 = {
	{ -1, 0, 26 },
};

static const Route[] Route6A6 = {
};

static const Route[] Route6A1 = {
};

static const Route[] Route6A13 = {
};

static const Route[] Route6B3 = {
	{ 1, 0, 8 },
	{ 0, -1, 28 },
	{ -1, 0, 10 },
};

static const Route[] Route6A20 = {
};

static const Route[] Route6A12 = {
};

static const Route[] Route6A21 = {
};

static const Route[] Route6A15 = {
};

static const Route[] Route6A4 = {
};

static const Route[] Route6B5 = {
	{ -1, 0, 8 },
	{ 0, -1, 28 },
	{ 1, 0, 107 },
};

static const Route[] Route7B1 = {
	{ 1, 0, 8 },
	{ 0, -1, 28 },
	{ -1, 0, 10 },
};

static const Route[] Route7A3 = {
};

static const Route[] Route7B4 = {
	{ -1, 0, 20 },
	{ 0, 1, 72 },
};

static const Route[] Route7A18 = {
};

static const Route[] Route7A29 = {
};

static const Route[] Route7A24 = {
};

static const Route[] Route7A30 = {
};

static const Route[] Route7B7 = {
	{ -1, 0, 12 },
	{ 0, -1, 20 },
	{ 1, 0, 111 },
};

static const Route[] Route7A2 = {
};

static const Route[] Route7A17 = {
};

static const Route[] Route7A19 = {
};

static const Route[] Route7A16 = {
};

static const Route[] Route7A32 = {
};

static const Route[] Route7A10 = {
};

static const Route[] Route7A11 = {
};

static const Route[] Route7A33 = {
};

static const Route[] Route7B0 = {
	{ -1, 0, 30 },
};

static const Route[] Route7A25 = {
};

static const Route[] Route7A0 = {
};

static const Route[] Route7B8 = {
	{ 1, 0, 16 },
	{ 0, 1, 72 },
};

static const Route[] Route7A14 = {
};

static const Route[] Route7A36 = {
};

static const Route[] Route7A35 = {
};

static const Route[] Route7B2 = {
	{ 1, 0, 8 },
	{ 0, 1, 52 },
};

static const Route[] Route7A1 = {
};

static const Route[] Route7A13 = {
};

static const Route[] Route7B3 = {
	{ 1, 0, 8 },
	{ 0, 1, 60 },
};

static const Route[] Route7A20 = {
};

static const Route[] Route7A34 = {
};

static const Route[] Route7A31 = {
};

static const Route[] Route7A27 = {
};

static const Route[] Route7B6 = {
	{ -1, 0, 12 },
	{ 0, -1, 16 },
	{ 1, 0, 111 },
};

static const Route[] Route7A12 = {
};

static const Route[] Route7A26 = {
};

static const Route[] Route7A21 = {
};

static const Route[] Route7A15 = {
};

static const Route[] Route7B5 = {
	{ -1, 0, 20 },
	{ 0, 1, 84 },
};

static const Route[] Route8B1 = {
	{ -1, 0, 12 },
	{ 0, -1, 32 },
	{ 1, 0, 111 },
};

static const Route[] Route8A3 = {
};

static const Route[] Route8B4 = {
	{ -1, 0, 16 },
	{ 0, 1, 28 },
	{ 1, 0, 115 },
};

static const Route[] Route8A18 = {
};

static const Route[] Route8A19 = {
};

static const Route[] Route8A23 = {
};

static const Route[] Route8A5 = {
};

static const Route[] Route8A16 = {
};

static const Route[] Route8A10 = {
};

static const Route[] Route8B0 = {
	{ 1, 0, 16 },
	{ 0, 1, 12 },
	{ 1, 0, 12 },
	{ 0, -1, 24 },
};

static const Route[] Route8A22 = {
};

static const Route[] Route8A7 = {
};

static const Route[] Route8A0 = {
};

static const Route[] Route8A14 = {
};

static const Route[] Route8A8 = {
};

static const Route[] Route8A1 = {
};

static const Route[] Route8A13 = {
};

static const Route[] Route8B3 = {
	{ -1, 0, 16 },
	{ 0, -1, 84 },
	{ 1, 0, 127 },
};

static const Route[] Route8A20 = {
};

static const Route[] Route8A12 = {
};

static const Route[] Route8A21 = {
};

static const Route[] Route8A15 = {
};

static const Route[] Route8A4 = {
};

static const Route[] Route8A9 = {
};

static const Route[] Route9B1 = {
	{ 1, 0, 119 },
};

static const Route[] Route9A3 = {
};

static const Route[] Route9B4 = {
	{ -1, 0, 30 },
};

static const Route[] Route9A18 = {
};

static const Route[] Route9A29 = {
};

static const Route[] Route9A24 = {
};

static const Route[] Route9A30 = {
};

static const Route[] Route9A2 = {
};

static const Route[] Route9A17 = {
};

static const Route[] Route9A19 = {
};

static const Route[] Route9A23 = {
};

static const Route[] Route9A5 = {
};

static const Route[] Route9A16 = {
};

static const Route[] Route9A32 = {
};

static const Route[] Route9A10 = {
};

static const Route[] Route9A11 = {
};

static const Route[] Route9A33 = {
};

static const Route[] Route9B0 = {
	{ 1, 0, 16 },
	{ 0, -1, 12 },
	{ 1, 0, 111 },
};

static const Route[] Route9A25 = {
};

static const Route[] Route9A7 = {
};

static const Route[] Route9A0 = {
};

static const Route[] Route9A14 = {
};

static const Route[] Route9B2 = {
	{ 1, 0, 119 },
};

static const Route[] Route9A6 = {
};

static const Route[] Route9B3 = {
	{ 1, 0, 12 },
	{ 0, -1, 28 },
	{ -1, 0, 14 },
};

static const Route[] Route9A28 = {
};

static const Route[] Route9A20 = {
};

static const Route[] Route9A31 = {
};

static const Route[] Route9A12 = {
};

static const Route[] Route9A26 = {
};

static const Route[] Route9A21 = {
};

static const Route[] Route9A15 = {
};

static const Route[] Route9A4 = {
};

static const Route[] Route9A9 = {
};

static const GroundElement[] GroundElements0 = {
	{ // A0
		25, 241,
		0,
		Route0A0
	},
	{ // B0
		1, 229,
		3,
		Route0B0
	},
	{ // A3
		13, 221,
		0,
		Route0A3
	},
	{ // B4
		1, 217,
		2,
		Route0B4
	},
	{ // A5
		9, 213,
		0,
		Route0A5
	},
	{ // B1
		1, 205,
		2,
		Route0B1
	},
	{ // A7
		5, 193,
		0,
		Route0A7
	},
	{ // B2
		29, 185,
		1,
		Route0B2
	},
	{ // A8
		25, 181,
		0,
		Route0A8
	},
	{ // B3
		29, 173,
		1,
		Route0B3
	},
	{ // A10
		29, 165,
		0,
		Route0A10
	},
	{ // A11
		9, 161,
		0,
		Route0A11
	},
	{ // A12
		29, 153,
		0,
		Route0A12
	},
	{ // A13
		17, 133,
		0,
		Route0A13
	},
	{ // A14
		13, 129,
		0,
		Route0A14
	},
	{ // A15
		21, 97,
		0,
		Route0A15
	},
	{ // A16
		17, 93,
		0,
		Route0A16
	},
	{ // A17
		9, 77,
		0,
		Route0A17
	},
	{ // A18
		29, 73,
		0,
		Route0A18
	},
	{ // A19
		29, 69,
		0,
		Route0A19
	},
	{ // A20
		1, 49,
		0,
		Route0A20
	},
	{ // A21
		9, 49,
		0,
		Route0A21
	},
	{ // A23
		1, 41,
		0,
		Route0A23
	},
	{ // A24
		9, 41,
		0,
		Route0A24
	},
	{ // B5
		13, 29,
		2,
		Route0B5
	},
	{ // A25
		1, 17,
		0,
		Route0A25
	},
	{ // A26
		1, 13,
		0,
		Route0A26
	},
};

static const GroundElement[] GroundElements1 = {
	{ // A2
		25, 225,
		0,
		Route1A2
	},
	{ // B0
		1, 217,
		2,
		Route1B0
	},
	{ // B1
		13, 217,
		2,
		Route1B1
	},
	{ // B2
		17, 205,
		3,
		Route1B2
	},
	{ // A5
		13, 189,
		0,
		Route1A5
	},
	{ // B3
		17, 173,
		2,
		Route1B3
	},
	{ // A6
		29, 165,
		0,
		Route1A6
	},
	{ // A7
		5, 149,
		0,
		Route1A7
	},
	{ // A8
		5, 117,
		0,
		Route1A8
	},
	{ // A9
		25, 117,
		0,
		Route1A9
	},
	{ // A10
		5, 73,
		0,
		Route1A10
	},
	{ // B4
		1, 69,
		2,
		Route1B4
	},
	{ // A12
		5, 49,
		0,
		Route1A12
	},
	{ // B5
		29, 41,
		1,
		Route1B5
	},
	{ // A14
		17, 33,
		0,
		Route1A14
	},
	{ // A15
		25, 17,
		0,
		Route1A15
	},
	{ // A16
		1, 5,
		0,
		Route1A16
	},
	{ // A17
		29, 1,
		0,
		Route1A17
	},
};

static const GroundElement[] GroundElements2 = {
	{ // A0
		13, 249,
		0,
		Route2A0
	},
	{ // B0
		29, 241,
		3,
		Route2B0
	},
	{ // A3
		25, 221,
		0,
		Route2A3
	},
	{ // B1
		21, 217,
		2,
		Route2B1
	},
	{ // B2
		25, 205,
		3,
		Route2B2
	},
	{ // A6
		13, 197,
		0,
		Route2A6
	},
	{ // A7
		5, 189,
		0,
		Route2A7
	},
	{ // B3
		25, 173,
		2,
		Route2B3
	},
	{ // A8
		21, 169,
		0,
		Route2A8
	},
	{ // A9
		21, 153,
		0,
		Route2A9
	},
	{ // A10
		13, 145,
		0,
		Route2A10
	},
	{ // A11
		1, 133,
		0,
		Route2A11
	},
	{ // A12
		1, 121,
		0,
		Route2A12
	},
	{ // A13
		13, 117,
		0,
		Route2A13
	},
	{ // A14
		9, 93,
		0,
		Route2A14
	},
	{ // B4
		1, 69,
		1,
		Route2B4
	},
	{ // A17
		13, 61,
		0,
		Route2A17
	},
	{ // A18
		13, 53,
		0,
		Route2A18
	},
	{ // A19
		17, 49,
		0,
		Route2A19
	},
	{ // B5
		29, 41,
		2,
		Route2B5
	},
	{ // A20
		21, 33,
		0,
		Route2A20
	},
	{ // A21
		29, 17,
		0,
		Route2A21
	},
	{ // A22
		1, 13,
		0,
		Route2A22
	},
	{ // A23
		29, 9,
		0,
		Route2A23
	},
	{ // A24
		1, 5,
		0,
		Route2A24
	},
};

static const GroundElement[] GroundElements3 = {
	{ // A0
		5, 253,
		0,
		Route3A0
	},
	{ // A1
		17, 249,
		0,
		Route3A1
	},
	{ // A2
		29, 245,
		0,
		Route3A2
	},
	{ // B0
		29, 241,
		3,
		Route3B0
	},
	{ // B2
		17, 237,
		2,
		Route3B2
	},
	{ // A6
		13, 233,
		0,
		Route3A6
	},
	{ // B1
		1, 229,
		4,
		Route3B1
	},
	{ // A7
		9, 221,
		0,
		Route3A7
	},
	{ // A8
		9, 201,
		0,
		Route3A8
	},
	{ // A9
		29, 201,
		0,
		Route3A9
	},
	{ // A10
		25, 181,
		0,
		Route3A10
	},
	{ // B3
		1, 173,
		3,
		Route3B3
	},
	{ // A12
		5, 165,
		0,
		Route3A12
	},
	{ // A13
		9, 161,
		0,
		Route3A13
	},
	{ // A14
		5, 157,
		0,
		Route3A14
	},
	{ // A15
		9, 153,
		0,
		Route3A15
	},
	{ // A16
		9, 141,
		0,
		Route3A16
	},
	{ // B4
		29, 125,
		3,
		Route3B4
	},
	{ // A18
		17, 113,
		0,
		Route3A18
	},
	{ // B5
		29, 109,
		3,
		Route3B5
	},
	{ // A20
		13, 105,
		0,
		Route3A20
	},
	{ // A21
		17, 97,
		0,
		Route3A21
	},
	{ // A22
		9, 85,
		0,
		Route3A22
	},
	{ // A23
		5, 73,
		0,
		Route3A23
	},
	{ // A24
		9, 73,
		0,
		Route3A24
	},
	{ // A25
		5, 69,
		0,
		Route3A25
	},
	{ // A26
		9, 69,
		0,
		Route3A26
	},
	{ // A27
		17, 57,
		0,
		Route3A27
	},
	{ // A28
		29, 41,
		0,
		Route3A28
	},
	{ // A29
		13, 33,
		0,
		Route3A29
	},
	{ // A30
		9, 9,
		0,
		Route3A30
	},
	{ // A31
		21, 5,
		0,
		Route3A31
	},
	{ // A32
		1, 1,
		0,
		Route3A32
	},
};

static const GroundElement[] GroundElements4 = {
	{ // A0
		9, 253,
		0,
		Route4A0
	},
	{ // A1
		25, 249,
		0,
		Route4A1
	},
	{ // A3
		17, 233,
		0,
		Route4A3
	},
	{ // B0
		29, 229,
		4,
		Route4B0
	},
	{ // A4
		9, 225,
		0,
		Route4A4
	},
	{ // A5
		25, 221,
		0,
		Route4A5
	},
	{ // A6
		21, 217,
		0,
		Route4A6
	},
	{ // A7
		25, 213,
		0,
		Route4A7
	},
	{ // B1
		1, 209,
		2,
		Route4B1
	},
	{ // A9
		29, 185,
		0,
		Route4A9
	},
	{ // A10
		5, 181,
		0,
		Route4A10
	},
	{ // B2
		13, 173,
		1,
		Route4B2
	},
	{ // A12
		25, 169,
		0,
		Route4A12
	},
	{ // A13
		21, 157,
		0,
		Route4A13
	},
	{ // A14
		17, 129,
		0,
		Route4A14
	},
	{ // A15
		21, 125,
		0,
		Route4A15
	},
	{ // A16
		13, 121,
		0,
		Route4A16
	},
	{ // A17
		21, 117,
		0,
		Route4A17
	},
	{ // A18
		17, 113,
		0,
		Route4A18
	},
	{ // A20
		21, 65,
		0,
		Route4A20
	},
	{ // A21
		13, 61,
		0,
		Route4A21
	},
	{ // A22
		29, 49,
		0,
		Route4A22
	},
	{ // B3
		29, 41,
		3,
		Route4B3
	},
	{ // A23
		9, 33,
		0,
		Route4A23
	},
	{ // A24
		5, 21,
		0,
		Route4A24
	},
	{ // A25
		29, 17,
		0,
		Route4A25
	},
	{ // A26
		25, 13,
		0,
		Route4A26
	},
	{ // A27
		9, 9,
		0,
		Route4A27
	},
};

static const GroundElement[] GroundElements5 = {
	{ // A0
		5, 253,
		0,
		Route5A0
	},
	{ // A1
		25, 249,
		0,
		Route5A1
	},
	{ // B0
		29, 241,
		3,
		Route5B0
	},
	{ // A4
		1, 221,
		0,
		Route5A4
	},
	{ // A5
		5, 217,
		0,
		Route5A5
	},
	{ // A6
		1, 213,
		0,
		Route5A6
	},
	{ // B1
		29, 213,
		3,
		Route5B1
	},
	{ // B3
		1, 205,
		2,
		Route5B3
	},
	{ // A8
		25, 197,
		0,
		Route5A8
	},
	{ // A9
		9, 193,
		0,
		Route5A9
	},
	{ // A10
		13, 181,
		0,
		Route5A10
	},
	{ // B4
		1, 173,
		1,
		Route5B4
	},
	{ // A12
		21, 165,
		0,
		Route5A12
	},
	{ // A13
		25, 161,
		0,
		Route5A13
	},
	{ // A14
		21, 157,
		0,
		Route5A14
	},
	{ // A15
		25, 153,
		0,
		Route5A15
	},
	{ // A16
		9, 133,
		0,
		Route5A16
	},
	{ // A17
		5, 129,
		0,
		Route5A17
	},
	{ // A18
		25, 117,
		0,
		Route5A18
	},
	{ // A19
		9, 97,
		0,
		Route5A19
	},
	{ // A20
		13, 93,
		0,
		Route5A20
	},
	{ // A21
		25, 85,
		0,
		Route5A21
	},
	{ // A22
		5, 77,
		0,
		Route5A22
	},
	{ // A23
		25, 73,
		0,
		Route5A23
	},
	{ // A24
		21, 69,
		0,
		Route5A24
	},
	{ // A25
		9, 57,
		0,
		Route5A25
	},
	{ // B5
		1, 49,
		1,
		Route5B5
	},
	{ // A27
		1, 45,
		0,
		Route5A27
	},
	{ // A28
		5, 41,
		0,
		Route5A28
	},
	{ // A29
		9, 17,
		0,
		Route5A29
	},
	{ // A30
		1, 13,
		0,
		Route5A30
	},
	{ // A31
		25, 9,
		0,
		Route5A31
	},
	{ // A32
		29, 5,
		0,
		Route5A32
	},
};

static const GroundElement[] GroundElements6 = {
	{ // A0
		13, 253,
		0,
		Route6A0
	},
	{ // A1
		17, 241,
		0,
		Route6A1
	},
	{ // B0
		1, 229,
		3,
		Route6B0
	},
	{ // A3
		29, 225,
		0,
		Route6A3
	},
	{ // A4
		9, 221,
		0,
		Route6A4
	},
	{ // B1
		29, 205,
		3,
		Route6B1
	},
	{ // A6
		17, 193,
		0,
		Route6A6
	},
	{ // A7
		13, 173,
		0,
		Route6A7
	},
	{ // A8
		5, 161,
		0,
		Route6A8
	},
	{ // B3
		1, 153,
		3,
		Route6B3
	},
	{ // B2
		25, 153,
		1,
		Route6B2
	},
	{ // A11
		1, 141,
		0,
		Route6A11
	},
	{ // A12
		17, 117,
		0,
		Route6A12
	},
	{ // A13
		1, 105,
		0,
		Route6A13
	},
	{ // B4
		1, 97,
		3,
		Route6B4
	},
	{ // A15
		21, 85,
		0,
		Route6A15
	},
	{ // A16
		5, 77,
		0,
		Route6A16
	},
	{ // B5
		29, 69,
		3,
		Route6B5
	},
	{ // A18
		5, 61,
		0,
		Route6A18
	},
	{ // A19
		9, 57,
		0,
		Route6A19
	},
	{ // A20
		13, 53,
		0,
		Route6A20
	},
	{ // A21
		17, 49,
		0,
		Route6A21
	},
	{ // A22
		25, 17,
		0,
		Route6A22
	},
	{ // A23
		13, 13,
		0,
		Route6A23
	},
	{ // A24
		9, 9,
		0,
		Route6A24
	},
	{ // A25
		5, 5,
		0,
		Route6A25
	},
};

static const GroundElement[] GroundElements7 = {
	{ // A0
		25, 253,
		0,
		Route7A0
	},
	{ // A1
		5, 249,
		0,
		Route7A1
	},
	{ // A2
		29, 249,
		0,
		Route7A2
	},
	{ // A3
		1, 245,
		0,
		Route7A3
	},
	{ // B1
		1, 241,
		3,
		Route7B1
	},
	{ // B0
		29, 241,
		1,
		Route7B0
	},
	{ // A10
		5, 221,
		0,
		Route7A10
	},
	{ // A11
		17, 221,
		0,
		Route7A11
	},
	{ // A12
		21, 201,
		0,
		Route7A12
	},
	{ // A13
		5, 197,
		0,
		Route7A13
	},
	{ // A14
		25, 193,
		0,
		Route7A14
	},
	{ // B2
		1, 185,
		2,
		Route7B2
	},
	{ // A15
		17, 177,
		0,
		Route7A15
	},
	{ // B3
		1, 173,
		2,
		Route7B3
	},
	{ // A16
		1, 165,
		0,
		Route7A16
	},
	{ // A17
		25, 165,
		0,
		Route7A17
	},
	{ // B4
		29, 157,
		2,
		Route7B4
	},
	{ // A18
		1, 153,
		0,
		Route7A18
	},
	{ // A19
		17, 149,
		0,
		Route7A19
	},
	{ // A20
		25, 149,
		0,
		Route7A20
	},
	{ // B5
		29, 141,
		2,
		Route7B5
	},
	{ // A21
		5, 129,
		0,
		Route7A21
	},
	{ // B6
		29, 125,
		3,
		Route7B6
	},
	{ // A24
		29, 113,
		0,
		Route7A24
	},
	{ // A25
		5, 105,
		0,
		Route7A25
	},
	{ // A26
		9, 101,
		0,
		Route7A26
	},
	{ // A27
		1, 85,
		0,
		Route7A27
	},
	{ // B7
		29, 85,
		3,
		Route7B7
	},
	{ // A29
		1, 69,
		0,
		Route7A29
	},
	{ // A30
		9, 57,
		0,
		Route7A30
	},
	{ // B8
		1, 49,
		2,
		Route7B8
	},
	{ // A31
		25, 45,
		0,
		Route7A31
	},
	{ // A32
		21, 41,
		0,
		Route7A32
	},
	{ // A33
		1, 9,
		0,
		Route7A33
	},
	{ // A34
		5, 5,
		0,
		Route7A34
	},
	{ // A35
		1, 1,
		0,
		Route7A35
	},
	{ // A36
		25, 1,
		0,
		Route7A36
	},
};

static const GroundElement[] GroundElements8 = {
	{ // A0
		21, 249,
		0,
		Route8A0
	},
	{ // A1
		5, 245,
		0,
		Route8A1
	},
	{ // A3
		13, 237,
		0,
		Route8A3
	},
	{ // B0
		1, 229,
		4,
		Route8B0
	},
	{ // A4
		25, 225,
		0,
		Route8A4
	},
	{ // A5
		13, 221,
		0,
		Route8A5
	},
	{ // B1
		29, 205,
		3,
		Route8B1
	},
	{ // A7
		25, 193,
		0,
		Route8A7
	},
	{ // A8
		29, 177,
		0,
		Route8A8
	},
	{ // A9
		9, 173,
		0,
		Route8A9
	},
	{ // A10
		5, 161,
		0,
		Route8A10
	},
	{ // B3
		17, 153,
		3,
		Route8B3
	},
	{ // A12
		25, 153,
		0,
		Route8A12
	},
	{ // A13
		9, 133,
		0,
		Route8A13
	},
	{ // A14
		5, 121,
		0,
		Route8A14
	},
	{ // A15
		9, 105,
		0,
		Route8A15
	},
	{ // A16
		13, 89,
		0,
		Route8A16
	},
	{ // A18
		5, 57,
		0,
		Route8A18
	},
	{ // A19
		21, 53,
		0,
		Route8A19
	},
	{ // B4
		29, 41,
		3,
		Route8B4
	},
	{ // A20
		29, 21,
		0,
		Route8A20
	},
	{ // A21
		5, 9,
		0,
		Route8A21
	},
	{ // A22
		1, 5,
		0,
		Route8A22
	},
	{ // A23
		25, 1,
		0,
		Route8A23
	},
};

static const GroundElement[] GroundElements9 = {
	{ // A0
		5, 249,
		0,
		Route9A0
	},
	{ // B0
		1, 241,
		3,
		Route9B0
	},
	{ // A2
		21, 241,
		0,
		Route9A2
	},
	{ // A3
		13, 233,
		0,
		Route9A3
	},
	{ // A4
		5, 225,
		0,
		Route9A4
	},
	{ // A5
		21, 221,
		0,
		Route9A5
	},
	{ // A6
		17, 217,
		0,
		Route9A6
	},
	{ // A7
		21, 213,
		0,
		Route9A7
	},
	{ // B1
		9, 205,
		1,
		Route9B1
	},
	{ // A9
		9, 201,
		0,
		Route9A9
	},
	{ // A10
		25, 193,
		0,
		Route9A10
	},
	{ // A11
		25, 185,
		0,
		Route9A11
	},
	{ // A12
		1, 177,
		0,
		Route9A12
	},
	{ // B2
		9, 173,
		1,
		Route9B2
	},
	{ // A14
		29, 169,
		0,
		Route9A14
	},
	{ // A15
		21, 161,
		0,
		Route9A15
	},
	{ // A16
		9, 125,
		0,
		Route9A16
	},
	{ // A17
		17, 125,
		0,
		Route9A17
	},
	{ // A18
		9, 117,
		0,
		Route9A18
	},
	{ // A19
		17, 117,
		0,
		Route9A19
	},
	{ // A20
		29, 81,
		0,
		Route9A20
	},
	{ // A21
		13, 73,
		0,
		Route9A21
	},
	{ // B3
		1, 69,
		3,
		Route9B3
	},
	{ // A23
		9, 65,
		0,
		Route9A23
	},
	{ // A24
		9, 57,
		0,
		Route9A24
	},
	{ // A25
		29, 49,
		0,
		Route9A25
	},
	{ // A26
		25, 45,
		0,
		Route9A26
	},
	{ // B4
		29, 41,
		1,
		Route9B4
	},
	{ // A28
		9, 37,
		0,
		Route9A28
	},
	{ // A29
		1, 29,
		0,
		Route9A29
	},
	{ // A30
		1, 21,
		0,
		Route9A30
	},
	{ // A31
		25, 17,
		0,
		Route9A31
	},
	{ // A32
		25, 13,
		0,
		Route9A32
	},
	{ // A33
		1, 5,
		0,
		Route9A33
	},
};

const Stage[] Stages = {
	{
		16,
		10,SkyElements0,
		27,GroundElements0,
	},
	{
		6,
		10,SkyElements1,
		18,GroundElements1,
	},
	{
		4,
		10,SkyElements2,
		25,GroundElements2,
	},
	{
		22,
		8,SkyElements3,
		33,GroundElements3,
	},
	{
		9,
		8,SkyElements4,
		28,GroundElements4,
	},
	{
		18,
		8,SkyElements5,
		33,GroundElements5,
	},
	{
		0,
		8,SkyElements6,
		26,GroundElements6,
	},
	{
		24,
		8,SkyElements7,
		37,GroundElements7,
	},
	{
		2,
		8,SkyElements8,
		24,GroundElements8,
	},
	{
		10,
		8,SkyElements9,
		34,GroundElements9,
	},
};

