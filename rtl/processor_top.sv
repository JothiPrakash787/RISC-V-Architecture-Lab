module processor_top(input logic clk,reset,output logic [31:0] debug_pc,debug_instruction);
 logic [31:0] pc,pc_next,instr,imm,rd1,rd2,alu_b,alu_result,mem_data,writeback,pc4;
 logic reg_write,mem_read,mem_write,alu_src,branch,jump,mem_to_reg,auipc,lui,zero;
 logic [3:0] alu_control; logic [31:0] alu_a; logic [4:0] rs1,rs2,rd;
 assign debug_pc=pc; assign debug_instruction=instr;
 instruction_memory imem(.address(pc-32'h80000000),.instruction(instr));
 imm_generator ig(.instr(instr),.imm(imm));
 control_unit cu(.opcode(instr[6:0]),.funct3(instr[14:12]),.funct7(instr[31:25]),.reg_write(reg_write),.mem_read(mem_read),.mem_write(mem_write),.alu_src(alu_src),.branch(branch),.jump(jump),.mem_to_reg(mem_to_reg),.auipc(auipc),.lui(lui),.alu_control(alu_control));
 assign rs1=instr[19:15];assign rs2=instr[24:20];assign rd=instr[11:7];
 register_file rf(.clk(clk),.reset(reset),.write_enable(reg_write),.rs1(rs1),.rs2(rs2),.rd(rd),.write_data(writeback),.read_data1(rd1),.read_data2(rd2));
 assign alu_a=auipc?pc:rd1; assign alu_b=alu_src?imm:rd2;
 alu alu0(.a(alu_a),.b(alu_b),.alu_control(alu_control),.result(alu_result),.zero(zero));
 data_memory dmem(.clk(clk),.mem_read(mem_read),.mem_write(mem_write),.address(alu_result),.write_data(rd2),.read_data(mem_data));
 assign pc4=pc+4;
 always_comb begin
  writeback=alu_result;
  if(mem_to_reg) writeback=mem_data;
  if(lui) writeback=imm;
  if(jump) writeback=pc4;
  pc_next=pc4;
  if(branch && (rd1==rd2)) pc_next=pc+imm;
  if(jump) begin if(instr[6:0]==7'b1100111) pc_next=(rd1+imm)&32'hfffffffe; else pc_next=pc+imm; end
 end
 always_ff @(posedge clk or posedge reset) begin
  if(reset) pc<=32'h80000000;
  else pc<=pc_next;
 end
endmodule
