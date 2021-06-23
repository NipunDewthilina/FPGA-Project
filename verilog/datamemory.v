module datamemory #(
    parameter N = 16
) (
    input write_en,
    input [N-1:0] addr, //[15:0]
    input [N-1:0] datain,
    output reg [(N/2)-1:0] dataout //[7:0]
);
    
    reg [(N/2)-1:0] ram [65535:0] ; //[7:0] [65535:0]
    parameter start_bit = 4095;
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
        if (write_en == 1)
            ram[addr] <= datain[(N/2)-1:0];
        else begin
            dataout <= ram[addr];
        end
    end
    
endmodule)