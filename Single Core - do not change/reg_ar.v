//registers without increment

module reg_ar #(
    parameter N) (
    input clk,
    input write_en,
    input clr_en,
    input [N-1:0] datain,
    // input [4:0] read_en,
    output reg [11:0] dataout
);

    always @(posedge clk) begin
        if (write_en == 1)//have to check read_en according to the register type
            dataout <= datain[11:0];
        if (clr_en == 1)
            dataout <= 12'd0;
    end     
    
endmodule