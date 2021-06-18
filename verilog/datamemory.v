module datamemory #(
    parameter N = 16
) (
    input write_en,
    input [N-1:0] addr, //[15:0]
    input [N-1:0] datain,
    output reg [(N/2)-1:0] dataout //[7:0]
);
    
    reg [(N/2)-1:0] ram [65535:0] ; //[7:0] [65535:0]

    always @(posedge clk) begin
        if (write_en == 1)
            ram[addr] <= datain[(N/2)-1:0];
        else begin
            dataout <= ram[addr];
        end
    end
    
endmodule)