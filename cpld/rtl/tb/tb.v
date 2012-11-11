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

	wire [ 7:0] bd;

	wire brd_n, bwr_n;


	reg [7:0] tmp;




	wire [9:0] w5300_addr;
	wire       w5300_rst_n;
	wire       w5300_cs_n;
	wire       w5300_int_n;

	wire       sl811_rst_n;
	wire       sl811_a0;
	wire       sl811_cs_n;
	wire       sl811_ms_n;
	wire       sl811_intrq;

	
	
	reg usb_power;


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

		.zcsrom_n(csrom_n),
		
		.ziorqge(iorqge),
		.zblkrom(blkrom),

		.zrst_n(rst_n),
		.zint_n(int_n),

		.bd(bd),

		.bwr_n(bwr_n),
		.brd_n(brd_n),


		.w5300_rst_n(w5300_rst_n),
		.w5300_addr (w5300_addr ),
		.w5300_cs_n (w5300_cs_n ),
		.w5300_int_n(w5300_int_n),
		
		.sl811_rst_n(sl811_rst_n),
		.sl811_intrq(sl811_intrq),
		.sl811_ms_n (sl811_ms_n ),
		.sl811_cs_n (sl811_cs_n ),
		.sl811_a0   (sl811_a0   ),

		.usb_power(usb_power)

	);












	ssz80 z
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





	w5300 w
	(
		.rst_n(w5300_rst_n),
		.addr (w5300_addr ),
		.cs_n (w5300_cs_n ),
		.rd_n (brd_n      ),
		.wr_n (bwr_n      ),
		.int_n(w5300_int_n),
		.d(bd)
	);


	sl811 s
	(
		.rst_n(sl811_rst_n),
		.a0   (sl811_a0   ),
		.cs_n (sl811_cs_n ),
		.wr_n (bwr_n      ),
		.rd_n (brd_n      ),
		.ms   (~sl811_ms_n),
		.intrq(sl811_intrq),
		.d(bd)
	);


	// csrom gen
	assign csrom_n = (a[15:14]==where_rom[1:0]);

	
	
	
	
	
////////////////////////////////////////////////////////////////////////////////	
////////////////////////////////////////////////////////////////////////////////	
////////////////////////////////////////////////////////////////////////////////	
/// here start tests

	initial
	begin : tests
	
		reg [15:0] rstint_port = 16'h83_AB;
		reg [15:0] w5300_port  = 16'h82_AB;
		reg [15:0] sl811_port  = 16'h81_AB;
		reg [15:0] sl_addr     = 16'h80_AB;
		reg [15:0] sl_data     = 16'h7F_AB;
	
		reg [7:0] tmp;
		reg [7:0] tmp2;

		
		wait(rst_n===1'b1);

		repeat(10) @(posedge clk);
	
	

		// test resets state after reset
		if( w.get_rst_n() !== 1'b0 )
		begin
			$display("w5300 hasn't rst_n=0 after reset!");
			$stop;
		end
		//
		if( s.get_rst_n() !== 1'b0 )
		begin
			$display("sl811 hasn't rst_n=0 after reset!");
			$stop;
		end

		// read reset register and check it
		z.iord(rstint_port,tmp);
		if( tmp[5:4]!==2'b00 )
		begin
			$display("reset bits in #83AB not 0 after reset!");
			$stop;
		end

		// remove resets
		z.iowr(rstint_port, {tmp[7:6],2'b11,tmp[3:0]} );
		// check whether resets has been removed
		if( w.get_rst_n() !== 1'b1 )
		begin
			$display("w5300 hasn't rst_n=1 port clear!");
			$stop;
		end
		//
		if( s.get_rst_n() !== 1'b1 )
		begin
			$display("sl811 hasn't rst_n=1 after port clear!");
			$stop;
		end

		




		
		
		$display("all tests passed!");
		$stop;
	end

	
	

	
	
	
	
	
	
	
	
	
	
	
	




endmodule

