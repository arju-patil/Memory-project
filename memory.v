module memory(clk, rst, wr_rd, wdata, rdata, vaild, ready, addr);
	parameter DEPTH      = 16;
	parameter WIDTH      = 8;
	parameter ADDR_WIDTH = $clog2(DEPTH);

	input clk, rst, wr_rd, vaild;
	input [ADDR_WIDTH-1:0] addr;
	input [WIDTH-1:0] wdata;
	output reg ready;
	output reg [WIDTH-1:0] rdata;
	reg [WIDTH-1:0] mem [DEPTH-1:0];

	integer i;

	always @(posedge clk) begin
		if (rst == 1) begin
			rdata = 0;
			ready = 0;
			for (i = 0; i < DEPTH; i = i + 1)
				mem[i] = 0;
		end
		else begin
			if (vaild == 1) begin
				ready = 1;
				if (wr_rd == 1)
					mem[addr] = wdata;
				else
					rdata = mem[addr];
			end
			else begin
				ready = 0;
			end
		end
endmodule
