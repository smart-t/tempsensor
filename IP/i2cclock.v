// Create approximate 100Khz clock used for I2C
//
// This module will take a reference clock and devides it's cycles by a
// given divisor. The clock is only active when te CS line is high. When
// inactive the i2cclock remains high.

module i2cclock (
		in_clock,
		divisor,
		cs,
		i2cclk
);


// arguments
		input 			in_clock;
		input [9:0]		divisor;
		input				cs;
		output			i2cclk;


//=======================================================
//  REG/WIRE declarations
//=======================================================
reg	[10:0]	COUNT = 11'd0;		// To count until divisor is reached
reg				CLK = 1'b0;			// Our delayed clock

//=======================================================
//  Structural coding
//=======================================================
		
always @(posedge in_clock)
begin
	if (cs == 1)
	begin
		COUNT <= COUNT + 1;
		if (COUNT > divisor)
		begin
			COUNT <= 0;
			CLK <= !CLK;
		end
	end
end

assign i2cclk = CLK;

endmodule