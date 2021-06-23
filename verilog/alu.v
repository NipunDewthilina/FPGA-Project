module alu 
#(
    parameter N,
    parameter width_of_i
) (
    input clk,
    input signed reg [N-1:0] in1,
    input signed reg [N-1:0] in2,
    input [2:0] alu_op,
    output reg [N-1:0] alu_out,
    output reg [N-1:0] z
);
    
    always @(posedge clk) begin
        case (alu_op)
            3'd0 : alu_out <= in1;
            3'd1 : alu_out <= in1 + in2;
            3'd2 : alu_out <= in1 - in2;
            3'd3 : alu_out <= in1 * in2;
            3'd4 : alu_out <= in1 << width_of_i;
        endcase

        if (alu_out == 0)
            z <= 1;
        else 
            z <= 0;
    end
endmodule
