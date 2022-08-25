`timescale 100 ms / 10 ms

module FU
(
    input  wire          CLK,
    input  wire          RESET,
    input  wire [4:0]    PROGRAM_LINES_COUNT,
    input  wire [767:0]  PROGRAM_LINES,
    output wire [127:0]  REGISTER_OUTPUT_DATA_BUS
);
    integer i;
    reg   [4:0]   program_counter;
    reg   [47:0]  instructions [15:0];
    reg   [47:0]  instruction;
    wire  [127:0] register_data_bus;

    assign REGISTER_OUTPUT_DATA_BUS = register_data_bus;

    CU CU (.CLK(CLK), .INSTRUCTION(instruction), .REGISTER_OUTPUT_DATA_BUS(register_data_bus));

    initial 
    begin
        program_counter = 0;

        instructions[0] = 48'h0000_0000_0000;
        instructions[1] = 48'h0000_0000_0000;
        instructions[2] = 48'h0000_0000_0000;
        instructions[3] = 48'h0000_0000_0000;
        instructions[4] = 48'h0000_0000_0000;
        instructions[5] = 48'h0000_0000_0000;
        instructions[6] = 48'h0000_0000_0000;
        instructions[7] = 48'h0000_0000_0000;

        instructions[8] = 48'h0000_0000_0000;
        instructions[9] = 48'h0000_0000_0000;
        instructions[10] = 48'h0000_0000_0000;
        instructions[11] = 48'h0000_0000_0000;
        instructions[12] = 48'h0000_0000_0000;
        instructions[13] = 48'h0000_0000_0000;
        instructions[14] = 48'h0000_0000_0000;
        instructions[15] = 48'h0000_0000_0000;
        
    end


    always @(posedge RESET, posedge CLK)
    begin
        if (1'b1 === RESET)
        begin 
            program_counter = 0;

            instructions[0] = PROGRAM_LINES[47:0];
            instructions[1] = PROGRAM_LINES[95:48];
            instructions[2] = PROGRAM_LINES[143:96];
            instructions[3] = PROGRAM_LINES[191:144];
            instructions[4] = PROGRAM_LINES[239:192];
            instructions[5] = PROGRAM_LINES[287:240];
            instructions[6] = PROGRAM_LINES[335:288];
            instructions[7] = PROGRAM_LINES[383:336];

            instructions[8] = PROGRAM_LINES[431:384];
            instructions[9] = PROGRAM_LINES[479:432];
            instructions[10] = PROGRAM_LINES[527:480];
            instructions[11] = PROGRAM_LINES[575:528];
            instructions[12] = PROGRAM_LINES[623:576];
            instructions[13] = PROGRAM_LINES[671:624];
            instructions[14] = PROGRAM_LINES[719:672];
            instructions[15] = PROGRAM_LINES[767:720];

            $display("");
            $display("=================================================================================================================================");
            $display("");
            $display("FU:     --- RESET ---");
            $display("FU:     PROGRAM_LINES = %b", PROGRAM_LINES);
            $display("FU:     instructions[0] = %b", instructions[0]);
            $display("FU:     instructions[1] = %b", instructions[1]);
            $display("FU:     instructions[2] = %b", instructions[2]);
            $display("FU:     instructions[3] = %b", instructions[3]);
            $display("FU:     instructions[4] = %b", instructions[4]);
            $display("FU:     instructions[5] = %b", instructions[5]);
            $display("FU:     instructions[6] = %b", instructions[6]);
            $display("FU:     instructions[7] = %b", instructions[7]);
            $display("FU:     instructions[8] = %b", instructions[7]);
            $display("FU:     instructions[9] = %b", instructions[7]);
            $display("FU:     instructions[10] = %b", instructions[7]);
            $display("FU:     instructions[11] = %b", instructions[7]);
            $display("FU:     instructions[12] = %b", instructions[7]);
            $display("FU:     instructions[13] = %b", instructions[7]);
            $display("FU:     instructions[14] = %b", instructions[7]);
            $display("FU:     instructions[15] = %b", instructions[7]);
        end

        else if (program_counter < PROGRAM_LINES)
        begin
            instruction = instructions[program_counter];
            program_counter = program_counter + 1;

            $display("");
            $display("=================================================================================================================================");
            $display("");
            $display("FU:     --- new instruction ---");
            $display("FU:     CLK = %b", CLK);
            $display("FU:     program_counter = %b (%d)", program_counter, program_counter);
            $display("FU:     instruction = %b", instruction);

            #7;
            $display("FU:     registers_data_bus = %b", register_data_bus);
            $display("FU:     register[0] = %b (%d)", register_data_bus[15:0], register_data_bus[15:0]);
            $display("FU:     register[1] = %b (%d)", register_data_bus[31:16], register_data_bus[31:16]);
            $display("FU:     register[2] = %b (%d)", register_data_bus[47:32], register_data_bus[47:32]);
            $display("FU:     register[3] = %b (%d)", register_data_bus[63:48], register_data_bus[63:48]);
            $display("FU:     register[4] = %b (%d)", register_data_bus[79:64], register_data_bus[79:64]);
            $display("FU:     register[5] = %b (%d)", register_data_bus[95:80], register_data_bus[95:80]);
            $display("FU:     register[6] = %b (%d)", register_data_bus[111:96], register_data_bus[111:96]);
            $display("FU:     register[7] = %b (%d)", register_data_bus[127:112], register_data_bus[127:112]);
            $display("");
        end
        
        else
		begin
            $display("");
            $display("Program is done.");
            $display("");
		end
    end

endmodule