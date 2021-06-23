//registers with increment

module name #(
    parameter N;
) (
    input clk,
    input write_en,
    input [N-1:0] datain,
    input inc_en,
    output reg [N-1:0] dataout = (N)'d0,
    
);

    always @(posedge clk) begin
        if (write_en == 1)
            dataout <= datain[11:0];
        if (inc_en == 1) 
            dataout <= dataout + (N)'d1;
    end
    
endmodule