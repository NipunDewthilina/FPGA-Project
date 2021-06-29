module instr_mem #(parameter width_in,parameter width_out)(input clk,
// input read_en,
input [width_in-1:0] addr,
// input [width_in-1:0] instr_in,
output reg[width_out-1:0] instr_out
);

    reg [width_out-1:0] ram [2047:0];

    localparam ldac = 5'd3;
    localparam nop = 5'd28;
    localparam mvacar = 5'd10;
    localparam mvac = 5'd9;
    localparam mvacr1 = 5'd11;
    localparam mvacr2 = 5'd12;
    localparam mvacr3 = 5'd13;
    localparam mvacr4 = 5'd14;
    localparam mvr1ac = 5'd15;
    localparam mvr2ac = 5'd16;
    localparam mvr3ac = 5'd17;
    localparam mvr4ac = 5'd18;
    localparam ldiac = 5'd5;
    localparam stac = 5'd8;
    localparam add = 5'd19;
    localparam mult = 5'd20;
    localparam lshift = 5'd21;
    localparam sub = 5'd22;
    localparam inac = 5'd23;
    localparam jpnz = 5'd24;
    localparam jmpz = 5'd26;
    localparam endop = 5'd31;
    localparam clac = 5'd30;

    localparam operand = 12'd0;

    localparam nop_addr = {nop,operand};
    localparam add_addr = {add,operand};
    localparam mult_addr = {mult,operand};
    localparam lshift_addr = {lshift,operand};
    localparam mvacar_addr= {mvacar,operand};
    localparam mvac_addr = {mvac,operand};
    localparam mvacr1_addr={mvacr1,operand};
    localparam mvacr2_addr={mvacr2,operand};
    localparam mvacr3_addr={mvacr3,operand};
    localparam mvacr4_addr={mvacr4,operand};
    localparam mvr1ac_addr={mvr1ac,operand};
    localparam mvr2ac_addr={mvr2ac,operand};
    localparam mvr3ac_addr={mvr3ac,operand};
    localparam mvr4ac_addr={mvr4ac,operand};
    localparam sub_addr = {sub,operand};
    localparam endop_addr = {endop,operand};
    localparam inac_addr = {inac,operand};
    localparam ldac_addr = {ldac,operand};
    localparam stac_addr = {stac,operand};
    localparam clac_addr = {clac,operand};

    localparam addr_i = 12'd4094;
    localparam addr_j = 12'd4093;
    localparam addr_k = 12'd4092;

    localparam addr_n = 12'd4091;
    localparam addr_2n = 12'd4090;
    localparam addr_3n = 12'd4089;

    localparam addr_l1 = 12'd2;
    localparam addr_l2 = 12'd66;
    localparam addr_l3 = 12'd85;

    localparam stac_i = {stac, addr_i};
    localparam stac_j = {stac, addr_j};
    localparam stac_k = {stac, addr_k};

    localparam ldiac_i = {ldiac, addr_i};
    localparam ldiac_j = {ldiac, addr_j};
    localparam ldiac_k = {ldiac, addr_k};
    localparam ldiac_n = {ldiac, addr_n};
    localparam ldiac_2n = {ldiac, addr_2n};
    localparam ldiac_3n = {ldiac, addr_3n};

    localparam jpnz_l1 = {jpnz, addr_l1};
    localparam jpnz_l2 = {jpnz, addr_l2};
    localparam jpnz_l3 = {jpnz, addr_l3};

    initial begin
        ram[0 ] = clac_addr;
        ram[1 ] = mvacr1_addr;
        ram[2 ] = ldiac_i; //loop1
        ram[3 ]  = nop_addr;
        ram[4 ]  = nop_addr;
        ram[5 ] = lshift_addr;
        ram[7 ] = nop_addr;
        ram[8 ] = nop_addr;
        ram[9 ] = nop_addr;
        ram[10] = mvac_addr;
        ram[11] = ldiac_k;
        ram[ 12] = mvacr3_addr;
        ram[ 13]  = nop_addr;
        ram[ 14]  = nop_addr;
        ram[ 15] = add_addr;
        ram[ 16] = mvacar_addr;
        ram[ 17] = ldac_addr;
        ram[ 18]  = nop_addr;
        ram[ 19]  = nop_addr;
        ram[ 20] = mvacr2_addr;
        ram[ 21] = mvr3ac_addr;
        ram[ 22]  = nop_addr;
        ram[ 23]  = nop_addr;
        ram[ 24] = lshift_addr;//21
        ram[ 25] = mvac_addr;//9
        ram[ 26] = ldiac_j;//5
        ram[ 27]  = nop_addr;
        ram[ 28]  = nop_addr;
        ram[ 29] = add_addr;//
        ram[ 30] = mvacar_addr;
        ram[ 31] = ldac_addr;
        ram[ 32]  = nop_addr;
        ram[ 33]  = nop_addr;
        ram[ 34] = mvac_addr;
        ram[ 35] = mvr2ac_addr;
        ram[ 36] = mult_addr;
        ram[ 37] = mvac_addr;
        ram[ 38] = mvr1ac_addr;
        ram[ 39] = add_addr;
        ram[ 40] = mvacr1_addr;
        ram[ 41] = ldiac_k;
        ram[ 42]  = nop_addr;
        ram[ 43]  = nop_addr;
        ram[ 44] = inac_addr;
        ram[ 45] = mvac_addr;
        ram[ 46] = mvacr4_addr;
        ram[ 47] = stac_k;
        ram[ 48]  = nop_addr;
        ram[ 49]  = nop_addr;
        ram[ 50] = ldiac_3n;
        ram[ 51] = sub_addr;
        ram[ 52] = jpnz_l1;
        ram[ 53] = ldiac_i;
        ram[ 54]  = nop_addr;
        ram[ 55]  = nop_addr;
        ram[ 56] = lshift_addr;
        ram[ 57] = mvac_addr;
        ram[ 58] = ldiac_j; 
        ram[ 59]  = nop_addr;
        ram[ 60]  = nop_addr;
        ram[ 61] = add_addr;
        ram[ 62] = mvacar_addr;
        ram[ 63] = mvr1ac_addr;
        ram[ 64] = stac_addr;
        ram[ 65]  = nop_addr;
        ram[ 66]  = nop_addr;
        ram[ 67] = ldiac_2n;
        ram[ 68] = stac_k;
        ram[ 69]  = nop_addr;
        ram[ 70]  = nop_addr;
        ram[ 71] = ldiac_j; //loop2
        ram[ 72]  = nop_addr;
        ram[ 73]  = nop_addr;
        ram[ 74] = inac_addr;
        ram[ 75] = stac_j;
        ram[ 76]  = nop_addr;
        ram[ 77]  = nop_addr;
        ram[ 78] = mvac_addr;
        ram[ 79] = ldiac_2n;
        ram[ 80]  = nop_addr;
        ram[ 81]  = nop_addr;
        ram[ 82] = sub_addr;
        ram[ 83] = jpnz_l1;
        ram[ 84] = ldiac_n;
        ram[ 85]  = nop_addr;
        ram[ 86]  = nop_addr;
        ram[ 87] = stac_j;
        ram[ 88]  = nop_addr;
        ram[ 89]  = nop_addr;
        ram[ 90] = ldiac_i; //loop3
        ram[ 91]  = nop_addr;
        ram[ 92]  = nop_addr;
        ram[ 93] = inac_addr;
        ram[ 94] = stac_i;
        ram[ 95]  = nop_addr;
        ram[ 96]  = nop_addr;
        ram[ 97] = mvac_addr;
        ram[ 98] = ldiac_n;
        ram[ 99]  = nop_addr;
        ram[100]  = nop_addr;
        ram[101] = sub_addr;
        ram[102] = jpnz_l2;
        ram[103] = endop_addr;
    end

    always @(posedge clk) begin
        // if (read_en == 1)
            instr_out <= ram[addr];
    end

endmodule


