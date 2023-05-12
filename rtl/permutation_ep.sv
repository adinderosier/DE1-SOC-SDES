// File: permutation_ep.sv
// Author: Adin De'Rosier
// Description: A SDES extension permutation (EP) module implemented in SystemVerilog.

module permutation_ep (
	input  wire [3:0] i_signal,   // 4-bit input signal
	output wire [7:0] o_signal    // 8-bit output signal
);

	// Assign output signal as a permutation of input signal bits
	assign o_signal = {i_signal[0], i_signal[3], i_signal[2], i_signal[1],
					   i_signal[2], i_signal[1], i_signal[0], i_signal[3]};
							 
endmodule