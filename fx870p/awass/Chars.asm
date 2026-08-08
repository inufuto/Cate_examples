cseg

AsciiPattern: public AsciiPattern
	; ascii 30
	; " 0123456789=ACEFGHIKMNOPRSTUVY"
	defb &h00,&h00,&h00,&h00,&hf8,&h88,&hf8,&h00
	defb &h00,&h00,&hf8,&h00,&hb8,&ha8,&he8,&h00
	defb &ha8,&ha8,&hf8,&h00,&he0,&h20,&hf8,&h00
	defb &he8,&ha8,&hb8,&h00,&hf8,&ha8,&hb8,&h00
	defb &h80,&hb8,&hc0,&h00,&hf8,&ha8,&hf8,&h00
	defb &he8,&ha8,&hf8,&h00,&h50,&h50,&h50,&h00
	defb &h78,&h90,&h78,&h00,&h70,&h88,&h50,&h00
	defb &hf8,&ha8,&h88,&h00,&hf8,&ha0,&h80,&h00
	defb &h70,&h88,&hb0,&h00,&hf8,&h20,&hf8,&h00
	defb &h88,&hf8,&h88,&h00,&hf8,&h20,&hd8,&h00
	defb &hf8,&h60,&hf8,&h00,&hf8,&h80,&h78,&h00
	defb &h70,&h88,&h70,&h00,&hf8,&ha0,&he0,&h00
	defb &hf8,&ha0,&h58,&h00,&h68,&ha8,&hb0,&h00
	defb &h80,&hf8,&h80,&h00,&hf8,&h08,&hf8,&h00
	defb &hf0,&h08,&hf0,&h00,&hc0,&h38,&hc0,&h00

CharPattern: public CharPattern
;	3dot
	defb &h00,&h00,&h0e,&h40,&h4e,&h00,&h88,&h80
;	6dot
	defb &he8,&ha0,&he8,&he0,&hea,&he0,&hea,&he0
	defb &h00,&he0,&ha4,&ha0,&h02,&he0,&h20,&h00
	defb &h00,&he0,&hec,&h80,&h02,&he0,&h20,&h00
	defb &h00,&he0,&haa,&h40,&h02,&he0,&h20,&h00
	defb &h00,&he0,&he6,&h20,&h02,&he0,&h20,&h00
;	sprite
	defb &h00,&hc0,&he2,&h00,&h00,&h60,&h82,&h00
	defb &h00,&hc0,&he2,&h00,&h08,&h60,&h82,&h20
	defb &h00,&hc0,&he0,&h00,&h00,&h80,&h60,&h00
	defb &h00,&hc0,&he0,&h20,&h08,&h20,&h84,&h20
	defb &h02,&he0,&hc0,&h00,&h02,&h80,&h60,&h00
	defb &h02,&he0,&hc0,&h00,&h22,&h80,&h68,&h00
	defb &h00,&he0,&hc0,&h00,&h00,&h60,&h80,&h00
	defb &h20,&he0,&hc0,&h00,&h24,&h80,&h28,&h00
	defb &h02,&he0,&he2,&h40,&h84,&h80,&h86,&h00
	defb &h42,&he0,&he2,&h00,&h06,&h80,&h84,&h80
	defb &h22,&h60,&h20,&h40,&h88,&h00,&h08,&h80
	defb &h08,&h20,&hc0,&h00,&h08,&he0,&h60,&h00
	defb &h22,&h00,&h02,&h20,&h40,&h80,&hc8,&h80
	defb &h04,&he0,&hc6,&h00,&h08,&hc0,&hec,&h00
	defb &h02,&h60,&h62,&h00,&h44,&he0,&h6e,&h40
	defb &h06,&hc0,&he4,&h00,&h0c,&he0,&hc8,&h00
	defb &h02,&h60,&h62,&h00,&h4e,&h60,&he4,&h40
	defb &h06,&he0,&he6,&h00,&h0c,&he0,&hec,&h00
	defb &h02,&h60,&h62,&h00,&h8e,&he0,&hee,&h80
	defb &h04,&he0,&hc6,&h00,&h0c,&he0,&hec,&h00
	defb &h02,&h60,&h62,&h00,&h4e,&h60,&he6,&h40
	defb &h6a,&h80,&ha8,&h60,&h84,&h20,&h26,&ha0
	defb &h68,&ha0,&h8a,&h60,&ha6,&h20,&h24,&h80
	defb &h06,&h80,&h88,&h60,&h08,&h40,&h24,&h80
	defb &h6a,&h80,&ha6,&h00,&h84,&h20,&h48,&h00
	defb &he0,&he0,&h8e,&h00,&hc0,&hc0,&h4c,&h00
	defb &h4e,&h00,&h0e,&h80,&h4c,&h40,&h0c,&h40
	defb &haa,&he0,&h0e,&h80,&hc4,&h40,&h0c,&h40
	defb &he2,&he0,&h0e,&h80,&h00,&hc0,&h0c,&h40
	defb &hea,&he0,&h0e,&h80,&hc4,&hc0,&h0c,&h40
	defb &h26,&he0,&h42,&h60,&h0c,&h40,&ha4,&h80
