# ARM-CPU-Verilog
Simple ARM architecture CPU coded in Verilog 

Hello to who ever reading this.
It's my first time creating a repository on Github so please bear with me and my mistakes. 

This is a resault of a course project that I had to pick during my last year of university. Although coding and computer design and architecture 
is not my field of study but I decided to put it on here so some may get some help.
The code works in Modelsim as far as I checked, but there may be some issues since I stoped working on it when I got the resaults that I wanted for 
my course so I apologize beforehand.

ARM CPU Verilog Project
Overview
This repository contains a Verilog implementation of an ARM CPU. The project aims to provide a functional simulation of an ARM processor that can be synthesized on an FPGA or used in a simulation environment.

Features

Instruction Set Architecture (ISA): Implements a subset of the ARM ISA, focusing on key instructions for basic functionality.

Pipeline Structure: Utilizes a pipelined architecture to improve instruction throughput and performance.

Modular Design: The CPU design is broken down into several modules for clarity and ease of understanding.

Instruction Fetch Unit (IFU): Responsible for fetching instructions from memory.

Instruction Decode Unit (IDU): Decodes fetched instructions and generates control signals.

Execution Unit (EXU): Executes arithmetic, logic, and data transfer operations.

Memory Unit (MEMU): Handles data memory access operations.

Write-Back Unit (WBU): Writes results back to registers.

Testing Infrastructure: Includes testbenches for each module and overall CPU functionality to ensure correctness.
Usage

To use this project:

Clone the repository to your local machine.
Simulate the design using a Verilog simulator or synthesize it for an FPGA target.
Modify or extend the design as needed for your specific requirements.
Contributions
Contributions to this project are welcome! If you have suggestions for improvements, bug fixes, or new features, please open an issue or submit a pull request.
