`timescale 1ps/1ps
module processor_tb;

    //timeunit 1ns;
    //timeprecision 1ps;
    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    parameter N_reg = 12;

    reg signed  [11:0] dm_out;
    reg signed [16:0] im_out;

    // reg [1:0] status;
    wire [11:0] pc_out;
    wire [11:0] ar_out;
    wire [16:0] bus_out;
    wire end_process;
    wire dm_en;

    processor core1 (
    .clk(clk),.dm_out(dm_out),.im_out(im_out),
    .dm_en(dm_en),.pc_out(pc_out),.ar_out(ar_out),.bus_out(bus_out),
    .end_process(end_process));

    datamemory #(.N(12)) dm
    (
	 .clk(clk),.write_en(dm_en),.addr(ar_out),.datain(bus_out),
    .dataout(dm_out),.r1(r1),.r2(r2),.r3(r3),.r4(r4));

    instr_mem #(.width_in(12),.width_out(17)) im
    (
        .clk(clk),.addr(pc_out),.instr_out(im_out)
    );
	 
initial begin
if (end_process ==1)
    $display(r1);
    $display(r2);
    $display(r3);
    $display(r4);
    end
	 
endmodule




    

