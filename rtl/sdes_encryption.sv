// File: sdes_ecryption.sv
// Author: Adin De'Rosier
// Description: Simplified DES Ecryption module implemented in SystemVerilog.

module sdes_encryption(
    input  wire [7:0] i_plaintext,  // 8-bit input plaintext
    input  wire [7:0] i_key1,       // 8-bit input key 1 (K1)
    input  wire [7:0] i_key2,       // 8-bit input key 2 (K2)
	 output wire [7:0] o_ciphertext  // 8-bit output ciphertext
);

	// Permutation IP
	wire [7:0] pip_key;
	permutation_ip pip(
		.i_signal(i_plaintext),
		.o_signal(pip_key)
	);

	// Permutation Expansion Key 1
	wire [7:0] pep_key1;
	permutation_ep pep1(
		.i_signal(pip_key[3:0]), 
		.o_signal(pep_key1)
	);

	// XOR8 with Key 1
	wire [7:0] xor8_key1 = pep_key1 ^ i_key1;
	
	// Switch S0 and S1 Key 1
	wire [3:0] sw_key1;
	switch_s0 s0_1(
		.i_signal(xor8_key1[7:4]), 
		.o_signal(sw_key1[3:2])
	);
	switch_s1 s1_1(
		.i_signal(xor8_key1[3:0]),
		.o_signal(sw_key1[1:0])
	);
	
	// Permutation P4 Key 1
	wire [3:0] p4_key1;
	permutation_p4 p4_1(
		.i_signal(sw_key1), 
		.o_signal(p4_key1)
	);
	
	// XOR4 with Key 1
	wire [3:0] xor4_key1 = pip_key[7:4] ^ p4_key1;
	
	// Permutation Expansion Key 2
	wire [7:0] pep_key2;
	permutation_ep pip2(
		.i_signal(xor4_key1),
		.o_signal(pep_key2)
	);
	
	// XOR8 with Key 2
	wire [7:0] xor8_key2 = pep_key2 ^ i_key2;
	
	// Switch S0 and S1 Key 2
	wire [3:0] sw_key2;
	switch_s0 s0_2(
		.i_signal(xor8_key2[7:4]),
		.o_signal(sw_key2[3:2])
	);
	switch_s1 s1_2(
		.i_signal(xor8_key2[3:0]), 
		.o_signal(sw_key2[1:0])
	);
	
	// Permutation P4 Key 2
	wire [3:0] p4_key2;
	permutation_p4 p4_2(
		.i_signal(sw_key2), 
		.o_signal(p4_key2)
	);
	
	// XOR4 with Key 2
	wire [3:0] xor4_key2 = pip_key[3:0] ^ p4_key2;
	
	// Permutation Inverse IP
	permutation_inverse_ip piip(
		.i_signal({xor4_key2, xor4_key1}), 
		.o_signal(o_ciphertext)
	);

endmodule
