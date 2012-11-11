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

	tri1 int_n;

	wire csrom_n;

	wire iorqge,
	     blkrom;
	

	wire [15:0] a;
	wire [ 7:0] d;

	wire [ 7:0] #1 bd;

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
	assign csrom_n = !(a[15:14]==where_rom[1:0]);

	
	
	
	
	
////////////////////////////////////////////////////////////////////////////////	
////////////////////////////////////////////////////////////////////////////////	
////////////////////////////////////////////////////////////////////////////////	
/// here start tests

	reg [15:0] rstint_port = 16'h83_AB;
	reg [15:0] w5300_port  = 16'h82_AB;
	reg [15:0] sl811_port  = 16'h81_AB;
	reg [15:0] sl_addr     = 16'h80_AB;
	reg [15:0] sl_data     = 16'h7F_AB;
	
	initial
	begin : tests
	
	
		reg [7:0] tmp;
		reg [7:0] tmp2;

		
		wait(rst_n===1'b1);

		repeat(10) @(posedge clk);
	
	

		test_resets();

		test_ints();

		check_sl811_port();


		repeat(10000)
		begin
			if( $random>>31 )
				check_sl811_access();
			else
				check_w5300_access();
		end

		








		




		
		
		$display("all tests passed!");
		$stop;
	end

	
	

	
	
	
	







	// translates memory address to w5300 address in accordance with specs
	function [9:0] mk_w5300_addr( input [13:0] mem_addr );

		if( mem_addr<14'h2000 )
		begin
			mk_w5300_addr = mem_addr[9:0];
		end
		else if( mem_addr<14'h3000 )
		begin
			mk_w5300_addr[9] = 1'b1;
			mk_w5300_addr[8:6] = mem_addr[11:9];
			mk_w5300_addr[5:1] = 5'b10111;
			mk_w5300_addr[0] = mem_addr[0];
		end
		else // if( mem_addr<14'h4000 )
		begin
			mk_w5300_addr[9] = 1'b1;
			mk_w5300_addr[8:6] = mem_addr[11:9];
			mk_w5300_addr[5:1] = 5'b11000;
			mk_w5300_addr[0] = mem_addr[0];
		end

	endfunction






	task check_w5300_access;

		reg [7:0] tmp,rddata,wrdata;
		reg [15:0] memaddr;
		reg [ 9:0] waddr;

		reg [1:0] rom;
		reg       a0_inv;
		reg       sub_ena;


		rom    = $random>>30;
		a0_inv = $random>>31;
		sub_ena= $random>>31;

		z.iowr(w5300_port,{4'd0,a0_inv,sub_ena,rom});

		z.iord(w5300_port,tmp);
		if( tmp[3:0]!=={a0_inv,sub_ena,rom} )
		begin
			$display("can't set w5300 port!");
			$stop;
		end


		if( $random>>31 )
			where_rom = rom;
		else
		begin
			where_rom = $random>>30;
			while( where_rom==rom )
				where_rom = $random>>30;
		end



		w.init_access(); // clear access_* to X


		memaddr = $random>>18;
		memaddr[15:14] = where_rom;



		if( $random>>31 )
		begin
			wrdata = $random>>24;
			z.memwr(memaddr,wrdata);
			if( where_rom==rom && sub_ena )
			begin
				if( w.get_addr()!==(mk_w5300_addr(memaddr[13:0])^a0_inv) ||
				    w.get_rnw()!==1'b0                                   ||
				    w.get_wr_data()!==wrdata                             )
				begin
					$display("w5300 write failed!");
					$stop;
				end
			end
			else
			begin
				if( w.get_addr()!=={10{1'bX}} || w.get_rnw()!==1'bX || w.get_wr_data()!=={8{1'bX}} )
				begin
					$display("write succeeded with wrong ROM mapping!");
					$stop;
				end
			end
		end
		else
		begin
			rddata = $random>>24;
			w.set_rd_data(rddata);
			z.memrd(memaddr,tmp);
			if( where_rom==rom && sub_ena )
			begin
				if( w.get_addr()!==(mk_w5300_addr(memaddr[13:0])^a0_inv) ||
				    w.get_rnw()!==1'b1                                   ||
				    tmp!==rddata                                         )
				begin
					$display("w5300 read failed!");
					$stop;
				end
			end
			else
			begin
				if( w.get_addr()!=={10{1'bX}} || w.get_rnw()!==1'bX )
				begin
					$display("read succeeded with wrong ROM mapping!");
					$stop;
				end
			end
		end













	endtask







	task check_sl811_access;

		reg [7:0] tmp, rddata, wrdata;

		reg [15:0] rdport;


		// check address reg
		wrdata=$random>>24;
		z.iowr(sl_addr,wrdata);
		if( s.get_rnw()!==1'b0 || s.get_addr()!==1'b0 || s.get_wr_data()!==wrdata )
		begin
			$display("sl811 address write failed!");
			$stop;
		end
		//
		rddata=$random>>24;
		s.set_rd_data(rddata);
		z.iord(sl_addr,tmp);
		if( s.get_rnw()!==1'b1 || s.get_addr()!==1'b0 || tmp!==rddata )
		begin
			$display("sl811 address read failed!");
			$stop;
		end

		// check data reg
		rdport=sl_data;
		rdport[14:8]=$random>>25;
		wrdata=$random>>24;
		z.iowr(rdport,wrdata);
		if( s.get_rnw()!==1'b0 || s.get_addr()!==1'b1 || s.get_wr_data()!==wrdata )
		begin
			$display("sl811 data write failed!");
			$stop;
		end
		//
		rddata=$random>>24;
		s.set_rd_data(rddata);
		z.iord(rdport,tmp);
		if( s.get_rnw()!==1'b1 || s.get_addr()!==1'b1 || tmp!==rddata )
		begin
			$display("sl811 data read failed!");
			$stop;
		end

	endtask




	task check_sl811_port;

		reg [7:0] tmp;

		z.iowr(sl811_port,8'd0);
		@(posedge clk);
		if( s.get_ms()!==0 )
		begin
			$display("can't set sl811_ms_n to 1!");
			$stop;
		end

		z.iowr(sl811_port,8'd1);
		@(posedge clk);
		if( s.get_ms()!==1 )
		begin
			$display("can't set sl811_ms_n to 0!");
			$stop;
		end
		
		usb_power <= 1'b0;
		z.iord(sl811_port,tmp);
		if( tmp[1]!==0 )
		begin
			$display("can't sense usb_power=0!");
			$stop;
		end

		usb_power <= 1'b1;
		z.iord(sl811_port,tmp);
		if( tmp[1]!==1 )
		begin
			$display("can't sense usb_power=1!");
			$stop;
		end



	endtask





	
	task test_ints;

		reg [7:0] tmp;

		// check ints
		z.iord(rstint_port,tmp);
		if( tmp[1:0]!==2'b00 )
		begin
			$display("int requests after reset!");
			$stop;
		end
		if( tmp[3:2]!==2'b00 )
		begin
			$display("ints enabled after reset!");
			$stop;
		end
		if( tmp[7]!==1'b0 )
		begin
			$display("internal int is on after reset!");
			$stop;
		end
		if( tmp[6]!==1'b0 )
		begin
			$display("ext.int assertion enabled after reset!");
			$stop;
		end
		//
		s.set_intrq(1'b1);
		z.iord(rstint_port,tmp);
		if( tmp[1]!==1'b1 )
		begin
			$display("cant sense INTRQ from sl811!");
			$stop;
		end
		w.set_int_n(1'b0);
		z.iord(rstint_port,tmp);
		if( tmp[0]!==1'b1 )
		begin
			$display("cant sense int_n from w5300!");
			$stop;
		end
		//
		z.iowr(rstint_port,{tmp[7:4],2'b10,tmp[1:0]});
		z.iord(rstint_port,tmp);
		if( tmp[7]!==1'b1 )
		begin
			$display("sl811 doesn't participate in internal int!");
			$stop;
		end
		z.iowr(rstint_port,{tmp[7:4],2'b01,tmp[1:0]});
		z.iord(rstint_port,tmp);
		if( tmp[7]!==1'b1 )
		begin
			$display("w5300 doesn't participate in internal int!");
			$stop;
		end
		z.iowr(rstint_port,{tmp[7:4],2'b11,tmp[1:0]});
		z.iord(rstint_port,tmp);
		if( tmp[7]!==1'b1 )
		begin
			$display("both chips doesn't participate in internal int!");
			$stop;
		end
		//
		z.iowr(rstint_port,{tmp[7],1'b1,tmp[5:0]});
		@(posedge clk);
		if( int_n!==1'b0 )
		begin
			$display("no int_n on internal int!");
			$stop;
		end
		// remove ints
		s.set_intrq(1'b0);
		@(posedge clk);
		if( int_n!==1'b0 )
		begin
			$display("int_n removed after sl811 removed intrq while w5300 didn't!");
			$stop;
		end
		w.set_int_n(1'b1);
		@(posedge clk);
		if( int_n!==1'b1 )
		begin
			$display("int_n not removed after both chips removed ints!");
			$stop;
		end
		// disable ints
		z.iord(rstint_port,tmp);
		z.iowr(rstint_port,{tmp[7],1'b0,tmp[5:4],2'b00,tmp[1:0]});
	endtask

	
	
	task test_resets;

		reg[7:0] tmp;

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

		// remove resets. first sl811
		z.iowr(rstint_port, {tmp[7:6],2'b10,tmp[3:0]} );
		if( s.get_rst_n() !== 1'b1 )
		begin
			$display("sl811 hasn't rst_n=1 after port clear!");
			$stop;
		end
		// then w5300 
		z.iowr(rstint_port, {tmp[7:6],2'b11,tmp[3:0]} );
		if( w.get_rst_n() !== 1'b1 )
		begin
			$display("w5300 hasn't rst_n=1 port clear!");
			$stop;
		end

	endtask
	




endmodule

