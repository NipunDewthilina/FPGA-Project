module ac #(
    parameter N
) (
	input clk,
    input write_en,
    //  input [3:0]read_en,
    input [N-1:0] datain,//from the bus
    input [11:0] alu_out,//alu_out
    input alu_to_ac,
    input inc_en,
    input clr_en,
    output reg [11:0] r_out, //r_out
    output reg [11:0] alu_in, //alu in
    output reg [11:0] dataout //to the bus
);

always @(posedge clk) begin
    r_out <= datain[11:0];
    if (inc_en == 1)
        dataout <= dataout + 12'd1;
    if (clr_en == 1)
        dataout <= 12'd0;
    if (write_en == 1)//ac write from bus
        dataout <= datain[11:0];
        alu_in <= datain[11:0];
    // if (read_en == 4'd14)//ac read for r
        // r_out <= datain[11:0];
    // if (read_en == 4'd5)//ac read for other registers 
    //     dataout <= datain;
    if (alu_to_ac == 1)//alu to ac
        alu_in <= alu_out;// in1
        dataout <= alu_out;
end
    
endmodule
