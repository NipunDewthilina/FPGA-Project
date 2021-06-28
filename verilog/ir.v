//registers with increment

module ir #(
    parameter N
) (
    input clk,
    input write_en,
    // input read_en,
    input [N-1:0] datain,
    input inc_en,
    output reg [11:0] dataout = 12'd0,
    output reg [5:0] instruction
    
);

    always @(posedge clk) begin
        if (write_en == 1)
            dataout <= datain[11:0];//lower half is feed to bus
            instruction <= datain[16:12];//higher half is the instruction
        // if (read_en == 4'd4)
        //     dataout <= datain[11:0];//lower half is feed to bus for either ar or pc
    end
    
endmodule