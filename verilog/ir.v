//registers with increment

module name #(
    parameter N;
) (
    input clk,
    input write_en,
    input [N-1:0] datain,
    input inc_en,
    output reg [11:0] dataout = (N)'d0,
    output reg [4:0] instruction
    
);

    always @(posedge clk) begin
        if (write_en == 1)
            dataout <= datain[11:0];//lower half is feed to bus
            intruction <= datain[16:12];//higher half is the instruction
    end
    
endmodule