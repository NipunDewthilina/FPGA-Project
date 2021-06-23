module instr_mem #(parameter width_in,parameter width_out)(input clk,
// input read_en,
input [width_in-1:0] addr,
// input [width_in-1:0] instr_in,
output reg[width_out-1:0] instr_out
);

    reg [width_out-1:0] ram [2047:0];

    parameter ldac = 5'd3;
    parameter nop = 5'd28;
    parameter mvacar = 5'd10;
    parameter mvac = 5'd9;
    parameter mvacr1 = 5'd11;
    parameter mvacr2 = 5'd12;
    parameter mvacr3 = 5'd13;
    parameter mvacr4 = 5'd14;
    parameter mvr1ac = 5'd15;
    parameter mvr2ac = 5'd16;
    parameter mvr3ac = 5'd17;
    parameter mvr4ac = 5'd18;
    parameter ldiac = 5'd5;
    parameter stac = 5'd8;
    parameter add = 5'd19;
    parameter mult = 5'd20;
    parameter lshift = 5'd21;
    parameter sub = 5'd22;
    parameter inac = 5'd23;
    parameter jpnz = 5'd24;
    parameter jmpz = 5'd26;
    parameter endop = 5'd31;

    parameter addr_i = 12'd4095;
    parameter addr_j = 12'd4094;
    parameter addr_k = 12'd4093;

    parameter addr_n = 12'd4092;
    parameter addr_2n = 12'd4091;
    parameter addr_3n = 12'd4090;

    parameter addr_l1 = 12'd0;
    parameter addr_l2 = 12'd40;
    parameter addr_l3 = 12'd49;

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
        ram[1] = lshift+17'd0;
        ram[2] = mvac+17'd0;
        ram[3] = ldiac_k;
        ram[4] = add+17'd0;
        ram[5] = mvacar+17'd0;
        ram[6] = ldac+17'd0;
        ram[7] = mvacr2+17'd0;
        ram[8] = ldiac_k;
        ram[9] = lshift+17'd0;
        ram[10] = mvac+17'd0;
        ram[11] = ldiac_j;
        ram[12] = add+17'd0;
        ram[13] = mvacar+17'd0;
        ram[14] = ldac+17'd0;
        ram[15] = mvac+17'd0;
        ram[16] = mvr2ac+17'd0;
        ram[17] = mult+17'd0;
        ram[18] = mvac+17'd0;
        ram[19] = mvr1ac+17'd0;
        ram[20] = add+17'd0;
        ram[21] = mvacr1+17'd0;
        ram[22] = ldiac_k;
        ram[23] = inac+17'd0;
        ram[24] = mvac+17'd0;
        ram[25] = mvacr4+17'd0;
        ram[26] = stac_k;
        ram[27] = ldiac_3n;
        ram[28] = sub+17'd0;
        ram[29] = jpnz_l1;
        ram[30] = ldiac_i;
        ram[31] = lshift+17'd0;
        ram[32] = mvac+17'd0;
        ram[33] = ldiac_j; 
        ram[34] = add+17'd0;
        ram[35] = mvacar+17'd0;
        ram[36] = mvr1ac+17'd0;
        ram[37] = stac+17'd0;
        ram[38] = ldiac_2n;
        ram[39] = stac_k;
        ram[40] = ldiac_j; //loop2
        ram[41] = inac+17'd0;
        ram[42] = stac_j;
        ram[43] = mvac+17'd0;
        ram[44] = ldiac_2n;
        ram[45] = sub+17'd0;
        ram[46] = jpnz_l1;
        ram[47] = ldiac_n;
        ram[48] = stac_j;
        ram[49] = ldiac_i; //loop3
        ram[50] = inac+17'd0;
        ram[51] = stac_i;
        ram[52] = mvac+17'd0;
        ram[53] = ldiac_n;
        ram[54] = sub+17'd0;
        ram[55] = jpnz_l2;
        ram[56] = nop+17'd0;
        ram[57] = endop+17'd0;
    end

    always @(posedge clk) begin
        // if (read_en == 1)
            instr_out <= ram[addr];
    end

endmodule


