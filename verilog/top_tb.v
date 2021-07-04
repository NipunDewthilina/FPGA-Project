`timescale 1ns/1ps
module top_tb;

    //timeunit 1ns;
    //timeprecision 1ps;
    reg clk = 0;
    localparam CLK_PERIOD = 10;
    initial begin
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    reg slow_clk = 0;
    initial begin
        forever #(100 / 2) slow_clk = ~slow_clk;
    end

    wire[11:0] result;
    reg [11:0] addr_tb;
    wire end_process1;
    wire end_process2;
    wire end_process3;
    wire end_process4;
	// reg start_process;
    // parameter N_reg = 12;
    reg [11:0] addr_mem [63:0];
    integer i = 0;
    integer file_id;
    initial begin
        #10;
        $readmemb("D:\\Educational stuff\\PROJECTS\\FPGA-Project\\addr_mem.txt", addr_mem);
        #10;
        file_id = $fopen("D:\\Educational stuff\\PROJECTS\\FPGA-Project\\result.txt","w");
        #10;
    end

    top top(.clk(clk),.addr_tb(addr_tb),.result(result),
    .end_process1(end_process1),.end_process2(end_process2),.end_process3(end_process3),.end_process4(end_process4));//later initiate this
	 

initial begin
    repeat(100000) begin
        @ (posedge clk) 
        if (end_process1 && end_process2 && end_process3 && end_process4) begin
            addr_tb <= addr_mem[i];
				i <= i+1;
                $fwrite(file_id,"%d\n ",result);
                
				if (i == 64) begin
				$fclose(file_id);
				$stop;
				end
		end
		#(CLK_PERIOD*4);
    end
    
end

endmodule




    

