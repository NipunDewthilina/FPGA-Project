//registers without increment

module rr #(
    parameter reg_size) (
    input clk,
    input write_en,
    input [reg_size-1:0] datain,
    input r_to_alu,
    output reg [reg_size-1:0] dataout
);

    always @(posedge clk) begin
        if (write_en ==  1 && r_to_alu == 1 )//have to check read_en according to the register type
            dataout <= datain;
    end     
    
endmodule