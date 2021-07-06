module instr_mem #(parameter width_in,parameter width_out)(input clk,
// input read_en,
input [width_in-1:0] addr1,
input [width_in-1:0] addr2,// not used
input [width_in-1:0] addr3,// not used
input [width_in-1:0] addr4,// not used
output reg[17:0] instr_out
);

    reg [17:0] ram [4095:0];

    localparam ldac =    6'd3;
    localparam nop =     6'd28;
    localparam mvacar =  6'd10;
    localparam mvac =    6'd9;
    localparam mvacr1 =  6'd11;
    localparam mvacr2 =  6'd12;
    localparam mvacr3 =  6'd13;
    localparam mvacr4 =  6'd14;
    localparam mvr1ac =  6'd15;
    localparam mvr2ac =  6'd16;
    localparam mvr3ac =  6'd17;
    localparam mvr4ac =  6'd18;
    localparam ldiac =   6'd5;
    localparam stac =    6'd8;
    localparam add =     6'd19;
    localparam mult =    6'd20;
    localparam lshift =  6'd21;
    localparam sub =     6'd22;
    localparam inac =    6'd23;
    localparam jpnz =    6'd24;
    localparam endop =   6'd31;
    localparam clac =    6'd30;
    localparam stiac =   6'd26;
    localparam stiac_rm1 = 6'd46;
    localparam stiac_rm2 = 6'd49;
    localparam stiac_rm3 = 6'd52;
    localparam stiac_rm4 = 6'd55;
    localparam lshift_1 = 6'd44;
    localparam rshift_1 = 6'd45;

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
    localparam lshift_1_addr = {lshift_1,operand};
    localparam rshift_1_addr = {rshift_1,operand};

    localparam addr_i = 12'd4094;
    localparam addr_j = 12'd4093;
    localparam addr_k = 12'd4092;
    localparam addr_k_2n = 12'd4086;
    localparam addr_j_n = 12'd4087;

    localparam addr_n = 12'd4091;
    localparam addr_i_range = 12'd4090;
    localparam addr_j_range = 12'd4089;
    localparam addr_k_range = 12'd4088;

    localparam addr_l1 = 12'd51;
    localparam addr_l2 = 12'd121;
    localparam addr_l3 = 12'd140;

    localparam stac_i = {stiac,addr_i};
    localparam stac_j = {stiac, addr_j};
    localparam stac_k = {stiac, addr_k};

    localparam stac_i_rm1 = {stiac_rm1, addr_i};
    localparam stac_j_rm1 = {stiac_rm1, addr_j};
    localparam stac_k_rm1 = {stiac_rm1, addr_k};
    localparam stac_i_rm2 = {stiac_rm2, addr_i};
    localparam stac_j_rm2 = {stiac_rm2, addr_j};
    localparam stac_k_rm2 = {stiac_rm2, addr_k};
    localparam stac_i_rm3 = {stiac_rm3, addr_i};
    localparam stac_j_rm3 = {stiac_rm3, addr_j};
    localparam stac_k_rm3 = {stiac_rm3, addr_k};
    localparam stac_i_rm4 = {stiac_rm4, addr_i};
    localparam stac_j_rm4 = {stiac_rm4, addr_j};
    localparam stac_k_rm4 = {stiac_rm4, addr_k};

    localparam stac_i_range_rm1 = {stiac_rm1, addr_i_range};
    localparam stac_j_range_rm1 = {stiac_rm1, addr_j_range};
    localparam stac_k_range_rm1 = {stiac_rm1, addr_k_range};
    localparam stac_i_range_rm2 = {stiac_rm2, addr_i_range};
    localparam stac_j_range_rm2 = {stiac_rm2, addr_j_range};
    localparam stac_k_range_rm2 = {stiac_rm2, addr_k_range};
    localparam stac_i_range_rm3 = {stiac_rm3, addr_i_range};
    localparam stac_j_range_rm3 = {stiac_rm3, addr_j_range};
    localparam stac_k_range_rm3 = {stiac_rm3, addr_k_range};
    localparam stac_i_range_rm4 = {stiac_rm4, addr_i_range};
    localparam stac_j_range_rm4 = {stiac_rm4, addr_j_range};
    localparam stac_k_range_rm4 = {stiac_rm4, addr_k_range};

    localparam stac_k_2n_rm1 = {stiac_rm1, addr_k_2n};
    localparam stac_j_n_rm1 =  {stiac_rm1, addr_j_n};
    localparam stac_k_2n_rm2 = {stiac_rm2, addr_k_2n};
    localparam stac_j_n_rm2 =  {stiac_rm2, addr_j_n};
    localparam stac_k_2n_rm3 = {stiac_rm3, addr_k_2n};
    localparam stac_j_n_rm3 =  {stiac_rm3, addr_j_n};
    localparam stac_k_2n_rm4 = {stiac_rm4, addr_k_2n};
    localparam stac_j_n_rm4=   {stiac_rm4, addr_j_n};

    localparam ldiac_n = {ldiac,addr_n};
    localparam ldiac_i = {ldiac, addr_i};
    localparam ldiac_j = {ldiac, addr_j};
    localparam ldiac_k = {ldiac, addr_k};
    localparam ldiac_i_range = {ldiac, addr_i_range};
    localparam ldiac_j_range = {ldiac, addr_j_range};
    localparam ldiac_k_range = {ldiac, addr_k_range};
    localparam ldiac_k_2n = {ldiac, addr_k_2n};
    localparam ldiac_j_n = {ldiac, addr_j_n};

    localparam jpnz_l1 = {jpnz, addr_l1};
    localparam jpnz_l2 = {jpnz, addr_l2};
    localparam jpnz_l3 = {jpnz, addr_l3};

    initial begin

        ram[0  ] = clac_addr;//clear AC
        ram[1  ] = ldiac_n;//load n
        ram[2  ] = stac_j_rm1;//store ram1 j
        ram[3  ] = stac_j_n_rm1;
        ram[4  ] = stac_j_rm3;//store ram3 j
        ram[5  ] = stac_j_n_rm3;
        ram[6  ] = stac_i_range_rm2;
        ram[7  ] = stac_i_range_rm3;
        ram[8  ] = mvacr1_addr; // send n to R1
        ram[9  ] = lshift_1_addr;//mult n by 2 -> 2n
        ram[10 ] = mvacr2_addr; //send 2n to R2
        ram[11 ] = stac_k_rm1; //store ram1 k
        ram[ 12] = stac_k_rm2; //store ram2 k
        ram[ 13] = stac_k_rm3; //store ram3 k
        ram[ 14] = stac_k_rm4; //store ram4 k
        ram[ 15] = stac_k_2n_rm1;
        ram[ 16] = stac_k_2n_rm2;
        ram[ 17] = stac_k_2n_rm3;
        ram[ 18] = stac_k_2n_rm4;
        ram[ 19] = stac_j_range_rm2;
        ram[ 20] = stac_j_range_rm4;
        ram[ 21] = mvr1ac_addr; //get n from R1
        ram[ 22] = rshift_1_addr;//n/2
        ram[ 23] = stac_i_range_rm1;//store i range in ram1
        ram[ 24] = stac_i_range_rm4;//store i range in ram4
        ram[ 25] = stac_i_rm2;
        ram[ 26] = stac_i_rm3;
        ram[ 27] = mvac_addr;//send n/2 to R
        ram[ 28] = mvacr3_addr; //send n/2 to R3
        ram[ 29] = mvr2ac_addr;//send 2n to AC
        ram[ 30] = sub_addr; //2n-n/2
        ram[ 31] = stac_j_range_rm1;//store j range in ram1
        ram[ 32] = stac_j_range_rm3; //store j range in ram3
        ram[ 33] = mvr2ac_addr; //get 2n to AC
        ram[ 34] = mvac_addr;//get 2n to R
        ram[ 35] = mvr1ac_addr; //get n to AC
        ram[ 36] = add_addr;//get 3n to AC
        ram[ 37] = stac_k_range_rm1;//store k range in ram1
        ram[ 38] = stac_k_range_rm2;//store k range in ram2
        ram[ 39] = stac_k_range_rm3;//store k range in ram3
        ram[ 40] = stac_k_range_rm4;//store k range in ram4
        ram[ 41] = mvr3ac_addr; //get n/2 from R3 to AC
        ram[ 42] = mvac_addr;//send n/2 to R
        ram[ 43] = mvr1ac_addr;//send n from R1
        ram[ 44] = add_addr;
        ram[ 45] = stac_j_rm2;
        ram[ 46] = stac_j_rm4;
        ram[ 47] = stac_j_n_rm2;
        ram[ 48] = stac_j_n_rm4; //all the indices are saved
        ram[ 49] = clac_addr;
        ram[ 50] = mvacr1_addr;
        ram[ 51] = ldiac_i; //loop1
        ram[ 52] = nop_addr;
        ram[ 53] = nop_addr;
        ram[ 54] = lshift_addr;
        ram[ 55] = nop_addr;
        ram[ 56] = nop_addr;
        ram[ 57] = nop_addr;
        ram[ 58] = mvac_addr;
        ram[ 59] = ldiac_k;
        ram[ 60] = mvacr3_addr;
        ram[ 61]  = nop_addr;
        ram[ 62]  = nop_addr;
        ram[ 63] = add_addr;
        ram[ 64] = mvacar_addr;
        ram[ 65] = ldac_addr;
        ram[ 66]  = nop_addr;
        ram[ 67]  = nop_addr;
        ram[ 68] = mvacr2_addr;
        ram[ 69] = mvr3ac_addr;
        ram[ 70]  = nop_addr;
        ram[ 71]  = nop_addr;
        ram[ 72] = lshift_addr;//21
        ram[ 73] = mvac_addr;//9
        ram[ 74] = ldiac_j;//5
        ram[ 75]  = nop_addr;
        ram[ 76]  = nop_addr;
        ram[ 77] = add_addr;//
        ram[ 78] = mvacar_addr;
        ram[ 79] = ldac_addr;
        ram[ 80]  = nop_addr;
        ram[ 81]  = nop_addr;
        ram[ 82] = mvac_addr;
        ram[ 83] = mvr2ac_addr;
        ram[ 84] = mult_addr;
        ram[ 85] = mvac_addr;
        ram[ 86] = mvr1ac_addr;
        ram[ 87] = add_addr;
        ram[ 88] = mvacr1_addr;//r1 loading over
        ram[ 89] = ldiac_k;
        ram[ 90]  = nop_addr;
        ram[ 91]  = nop_addr;
        ram[ 92] = inac_addr;
        ram[ 93] = mvac_addr;
        ram[ 94] = mvacr4_addr;
        ram[ 95] = stac_k;
        ram[ 96]  = nop_addr;
        ram[ 97]  = nop_addr;
        ram[ 98] = ldiac_k_range;
        ram[ 99] = sub_addr;
        ram[100] = jpnz_l1;
        ram[101] = ldiac_i;
        ram[102]  = nop_addr;
        ram[103]  = nop_addr;
        ram[104] = lshift_addr;
        ram[105] = mvac_addr;
        ram[106] = ldiac_j; 
        ram[107]  = nop_addr;
        ram[108]  = nop_addr;
        ram[109] = add_addr;
        ram[110] = mvacar_addr;
        ram[111] = mvr1ac_addr;
        ram[112] = stac_addr;
        ram[113] = clac_addr;
        ram[114] = mvacr1_addr;
        ram[115]  = nop_addr;
        ram[116]  = nop_addr;
        ram[117] = ldiac_k_2n;//k init value
        ram[118] = stac_k;//reset k
        ram[119]  = nop_addr;
        ram[120]  = nop_addr;
        ram[121] = ldiac_j; //loop2
        ram[122]  = nop_addr;
        ram[123]  = nop_addr;
        ram[124] = inac_addr;
        ram[125] = stac_j;
        ram[126]  = nop_addr;
        ram[127]  = nop_addr;
        ram[128] = mvac_addr;
        ram[129] = ldiac_j_range;
        ram[130]  = nop_addr;
        ram[131]  = nop_addr;
        ram[132] = sub_addr;
        ram[133] = jpnz_l1;
        ram[134] = ldiac_j_n;
        ram[135]  = nop_addr;
        ram[136]  = nop_addr;
        ram[137] = stac_j;
        ram[138]  = nop_addr;
        ram[139]  = nop_addr;
        ram[140] = ldiac_i; //loop3
        ram[141]  = nop_addr;
        ram[142]  = nop_addr;
        ram[143] = inac_addr;
        ram[144] = stac_i;
        ram[145]  = nop_addr;
        ram[146]  = nop_addr;
        ram[147] = mvac_addr;
        ram[148] = ldiac_i_range;
        ram[149]  = nop_addr;
        ram[150]  = nop_addr;
        ram[151] = sub_addr;
        ram[152] = jpnz_l1;
        ram[153] = nop_addr;
        ram[154] = nop_addr;
        ram[155] = nop_addr;
        ram[156] = nop_addr;
        ram[157] = endop_addr;
    end

    always @(posedge clk) begin
        // if (read_en == 1)
            instr_out <= ram[addr1];

    end

endmodule


