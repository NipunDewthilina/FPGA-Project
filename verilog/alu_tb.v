`timescale 1ns/1ps
module alu_tb;

    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    localparam N = 12;
    localparam width_of_index = 6;
    reg [2:0] alu_op;
    reg [N-1:0] in1, in2;
    wire [N-1:0] alu_out;
 	wire [15:0] z;
    //wire z;

    alu #(.N(N), .width_of_i(width_of_index)) dut (.clk(clk), .in1(in1), .in2(in2), .alu_op(alu_op), .alu_out(alu_out), .z(z));

    // Random_Num #(.WIDTH(WIDTH)) A_r, B_r;
    // Random_Sel sel_r;

    initial begin
      
      	// $dumpfile("dump.vcd");
    	// $dumpvars(1);
    
        in1 <= 12'd5;
        in2 <= 12'd10;
        alu_op <= 3'd1;

        @(posedge clk);
        in1 <= 12'd30;
        in2 <= 12'd10;
        alu_op <= 3'd2;
	
        @(posedge clk);
        in1 <= 12'd5;
        in2 <= 12'd10;
        alu_op <= 3'd3;
		
      #(CLK_PERIOD * 3);
        @(posedge clk);
        in1 <= 12'd4;
        in2 <= 12'd20;
        alu_op <= 3'd4;

        #(CLK_PERIOD * 3);
        @(posedge clk);
        in1 <= 12'd4;
        in2 <= 12'd20;
        alu_op <= 3'd1;

        #(CLK_PERIOD * 3);
        @(posedge clk);
        in1 <= 12'd6;
        in2 <= 12'd20;
        alu_op <= 3'd3;

        $stop;
    end
  
endmodule
