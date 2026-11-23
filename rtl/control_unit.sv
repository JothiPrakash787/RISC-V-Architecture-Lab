module control_unit(input logic [6:0] opcode,input logic [2:0] funct3,input logic [6:0] funct7,
 output logic reg_write,mem_read,mem_write,alu_src,branch,jump,mem_to_reg,auipc,lui,output logic [3:0] alu_control);
 always_comb begin
  reg_write=0;mem_read=0;mem_write=0;alu_src=0;branch=0;jump=0;mem_to_reg=0;auipc=0;lui=0;alu_control=0;
  case(opcode)
   7'b0110011: begin reg_write=1; case(funct3)
    3'b000: alu_control=(funct7[5])?4'b0001:4'b0000;
    3'b111: alu_control=4'b0010; 3'b110: alu_control=4'b0011; 3'b100: alu_control=4'b0100;
    3'b010: alu_control=4'b0101; 3'b001: alu_control=4'b0110; 3'b101: alu_control=funct7[5]?4'b1000:4'b0111;
    3'b011: alu_control=4'b1001; default: alu_control=0; endcase end
   7'b0010011: begin reg_write=1;alu_src=1;case(funct3)
    3'b000:alu_control=0;3'b111:alu_control=2;3'b110:alu_control=3;3'b100:alu_control=4;3'b010:alu_control=5;3'b011:alu_control=9;
    3'b001:alu_control=6;3'b101:alu_control=funct7[5]?8:7;default:alu_control=0;endcase end
   7'b0000011:begin reg_write=1;mem_read=1;mem_to_reg=1;alu_src=1;end
   7'b0100011:begin mem_write=1;alu_src=1;end
   7'b1100011:begin branch=1;alu_control=1;end
   7'b1101111,7'b1100111:begin reg_write=1;jump=1;end
   7'b0110111:begin reg_write=1;lui=1;end
   7'b0010111:begin reg_write=1;auipc=1;end
   default:begin end
  endcase
 end
endmodule
