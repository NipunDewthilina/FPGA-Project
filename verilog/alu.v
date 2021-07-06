module alu 
#(
    parameter N,
    parameter width_of_i
) (
    input clk,
    input [N-1:0] in1,
    input [N-1:0] in2,
    input [2:0] alu_op,
    output reg [N-1:0] alu_out,
    output reg [15:0] z
);
    
    always @(posedge clk) begin
        case (alu_op)
            3'd1 : alu_out <= in1 + in2;
            3'd2 : alu_out <= in1 - in2;
            3'd3 : alu_out <= in1 * in2;
            3'd4 : alu_out <= in1 << width_of_i;
            3'd5 : alu_out <= in1 << 1; //multiplying by 2
            3'd6 : alu_out <= in1 >> 1; //dividing by 2
            3'd0 : alu_out <= in1;
        endcase

        if (alu_out == 0)
            z <= 16'd1;
        else 
            z <= 16'd0;
    end
endmodule
