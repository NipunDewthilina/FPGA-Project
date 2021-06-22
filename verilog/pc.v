//registers with increment

module pc #(
    parameter N;
) (
    input clk,
    input write_en,
    input [11:0] datain,
    input inc_en,
    input clr_en,
    output reg [N-1:0] dataout = (N)'d0
    
);

    always @(posedge clk) begin
        if (write_en == 1)
            dataout <= datain;
        if (inc_en == 1) 
            dataout <= dataout + (N)'d1;
        if (clr_en == 1)
            dataout <= (N)'d0;
    end
    
endmodule