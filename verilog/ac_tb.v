`timescale 1ns/1ps
module ac_tb;

    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    localparam N = 17;

    reg wire;
    reg [16: 0] datain;
    reg [11: 0] alu_out;
    reg alu_to_ac;
    reg inc_en;
    reg clr_en;

    wire [11: 0] dataout;

    ac #(.N(N)) dut (.clk(clk), .write_en(write_en), .datain(datain), .alu_out(alu_out), .alu_to_ac(alu_to_ac), .inc_en(inc_en),
        .clr_en(clr_en), .dataout(dataut))

    initial begin
        #(CLK_PERIOD * 4)
        datain <= 12'd12;
        write_en <= 1'd1;
        alu_to_ac <= 0;
        inc_en <= 0;

        @(posedge clk)
        alu_to_ac <= 1'd1;
        write_en <= 0;
        alu_out <= 12'd23;
        inc_en <= 0;

        @(posedge clk)
        dataout <= 12'd1;
        write_en <= 0;
        alu_to_ac <= 0;
        inc_en <= 1;

        $stop;

    end

endmodule

