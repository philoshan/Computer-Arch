# Computer Architecture Course

This repository contains assignments for the Computer Architecture course at Hanyang University ERICA, created by Jiseung Han

> **Hanyang University ERICA Campus | Department of Robotics**  
> **Computer Architecture Course**  
> **Instructor: Prof. Bumjin Jang**

A 13-week project-based learning course: Build a 5-stage pipelined MIPS CPU and use it to control a virtual motor via PWM.

## 📋 Course Syllabus

| Week | Topic | Key Concepts |
|------|-------|--------------|
| 01 | Introduction to Verilog Syntax | Module structure, data types, operators |
| 02 | Register File | Dual-read, single-write, $zero handling |
| 03 | Memory & PC | Instruction/Data Memory, PC+4 |
| 04 | Single-Cycle Datapath | IF/ID/EX/MEM/WB Integration |
| 05 | Control Unit | Main Decoder, ALU Decoder |
| 06 | Pipeline Integration | Pipeline registers, signal propagation |
| 07 | Early Branch Resolution | 1-cycle branch penalty |
| 08 | Data Forwarding | Forwarding Unit |
| 09 | Stall & Flush | Hazard Detection Unit |
| 10 | Jump Instructions | j, jal, jr support |
| 11 | Memory-Mapped I/O | Switches, LEDs |
| 12 | PWM Motor Control | Accel/Decel Algorithm |
| 13 | Final PBL Demo | Waveform Presentation |

## 🏗️ Architecture Progression

```
Week 01: Verilog Syntax Basics
     ↓
Week 02-05: Single-Cycle MIPS CPU
     ↓
Week 06-09: 5-Stage Pipelined CPU
     ↓
Week 10-11: Jump + MMIO
     ↓
Week 12-13: Motor Control Application
```

## 🚀 Getting Started

### Prerequisites
- [Icarus Verilog](https://bleyer.org/icarus/)
- [GTKWave](http://gtkwave.sourceforge.net/) (for waveforms)

### Quick Start
```bash
cd class_01
make        # Compile and run
make wave   # View waveform
```

## 📁 Structure

```
verilog/
├── class_01/    # Verilog Syntax Introduction
├── class_02/    # Register File
├── class_03/    # Memory + PC
├── class_04/    # Single-cycle Datapath
├── class_05/    # Control Unit
├── class_06/    # Pipeline Integration (Baseline)
├── class_07/    # Early Branch Resolution
├── class_08/    # Forwarding
├── class_09/    # Hazard Unit
├── class_10/    # Jump Instructions
├── class_11/    # Memory-Mapped I/O
├── class_12/    # PWM Motor Control
└── class_13/    # Final Demo
```

## 📝 License

Educational use only.
