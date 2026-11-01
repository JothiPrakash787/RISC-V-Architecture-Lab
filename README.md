# RISC-V Architecture Lab (SystemVerilog)

This repository contains the SystemVerilog source files provided for the RISC-V architecture lab in Vivado.

## Source files

| File | Module | Purpose |
|---|---|---|
| `instruction_fetch.sv` | `instruction_fetch` | Program counter update and instruction-fetch address logic |
| `instruction_decode.sv` | `instruction_decode` | Extracts instruction fields and generates decode/control outputs for the included instruction subset |
| `register_file.sv` | `register_file` | 32-register register bank with two combinational read ports and one synchronous write port |
| `immgenerator.sv` | `immgenerator` | Generates sign-extended or shifted immediate values based on opcode and function fields |
| `main_control_unit.sv` | `main_control_unit` | Generates main control signals based on the opcode |

## Notes

- These files use SystemVerilog constructs such as `logic`, `always_comb`, and `always_ff`; use the `.sv` extension in Vivado.
- The source code has been placed into separate files without intentionally changing the supplied logic.
- Testbench files were not included in the supplied text, so this repository contains RTL source files only.
- Before submission, check that these are all the modules required by your class and add any missing RTL or testbench files if required.
