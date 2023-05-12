module sdes_keygen (
    input  wire [9:0] i_key,       // 10-bit input key
    output wire [7:0] o_key1,      // 8-bit output key 1 (K1)
    output wire [7:0] o_key2       // 8-bit output key 2 (K2)
);

	// Permutation P10
	wire [9:0] p10_key;
	permutation_p10 p10 (
		 .i_signal(i_key),
		 .o_signal(p10_key)
	);

	// Split into two 5-bit halves
	wire [4:0] left_half  = p10_key[9:5];
	wire [4:0] right_half = p10_key[4:0];

	// Perform LS-1 on each half
	wire [4:0] left_ls1, right_ls1;
	circular_left_shift #(
		 .NUM_IOBUFS(5),
		 .NUM_SHIFT(1)
	) ls1_left (
		 .i_signal(left_half),
		 .o_signal(left_ls1)
	);

	circular_left_shift #(
		 .NUM_IOBUFS(5),
		 .NUM_SHIFT(1)
	) ls1_right (
		 .i_signal(right_half),
		 .o_signal(right_ls1)
	);

	// Perform LS-2 on each half
	wire [4:0] left_ls2, right_ls2;
	circular_left_shift #(
		 .NUM_IOBUFS(5),
		 .NUM_SHIFT(2)
	) ls2_left (
		 .i_signal(left_ls1),
		 .o_signal(left_ls2)
	);

	circular_left_shift #(
		 .NUM_IOBUFS(5),
		 .NUM_SHIFT(2)
	) ls2_right (
		 .i_signal(right_ls1),
		 .o_signal(right_ls2)
	);

	// Combine LS-1 halves and apply permutation P8 to generate K1
	wire [9:0] combined_ls1 = {left_ls1, right_ls1};
	permutation_p8 p8_k1 (
		 .i_signal(combined_ls1),
		 .o_signal(o_key1)
	);

	// Combine LS-2 halves and apply permutation P8 to generate K2
	wire [9:0] combined_ls2 = {left_ls2, right_ls2};
	permutation_p8 p8_k2 (
		 .i_signal(combined_ls2),
		 .o_signal(o_key2)
	);

endmodule
