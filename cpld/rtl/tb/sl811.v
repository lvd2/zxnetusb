// ZXiznet project
// (c) NedoPC 2012
//
// test module for sl811
// tests whether transactions going for it are correct

module sl811
(
	input  wire       rst_n,
	input  wire       a0,
	input  wire       cs_n,
	input  wire       rd_n,
	input  wire       wr_n,
	input  wire       ms,
	output reg        intrq,
	inout  wire [7:0] d
);

	
	reg       access_addr;
	reg       access_rnw;
	
	wire rd = ~(cs_n|rd_n);
	wire wr = ~(cs_n|wr_n);


	initial
	begin
		intrq = 1'b0;
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





	task set_intrq
	(
		input new_intrq
	);
		intrq = new_intrq;

	endtask


	function get_rst_n;
	
		get_rst_n = rst_n;

	endfunction


	function get_ms;

		get_ms = ms;
	
	endfunction



endmodule

