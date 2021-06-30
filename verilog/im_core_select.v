module im_core_select (
    input [16:0] ins_in,
    input clk,
    output reg [16:0] core1,
    output reg [16:0] core2,
    output reg [16:0] core3,
    output reg [16:0] core4
);

always @(posedge clk) begin
    core1 <= ins_in;
    core2 <= ins_in;
    core3 <= ins_in;
    core4 <= ins_in;
end
    
endmodule