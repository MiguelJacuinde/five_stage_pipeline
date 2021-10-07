module pipeline ();

//IF stage

 //inputs
  wire EX_MEM_PCSrc;
  wire [31:0] EX_MEM_NPC;
 //output
  wire [31:0] IF_ID_instr, IF_ID_npc;

  ifetch ifetch1(
                  //inputs
		   .EX_MEM_PCSrc(EX_MEM_PCSrc),
		   .EX_MEM_NPC(EX_MEM_NPC),
		 //outputs
		   .IF_ID_instr(IF_ID_instr),
                   .IF_ID_npc(IF_ID_npc) );
//ID stage

 //inputs
  wire [4:0] MEM_WB_rd;
  wire MEM_WB_regwrite;
  wire [31:0] WB_mux5_writedata;
 //outputs
  wire [31:0] npcout, rdata1out, rdata2out, s_extendout;
  wire 	     regdst, alusrc;  
  wire [1:0] wb_ctlout, aluop; 
  wire [2:0] m_ctlout;
  wire [4:0] instrout_2016, instrout_1511;
   
  IDECODE idecode2(
		   //inputs
                    .MEM_WB_rd(MEM_WB_rd),
                    .MEM_WB_regwrite(MEM_WB_regwrite),
                    .WB_mux5_writedata(WB_mux5_writedata),
		   //outputs
	            .IF_ID_instrout(IF_ID_instr),
		    .IF_ID_npcout(IF_ID_npc),
		    .wb_ctlout(wb_ctlout),
		    .m_ctlout(m_ctlout),
		    .regdst(regdst),
		    .alusrc(alusrc),
		    .aluop(aluop), 
		    .npcout(npcout),
		    .rdata1out(rdata1out),
		    .rdata2out(rdata2out),
		    .s_extendout(s_extendout),
		    .instrout_2016(instrout_2016),
		    .instrout_1511(instrout_1511) );

//EX stage
 
 //outputs
  wire branch, memread, memwrite;
  wire zero;
  wire [1:0] wb_ctlout_ex;
  wire [31:0] alu_result, rdata2out_ex;
  wire [4:0] five_bit_muxout;
  wire [31:0] add_result;

  iexecute iexecute3(
		       //inputs
			.wb_ctl(wb_ctlout),
			.m_ctl(m_ctlout),
			.regdst(regdst),
			.alusrc(alusrc),
			.aluop(aluop),
			.npcout(npcout),
			.rdata1(rdata1out),
			.rdata2(rdata2out),
			.s_extendout(s_extendout),
			.instrout_1511(instrout_1511),
			.instrout_2016(instrout_2016),
		      //outputs
			.wb_ctlout(wb_ctlout_ex),
			.branch(branch),
			.zero(zero),
			.rdata2out(rdata2out_ex),
			.memwrite(memwrite),
			.memread(memread),
			.alu_result(alu_result),
			.five_bit_muxout(five_bit_muxout) );

//MEM stage
  wire MEM_WB_memtoreg;
  wire [31:0] read_data, mem_alu_result;

  MEMORY memory4(
		    //inputs
			.wb_ctlout(wb_ctlout_ex),
			.branch(branch),
			.memread(memread),
			.memwrite(memwrite),
			.zero(zero),
			.alu_result(alu_result),
			.rdata2out(rdata2out_ex),
			.five_bit_muxout(five_bit_muxout),
		    //outputs
			.MEM_PCSrc(EX_MEM_PCSrc),
			.MEM_WB_regwrite(MEM_WB_regwrite),
			.MEM_WB_memtoreg(MEM_WB_memtoreg),
			.read_data(read_data),
			.mem_alu_result(mem_alu_result),
			.mem_write_reg(MEM_WB_rd) );

//WB stage  
  wire [31:0] WB_mux5_writedata;

  writeback writeback5(
	      	       //inputs
			.read_data(read_data),
			.mem_alu_result(mem_alu_result),
		       //outputs
			.WB_mux_writedata(WB_mux_writedata) );

/* NO LONGER NEED TO BE INITIALIZED
   initial begin
   EX_MEM_PCSrc <= 1'b0;
   EX_MEM_NPC <= 32'b0;
   MEM_WB_rd <= 5'bz;
   MEM_WB_regwrite <= 1'bz;
   WB_mux5_writedata <= 32'bz;
   end
*/
	
   // This for Icarus ( iverilog)
   initial begin
    $dumpfile ("pipeline.vcd"); // Change filename as appropriate. 
    $dumpvars(5, ifetch1, idecode2, iexecute3, memory4, writeback5);
     
   end

endmodule // pipeline
