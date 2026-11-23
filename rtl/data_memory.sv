module data_memory(input logic clk,mem_read,mem_write,input logic [31:0] address,write_data,output logic [31:0] read_data);
 logic [31:0] mem[0:255]; integer i;
 initial begin for(i=0;i<256;i=i+1) mem[i]=32'b0; end
 always_ff @(posedge clk) if(mem_write) mem[address[9:2]]<=write_data;
 always_comb read_data=mem[address[9:2]];
endmodule
