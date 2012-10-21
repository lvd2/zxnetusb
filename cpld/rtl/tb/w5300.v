// ZXiznet project
// (c) NedoPC 2012
//
// test module for w5300
// tests whether transactions going for it are correct

module w5300
(
	input  wire       rst_n,
	input  wire [9:0] addr,
	input  wire       cs_n,
	input  wire       rd_n,
	input  wire       wr_n,
	output reg        int_n
);

	
	reg [9:0] access_addr;
	reg       access_rnw;
	
	wire rd = ~(cs_n|rd_n);
	wire wr = ~(cs_n|wr_n);


	initial
	begin
		int_n = 1'b1;
	end



	always @(negedge rd)
	begin
		access_addr = addr;
		access_rnw  = 1'b1;
	end

	always @(negedge wr)
	begin
		access_addr = addr;
		access_rnw  = 1'b0;
	end





	task set_int_n
	(
		input new_int_n
	);
		int_n = new_int_n;

	endtask



	function get_rst_n;
	
		get_rst_n = rst_n;

	endfunction




endmodule

