// ZXiznet project
// (c) NedoPC 2012
//
// top-level module

module top
(
	// zxbus
	input  wire [15:0] za,
	inout  wire [ 7:0] zd,
	//
	input  wire        ziorq_n,
	input  wire        zrd_n,
	input  wire        zwr_n,
	input  wire        zmreq_n,
	output wire        ziorqge,
	output wire        zblkrom
	input  wire        zcsrom_n
	input  wire        zrst_n,
	output wire        zint_n,


	// w5300 Ethernet chip
	output reg         erst_n,
	output wire [ 9:0] ea,
	output wire        ecs_n,
	input  wire        eint_n,


	// sl811 Usb chip
	output reg         urst_n,
	input  wire        uint,
	output reg         ums,
	output wire        ucs_n

	// = total 50 pins (maximum is 66)
	//   among them 26 outputs (maximum is 64)
);





endmodule

