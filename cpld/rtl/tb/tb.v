// ZXiznet project
// (c) NedoPC 2012
//
// testbench


`timescale 1ns/1ns

// CPU at 14MHz
`define HALF_CPU_PERIOD (35)


module tb;

	reg rst_n;
	reg clk;


	tri1 iorq_n,
	     mreq_n,
	     rd_n,
	     wr_n;

	wire [15:0] a;
	wire [ 7:0] d;


	reg [7:0] tmp;




	initial
	begin
		clk = 1'b1;

		forever #`HALF_CPU_PERIOD clk = ~clk;
	end


	initial
	begin
		rst_n = 1'b0;

		repeat(3) @(posedge clk);

		rst_n <= 1'b1;
	end




	initial
	begin
		wait(rst_n===1'b1);
		@(posedge clk);

		ssz80.memwr(16'h1234,8'hAB);
		ssz80.memwr(16'habcd,8'h54);
		ssz80.memrd(16'h1111,tmp);
		ssz80.iowr(16'h2222,8'h99);
		ssz80.iord(16'heeee,tmp);
	end







	top DUT
	(
		.za(a),
		.zd(d),

		.ziorq_n(iorq_n),
		.zmreq_n(mreq_n),
		.zrd_n(rd_n),
		.zwr_n(wr_n),
		.zrfsh_n(1'b1),

		.zcsrom_n(a[15:14]===2'b00),

		.zrst_n(rst_n)

	);












	ssz80 ssz80
	(
		.clk  (clk  ),
		.rst_n(rst_n),

		.iorq_n(iorq_n),
		.mreq_n(mreq_n),
		.rd_n  (rd_n  ),
		.wr_n  (wr_n  ),

		.a(a),
		.d(d)
	);





endmodule

