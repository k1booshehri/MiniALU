`timescale 100 ms / 10 ms

module ALU
(
    input  wire        CLK,
    input  wire [8:0]  OPCODES,
    input  wire [31:0] OPRANDS,
    output wire [15:0]  OUT
);
    function [7:0] power;
        input [7:0] base, exponent;
        integer i;
        begin
            power = 1;
            for (i = 0; i < exponent; i = i + 1) begin
                power = power * base;
            end
        end
    endfunction

    function [7:0] log2;
        input [7:0] number;
        begin
            if(number < 2)
            	log2 = 0;

            else if(number < 4)
            	log2 = 1;

            else if(number < 8)
            	log2 = 2;

            else if(number < 16)
            	log2 = 3;

            else if(number < 32)
            	log2 = 4;

            else if(number < 64)
            	log2 = 5;

            else if(number < 128)
            	log2 = 6;

            else if(number < 256)
            	log2 = 7;

            else if(number < 512)
            	log2 = 8;
        end
    endfunction

    function [7:0] log; // it is not synthesizable
        input [7:0] base, number;
        begin
            log = 0;
            while(base <= number) begin
                number = number / base;
                log = log + 1;
                $display("%d, %d", number, log);
            end
        end
    endfunction

    function [15:0] square_root;
        input [31:0] number; 
        reg [31:0] a;
        reg [15:0] q;
        reg [17:0] left, right, r;    
        integer i;
        begin
            a = number;
            q = 0;
            i = 0;
            left = 0;
            right = 0;
            r = 0;
            for(i = 0; i < 16; i = i + 1) begin 
                right = {q, r[17], 1'b1};
                left = {r[15:0], a[31:30]};
                a = {a[29:0], 2'b00};
                if (1 == r[17])
                    r = left + right;
                else
                    r = left - right;
                q = {q[14:0], !r[17]};       
            end
            square_root = q;
        end
    endfunction

    reg [2:0] opcode [2:0];
    reg [7:0] oprand [3:0];
    reg [15:0] out [2:0];

    assign OUT = out[1];
    

    always @(posedge CLK)
    begin
        #2;

        opcode[0] = OPCODES[8:6];
        opcode[1] = OPCODES[5:3];
        opcode[2] = OPCODES[2:0];

        oprand[0] = OPRANDS[31:24];
        oprand[1] = OPRANDS[23:16];
        oprand[2] = OPRANDS[15:8];
        oprand[3] = OPRANDS[7:0];


        case(opcode[0])
            3'b000: // Addition
                out[0] = oprand[0] + oprand[1]; 
            3'b001: // Subtraction
                out[0] = oprand[0] - oprand[1]; 
            3'b010: // Multiplication
                out[0] = oprand[0] * oprand[1]; 
            3'b011: // Division
                out[0] = oprand[0] / oprand[1]; 
            3'b100: // Power
                out[0] = power(oprand[0], oprand[1]);
            3'b101: // Logarithm
                out[0] = log2(oprand[0]);
                // out[0] = log(oprand[0], oprand[1]);
            3'b101: // Square root
                out[0] = square_root(oprand[0]);
        endcase


        case(opcode[2])
            3'b000: // Addition
                out[2] = oprand[2] + oprand[3]; 
            3'b001: // Subtraction
                out[2] = oprand[2] - oprand[3]; 
            3'b010: // Multiplication
                out[2] = oprand[2] * oprand[3]; 
            3'b011: // Division
                out[2] = oprand[2] / oprand[3]; 
            3'b100: // Power
                out[2] = power(oprand[2], oprand[3]);
            3'b101: // Logarithm
                out[2] = log2(oprand[2]);
                // out[2] = log(oprand[2], oprand[3]);
            3'b101: // Square root
                out[2] = square_root(oprand[2]);
        endcase


        case(opcode[1])
            3'b000: // Addition
                out[1] = out[0] + out[2]; 
            3'b001: // Subtraction
                out[1] = out[0] - out[2]; 
            3'b010: // Multiplication
                out[1] = out[0] * out[2]; 
            3'b011: // Division
                out[1] = out[0] / out[2]; 
            3'b100: // Power
                out[1] = power(out[0], out[2]);
            3'b101: // Logarithm
                out[1] = log2(out[0]);
                // out[1] = log(out[0], out[1]);
            3'b101: // Square root
                out[1] = square_root(out[0]);
        endcase


        $display("");
        $display("ALU:    CLK = %b", CLK);
        $display("ALU:    OPCODES = %b, OPRANDS = %h", OPCODES, OPRANDS);

        $display("ALU:    opcode[0] = %b", opcode[0]);
        $display("ALU:    opcode[1] = %b", opcode[1]);
        $display("ALU:    opcode[2] = %b", opcode[2]);

        $display("ALU:    oprand[0] = %b (%d)", oprand[0], oprand[0]);
        $display("ALU:    oprand[1] = %b (%d)", oprand[1], oprand[1]);
        $display("ALU:    oprand[2] = %b (%d)", oprand[2], oprand[2]);
        $display("ALU:    oprand[3] = %b (%d)", oprand[3], oprand[3]);
        
        $display("ALU:    out[0]    = %b (%d)", out[0], out[0]);
        $display("ALU:    out[2]    = %b (%d)", out[2], out[2]);
        $display("ALU:    out[1]    = %b (%d)", out[1], out[1]);
        $display("");
    end

endmodule