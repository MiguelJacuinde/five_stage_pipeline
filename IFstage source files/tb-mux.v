module test_mux;
//wire ports
wire [31:0] Y;

//regs
reg [31:0] A, B;
reg	   sel;

//Instantiate
mux mux1 (Y, A, B, sel);

	initial begin
	A = 32'hAAAAAAAA;
	B = 32'h55555555;
	sel = 1'b1;
	#10
	A = 32'h00000000;
	#10
	sel = 1'b1;
	#10
	B = 32'hFFFFFFFF;
	#5
	A = 32'hA5A5A5A5;
	#5
	sel = 1'b0;
	B = 32'hDDDDDDDD;
	#5
	sel = 1'bx;
	end

always @ (A or B or sel)
	#1 $display ("At t = %0d sel = %b A = %h B = %h Y = %h",
			$time, sel, A, B, Y);

endmodule	//test_mux
