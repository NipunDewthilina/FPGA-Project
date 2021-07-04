`timescale 1ns/1ps
module ir_tb;

    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    localparam N = 17;

    reg write_en;
    reg [16: 0] datain;
    reg inc_en;

    wire [11: 0] dataout;
    wire [5: 0] instruction;

    ir (.N(N)) dut (.clk(clk), .write_en(write_en), .datain(datain), .inc_en(inc_en),
    .dataout(dataout), .instruction(instruction));

    initial begin
        #(CLK_PERIOD*4);

        @(posedge clk);
        write_en <= 0;
        datain <= 17'd12;
        
        @(posedge clk);
        write_en <= 1;
        datain <= 17'd123;

        $stop;
    end

endmodule
