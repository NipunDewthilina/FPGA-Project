module ac #(
    parameter N
) (
    input write_en,
    input [3:0]read_en,
    input [N-1:0] datain,//from the bus
    input [N-1:0] alu_out,//alu_out
    input alu_to_ac,
    input inc_en,
    input clr_en,
    output [N-1:0] r_out, //r_out
    output reg [N-1:0] dataout = (N)'d0//to the bus
);

always @(posedge clk) begin
    if (inc_en == 1)
        dataout <= dataout + (N)'d1;
    if (clr_en == 1)
        dataout <= (N)'d0;
    if (write_en == 1)//ac write from bus
        dataout <= datain;
    if (read_en == 4'd13)//ac read for r
        r_out <= datain;
    if (read_en == 4'd5)//ac read for other registers 
        dataout <= datain;
    if (alu_to_ac == 1)
        dataout <= alu_out;
end
    
endmodule
