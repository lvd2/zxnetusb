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
	input  wire        zrfsh_n,
	output wire        ziorqge,
	output wire        zblkrom,
	input  wire        zcsrom_n,
	input  wire        zrst_n,
	output wire        zint_n,


	// w5300 Ethernet chip
	output wire        w5300_rst_n,
	output wire [ 9:0] w5300_addr,
	output wire        w5300_cs_n,
	input  wire        w5300_int_n,
	input  wire [ 3:0] w5300_brdy,


	// sl811 Usb chip
	output wire        sl811_rst_n,
	input  wire        sl811_intrq,
	output wire        sl811_ms,
	output wire        sl811_cs_n,
	output wire        sl811_a0

	// usb power presence
	input  wire        usb_power

	// = total 56 pins (maximum is 66)
	//   among them 27 outputs (maximum is 64)
);


	wire ena_w5300_int;
	wire ena_sl811_int;
	wire ena_zxbus_int;
	wire internal_int;

	wire [7:0] ports_wrdata;
	wire [7:0] ports_rddata;
	wire [1:0] ports_addr;
	wire       ports_wrena;
	wire       ports_wrstb_n;

	wire [1:0] rommap_win;
	wire       rommap_ena;

	wire       w5300_a0inv;


	// zx-bus
	zbus zbus
	(
		.za(za),
		.zd(zd),
		//
		.ziorq_n (ziorq_n ),
		.zrd_n   (zrd_n   ),
		.zwr_n   (zwr_n   ),
		.zmreq_n (zmreq_n ),
		.zrfsh_n (zrfsh_n ),
		.ziorqge (ziorqge ),
		.zblkrom (zblkrom ),
		.zcsrom_n(zcsrom_n),
		.zrst_n  (zrst_n  ),
		//
		.ports_wrena  (ports_wrena  ),
		.ports_wrstb_n(ports_wrstb_n),
		.ports_addr   (ports_addr   ),
		.ports_wrdata (ports_wrdata ),
		.ports_rddata (ports_rddata ),
		//
		.rommap_win(rommap_win),
		.rommap_ena(rommap_ena),
		//
		.sl811_cs_n(sl811_cs_n),
		.sl811_a0  (sl811_a0  ),
		//
		.w5300_cs_n(w5300_cs_n)
	);


	// map Z80 space to wiznet space
	wizmap wizmap
	(
		.za(za),

		.w5300_a0inv(w5300_a0inv),
		.w5300_addr (w5300_addr )
	);


	// ports
	ports ports
	(
		.rst_n(zrst_n),
		//
		.wrstb_n(ports_wrstb_n),
		.wrena  (ports_wrena  ),
		.addr   (ports_addr   ),
		.wrdata (ports_wrdata ),
		.rddata (ports_rddata ),
		//
		.ena_w5300_int(ena_w5300_int),
		.ena_sl811_int(ena_sl811_int),
		.ena_zxbus_int(ena_zxbus_int),
		//
		.w5300_int_n(w5300_int_n),
		.sl811_intrq(sl811_intrq),
		//
		.internal_int(internal_int),
		//
		.rommap_win(rommap_win),
		.rommap_ena(rommap_ena),
		//
		.w5300_a0inv(w5300_a0inv),
		.w5300_rst_n(w5300_rst_n),
		.w5300_brdy (w5300_brdy ),
		//
		.sl811_ms   (sl811_ms   ),
		.sl811_rst_n(sl811_rst_n),
		//
		.usb_power(usb_power)
	);





	// interrupt generation
	assign internal_int = (ena_w5300_int & (~w5300_int_n)) |
	                      (ena_sl811_int &   sl811_intrq ) ;
	//
	assign zint_n = (internal_int & ena_zxbus_int) ? 1'b0 : 1'bZ;


endmodule

