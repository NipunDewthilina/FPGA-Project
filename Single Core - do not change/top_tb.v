`timescale 1ns/1ps
module top_tb;

    //timeunit 1ns;
    //timeprecision 1ps;
    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    wire [11:0] r1;
    wire [11:0] r2;
    wire [11:0] r3;
    wire [11:0] r4;
	 wire [11:0] r5;
    wire [11:0] r6;
    wire [11:0] r7;
    wire [11:0] r8;
	 wire [11:0] r9;
    wire [11:0] r10;
    wire [11:0] r11;
    wire [11:0] r12;
	 wire [11:0] r13;
    wire [11:0] r14;
    wire [11:0] r15;
    wire [11:0] r16;
    wire end_process;
	 reg start_process;
    // parameter N_reg = 12;

    top top(.clk(clk),.start_process(start_process),.r1(r1),.r2(r2),.r3(r3),.r4(r4)
	 ,.r5(r5),.r6(r6),.r7(r7),.r8(r8)
	 ,.r9(r9),.r10(r10),.r11(r11),.r12(r12)
	 ,.r13(r13),.r14(r14),.r15(r15),.r16(r16),
    .end_process(end_process));//later initiate this
	
initial begin

    @(posedge clk)
    start_process <= 1;
    
    repeat(10000) begin
        @ (posedge clk)
        if (end_process ==1) begin
         #(CLK_PERIOD*3);
            $display("hi");
            $display(r1);
            $display(r2);
            $display(r3);
            $display(r4);
            $display("hi1");
            $stop;
        end
    end
    //	end
end
	 
endmodule




    

