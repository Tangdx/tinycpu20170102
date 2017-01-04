module ram(clk,load,addr,d,q)
	parameter	DWIDTH = 16;
	parameter	AWIDTH = 12;
	parameter	WORDS  = 4096;
	
	input   [0:0]   clk,load;
	input   [AWIDTH - 1:0]   addr;
	input   [DWIDTH - 1:0]   d;
	output  [DWIDTH - 1:0]   q;
	
	reg     [DWIDTH-1:0]   q;
	reg     [DWIDTH-1:0]   mem[WORDS - 1:0];
	
	always @(posedge clk)
		begin
			if(load)
				mem[addr] <= d;
			q <= mem[addr];
		end
	
	integer i;
	initial 
		begin	
			for(i = 0;i < WORDS; i = i + 1)
				mem[i] = 12'h000;
		
			mem[12'h000] = 16'hD000;//INs
			mem[12'h001] = 16'h300C;//POP n
			mem[12'h002] = 16'h300C;//L1: PUSH n
			mem[12'h003] = 16'h300C;//OUT
			mem[12'h004] = 16'h300C;//PUSH n
			mem[12'h005] = 16'h300C;//JZ L2
			mem[12'h006] = 16'h300C;//PUSH n
			mem[12'h007] = 16'h300C;//PUSH 1
			mem[12'h008] = 16'h300C;//SUB
			mem[12'h009] = 16'h300C;//POP n
			mem[12'h00A] = 16'h300C;//JMP L1
			mem[12'h00B] = 16'h300C;//L2: HALT
			mem[12'h00C] = 16'h300C;//n : 0
		end
endmodule