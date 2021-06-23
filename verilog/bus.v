module bus #(parameter N)( input clk,
input [3:0] read_en,
input [11:0] r1,
input [11:0] r2,
input [11:0] r3,
input [11:0] r4,
input [11:0] ir,
input [11:0] ac,
input [11:0] dm,
input [16:0] im,
output reg [N-1:0] busout ) ;
always @(r1 or r2 or r3 or r4 or ir or ac or im or read_en or dm)

   begin
   case(read_en)
   4'd4: busout <= ir+17'd0;
   4'd5: busout <= ac+17'd0;
   4'd7: busout <= r1+17'd0;
   4'd8: busout <= r2+17'd0;
   4'd9: busout <= r3+17'd0;
   4'd10: busout <= r4+17'd0;
   4'd12: busout <= dm + 17'd0;
   4'd13: busout <= im+ 17'd0;
   default: busout <= 17'd0;
   endcase
   end
   endmodule