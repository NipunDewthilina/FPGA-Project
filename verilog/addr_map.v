module addr_map(
	    input clk,
		 input [11:0] addr2,
		 input [11:0] addr3,
		 input [11:0] addr4,
		 input [5:0] instr_fb,
		 output reg [11:0] addr2_reg,
		 output reg [11:0] addr3_reg,
		 output reg [11:0] addr4_reg
	);

	always @(posedge clk) begin
		if (instr_fb != 6'd5 && addr2 != 12'd4091) begin
		 addr2_reg <= addr2-12'd9;
		 addr3_reg <= addr3-12'd18;
		 addr4_reg <= addr4-12'd27;
		end
		else begin
			addr2_reg <= addr2;
		 	addr3_reg <= addr3;
		 	addr4_reg <= addr4;
		end
			
	end
endmodule