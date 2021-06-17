// class Random_Num #(WIDTH);
//     rand bit signed [WIDTH-1:0] num;
// endclass

// class Random_Sel;
//     rand bit [2:0] num;
//     constraint c {num inside {[0:4]};}

//     function new();
//         this.randomize();
//     endfunction
// endclass

module alu_tb ();

    timeunit 1ns;
    timeprecision 1ps;
    logic clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    localparam N = 8;
    reg [1:0] alu_op;
    reg signed [WIDTH-1:0] in1, in2, alu_out;
    wire z;

    alu #(.N(N)) dut (.*);

    // Random_Num #(.WIDTH(WIDTH)) A_r, B_r;
    // Random_Sel sel_r;

    initial begin
        in1 <= 8'd5;
        in2 <= 8'd10;
        alu_op <= 2'd0;

        @(posedge clk);
        in1 <= 8'd30;
        in2 <= 8'd10;
        alu_op <= 2'd0;

        @(posedge clk);
        in1 <= 8'd5;
        in2 <= 8'd10;
        alu_op <= 2'd1;

        @(posedge clk);
        in1 <= 8'd51;
        B <= 8'd17;
        sel <= 2'd2;
    end
endmodule
