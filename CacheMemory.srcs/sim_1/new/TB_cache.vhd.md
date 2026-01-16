TB_cache.vhd — Short README (testbench)

Purpose
- Testbench for `cache256.vhd` focusing on MISS/UPDATE and subsequent HIT behavior across a block of addresses.

What it does
- Drives `update`, `wr`, `tagIn`, `dataIn` and `addressBus` to simulate block updates and reads.
- Contains several test cases: write/update a block, read back lines (expected HIT), then another block etc.

Signals observed
- `dataOut` and `hitOut` from the `cache256` DUT.

Use
- Open in Vivado and run the behavioral simulation to see expected sequences of HITs and data outputs.
