module permutation_inverse_ip(
	input  wire [7:0] i_signal,
	output wire [7:0] o_signal
);
	assign o_signal = {i_signal[4], i_signal[7], i_signal[5], i_signal[3],
							 i_signal[1], i_signal[6], i_signal[0], i_signal[2]};
endmodule