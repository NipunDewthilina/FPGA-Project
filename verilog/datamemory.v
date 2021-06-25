//Remember : all the inputs from bus are 17 bits, outputs to the bus is 12 bits.
module datamemory #(
    parameter N
) (
	input clk,
    input write_en,
    input [11:0] addr, //[N-1:0]
    input [N-1:0] datain,
    output reg [11:0] dataout, //[N-1:0]
    output reg [11:0] r1,
    output reg [11:0] r2,
    output reg [11:0] r3,
    output reg [11:0] r4
);
    
    reg [11:0] ram [4095:0] ; //[N-1:0] [4095:0]
    parameter start_bit = 4094;
    initial begin
        
        ram[start_bit] = 12'd0;//i
        ram[start_bit-1] = 12'd2;//j
        ram[start_bit-2] = 12'd4;//k
        ram[start_bit-3] = 12'd2;//n = 2
        ram[start_bit-4] = 12'd4;//2n = 4
        ram[start_bit-5] = 12'd6;//3n = 6
        //2x2 matrix
        ram[4] = 12'd1;
        ram[5] = 12'd2;
        ram[68]  =12'd3;
        ram[69] = 12'd4;
        ram[258]= 12'd5;
        ram[259]=12'd6;
        ram[322]=12'd7;
        ram[323]=12'd8;
    end
    always @(posedge clk) begin
        r1 <= ram[2];
        r2 <= ram[3];
        r3 <= ram[66];
        r4 <= ram[67];
        if (write_en == 1)
            ram[addr] <= datain[11:0];
        else begin
            dataout <= ram[addr];
        end
    end
    
endmodule