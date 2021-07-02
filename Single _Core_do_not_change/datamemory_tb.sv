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
    reg write_en;
    reg receive_en;
    reg  [11:0] addr; //[N-1:0]
    reg  [17:0] datain;
    reg  [11:0] addr_input;
    reg  [17:0] data_input;
    wire [11:0] dataout; //[N-1:0]
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
    
    //reg [11:0] ram [4095:0] ; //[N-1:0] [4095:0]
    //localparam start_bit = 4094;
    //initial begin
        
        // ram[start_bit] = 12'd0;//i
        // ram[start_bit-1] = 12'd4;//j
        // ram[start_bit-2] = 12'd8;//k
        // ram[start_bit-3] = 12'd4;//n = 2 //n = 4
        // ram[start_bit-4] = 12'd8;//2n = 4
        // ram[start_bit-5] = 12'd12;//3n = 6 //3n = 12
        //2x2 matrix
//        ram[4] =  12'd1;
//        ram[5] =  12'd2;
//        ram[68]  =12'd3;
//        ram[69] = 12'd4;
//        ram[258]= 12'd5;
//        ram[259]= 12'd6;
//        ram[322]= 12'd7;
//        ram[323]= 12'd8;
			//4x4 matrix
		//   ram[8] = 12'd1;
		//   ram[9] = 12'd2;
		//   ram[10] = 12'd1;
		//   ram[11] = 12'd2;
		//   ram[72] = 12'd1;
		//   ram[73] = 12'd2;
		//   ram[74] = 12'd1;
		//   ram[75] = 12'd2;
		//   ram[136]= 12'd1;
		//   ram[137]= 12'd2;
		//   ram[138]= 12'd1;
		//   ram[139]= 12'd2;
		//   ram[200]= 12'd3;
		//   ram[201]= 12'd2;
		//   ram[202]= 12'd1;
		//   ram[203]= 12'd0;
		//   ram[516]= 12'd1;
		//   ram[517]= 12'd2;
		//   ram[518]= 12'd1;
		//   ram[519]= 12'd2;
		//   ram[580]= 12'd1;
		//   ram[581]= 12'd2;
		//   ram[582]= 12'd1;
		//   ram[583]= 12'd2;
		//   ram[644]= 12'd1;
		//   ram[645]= 12'd2;
		//   ram[646]= 12'd1;
		//   ram[647]= 12'd2;
		//   ram[708]= 12'd3;
		//   ram[709]= 12'd2;
		//   ram[710]= 12'd1;
		//   ram[711]= 12'd0;
		  
		  
		  
    //end
// 2]
// 3]
// 66
// 67
	 integer file_in,file_out,status;
//    integer  data_file; // file handler
//    integer  scan_file; // file handler
    reg [11:0] captured_data;
//    `define NULL 0  
	 localparam path_in = "mat44.txt" ;
    initial begin
//        data_file = $fopen("C:\Users\dewth\Desktop\mat44.txt", "r");
//        if (data_file == `NULL) begin
//            $display("data_file handle was NULL");
////            $stop;
//        end
//        else begin
//            $display("Read");
//        end
			file_in = $fopen(path_in,"r");
			while(!$feof(file_in)) begin
				@(posedge clk); #1;
					status = $fscanf(file_in, "%d\r", captured_data); 
//					if (!$feof(data_file)) begin
                //use captured_data as you would any other wire or reg value;
                $display(captured_data);
                write_en <= 0;
                receive_en <= 1;
                addr <= 0;
                datain <= 0;
                addr_input <= addr_input + 1;
                data_input <= captured_data;
//            end
			end
		
    end

    datamemory #(.N(17)) dm
    (
	 .clk(clk),.write_en(dm_en),.addr(addr),.datain(datain), .addr_input(addr_input), .data_input(data_input),
    .dataout(dataout),.r1(r1),.r2(r2),.r3(r3),.r4(r4)
	 ,.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12)
	 ,.r13(r13),.r14(r14),.r15(r15),.r16(r16)
    );

//    initial begin
//        repeat(4096) begin
//        @(posedge clk)
//            scan_file = $fscanf(data_file, "%d\n", captured_data); 
//            if (!$feof(data_file)) begin
//                //use captured_data as you would any other wire or reg value;
//                $display(captured_data);
//                write_en <= 0;
//                receive_en <= 1;
//                addr <= 0;
//                datain <= 0;
//                addr_input <= addr_input + 1;
//                data_input <= captured_data;
//            end
//        end
//    end
    
    
endmodule