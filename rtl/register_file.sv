module register_file(input logic clk,reset,write_enable,input logic [4:0] rs1,rs2,rd,input logic [31:0] write_data,output logic [31:0] read_data1,read_data2);
 logic [31:0] regs[0:31]; integer i;
 always_ff @(posedge clk or posedge reset) begin
  if(reset) for(i=0;i<32;i=i+1) regs[i]<=32'b0;
  else if(write_enable && rd!=0) regs[rd]<=write_data;
 end
 always_comb begin read_data1=(rs1==0)?32'b0:regs[rs1]; read_data2=(rs2==0)?32'b0:regs[rs2]; end
endmodule
