`timescale 100 ms / 10 ms

module FU_TB;
    localparam period = 10; 

    reg           clk;
    reg           reset;
    reg  [4:0]    program_lines_count;
    reg  [767:0]  program_lines;
    wire [127:0]  register_output_data_bus;

    FU FU (.CLK(clk), .RESET(reset), .PROGRAM_LINES_COUNT(program_lines), .PROGRAM_LINES(program_lines), .REGISTER_OUTPUT_DATA_BUS(register_output_data_bus));

    initial
        begin
            clk = 1'b0;
            reset = 1'b0;
            program_lines_count = 4'b0000;
            program_lines = 768'h0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_;
            #period;


            program_lines_count = 4'b0011;
            program_lines[47:0]   = 48'b000_010_000_0_00001100_0_00000110_0_00000010_0_00000100_000;
            program_lines[95:48]  = 48'b000_010_100_0_00001100_1_00000000_0_00000010_0_00000100_001;
            program_lines[143:96] = 48'b101_010_100_0_00000000_0_00000110_0_00000010_0_00000100_010;
            reset = 1'b1;
            #period;

            reset = 1'b0;
            #period;

            clk = ~clk;
            #period;

            clk = ~clk;
            #period;

            clk = ~clk;
            #period;

            clk = ~clk;
            #period;

            clk = ~clk;
            #period;

            clk = ~clk;
            #period;

            clk = ~clk;
            #period;

            clk = ~clk;
            #period;

            clk = ~clk;
            #period;
        end
endmodule

