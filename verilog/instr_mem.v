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

    localparam addr_i = 12'd4094;
    localparam addr_j = 12'd4093;
    localparam addr_k = 12'd4092;

    localparam addr_n = 12'd4091;
    localparam addr_2n = 12'd4090;
    localparam addr_3n = 12'd4089;

    localparam addr_l1 = 12'd0;
    localparam addr_l2 = 12'd40;
    localparam addr_l3 = 12'd49;

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
        ram[0] = ldiac_i; //loop1
        ram[1] = lshift_addr;
        ram[2] = mvac_addr;
        ram[3] = ldiac_k;
        ram[4] = add_addr;
        ram[5] = mvacar_addr;
        ram[6] = ldac_addr;
        ram[7] = mvacr2_addr;
        ram[8] = ldiac_k;
        ram[9] = lshift_addr;//21
        ram[10] = mvac_addr;//9
        ram[11] = ldiac_j;//5
        ram[12] = add_addr;//
        ram[13] = mvacar_addr;
        ram[14] = ldac_addr;
        ram[15] = mvac_addr;
        ram[16] = mvr2ac_addr;
        ram[17] = mult_addr;
        ram[18] = mvac_addr;
        ram[19] = mvr1ac_addr;
        ram[20] = add_addr;
        ram[21] = mvacr1_addr;
        ram[22] = ldiac_k;
        ram[23] = inac_addr;
        ram[24] = mvac_addr;
        ram[25] = mvacr4_addr;
        ram[26] = stac_k;
        ram[27] = ldiac_3n;
        ram[28] = sub_addr;
        ram[29] = jpnz_l1;
        ram[30] = ldiac_i;
        ram[31] = lshift_addr;
        ram[32] = mvac_addr;
        ram[33] = ldiac_j; 
        ram[34] = add_addr;
        ram[35] = mvacar_addr;
        ram[36] = mvr1ac_addr;
        ram[37] = stac_addr;
        ram[38] = ldiac_2n;
        ram[39] = stac_k;
        ram[40] = ldiac_j; //loop2
        ram[41] = inac_addr;
        ram[42] = stac_j;
        ram[43] = mvac_addr;
        ram[44] = ldiac_2n;
        ram[45] = sub_addr;
        ram[46] = jpnz_l1;
        ram[47] = ldiac_n;
        ram[48] = stac_j;
        ram[49] = ldiac_i; //loop3
        ram[50] = inac_addr;
        ram[51] = stac_i;
        ram[52] = mvac_addr;
        ram[53] = ldiac_n;
        ram[54] = sub_addr;
        ram[55] = jpnz_l2;
        //ram[56] = nop_addr;
        ram[56] = endop_addr;
    end

    always @(posedge clk) begin
        // if (read_en == 1)
            instr_out <= ram[addr];
    end

endmodule


