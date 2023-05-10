// File: permutation_p4.sv
// Author: Adin De'Rosier
// Description: A 4-bit permutation module implemented in SystemVerilog.

module permutation_p4(
	input  wire [3:0] i_signal,   // 4-bit input signal
	output wire [3:0] o_signal    // 4-bit output signal
);

	// Assign output signal as a permutation of input signal bits
	assign o_signal = {i_signal[2], i_signal[0],
							i_signal[1], i_signal[3]};

endmodule
