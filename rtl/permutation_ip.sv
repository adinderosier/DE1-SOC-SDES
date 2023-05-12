// File: permutation_ip.sv
// Author: Adin De'Rosier
// Description: A SDES initial permutation (IP) module implemented in SystemVerilog.

module permutation_ip (
    input  wire [7:0] i_signal,   // 8-bit input signal
    output wire [7:0] o_signal    // 8-bit output signal
);

	// Assign output signal as a permutation of input signal bits
	assign o_signal = {i_signal[6], i_signal[2], i_signal[5], i_signal[7],
					   i_signal[4], i_signal[0], i_signal[3], i_signal[1]};
							 
endmodule
