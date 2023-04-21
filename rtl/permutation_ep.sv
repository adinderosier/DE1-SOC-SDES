module permutation_ep (
	input  wire [3:0] i_signal,
	output wire [7:0] o_signal
);
	assign o_signal = {i_signal[0], i_signal[3], i_signal[2], i_signal[1],
							 i_signal[2], i_signal[1], i_signal[0], i_signal[3]};
endmodule