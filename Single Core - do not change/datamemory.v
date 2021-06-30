//Remember : all the inputs from bus are 17 bits, outputs to the bus is 12 bits.
module datamemory #(
    parameter N=17
) (
	input clk,
    input write_en,
    input [11:0] addr, //[N-1:0]
    input [N-1:0] datain,
    output reg [11:0] dataout, //[N-1:0]
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
    
    reg [11:0] ram [4095:0] ; //[N-1:0] [4095:0]
    localparam start_bit = 4094;
    initial begin
        
        ram[start_bit] = 12'd0;//i
        ram[start_bit-1] = 12'd4;//j
        ram[start_bit-2] = 12'd8;//k
        ram[start_bit-3] = 12'd4;//n = 2 //n = 4
        ram[start_bit-4] = 12'd8;//2n = 4
        ram[start_bit-5] = 12'd12;//3n = 6 //3n = 12
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
		  ram[8] = 12'd1;
		  ram[9] = 12'd2;
		  ram[10] = 12'd1;
		  ram[11] = 12'd2;
		  ram[72] = 12'd1;
		  ram[73] = 12'd2;
		  ram[74] = 12'd1;
		  ram[75] = 12'd2;
		  ram[136]= 12'd1;
		  ram[137]= 12'd2;
		  ram[138]= 12'd1;
		  ram[139]= 12'd2;
		  ram[200]= 12'd3;
		  ram[201]= 12'd2;
		  ram[202]= 12'd1;
		  ram[203]= 12'd0;
		  ram[516]= 12'd1;
		  ram[517]= 12'd2;
		  ram[518]= 12'd1;
		  ram[519]= 12'd2;
		  ram[580]= 12'd1;
		  ram[581]= 12'd2;
		  ram[582]= 12'd1;
		  ram[583]= 12'd2;
		  ram[644]= 12'd1;
		  ram[645]= 12'd2;
		  ram[646]= 12'd1;
		  ram[647]= 12'd2;
		  ram[708]= 12'd3;
		  ram[709]= 12'd2;
		  ram[710]= 12'd1;
		  ram[711]= 12'd0;
		  
		  
		  
    end
// 2]
// 3]
// 66
// 67
    always @(posedge clk) begin
        r1 <= ram [4]; 
        r2 <= ram [5];
        r3 <= ram [6];
        r4 <= ram [7];
		  r5 <= ram [68]; 
        r6 <= ram [69];
        r7 <= ram [70];
        r8 <= ram [71];
		  r9 <= ram [132]; 
        r10 <= ram[133];
        r11 <= ram[134];
        r12 <= ram[135];
		  r13 <= ram[196]; 
        r14 <= ram[197];
        r15 <= ram[198];
        r16 <= ram[199];
        if (write_en == 1)
            ram[addr] <= datain[11:0];
        else begin
            dataout <= ram[addr];
        end
    end
    
endmodule