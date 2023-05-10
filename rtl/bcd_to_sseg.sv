// File: bcd_to_sseg.sv
// Author: Adin De'Rosier
// Description: A BCD to seven-segment conversion module implemented in SystemVerilog.

module bcd_to_sseg (
    input  wire [3:0] i_bcd,     // 4-bit BCD input
    output wire [6:0] o_sseg     // 7-bit output for seven-segment display
);

    // BCD to seven-segment display conversion using a case statement
    always_comb begin
        case (i_bcd)
            4'b0000: o_sseg = 7'b1000000; // 0
            4'b0001: o_sseg = 7'b1111001; // 1
            4'b0010: o_sseg = 7'b0100100; // 2
            4'b0011: o_sseg = 7'b0110000; // 3
            4'b0100: o_sseg = 7'b0011001; // 4
            4'b0101: o_sseg = 7'b0010010; // 5
            4'b0110: o_sseg = 7'b0000010; // 6
            4'b0111: o_sseg = 7'b1111000; // 7
            4'b1000: o_sseg = 7'b0000000; // 8
            4'b1001: o_sseg = 7'b0010000; // 9
            4'b1010: o_sseg = 7'b0001000; // A
            4'b1011: o_sseg = 7'b0000011; // B
            4'b1100: o_sseg = 7'b1000110; // C
            4'b1101: o_sseg = 7'b0100001; // D
            4'b1110: o_sseg = 7'b0000110; // E
            4'b1111: o_sseg = 7'b0001110; // F
            default: o_sseg = 7'b1111111; // Invalid BCD input, turn off all segments
        endcase
    end

endmodule
