# Hierarchical FSM Adventure Game Controller (Cyclone IV FPGA)

A modular, multi-tier digital finite state machine system designed in SystemVerilog, synthesized using Intel Quartus Prime, and physically verified on an Altera Cyclone IV E FPGA development board.

---

## Architecture Overview

The system decomposes an interactive text/dungeon navigation game into decoupled hardware subsystems orchestrated by a top-level structural RTL module (`game.sv`):

* **Top-Level Orchestration (`game.sv`):** Integrates directional inputs, clock dividers, sequential primitives, and child state machines into a cohesive datapath.
* **Navigation FSM (`room.sv`):** Implements positional room-to-room transitions across the map based on directional player movement inputs (North, South, East, West).
* **Item Persistence Subsystem (`sword.sv`):** Governs inventory state latching, ensuring acquired items (such as the sword) persist across subsequent room transitions and trigger valid win conditions.
* **Custom Sequential Primitives (`d_ff.sv`):** Employs explicit edge-triggered D flip-flop register stages to synchronize asynchronous player inputs and preserve state stability.
* **Input Conditioning & Glitch Filtering:** Combinatorial logic designed to filter illegal simultaneous button presses and transient input spikes from mechanical switches.

```
                  ┌──────────────────────────────────────────────┐
                  │                 game.sv                      │
                  │                                              │
Player Inputs ───>│ [ Input Filtering / Debounce ]               │
(Pushbuttons)     │   │                                          │
                  │   ├──> [ room.sv ] (Navigation FSM) ────────>│──> Room Status LEDs
                  │   │        │                                 │
                  │   └──> [ sword.sv ] (Persistence FSM) ──────>│──> Item / Win Indicators
                  │                                              │
Clock / Reset ───>│ [ d_ff.sv ] (Sequential Synchronization)     │
                  └──────────────────────────────────────────────┘
```

---

## Synthesis & Hardware Bring-Up

* **Target Device:** Altera Cyclone IV E FPGA
* **EDA Toolchain:** Intel Quartus Prime & ModelSim
* **I/O Pin Mapping (`FPGA_Dungeon_Game.qsf`):** Constrains physical package pins to tactile pushbuttons for player inputs, onboard slide switches for system control, and active-high LEDs / 7-segment displays for room tracking and status flags.
* **Timing & Functional Simulation:** Validated via vector waveform simulation (`Waveform.vwf`) to guarantee hazard-free state propagation before flashing bitstreams via JTAG.

---

## Repository Structure

* `game.sv` — Top-level structural SystemVerilog module
* `room.sv` — Navigation finite state machine module
* `sword.sv` — Item acquisition and persistence state machine
* `d_ff.sv` — Custom D flip-flop sequential storage primitive
* `FPGA_Dungeon_Game.qpf` — Intel Quartus Prime project configuration file
* `FPGA_Dungeon_Game.qsf` — Physical pin assignments and device hardware constraints
* `Waveform.vwf` — Simulation vector waveform stimulus
