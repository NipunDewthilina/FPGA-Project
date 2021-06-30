module top
(
    input clk,
    input start_process,
    output wire [11:0] r1,
    output wire [11:0] r2,
    output wire [11:0] r3,
    output wire [11:0] r4,
	 output wire [11:0] r5,
    output wire [11:0] r6,
    output wire [11:0] r7,
    output wire [11:0] r8,
	 output wire [11:0] r9,
    output wire [11:0] r10,
    output wire [11:0] r11,
    output wire [11:0] r12,
	 output wire [11:0] r13,
    output wire [11:0] r14,
    output wire [11:0] r15,
    output wire [11:0] r16,
    output wire end_process1,
    output wire end_process2,
    output wire end_process3,
    output wire end_process4
);
    wire [11:0] dm_out1;
    wire [16:0] im_out;

    // reg [1:0] status;
    wire [11:0] pc_out1;
    wire [11:0] ar_out1;
    wire [16:0] bus_out1;
    wire dm_en1;

    wire [11:0] dm_out2;
    // wire [16:0] im_out2;

    // reg [1:0] status;
    wire [11:0] pc_out2;
    wire [11:0] ar_out2;
    wire [16:0] bus_out2;
    wire dm_en2;

    wire [11:0] dm_out3;
    // wire [16:0] im_out3;

    // reg [1:0] status;
    wire [11:0] pc_out3;
    wire [11:0] ar_out3;
    wire [16:0] bus_out3;
    wire dm_en3;

    wire [11:0] dm_out4;
    // wire [16:0] im_out4;

    // reg [1:0] status;
    wire [11:0] pc_out4;
    wire [11:0] ar_out4;
    wire [16:0] bus_out4;
    wire dm_en4;

// ( input clk,
// 	input [11:0] dm_out,
// 	input [16:0] im_out,
// 	output reg dm_en,
// 	output [11:0] pc_out,//
// 	output [11:0] ar_out,
// 	output [16:0] bus_out,
// 	output end_process);

    processor core1 (
    .clk(clk),.dm_out(dm_out1),.im_out(im_out),
    .dm_en(dm_en1),.pc_out(pc_out1),.ar_out(ar_out1),.bus_out(bus_out1),
    .end_process(end_process1),.start_process(start_process)
    );

    processor core2 (
    .clk(clk),.dm_out(dm_out2),.im_out(im_out),
    .dm_en(dm_en2),.pc_out(pc_out2),.ar_out(ar_out2),.bus_out(bus_out2),
    .end_process(end_process2),.start_process(start_process)
    );

    processor core3 (
    .clk(clk),.dm_out(dm_out3),.im_out(im_out),
    .dm_en(dm_en3),.pc_out(pc_out3),.ar_out(ar_out3),.bus_out(bus_out3),
    .end_process(end_process3),.start_process(start_process)
    );

    processor core4 (
    .clk(clk),.dm_out(dm_out4),.im_out(im_out),
    .dm_en(dm_en4),.pc_out(pc_out4),.ar_out(ar_out4),.bus_out(bus_out4),
    .end_process(end_process4),.start_process(start_process)
    );
    
    datamemory #(.N(17)) dm                                     
    (.clk(clk),.write_en_1(dm_en1),.write_en_2(dm_en2),.write_en_3(dm_en3),.write_en_4(dm_en4)
    ,.addr1(ar_out1),.addr2(ar_out2),.addr3(ar_out3),.addr4(ar_out4),
    .datain1(bus_out1),.datain2(bus_out2),.datain3(bus_out3),.datain4(bus_out4),
    .dataout1(dm_out1),.dataout2(dm_out2),.dataout3(dm_out3),.dataout4(dm_out4),
    .r1(r1),.r2(r2),.r3(r3),.r4(r4)
	 ,.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12)
	 ,.r13(r13),.r14(r14),.r15(r15),.r16(r16)
    );
//     (
// 	input clk,
//     input write_en_1,
//     input write_en_2,
//     input write_en_3,
//     input write_en_4,
//     input [11:0] addr, //[N-1:0]
//     input [N-1:0] datain1,
//     input [N-1:0] datain2,
//     input [N-1:0] datain3,
//     input [N-1:0] datain4,
//     output reg [11:0] dataout1, //[N-1:0]
//     output reg [11:0] dataout2, //[N-1:0]
//     output reg [11:0] dataout3, //[N-1:0]
//     output reg [11:0] dataout4, //[N-1:0]
//     output reg [11:0] r1,
//     output reg [11:0] r2,
//     output reg [11:0] r3,
//     output reg [11:0] r4,
// 	output reg [11:0] r5,
//     output reg [11:0] r6,
//     output reg [11:0] r7,
//     output reg [11:0] r8,
// 	output reg [11:0] r9,
//     output reg [11:0] r10,
//     output reg [11:0] r11,
//     output reg [11:0] r12,
// 	output reg [11:0] r13,
//     output reg [11:0] r14,
//     output reg [11:0] r15,
//     output reg [11:0] r16
// );
//have to be modified
    instr_mem #(.width_in(12),.width_out(17)) im 
    (
        .clk(clk),.addr1(pc_out1),.addr2(pc_out2),.addr3(pc_out3),.addr4(pc_out4),.instr_out(im_out)
    );


endmodule