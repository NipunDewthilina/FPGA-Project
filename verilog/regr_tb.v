`timescale 1ns/1ps
module regr_tb;

    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    localparam N = 17;

    reg write_en;
    reg [16: 0] datain;
    wire [11: 0] dataout;

    regr #(.N(N)) dut (.clk(clk), .write_en(write_en), .datain(datain), .dataout(dataout))

    initial begin
        #(CLK_PERIOD * 4)
        datain <= 17'd12;
        write_en <= 1'd1;

        @(posedge clk)
        write_en <= 0;

        @(posedge clk)
        write_en <= 1;
        datain <= 17'd29;

        $stop;

    end

endmodule
