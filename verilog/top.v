module top
(
    input clk,
	 input [11:0] addr_tb,
    output wire end_process1,
    output wire end_process2,
    output wire end_process3,
    output wire end_process4,
    output wire [11:0] result
);
    wire [11:0] dm_out1;
    wire [17:0] im_out;

    // reg [1:0] status;
    wire [11:0] pc_out1;
    wire [11:0] ar_out1;
    wire [17:0] bus_out1;
    wire dm_en1;
    wire dm_en1_ram1;
    wire dm_en1_ram2;
    wire dm_en1_ram3;
    wire dm_en1_ram4;

    wire dm_en2;
    wire dm_en2_ram1;
    wire dm_en2_ram2;
    wire dm_en2_ram3;
    wire dm_en2_ram4;

    wire dm_en3;
    wire dm_en3_ram1;
    wire dm_en3_ram2;
    wire dm_en3_ram3;
    wire dm_en3_ram4;

    wire dm_en4;
    wire dm_en4_ram1;
    wire dm_en4_ram2;
    wire dm_en4_ram3;
    wire dm_en4_ram4;

    reg dm_en     ;
    reg dm_en_ram1;
    reg dm_en_ram2;
    reg dm_en_ram3;
    reg dm_en_ram4;

    wire [11:0] dm_out2;
    
    wire [11:0] pc_out2;
    wire [11:0] ar_out2;
    wire [17:0] bus_out2;

    wire [11:0] dm_out3;

    // reg [1:0] status;
    wire [11:0] pc_out3;
    wire [11:0] ar_out3;
    wire [17:0] bus_out3;

    wire [11:0] dm_out4;
    // wire [16:0] im_out4;

    // reg [1:0] status;
    wire [11:0] pc_out4;
    wire [11:0] ar_out4;
    wire [17:0] bus_out4;
	
	 wire [17:0] c1;
	 wire [17:0] c2;
	 wire [17:0] c3;
	 wire [17:0] c4;

     wire start_process;

    processor core1 (
    .clk(clk),.dm_out(dm_out1),.im_out(c1),
    .dm_en(dm_en1),.
    dm_en_ram1(dm_en1_ram1),.
    dm_en_ram2(dm_en1_ram2),.
    dm_en_ram3(dm_en1_ram3),.
    dm_en_ram4(dm_en1_ram4),.pc_out(pc_out1),.ar_out(ar_out1),.bus_out(bus_out1),
    .end_process(end_process1),.start_process(start_process)
    );

    processor core2 (
    .clk(clk),.dm_out(dm_out2),.im_out(c2),
    .dm_en(dm_en2),.
    dm_en_ram1(dm_en2_ram1),.
    dm_en_ram2(dm_en2_ram2),.
    dm_en_ram3(dm_en2_ram3),.
    dm_en_ram4(dm_en2_ram4),.pc_out(pc_out2),.ar_out(ar_out2),.bus_out(bus_out2),
    .end_process(end_process2),.start_process(start_process)
    );

    processor core3 (
    .clk(clk),.dm_out(dm_out3),.im_out(c3),
    .dm_en(dm_en3),.
    dm_en_ram1(dm_en3_ram1),.
    dm_en_ram2(dm_en3_ram2),.
    dm_en_ram3(dm_en3_ram3),.
    dm_en_ram4(dm_en3_ram4),.pc_out(pc_out3),.ar_out(ar_out3),.bus_out(bus_out3),
    .end_process(end_process3),.start_process(start_process)
    );

    processor core4 (
    .clk(clk),.dm_out(dm_out4),.im_out(c4),
    .dm_en(dm_en4),.
    dm_en_ram1(dm_en4_ram1),.
    dm_en_ram2(dm_en4_ram2),.
    dm_en_ram3(dm_en4_ram3),.
    dm_en_ram4(dm_en4_ram4),.pc_out(pc_out4),.ar_out(ar_out4),.bus_out(bus_out4),
    .end_process(end_process4),.start_process(start_process)
    );
    
    datamemory #(.N(18)) dm                                     
    (.clk(clk),.dm_en1(dm_en1),.
	 dm_en1_ram1(dm_en1_ram1),.
	 dm_en1_ram2(dm_en1_ram2),.
	 dm_en1_ram3(dm_en1_ram3),.
	 dm_en1_ram4(dm_en1_ram4)
     ,.dm_en2(dm_en2),.
	 dm_en2_ram1(dm_en2_ram1),.
	 dm_en2_ram2(dm_en2_ram2),.
	 dm_en2_ram3(dm_en2_ram3),.
	 dm_en2_ram4(dm_en2_ram4)
     ,.dm_en3(dm_en3),.
	 dm_en3_ram1(dm_en3_ram1),.
	 dm_en3_ram2(dm_en3_ram2),.
	 dm_en3_ram3(dm_en3_ram3),.
	 dm_en3_ram4(dm_en3_ram4)
     ,.dm_en4(dm_en4),.
	 dm_en4_ram1(dm_en4_ram1),.
	 dm_en4_ram2(dm_en4_ram2),.
	 dm_en4_ram3(dm_en4_ram3),.
	 dm_en4_ram4(dm_en4_ram4),.
	 addr_tb(addr_tb),.addr1(ar_out1),.addr2(ar_out2),.addr3(ar_out3),.addr4(ar_out4),
    .datain1(bus_out1),.datain2(bus_out2),.datain3(bus_out3),.datain4(bus_out4),
    .dataout1(dm_out1),.dataout2(dm_out2),.dataout3(dm_out3),.dataout4(dm_out4),.result(result),
    .start_process(start_process)
    );

    instr_mem #(.width_in(12),.width_out(17)) im 
    (
        .clk(clk),.addr1(pc_out1),.addr2(pc_out2),.addr3(pc_out3),.addr4(pc_out4),.instr_out(im_out)
    );

    im_core_select ics (.ins_in(im_out),.core1(c1),.core2(c2),.core3(c3),.core4(c4),.clk(clk));


endmodule