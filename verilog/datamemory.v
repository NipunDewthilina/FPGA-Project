//Remember : all the inputs from bus are 17 bits, outputs to the bus is 12 bits.
module datamemory #(
    parameter N
) (
	input clk,
    input write_en_1,
    input write_en_2,
    input write_en_3,
    input write_en_4,
    input [11:0] addr1, //[N-1:0]
    input [11:0] addr2, //[N-1:0]
    input [11:0] addr3, //[N-1:0]
    input [11:0] addr4, //[N-1:0]
    input [N-1:0] datain1,
    input [N-1:0] datain2,
    input [N-1:0] datain3,
    input [N-1:0] datain4,
    output reg [11:0] dataout1, //[N-1:0]
    output reg [11:0] dataout2, //[N-1:0]
    output reg [11:0] dataout3, //[N-1:0]
    output reg [11:0] dataout4, //[N-1:0]
    output reg [11:0] r1,
    output reg [11:0] r2,
    output reg [11:0] r3,
    output reg [11:0] r4,
	output reg [11:0] r5,
    output reg [11:0] r6,
    output reg [11:0] r7,
    output reg [11:0] r8,
	output reg [11:0] r9,
    output reg [11:0] r10,
    output reg [11:0] r11,
    output reg [11:0] r12,
	output reg [11:0] r13,
    output reg [11:0] r14,
    output reg [11:0] r15,
    output reg [11:0] r16
);
    
    reg [11:0] ram1 [4095:0] ; //[N-1:0] [4095:0]
    reg [11:0] ram2 [4095:0];
    reg [11:0] ram3 [4095:0];
    reg [11:0] ram4 [4095:0];
    localparam start_bit = 4094;
    initial begin
        //core 1 - 00
          ram1[start_bit] =   12'd0;//i
          ram1[start_bit-1] = 12'd4;//j
          ram1[start_bit-2] = 12'd8;//k
          ram1[start_bit-3] = 12'd2;//n/2 = 2 
          ram1[start_bit-4] = 12'd6;//2n-n/2 = 6
          ram1[start_bit-5] = 12'd12;//3n = 6 //3n = 12
		  ram1[start_bit-6] = 12'd4;
		  ram1[start_bit-7] = 12'd8;
        
        //core2 - 11
          ram2[start_bit] =   12'd2;//i
          ram2[start_bit-1] = 12'd6;//j
          ram2[start_bit-2] = 12'd8;//k
          ram2[start_bit-3] = 12'd4;//n = 4 
          ram2[start_bit-4] = 12'd8;//2n = 8
          ram2[start_bit-5] = 12'd12;//3n = 6 //3n = 12
		  ram2[start_bit-6] = 12'd6;
		  ram2[start_bit-7] = 12'd8;


        //core3 - 10
          ram3[start_bit] =   12'd2;//i
          ram3[start_bit-1] = 12'd4;//j
          ram3[start_bit-2] = 12'd8;//k
          ram3[start_bit-3] = 12'd4;//n = 4 
          ram3[start_bit-4] = 12'd6;//2n-n/2 = 6
          ram3[start_bit-5] = 12'd12;//3n = 6 //3n = 12
		  ram3[start_bit-6] = 12'd4;
		  ram3[start_bit-7] = 12'd8;

        //core4 - 01
          ram4[start_bit] =   12'd0;//i
          ram4[start_bit-1] = 12'd6;//j
          ram4[start_bit-2] = 12'd8;//k
          ram4[start_bit-3] = 12'd2;//n/2 = 2 
          ram4[start_bit-4] = 12'd8;//2n = 8
          ram4[start_bit-5] = 12'd12;//3n = 6 //3n = 12
		  ram4[start_bit-6] = 12'd6;
		  ram4[start_bit-7] = 12'd8;

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
		  ram1[8] =  12'd1;
		  ram1[9] =  12'd2;
		  ram1[10] = 12'd1;
		  ram1[11] = 12'd2;
		  ram1[72] = 12'd1;
		  ram1[73] = 12'd2;
		  ram1[74] = 12'd1;
		  ram1[75] = 12'd2;
		  ram1[136]= 12'd1;
		  ram1[137]= 12'd2;
		  ram1[138]= 12'd1;
		  ram1[139]= 12'd2;
		  ram1[200]= 12'd3;
		  ram1[201]= 12'd2;
		  ram1[202]= 12'd1;
		  ram1[203]= 12'd0;
		  ram1[516]= 12'd1;
		  ram1[517]= 12'd2;
		  ram1[518]= 12'd1;
		  ram1[519]= 12'd2;
		  ram1[580]= 12'd1;
		  ram1[581]= 12'd2;
		  ram1[582]= 12'd1;
		  ram1[583]= 12'd2;
		  ram1[644]= 12'd1;
		  ram1[645]= 12'd2;
		  ram1[646]= 12'd1;
		  ram1[647]= 12'd2;
		  ram1[708]= 12'd3;
		  ram1[709]= 12'd2;
		  ram1[710]= 12'd1;
		  ram1[711]= 12'd0;  
          
          ram2[8] =  12'd1;
		  ram2[9] =  12'd2;
		  ram2[10] = 12'd1;
		  ram2[11] = 12'd2;
		  ram2[72] = 12'd1;
		  ram2[73] = 12'd2;
		  ram2[74] = 12'd1;
		  ram2[75] = 12'd2;
		  ram2[136]= 12'd1;
		  ram2[137]= 12'd2;
		  ram2[138]= 12'd1;
		  ram2[139]= 12'd2;
		  ram2[200]= 12'd3;
		  ram2[201]= 12'd2;
		  ram2[202]= 12'd1;
		  ram2[203]= 12'd0;
		  ram2[516]= 12'd1;
		  ram2[517]= 12'd2;
		  ram2[518]= 12'd1;
		  ram2[519]= 12'd2;
		  ram2[580]= 12'd1;
		  ram2[581]= 12'd2;
		  ram2[582]= 12'd1;
		  ram2[583]= 12'd2;
		  ram2[644]= 12'd1;
		  ram2[645]= 12'd2;
		  ram2[646]= 12'd1;
		  ram2[647]= 12'd2;
		  ram2[708]= 12'd3;
		  ram2[709]= 12'd2;
		  ram2[710]= 12'd1;
		  ram2[711]= 12'd0;  

          ram3[8] =  12'd1;
		  ram3[9] =  12'd2;
		  ram3[10] = 12'd1;
		  ram3[11] = 12'd2;
		  ram3[72] = 12'd1;
		  ram3[73] = 12'd2;
		  ram3[74] = 12'd1;
		  ram3[75] = 12'd2;
		  ram3[136]= 12'd1;
		  ram3[137]= 12'd2;
		  ram3[138]= 12'd1;
		  ram3[139]= 12'd2;
		  ram3[200]= 12'd3;
		  ram3[201]= 12'd2;
		  ram3[202]= 12'd1;
		  ram3[203]= 12'd0;
		  ram3[516]= 12'd1;
		  ram3[517]= 12'd2;
		  ram3[518]= 12'd1;
		  ram3[519]= 12'd2;
		  ram3[580]= 12'd1;
		  ram3[581]= 12'd2;
		  ram3[582]= 12'd1;
		  ram3[583]= 12'd2;
		  ram3[644]= 12'd1;
		  ram3[645]= 12'd2;
		  ram3[646]= 12'd1;
		  ram3[647]= 12'd2;
		  ram3[708]= 12'd3;
		  ram3[709]= 12'd2;
		  ram3[710]= 12'd1;
		  ram3[711]= 12'd0;  

          ram4[8] =  12'd1;
		  ram4[9] =  12'd2;
		  ram4[10] = 12'd1;
		  ram4[11] = 12'd2;
		  ram4[72] = 12'd1;
		  ram4[73] = 12'd2;
		  ram4[74] = 12'd1;
		  ram4[75] = 12'd2;
		  ram4[136]= 12'd1;
		  ram4[137]= 12'd2;
		  ram4[138]= 12'd1;
		  ram4[139]= 12'd2;
		  ram4[200]= 12'd3;
		  ram4[201]= 12'd2;
		  ram4[202]= 12'd1;
		  ram4[203]= 12'd0;
		  ram4[516]= 12'd1;
		  ram4[517]= 12'd2;
		  ram4[518]= 12'd1;
		  ram4[519]= 12'd2;
		  ram4[580]= 12'd1;
		  ram4[581]= 12'd2;
		  ram4[582]= 12'd1;
		  ram4[583]= 12'd2;
		  ram4[644]= 12'd1;
		  ram4[645]= 12'd2;
		  ram4[646]= 12'd1;
		  ram4[647]= 12'd2;
		  ram4[708]= 12'd3;
		  ram4[709]= 12'd2;
		  ram4[710]= 12'd1;
		  ram4[711]= 12'd0;  
    end
// 2
// 3
// 66
// 67
    always @(posedge clk) begin
        r1 <=  ram1 [4  ]; 
        r2 <=  ram1 [5  ];
        r3 <=  ram4 [6  ];
        r4 <=  ram4 [7  ];
		r5 <=  ram1 [68 ]; 
        r6 <=  ram1 [69 ];
        r7 <=  ram4 [70 ];
        r8 <=  ram4 [71 ];
		r9 <=  ram3 [132]; 
        r10 <= ram3 [133];
        r11 <= ram2 [134];
        r12 <= ram2 [135];
		r13 <= ram3 [196]; 
        r14 <= ram3 [197];
        r15 <= ram2 [198];
        r16 <= ram2 [199];
        if (write_en_1 == 1)
            ram1[addr1] <= datain1[11:0];
        if (write_en_2 == 1)
            ram2[addr2]<= datain2[11:0];
        if (write_en_3 == 1)
            ram3[addr3]<= datain3[11:0];
        if (write_en_4 == 1)
            ram4[addr4]<= datain4[11:0];
        else begin
            dataout1 <= ram1[addr1];
            dataout2 <= ram2[addr2];
            dataout3 <= ram3[addr3];
            dataout4 <= ram4[addr4];
        end
    end
    
endmodule