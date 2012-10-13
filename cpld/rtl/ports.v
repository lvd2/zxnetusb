// ZXiznet project
// (c) NedoPC 2012
//
// ports of card: #83AB, #82AB, #81AB (read/write),
// correspond to addr=2'b11, 2'b10, 2'b01

module ports
(
	input  wire       rst_n,

	input  wire       wrstb_n, // write strobe for ports, latched at positive edge
	input  wire       wrena,   // write enable for ports
	//
	input  wire [1:0] addr, // addressing: no port at 2'b00
	//
	input  wire [7:0] wrdata,
	output reg  [7:0] rddata,


	// inputs and outputs
	output reg        ena_w5300_int,
	output reg        ena_sl811_int,
	output reg        ena_zxbus_int,
	input  wire       w5300_int_n,
	input  wire       sl811_intrq,
	input  wire       internal_int,
	//
	output reg  [1:0] rommap_win,
	output reg        rommap_ena,
	output reg        w5300_a0inv,
	output reg        w5300_rst_n,
	//
	output reg        sl811_ms,
	output reg        sl811_rst_n
);




	// wr #83AB
	always @(posedge wrstb_n, negedge rst_n)
	if( !rst_n )
	begin
		ena_w5300_int <= 1'b0;
		ena_sl811_int <= 1'b0;
		ena_zxbus_int <= 1'b0;
	end
	else if( wrena && addr==2'b11 )
	begin
		ena_w5300_int <= wrdata[2];
		ena_sl811_int <= wrdata[3];
		ena_zxbus_int <= wrdata[7];
	end
	

	// wr #82AB
	always @(posedge wrstb_n, negedge rst_n)
	if( !rst_n )
	begin
		rommap_win <= 2'b00;
		rommap_ena <= 1'b0;
		
		w5300_a0inv <= 1'b0;
		w5300_rst_n <= 1'b0;
	end
	else if( wrena && addr==2'b10 )
	begin
		rommap_win <= wrdata[1:0];
		rommap_ena <= wrdata[2];
		
		w5300_a0inv <= wrdata[3];
		w5300_rst_n <= wrdata[7];
	end


	// wr #81AB
	always @(posedge wrstb_n, negedge rst_n)
	if( !rst_n )
	begin
		sl811_ms    <= 1'b0;
		sl811_rst_n <= 1'b0;
	end
	else if( wrena && addr==2'b01 )
	begin
		sl811_ms    <= wrdata[0];
		sl811_rst_n <= wrdata[7];
	end



	// read ports
	always @*
	case(addr)

		2'b11: rddata = { internal_int, ena_zxbus_int, 2'bXX, ena_sl811_int, ena_w5300_int, sl811_intrq, ~w5300_int_n };

		2'b10: rddata = { w5300_rst_n, 3'bXXX, w5300_a0inv, rommap_ena, rommap_win };

		2'b01: rddata = { sl811_rst_n, 6'bXXXXXX, sl811_ms };

		default: rddata = 8'bXXXX_XXXX;

	endcase




endmodule
