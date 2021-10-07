module memory (
   output reg [31:0] data,    // Output of Instruction Memory
   input wire [31:0] addr     // Input of Instruction Memory
   );

// Register Declarations
   reg [31:0] MEM[0:127];  // 128 words of 32-bit memory

// Initialize Registers
   initial begin
   MEM[0] <= 32'h002300AA;
   MEM[1] <= 32'h10654321;
   MEM[2] <= 32'h00100022;
   MEM[3] <= 32'h8C123456;
   MEM[4] <= 32'h8F123456;
   MEM[5] <= 32'hAD654321;
   MEM[6] <= 32'h13012345;
   MEM[7] <= 32'hAC654321;
   MEM[8] <= 32'h12012345;
   MEM[9] <= 32'hxxxxxxxx;
   end

   always @ (addr) data <= MEM[addr];
endmodule // mem
