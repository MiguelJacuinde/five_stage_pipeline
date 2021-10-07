module test_incr;
//port wires
wire [31:0] IncrOut;

//regs
reg [31:0] A;

//Instantiate
incrementer incr1 (A, IncrOut);

	initial begin
	#10
	A = 3;
	#10
	A = 15;
	#10
	A = 64;
	#5;
	end

always @ (A)
	#1 $display ("Time = %0d\tA=%0d\tIncrOut=%0d",
			$time, A, IncrOut);

endmodule	// test_incr
