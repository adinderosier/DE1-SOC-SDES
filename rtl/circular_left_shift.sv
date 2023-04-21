module circular_left_shift #(
    parameter NUM_IOBUFS = 5,  // Size of the input and output signals
    parameter NUM_SHIFT  = 1   // Number of bits to shift
) (
    input  wire [NUM_IOBUFS-1:0] i_signal,
    output wire [NUM_IOBUFS-1:0] o_signal
);

genvar i;

generate
	for (i = 0; i < NUM_IOBUFS; i++) begin : generate_block_left_shift
	  assign o_signal[i] = i_signal[(i - NUM_SHIFT + NUM_IOBUFS) % NUM_IOBUFS];
	end
endgenerate

endmodule
