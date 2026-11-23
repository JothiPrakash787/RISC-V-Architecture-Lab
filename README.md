# RISC-V Architecture Lab — Updated Package

This package adds a separate, self-contained **single-cycle RV32I-style teaching core** in `rtl/`. Your existing root-level files in GitHub are not replaced; keep them as they are. The new core is intentionally kept in its own folder so the original module interfaces are not silently changed.

## New RTL modules

| File | Purpose |
|---|---|
| `rtl/processor_top.sv` | Integrates the single-cycle processor |
| `rtl/instruction_memory.sv` | Demo instruction ROM |
| `rtl/control_unit.sv` | Opcode/funct control decoding |
| `rtl/imm_generator.sv` | I/S/B/U/J immediate generation |
| `rtl/register_file.sv` | 32 x 32-bit register file (x0 hardwired to zero on reads) |
| `rtl/alu.sv` | Arithmetic and logic operations |
| `rtl/data_memory.sv` | Word-addressed data memory |

`sim/processor_tb.sv` runs a small program that tests ADDI, ADD, SW, LW and a taken BEQ. It checks register and memory results.

## Instruction subset in the integrated demo core

The control/ALU supports common R-type operations (ADD, SUB, AND, OR, XOR, SLT, SLTU, shifts), immediate ALU operations, LW, SW, BEQ, JAL, JALR, LUI and AUIPC. This is an educational subset, not a fully verified implementation of every RV32I corner case or exception/interrupt behavior. Byte/halfword loads and stores, alignment exceptions, CSR instructions, privilege modes and pipeline hazards are not implemented.

## Run simulation

### Vivado 2025.1

1. Create a new RTL project (or open your existing project).
2. Add every `.sv` file under `rtl/` as **Design Sources**.
3. Add `sim/processor_tb.sv` as a **Simulation Source**.
4. Set `processor_tb` as the simulation top and run **Run Behavioral Simulation**.
5. The transcript should print a `PASS` message.

### Icarus Verilog (optional)

```bash
iverilog -g2012 -s processor_tb -o processor_test rtl/*.sv sim/processor_tb.sv
vvp processor_test
```

## Repository layout

```text
RISC-V-Architecture-Lab-Updated/
├── rtl/                 # New integrated single-cycle core
├── sim/                 # Testbench
├── legacy_original/     # Original repository source snapshots (unchanged)
└── README.md
```

## Important submission note

Keep your existing root-level source files in the GitHub repository. The new integrated design uses its own modules under `rtl/`; do not add the old root-level files and new RTL files together to the same Vivado design if module names conflict (notably `register_file`). Add only the `rtl/` sources and `sim/processor_tb.sv` for the integrated demo.

Before submitting, confirm with your TA whether the required architecture is single-cycle or five-stage pipelined. This package implements the single-cycle option; it does not claim to be a pipelined CPU.
