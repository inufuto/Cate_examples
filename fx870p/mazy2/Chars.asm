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
	defb &h00,&h00,&h46,&h60,&h66,&h40,&h0e,&h60
	defb &h0e,&hc0,&h4e,&h40,&h44,&h40,&h0e,&h00
;	point
	defb &h00,&he0,&h00,&hc0,&haa,&he0,&hc4,&h40
	defb &he2,&he0,&h00,&hc0,&hea,&he0,&hc4,&hc0
	defb &h0e,&h80,&h0c,&h40,&he0,&he0,&hc0,&hc0
	defb &h8e,&h00,&h4c,&h00
;	6dot
	defb &h00,&hc0,&he2,&h00,&h00,&h60,&h82,&h00
	defb &h00,&hc0,&he2,&h00,&h08,&h60,&h82,&h20
	defb &h00,&hc0,&he0,&h00,&h00,&h80,&h60,&h00
	defb &h00,&hc0,&he0,&h20,&h08,&h20,&h84,&h20
	defb &h02,&he0,&hc0,&h00,&h02,&h80,&h60,&h00
	defb &h02,&he0,&hc0,&h00,&h22,&h80,&h68,&h00
	defb &h00,&he0,&hc0,&h00,&h00,&h60,&h80,&h00
	defb &h20,&he0,&hc0,&h00,&h24,&h80,&h28,&h00
	defb &h22,&h00,&h02,&h20,&h88,&hc0,&h80,&h40
	defb &h22,&h00,&h42,&h20,&h88,&hc0,&h80,&h60
	defb &h22,&h00,&h20,&h00,&h88,&h80,&h08,&h80
	defb &h22,&h00,&h40,&h20,&h88,&ha0,&h84,&h20
	defb &h22,&h60,&h20,&h40,&h88,&h00,&h08,&h80
	defb &h22,&h60,&h20,&hc0,&h88,&h00,&h48,&h80
	defb &h22,&h20,&h02,&h20,&h88,&h00,&h80,&h00
	defb &h22,&ha0,&h24,&h80,&h88,&h00,&h40,&h80
	defb &h08,&h20,&hc0,&h00,&h08,&he0,&h60,&h00
	defb &h22,&h00,&h02,&h20,&h40,&h80,&hc8,&h80
	defb &h64,&h20,&h46,&h00,&hac,&he0,&hca,&h00
	defb &h6c,&he0,&hc6,&h00,&hac,&he0,&hca,&h00
	defb &h20,&he0,&he0,&h20,&h8c,&he0,&hec,&h80
	defb &h26,&he0,&he6,&h20,&h80,&he0,&he0,&h80
	defb &hee,&he0,&hee,&h00,&hee,&he0,&h6e,&h00
