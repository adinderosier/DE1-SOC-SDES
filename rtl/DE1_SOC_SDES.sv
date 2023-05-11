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
	wire mode;
	wire [9:0] input_Key;
	wire [7:0] Key1;
	wire [7:0] Key2;
	wire [7:0] Plaintext;
	wire [7:0] new_Plaintext;
	wire [7:0] Ciphertext;
	wire [7:0] new_Ciphertext;

//=======================================================
//  Structural coding
//=======================================================
	sdes_keygen (input_Key, Key1, Key2);
	sdes_encryption (Plaintext, Key1, Key2, new_Ciphertext);
	sdes_decryption (Ciphertext, Key1, Key2, new_Plaintext);

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
	// Define led register and initialize
	reg [7:0] led_reg = 8'b0;

	// Define next state logic
	always_ff @(posedge CLOCK_50) begin
		if (KEY[1]) begin
			state_reg <= IDLE;
		end else if (KEY[0]) begin
			case(state_reg)
				IDLE: begin
					state_reg <= KEY_INPUT;
				end
				KEY_INPUT: begin
					state_reg <= MODE_INPUT;
				end
				MODE_INPUT: begin
					if (mode == 0) begin
						state_reg <= PLAINTEXT_INPUT;
					end else begin
						state_reg <= CIPHERTEXT_INPUT;
					end
				end
				PLAINTEXT_INPUT: begin
					state_reg <= ENCRYPT;
				end
				CIPHERTEXT_INPUT: begin
					state_reg <= DECRYPT;
				end
				ENCRYPT: begin
					state_reg <= IDLE;
				end
				DECRYPT: begin
					state_reg <= IDLE;
				end
			endcase
		end
	end

	// Define output logic
	always_ff @(posedge CLOCK_50) begin
		case(state_reg)
			IDLE: begin
				LEDR[9:2] <= led_reg;
				input_Key <= SW;
			end
			KEY_INPUT: begin
				mode <= SW[0];
			end
			MODE_INPUT: begin
			end
			PLAINTEXT_INPUT: begin
				Plaintext <= SW[9:2];
			end
			CIPHERTEXT_INPUT: begin
				Ciphertext <= SW[9:2];
			end
			ENCRYPT: begin
				led_reg <= new_Ciphertext[7:0];
			end
			DECRYPT: begin
				led_reg <= new_Plaintext[7:0];
			end
		endcase
	end

endmodule
