`timescale 1ns / 1ps
/* and.v */
module AND(
	input	wire	membranch, zero,
	output	wire	PCSrc
    );

	assign PCSrc = membranch && zero; //finish this line

endmodule
