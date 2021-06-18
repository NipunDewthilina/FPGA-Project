module ac #(
    parameter N = 15
) (
    input write_en,
    input [N-1:0] datain,
    output reg [N-1:0] dataout = (N)'d0,
    input [N-1:0] alu_out,
    input alu_to_ac,
    input inc_en
);

always @(posedge clk) begin
    if (inc_en == 1)
        dataout <= dataout + (N-1)'d1;
    if (write_en == 1)
        dataout <= datain;
    if (alu_to_ac == 1)
        dataout <= alu_out;
end
    
endmodule
