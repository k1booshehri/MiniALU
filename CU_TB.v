`timescale 100 ms / 10 ms

module CU_TB;
    localparam period = 10; 

    reg  clk;
    reg  [47:0]   instruction;
    wire [127:0]  register_data_bus;

    CU CU (.CLK(clk), .INSTRUCTION(instruction), .REGISTER_OUTPUT_DATA_BUS(register_data_bus));

    initial
        begin
            instruction = 48'h0000_0000_0000;
            clk = 1'b0;
            #period;
            $display("CU TB:  CLK = %b, instruction = %b register_data_bus = %h", clk, instruction, register_data_bus);

            instruction = 48'b000_010_100_0_0000_1100_0_0000_0110_0_0000_0010_0_0000_0100_000;
            clk = 1'b1;
            #period;
            $display("CU TB:  CLK = %b, instruction = %b register_data_bus = %h", clk, instruction, register_data_bus);
        end
endmodule
