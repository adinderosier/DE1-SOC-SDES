module DE1_SOC_SDES(
	//////////// CLOCK //////////
	input 		          		CLOCK_50,
	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,
	//////////// KEY //////////
	input 		     [3:0]		KEY,
	//////////// LED //////////
	output		     [9:0]		LEDR,
	//////////// SW //////////
	input 		     [9:0]		SW
);

//=======================================================
//  REG/Wire declarations
//=======================================================
	wire [9:0] input_Key;
	wire [7:0] Key1;
	wire [7:0] Key2;
	wire [7:0] Plaintext;
	wire [7:0] new_Plaintext;
	wire [7:0] Ciphertext;
	wire [7:0] new_Ciphertext;
	
	wire btn_0;
	wire btn_1;

//=======================================================
//  Structural coding
//=======================================================

	sdes_keygen (input_Key, Key1, Key2);
	sdes_encryption (Plaintext, Key1, Key2, new_Ciphertext);
	sdes_decryption (Ciphertext, Key1, Key2, new_Plaintext);
	debounce d0 (CLOCK_50, 1'b1, KEY[0], btn_0);
	debounce d1 (CLOCK_50, 1'b1, KEY[1], btn_1);
	
	bcd_to_sseg s0 (Key1[3:0], HEX0);
	bcd_to_sseg s1 (Key1[7:4], HEX1);
	bcd_to_sseg s2 (Key2[3:0], HEX2);
	bcd_to_sseg s3 (Key2[7:4], HEX3);

//=======================================================
//  Behavioral coding
//=======================================================
	// Define states enum
	typedef enum logic[2:0] {
		IDLE,
		KEY_INPUT,
		PLAINTEXT_INPUT,
		CIPHERTEXT_INPUT,
		MODE_INPUT,
		ENCRYPT,
		DECRYPT
	} states;

	// Define state register and initialize
	reg [2:0] state_reg = IDLE;
	// Define mode register and initialize
	reg mode = 1'b0;
	// Define led register and initialize
	reg [7:0] led_reg = 8'b0;
	
	// State machine
	always_ff @(posedge CLOCK_50) begin
		if (~btn_1) begin
			// Reset state
			state_reg <= IDLE;
		end else if (~btn_0) begin
			case(state_reg)
				IDLE: begin
					// Set 10-bit key from switches
					input_Key <= SW;
					// Update state
					state_reg <= KEY_INPUT;
				end
				KEY_INPUT: begin
					// Set mode from switch
					mode <= SW[0];
					// Update state
					state_reg <= MODE_INPUT;
				end
				MODE_INPUT: begin
					if (mode == 0) begin
						// Update state
						state_reg <= PLAINTEXT_INPUT;
					end else begin
						// Update state
						state_reg <= CIPHERTEXT_INPUT;
					end
				end
				PLAINTEXT_INPUT: begin
					// Set plaintext from switches
					Plaintext <= SW[9:2];
					// Update state
					state_reg <= ENCRYPT;
				end
				CIPHERTEXT_INPUT: begin
					// Set ciphertext from switches
					Ciphertext <= SW[9:2];
					// Update state
					state_reg <= DECRYPT;
				end
				ENCRYPT: begin
					// Final output
					//led_reg <= new_Ciphertext;
					LEDR[9:2] <= new_Ciphertext;
					// Update state
					state_reg <= IDLE;
				end
				DECRYPT: begin
					// Final output
					//led_reg <= new_Plaintext;
					LEDR[9:2] <= new_Plaintext;
					// Update state
					state_reg <= IDLE;
				end
			endcase
		end
	end
endmodule
