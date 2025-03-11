# ShiftAES Encryption in Verilog

## Overview

ShiftAES is a hybrid encryption algorithm combining barrel shifting and AES-like operations for secure data encryption. It operates on 64-bit plaintext, dividing it into four 16-bit blocks, performing dynamic barrel shifts based on the count of 1s, and applying XOR transformations with a unique key per round, followed by S-Box substitution.

## Features

- **Dynamic Barrel Shifting**: Shift count is based on the number of 1s in each block.
- **Multiple XOR Operations**: Each block undergoes multiple XOR transformations with different key segments.
- **Secure Randomization**: Introduces randomness in key selection and shifts.
- **Verilog Implementation**: Designed for FPGA/ASIC hardware acceleration.

## File Structure

- `shiftAES_encryption.v` - Main encryption module.
- `shiftAES_tb.v` - Testbench for simulating the encryption process.

## How It Works

1. **Input Processing**: 64-bit plaintext is divided into four 16-bit blocks.
2. **Barrel Shifting**: Each block is shifted dynamically based on the number of 1s.
3. **Key Mixing**: Blocks undergo multiple XOR operations with different key segments.
4. **Repeated Iterations**: Steps 2 and 3 repeat multiple times for increased security.
5. **Final Transformation**: The resulting ciphertext undergoes S-Box substitution.

## Prerequisites

- Xilinx Vivado or ModelSim for simulation.
- Knowledge of Verilog and digital design.

## How to Run

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/ShiftAES-Verilog.git
   cd ShiftAES-Verilog
   ```
2. Open in Vivado or ModelSim.
3. Load `shiftAES_encryption.v` and `shiftAES_tb.v`.
4. Run the simulation to observe encryption outputs.

## Expected Output

After simulation, the ciphertext should be visible in the waveform window. Ensure correct key usage and plaintext input.

## Author

Created by Aayush. Reach out for collaboration!



