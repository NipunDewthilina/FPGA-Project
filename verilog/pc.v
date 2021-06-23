//registers with increment

module pc #(
    parameter N
) (
    input clk,
    input write_en,
    input [11:0] datain,
    input inc_en,
    input clr_en,
    output reg [N-1:0] dataout = 12'd0
    
);

    always @(posedge clk) begin
        if (write_en == 1)
            dataout <= datain[11:0];
        if (inc_en == 1) 
            dataout <= dataout + 12'd1;
        if (clr_en == 1)
            dataout <= 12'd0;
    end
    
endmodule