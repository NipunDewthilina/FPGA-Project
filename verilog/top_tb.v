`timescale 1ns/1ps
module top_tb;

    //timeunit 1ns;
    //timeprecision 1ps;
    reg clk = 0;
    localparam CLK_PERIOD = 20;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    wire [11:0] r1;
    wire [11:0] r2;
    wire [11:0] r3;
    wire [11:0] r4;
    wire end_process;
    // parameter N_reg = 12;

    top top(.clk(clk),.r1(r1),.r2(r2),.r3(r3),.r4(r4),
    .end_process(end_process));//later initiate this
	
	initial begin
//	always @(posedge clk) 
//forever begin
//		if (end_process ==1)
#(CLK_PERIOD*3);
			 $display("hi");
			 $display(r1);
			 $display(r2);
			 $display(r3);
			 $display(r4);
			 $display("hi1");
//			 end
//	end
	end
	 
endmodule




    

