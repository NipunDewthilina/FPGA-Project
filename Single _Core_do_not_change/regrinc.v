//registers with increment

module regrinc #(
    parameter N
) (
    input clk,
    input write_en,
    input [N-1:0] datain,
    input inc_en,
    output reg [11:0] dataout = 12'd0
    
);

    always @(posedge clk) begin
        if (write_en == 1)
            dataout <= datain[11:0];
        if (inc_en == 1) 
            dataout <= dataout + 12'd1;
    end
    
endmodule