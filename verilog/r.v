//registers without increment

module rr #(
    parameter N
) (
    input clk,
    input write_en,
    input [N-1:0] datain,
    output reg [N-1:0] dataout
);

    always @(posedge clk) begin
        if (write_en == 1 )//have to check read_en according to the register type
            dataout <= datain;
    end     
    
endmodule