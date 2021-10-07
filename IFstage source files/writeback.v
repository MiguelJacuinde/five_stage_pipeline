
module writeback(
	input	wire 		MEM_WB_memtoreg,
	input	wire [31:0]	read_data, mem_alu_result,
	output 	wire [31:0] 	WB_mux_writedata
   	);
	
	mux mux3(
		.y(WB_mux_writedata),
		.sel(MEM_WB_memtoreg),
		.a(read_data),
		.b(mem_alu_result)						
	);

endmodule