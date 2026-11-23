`timescale 1ns/1ps
module processor_tb;
 logic clk=0,reset=1; logic [31:0] pc,instr; integer cycles;
 always #5 clk=~clk;
 processor_top dut(.clk(clk),.reset(reset),.debug_pc(pc),.debug_instruction(instr));
 initial begin
  repeat(2) @(posedge clk); reset=0;
  for(cycles=0;cycles<10;cycles=cycles+1) @(posedge clk);
  #1;
  if(dut.rf.regs[1]!==32'd5) $fatal(1,"x1 expected 5, got %0d",dut.rf.regs[1]);
  if(dut.rf.regs[2]!==32'd7) $fatal(1,"x2 expected 7, got %0d",dut.rf.regs[2]);
  if(dut.rf.regs[3]!==32'd12) $fatal(1,"x3 expected 12, got %0d",dut.rf.regs[3]);
  if(dut.dmem.mem[0]!==32'd12) $fatal(1,"memory[0] expected 12, got %0d",dut.dmem.mem[0]);
  if(dut.rf.regs[4]!==32'd12) $fatal(1,"x4 expected 12, got %0d",dut.rf.regs[4]);
  if(dut.rf.regs[5]!==32'd9) $fatal(1,"branch failed: x5 expected 9, got %0d",dut.rf.regs[5]);
  $display("PASS: processor test completed. x3=%0d, memory[0]=%0d, x4=%0d, x5=%0d",dut.rf.regs[3],dut.dmem.mem[0],dut.rf.regs[4],dut.rf.regs[5]);
  $finish;
 end
endmodule
