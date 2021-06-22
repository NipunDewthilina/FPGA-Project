//registers without increment

module regr #(
    parameter N
) (
    input clk,
    input write_en,
    input [N-1:0] datain,
    input [4:0] read_en,
    output reg [N-1:0] dataout
);

    always @(posedge clk) begin
        if (write_en == 1 or read_en)//have to check read_en according to the register type
            dataout <= datain;
    end     
    
endmodule