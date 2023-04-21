module switch_s1(
    input  wire [3:0] i_signal,
    output wire [1:0] o_signal
);
	always_comb begin
		 case (i_signal)
			  4'b0000: o_signal = 2'b00; // 0
			  4'b0001: o_signal = 2'b10; // 2
			  4'b0010: o_signal = 2'b01; // 1
			  4'b0011: o_signal = 2'b00; // 0
			  4'b0100: o_signal = 2'b10; // 2
			  4'b0101: o_signal = 2'b01; // 1
			  4'b0110: o_signal = 2'b11; // 3
			  4'b0111: o_signal = 2'b11; // 3
			  4'b1000: o_signal = 2'b11; // 3
			  4'b1001: o_signal = 2'b10; // 2
			  4'b1010: o_signal = 2'b00; // 0
			  4'b1011: o_signal = 2'b01; // 1
			  4'b1100: o_signal = 2'b01; // 1
			  4'b1101: o_signal = 2'b00; // 0
			  4'b1110: o_signal = 2'b00; // 0
			  4'b1111: o_signal = 2'b11; // 3
			  default: o_signal = 2'b11; // Invalid BCD input, set to default value
		 endcase
	end
endmodule