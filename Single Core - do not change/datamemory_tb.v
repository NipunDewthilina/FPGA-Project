//Remember : all the inputs from bus are 17 bits, outputs to the bus is 12 bits.
`timescale 1ns/1ps
module datamemory_tb;

    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

	//input clk,
    //wire clk,
//    reg write_en;
    // reg receive_en;
    // reg [11:0] addr; //[N-1:0]
    // reg [17:0] datain;
    // reg [11: 0] addr_input;
    // reg [17: 0] data_input;
    reg start_writing;
    // wire [11:0] dataout; //[N-1:0]
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
    

    // integer  data_file; // file handler
    // integer  scan_file; // file handler
    // reg [11:0] captured_data;
    // `define NULL 0  

    // initial begin
    //     data_file = $fopen("../../mat44.txt", "r");
    //     if (data_file == `NULL) begin
    //         $display("data_file handle was NULL");
    //         $finish;
    //     end
    // end

    datamemory #(.N(17)) dm
    (
	 .clk(clk),.start_writing(start_writing),.r1(r1),.r2(r2),.r3(r3),.r4(r4)
	 ,.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12)
	 ,.r13(r13),.r14(r14),.r15(r15),.r16(r16)
    );    
	 
	 initial begin
	 @(posedge clk)
		start_writing<= 1;
	 end
    
endmodule