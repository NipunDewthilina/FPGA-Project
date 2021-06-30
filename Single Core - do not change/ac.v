module ac #(
    parameter N=17) 
    ( input clk,
    input write_en,
    input [N-1:0] datain,//from the bus
    input [11:0] alu_out,//alu_out
    input alu_to_ac,
    // input ac_to_alu,
    input inc_en,
    input clr_en,
    // input ac_to_r,
    // output reg [11:0] r_out, //r_out
    // output reg [11:0] alu_in, //alu in
    output reg [11:0] dataout //to the bus
);

always @(posedge clk) begin
    if (write_en == 1'd1) 
        dataout  <= datain[11:0];
    // if (ac_to_alu == 1) alu_in  <= datain[11:0];
    if (alu_to_ac == 1'd1) 
        dataout <= alu_out;
    if (clr_en == 1'd1) 
        dataout    <= 12'd0;
    if (inc_en == 1'd1) 
        dataout    <= dataout + 12'd1;
    // if (ac_to_r == 1) r_out     <= datain[11:0];
end
    
endmodule
