`timescale 1ns/1ps
`include "memory.v"

module top();
	parameter DEPTH      = 16;
	parameter WIDTH      = 8;
	parameter ADDR_WIDTH = 4;

	reg clk, rst, wr_rd, vaild;
	reg [ADDR_WIDTH-1:0] addr;
	reg [WIDTH-1:0] wdata;
	wire [WIDTH-1:0] rdata;
	wire ready;

	memory #(.DEPTH(DEPTH), .WIDTH(WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
		.clk(clk),
		.rst(rst),
		.wr_rd(wr_rd),
		.wdata(wdata),
		.rdata(rdata),
		.vaild(vaild),
		.ready(ready),
		.addr(addr)
	);

	// Clock generation
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	// Test sequence
	initial begin
		rst = 1;
		wr_rd = 0;
		vaild = 0;
		addr = 0;
		wdata = 0;
		#10;
		rst = 0;          // Release reset
		#10;

		// Write data to memory
		wr_rd = 1;
		vaild = 1;
		addr  = 4;
		wdata = 8'hA5;
		#10;

		// Read data from memory
		wr_rd = 0;
		vaild = 1;
		addr  = 4;
		#10;

		vaild = 0;
		#10;
		$display("Read data at addr 4 = %h (expected A5)", rdata);
		$finish;
	end
endmodule
