`timescale 100 ms / 10 ms

module ALU_TB;
    localparam period = 1; 

    reg clk;
    reg [8:0] opcodes;
    reg [31:0] oprands;
    wire [15:0] out;

    ALU ALU (.CLK(clk), .OPCODES(opcodes), .OPRANDS(oprands), .OUT(out));

    initial
        begin
            opcodes = 9'b000_000_000;
            oprands = 32'h00_00_00_00;
            clk = 1'b1;
            #period;
            $display("ALU TB: CLK = %b, opcodes = %b, oprands = %b", clk, opcodes, oprands);


            opcodes = 9'b000_010_100;
            oprands = 32'h0C_06_02_04;
            clk = 1'b0; 
            #period;
            $display("ALU TB: CLK = %b, opcodes = %b, oprands = %b, out = %b", clk, opcodes, oprands, out);
        end
endmodule
