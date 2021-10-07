/* execute.v */
module iexecute(
	input		wire	[1:0]	wb_ctl,
	input		wire	[2:0]	m_ctl,
	input		wire		regdst, alusrc,
	input		wire	[1:0]	aluop, 
	input		wire	[31:0]	npcout, rdata1, rdata2, s_extendout,
	input		wire	[4:0]	instrout_2016, instrout_1511,
	output	wire	[1:0]	wb_ctlout,
	output	wire		branch, memread, memwrite,
	output	wire	[31:0]	EX_MEM_NPC,
	output	wire		zero,
	output	wire	[31:0]	alu_result, rdata2out, add_result,
	output	wire	[4:0]	five_bit_muxout
	);

	// signals
	wire	[31:0]	adder_out, b, aluout;
	wire	[4:0]	muxout;
	wire	[2:0]	control;
	wire		aluzero;
	
	// instantiations
	
	adder adder3	(.add_in1(npcout),
			 .add_in2(s_extendout),
			 .add_out(adder_out) );

	alu alu3	(.a(rdata1),
			 .b(b),
			 .control(control),
			 .result(aluout),
			 .zero(aluzero) );

	alu_control alu_control3	(.funct(s_extendout[5:0]),
					 .aluop(aluop),
					 .select(control) );

	ex_mem ex_mem3	(.ctlwb_out(wb_ctl),
			 .ctlm_out(m_ctl),
			 .adder_out(EX_MEM_NPC),
			 .aluzero(aluzero),
			 .aluout(aluout),
			 .readdat2(rdata2),
			 .muxout(muxout),
			 .wb_ctlout(wb_ctlout),
			 .branch(branch),
			 .memread(memread),
			 .memwrite(memwrite),
			 .add_result(add_result),
			 .zero(zero),
			 .alu_result(alu_result),
			 .rdata2out(rdata2out),
			 .five_bit_muxout(five_bit_muxout) );

	five_bit_mux five_bit_mux3	(.y(muxout),
					 .a(instrout_2016), 
					 .b(instrout_1511),
					 .sel(regdst) );

	mux mux3	(.y(b),
                         .a(s_extendout),              
                         .b(rdata2),
                         .sel(alusrc) );
		
        //for testing
        initial begin
        $display("Time\t  WB\t  M\t  NPCout\t EX_MEM_NPC\t  ALURes\t  Rdata2\t  AddRes\t 5bitmux");
        $monitor("%0d\t   %0d\t  %0d\t    %0d\t          %0d\t           %0d\t              %0d\t         %0d\t         %0d",
                        $time, wb_ctl, m_ctl, npcout, EX_MEM_NPC, alu_result, rdata2out, add_result, five_bit_muxout);
        #20 $finish;
        end

endmodule // iexecute
