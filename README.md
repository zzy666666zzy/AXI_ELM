# AXI_ELM: Real ELM for Hardware Implementation

This repository provides a full pipeline for training and hardware deployment of an **Extreme Learning Machine (ELM)** optimized for FPGA implementation.

## Overview

- **REAL_ELM_REFERENCE.m**  
  Trains a real ELM model with **small variance** in weights and biases, suitable for hardware usage.  
  - Outputs `.coe` files for RAM (BRAM) initialization.
  - Applies regularization to ensure stable, fixed-point compatible weights.

- **code_gen_l1.py** and **code_gen_l2.py**  
  Automatically generate **Verilog HDL code** for the hidden (Layer 1) and output (Layer 2) modules based on the trained parameters.

- **IP_auto_gen.tcl**  
  A TCL script for Vivado to generate **hardcoded BRAM IPs** using the generated `.coe` files for memory initialization.

## Usage Instructions

1. **Train the ELM model**  
   - Run `REAL_ELM_REFERENCE.m` in MATLAB.
   - This script will:
     - Train the ELM with regularization.
     - Export weights and biases into `.coe` files.
     - Save trained parameters for further use.

2. **Generate Verilog HDL code**  
   - Execute `code_gen_l1.py` and `code_gen_l2.py` with Python.
   - These scripts will generate synthesizable Verilog modules for ELM deployment.

3. **Create BRAM IPs in Vivado**  
   - Run `IP_auto_gen.tcl` inside Vivado Tcl console.
   - This automates BRAM block creation initialized with the trained model weights.

## License

This project is provided under the **[Insert Your License Name Here]** license.

> ⚠️ **Disclaimer:**  
> If you use, modify, or redistribute any part of this project, you must retain proper attribution.  
> Users must be aware that hardware deployment results (e.g., FPGA resource utilization, timing closure) depend on the synthesis toolchain and target device.  
> Any commercial use without permission is prohibited.

---

## Acknowledgements

This project was created to streamline the development and deployment of lightweight ELM neural networks on FPGA platforms.

---
