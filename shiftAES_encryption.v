`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2025 17:52:58
// Design Name: 
// Module Name: shiftAES_encryption
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module shiftAES_encryption(
    input clk,
    input reset,
    input [63:0] plaintext,
    input [127:0] key,
    output reg [63:0] ciphertext
);
    
    reg [15:0] block[3:0]; 
    reg [15:0] temp_block[3:0];
    reg [127:0] round_key;
    reg [3:0] shift_amt [3:0]; // Shift amounts for each block
    integer i, j;

    // Function to count the number of 1s in a 16-bit input
    function integer count_ones;
        input [15:0] data;
        integer k;
        begin
            count_ones = 0;
            for (k = 0; k < 16; k = k + 1)
                count_ones = count_ones + data[k];
        end
    endfunction

    // Barrel shift function
    function [15:0] barrel_shift;
        input [15:0] data;
        input [3:0] shift;
        input direction;  // 1 for right shift, 0 for left shift
        begin
            if (direction)
                barrel_shift = (data >> shift) | (data << (16 - shift));  // Right shift
            else
                barrel_shift = (data << shift) | (data >> (16 - shift));  // Left shift
        end
    endfunction
    always @(posedge clk or posedge reset) begin
    if (reset) begin
        ciphertext <= 64'b0;
        for (i = 0; i < 4; i = i + 1) begin
            block[i] <= 16'b0;
            temp_block[i] <= 16'b0;
            shift_amt[i] <= 4'b0;
        end
        round_key <= 128'b0;
    end
    else begin
        {block[3], block[2], block[1], block[0]} <= plaintext;
        round_key <= key;

        // Debug: Print inputs
        $display("Plaintext: %h", plaintext);
        $display("Key: %h", key);

        // Step 1: Compute shift amounts
        for (i = 0; i < 4; i = i + 1) begin
            shift_amt[i] = count_ones(block[i]) + (i % 3) + 1;
            if (shift_amt[i] > 15)
                shift_amt[i] = 15; // Ensuring shift is within range
            $display("Block[%0d]: %h, Shift Amount: %0d", i, block[i], shift_amt[i]);
        end

        // Step 2: Apply transformations
        for (i = 0; i < 4; i = i + 1) begin
            temp_block[i] <= block[i];

            for (j = 0; j < shift_amt[i]; j = j + 1) begin
                if (j % 2 == 0) 
                    temp_block[i] <= barrel_shift(temp_block[i], shift_amt[i], 1);
                else 
                    temp_block[i] <= barrel_shift(temp_block[i], shift_amt[i], 0);

                case (j % 3)
                    0: temp_block[i] <= temp_block[i] ^ round_key[15:0];
                    1: temp_block[i] <= ~(temp_block[i] ^ round_key[31:16]);
                    2: temp_block[i] <= temp_block[i] & round_key[47:32];
                endcase

                $display("Temp Block[%0d][%0d]: %h", i, j, temp_block[i]);
            end

            block[i] <= temp_block[i]; // Store result back in block
        end

        ciphertext <= {block[3], block[2], block[1], block[0]};
        $display("Ciphertext: %h", ciphertext);
    end
end
endmodule



