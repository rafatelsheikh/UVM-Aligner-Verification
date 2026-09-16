# UVM Aligner Verification Environment

This repository contains a robust, full-featured Universal Verification Methodology (UVM) testbench developed to verify a hardware Aligner module. The environment is architected with an Advanced Peripheral Bus (APB) slave interface, a complete Register Abstraction Layer (RAL) model, and virtual sequencers for coordinating multi-interface stimulus generation. 

## 🏗️ Testbench Architecture

The testbench is designed using standard UVM hierarchies, isolating stimulus generation, driving, monitoring, and checking into reusable components.

<img width="966" height="853" alt="Enviro" src="https://github.com/user-attachments/assets/866cc8da-0b24-446f-a492-e07694644cde" />

As illustrated in the environment diagram, the verification structure consists of:
*   **Virtual Sequencer:** Coordinates complex sequences across the APB, RX, and TX agents.
*   **APB Agent:** Drives and monitors the APB interface to interact with the design's registers. It contains an active driver, sequencer, and monitor with its own coverage collector.
*   **MD Agents (RX & TX):** Configurable master and slave agents that handle the data stream, each equipped with its own sequencer, driver, monitor, and coverage tracking.
*   **Model & Predictor:** The Register Abstraction Layer (RAL) is integrated with a predictor to track the expected state of the DUT registers (including control, status, and IRQ registers) and feed expected data to the scoreboard.
*   **Scoreboard:** Implements automatic checking by comparing the actual outputs from the Aligner against the expected results.

## 📂 Repository Structure

The project is divided into RTL design and testbench directories:

*   `rtl/`: Contains all hardware design files, including the core aligner (`cfs_aligner_core.sv`), RX/TX controllers (`cfs_rx_ctrl.sv`, `cfs_tx_ctrl.sv`), synchronous FIFOs (`cfs_synch_fifo.sv`), edge detectors, and registers. The main design file list is compiled via `design.sv`.
*   `tb/`: Houses all verification files, testbench interfaces (`cfs_apb_if.sv`, `cfs_md_if.sv`), and the main `testbench.sv` module.
*   `tb/cfs_env_pkg.sv`: The core UVM package encompassing all agent configurations, sequences, the RAL block (`cfs_algn_reg_block.sv`), the scoreboard (`cfs_algn_scoreboard.sv`), and all test classes.

## 🧪 Included Tests

The environment supports several tests that can be passed to the simulator to verify different operational scenarios:
*   `cfs_algn_test_base` - The foundational base test class.
*   `cfs_algn_test_reg_access` - Verifies read/write access to the register map.
*   `cfs_algn_test_random` - Applies constrained-random stimulus to stress-test the data paths.
*   `cfs_algn_test_random_rx_err` - Tests the design's ability to handle injected receive errors.

## 🚀 Running the Simulation

The simulation is configured to run using standard EDA tools (like QuestaSim or ModelSim). 

**1. Verbosity & Message Configuration**
You can control the UVM logging verbosity by modifying the `messages.f` file. For instance, you can set the register predictor (`REG_PREDICT`), RX/TX FIFOs, or drop counters to `UVM_HIGH` to debug specific components.

**2. Compilation and Execution**
Use the provided commands to compile the file list and launch the simulation with coverage enabled. By default, the simulation uses a random seed and runs the random test:

```bash
vlib work
vlog -f filelist.f
vsim -voptargs=+acc -L mtiUvm work.testbench -classdebug -uvmcontrol=all +UVM_TESTNAME=cfs_algn_test_random -cover -l sim.log -sv_seed random -f messages.f
