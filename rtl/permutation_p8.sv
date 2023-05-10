// File: permutation_p8.sv
// Author: Adin De'Rosier
// Description: A 10-bit to 8-bit permutation module implemented in SystemVerilog.

module permutation_p8 (
    input  wire [9:0] i_signal,   // 10-bit input signal
    output wire [7:0] o_signal    // 8-bit output signal
);

	// Assign output signal as a permutation of input signal bits
	assign o_signal = {i_signal[4], i_signal[7], i_signal[3], i_signal[6],
							i_signal[2], i_signal[5], i_signal[0], i_signal[1]};

endmodule
