module control (
    input clk,
    input [15:0] z,
    input [5:0] instruction,
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

    reg [10:0] address = 10'd0;
    wire instruction_ext = {address,instruction};

    parameter 
    start1 =     6'd0,
    fetch1 =     6'd1,
    fetch2 =     6'd2,
    ldac1 =      6'd3,
    ldac2 =      6'd4,
    ldiac1 =     6'd5,
    ldiac2 =     6'd6,
    ldiac3 =     6'd7, //not used
    stac1 =      6'd8,
    mvac1 =      6'd9,
    mvacar =     6'd10,
    mvacr1 =     6'd11,
    mvacr2 =     6'd12,
    mvacr3 =     6'd13,
    mvacr4 =     6'd14,
    mvr1ac =     6'd15,
    mvr2ac =     6'd16,
    mvr3ac =     6'd17,
    mvr4ac =     6'd18,
    add1 =       6'd19,
    mult1 =      6'd20,
    lshift1 =    6'd21,
    sub1 =       6'd22,
    inac1 =      6'd23,
    jpnz1 =      6'd24,
    jpnz2 =      6'd25,
    jmpz1 =      6'd26,//notused
    jmpz2 =      6'd27,//notused
    nop1 =       6'd28,
    clac1 =      6'd30,
    endop =      6'd31,
    ldac1x =     6'd32,
    ldac2x =     6'd33,
    ldiac1x =    6'd34,
    ldiac2x =    6'd35,
    stac1x =     6'd36,
    fetch1x =    6'd37;

    always @(posedge clk) //changed from posedge to negedge
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
                                 // fedcba9876543210
                write_en <=     16'b0000000000000000;
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000110;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            fetch1: begin
                read_en <= 4'd13; //IM
                                 // fedcba9876543210
                write_en <=     16'b0000000000000000;//IR
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch2;
            end

            fetch2: begin 
                read_en <= 4'd13;//im
                write_en <=     16'b0000000000001000;//ir
                inc_en <=       16'b0000000000000000; 
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= instruction ;
            end

            ldac1: begin //read ac write ar!!
                read_en <= 4'd5; //ac
                write_en <=     16'b0000000000000100; //ar
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= ldac2;
            end

            ldac2: begin //Read DM Write AC
                read_en <= 4'd12; //DM
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= ldac2x;
            end

            ldac2x: begin //Write AC
                read_en <= 4'd12; //DM
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            ldiac1: begin //Read IR Write AR
                read_en <= 4'd4; //IR
                write_en <=     16'b0000000000000100; //ar
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= ldiac2;
            end

            ldiac2: begin //read DM Write AC
                read_en <= 4'd12; //DM
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= ldiac2x;
            end

            ldiac2x: begin //read DM Write AC
                read_en <= 4'd12; //DM
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            stac1: begin //Read AC
                read_en <= 4'd5; //ac
                write_en <=     16'b0000000000000000; //dm
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stac1x;
            end

            stac1x: begin //Write DM
                read_en <= 4'd5; //ac
                write_en <=     16'b0000100000000000; //dm
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end


            mvac1: begin
                read_en <= 4'd5; //ac
                write_en <=     16'b000000000100000; //r
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvacar: begin
                read_en <= 4'd5; //ac
                write_en <=     16'b0000000000000100; //ar
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvacr1: begin
                read_en <= 4'd5; //ac
                write_en <=     16'b0000010000000000; //r1
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvacr2: begin
                read_en <= 4'd5; //ac
                write_en <=     16'b0000001000000000; //r2
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvacr3: begin
                read_en <= 4'd5; //ac
                write_en <=     16'b0000000100000000; //r3
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end
                
            mvacr4: begin
                read_en <= 4'd5; //ac
                write_en <=     16'b0000000010000000; //r4
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvr1ac: begin
                read_en <= 4'd7; //r1
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvr2ac: begin
                read_en <= 4'd8; //r2
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvr3ac: begin
                read_en <= 4'd9; //r3
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            mvr4ac: begin
                read_en <= 4'd10; //r4
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            add1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000;  //alu_to_ac changed 22/06/2021
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <=       3'd1; //add
                next <= fetch1;
            end

            sub1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000;  //alu_to_ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd2; //sub
                next <= fetch1;
            end

            mult1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000;  //alu_to_ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd3; //mult
                next <= fetch1;
            end

            lshift1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000; //alu_to_ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd4; //lshift
                next <= fetch1;
            end

            inac1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0000000000000000;  //ac
                inc_en <=       16'b0000000000010010;//ac increment
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            jpnz1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0000000000000000;  
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;

                if (z == 1)
                    next <= fetch1;
                else if(z==0)
                    next <= jpnz2;
            end

            jpnz2: begin
                read_en <= 4'd4; //ir
                write_en <=     16'b0000000000000010; //pc  
                inc_en <=       16'b0000000000000010; 
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            jmpz1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0000000000000000;  
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;

                if (z == 0)
                    next <= fetch1;
                else if(z==1)
                    next <= jmpz2;
            end

            jmpz2: begin
                read_en <= 4'd4; //ir
                write_en <=     16'b0000000000000010; //pc  
                inc_en <=       16'b0000000000000010; 
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

             endop: begin
                read_en <= 4'd0;
                write_en <=     16'b0000000000000000 ;
                inc_en <=       16'b0000000000000010 ;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= endop;
                end
    endcase 
	 end //added end
endmodule

