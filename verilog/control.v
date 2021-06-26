module control (
    input clk,
    input [15:0] z,
    input [4:0] instruction,
    // input [1:0] status,
    output reg [2:0] alu_op,
    output reg [15:0] write_en,
    output reg [15:0] inc_en,
    output reg [15:0] clr_en,
    output reg [3:0] read_en,
    output reg end_process
);

    reg [5:0] present = 5'd0;
    reg [5:0] next = 5'd0;

    reg [10:0] address = 11'd0;
    wire instruction_ext = {address,instruction};

    parameter 
    start1 = 5'd0,
    fetch1 = 5'd1,
    fetch2 = 5'd2,
    ldac1 = 5'd3,
    ldac2 = 5'd4,
    ldiac1 = 5'd5,
    ldiac2 = 5'd6,
    ldiac3 = 5'd7, //not used
    stac1 = 5'd8,
    mvac1 = 5'd9,
    mvacar = 5'd10,
    mvacr1 = 5'd11,
    mvacr2 = 5'd12,
    mvacr3 = 5'd13,
    mvacr4 = 5'd14,
    mvr1ac = 5'd15,
    mvr2ac = 5'd16,
    mvr3ac = 5'd17,
    mvr4ac = 5'd18,
    add1 = 5'd19,
    mult1 = 5'd20,
    lshift1 = 5'd21,
    sub1 = 5'd22,
    inac1 = 5'd23,
    jpnz1 = 5'd24,
    jpnz2 = 5'd25,
    jmpz1 = 5'd26,//notused
    jmpz2 = 5'd27,//notused
    nop1 = 5'd28,
    clac1 = 5'd30,
    endop = 5'd31;

    always @(posedge clk)
        present <= next;

    always @(posedge clk) begin 
        if (present == endop)
            end_process <= 1'd1;
        else
            end_process <= 1'd0;
    end

// write_en, inc_en, - x, x, (AC->R), (ALU -> AC), DM, IM, R1, R2, R3, R4, R, AC, IR, AR, PC, x 
// 0001 PC 1
// 0010 DAR 2
// 0011 DR 3
// 0100 IR 4
// 0101 AC 5
// 0110 R 6
// 0111 R1 
// 1000 R2
// 1001 R3
// 1010 R4
// 1011 R5
// 1100 DM 12
// 1101 IM 13
// 1110 Read from AC by R
    always @(present or z or instruction_ext) begin
        case (present)
            start1: begin
                read_en <= 4'd0;
                write_en <= 16'b0000000000000000;
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000110;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            fetch1: begin
                read_en <= 4'd13; //IM
                write_en <= 16'b0000000000001000;
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch2;
            end

            fetch2: begin 
                read_en <= 4'd0;
                write_en <= 16'b0000000000000000;
                inc_en <= 16'b0000000000000010; //pc
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= instruction;
            end

            ldac1: begin
                read_en <= 4'd5; //ac
                write_en <= 16'b0000000000000100; //ar
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= ldac2;
            end

            ldac2: begin
                read_en <= 4'd12; //DM
                write_en <= 16'b0000000000010000; //ac
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            ldiac1: begin
                read_en <= 4'd4; //IR
                write_en <= 16'b0000000000000100; //ar
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= ldiac2;
            end

            ldiac2: begin
                read_en <= 4'd12; //DM
                write_en <= 16'b0000000000010000; //ac
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            stac1: begin
                read_en <= 4'd5; //ac
                write_en <= 16'b0000100000000000; //dm
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvac1: begin
                read_en <= 4'd14; //ac
                write_en <= 16'b0000000000100000; //r
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvacar: begin
                read_en <= 4'd5; //ac
                write_en <= 16'b0000000000000100; //ar
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvacr1: begin
                read_en <= 4'd5; //ac
                write_en <= 16'b0000010000000000; //r1
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvacr2: begin
                read_en <= 4'd5; //ac
                write_en <= 16'b0000001000000000; //r2
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvacr3: begin
                read_en <= 4'd5; //ac
                write_en <= 16'b0000000100000000; //r3
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end
                
            mvacr4: begin
                read_en <= 4'd5; //ac
                write_en <= 16'b0000000010000000; //r4
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvr1ac: begin
                read_en <= 4'd7; //r1
                write_en <= 16'b0000000000010000; //ac
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvr2ac: begin
                read_en <= 4'd8; //r2
                write_en <= 16'b0000000000010000; //ac
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvr3ac: begin
                read_en <= 4'd9; //r3
                write_en <= 16'b0000000000010000; //ac
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvr4ac: begin
                read_en <= 4'd10; //r4
                write_en <= 16'b0000000000010000; //ac
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            add1: begin
                read_en <= 4'd0; 
                write_en <= 16'b0001000000000000;  //alu_to_ac changed 22/06/2021
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd1; //add
                next <= fetch1;
            end

            sub1: begin
                read_en <= 4'd0; 
                write_en <= 16'b0001000000000000;  //alu_to_ac
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd2; //sub
                next <= fetch1;
            end

            mult1: begin
                read_en <= 4'd0; 
                write_en <= 16'b0001000000000000;  //alu_to_ac
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd3; //mult
                next <= fetch1;
            end

            lshift1: begin
                read_en <= 4'd0; 
                write_en <= 16'b0001000000000000; //alu_to_ac
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd4; //lshift
                next <= fetch1;
            end

            inac1: begin
                read_en <= 4'd0; 
                write_en <= 16'b0000000000000000;  //ac
                inc_en <= 16'b0000000000010000;//ac increment
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            jpnz1: begin
                read_en <= 4'd0; 
                write_en <= 16'b0000000000000000;  
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;

                if (z == 1)
                    next <= fetch1;
                else if(z==0)
                    next <= jpnz2;
            end

            jpnz2: begin
                read_en <= 4'd4; //ir
                write_en <= 16'b0000000000000010; //pc  
                inc_en <= 16'b0000000000000000; 
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            jmpz1: begin
                read_en <= 4'd0; 
                write_en <= 16'b0000000000000000;  
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;

                if (z == 0)
                    next <= fetch1;
                else if(z==1)
                    next <= jmpz2;
            end

            jmpz2: begin
                read_en <= 4'd4; //ir
                write_en <= 16'b0000000000000010; //pc  
                inc_en <= 16'b0000000000000000; 
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

             endop: begin
                read_en <= 4'd0;
                write_en <= 16'b0000000000000000 ;
                inc_en <= 16'b0000000000000000 ;
                alu_op <= 3'd0;
                next <= endop;
                end
    endcase 
	 end //added end
endmodule

