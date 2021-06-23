`timescale 1ps/1ps
module top_tb;

    //timeunit 1ns;
    //timeprecision 1ps;
    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    wire r1;
    wire r2;
    wire r3;
    wire r4;
    wire end_process;
    // parameter N_reg = 12;

    top top(.clk(clk),.r1(r1),.r2(r2),.r3(r3),.r4(r4),
    .end_process(end_process));//later initiate this
	 
initial begin
if (end_process ==1)
    $display(r1);
    $display(r2);
    $display(r3);
    $display(r4);
    end
	 
endmodule




    

