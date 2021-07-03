//Remember : all the inputs from bus are 17 bits, outputs to the bus is 12 bits.
`timescale 1 ps / 1 ps
module datamemory #(
    parameter N=17
) (
		input clk,
		input start_writing,
		input write_en,
		input addr,
		input datain,
		output reg [11:0] r1,
		output reg [11:0] r2,
		output reg [11:0] r3,
		output reg [11:0] r4,
		output reg [11:0] r5,
		output reg [11:0] r6,
		output reg [11:0] r7,
		output reg [11:0] r8,
		output reg [11:0] r9,
		output reg [11:0] r10,
		output reg [11:0] r11,
		output reg [11:0] r12,
		output reg [11:0] r13,
		output reg [11:0] r14,
		output reg [11:0] r15,
		output reg [11:0] r16,
		output reg [11:0] dataout,
		output reg start_process
);
    
    reg [11:0] ram [4095:0] ; //[N-1:0] [4095:0]
    localparam start_bit = 4094;
	integer i;
    initial begin
        #10
		  if (start_writing == 1) begin
				$readmemb("D:\\Educational stuff\\PROJECTS\\FPGA-Project\\input and output python and other files\\python_matrix\\mat44.txt", ram);
				@(posedge clk)
				start_writing<=0;
				end
        #10
        for(i=0;i<4096;i=i+1) begin
            $display("%b", ram[i]);
        end
    end

    always @(posedge clk) begin
        r1 <= ram [4]; 
        r2 <= ram [5];
        r3 <= ram [6];
        r4 <= ram [7];
		r5 <= ram [68]; 
        r6 <= ram [69];
        r7 <= ram [70];
        r8 <= ram [71];
		r9 <= ram [132]; 
        r10 <= ram[133];
        r11 <= ram[134];
        r12 <= ram[135];
		r13 <= ram[196]; 
        r14 <= ram[197];
        r15 <= ram[198];
        r16 <= ram[199];
		  if (start_writing == 0) 
		  start_process <= 1;
		  
        if (write_en == 1)
            ram[addr] <= datain[11:0];
        else begin
            dataout <= ram[addr];
        end
    end
    
endmodule