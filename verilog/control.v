module control (
    input clk,
    input [15:0] z,
    input [5:0] instruction,
    input start_process,
    // input [1:0] status,
    output reg [2:0] alu_op,
    output reg [15:0] write_en,
    output reg [15:0] inc_en,
    output reg [15:0] clr_en,
    output reg [3:0] read_en,
    output reg end_process
);

    reg [5:0] present = 6'd43;
    reg [5:0] next = 6'd43;

    wire [9:0] address = 10'd0;
    wire [15:0] instruction_ext = {address,instruction};

    localparam 
    start1 =     6'd43,
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
    add1x =      6'd38,
    mult1x =     6'd39,
    lshift1x =   6'd40,
    sub1x =      6'd41,
    inac1 =      6'd23,
    jpnz1 =      6'd24,
    jpnz2 =      6'd25,
    nop1 =       6'd28,
    clac1 =      6'd30,
    endop =      6'd31,
    ldac1x =     6'd32,
    ldac2x =     6'd33,
    ldiac1x =    6'd34,
    ldiac2x =    6'd35,
    stac1x =     6'd36,
    fetch1x =    6'd37,
    stiac1 =     6'd26,
    stiac2 =     6'd27,
    stiac2x=     6'd42,
    lshift_1=    6'd44,
    lshift_1x=   6'd56,
    rshift_1=    6'd45,
    rshift_1x=   6'd57,
    stiac_rm1=   6'd46,
    stiac_rm1x=  6'd47,
    stiac_rm1y=  6'd48,
    stiac_rm2=   6'd49,
    stiac_rm2x=  6'd50,
    stiac_rm2y=  6'd51,
    stiac_rm3=   6'd52,
    stiac_rm3x=  6'd53,
    stiac_rm3y=  6'd54,
    stiac_rm4=   6'd55,
    stiac_rm4x=  6'd58,
    stiac_rm4y=  6'd59;

    always @(posedge clk) 
        present <= next;

    always @(posedge clk) begin 
        if (present == endop)
            end_process <= 1'd1;
        else
            end_process <= 1'd0;
    end

// write_en, inc_en, - x, AC->ALU,R->ALU, (AC->R), (ALU -> AC), DM, IM, R1, R2, R3, R4, R, AC, IR, AR, PC, x 
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
    always @(present or z or instruction_ext or start_process) begin
        case (present)
            start1: begin
                read_en <= 4'd0;
                                 // fedcba9876543210
                write_en <=     16'b0000000000000000;
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000010;
                alu_op <= 3'd0;
                if (start_process == 1)
                    next <= fetch1;
                else begin
                    next <= start1;
                end
            end

            fetch1: begin
                read_en <= 4'd13; //IM
                                 // fedcba9876543210
                write_en <=     16'b0000000000001000;//IR
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch2;
            end

            fetch2: begin 
                read_en <= 4'd0;
                write_en <=     16'b0000000000000000;
                inc_en <=       16'b0000000000000000; 
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= instruction_ext[5:0] ;
            end

            ldac1: begin //read ac write ar!!
                read_en <= 4'd5; //ac
                write_en <=     16'b0000000000000100; //ar
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= ldac2;
            end

            // ldac1x : begin
            //     read_en <= 4'd0; //ac
            //     write_en <=     16'b0000000000000000; //ar
            //     inc_en <=       16'b0000000000000000;
            //     clr_en <=       16'b0000000000000000;
            //     alu_op <= 3'd0;
            //     next <= ldac1x;
            // end

            ldac2: begin //Read DM Write AC
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
                next <= ldiac1x;
            end

            ldiac1x : begin //
                read_en <= 4'd0; //ac
                write_en <=     16'b0000000000000000; //ar
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= ldiac2;
            end

            ldiac2: begin //read DM Write AC
                read_en <= 4'd12; //DM
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            stac1: begin //Read AC
                read_en <= 4'd5; //ac
                write_en <=     16'b0000100000000000; //dm
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stac1x;
            end

            stac1x: begin //Write DM
                read_en <= 4'd5; 
                write_en <=     16'b0000000000000000; 
                inc_en <=       16'b0000000000000010;//pc
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            stiac1 : begin
                read_en <= 4'd4; //IR
                write_en <= 16'b0000000000000100; //AR
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac2;
            end

            stiac2 : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b0000100000000000; //DM
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac2x;
            end

            stiac2x : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b0000000000000000; 
                inc_en <= 16'b0000000000000010;//pc
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            stiac_rm1 : begin
                read_en <= 4'd4; //IR
                write_en <= 16'b0000000000000100; //AR
                inc_en <= 16'b0000000000000000;//pc
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac_rm1x;
            end

            stiac_rm1x : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b0000000000000001; //DM-Rm1 index 0
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac_rm1y;
            end

            stiac_rm1y : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b0000000000000000; 
                inc_en <= 16'b0000000000000010;//pc
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            stiac_rm2 : begin
                read_en <= 4'd4; //IR
                write_en <= 16'b0000000000000100; //AR
                inc_en <= 16'b0000000000000000;//pc
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac_rm2x;
            end

            stiac_rm2x : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b1000000000000000; //DM-Rm2 index 15
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac_rm2y;
            end

            stiac_rm2y : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b0000000000000000; 
                inc_en <= 16'b0000000000000010;//pc
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            stiac_rm3 : begin
                read_en <= 4'd4; //IR
                write_en <= 16'b0000000000000100; //AR
                inc_en <= 16'b0000000000000000;//pc
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac_rm3x;
            end

            stiac_rm3x : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b0100000000000000; //DM-Rm3 index 14
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac_rm3y;
            end

            stiac_rm3y : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b0000000000000000; 
                inc_en <= 16'b0000000000000010;//pc
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            stiac_rm4 : begin
                read_en <= 4'd4; //IR
                write_en <= 16'b0000000000000100; //AR
                inc_en <= 16'b0000000000000000;//pc
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac_rm4x;
            end

            stiac_rm4x : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b0010000000000000; //DM-Rm4 index 13
                inc_en <= 16'b0000000000000000;
                clr_en <= 16'b0000000000000000;
                alu_op <= 3'd0;
                next <= stiac_rm4y;
            end

            stiac_rm4y : begin
                read_en <= 4'd5; //AC
                write_en <= 16'b0000000000000000; 
                inc_en <= 16'b0000000000000010;//pc
                clr_en <= 16'b0000000000000000;
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
                next <=  fetch1;
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
                next <=  fetch1;
            end

            mvr1ac: begin
                read_en <= 4'd7; //r1
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <=  fetch1;
            end

            mvr2ac: begin
                read_en <= 4'd8; //r2
                write_en <=     16'b0000000000010000; //ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <=  fetch1;
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
                next <=  fetch1;
            end

            add1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000;  //ac to alu, r to alu
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <=       3'd1; //add
                next <=  add1x;
            end

            add1x: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000;  //alu_to_ac 
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <=       3'd0; //add
                next <= fetch1;
            end

            sub1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000;  //ac to alu, r to alu
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd2; //sub
                next <=  sub1x;
            end

            sub1x: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000;  //alu_to_ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0; //sub
                next <= fetch1;
            end

            mult1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000;  //alu_to_ac
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd3; //mult
                next <=  mult1x;
            end

            mult1x: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000;  //ac to alu, r to alu
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0; //mult
                next <= fetch1;
            end

            lshift1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000; //alu_to_ac
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd4; //lshift
                next <=  lshift1x;
            end

            lshift1x: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000; //alu_to_ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0; //lshift
                next <= fetch1;
            end

            lshift_1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000; //alu_to_ac
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd5; //lshift
                next <=  lshift_1x;
            end

            lshift_1x: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000; //alu_to_ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0; //lshift by 1
                next <= fetch1;
            end

            rshift_1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000; //alu_to_ac
                inc_en <=       16'b0000000000000000;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd6; 
                next <=  rshift_1x;
            end

            rshift_1x: begin
                read_en <= 4'd0; 
                write_en <=     16'b0001000000000000; //alu_to_ac
                inc_en <=       16'b0000000000000010;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0; //rshift by 1
                next <= fetch1;
            end

            inac1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0000000000000000;  //ac
                inc_en <=       16'b0000000000010010;//ac increment
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <=  fetch1;
            end

            jpnz1: begin
                read_en <= 4'd0; 
                write_en <=     16'b0000000000000000;  
                inc_en <=       16'b0000000000000010;
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
                inc_en <=       16'b0000000000000000; 
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end

            // jmpz1: begin
            //     read_en <= 4'd0; 
            //     write_en <=     16'b0000000000000000;  
            //     inc_en <=       16'b0000000000000010;
            //     clr_en <=       16'b0000000000000000;
            //     alu_op <= 3'd0;

            //     if (z == 0)
            //         next <= fetch1;
            //     else if(z==1)
            //         next <= jmpz2;
            // end

            // jmpz2: begin
            //     read_en <= 4'd4; //ir
            //     write_en <=     16'b0000000000000010; //pc  
            //     inc_en <=       16'b0000000000000000; 
            //     clr_en <=       16'b0000000000000000;
            //     alu_op <= 3'd0;
            //     next <= fetch1;
            // end

             endop: begin
                read_en <= 4'd12;
                write_en <=     16'b0000000000000000 ;
                inc_en <=       16'b0000000000000000 ;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= endop;
                end
            
            nop1: begin
                read_en <= 4'd0;
                write_en <=     16'b0000000000000000 ;
                inc_en <=       16'b0000000000000010 ;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
                end
            
            clac1 : begin
                read_en <= 4'd0;
                write_en <=     16'b0000000000000000 ;
                inc_en <=       16'b0000000000000010 ;
                clr_en <=       16'b0000000000010000;
                alu_op <= 3'd0;
                next <= fetch1;
            end
            
            default : begin
                read_en <= 4'd0;
                write_en <=     16'b0000000000000000 ;
                inc_en <=       16'b0000000000000000 ;
                clr_en <=       16'b0000000000000000;
                alu_op <= 3'd0;
                next <= fetch1;
            end
                
    endcase 
	 end //added end
endmodule

