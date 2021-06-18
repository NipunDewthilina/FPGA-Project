module alu 
#(
    parameter N
) (
    input clk,
    input [N-1:0] in1,
    input [N-1:0] in2,
    input [1:0] alu_op,
    output reg [N-1:0] alu_out,
    output reg [N-1:0] z
);
    
    always @(posedge clk) begin
        case (alu_op)
            2'd0 : alu_out <= in1 + in2;
            2'd1 : alu_out <= in1 - in2;
            2'd2 : alu_out <= in1 * in2;
            2'd3 : alu_out <= in1 << in2;
        endcase

        if (alu_out == 0)
            z <= 1;
        else 
            z <= 0;
    end
endmodule
