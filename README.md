# MIPS Single-Cycle Processor

A Modular implementation of a 32-bit single-cycle MIPS processor written in Verilog. The processor completes all five instruction stages—fetch, decode, execute, memory access, and write-back—in a single clock cycle. 

---

##  Project Overview

This project demonstrates the core architecture of a MIPS processor using hardware description language (Verilog). It supports basic MIPS instructions and provides an integrated datapath and control unit design suitable for simulation and learning purposes.

---

##  Repository Structure

```
MIPS-Single-Cycle-Processor/
│
├── modules/                # Core modules (ALU, Register File, Control Unit, etc.)
│   ├── alu.v
│   ├── register_file.v
│   ├── control_unit.v
│   ├── program_counter.v
│   └── ... (other building blocks)
│
├── instruction_memory.v    # ROM-based instruction storage
├── data_memory.v           # RAM-based data memory
├── top.v                   # Top-level processor integration
│
├── testbench/              # Testbench files for simulation
│   ├── tb_top.v
│   └── ... (other testbenches)
│
└── *.vcd / *.vvp           # Simulation outputs
```

---

##  Supported Instructions

| Type       | Instructions              | Description                            |
|------------|---------------------------|----------------------------------------|
| **R-Type** | `add`, `sub`, `slt`, `mul`| Arithmetic & comparison operations     |
| **I-Type** | `addi`, `lw`, `sw`        | Immediate arithmetic and memory access |
| **Branch** | `beq`                     | Conditional branching                  |
| **Jump**   | `j`, `jal`                | Unconditional jumps and linking        |

---

##  Components Description

- **ALU (`alu.v`)**: Performs arithmetic and logic operations.
- **Register File (`register_file.v`)**: 32 registers with 2 read and 1 write port. Register `$zero` is hardwired to 0.
- **Control Unit (`control_unit.v`)**: Generates control signals based on opcode and funct fields.
- **Program Counter (`program_counter.v`)**: Holds the address of the current instruction.
- **Instruction Memory (`instruction_memory.v`)**: Contains hardcoded instruction set in hex.
- **Data Memory (`data_memory.v`)**: Allows `lw` and `sw` for word-level memory operations.

---

##  Simulation Instructions

###  Run Simulation

1. **Navigate to root directory**:
   ```bash
   cd MIPS-Single-Cycle-Processor
   ```

2. **Compile the design and testbench**:
   ```bash
   iverilog -o mips.vvp top.v modules/*.v testbench/tb_top.v
   ```

3. **Run the simulation**:
   ```bash
   vvp mips.vvp
   ```

---

##  Example Use Case

You can preload the instruction memory with a small program performing the following:

```assembly
addi $t0, $zero, 5
addi $t1, $zero, 10
add  $t2, $t0, $t1
sw   $t2, 0($zero)
```

This will add two numbers and store the result in memory at address 0.

---

##  Learning Outcomes

- Understand datapath-level integration of a processor.
- Learn Verilog for hardware design and simulation.
- Practice instruction encoding and decoding.
- Explore memory interfacing and control signal design.

---

