topLevelModule.vhd — Short README

Purpose
- Top-level wrapper exposing a simple CPU-facing interface and connecting the `FSM` and `cache256` modules.

Entity / Ports
- `addressBus` (in 16 bits) — full CPU address (tag/index/offset).
- `dataIn` (in 8 bits) — data from CPU (for writes / updates).
- `cpuWr` (in) — CPU write request indicator.
- `clk` (in) — clock.
- `dataOut` (out 8 bits) — data presented to CPU on reads.

Behavior
- Extracts tag bits from `addressBus` and passes them to `cache256`.
- Instantiates `FSM` to generate `update` and `cacheWr` control signals.
- Instantiates `cache256` to perform actual cache operations.

Instantiated components
- `FSM` and `cache256`.

Testbenches
- `TB_cacheSystem.vhd`, `simulationScenario.vhd` exercise `topLevelModule` behavior (miss/hit, read/write sequences).
