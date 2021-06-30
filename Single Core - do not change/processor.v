module processor ( input clk,
	input [11:0] dm_out,
	input [16:0] im_out,
	input start_process,
	// input [1:0] status,

	output reg dm_en,
	output [11:0] pc_out,//
	output [11:0] ar_out,
	output [16:0] bus_out,
	output end_process);

	wire [2:0] alu_op;
	wire [11:0] alu_out;
	wire [11:0] regr_out ;
	wire [11:0] regr1_out ;
	wire [11:0] regr2_out ;
	wire [11:0] regr3_out ;
	wire [11:0] regr4_out ;
	wire [11:0] ac_out;
	wire [11:0] r_out;

	wire [11:0] alu_in;

	wire [11:0] ir_out;
	wire [15:0] write_en ;
	wire [3:0] read_en;
	wire [15:0] inc_en;
	wire [15:0] clr_en;
	wire [5:0] instruction;
	//  wire [15:0] mem0;
	//  wire [15:0] mem1;
	//  wire [15:0] mem2;
	//  wire [15:0] mem3;
	//  wire [15:0] mem4;
	//  wire [15:0] mem5;
	//  wire [15:0] mem6;
	//  wire [15:0] mem7;
	//  wire [15:0] mem8;

	wire [15:0] z ;
	localparam  N_bus = 17;
	localparam N_reg = 12;
	localparam width_of_i = 6;

	//register R
	 regr #(.N(N_bus)) reg_r (.clk(clk), .write_en (write_en[5] //write enable 6th bit
	 ),.datain(bus_out),.dataout(regr_out ));

	//register ir
	ir #(.N(N_bus)) ir (.clk(clk),.write_en(write_en[3]),.datain(bus_out),
	.inc_en(inc_en[3]),.dataout(ir_out),.instruction(instruction));
// 	(
//     input clk,
//     input write_en,
//     // input read_en,
//     input [N-1:0] datain,
//     input inc_en,
//     output reg [11:0] dataout = 12'd0,
//     output reg [4:0] instruction
    
// );

	//register R1
	 regr #(.N(N_bus)) regr_r1(.clk(clk), .write_en (write_en [10]),
	 .datain(bus_out),.dataout(regr1_out
	));

	//register R2
	 regr #(.N(N_bus)) regr_r2(.clk(clk), .write_en (write_en [9]),
	 .datain(bus_out),.dataout(regr2_out
	));

	//register R3
	 regr #(.N(N_bus)) regr_r3(.clk(clk), .write_en (write_en [8]),
	 .datain(bus_out),.dataout(regr3_out
	));

	//register R4
	 regr #(.N(N_bus)) regr_r4(.clk(clk), .write_en (write_en [7]),
	 .datain(bus_out),.dataout(regr4_out ));

	//register AR
	 reg_ar #(.N(N_bus)) ar(.clk(clk), .write_en (write_en [2]),
	 .datain(bus_out),.clr_en(clr_en[2]),.dataout(ar_out));

	//register PC
	 pc #(.N(N_bus)) pc(.clk(clk), .write_en (write_en [1]),
	 .clr_en(clr_en[1]),.inc_en(inc_en[1]),.datain(bus_out),.dataout(pc_out));//
// (
//     input clk,
//     input write_en,
//     input [N-1:0] datain,
//     input inc_en,
//     input clr_en,
//     output reg [11:0] dataout = 12'd0
    
// );
	//register bus
	 bus #(.N(N_bus)) bus1 (.r(regr_out),.r1(regr1_out ),.r2(regr2_out ),.r3(regr3_out ),.r4(regr4_out )
	 ,.ir(ir_out),.ac(ac_out),.dm(dm_out),.im(im_out),.busout(bus_out),.read_en(read_en)
	,.clk(clk));

	//register Accumilator
	 ac #(.N(N_bus)) ac1(.clk(clk), .write_en (write_en[4]),.datain(bus_out),.dataout(ac_out),.alu_out(
	alu_out),.alu_to_ac (write_en [12]),.inc_en(inc_en[4]),
	.clr_en(clr_en[4]));
	// ( input clk,
    // input write_en,
    // input [N-1:0] datain,//from the bus
    // input [11:0] alu_out,//alu_out
    // input alu_to_ac,
    // // input ac_to_alu,
    // input inc_en,
    // input clr_en,
    // // input ac_to_r,
    // // output reg [11:0] r_out, //r_out
    // // output reg [11:0] alu_in, //alu in
    // output reg [11:0] dataout //to the bus

	//register alu
	 alu #(.N(N_reg),.width_of_i(width_of_i)) alu1 (.clk(clk),.in1(ac_out),.in2(regr_out),
	 .alu_op(alu_op),.alu_out(alu_out),.z(z));
	// (
	//     input clk,
	//     input signed reg [N-1:0] in1,
	//     input signed reg [N-1:0] in2,
	//     input [2:0] alu_op,
	//     output reg [N-1:0] alu_out,
	//     output reg [N-1:0] z
	// );

	// control unit
	 control control1 (.clk(clk),.z(z),.instruction 
	(instruction),.alu_op(alu_op),.write_en (write_en ),.
	read_en(read_en),.inc_en(inc_en),.clr_en(clr_en)
	,.start_process(start_process)
	,.end_process (end_process ));

	//status = 2'd1;
	always @(posedge clk) begin
		if (start_process == 1)
		 	dm_en <= write_en[11];
	end

endmodule