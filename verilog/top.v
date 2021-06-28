module top
(
    input clk,
    output wire [11:0] r1,
    output wire [11:0] r2,
    output wire [11:0] r3,
    output wire [11:0] r4,
    output wire end_process
);
    wire [11:0] dm_out;
    wire [16:0] im_out;

    // reg [1:0] status;
    wire [11:0] pc_out;
    wire [11:0] ar_out;
    wire [16:0] bus_out;
    wire dm_en;

// ( input clk,
// 	input [11:0] dm_out,
// 	input [16:0] im_out,
// 	output reg dm_en,
// 	output [11:0] pc_out,//
// 	output [11:0] ar_out,
// 	output [16:0] bus_out,
// 	output end_process);

    processor core1 (
    .clk(clk),.dm_out(dm_out),.im_out(im_out),
    .dm_en(dm_en),.pc_out(pc_out),.ar_out(ar_out),.bus_out(bus_out),
    .end_process(end_process)
    );

    datamemory #(.N(17)) dm
    (
	 .clk(clk),.write_en(dm_en),.addr(ar_out),.datain(bus_out),
    .dataout(dm_out),.r1(r1),.r2(r2),.r3(r3),.r4(r4)
    );

    instr_mem #(.width_in(12),.width_out(17)) im
    (
        .clk(clk),.addr(pc_out),.instr_out(im_out)
    );


endmodule