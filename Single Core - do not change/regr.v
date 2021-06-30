//registers without increment

module regr #(
    parameter N=17
) (
    input clk,
    input write_en,
    input [N-1:0] datain,
    output reg [11:0] dataout
);

    always @(negedge clk) begin
        if (write_en == 1 )//have to check read_en according to the register type
            dataout <= datain[11:0];
    end     
    
endmodule