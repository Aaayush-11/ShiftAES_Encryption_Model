`timescale 1ns / 1ps

module shiftAES_encryption_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [63:0] plaintext;
    reg [127:0] key;

    // Outputs
    wire [63:0] ciphertext;

    // Instantiate the Unit Under Test (UUT)
    shiftAES_encryption uut (
        .clk(clk),
        .reset(reset),
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test procedure
    initial begin
        // Initialize inputs
        reset = 1;
        plaintext = 64'h0;
        key = 128'h0;

        // Wait for global reset
        #20;
        reset = 0;

        // Test case 1
        plaintext = 64'h0123456789ABCDEF;
        key = 128'h00112233445566778899AABBCCDDEEFF;
        #200; // Wait for the encryption to complete

        // Display the result
        $display("Plaintext: %h", plaintext);
        $display("Key: %h", key);
        $display("Ciphertext: %h", ciphertext);

        // Test case 2
        plaintext = 64'hFEDCBA9876543210;
        key = 128'hFFEEDDCCBBAA99887766554433221100;
        #200;

        // Display the result
        $display("Plaintext: %h", plaintext);
        $display("Key: %h", key);
        $display("Ciphertext: %h", ciphertext);

        // End simulation
        $stop;
    end
endmodule