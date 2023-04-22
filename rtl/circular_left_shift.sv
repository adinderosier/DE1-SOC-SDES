// File: circular_left_shift.sv
// Author: Adin De'Rosier
// Description: A parameterized circular left shift module implemented in SystemVerilog.

module circular_left_shift #(
    parameter NUM_IOBUFS = 5,   // Size of the input and output signals
    parameter NUM_SHIFT  = 1    // Number of bits to shift
) (
    input  wire [NUM_IOBUFS-1:0] i_signal,   // Input signal (Size of NUM_IOBUFS - 1)
    output wire [NUM_IOBUFS-1:0] o_signal    // Output signal (Size of NUM_IOBUFS - 1)
);

genvar i;

// Generate a block of code for each bit of the output signal
generate
	for (i = 0; i < NUM_IOBUFS; i++) begin : generate_block_left_shift
		// Assign the shifted value to the output signal
		assign o_signal[i] = i_signal[(i - NUM_SHIFT + NUM_IOBUFS) % NUM_IOBUFS];
	end
endgenerate

endmodule
