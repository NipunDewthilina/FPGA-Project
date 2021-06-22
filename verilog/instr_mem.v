module instr_mem #(parameter width_in,parameter width_out)(input clk,
input read_en,
input [width_in-1:0] addr,
input [width_in-1:0] instr_in,
output reg[width_out-1:0] instr_out
);

    reg [width_out-1:0] ram [2047:0];

    parameter ldac = 5'd12;
    parameter nop = 5'd1;
    parameter mvacar = 5'd2;
    parameter mvac = 5'd3;
    parameter mvacr1 = 5'd4;
    parameter mvacr2 = 5'd5;
    parameter mvacr3 = 5'd6;
    parameter mvacr4 = 5'd7;
    parameter mvr1ac = 5'd8;
    parameter mvr2ac = 5'd9;
    parameter mvr3ac = 5'd10;
    parameter mvr4ac = 5'd11;
    parameter ldiac = 5'd13;
    parameter stac = 5'd14;
    parameter add = 5'd15;
    parameter mult = 5'd16;
    parameter lshift = 5'd17;
    parameter sub = 5'd18;
    parameter inac = 5'd19;
    parameter jpnz = 5'd20;
    parameter jmpz = 5'd21;

    parameter addr_i = 12'd0;
    parameter addr_j = 12'd1;
    parameter addr_k = 12'd2;

    parameter addr_n = 12'd3;
    parameter addr_2n = 12'd4;
    parameter addr_3n = 12'd5;

    parameter addr_l1 = 12'd0;
    parameter addr_l2 = ;
    parameter addr_l3 = ;

    parameter stac_i = {stac, addr_i};
    parameter stac_j = {stac, addr_j};
    parameter stac_k = {stac, addr_k};

    parameter ldiac_i = {ldiac, addr_i};
    parameter ldiac_j = {ldiac, addr_j};
    parameter ldiac_k = {ldiac, addr_k};
    parameter ldiac_n = {ldiac, addr_n};
    parameter ldiac_2n = {ldiac, addr_2n};
    parameter ldiac_3n = {ldiac, addr_3n};

    parameter jpnz_l1 = {jpnz, addr_l1};
    parameter jpnz_l2 = {jpnz, addr_l2};
    parameter jpnz_l3 = {jpnz, addr_l3};

    initial begin
        ram[0] = ldiac_i; //loop1
        ram[1] = lshift;
        ram[2] = mvac;
        ram[3] = ldiac_k;
        ram[4] = add;
        ram[5] = mvacar;
        ram[6] = ldac;
        ram[7] = mvacr2;
        ram[8] = ldiac_k;
        ram[9] = shift;
        ram[10] = mvac;
        ram[11] = ldiac_j;
        ram[12] = add;
        ram[13] = mvacar;
        ram[14] = ldac;
        ram[15] = mvac;
        ram[16] = mvr2ac;
        ram[17] = mult;
        ram[18] = mvac;
        ram[19] = mvr1ac;
        ram[20] = add;
        ram[21] = mvacr1;
        ram[22] = ldiac_k;
        ram[23] = inac;
        ram[24] = mvac;
        ram[25] = mvacr4;
        ram[26] = stac_k;
        ram[27] = ldiac_3n;
        ram[28] = sub;
        ram[29] = jpnz_l1;
        ram[30] = ldiac_i;
        ram[31] = lshift;
        ram[32] = mvac;
        ram[33] = ldiac_j; 
        ram[34] = add;
        ram[35] = mvacar;
        ram[36] = mvr1ac;
        ram[37] = stac;
        ram[38] = ldiac_2n;
        ram[39] = stac_k;
        ram[40] = ldiac_j; //loop2
        ram[41] = inac;
        ram[42] = stac_j;
        ram[43] = mvac;
        ram[44] = ldiac_2n;
        ram[45] = sub;
        ram[46] = jpnz_l1;
        ram[47] = ldiac_n;
        ram[48] = stac_j;
        ram[49] = ldiac_i; //loop3
        ram[50] = inac;
        ram[51] = stac_i;
        ram[52] = mvrac;
        ram[53] = ldiac_n;
        ram[54] = sub;
        ram[55] = jpnz_l2;
        ram[56] = nop;
    end

    always @(posedge clk) begin
        if (read_en == 1)
            instr_out <= ram[addr];
    end

endmodule

