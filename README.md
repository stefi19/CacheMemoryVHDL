CacheMemoryVHDL

Overview
- This repository contains a small VHDL cache subsystem consisting of a top-level wrapper, a simple FSM, a 4-bank data cache, tag memory and supporting components plus testbenches.
- Sources are under `CacheMemory.srcs/sources_1/new`.
- Testbenches and simulation scenarios are under `CacheMemory.srcs/sim_1/new`.

Files (high-level)
- `cache256.vhd` — Cache controller + data banks + tag memory and combinational logic (comparator, decoder, mux).
- `comparator.vhd` — Tag comparator: `hit` when `tag = tagMem`.
- `decoder2x4.vhd` — 2-to-4 decoder for bank selection by offset.
- `FSM.vhd` — Small FSM that sequences SEARCH, UPDATE and RDWR states and produces `updateSignal` and `cacheWr`.
- `MUX4x1.vhd` — 4:1 multiplexer for 8-bit data.
- `RAM64x8.vhd` — 64x8 synchronous data RAM used for each bank.
- `RAM64x9.vhd` — 64x9 synchronous RAM used for tags (8-bit tag + valid bit).
- `topLevelModule.vhd` — CPU-facing wrapper that instantiates `FSM` and `cache256`.

Testbenches / simulation
- `TB_cache.vhd` — Tests the `cache256` module directly.
- `TB_cacheSystem.vhd` / `simulationScenario.vhd` — System-level tests for `topLevelModule`.
- `TB_FSM.vhd` — FSM checks.
- `TB_RAM64x8.vhd`, `TB_RAM64x9.vhd` — Memory checks.

Per-file READMEs
- `CacheMemory.srcs/sources_1/new/cache256.vhd.md` — details for `cache256.vhd` (fields, behavior, formulas).
- `CacheMemory.srcs/sources_1/new/comparator.vhd.md` — details for `comparator.vhd`.
- `CacheMemory.srcs/sources_1/new/decoder2x4.vhd.md` — details for `decoder2x4.vhd`.
- `CacheMemory.srcs/sources_1/new/FSM.vhd.md` — details for `FSM.vhd` (expanded FSM explanation).
- `CacheMemory.srcs/sources_1/new/MUX4x1.vhd.md` — details for `MUX4x1.vhd`.
- `CacheMemory.srcs/sources_1/new/RAM64x8.vhd.md` — details for `RAM64x8.vhd`.
- `CacheMemory.srcs/sources_1/new/RAM64x9.vhd.md` — details for `RAM64x9.vhd`.
- `CacheMemory.srcs/sources_1/new/topLevelModule.vhd.md` — details for `topLevelModule.vhd`.
- `CacheMemory.srcs/sim_1/new/TB_cache.vhd.md` — testbench README for `TB_cache.vhd`.
- `CacheMemory.srcs/sim_1/new/TB_cacheSystem.vhd.md` — testbench README for `TB_cacheSystem.vhd`.
- `CacheMemory.srcs/sim_1/new/TB_FSM.vhd.md` — testbench README for `TB_FSM.vhd`.
- `CacheMemory.srcs/sim_1/new/TB_RAM64x8.vhd.md` — testbench README for `TB_RAM64x8.vhd`.
- `CacheMemory.srcs/sim_1/new/TB_RAM64x9.vhd.md` — testbench README for `TB_RAM64x9.vhd`.
- `CacheMemory.srcs/sim_1/new/simulationScenario.vhd.md` — scenario README for `simulationScenario.vhd`.

Connections (component instantiation summary)
- `topLevelModule` instantiates `FSM` and `cache256`.
- `cache256` instantiates `comparator`, `decoder2x4`, four `RAM64x8` data banks, one `RAM64x9` tag memory, and `MUX4x1`.
- Testbenches instantiate the DUTs above depending on the target under test.

How to run simulations
- This project was created with Vivado. The Vivado project file `CacheMemory.xpr` is present in the repo root.
- Pre-generated simulation artifacts and scripts exist under `CacheMemory.sim/sim_1/behav/xsim/` and `CacheMemory.sim/` (note: many scripts there are Windows `.bat` files). Recommended approaches:
  - Open `CacheMemory.xpr` in Vivado on a supported OS and run behavioral simulation from the GUI. Use the testbench `TB_cache.vhd`, `TB_cacheSystem.vhd` or `simulationScenario.vhd`.
  - Alternatively, adapt the `.tcl` simulation files in `CacheMemory.sim/sim_1/behav/xsim/` for command-line use on your platform.

Contact / Notes
- Per-file READMEs are provided next to source files with extra details. If you want I can also add quick run commands for macOS or generate a shell-based test harness to run `xsim` if you have Vivado command-line tools installed.