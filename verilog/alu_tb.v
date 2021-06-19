// class Random_Num #(WIDTH);
//     rand bit signed [WIDTH-1:0] num;
// endclass

// class Random_Sel;
//     rand bit [2:0] num;
//     constraint c {num inside {[0:4]};}

//     function new();
//         this.randomize();
//     endfunction
// endclass

module alu_tb;

    timeunit 1ns;
    timeprecision 1ps;
    logic clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    localparam N = 16;
    localparam width_of_index = 8;
    reg [1:0] alu_op;
    reg signed [N-1:0] in1, in2;
    wire [N-1:0] alu_out, z;
    //wire z;

    alu #(.N(N),.width_of_index(width_of_index)) dut (.clk(clk), .in1(in1), .in2(in2), .alu_op(alu_op), .alu_out(alu_out), .z(z));

    // Random_Num #(.WIDTH(WIDTH)) A_r, B_r;
    // Random_Sel sel_r;

    initial begin
      
      	$dumpfile("dump.vcd");
    	$dumpvars(1);
    
        in1 <= 8'd5;
        in2 <= 8'd10;
        alu_op <= 2'd0;

        @(posedge clk);
        in1 <= 8'd30;
        in2 <= 8'd10;
        alu_op <= 2'd0;
	
        @(posedge clk);
        in1 <= 8'd5;
        in2 <= 8'd10;
        alu_op <= 2'd1;
		
      #(CLK_PERIOD * 3);
        @(posedge clk);
        in1 <= 8'd4;
        in2 <= 8'd20;
        alu_op <= 2'd2;

        //$stop;
    end
  
endmodule
