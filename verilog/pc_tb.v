`timescale 1ns/1ps
module pc_tb;

    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    localparam N = 17;

    reg write_en;
    reg [16: 0] datain;
    reg inc_en;
    reg clr_en;
    wire [11: 0] dataout;

    pc #(.N(N)) dut (.clk(clk), .write_en(write_en), .datain(datain), .inc_en(inc_en),
        .clr_en(clr_en), .dataout(dataout))

    initial begin
        #(CLK_PERIOD * 4)
        datain <= 17'd12;
        write_en <= 1'd1;
        clr_en <= 0;
        inc_en <= 0;

        @(posedge clk)
        write_en <= 0;
        clr_en <= 0;
        inc_en <= 1;

        @(posedge clk)
        write_en <= 0;
        clr_en <= 1;
        inc_en <= 0;

        $stop;

    end

endmodule
