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

	wire int_n;

	wire csrom_n;

	wire iorqge,
	     blkrom;
	

	wire [15:0] a;
	wire [ 7:0] d;


	reg [7:0] tmp;




	wire [9:0] w5300_addr;
	wire       w5300_rst_n;
	wire       w5300_cs_n;
	wire       w5300_int_n;

	wire       sl811_rst_n;
	wire       sl811_a0;
	wire       sl811_cs_n;
	wire       sl811_ms;
	wire       sl811_intrq;


	reg [1:0] where_rom;





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
		where_rom = 2'b00;
	end




	initial
	begin
		wait(rst_n===1'b1);
		@(posedge clk);

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

		.zcsrom_n(csrom_n),
		
		.ziorqge(iorqge),
		.zblkrom(blkrom),

		.zrst_n(rst_n),
		.zint_n(int_n),


		.w5300_rst_n(w5300_rst_n),
		.w5300_addr (w5300_addr ),
		.w5300_cs_n (w5300_cs_n ),
		.w5300_int_n(w5300_int_n),
		
		.sl811_rst_n(sl811_rst_n),
		.sl811_intrq(sl811_intrq),
		.sl811_ms   (sl811_ms   ),
		.sl811_cs_n (sl811_cs_n ),
		.sl811_a0   (sl811_a0   )

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





	w5300 w5300
	(
		.rst_n(w5300_rst_n),
		.addr (w5300_addr ),
		.cs_n (w5300_cs_n ),
		.rd_n (rd_n       ),
		.wr_n (wr_n       ),
		.int_n(w5300_int_n)
	);


	sl811 sl811
	(
		.rst_n(sl811_rst_n),
		.a0   (sl811_a0   ),
		.cs_n (sl811_cs_n ),
		.wr_n (wr_n       ),
		.rd_n (rd_n       ),
		.ms   (sl811_ms   ),
		.intrq(sl811_intrq)
	);





	// csrom gen
	assign csrom_n = (a[15:14]==where_rom[1:0]);





endmodule

