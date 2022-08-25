`timescale 100 ms / 10 ms

module CU
(
    input  wire          CLK,
    input  wire [47:0]   INSTRUCTION,
    output wire [127:0]  REGISTER_OUTPUT_DATA_BUS
);

    integer addressing_mode, oprand_value, output_register_index;
    reg  [8:0]  opcodes;
    reg  [31:0] oprands;
    reg  [15:0] registers [7:0];
    wire [15:0] out;

    assign REGISTER_OUTPUT_DATA_BUS[15:0]    = registers[0];
    assign REGISTER_OUTPUT_DATA_BUS[31:16]   = registers[1];
    assign REGISTER_OUTPUT_DATA_BUS[47:32]   = registers[2];
    assign REGISTER_OUTPUT_DATA_BUS[63:48]   = registers[3];
    assign REGISTER_OUTPUT_DATA_BUS[79:64]   = registers[4];
    assign REGISTER_OUTPUT_DATA_BUS[95:80]   = registers[5];
    assign REGISTER_OUTPUT_DATA_BUS[111:96]  = registers[6];
    assign REGISTER_OUTPUT_DATA_BUS[127:112] = registers[7];

    ALU ALU (.CLK(CLK), .OPCODES(opcodes), .OPRANDS(oprands), .OUT(out));

    initial 
    begin
        registers[0] = 32'h0000;
        registers[1] = 32'h0000;
        registers[2] = 32'h0000;
        registers[3] = 32'h0000;
        registers[4] = 32'h0000;
        registers[5] = 32'h0000;
        registers[6] = 32'h0000;
        registers[7] = 32'h0000;
    end

    always @(posedge CLK)
    begin
        #1;

        opcodes = INSTRUCTION[47:39];

        // Fist extera point part
        // first oprand
        addressing_mode = INSTRUCTION[38];
        oprand_value = INSTRUCTION[37:30];
        if (1'b0 === addressing_mode)
            oprands[31:24] = oprand_value;
        else
            oprands[31:24] = registers[oprand_value];

        // second oprand
        addressing_mode = INSTRUCTION[29];
        oprand_value = INSTRUCTION[28:21];
        if (1'b0 === addressing_mode)
            oprands[23:16] = oprand_value;
        else
            oprands[23:16] = registers[oprand_value];
        
        // third oprand
        addressing_mode = INSTRUCTION[20];
        oprand_value = INSTRUCTION[19:12];
        if (1'b0 === addressing_mode)
            oprands[15:8] = oprand_value;
        else
            oprands[15:8] = registers[oprand_value];

        // last oprand 
        addressing_mode = INSTRUCTION[11];
        oprand_value = INSTRUCTION[10:3];
        if (1'b0 === addressing_mode)
            oprands[7:0] = oprand_value;
        else
            oprands[7:0] = registers[oprand_value];



        $display("");
        $display("CU:     CLK = %b", CLK);
        $display("CU:     INSTRUCTION[47:39] = %b, Opcode = %b ", INSTRUCTION[47:39], opcodes);
        $display("CU:     INSTRUCTION[38:30] = %b, addressing mode = %b, oprand value = %b (%d) oprand[0] = %b (%d)", INSTRUCTION[38:30], addressing_mode, oprand_value, oprand_value, oprands[0], oprands[0]);
        $display("CU:     INSTRUCTION[29:21] = %b, addressing mode = %b, oprand value = %b (%d) oprand[1] = %b (%d)", INSTRUCTION[29:21], addressing_mode, oprand_value, oprand_value, oprands[1], oprands[1]);
        $display("CU:     INSTRUCTION[20:12] = %b, addressing mode = %b, oprand value = %b (%d) oprand[2] = %b (%d)", INSTRUCTION[20:12], addressing_mode, oprand_value, oprand_value, oprands[2], oprands[2]);
        $display("CU:     INSTRUCTION[11:3]  = %b, addressing mode = %b, oprand value = %b (%d) oprand[3] = %b (%d)", INSTRUCTION[11:3], addressing_mode, oprand_value, oprand_value, oprands[3], oprands[3]);
        $display("CU:     registers[0] = %b (%d)", registers[0], registers[0]);
        $display("CU:     registers[1] = %b (%d)", registers[1], registers[1]);
        $display("CU:     registers[2] = %b (%d)", registers[2], registers[2]);
        $display("CU:     registers[3] = %b (%d)", registers[3], registers[3]);
        $display("CU:     registers[4] = %b (%d)", registers[4], registers[4]);
        $display("CU:     registers[5] = %b (%d)", registers[5], registers[5]);
        $display("CU:     registers[6] = %b (%d)", registers[6], registers[6]);
        $display("CU:     registers[7] = %b (%d)", registers[7], registers[7]);

        #3;
        output_register_index = INSTRUCTION[2:0];
        registers[output_register_index] = out;

        
        $display("CU:     INSTRUCTION[2:0] = %b, output_register_index = %d", INSTRUCTION[2:0], output_register_index);
        $display("CU:     out       = %b, register[%d] = %b (%d)", out, output_register_index, registers[output_register_index], registers[output_register_index]);
        #1;
        $display("CU:     REGISTER_OUTPUT_DATA_BUS = %h", REGISTER_OUTPUT_DATA_BUS);
        $display("");

    end

endmodule