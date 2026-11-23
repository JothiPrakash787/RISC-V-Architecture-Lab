module instruction_memory(input logic [31:0] address,output logic [31:0] instruction);
 logic [31:0] rom[0:255]; integer i;
 initial begin
  for(i=0;i<256;i=i+1) rom[i]=32'h00000013; // NOPs
  // Demo program: x1=5; x2=7; x3=x1+x2; store/load; taken BEQ; skip x5=1; x5=9.
  rom[0]=32'h00500093; // addi x1,x0,5
  rom[1]=32'h00700113; // addi x2,x0,7
  rom[2]=32'h002081b3; // add x3,x1,x2
  rom[3]=32'h00302023; // sw x3,0(x0)
  rom[4]=32'h00002203; // lw x4,0(x0)
  rom[5]=32'h00418463; // beq x3,x4,+8
  rom[6]=32'h00100293; // addi x5,x0,1 (skipped)
  rom[7]=32'h00900293; // addi x5,x0,9
  rom[8]=32'h00000013; // nop
 end
 assign instruction=rom[address[9:2]];
endmodule
