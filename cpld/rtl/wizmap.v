// ZXiznet project
// (c) NedoPC 2012
//
// mapping of wiznet address space

module wizmap
(
	//
	input  wire [15:0] za,

	//
	input  wire        w5300_a0inv,

	//
	output reg  [ 9:0] w5300_addr
);


	always @* w5300_addr[0] = w5300_a0inv ^ za[0];



	always @*
	if( za[13]==1'b0 )
	begin
		w5300_addr[9:1] = za[9:1];
	end
	else // if( za[13]==1'b1 )
	begin
		w5300_addr[9]   = 1'b1;
		w5300_addr[8:6] = za[11:9];

		if( za[12]==1'b0 )
			w5300_addr[5:1] = 5'b10111;
		else // if( za[12]==1'b1 )
			w5300_addr[5:1] = 5'b11000;
	end

endmodule

