module bus #(parameter N)( input clk,
input [3:0] read_en,
input [11:0] r1,
input [11:0] r2,
input [11:0] r3,
input [11:0] r4,
input [11:0] ir,
input [11:0] ac,
input [11:0] dm,
input [N-1:0] im,
input [11:0] r,
output reg [N-1:0] busout ) ;
always @(r or r1 or r2 or r3 or r4 or ir or ac or im or read_en or dm)

   begin
   case(read_en)
   4'd3: busout <= r+ 18'd0;
   4'd4: busout <= ir+18'd0;
   4'd5: busout <= ac+18'd0;
   4'd7: busout <= r1+18'd0;
   4'd8: busout <= r2+18'd0;
   4'd9: busout <= r3+18'd0;
   4'd10: busout <= r4+  18'd0;
   4'd12: busout <= dm + 18'd0;
   4'd13: busout <= im;
   default: busout <= 18'd0;
   endcase
   end
   endmodule