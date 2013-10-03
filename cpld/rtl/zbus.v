// ZXiznet project
// (c) NedoPC 2012
//
// zx-bus functions: ports mapping/access, ROM mapping

module zbus
(
	input  wire [15:0] za,
	inout  wire [ 7:0] zd,
	//
	inout  wire [ 7:0] bd,
	//
	input  wire        ziorq_n,
	input  wire        zrd_n,
	input  wire        zwr_n,
	input  wire        zmreq_n,
	output wire        ziorqge,
	output wire        zblkrom,
	input  wire        zcsrom_n,
	input  wire        zrst_n,

	//
	output wire        ports_wrena,
	output wire        ports_wrstb_n,
	output wire [ 1:0] ports_addr,
	output wire [ 7:0] ports_wrdata,
	input  wire [ 7:0] ports_rddata,
	
	//
	input  wire [ 1:0] rommap_win,
	input  wire        rommap_ena,

	//
	output wire        sl811_cs_n,
	output wire        sl811_a0,

	//
	output wire        w5300_cs_n,
	input  wire        w5300_ports
);
	parameter BASE_ADDR = 8'hAB;



	wire io_addr_ok;

	wire mrd, mwr;

	wire ena_dbuf;
	wire ena_din;
	wire ena_dout;


	// addr decode
	assign io_addr_ok = (za[7:0]==BASE_ADDR);


	// IORQGE
	assign ziorqge = io_addr_ok ? 1'b1 : 1'bZ;



	// ports write
	assign ports_addr = za[9:8];
	//
	assign ports_wrdata = zd;
	//
	assign ports_wrena   = io_addr_ok && za[15];
	assign ports_wrstb_n = ziorq_n | zwr_n;



	// sl811 chip select and A0
	assign sl811_cs_n = !( !w5300_ports && io_addr_ok && ( !za[15] || (za[15] && za[9:8]==2'b00) ) && !ziorq_n );
	//
	assign sl811_a0 = ~za[15];


	// w5300 chip select
	assign mwr = !zmreq_n && !zwr_n && (za[15:14]==rommap_win) && rommap_ena;
	assign mrd = !zmreq_n && !zrd_n && !zcsrom_n && (za[15:14]==rommap_win) && rommap_ena;
	//
	assign w5300_cs_n = ~(mwr || mrd || ( w5300_ports && io_addr_ok && !za[15] && !ziorq_n ) );

	// block ROM
	assign zblkrom = (rommap_ena && (za[15:14]==rommap_win)) ? 1'b1 : 1'bZ;



	assign ena_dbuf = (~sl811_cs_n) | (~w5300_cs_n);
	assign ena_din  = ~zwr_n;
	assign ena_dout = ~zrd_n;


	// ports data read/buffering
	assign zd = (io_addr_ok && !ziorq_n && !zrd_n && za[15] && (za[9:8]!=2'b00)) ?
	            ports_rddata : ( (ena_dbuf && ena_dout) ? bd : 8'bZZZZ_ZZZZ );


	assign bd = (ena_dbuf && ena_din) ? zd : 8'bZZZZ_ZZZZ;

endmodule

