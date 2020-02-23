// initially part of ZXiznet project (c) NedoPC 2012
//
// Simple Simulator of Z80
//  performs only some Z80 cycles as tasks, no /WAIT etc.


// reference Z80 cycles:
//
//
// M1 opcode read:
//       |-------------------------------|
// clk: _/```\___/```\___/```\___/```\___/`
// mreq  `````\___________/```````````````
// rd    `````\___________/```````````````

// mem read/write:
//       |-----------------------|
// clk: _/```\___/```\___/```\___/`
// mreq  `````\_______________/```
// rd    `````\_______________/```
// wr    `````````````\_______/```

// IO read/write:
//       |-------------------------------|
// clk: _/```\___/```\___/```\___/```\___/`
// iorq  `````````\___________________/```
// rd/wr `````````\___________________/```


`timescale 1ns/100ps

module ssz80
(
	input  wire       clk,
	input  wire       rst_n,

	output reg        mreq_n,
	output reg        iorq_n,
	output reg        wr_n,
	output reg        rd_n,

	output reg  [15:0] a,

	inout  wire [ 7:0] d
);


	reg [7:0] dout;
	reg       oena;


	assign d = oena ? dout : 8'bZZZZ_ZZZZ;




	initial
	begin
		a='d0;

		dout = 'd0;
		oena = 1'b0;

		mreq_n = 1'bZ;
		iorq_n = 1'bZ;
		rd_n   = 1'bZ;
		wr_n   = 1'bZ;
	end




	task fetch;
		input  [15:0] addr;
		output [ 7:0] data;

		begin
			@(posedge clk);
			mreq_n <= 1'b1;
			iorq_n <= 1'b1;
			rd_n   <= 1'b1;
			wr_n   <= 1'b1;
			oena <= 1'b0;
			a <= addr;

			@(negedge clk);

			mreq_n <= 1'b0;
			rd_n   <= 1'b0;

			@(posedge clk);
			@(posedge clk);

			data = d;
			mreq_n <= 1'b1;
			rd_n   <= 1'b1;

			@(negedge clk);
			@(negedge clk);
		end

	endtask





	task memrd;

		input  [15:0] addr;
		output [ 7:0] data;

		begin
			@(posedge clk);
			mreq_n <= 1'b1;
			iorq_n <= 1'b1;
			rd_n   <= 1'b1;
			wr_n   <= 1'b1;
			oena <= 1'b0;
			a <= addr;

			@(negedge clk);

			mreq_n <= 1'b0;
			rd_n   <= 1'b0;

			@(negedge clk);
			@(negedge clk);

			data = d;
			mreq_n <= 1'b1;
			rd_n   <= 1'b1;

		end
	endtask


	task memwr;

		input  [15:0] addr;
		input  [ 7:0] data;

		begin
			@(posedge clk);

			mreq_n <= 1'b1;
			iorq_n <= 1'b1;
			rd_n   <= 1'b1;
			wr_n   <= 1'b1;
			a <= addr;
			dout <= data;
			oena <= 1'b1;

			@(negedge clk);

			mreq_n <= 1'b0;
			@(negedge clk);
			wr_n   <= 1'b0;
			@(negedge clk);

			mreq_n <= 1'b1;
			wr_n   <= 1'b1;
			wait(wr_n==1'b1); // delta-cycle delay!!!

			//@(posedge clk);
			oena <= 1'b0;
		end
	endtask


	task iord_;

		input [15:0] addr;

		output [7:0] data;

		begin

			@(posedge clk);

			mreq_n <= 1'b1;
			iorq_n <= 1'b1;
			rd_n   <= 1'b1;
			wr_n   <= 1'b1;

			oena <= 1'b0;
			a <= addr;

			@(posedge clk);

			iorq_n <= 1'b0;
			rd_n   <= 1'b0;

			@(negedge clk);
			@(negedge clk);
			@(negedge clk);

			data = d;

			iorq_n <= 1'b1;
			rd_n   <= 1'b1;

		end

	endtask


	task iowr_;

		input [15:0] addr;
		input [ 7:0] data;

		begin

			@(posedge clk);

			mreq_n <= 1'b1;
			iorq_n <= 1'b1;
			rd_n   <= 1'b1;
			wr_n   <= 1'b1;

			a <= addr;
			dout <= data;
			oena <= 1'b1;

			@(posedge clk);

			iorq_n <= 1'b0;
			wr_n   <= 1'b0;

			@(negedge clk);
			@(negedge clk);
			@(negedge clk);

			iorq_n <= 1'b1;
			wr_n   <= 1'b1;

			wait(wr_n==1'b1); // delta-cycle delay!!!
			#(1.0);
			//@(posedge clk);
			//oena <= 1'b0;
		end

	endtask




	task iowr;

		input [15:0] addr;
		input [ 7:0] data;

		begin
			random_mem();
			iowr_(addr,data);
			random_mem();
		end

	endtask

	
	task iord;

		input  [15:0] addr;
		output [ 7:0] data;

		begin
			random_mem();
			iord_(addr,data);
			random_mem();
		end

	endtask




	task random_mem;

		reg [15:0] addr;
		reg [ 7:0] data;

		integer m;

		begin
			addr = $random()>>16;
			data = $random()>>24;

			case( $random()%3 )
			0: memrd(addr,data);
			1: memwr(addr,data);
			2: fetch(addr,data);
			endcase
		end

	endtask



endmodule

